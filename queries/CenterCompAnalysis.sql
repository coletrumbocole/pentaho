# Sorry, this is a little bit fast and dirty because stretchy reports will most likely be replaced by Saiku or Pentaho reports soon. 
select
	*
from(
select # base has duplicate clients, so this will have to group by base.c_id, giving totals by client.
	ifnull(base.group_no, 'no group') as "GrpNo" # like a group id, counted in total row. 1 per base.c_id
	,base.group_name as "GrpName" # 1 per base.c_id
	,base.client_name as "ClientName" # 1 per base.c_id
	,count(base.ln_no) as "LnNo" # MORE THAN 1 per base.c_id
	,sum(base.ln_amt) as "LnAmt" # MORE THAN 1 per base.c_id
	,sum(base.outbal) as "OutBal" # MORE THAN 1 per base.c_id
	,sum(base.intbal) as "IntBal" # MORE THAN 1 per base.c_id
	,sum(base.ttc) as "TTC" # MORE THAN 1 per base.c_id
	,sum(base.arrears) as "Arrears" # 1 per LOAN, which is >= 0 per base.c_id
	,sum(base.gf5) as "GF 5%" # 1 per base.c_id
	,30 as "GFWkly" # 1 per base.c_id, so this will be left as 30 here. When grouped by client, this will still be 30 different than what would have happened with sum(30).
	,sum(base.psbal) as "PSBal"
	,sum(base.gf5) + sum(base.gfwkly) + sum(base.psbal) as "Total" #gf 5, gfwkly, psbal
	,(sum(base.gf5) + sum(base.gfwkly) + sum(base.psbal)) - (sum(base.ttc)) as "Variance" #Total - TTC
from
	(select #base
	group_info.group_no as group_no # like a group id, counted in total row
	,group_info.group_name as group_name
	,c.id as c_id
	,c.display_name as client_name
	,l.id as ln_no
	,l.principal_disbursed_derived as ln_amt
	,l.principal_outstanding_derived as outbal
	,l.interest_outstanding_derived as intbal
	,ifnull(l.total_outstanding_derived, 0) as ttc
	,laa.principal_overdue_derived as arrears
	,ifnull(l.principal_disbursed_derived, 0) * .05 as gf5
	,30 as gfwkly #30 per client, so this will be left as 30 here. When grouped by client, this will still be 30 different than what would have happened with sum(30).
	,ifnull(ps_bal, 0) as psbal

	from m_client as c

	left join
		(select client_id
		,account_balance_derived as ps_bal
		from m_savings_account
		) as sav
		on sav.client_id = c.id # hopefully every client only has 1 savings account. Otherwise, this would duplicate clients

	left join m_loan as l
		on l.client_id = c.id
		
	left join m_loan_arrears_aging as laa
		on laa.loan_id = l.id

	left join
		(select
			g.id as group_no
			,g.display_name as group_name
			,gc.client_id as client_id
		from m_group as g #there are 9 groups in g, but only 7 group_ids in gc. 
		
		inner join m_group_client as gc #I want the records from g that have a g.id that matches gc.group_id
			on gc.group_id = g.id
			
		group by gc.client_id
		) as group_info
		on group_info.client_id = c.id
	) as base
    
group by base.c_id

union all
(
select # Total
    ifnull(base.group_no, 'no group') as "GrpNo" # like a group id, counted in total row
	,'TOTAL' as "GrpName"
	,count(distinct base.c_id) as "ClientName"
	,count(base.ln_no) as "LnNo"
	,sum(base.ln_amt) as "LnAmt"
	,sum(base.outbal) as "OutBal"
	,sum(base.intbal) as "IntBal"
	,sum(base.ttc) as "TTC"
	,sum(base.arrears) as "Arrears"
	,sum(base.gf5) as "GF 5%"
	,sum(base.gfwkly) as "GFWkly" #30 per client, so this will be left as 30 here. When grouped by client, this will still be 30 different than what would have happened with sum(30).
	,sum(base.psbal) as "PSBal"
	,sum(base.gf5) + sum(base.gfwkly) + sum(base.psbal) as "Total" #gf 5, gfwkly, psbal
	,(sum(base.gf5) + sum(base.gfwkly) + sum(base.psbal)) - (sum(base.ttc)) as "Variance" #Total - TTC
from
	(select
	group_info.group_no as group_no # like a group id, counted in total row
	,group_info.group_name as group_name
	,c.id as c_id
	,c.display_name as client_name
	,l.id as ln_no
	,l.principal_disbursed_derived as ln_amt
	,l.principal_outstanding_derived as outbal
	,l.interest_outstanding_derived as intbal
	,ifnull(l.total_outstanding_derived, 0) as ttc
	,laa.principal_overdue_derived as arrears
	,ifnull(l.principal_disbursed_derived, 0) * .05 as gf5
	,30 as gfwkly #30 per client, so this will be left as 30 here. When grouped by client, this will still be 30 different than what would have happened with sum(30).
	,ifnull(ps_bal, 0) as psbal

	from m_client as c

	left join
		(select client_id
		,account_balance_derived as ps_bal
		from m_savings_account
		) as sav
		on sav.client_id = c.id # hopefully every client only has 1 savings account. Otherwise, this would duplicate clients

	left join m_loan as l
		on l.client_id = c.id
		
	left join m_loan_arrears_aging as laa
		on laa.loan_id = l.id

	left join
		(select
			g.id as group_no
			,g.display_name as group_name
			,gc.client_id as client_id
		from m_group as g #there are 9 groups in g, but only 7 group_ids in gc. 
		
		inner join m_group_client as gc #I want the records from g that have a g.id that matches gc.group_id
			on gc.group_id = g.id
			
		group by gc.client_id
		) as group_info
		on group_info.client_id = c.id
	) as base

group by base.group_no

) 

)as everything

order by GrpNo, LnNo
