select
	tot.branch as "Branch"
	,tot.par8 as "8-30"
	,tot.par31 as "31-60"
	,tot.par61 as "61-90"
	,tot.par91 as "91-120"
	,tot.par120 as ">120"
	,(tot.par8 + tot.par31 + tot.par61 + tot.par91 + tot.par120) as "TOTAL"
	,tot.weighted_par8 as "8-30 weighted"
	,tot.weighted_par31 as "31-60 weighted"
	,tot.weighted_par61 as "61-90 weighted"
	,tot.weighted_par91 as "91-120 weighted"
	,tot.weighted_par120 as ">120 weighted"
	,(tot.weighted_par8 + tot.weighted_par31 + tot.weighted_par61 + tot.weighted_par91 + tot.weighted_par120) as "TOTAL weighted"

from
(
	select 
	o.`name` as branch
	,sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 8 and 30, l.principal_outstanding_derived, 0)) as par8
	,sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 31 and 60, l.principal_outstanding_derived, 0)) as par31
	,sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 61 and 90, l.principal_outstanding_derived, 0)) as par61
	,sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 91 and 120, l.principal_outstanding_derived, 0)) as par91
	,sum(if(datediff(curdate(), laa.overdue_since_date_derived) > 120, l.principal_outstanding_derived, 0)) as par120
	
	,(sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 8 and 30, l.principal_outstanding_derived, 0)) * .1) as weighted_par8
	,(sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 31 and 60, l.principal_outstanding_derived, 0)) * .25) as weighted_par31
	,(sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 61 and 90, l.principal_outstanding_derived, 0)) * .5) as weighted_par61
	,(sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 91 and 120, l.principal_outstanding_derived, 0) ) * .75) as weighted_par91
	,sum( if(datediff(curdate(), laa.overdue_since_date_derived) > 120, l.principal_outstanding_derived, 0) ) as weighted_par120

	from `mifostenant-default`.m_loan as l
	left join `mifostenant-default`.m_client as c
		on c.id = l.client_id # so that I have no duplication of loans. *All loans have a client, some have same client.

	left join `mifostenant-default`.m_office as o 
		on o.id = c.office_id # All clients have office_id. So now each loan has an office_id.
		
	left join `mifostenant-default`.m_loan_arrears_aging as laa
		on l.id = laa.loan_id # not all loans have match an laa.
	
	group by o.`name`
) as tot  # totals

union # Outstanding Loan row. Should I combine this with Final Loan Loss row? It would be convenient, but then what would I call this row?

select
'Outstanding Loan' as "Branch"
,sum_tot.par8 as "8-30"
,sum_tot.par31 as "31-60"
,sum_tot.par61 as "61-90"
,sum_tot.par91 as "91-120"
,sum_tot.par120 as ">120"
,(sum_tot.par8 + sum_tot.par31 + sum_tot.par61 + sum_tot.par91 + sum_tot.par120) as "TOTAL"
,NULL as "8-30 weighted"
,NULL as "31-60 weighted"
,NULL as "61-90 weighted"
,NULL as "91-120 weighted"
,NULL as ">120 weighted"
,NULL as "TOTAL weighted"

from 
(
	select 

	sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 8 and 30, l.principal_outstanding_derived, 0)) as par8
	,sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 31 and 60, l.principal_outstanding_derived, 0)) as par31
	,sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 61 and 90, l.principal_outstanding_derived, 0)) as par61
	,sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 91 and 120, l.principal_outstanding_derived, 0)) as par91
	,sum(if(datediff(curdate(), laa.overdue_since_date_derived) > 120, l.principal_outstanding_derived, 0)) as par120
	
	# no weighted   

	from `mifostenant-default`.m_loan as l
	left join `mifostenant-default`.m_client as c
		on c.id = l.client_id

	left join `mifostenant-default`.m_office as o 
		on o.id = c.office_id
		
	left join `mifostenant-default`.m_loan_arrears_aging as laa
		on l.id = laa.loan_id 
	
	# same as tot above, but not grouped, and no weighted sums
) as sum_tot

union # Final Loan Loss row

select
'Final Loan Loss' as "Branch"
,NULL as "8-30"
,NULL as "31-60"
,NULL as "61-90"
,NULL as "91-120"
,NULL as ">120"
,NULL as "TOTAL"
,sum_tot.weighted_par8 as "8-30 weighted"
,sum_tot.weighted_par31 as "31-60 weighted"
,sum_tot.weighted_par61 as "61-90 weighted"
,sum_tot.weighted_par91 as "91-120 weighted"
,sum_tot.weighted_par120 as ">120 weighted"
,(sum_tot.weighted_par8 + sum_tot.weighted_par31 + sum_tot.weighted_par61 + sum_tot.weighted_par91 + sum_tot.weighted_par120) as "TOTAL weighted"

from 
(
	select 
	
	# no normal totals, only weighted PAR totals
	
	(sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 8 and 30, l.principal_outstanding_derived, 0)) * .1) as weighted_par8
	,(sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 31 and 60, l.principal_outstanding_derived, 0)) * .25) as weighted_par31
	,(sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 61 and 90, l.principal_outstanding_derived, 0)) * .5) as weighted_par61
	,(sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 91 and 120, l.principal_outstanding_derived, 0) ) * .75) as weighted_par91
	,sum( if(datediff(curdate(), laa.overdue_since_date_derived) > 120, l.principal_outstanding_derived, 0) ) as weighted_par120

	from `mifostenant-default`.m_loan as l
	left join `mifostenant-default`.m_client as c
		on c.id = l.client_id

	left join `mifostenant-default`.m_office as o 
		on o.id = c.office_id
		
	left join `mifostenant-default`.m_loan_arrears_aging as laa
		on l.id = laa.loan_id 
	
	# same table as tot above, but not grouped, and no normal PAR totals
) as sum_tot

;