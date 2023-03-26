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

/*formats*/
proc format;
value hosp_cntrl	1="government, nonfederal" 
					2="nongovernment, nonprofit"
					3="investor owned, for profit";
value hosp_teach	1="teaching"
					2="nonteaching";
value female		0="male"
					1="female";
value cm_obese		0="not present"
					1="present";
value pay			1="medicare"
					2="medicaid"
					3="private inc. HMO"
					4="self pay"
					5="no charge"
					6="other";
value race			1="white"
					2="black"
					3="hispanic"
					4="asian or pacific islander"
					5="native american"
					6="other";
run;

/*import data*/
data cabg;
set dropbox.cabg;
/*add formats*/
format 	hosp_cntrl hosp_cntrl.
		hosp_teach hosp_teach.
		female female.
		cm_obese cm_obese.
		pay1 pay.
		race race.;
/*make dhospid numeric*/
new = input(dshospid, 8.);
   drop dshospid;
   rename new=dshospid;
run;

/*look at data*/
proc contents data = cabg;
run;

/*macros for descriptive analytics*/
ods html file = "C:\Users\abourdea\Dropbox (University of Michigan)\BIOSTAT512_Final_Project\output\descriptive\descriptive_anlaytics_26MAR2023.html";

/*categorical*/
%macro cat(var);
proc freq data = cabg;
tables &var;
run;
%mend;

/*numeric*/
%macro num(var);
proc means data = cabg;
var &var;
run;
%mend;

/*hosp level*/
%cat(hosp_cntrl);
%cat(hosp_teach);
%num(hospN);
%num(dshospid);

/*patient level*/
%num(id);
%num(age);
%cat(female);
%num(los);
%num(wcharlsum);
%cat(cm_obese);
%cat(pay1);
%cat(race);

ods excel close;

/*output processed dataset to DropBox*/
data dropbox.cabg_fmt;
set cabg;
run;