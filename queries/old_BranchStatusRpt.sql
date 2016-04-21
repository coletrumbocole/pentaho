SELECT
	*
FROM
	(SELECT
		branch_by_cli 								as "Branch"
		,mentor_by_cli 								as "Mentor"
		,center_by_cli 								as "Center"
		,mtg_day_by_cli 							as "Mtg Day"
		,count(c_id) 								as "Clients"
		,count( if(loans_by_cli > 0, c_id, NULL) ) 	as "W/ Loan" #58, same as [select count(distinct client_id) from m_loan]
		,count(if(loans_by_cli = 0, c_id, NULL) ) 	as "W/o Loan"
		,sum(loans_by_cli) 							as "Loans" # 66, same as [select count(id) from m_loan]
		,sum(loans_amt_by_cli) 						as "Loans Amt"
		,sum(outbal_by_cli) 						as "OutBal"
		,sum(arrears_no_by_cli) 					as "Arrears No"
		,sum(arrears_amt_by_cli) 					as "Arrears Amt"
		,sum(new_no_by_cli) 						as "New No"
		,sum(new_amt_by_cli) 						as "New Amt"
		,sum(par_amt_by_cli) 						as "PAR Amt"
		,sum(age_by_cli) 							as "Age"
		,sum(disb_no_by_cli) 						as "Disb No"
		,sum(disb_amt_by_cli) 						as "Disb Amt"
		,sum(prin_pd_by_cli) 						as "Prin Pd"
		,sum(int_pd_by_cli) 						as "Int Pd"

	from(
		select
			o_s.branch 								as branch_by_cli #hopefully the client only belongs to 1 branch
			,o_s.mentor 							as mentor_by_cli  #hopefully the client only belongs to 1 mentor
			,o_s.center 							as center_by_cli  #hopefully the client only belongs to 1 center
			,group_mtg_day.mtg_day 					as mtg_day_by_cli  #hopefully the client only has 1 mtg day
			,c.id 									as c_id # can't have duplicate , will be grouped by c.id
			,count(l.id) 							as loans_by_cli # This will be Loans, and it will show me Clients With Loan / without loan by the number of loans each client has,
			,sum(l.principal_disbursed_derived) 	as loans_amt_by_cli
			,sum(l.principal_outstanding_derived) 	as outbal_by_cli
			,count(laa.loan_id) 					as arrears_no_by_cli
			,sum(laa.principal_overdue_derived) 	as arrears_amt_by_cli
			,count( if(l.disbursedon_date > date_sub(curdate(), interval 1 week), l.id, NULL) ) as new_no_by_cli
			,sum( if(l.disbursedon_date > date_sub(curdate(), interval 1 week), l.principal_disbursed_derived, 0) )  as new_amt_by_cli
			,sum(if(laa.loan_id <> NULL, l.principal_outstanding_derived, 0)) as par_amt_by_cli
			,'' 									as age_by_cli
			,count( if(l.disbursedon_date > date_sub( curdate(), interval 1 month), l.id, NULL) ) as disb_no_by_cli
			,sum( if(l.disbursedon_date > date_sub( curdate(), interval 1 month), l.principal_disbursed_derived, NULL) ) as disb_amt_by_cli
			,sum(l.principal_repaid_derived) 		as prin_pd_by_cli
			,sum(l.interest_repaid_derived) 		as int_pd_by_cli
		from m_client 								as c

		left join
			(select
				o1.id 								as center_id,
				g.display_name 						as center,
				ifnull(g.display_name, o1.`name`) 	as branch,
				s.display_name 						as mentor
				# needs Mtg Day        
			from m_office 							as o1
			
			left join m_group 						as g
				on o1.parent_id = g.office_id #Multiple groups have same parent office. This duplicates the offices.
			
			left join m_staff 						as s 
				on o1.id = s.office_id # Multiple staff at each office, also duplicates office records.
			group by o1.id 
			) 										as o_s
			on c.office_id = o_s.center_id
		
		left join 
			( select
				"KAMALING COMPOUND" 		as group_name,	 "Friday" as mtg_day UNION ALL ( select
				"CABAÑERO FARM" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"MASULOG" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"KAGITINGAN/BRGY.41-2" 		as group_name,	 null as mtg_day	) UNION ALL ( select
				"SAN RAFAEL" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"MATUMBO" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"CANDUMAN HOUSING" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"MADRID" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"MARIBAGO" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"CHICHARONAN" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"AGUS GAMAY" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"Sanrose Market" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"CAIMITOHAN" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"POB. GREENHILLS" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"KAGITINGAN/BRGY.41-1" 		as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"YELLOW BELL 2" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"PUROK LEMONSITO" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"BRGY. 12/ DIVISORIA" 		as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"TUGBONGAN - A" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"DUBAIS" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"MATUMBO2" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"LOOC 2" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"POBLACION 7" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BGY. SAN ANTONIO SPL 9" 	as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"ALABANG 7" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"TALON 3" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"POBLACION 1" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"JADE COMPOUND" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"PAROLA 3/6" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"PAROLA 4/5" 				as group_name,	 null as mtg_day	) UNION ALL ( select
				"SUCAT, MUNTINLUPA" 		as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"SUNRISE" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BGY. BF-A" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"PARADISE" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"POLICARPIO" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"BARANGAY 8" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"KADIMA LETRE" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"GOZON 4/5" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"GOZON 2" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"CATMON 1" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BATO- BATO" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"HOLY SPIRIT 4/RIVERSIDE" 	as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"NEW SILANGAN" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"PINYAHAN" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"KILYAWAN 1" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"COMVILLE" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"IGIBAN" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"PAGRAI 1" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"QUEEN IMELDA" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"SILIHAN" 					as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"MAHABANG PARANG" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"LIBIS" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"ROSARIO - REYES" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"NANGKA" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"BAG-BAG" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"TALIPAPA" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BAHAY TORO 3" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"COMMONWEALTH 7" 			as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"NORTH FAIRVIEW 2" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"LUMOT" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"MARULAS 2" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"WEST BAGONG BARRIO 2/4" 	as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"MAPULANG LUPA 1A" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"MAPULANG LUPA 2" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"POTRERO 3" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"CAMARIN 33" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"CAMARIN 4" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"CAMARIN 7" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"CAMARIN 26" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"SITIO MALABON" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"BULAO 2" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"IBARRA COMPOUND" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"SITIO BAYABAS" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"MASAYA" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"BONIFACIO" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"STO. ROSARIO" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"CALZADA 3" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"PATEROS" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"CALZADA" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"STA. ANA" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BLK. 37-1/2" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BLK. 38" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BLK. 40-2" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"GUMAOK EAST" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"GRACEVILLE" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"MUZON-TIERRA BENITA" 		as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"PECSON VILLE" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"AMPARO" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"18381" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"18401TO" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"18412" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"16471" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"11031" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BLK. 28-27/BLK. 20-2" 		as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"BRGY. 600" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"DAGAT-DAGATAN 1" 			as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BARANGAY 20" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"LANGARAY 2A" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BARANGAY 19" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"DAGAT-DAGATAN 11" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"NBBN 1/NBBS 1/2/NBBN2" 	as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"HITO" 						as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"KAUNLARAN 1" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"DOÑA ROSARIO" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"SAN BARTOLOME" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"SAN BARTOLOME 2" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"SAN BARTOLOME 1-A" 		as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"PINAGMINAHAN" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"TULAKEN" 					as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"JACINTO" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"SAN LUIS" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"MAMBUGAN 4" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"SAMBAVILLE" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"CAMARIN 32" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"CITRUS" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BIGTE" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"GAYA-GAYA PHASE 6B-A" 		as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BAGONG BUHAY 2" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"TALA" 						as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"MALARIA 2" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"MARIA CORAZON" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"DUHAT" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"UPPER TAGPOS 2" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"PAGRAI 4" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"SITIO PALANAS" 			as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"SITIO INALSAN" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"PADILLA 1" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"URBAN 4" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"ILANG-ILANG" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"NAPICO" 					as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"VILLA ANTONIO-PG" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"KATARUNGAN 2" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"SITIO EEA" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"URBAN 2-A" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"MANGGAHAN" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"PALATIW" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"PINAGBUHATAN" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"Sitio Camansi" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"TABING ILOG" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"KINGSWOOD" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"ST. JUDE" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"QUADRA" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"TAMBUNTING/OROQUIETA" 		as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BALUT 1/2" 				as group_name,	 null as mtg_day	) UNION ALL ( select
				"BF-SITE" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"CAA-LAS PIÑAS" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"T.S CRUZ, LAS PIÑAS" 		as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"FLOODWAY" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"SOLDIERS/KABISIG" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"KABISIG 4" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"PFCI 1/2" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"SITIO TUBIGAN" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"RUHAT" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"METROVIEW" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"GETHSEMANE" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"SITIO TUGAS" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BIASONG PROPER" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"COGON DRIVE" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"SITIO APPLE" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"LA PURISIMA" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"NEW HARMONY II-LOMA DE GATO" as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"QUARRY" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"SOUTHWINDS" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"Ilang-Ilang" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"QUIOT" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"PAYATAS - LEYTE" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"PAYATAS 4" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"PAYATAS - DAMA DE NOCHE 1" as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"LITEX 1-1" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"COMMONWEALTH 2" 			as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"PAYATAS MADJAAS" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"MODESTA" 					as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"SAINT MATHEW" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"VICTORY HILLS" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"SILANGAN" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"SITIO BATO-BATO" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"ARIENDA6" 					as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"N. IBAYO-PG" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"ARIENDA" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"PATEROS 2/4-PG" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"PITOGO/'NUEVO-PG" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"ARIENDA" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"SAN LORENZO" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"MCDONALD" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"SITIO MABILOG-CULIAT" 		as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"PAEL-CULIAT" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"NIA ROAD" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"KABATUHAN" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"MARULAS 6" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"JASMIN A" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"PALTOK" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"BRGY. UNANG SIGAW (BALINTAWAK)" as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"KARUHATAN" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BARANGAY 101" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BICUTAN" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"IMELDA" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"MASAYA 2" 					as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"N. LAOT" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"K-9 EXTENSION" 			as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BANANA REPUBLIC" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"SAMPAGUITA PG" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"EXODUS1-A" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"LLANO ROAD - VC" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"UGONG BONBON" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BAGBAGUIN 2/CAYBIGA 2" 	as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"CAYBIGA 5" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BAGUMBONG 15" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"BAGUMBONG 4-1/7" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"BAGUMBONG 6" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BIGNAY 2" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"DEPARO 3/6 -1" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"TALANAY" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"CENTELLA" 					as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"BALITE" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"JEWEL MINE" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"SM PARANG" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"KASIGLAHAN 8" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"BAGONG SILANG PHASE 8-B" 	as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"BAGONG SILANG 33" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BAGONG SILANG 9/3" 		as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BAGUMBONG 14" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"BRGY. PINAGSAMA" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"TIPAS" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"I TIPAS" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"MANUNUSO" 					as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"SITIO ABUYOD" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"ANGELA" 					as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"BRGY. SAN ROQUE 3-A" 		as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"PADILLA 2" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"PUROK SUMULONG" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"CARISSA 1" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"GUAVA HILLS" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"LOWER MANGGAHAN" 			as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"LUMANG PALENGKE" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"TIKLING" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"GENESIS" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"PASONG PUTIK 2" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"SAN AGUSTIN - ACACIA" 		as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"CAMARIN 16" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"CAMARIN 28/CAMARIN 28-A"	as group_name,	 "Tuesday" as mtg_day	)
			) 										as group_mtg_day
			on group_mtg_day.group_name = o_s.center

		left join m_loan 							as l
			on c.id = l.client_id

		left join m_loan_arrears_aging 				as laa
			on l.id = laa.loan_id

		group by c.id ) 							as by_cli

	group by center # hopefully every center only has 1 mentor. But branches can have more than 1 mentor.

	union all
	(
	select
		branch_by_cli 								as "Branch"
		,mentor_by_cli 								as "Mentor"
		,count(distinct center_by_cli) 				as "Center"
		,'' 										as "Mtg Day"
		,count(c_id) 								as "Clients"
		,count( if(loans_by_cli > 0, c_id, NULL) ) 	as "W/ Loan" #58, same as [select count(distinct client_id) from m_loan]
		,count(if(loans_by_cli = 0, c_id, NULL) ) 	as "W/o Loan"
		,sum(loans_by_cli) 							as "Loans" # 66, same as [select count(id) from m_loan]
		,sum(loans_amt_by_cli) 						as "Loans Amt"
		,sum(outbal_by_cli) 						as "OutBal"
		,sum(arrears_no_by_cli) 					as "Arrears No"
		,sum(arrears_amt_by_cli) 					as "Arrears Amt"
		,sum(new_no_by_cli) 						as "New No"
		,sum(new_amt_by_cli) 						as "New Amt"
		,sum(par_amt_by_cli) 						as "PAR Amt"
		,'' 										as "Age"
		,sum(disb_no_by_cli) 						as "Disb No"
		,sum(disb_amt_by_cli) 						as "Disb Amt"
		,sum(prin_pd_by_cli) 						as "Prin Pd"
		,sum(int_pd_by_cli) 						as "Int Pd"

	from(
		select
			o_s.branch 								as branch_by_cli #hopefully the client only belongs to 1 branch
			,o_s.mentor 							as mentor_by_cli  #hopefully the client only belongs to 1 mentor
			,o_s.center 							as center_by_cli  #hopefully the client only belongs to 1 center
			,group_mtg_day.mtg_day 					as mtg_day_by_cli  #hopefully the client only has 1 mtg day
			,c.id 									as c_id # can't have duplicate , will be grouped by c.id
			,count(l.id) 							as loans_by_cli # This will be Loans, and it will show me Clients With Loan / without loan by the number of loans each client has,
			,sum(l.principal_disbursed_derived) 	as loans_amt_by_cli
			,sum(l.principal_outstanding_derived) 	as outbal_by_cli
			,count(laa.loan_id) 					as arrears_no_by_cli
			,sum(laa.principal_overdue_derived) 	as arrears_amt_by_cli
			,count( if(l.disbursedon_date > date_sub(curdate(), interval 1 week), l.id, NULL) ) as new_no_by_cli
			,sum( if(l.disbursedon_date > date_sub(curdate(), interval 1 week), l.principal_disbursed_derived, 0) )  as new_amt_by_cli
			,sum(if(laa.loan_id <> NULL, l.principal_outstanding_derived, 0)) as par_amt_by_cli
			,'' 									as age_by_cli
			,count( if(l.disbursedon_date > date_sub( curdate(), interval 1 month), l.id, NULL) ) as disb_no_by_cli
			,sum( if(l.disbursedon_date > date_sub( curdate(), interval 1 month), l.principal_disbursed_derived, NULL) ) as disb_amt_by_cli
			,sum(l.principal_repaid_derived) 		as prin_pd_by_cli
			,sum(l.interest_repaid_derived) 		as int_pd_by_cli
		from m_client 								as c

		left join
			(select
				o1.id 								as center_id,
				o1.`name` 							as center,
				ifnull(o2.`name`, o1.`name`) 		as branch,
				s.display_name 						as mentor
				# needs Mtg Day        
			from m_office 							as o1
			
			left join m_office 						as o2
				on o1.parent_id = o2.id
			
			left join m_staff 						as s 
				on o1.id = s.office_id
			group by o1.id 
			) 										as o_s
			on c.office_id = o_s.center_id

		left join 
			( select
				"KAMALING COMPOUND" 		as group_name,	 "Friday" as mtg_day UNION ALL ( select
				"CABAÑERO FARM" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"MASULOG" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"KAGITINGAN/BRGY.41-2" 		as group_name,	 null as mtg_day	) UNION ALL ( select
				"SAN RAFAEL" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"MATUMBO" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"CANDUMAN HOUSING" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"MADRID" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"MARIBAGO" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"CHICHARONAN" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"AGUS GAMAY" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"Sanrose Market" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"CAIMITOHAN" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"POB. GREENHILLS" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"KAGITINGAN/BRGY.41-1" 		as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"YELLOW BELL 2" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"PUROK LEMONSITO" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"BRGY. 12/ DIVISORIA" 		as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"TUGBONGAN - A" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"DUBAIS" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"MATUMBO2" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"LOOC 2" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"POBLACION 7" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BGY. SAN ANTONIO SPL 9" 	as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"ALABANG 7" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"TALON 3" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"POBLACION 1" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"JADE COMPOUND" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"PAROLA 3/6" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"PAROLA 4/5" 				as group_name,	 null as mtg_day	) UNION ALL ( select
				"SUCAT, MUNTINLUPA" 		as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"SUNRISE" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BGY. BF-A" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"PARADISE" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"POLICARPIO" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"BARANGAY 8" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"KADIMA LETRE" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"GOZON 4/5" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"GOZON 2" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"CATMON 1" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BATO- BATO" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"HOLY SPIRIT 4/RIVERSIDE" 	as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"NEW SILANGAN" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"PINYAHAN" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"KILYAWAN 1" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"COMVILLE" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"IGIBAN" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"PAGRAI 1" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"QUEEN IMELDA" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"SILIHAN" 					as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"MAHABANG PARANG" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"LIBIS" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"ROSARIO - REYES" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"NANGKA" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"BAG-BAG" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"TALIPAPA" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BAHAY TORO 3" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"COMMONWEALTH 7" 			as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"NORTH FAIRVIEW 2" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"LUMOT" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"MARULAS 2" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"WEST BAGONG BARRIO 2/4" 	as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"MAPULANG LUPA 1A" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"MAPULANG LUPA 2" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"POTRERO 3" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"CAMARIN 33" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"CAMARIN 4" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"CAMARIN 7" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"CAMARIN 26" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"SITIO MALABON" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"BULAO 2" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"IBARRA COMPOUND" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"SITIO BAYABAS" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"MASAYA" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"BONIFACIO" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"STO. ROSARIO" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"CALZADA 3" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"PATEROS" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"CALZADA" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"STA. ANA" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BLK. 37-1/2" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BLK. 38" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BLK. 40-2" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"GUMAOK EAST" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"GRACEVILLE" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"MUZON-TIERRA BENITA" 		as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"PECSON VILLE" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"AMPARO" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"18381" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"18401TO" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"18412" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"16471" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"11031" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BLK. 28-27/BLK. 20-2" 		as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"BRGY. 600" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"DAGAT-DAGATAN 1" 			as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BARANGAY 20" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"LANGARAY 2A" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BARANGAY 19" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"DAGAT-DAGATAN 11" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"NBBN 1/NBBS 1/2/NBBN2" 	as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"HITO" 						as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"KAUNLARAN 1" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"DOÑA ROSARIO" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"SAN BARTOLOME" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"SAN BARTOLOME 2" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"SAN BARTOLOME 1-A" 		as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"PINAGMINAHAN" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"TULAKEN" 					as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"JACINTO" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"SAN LUIS" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"MAMBUGAN 4" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"SAMBAVILLE" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"CAMARIN 32" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"CITRUS" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BIGTE" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"GAYA-GAYA PHASE 6B-A" 		as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BAGONG BUHAY 2" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"TALA" 						as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"MALARIA 2" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"MARIA CORAZON" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"DUHAT" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"UPPER TAGPOS 2" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"PAGRAI 4" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"SITIO PALANAS" 			as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"SITIO INALSAN" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"PADILLA 1" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"URBAN 4" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"ILANG-ILANG" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"NAPICO" 					as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"VILLA ANTONIO-PG" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"KATARUNGAN 2" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"SITIO EEA" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"URBAN 2-A" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"MANGGAHAN" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"PALATIW" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"PINAGBUHATAN" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"Sitio Camansi" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"TABING ILOG" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"KINGSWOOD" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"ST. JUDE" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"QUADRA" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"TAMBUNTING/OROQUIETA" 		as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BALUT 1/2" 				as group_name,	 null as mtg_day	) UNION ALL ( select
				"BF-SITE" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"CAA-LAS PIÑAS" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"T.S CRUZ, LAS PIÑAS" 		as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"FLOODWAY" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"SOLDIERS/KABISIG" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"KABISIG 4" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"PFCI 1/2" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"SITIO TUBIGAN" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"RUHAT" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"METROVIEW" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"GETHSEMANE" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"SITIO TUGAS" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BIASONG PROPER" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"COGON DRIVE" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"SITIO APPLE" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"LA PURISIMA" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"NEW HARMONY II-LOMA DE GATO" as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"QUARRY" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"SOUTHWINDS" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"Ilang-Ilang" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"QUIOT" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"PAYATAS - LEYTE" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"PAYATAS 4" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"PAYATAS - DAMA DE NOCHE 1" as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"LITEX 1-1" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"COMMONWEALTH 2" 			as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"PAYATAS MADJAAS" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"MODESTA" 					as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"SAINT MATHEW" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"VICTORY HILLS" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"SILANGAN" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"SITIO BATO-BATO" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"ARIENDA6" 					as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"N. IBAYO-PG" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"ARIENDA" 					as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"PATEROS 2/4-PG" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"PITOGO/'NUEVO-PG" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"ARIENDA" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"SAN LORENZO" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"MCDONALD" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"SITIO MABILOG-CULIAT" 		as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"PAEL-CULIAT" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"NIA ROAD" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"KABATUHAN" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"MARULAS 6" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"JASMIN A" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"PALTOK" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"BRGY. UNANG SIGAW (BALINTAWAK)" as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"KARUHATAN" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BARANGAY 101" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BICUTAN" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"IMELDA" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"MASAYA 2" 					as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"N. LAOT" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"K-9 EXTENSION" 			as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BANANA REPUBLIC" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"SAMPAGUITA PG" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"EXODUS1-A" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"LLANO ROAD - VC" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"UGONG BONBON" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BAGBAGUIN 2/CAYBIGA 2" 	as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"CAYBIGA 5" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BAGUMBONG 15" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"BAGUMBONG 4-1/7" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"BAGUMBONG 6" 				as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"BIGNAY 2" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"DEPARO 3/6 -1" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"TALANAY" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"CENTELLA" 					as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"BALITE" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"JEWEL MINE" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"SM PARANG" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"KASIGLAHAN 8" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"BAGONG SILANG PHASE 8-B" 	as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"BAGONG SILANG 33" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BAGONG SILANG 9/3" 		as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"BAGUMBONG 14" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"BRGY. PINAGSAMA" 			as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"TIPAS" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"I TIPAS" 					as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"MANUNUSO" 					as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"SITIO ABUYOD" 				as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"ANGELA" 					as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"BRGY. SAN ROQUE 3-A" 		as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"PADILLA 2" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"PUROK SUMULONG" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"CARISSA 1" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"GUAVA HILLS" 				as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"LOWER MANGGAHAN" 			as group_name,	 "Tuesday" as mtg_day	) UNION ALL ( select
				"LUMANG PALENGKE" 			as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"TIKLING" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"GENESIS" 					as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"PASONG PUTIK 2" 			as group_name,	 "Thursday" as mtg_day	) UNION ALL ( select
				"SAN AGUSTIN - ACACIA" 		as group_name,	 "Friday" as mtg_day	) UNION ALL ( select
				"CAMARIN 16" 				as group_name,	 "Monday" as mtg_day	) UNION ALL ( select
				"CAMARIN 28/CAMARIN 28-A"	as group_name,	 "Tuesday" as mtg_day	)
			) 										as group_mtg_day
			on group_mtg_day.group_name = o_s.center

		left join m_loan 							as l
			on c.id = l.client_id
	   
		left join m_loan_arrears_aging 				as laa
			on l.id = laa.loan_id

		group by c.id ) 							as by_cli

	group by mentor
)

) as everything

order by Branch, Mentor, Loans
;

# needs a total by mentor



