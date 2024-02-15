clear
import excel "C:\Users\charl\Dropbox\Solve Platform Bulk Download\Solutions\2023_full.xlsx", sheet("Sheet1") firstrow
gen sf= SolutionStatus!="Published"

encode ChallengeName , gen(challenge_id)

encode Whichofthefollowingcategorie , gen(typetech)
gen course_mit= ( DidyoutaketheMITxcourseBu!="No, I didn’t take the course")
gen previous_netw= ( Isyoursolutionanactiveorpa !="No, Solve is the first network joined")
gen us_founder= ( IstheTeamLeadaresidentoft =="Yes")
replace male_founder= ( WhatistheTeamLeadsgender =="Man")
reg sf typetech course_mit previous_netw male_founder us_founder
reg sf i.typetech course_mit previous_netw male_founder us_founder
gen finalist= SolutionStatus=="Finalist"
reg finalist i.typetech course_mit previous_netw male_founder us_founder

gen us_team_lead_loc= ( TeamLeadlocation =="United States")
gen other_dim_target= ( WhichdimensionoftheChallenge =="Other")
gen us_team_hq= ( Inwhatcountryisyoursolution=="United States")

gen stage_dev= 0
replace stage_dev= 1 if strpos(Whatisyoursolutionsstageof, "Prototype")>0
replace stage_dev= 2 if strpos(Whatisyoursolutionsstageof, "Pilot")>0
replace stage_dev= 3 if strpos(Whatisyoursolutionsstageof, "Growth")>0
replace stage_dev= 4 if strpos(Whatisyoursolutionsstageof, "Scale")>0


gen help_business= 0
replace help_business= 1 if strpos(Inwhichofthefollowingareas, "Business ")>0
gen help_finance= 0 
replace help_finance= 1 if strpos(Inwhichofthefollowingareas, "Financial (")>0
gen help_hc= 0
replace help_hc= 1  if strpos(Inwhichofthefollowingareas, "Human Capital (")>0
gen help_legal= 0
replace help_legal= 1  if strpos(Inwhichofthefollowingareas, "Legal or")>0
gen help_monitoring= 0
replace help_monitoring= 1 if strpos(Inwhichofthefollowingareas, "Monitoring &")>0
gen help_product= 0
replace help_product= 1 if strpos(Inwhichofthefollowingareas, "Product /")>0
gen help_pubrel= 0
replace help_pubrel= 1 if strpos(Inwhichofthefollowingareas, "Public Relations (")>0
gen help_tech= 0
replace help_tech= 1 if strpos(Inwhichofthefollowingareas, "Technology (")>0


gen white_founder= (WhatistheTeamLeadsraceor=="White")*1
gen solv_f_selected= ( Haveyouorsomeoneelsefromyo =="Yes")*1
encode HowdidyoufirsthearaboutSol , gen(heard_solve)


gen sdg1= 0
replace sdg1= 1 if strpos(WhichoftheUNSustainableDeve, "1.")>0
gen sdg2= 0 
replace sdg2= 1 if strpos(WhichoftheUNSustainableDeve, "2.")>0
gen sdg3= 0
replace sdg3= 1  if strpos(WhichoftheUNSustainableDeve, "3.")>0
gen sdg4= 0
replace sdg4= 1  if strpos(WhichoftheUNSustainableDeve, "4.")>0
gen sdg5= 0
replace sdg5= 1 if strpos(WhichoftheUNSustainableDeve, "5.")>0
gen sdg6= 0
replace sdg6= 1 if strpos(WhichoftheUNSustainableDeve, "6.")>0
gen sdg7= 0
replace sdg7= 1 if strpos(WhichoftheUNSustainableDeve, "7.")>0
gen sdg8= 0
replace sdg8= 1 if strpos(WhichoftheUNSustainableDeve, "8.")>0
gen sdg9= 0
replace sdg9= 1 if strpos(WhichoftheUNSustainableDeve, "9.")>0
gen sdg10= 0
replace sdg10= 1 if strpos(WhichoftheUNSustainableDeve, "10.")>0
gen sdg11= 0
replace sdg11= 1 if strpos(WhichoftheUNSustainableDeve, "11.")>0
gen sdg12= 0
replace sdg12= 1 if strpos(WhichoftheUNSustainableDeve, "12.")>0
gen sdg13= 0
replace sdg13= 1 if strpos(WhichoftheUNSustainableDeve, "13.")>0
gen sdg14= 0
replace sdg14= 1 if strpos(WhichoftheUNSustainableDeve, "14.")>0
gen sdg15= 0
replace sdg15= 1 if strpos(WhichoftheUNSustainableDeve, "15.")>0
gen sdg16= 0
replace sdg16= 1 if strpos(WhichoftheUNSustainableDeve, "16.")>0
gen sdg17= 0
replace sdg17= 1 if strpos(WhichoftheUNSustainableDeve, "17.")>0

