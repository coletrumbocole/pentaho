select

o.name as "Branch"
,count(l.id) as "Loan No"
,sum(l.principal_disbursed_derived) as "Loan Amt"
,sum(l.principal_outstanding_derived) as "Balance"

,count( laa.loan_id ) as "No (Arrears)"
,sum( if(laa.loan_id is not NULL, l.principal_outstanding_derived, 0) ) as "PAR Amt"
,sum( laa.principal_overdue_derived ) as "Arrears"

#if(datediff(curdate(), laa.overdue_since_date_derived) between 1 and 7, l.id, NULL)
	# what if laa.overdue_since_date_derived is NULL? datediff returns NULL. between 1 and 7 doesn't evaluate to true.

,count(if(datediff(curdate(), laa.overdue_since_date_derived) between 1 and 7, l.id, NULL)) as "No (1-7)"
,sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 1 and 7, laa.principal_overdue_derived, 0) ) as "Arrears (1-7)"
,sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 1 and 7, l.principal_outstanding_derived, 0) ) as "PAR Amt (1-7)"

#if(datediff(curdate(), laa.overdue_since_date_derived) between 8 and 30, l.id, NULL)
,count( if(datediff(curdate(), laa.overdue_since_date_derived) between 8 and 30, l.id, NULL) ) as "No (8-30)"
,sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 8 and 30, laa.principal_overdue_derived, 0) ) as "Arrears (8-30)"
,sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 8 and 30, l.principal_outstanding_derived, 0) ) as "PAR Amt (8-30)"

#if(datediff(curdate(), laa.overdue_since_date_derived) between 31 and 60, l.id, NULL)
,count( if(datediff(curdate(), laa.overdue_since_date_derived) between 31 and 60, l.id, NULL) ) as "No (31-60)"
,sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 31 and 60, laa.principal_overdue_derived, 0) ) as "Arrears (31-60)"
,sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 31 and 60, l.principal_outstanding_derived, 0) ) as "PAR Amt (31-60)"

#if(datediff(curdate(), laa.overdue_since_date_derived) between 61 and 90, l.id, NULL)
,count( if(datediff(curdate(), laa.overdue_since_date_derived) between 61 and 90, l.id, NULL) ) as "No (61-90)"
,sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 61 and 90, laa.principal_overdue_derived, 0) ) as "Arrears (61-90)"
,sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 61 and 90, l.principal_outstanding_derived, 0) ) as "PAR Amt (61-90)"

#if(datediff(curdate(), laa.overdue_since_date_derived) between 91 and 120, l.id, NULL)
,count( if(datediff(curdate(), laa.overdue_since_date_derived) between 91 and 120, l.id, NULL) ) as "No (91-120)"
,sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 91 and 120, laa.principal_overdue_derived, 0) ) as "Arrears (91-120)"
,sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 91 and 120, l.principal_outstanding_derived, 0) ) as "PAR Amt (91-120)"

#if(datediff(curdate(), laa.overdue_since_date_derived) > 120, l.id, NULL)
,count( if(datediff(curdate(), laa.overdue_since_date_derived) > 120, l.id, NULL) ) as "No (>120)"
,sum( if(datediff(curdate(), laa.overdue_since_date_derived) > 120, laa.principal_overdue_derived, 0) ) as "Arrears (>120)"
,sum( if(datediff(curdate(), laa.overdue_since_date_derived) > 120, l.principal_outstanding_derived, 0) ) as "PAR Amt (>120)"

,count( if(datediff(curdate(), laa.overdue_since_date_derived) > 7, l.id, NULL) ) as "No total" 
,sum( if(datediff(curdate(), laa.overdue_since_date_derived) > 7, laa.principal_overdue_derived, 0) ) as "ARREARS total"
,sum( if(datediff(curdate(), laa.overdue_since_date_derived) > 7, l.principal_outstanding_derived, 0) ) as "PAR"
from m_loan as l

left join m_client as c
	on c.id = l.client_id # so that I have no duplication of loans. *All loans have a client, some have same client.

