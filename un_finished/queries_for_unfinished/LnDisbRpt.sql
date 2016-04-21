# loan disbursement with fees, 1 month. * I want to make it by branch, but the loans are not consistently assigned to an officer.

select 
	l.id as "No."
    ,display_name as "Client Name"
#Receipt  -  the check number
    ,tr.receipt_number as "Receipt"
    ,l.disbursedon_date as "Disbursement Date"
    ,p.`name` as "Ln Type"
    ,l.principal_disbursed_derived as "Ln Amount"
#GF5 - 5% group fund savings on the loan amount
    ,if( p.`name` = 'General Loan', (l.principal_disbursed_derived * .05), 0 ) as "GF5"
#SF - this is the 2% service charge on the loan amount
    ,(l.principal_disbursed_derived * .02) as "SF"
#CF - 1% center fund on the loan amount
    ,if( p.`name` = 'General Loan', (l.principal_disbursed_derived * .01), 0 ) as "CF"
#Ln Ins - 1% loan insurance (credit insurance) on the loan amount.
    ,(l.principal_disbursed_derived * .01) as "Ln Ins"
#FAI - 1% family accident insurance on the loan amount
    ,(l.principal_disbursed_derived * .01) as "FAI"
    ,if( p.`name` = 'General Loan', (l.principal_disbursed_derived * .1), (l.principal_disbursed_derived * .04) ) as "Total" # sum of gf5, sf, cf, ln ins, fai. x(.05)+x(.02)+x(.01)+x(.01)+x(.01) = x(.1)
    ,(l.principal_disbursed_derived) - if( p.`name` = 'General Loan', (l.principal_disbursed_derived * .1), (l.principal_disbursed_derived * .04) ) as "Net Amount" # Ln Amount - Total
    ,l.maturedon_date as "Due Date"
    ,l.term_frequency as "Term"
from m_loan as l 

left join  m_client as c
	on l.client_id = c.id # gets every loan, with its client. If more than one loan belongs to a client, the client is duplicated. *Every loan has client_id

left join m_product_loan as p
	on l.loan_type_enum = p.id # gets every product that matches a loan. *Every loan has a loan_type_enum

left join 
	(select
		distinct lt.loan_id as lt_loan_id
		,pd.receipt_number
	from m_loan_transaction as lt
	
	left join m_payment_detail pd 
		on lt.payment_detail_id = pd.id
	where transaction_type_enum =1) as tr
	on tr.lt_loan_id = l.id # joins every transaction that was a disbursement to the loans.
    # Note: r_enum_value tells us that Disbursements are any records in m_loan_transaction where transaction_type_enum = 1.

where l.disbursedon_date between date_sub(curdate(), interval 1 month) and curdate()
	#and branch is Quezon City 

union # total row

select 
	'' as "No."
    ,'TOTAL' as "Client Name"
    ,'' as "Receipt"
    ,'' as "Disbursement Date"
    ,'' as "Ln Type"
    ,sum(l.principal_disbursed_derived) as "Ln Amount"
    ,sum(if( p.`name` = 'General Loan', (l.principal_disbursed_derived * .05), 0 )) as "GF5"
    ,sum((l.principal_disbursed_derived * .02)) as "SF"
    ,sum(if( p.`name` = 'General Loan', (l.principal_disbursed_derived * .01), 0 )) as "CF"
    ,sum((l.principal_disbursed_derived * .01)) as "Ln Ins"
    ,sum((l.principal_disbursed_derived * .01)) as "FAI"
    ,sum( if( p.`name` = 'General Loan', (l.principal_disbursed_derived * .1), (l.principal_disbursed_derived * .04) ) ) as "Total" # sum of gf5, sf, cf, ln ins, fai. x(.05)+x(.02)+x(.01)+x(.01)+x(.01) = x(.1)     If not General Loan, x(.02)+x(.01)+x(.01) = x(.04)
    ,sum((l.principal_disbursed_derived) - if( p.`name` = 'General Loan', (l.principal_disbursed_derived * .1), (l.principal_disbursed_derived * .04) ) ) as "Net Amount" # Ln Amount - Total
    ,'' as "Due Date"
    ,'' as "Term"
from m_loan as l 
# matches the above from statement.
left join  m_client as c
	on l.client_id = c.id # gets every loan, with its client. If more than one loan belongs to a client, the client is duplicated

left join m_product_loan as p
	on l.loan_type_enum = p.id # gets every product that matches a loan

left join 
	(select
		distinct lt.loan_id as lt_loan_id
		,pd.receipt_number
	from m_loan_transaction lt
	
    left join m_payment_detail pd 
		on lt.payment_detail_id = pd.id
	where transaction_type_enum =1) as tr
	on tr.lt_loan_id = l.id # joins every transaction that was a disbursement to the loans.
where l.disbursedon_date between date_sub(curdate(), interval 1 month) and curdate()
	#and branch is Quezon City 
;