gen sdg_count= sdg1+sdg2+sdg3+sdg4+sdg5+sdg6+sdg7+sdg8+sdg9+sdg10+sdg11+sdg12+sdg13+sdg14+sdg15+sdg16+sdg17 


gen stage_tech= 0
replace stage_tech= 1 if strpos(Whichofthefollowingcategorie, "A new application")>0
replace stage_tech= 2 if strpos(Whichofthefollowingcategorie, "A new technology")>0



* Initialize tech variables to 0
gen tech_ancestral = 0
gen tech_ai_ml = 0
gen tech_audiovisual = 0
gen tech_behavioral = 0
gen tech_bigdata = 0
gen tech_biomimicry = 0
gen tech_bioengineering = 0
gen tech_blockchain = 0
gen tech_crowdsourced = 0
gen tech_gis = 0
gen tech_imaging = 0
gen tech_iot = 0
gen tech_manufacturing = 0
gen tech_materials = 0
gen tech_robotics = 0
gen tech_software = 0
gen tech_virtualreality = 0

* Replace tech variables with 1 if the category is found 
replace tech_ancestral = 1 if strpos(Pleaseselectthetechnologiesc, "Ancestral Technology & Practices") > 0
replace tech_ai_ml = 1 if strpos(Pleaseselectthetechnologiesc, "Artificial Intelligence / Machine Learning") > 0
replace tech_audiovisual = 1 if strpos(Pleaseselectthetechnologiesc, "Audiovisual Media") > 0
replace tech_behavioral = 1 if strpos(Pleaseselectthetechnologiesc, "Behavioral Technology") > 0
replace tech_bigdata = 1 if strpos(Pleaseselectthetechnologiesc, "Big Data") > 0
replace tech_biomimicry = 1 if strpos(Pleaseselectthetechnologiesc, "Biomimicry") > 0
replace tech_bioengineering = 1 if strpos(Pleaseselectthetechnologiesc, "Biotechnology / Bioengineering") > 0
replace tech_blockchain = 1 if strpos(Pleaseselectthetechnologiesc, "Blockchain") > 0
replace tech_crowdsourced = 1 if strpos(Pleaseselectthetechnologiesc, "Crowd Sourced Service / Social Networks") > 0
replace tech_gis = 1 if strpos(Pleaseselectthetechnologiesc, "GIS and Geospatial Technology") > 0
replace tech_imaging = 1 if strpos(Pleaseselectthetechnologiesc, "Imaging and Sensor Technology") > 0
replace tech_iot = 1 if strpos(Pleaseselectthetechnologiesc, "Internet of Things") > 0
replace tech_manufacturing = 1 if strpos(Pleaseselectthetechnologiesc, "Manufacturing Technology") > 0
replace tech_materials = 1 if strpos(Pleaseselectthetechnologiesc, "Materials Science") > 0
replace tech_robotics = 1 if strpos(Pleaseselectthetechnologiesc, "Robotics and Drones") > 0
replace tech_software = 1 if strpos(Pleaseselectthetechnologiesc, "Software and Mobile Applications") > 0
replace tech_virtualreality = 1 if strpos(Pleaseselectthetechnologiesc, "Virtual Reality / Augmented Reality") > 0


gen has_website= 1-missing( Ifyoursolutionhasawebsite)


gen us_operate = 0
replace us_operate= 1 if strpos(Inwhichcountriesdoyoucurren, "United States") > 0

gen us_operate_ny = 0
replace us_operate_ny= 1 if strpos(Inwhichcountrieswillyoubeo, "United States") > 0

gen for_profit = 0
replace for_profit= 1 if strpos(Whattypeoforganizationisyou, "For-profit") > 0

gen more_than_year= 0 
replace more_than_year= 1 if strpos(Howlonghaveyoubeenworkingo, "year") > 0
replace more_than_year= 1 if strpos(Howlonghaveyoubeenworkingo, "Year") > 0
replace more_than_year= 1 if strpos(Howlonghaveyoubeenworkingo, "since") > 0
replace more_than_year= 1 if strpos(Howlonghaveyoubeenworkingo, "Since") > 0

gen b2c= 0 
replace b2c= 1 if strpos(Doyouprimarilyprovideproduct, "consume") > 0