left join m_office as o 
	on o.id = c.office_id # All clients have office_id. So now each loan has an office_id.
    
left join m_loan_arrears_aging as laa
	on l.id = laa.loan_id # not all loans have match an laa.

#where hierarchy ... so that I don't repeat count anything? It looks like every loan ends up at a unique office becouase of the way the tables are joined.
group by o.name

union

(
	select # same calculation for every field, just not grouped.

	'TOTAL' as "Branch"
	,count(l.id) as "Loan No"
	,sum(l.principal_disbursed_derived) as "Loan Amt"
	,sum(l.principal_outstanding_derived) as "Balance"

	,'?' as "No" # ?
	,'?' as "PAR Amt" # ?
	,'?' as "Arrears" # ?

	#if(datediff(curdate(), laa.overdue_since_date_derived) between 1 and 7, l.id, NULL)
		# what if laa.overdue_since_date_derived is NULL? datediff returns NULL. between 1 and 7 doesn't evaluate to true.

	,count(if(datediff(curdate(), laa.overdue_since_date_derived) between 1 and 7, l.id, NULL)) as "No (1-7)"
	,sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 1 and 7, laa.principal_overdue_derived, 0) ) as "Arrears (1-7)"
	,sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 1 and 7, l.principal_outstanding_derived, 0) ) as "PAR Amt (1-7)"

	#if(datediff(curdate(), laa.overdue_since_date_derived) between 8 and 30, l.id, NULL)
	,count( if(datediff(curdate(), laa.overdue_since_date_derived) between 8 and 30, l.id, NULL) ) as "No (8-30)"
	,sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 8 and 30, laa.principal_overdue_derived, 0) ) as "Arrears (8-30)"
	,sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 8 and 30, l.principal_outstanding_derived, 0) ) as "PAR Amt (8-30)"

	#if(datediff(curdate(), laa.overdue_since_date_derived) between 31 and 60, l.id, NULL)
	,count( if(datediff(curdate(), laa.overdue_since_date_derived) between 31 and 60, l.id, NULL) ) as "No (31-60)"
	,sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 31 and 60, laa.principal_overdue_derived, 0) ) as "Arrears (31-60)"
	,sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 31 and 60, l.principal_outstanding_derived, 0) ) as "PAR Amt (31-60)"

	#if(datediff(curdate(), laa.overdue_since_date_derived) between 61 and 90, l.id, NULL)
	,count( if(datediff(curdate(), laa.overdue_since_date_derived) between 61 and 90, l.id, NULL) ) as "No (61-90)"
	,sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 61 and 90, laa.principal_overdue_derived, 0) ) as "Arrears (61-90)"
	,sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 61 and 90, l.principal_outstanding_derived, 0) ) as "PAR Amt (61-90)"

	#if(datediff(curdate(), laa.overdue_since_date_derived) between 91 and 120, l.id, NULL)
	,count( if(datediff(curdate(), laa.overdue_since_date_derived) between 91 and 120, l.id, NULL) ) as "No (91-120)"
	,sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 91 and 120, laa.principal_overdue_derived, 0) ) as "Arrears (91-120)"
	,sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 91 and 120, l.principal_outstanding_derived, 0) ) as "PAR Amt (91-120)"

	#if(datediff(curdate(), laa.overdue_since_date_derived) > 120, l.id, NULL)
	,count( if(datediff(curdate(), laa.overdue_since_date_derived) > 120, l.id, NULL) ) as "No (>120)"
	,sum( if(datediff(curdate(), laa.overdue_since_date_derived) > 120, laa.principal_overdue_derived, 0) ) as "Arrears (>120)"
	,sum( if(datediff(curdate(), laa.overdue_since_date_derived) > 120, l.principal_outstanding_derived, 0) ) as "PAR Amt (>120)"

	,count( if(datediff(curdate(), laa.overdue_since_date_derived) > 7, l.id, NULL) ) as "No total" 
	,sum( if(datediff(curdate(), laa.overdue_since_date_derived) > 7, laa.principal_overdue_derived, 0) ) as "ARREARS total"
	,sum( if(datediff(curdate(), laa.overdue_since_date_derived) > 7, l.principal_outstanding_derived, 0) ) as "PAR"

	from m_loan as l #same from statement as the first table in the union, but not grouped
	left join m_client as c
		on c.id = l.client_id # so that I have no duplication of loans. *All loans have a client, some have same client.

	left join m_office as o 
		on o.id = c.office_id # All clients have office_id. So now each loan has an office_id.
		
	left join m_loan_arrears_aging as laa
		on l.id = laa.loan_id # not all loans have match an laa.

	#where hierarchy ... so that I don't repeat count anything? It looks like every loan ends up at a unique office becouase of the way the tables are joined.
	#group by o.name
)

