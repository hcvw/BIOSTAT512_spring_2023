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
%let user = abourdea;
%put &user;

libname dropbox "C:\Users\&user\Dropbox (University of Michigan)\BIOSTAT512_Final_Project\data";

/*import data*/
data cabg;
set dropbox.cabg;
run;

/*look at data*/
proc contents data = cabg;
run;

/*macro for descriptive analytics*/
ods excel file = "C:\Users\abourdea\Dropbox (University of Michigan)\BIOSTAT512_Final_Project\output\descriptive\descriptive_anlaytics_23MAR2023.xlsx"
	options(sheet_interval = "NOW");

%macro descriptive(var);
proc univariate data = cabg;
var &var;
run;
%mend;

%descriptive(age);
%descriptive(cm_obese);
/*%descriptive(dshospid); - leaving this variable out as it is a character. Should we do a proc freq??*/
%descriptive(female);
%descriptive(hospN);
%descriptive(hosp_cntrl);
%descriptive(hosp_teach);
%descriptive(id);
%descriptive(los);
%descriptive(pay1);
%descriptive(race);
%descriptive(wcharlsum);

ods excel close;