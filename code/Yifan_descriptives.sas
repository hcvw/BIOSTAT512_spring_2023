libname b512 "/home/u58566978/b512/project";

data cabg; set b512.cabg; run;

proc contents data=cabg; run;

/*formats for vars*/
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

data cabg; set cabg;
format 	hosp_cntrl hosp_cntrl.
		hosp_teach hosp_teach.
		female female.
		cm_obese cm_obese.
		pay1 pay.
		race race.;
run;

/*changing dshospid to numeric var*/
data cabg; set cabg;
   new = input(dshospid, 8.);
   drop dshospid;
   rename new=dshospid;
run;

data b512.cabg2; set cabg; run;

/*macro for categorical vars*/
%macro cat(var);
proc freq data=b512.cabg2;
tables &var;
run;
%mend;

/*macro for numeric vars*/
%macro num(var);
proc means data=b512.cabg2;
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