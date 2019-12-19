library(corrplot)
library(PerformanceAnalytics)
library(ggplot2)
library(FactoMineR)
library(factoextra)
library(dplyr)
library(lattice)
library(cluster)
library(visreg)
library(car)
library(tidyr)
library(caret)
library(forcats) # fct_recode function
library(repr)    # for figure size
library(randomForest)

is.Date <- function(x) inherits(x, 'Date')

# library(summarytools)

date_conversion <- function(dataframe){
    dataframe$YearBuilt <- as.Date(
        ISOdate(dataframe[, 'YearBuilt'], 01, 01), format = "%Y")
    dataframe$YearRemodAdd <- as.Date(
        ISOdate(dataframe[, 'YearRemodAdd'], 01, 01), format = "%Y")
    dataframe$GarageYrBlt <- as.Date(
        ISOdate(dataframe[, 'GarageYrBlt'], 01, 01), format = "%Y")
    dataframe$YrSold <- as.Date(
        ISOdate(dataframe[, 'YrSold'], dataframe[, 'MoSold'], 01), format = "%Y")

    dataframe = select(dataframe, -MoSold)
    return(dataframe)
}

noqual_conversion <- function(dataframe){
    dataframe$MSSubClass <- factor(dataframe$MSSubClass)
    return(dataframe)
}

