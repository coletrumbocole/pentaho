select
C.group_no as GroupNo
,L.state as "State"
,L.id as "Loan ID"
,C.display_name as "Client Name"
,L.ln_amount as LnAmount
,L.ln_type as "Ln Type"
,L.ln_bal as "Ln Bal"
,L.total_to_close as "Total to Close"
,L.term as "Term"
,L.repayment_week as "RW"
,L.prin_cd as "Prin (Current Due)"
,L.int_cd as "Int (Current Due)"
,L.delay as "Delay"
,L.prin_od as "Prin (Overdue)"
,L.int_od as "Int  (Overdue)"
,L.ln_pmts as "Ln Pmts"
,C.cf as "CF (Weekly Due)"
,C.gf as "GF (Weekly Due)"
,L.fee as "Fee/ Dayong"
,( ifnull(L.ln_pmts, 0) + ifnull(C.cf, 0) + ifnull(C.gf, 0) + ifnull(L.fee, 0) ) as "Total Due"
,C.ps_bal as "Ps Bal"

## leave the rest blank
,'' as "Ps Dep"
,'' as "Total Paid"
,'' as "Date"
,'' as "Slip"
,'' as "Cash"
,'' as "Total"
,'' as "Att"
,'' as "Rpt"
,'' as "Coo"
,'' as "Signature"

from  # all fields come from L or C. L has loan info, C has client info.
(
	select # will become L.  loan info - has each needed field from m_loan with calculated fields joined on.
		lr.client_id
        , lr.enum_value as state
        , lr.id
        , lr.principal_disbursed_derived as ln_amount
        , lr.loan_type_enum as ln_type
        , lr.principal_outstanding_derived as ln_bal
        , lr.total_outstanding_derived as total_to_close
        , concat( lr.term_frequency, " weeks") as term
		, timestampdiff(WEEK, lr.expected_firstrepaymenton_date, '${endDate}') as repayment_week
		, lr.prin_due as prin_cd
		, lr.int_due as int_cd 
		, concat(datediff('${endDate}', arr.overdue_since_date_derived), " days") as delay
		, arr.principal_overdue_derived as prin_od
		, arr.interest_overdue_derived as int_od
		, (ifnull(lr.prin_due, 0) + ifnull(lr.int_due, 0) + ifnull(arr.principal_overdue_derived, 0) + ifnull(arr.interest_overdue_derived, 0)) as ln_pmts
		, lr.fee as fee
		, '' as ps_bal
	from # lr
	(	select 
			* 
		from m_loan as l 
		
        left join
			(select 
				enum_value
                , enum_id 
			from r_enum_value 
			where enum_name = 'loan_status_id' ) as en 
			on l.loan_status_id = en.enum_id
        
        left join
			(select # will become r
				loan_id
				, duedate
				, (ifnull(principal_amount, 0) - ifnull(principal_completed_derived, 0) - ifnull(principal_writtenoff_derived, 0) ) as prin_due
				, (ifnull(interest_amount, 0) - ifnull(interest_completed_derived, 0) - ifnull(interest_writtenoff_derived, 0) - ifnull(interest_waived_derived, 0) ) as int_due
				, (ifnull(fee_charges_amount, 0) - ifnull(fee_charges_completed_derived, 0) - ifnull(fee_charges_writtenoff_derived, 0) - ifnull(fee_charges_waived_derived, 0) ) as fee
			from m_loan_repayment_schedule 
			where duedate between date_sub(curdate(), interval 6 day) and curdate() ) as r
			on r.loan_id = l.id
	) as lr
			
	left join # arr
		(select
			loan_id
			,ifnull(principal_overdue_derived, 0) as principal_overdue_derived
			,ifnull(interest_overdue_derived, 0) as interest_overdue_derived
			,ifnull(fee_charges_overdue_derived, 0) as fee_charges_overdue_derived
			,ifnull(penalty_charges_overdue_derived, 0) as penalty_charges_overdue_derived
			,ifnull(total_overdue_derived, 0) as total_overdue_derived
			,overdue_since_date_derived
        from m_loan_arrears_aging) as arr	
		on lr.id = arr.loan_id
    
) as L 

