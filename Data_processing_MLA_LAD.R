
setwd("C:/Users/vijay.bhaskar/Desktop/MLA LADS/")

urls <- c(
  'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-150-YELAHANKA-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-151-KR-PURAM-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-152-BYATARAYANAPURA-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-153-YESHWANTHAPURA-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-154-RAJARAJESHWARI-NAGAR-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-155-DASARAHALLI-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-156-MAHALAKSHMI-LAYOUT-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-157-MALLESHWARAM-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-158-HEBBAL-2015-2018.csv'
  # ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-159-PULAKESHI-NAGAR-2013-2018'
  #,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-160-SARVAGNA-NAGAR-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-161-CV-RAMAN-NAGAR-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-162-SHIVAJI-NAGAR-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-163-SHANTI--NAGAR-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-164-GANDHI-NAGAR-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-165-RAJAJI-NAGAR-2013-2018.csv'
  #,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-166-GOVINDRAJ-NAGAR-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-167-VIJAYANAGAR-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-168-CHAMRAJPET-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-169-CHICKPET-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-170-BASAVANAGUDI-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-171-PADMANABHA-NAGAR-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-172-BTM-LAYOUT-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-173-JAYANAGAR-2013-2018.csv'
  # ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-174-MAHADEVAPURA-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-175-BOMMANAHALLI-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-176-BANGALORE-SOUTH-2013-2018.csv'
  ,'http://data.opencity.in/Data/Karnataka-MLA-LAD-Funds-AC-177-ANEKAL-2013-2018.csv'
)
  

library(tidyverse)
library(gtools)
#combined_df <- map_dfr(urls, read_csv)    Don't use this


#This step will read from the URLs listed above and make the URLs 
# as the rownames in the data frame so that we can have the source file label in final table for each row/project name

result <- do.call(smartbind, sapply(urls, read.csv, simplify = FALSE,stringsAsFactors = FALSE))


#Renaming Long column names to shorter names


colnames(result)[5]<- c("Project_description_1")
colnames(result)[8]<- c("Project_description_2")

colnames(result)[6] <- c("Value_1")
colnames(result)[9] <- c("Value_2")


# Creating one proper column name for Project description and Value 
# as the original csv files have 2 slightly different column names for them

result$Project[!is.na(result$Project_description_1)] = result$Project_description_1[!is.na(result$Project_description_1)]  # merge with y
result$Project[!is.na(result$Project_description_2)] = result$Project_description_2[!is.na(result$Project_description_2)]  # merge with z

result$Value_in_Lakhs[!is.na(result$Value_1)] = result$Value_1[!is.na(result$Value_1)]  
result$Value_in_Lakhs[!is.na(result$Value_2)] = result$Value_2[!is.na(result$Value_2)] 


colnames(result)

Final_result <- result[,c(2,10,11)]


write.csv(Final_result,"Combined_data.csv")