quantitative_conversion <- function(dataframe){
    dataframe$LotShape <- fct_recode(dataframe$LotShape,
        '1' = 'IR3', '2' = 'IR2', '3' = 'IR1', '4' = 'Reg')
    dataframe$LotShape <- as.numeric(as.character(dataframe$LotShape))
    
    dataframe$LandContour <- dataframe$LandContour %>%
        fct_recode('1' = 'Low', '2' = 'HLS', '3' = 'Bnk', '4' = 'Lvl')
    dataframe$LandContour <- as.numeric(as.character(dataframe$LandContour))
    
    dataframe$Utilities <- dataframe$Utilities %>%
        fct_recode('1' = 'ELO', '2' = 'NoSeWa', '3' = 'NoSewr', '4' = 'AllPub')
    dataframe$Utilities <- as.numeric(as.character(dataframe$Utilities))
    
    dataframe$LandSlope <- dataframe$LandSlope %>%
        fct_recode('1' = 'Sev', '2' = 'Mod', '3' = 'Gtl')
    dataframe$LandSlope <- as.numeric(as.character(dataframe$LandSlope))
    
    dataframe$ExterQual <- dataframe$ExterQual %>%
        fct_recode('1' = 'Po', '2' = 'Fa', '3' = 'TA', '4' = 'Gd', '5' = 'Ex')
    dataframe$ExterQual <- as.numeric(as.character(dataframe$ExterQual))
    
    dataframe$ExterCond <- dataframe$ExterCond %>%
        fct_recode('1' = 'Po', '2' = 'Fa', '3' = 'TA', '4' = 'Gd', '5' = 'Ex')
    dataframe$ExterCond <- as.numeric(as.character(dataframe$ExterCond))

    dataframe$BsmtQual <- dataframe$BsmtQual %>%
        fct_recode('1' = 'Po', '2' = 'Fa', '3' = 'TA', '4' = 'Gd', '5' = 'Ex')
    dataframe$BsmtQual <- as.numeric(as.character(dataframe$BsmtQual))

    dataframe$BsmtCond  <- dataframe$BsmtCond  %>%
        fct_recode('1' = 'Po', '2' = 'Fa', '3' = 'TA', '4' = 'Gd', '5' = 'Ex')
    dataframe$BsmtCond  <- as.numeric(as.character(dataframe$BsmtCond))

    dataframe$BsmtExposure  <- dataframe$BsmtExposure  %>%
        fct_recode('1' = 'No', '2' = 'Mn', '3' = 'Av', '4' = 'Gd')
    dataframe$BsmtExposure  <- as.numeric(as.character(dataframe$BsmtExposure))

    dataframe$BsmtFinType1  <- dataframe$BsmtFinType1  %>%
        fct_recode('1' = 'Unf', '2' = 'LwQ', '3' = 'Rec',
                   '4' = 'BLQ', '5' = 'ALQ', '6' = 'GLQ')
    dataframe$BsmtFinType1  <- as.numeric(as.character(dataframe$BsmtFinType1))

    dataframe$BsmtFinType2  <- dataframe$BsmtFinType2  %>%
        fct_recode('1' = 'Unf', '2' = 'LwQ', '3' = 'Rec',
                   '4' = 'BLQ', '5' = 'ALQ', '6' = 'GLQ')
    dataframe$BsmtFinType2  <- as.numeric(as.character(dataframe$BsmtFinType2))

    dataframe$HeatingQC  <- dataframe$HeatingQC  %>%
        fct_recode('1' = 'Po', '2' = 'Fa', '3' = 'TA', '4' = 'Gd', '5' = 'Ex')
    dataframe$HeatingQC  <- as.numeric(as.character(dataframe$HeatingQC))

    dataframe$CentralAir  <- dataframe$CentralAir  %>%
        fct_recode('0' = 'N', '1' = 'Y')
    dataframe$CentralAir  <- as.numeric(as.character(dataframe$CentralAir))

    dataframe$Electrical  <- dataframe$Electrical  %>%
        fct_recode('1' = 'Mix', '2' = 'FuseP', '3' = 'FuseF', '4' = 'FuseA', '5' = 'SBrkr')
    dataframe$Electrical  <- as.numeric(as.character(dataframe$Electrical))

    dataframe$KitchenQual  <- dataframe$KitchenQual  %>%
        fct_recode('1' = 'Po', '2' = 'Fa', '3' = 'TA', '4' = 'Gd', '5' = 'Ex')
    dataframe$KitchenQual  <- as.numeric(as.character(dataframe$KitchenQual))

    dataframe$Functional <- dataframe$Functional  %>%
        fct_recode('1' = 'Sal', '2' = 'Sev', '3' = 'Maj2', '4' = 'Maj1',
                   '5' = 'Mod', '6' = 'Min2', '7' = 'Min1', '8' = 'Typ')
    dataframe$Functional <- as.numeric(as.character(dataframe$Functional))

    #dataframe$FireplaceQu  <- dataframe$FireplaceQu  %>%
    #    fct_recode('1' = 'Po', '2' = 'Fa', '3' = 'TA', '4' = 'Gd', '5' = 'Ex')
    #dataframe$FireplaceQu  <- as.numeric(as.character(dataframe$FireplaceQu))

    #dataframe$GarageFinish  <- dataframe$GarageFinish  %>%
    #    fct_recode('1' = 'Unf', '2' = 'RFn', '3' = 'Fin')
    #dataframe$GarageFinish  <- as.numeric(as.character(dataframe$GarageFinish))

    dataframe$GarageQual  <- dataframe$GarageQual  %>%
        fct_recode('1' = 'Po', '2' = 'Fa', '3' = 'TA', '4' = 'Gd', '5' = 'Ex')
    dataframe$GarageQual  <- as.numeric(as.character(dataframe$GarageQual))

    dataframe$GarageCond  <- dataframe$GarageCond  %>%
        fct_recode('1' = 'Po', '2' = 'Fa', '3' = 'TA', '4' = 'Gd', '5' = 'Ex')
    dataframe$GarageCond  <- as.numeric(as.character(dataframe$GarageCond))

    dataframe$PavedDrive  <- dataframe$PavedDrive  %>%
        fct_recode('1' = 'N', '2' = 'P', '3' = 'Y')
    dataframe$PavedDrive  <- as.numeric(as.character(dataframe$PavedDrive))

    #dataframe$PoolQC  <- dataframe$PoolQC  %>%
    #    fct_recode('1' = 'Po', '2' = 'Fa', '3' = 'TA', '4' = 'Gd', '5' = 'Ex')
    #dataframe$PoolQC  <- as.numeric(as.character(dataframe$PoolQC))

    #dataframe$Fence  <- dataframe$Fence  %>%
    #    fct_recode('1' = 'MnWw', '2' = 'GdWo', '3' = 'MnPrv', '4' = 'GdPrv')
    #dataframe$Fence  <- as.numeric(as.character(dataframe$Fence))
    
    return(dataframe)
}

