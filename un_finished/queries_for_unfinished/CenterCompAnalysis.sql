SELECT
	*
FROM(
	SELECT # base hAS duplicate clients, so this will have to GROUP BY base.c_id, giving totals by client.
		ifnull(base.group_no, 'no group') 						AS "GrpNo" # like a group id, counted in total row. 1 per base.c_id
		,base.group_name 										AS "GrpName" # 1 per base.c_id
		,base.client_name 										AS "ClientName" # 1 per base.c_id
		,count(base.ln_no) 										AS "LnNo" # MORE THAN 1 per base.c_id
		,sum(base.ln_amt) 										AS "LnAmt" # MORE THAN 1 per base.c_id
		,sum(base.outbal) 										AS "OutBal" # MORE THAN 1 per base.c_id
		,sum(base.intbal) 										AS "IntBal" # MORE THAN 1 per base.c_id
		,sum(base.ttc) 											AS "TTC" # MORE THAN 1 per base.c_id
		,sum(base.arrears) 										AS "Arrears" # 1 per LOAN, which is >= 0 per base.c_id
		,sum(base.gf5) 											AS "GF 5%" # 1 per base.c_id
		,30 													AS "GFWkly" # 1 per base.c_id, so this will be left AS 30 here. When grouped by client, this will still be 30 different than what would have happened with sum(30).
		,sum(base.psbal) 										AS "PSBal"
		,sum(base.gf5) + sum(base.gfwkly) + sum(base.psbal) 	AS "Total" #gf 5, gfwkly, psbal
		,(sum(base.gf5) + sum(base.gfwkly) + sum(base.psbal)) - (sum(base.ttc)) AS "Variance" #Total - TTC
	FROM
		(SELECT #base
			group_info.group_no 								AS group_no # like a group id, counted in total row
			,group_info.group_name 								AS group_name
			,c.id 												AS c_id
			,c.display_name 									AS client_name
			,l.id 												AS ln_no
			,l.principal_disbursed_derived 						AS ln_amt
			,l.principal_outstanding_derived 					AS outbal
			,l.interest_outstanding_derived 					AS intbal
			,ifnull(l.total_outstanding_derived, 0) 			AS ttc
			,laa.principal_overdue_derived 						AS arrears
			,ifnull(l.principal_disbursed_derived, 0) * .05 	AS gf5
			,30 												AS gfwkly #30 per client, so this will be left AS 30 here. When grouped by client, this will still be 30 different than what would have happened with sum(30).
			,ifnull(ps_bal, 0) 									AS psbal
		FROM m_client 											AS c

		LEFT JOIN (
			SELECT 
				client_id
				,account_balance_derived 						AS ps_bal
			FROM m_savings_account
			) 													AS sav
			ON sav.client_id = c.id # hopefully every client only hAS 1 savings account. Otherwise, this would duplicate clients

		LEFT JOIN m_loan 										AS l
			ON l.client_id = c.id
			
		LEFT JOIN m_loan_arrears_aging 							AS laa
			ON laa.loan_id = l.id

		LEFT JOIN (
			SELECT
				g.id 											AS group_no
				,g.display_name 								AS group_name
				,gc.client_id 									AS client_id
			FROM m_group 										AS g #there are 9 groups in g, but only 7 group_ids in gc. 
			
			INNER JOIN m_group_client 							AS gc #I want the records FROM g that have a g.id that matches gc.group_id
				ON gc.group_id = g.id
				
			GROUP BY gc.client_id
			) 													AS group_info
			ON group_info.client_id = c.id
		) 														AS base
		
	GROUP BY base.c_id

	UNION ALL
	(
	SELECT # Total
		ifnull(base.group_no, 'no group') 						AS "GrpNo" # like a group id, counted in total row
		,'TOTAL' 												AS "GrpName"
		,count(distinct base.c_id) 								AS "ClientName"
		,count(base.ln_no) 										AS "LnNo"
		,sum(base.ln_amt) 										AS "LnAmt"
		,sum(base.outbal) 										AS "OutBal"
		,sum(base.intbal) 										AS "IntBal"
		,sum(base.ttc) 											AS "TTC"
		,sum(base.arrears) 										AS "Arrears"
		,sum(base.gf5) 											AS "GF 5%"
		,sum(base.gfwkly) 										AS "GFWkly" #30 per client, so this will be left AS 30 here. When grouped by client, this will still be 30 different than what would have happened with sum(30).
		,sum(base.psbal) 										AS "PSBal"
		,sum(base.gf5) + sum(base.gfwkly) + sum(base.psbal) 	AS "Total" #gf 5, gfwkly, psbal
		,(sum(base.gf5) + sum(base.gfwkly) + sum(base.psbal)) - (sum(base.ttc)) AS "Variance" #Total - TTC
	FROM
		(SELECT
			group_info.group_no 								AS group_no # like a group id, counted in total row
			,group_info.group_name 								AS group_name
			,c.id 												AS c_id
			,c.display_name 									AS client_name
			,l.id 												AS ln_no
			,l.principal_disbursed_derived 						AS ln_amt
			,l.principal_outstanding_derived 					AS outbal
			,l.interest_outstanding_derived 					AS intbal
			,ifnull(l.total_outstanding_derived, 0) 			AS ttc
			,laa.principal_overdue_derived 						AS arrears
			,ifnull(l.principal_disbursed_derived, 0) * .05 	AS gf5
			,30 												AS gfwkly #30 per client, so this will be left AS 30 here. When grouped by client, this will still be 30 different than what would have happened with sum(30).
			,ifnull(ps_bal, 0) 									AS psbal
		FROM m_client 											AS c

		LEFT JOIN
			(SELECT 
				client_id
				,account_balance_derived 						AS ps_bal
			FROM m_savings_account
			) 													AS sav
			ON sav.client_id = c.id # hopefully every client only hAS 1 savings account. Otherwise, this would duplicate clients

		LEFT JOIN m_loan 										AS l
			ON l.client_id = c.id
			
		LEFT JOIN m_loan_arrears_aging 							AS laa
			ON laa.loan_id = l.id

		LEFT JOIN
			(SELECT
				g.id 											AS group_no
				,g.display_name 								AS group_name
				,gc.client_id 									AS client_id
			FROM m_group 										AS g #there are 9 groups in g, but only 7 group_ids in gc. 
			
			INNER JOIN m_group_client 							AS gc #I want the records FROM g that have a g.id that matches gc.group_id
				ON gc.group_id = g.id
				
			GROUP BY gc.client_id
			) 													AS group_info
			ON group_info.client_id = c.id
		) 														AS base

	GROUP BY base.group_no

	)

) AS everything

ORDER BY GrpNo, LnNo
;