union

(
select 
	'PERCENTAGE' as "Branch"
	,NULL as "Loan No"
	,NULL as "Loan Amt"
	,NULL as "Balance"

	,NULL as "No" # ?
	,NULL as "PAR Amt" # ?
	,NULL as "Arrears" # ?

	#if(datediff(curdate(), laa.overdue_since_date_derived) between 1 and 7, l.id, NULL)
		# what if laa.overdue_since_date_derived is NULL? datediff returns NULL. between 1 and 7 doesn't evaluate to true.

	,NULL as "No (1-7)"
	,NULL as "Arrears (1-7)"
	,NULL as "PAR Amt (1-7)"

	#if(datediff(curdate(), laa.overdue_since_date_derived) between 8 and 30, l.id, NULL)
	,NULL as "No (8-30)"
	,arrears_totals.a8 as "Arrears (8-30)"
	,NULL as "PAR Amt (8-30)"

	#if(datediff(curdate(), laa.overdue_since_date_derived) between 31 and 60, l.id, NULL)
	,NULL as "No (31-60)"
	,arrears_totals.a31 as "Arrears (31-60)"
	,NULL as "PAR Amt (31-60)"

	#if(datediff(curdate(), laa.overdue_since_date_derived) between 61 and 90, l.id, NULL)
	,NULL as "No (61-90)"
	,arrears_totals.a61 as "Arrears (61-90)"
	,NULL as "PAR Amt (61-90)"

	#if(datediff(curdate(), laa.overdue_since_date_derived) between 91 and 120, l.id, NULL)
	,NULL as "No (91-120)"
	,arrears_totals.a91 as "Arrears (91-120)"
	,NULL as "PAR Amt (91-120)"

	#if(datediff(curdate(), laa.overdue_since_date_derived) > 120, l.id, NULL)
	,NULL as "No (>120)"
	,arrears_totals.a120 as "Arrears (>120)"
	,NULL as "PAR Amt (>120)"

	,NULL as "No total" 
	,(arrears_totals.a8 + arrears_totals.a31 + arrears_totals.a61 + arrears_totals.a91 + arrears_totals.a120) as "ARREARS total"
	,arrears_totals.par as "PAR"

	from
    (
		select 
		(sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 8 and 30, laa.principal_overdue_derived, 0)) * .1) as a8
		,(sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 31 and 60, laa.principal_overdue_derived, 0)) * .25) as a31
		,(sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 61 and 90, laa.principal_overdue_derived, 0)) * .5) as a61
		,(sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 91 and 120, laa.principal_overdue_derived, 0) ) * .75) as a91
		,sum( if(datediff(curdate(), laa.overdue_since_date_derived) > 120, laa.principal_overdue_derived, 0) ) as a120
		,sum( if(datediff(curdate(), laa.overdue_since_date_derived) > 7, l.principal_outstanding_derived, 0) ) as par
        
		from m_loan as l #same from statement as the first table in the union, but not grouped
		left join m_client as c
			on c.id = l.client_id # so that I have no duplication of loans. *All loans have a client, some have same client.

		left join m_office as o 
			on o.id = c.office_id # All clients have office_id. So now each loan has an office_id.
			
		left join m_loan_arrears_aging as laa
			on l.id = laa.loan_id # not all loans have match an laa.
	) as arrears_totals
)
;