near_zero <- function(dataframe){
    nzv <- nearZeroVar(dataframe, saveMetrics = TRUE)
    nzv[which(nzv$nzv == TRUE | nzv$zeroVar == TRUE),]
    return(dataframe)
}

many_zeros_delete <- function(dataframe){
    dataframe <- select(dataframe,
                    - BsmtFinSF2,
                    - LowQualFinSF,
                    - EnclosedPorch,
                    - X3SsnPorch,
                    - ScreenPorch,
                    - PoolArea,
                    - MiscVal,
                    - LandContour,
                    - LandSlope,
                    - BsmtCond,
                    - BsmtFinType2,
                    - KitchenAbvGr,
                    - Functional,
                    - GarageQual,
                    - GarageCond
                   )
    return(dataframe)
}

remain_process <- function(dataframe){
    dataframe <- select(dataframe, -Street, -Utilities, -Condition2)
    
    dataframe$Heating  <- dataframe$Heating  %>%
    fct_recode('0' = 'GasA',
               '1' = 'Floor', '1' = 'GasW', '1' = 'Grav',
               '1' = 'OthW', '1' = 'Wall')
    dataframe$Heating  <- as.numeric(as.character(dataframe$Heating))
    
    dataframe$RoofMatl  <- dataframe$RoofMatl  %>%
    fct_recode('0' = 'CompShg',
               '1' = 'ClyTile', '1' = 'Membran', '1' = 'Metal',
               '1' = 'Roll', '1' = 'Tar&Grv', '1' = 'WdShake', '1' = 'WdShngl')
    dataframe$RoofMatl  <- as.numeric(as.character(dataframe$RoofMatl))
    
    levels(dataframe$MiscFeature) <- c(levels(dataframe$MiscFeature), 'None')
    dataframe$MiscFeature[which(is.na(dataframe$MiscFeature))] <- 'None'
    dataframe$MiscFeature <- dataframe$MiscFeature  %>%
    fct_recode('0' = 'None',
               '1' = 'Elev', '1' = 'Gar2', '1' = 'Othr',
               '1' = 'Shed', '1' = 'TenC')
    dataframe$MiscFeature <- as.numeric(as.character(dataframe$MiscFeature))
    
    return(dataframe)
}

missing_data_to_none <- function(dataframe){
    levels(dataframe$Alley) <- c(levels(dataframe$Alley), 'None')
    dataframe$Alley[which(is.na(dataframe$Alley))] <- 'None'

    levels(dataframe$FireplaceQu) <- c(levels(dataframe$FireplaceQu), 'None')
    dataframe$FireplaceQu[which(is.na(dataframe$FireplaceQu))] <- 'None'

    levels(dataframe$GarageType) <- c(levels(dataframe$GarageType), 'None')
    dataframe$GarageType[which(is.na(dataframe$GarageType))] <- 'None'

    levels(dataframe$GarageFinish) <- c(levels(dataframe$GarageFinish), 'None')
    dataframe$GarageFinish[which(is.na(dataframe$GarageFinish))] <- 'None'

    levels(dataframe$PoolQC) <- c(levels(dataframe$PoolQC), 'None')
    dataframe$PoolQC[which(is.na(dataframe$PoolQC))] <- 'None'

    levels(dataframe$Fence) <- c(levels(dataframe$Fence), 'None')
    dataframe$Fence[which(is.na(dataframe$Fence))] <- 'None'

    #dataframe <- dataframe[which(!is.na(dataframe$LotFrontage)),]
    #dataframe <- dataframe[which(!is.na(dataframe$MasVnrType)),]
    #dataframe <- dataframe[which(!is.na(dataframe$MasVnrArea)),]
    #dataframe <- dataframe[which(!is.na(dataframe$BsmtQual)),]
    #dataframe <- dataframe[which(!is.na(dataframe$BsmtExposure)),]
    #dataframe <- dataframe[which(!is.na(dataframe$BsmtFinType1)),]
    #dataframe <- dataframe[which(!is.na(dataframe$Electrical)),]

    NA_lines = which(is.na(dataframe$GarageYrBlt))
    dataframe$GarageYrBlt[NA_lines] <- dataframe$YearBuilt[NA_lines]
    
    dataframe$MasVnrType[which(is.na(dataframe$MasVnrType))] <- 'None'
    
    return(dataframe)
}

