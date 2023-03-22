/*************************************************
Title: 1.Descriptive
Authors: Thea Bourdeau, 
Date: 3.22.2023
*************************************************/

/*setup*/
OPTIONS FORMCHAR="|----|+|---+=|-/\<>*";
ods graphics on  / attrpriority = none;
ods trace on;

/*filepaths*/
libname ;

/*import data*/
data cabg;
set ;
run;