left join 

	(select 
		cl.cf
        ,30 as gf
		,cl.display_name
        ,cl.id
        ,sav.ps_bal
        , group_no
        , group_name
	from # cl - has all clients ids, display name, and no. of loans
		(select
			count(l.client_id) as cf
            ,c.display_name
            ,c.id
		from m_client c
		
		left join 
			(select 
				client_id 
			from m_loan ) as l
			on c.id = l.client_id 

		group by c.id ) as cl
    
    left join # sav - has client_id, ps_bal for every client whith a savings account. Do any clients have more than 1 savings account? None have a savings account
		(select 
			client_id
			,account_balance_derived as ps_bal
        from m_savings_account) as sav
		on sav.client_id = cl.id
        
	left join # group - has group_no, group_name for every client in a group.
		(select
			g.id as group_no
			,g.display_name as group_name
			,gc.client_id as client_id
		from m_group as g
		
		inner join m_group_client as gc
			on gc.group_id = g.id
			
		group by gc.client_id
		) as group_info
		on group_info.client_id = cl.id
) as C

on C.id = L.client_id

;


#########################################################################
	select # will become L.  loan info - has each needed field from m_loan with calculated fields joined on.
		lr.client_id
        , lr.enum_value as state
        , lr.id
        , lr.principal_disbursed_derived as ln_amount
        , lr.loan_type_enum as ln_type
        , lr.principal_outstanding_derived as ln_bal
        , lr.total_outstanding_derived as total_to_close
        , concat( lr.term_frequency, " weeks") as term
		, timestampdiff(WEEK, lr.expected_firstrepaymenton_date, '${endDate}') as repayment_week
		, lr.prin_due as prin_cd
		, lr.int_due as int_cd 
		, concat(datediff('${endDate}', arr.overdue_since_date_derived), " days") as delay
		, arr.principal_overdue_derived as prin_od
		, arr.interest_overdue_derived as int_od
		, (ifnull(lr.prin_due, 0) + ifnull(lr.int_due, 0) + ifnull(arr.principal_overdue_derived, 0) + ifnull(arr.interest_overdue_derived, 0)) as ln_pmts
		, lr.fee as fee
		, '' as ps_bal
	from # lr
	(	select 
			* 
		from m_loan as l 
		
        left join
			(select 
				enum_value
                , enum_id 
			from r_enum_value 
			where enum_name = 'loan_status_id' ) as en 
			on l.loan_status_id = en.enum_id
        
        left join
			(select # will become r
				loan_id
				, duedate
				, (ifnull(principal_amount, 0) - ifnull(principal_completed_derived, 0) - ifnull(principal_writtenoff_derived, 0) ) as prin_due
				, (ifnull(interest_amount, 0) - ifnull(interest_completed_derived, 0) - ifnull(interest_writtenoff_derived, 0) - ifnull(interest_waived_derived, 0) ) as int_due
				, (ifnull(fee_charges_amount, 0) - ifnull(fee_charges_completed_derived, 0) - ifnull(fee_charges_writtenoff_derived, 0) - ifnull(fee_charges_waived_derived, 0) ) as fee
			from m_loan_repayment_schedule 
			where duedate between date_sub(curdate(), interval 6 day) and curdate() ) as r
			on r.loan_id = l.id
	) as lr
			
	left join # arr
		(select
			loan_id
			,ifnull(principal_overdue_derived, 0) as principal_overdue_derived
			,ifnull(interest_overdue_derived, 0) as interest_overdue_derived
			,ifnull(fee_charges_overdue_derived, 0) as fee_charges_overdue_derived
			,ifnull(penalty_charges_overdue_derived, 0) as penalty_charges_overdue_derived
			,ifnull(total_overdue_derived, 0) as total_overdue_derived
			,overdue_since_date_derived
        from m_loan_arrears_aging) as arr	
		on lr.id = arr.loan_id
;








#############################################################



select 
			* 
		from m_loan as l 
		
        left join
			(select 
				enum_value
                , enum_id 
			from r_enum_value 
			where enum_name = 'loan_status_id' ) as en 
			on l.loan_status_id = en.enum_id
        
        left join
			(select # will become r
				loan_id
				, duedate
				, (ifnull(principal_amount, 0) - ifnull(principal_completed_derived, 0) - ifnull(principal_writtenoff_derived, 0) ) as prin_due
				, (ifnull(interest_amount, 0) - ifnull(interest_completed_derived, 0) - ifnull(interest_writtenoff_derived, 0) - ifnull(interest_waived_derived, 0) ) as int_due
				, (ifnull(fee_charges_amount, 0) - ifnull(fee_charges_completed_derived, 0) - ifnull(fee_charges_writtenoff_derived, 0) - ifnull(fee_charges_waived_derived, 0) ) as fee
			from m_loan_repayment_schedule 
			where duedate between date_sub(curdate(), interval 6 day) and curdate() ) as r
			on r.loan_id = l.id
;



###############################################################################


select 
	enum_value
	, enum_id 
from r_enum_value 
where enum_name = 'loan_status_id' 
;