missing_data_remain <- function(dataframe){
    for (i in 1:ncol(dataframe)){
        na_number <- length(which(is.na(dataframe[, i])))
        if (na_number > 0){
            if (is.null(levels(dataframe[,i]))){
                dataframe[which(is.na(dataframe[, i])), i] <- 0
            }
        }
    }
    return(dataframe)
}

modality_completion <- function(dataframe){
    levels(dataframe$Exterior1st) <- c(levels(dataframe$Exterior1st), 'AsbShng', 'AsphShn', 'BrkComm', 'BrkFace', 'CBlock', 'CemntBd', 'HdBoard', 'ImStucc', 'MetalSd', 'Other', 'Plywood', 'PreCast', 'Stone', 'Stucco', 'VinylSd', 'Wd Sdng', 'WdShing')
    levels(dataframe$Exterior2nd) <- c(levels(dataframe$Exterior2nd), 'AsbShng', 'AsphShn', 'BrkComm', 'BrkFace', 'CBlock', 'CemntBd', 'HdBoard', 'ImStucc', 'MetalSd', 'Other', 'Plywood', 'PreCast', 'Stone', 'Stucco', 'VinylSd', 'Wd Sdng', 'WdShing')
    levels(dataframe$Foundation) <- c(levels(dataframe$Foundation), 'BrkTil', 'CBlock', 'PConc', 'Slab', 'Stone', 'Wood')
    levels(dataframe$GarageType) <- c(levels(dataframe$GarageType), '2Types', 'Attchd', 'Basment', 'BuiltIn', 'CarPort', 'Detchd')
    levels(dataframe$LotConfig) <- c(levels(dataframe$LotConfig), 'Inside', 'Corner', 'CulDSac', 'FR2', 'FR3')
    levels(dataframe$MasVnrType) <- c(levels(dataframe$MasVnrType), 'BrkCmn', 'BrkFace', 'CBlock', 'None', 'Stone')
    levels(dataframe$MSZoning) <- c(levels(dataframe$MSZoning), 'A', 'C', 'FV', 'I', 'RH', 'RL', 'RP', 'RM')
    levels(dataframe$PoolQC) <- c(levels(dataframe$PoolQC), 'Po', 'Fa', 'TA', 'Gd', 'Ex')
    levels(dataframe$RoofStyle) <- c(levels(dataframe$RoofStyle), 'Flat', 'Gable', 'Gambrel', 'Hip', 'Mansard', 'Shed')
    levels(dataframe$SaleCondition) <- c(levels(dataframe$SaleCondition), 'Normal', 'Abnorml', 'AdjLand', 'Alloca', 'Family', 'Partial')
    levels(dataframe$SaleType) <- c(levels(dataframe$SaleType), 'WD ', 'CWD', 'VWD', 'New', 'COD', 'Con', 'ConLw', 'ConLI', 'ConLD', 'Oth')

    return(dataframe)
}






