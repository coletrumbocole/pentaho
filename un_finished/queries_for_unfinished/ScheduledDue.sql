# A very lengthy query, because it is copied for each branch unioned with its total. Y

select #Antipolo
	o_s.branch as "Branch"
	,o_s.mentor as "Mentor"
	,count( distinct o_s.center) as "Center"
	,count( distinct c.id) as "Client Name"
	,sum(lrs.prin_due) as "Prin Due" # current principal
	,sum(lrs.int_due) as "Int Due" #current interest 
	,sum(laa.principal_overdue_derived) as "Arrears (prin)" # overdue principal
	,sum(laa.interest_overdue_derived) as "Arrears (int)" #overdue interest
from # every loan, its client name, branch, mentor, center, prin due, int due, arrears
m_loan as l

left join
	(select # will become lrs
		loan_id		
		, (ifnull(principal_amount, 0) - ifnull(principal_completed_derived, 0) - ifnull(principal_writtenoff_derived, 0) ) as prin_due
		, (ifnull(interest_amount, 0) - ifnull(interest_completed_derived, 0) - ifnull(interest_writtenoff_derived, 0) - ifnull(interest_waived_derived, 0) ) as int_due
	from m_loan_repayment_schedule 
	where duedate between date_sub(curdate(), interval 6 day) and curdate() 
    ) as lrs
    on l.id = lrs.loan_id # lrs.loan_id all unique.

left join m_loan_arrears_aging laa
	on l.id = laa.loan_id

left join m_client as c 
	on l.client_id = c.id # gives one client per loan because every c.id is unique, and every l.client_id is not null.
    
left join 
	(
	select
		o1.id as id,
        o1.`name` as center,
        ifnull(o2.`name`, o1.`name`) as branch,
		s.display_name as mentor
    from m_office as o1
    
    left join m_office as o2
		on o1.parent_id = o2.id
    
    left join m_staff as s on o1.id = s.office_id
	group by o1.id ) as o_s
    on o_s.id = c.office_id
# gives one office (with parent office, mentor) per client because every o.id is unique, and every c.office_id is not null.

where o_s.branch = "Head Office" # Antipolo

group by o_s.mentor

union #Antipolo total. this will be the same table as above, but not grouped, just counts and sums.
(
select
	o_s.branch as "Branch"
	,count( distinct o_s.mentor ) as "Mentor"
	,count( distinct o_s.center ) as "Center"
	,count( distinct c.id ) as "Client Name"
	,sum(lrs.prin_due) as "Prin Due" # current principal
	,sum(lrs.int_due) as "Int Due" #current interest 
	,sum(laa.principal_overdue_derived) as "Arrears (prin)" # overdue principal
	,sum(laa.interest_overdue_derived) as "Arrears (int)" #overdue interest
from # every loan, its client name, branch, mentor, center, prin due, int due, arrears
m_loan as l

left join
	(select # will become lrs
		loan_id		
		, (ifnull(principal_amount, 0) - ifnull(principal_completed_derived, 0) - ifnull(principal_writtenoff_derived, 0) ) as prin_due
		, (ifnull(interest_amount, 0) - ifnull(interest_completed_derived, 0) - ifnull(interest_writtenoff_derived, 0) - ifnull(interest_waived_derived, 0) ) as int_due
	from m_loan_repayment_schedule 
	where duedate between date_sub(curdate(), interval 6 day) and curdate() 
    ) as lrs
    on l.id = lrs.loan_id # lrs.loan_id all unique.

left join m_loan_arrears_aging laa
	on l.id = laa.loan_id

left join m_client as c 
	on l.client_id = c.id # gives one client per loan because every c.id is unique, and every l.client_id is not null.
    
left join 
	(
	select
		o1.id as id,
        o1.`name` as center,
        ifnull(o2.`name`, o1.`name`) as branch,
		s.display_name as mentor
    from m_office as o1
    
    left join m_office as o2
		on o1.parent_id = o2.id
    
    left join m_staff as s on o1.id = s.office_id
	group by o1.id ) as o_s
    on o_s.id = c.office_id
# gives one office (with parent office, mentor) per client because every o.id is unique, and every c.office_id is not null.

where o_s.branch = "Head Office" # would become Antipolo
)

union # Philippines. Would become Caloocan

(
select
	o_s.branch as "Branch"
	,o_s.mentor as "Mentor"
	,count( distinct o_s.center) as "Center"
	,count( distinct c.id) as "Client Name"
	,sum(lrs.prin_due) as "Prin Due" # current principal
	,sum(lrs.int_due) as "Int Due" #current interest 
	,sum(laa.principal_overdue_derived) as "Arrears (prin)" # overdue principal
	,sum(laa.interest_overdue_derived) as "Arrears (int)" #overdue interest
from # every loan, its client name, branch, mentor, center, prin due, int due, arrears
m_loan as l

left join
	(select # will become lrs
		loan_id		
		, (ifnull(principal_amount, 0) - ifnull(principal_completed_derived, 0) - ifnull(principal_writtenoff_derived, 0) ) as prin_due
		, (ifnull(interest_amount, 0) - ifnull(interest_completed_derived, 0) - ifnull(interest_writtenoff_derived, 0) - ifnull(interest_waived_derived, 0) ) as int_due
	from m_loan_repayment_schedule 
	where duedate between date_sub(curdate(), interval 6 day) and curdate() 
    ) as lrs
    on l.id = lrs.loan_id # lrs.loan_id all unique.

left join m_loan_arrears_aging laa
	on l.id = laa.loan_id

left join m_client as c 
	on l.client_id = c.id # gives one client per loan because every c.id is unique, and every l.client_id is not null.
    
left join 
	(
	select
		o1.id as id,
        o1.`name` as center,
        ifnull(o2.`name`, o1.`name`) as branch,
		s.display_name as mentor
    from m_office as o1
    
    left join m_office as o2
		on o1.parent_id = o2.id
    
    left join m_staff as s on o1.id = s.office_id
	group by o1.id ) as o_s
    on o_s.id = c.office_id
# gives one office (with parent office, mentor) per client because every o.id is unique, and every c.office_id is not null.

where o_s.branch = "Philippines" # Antipolo

group by o_s.mentor
)

union #Total. total

(
select
	o_s.branch as "Branch"
	,count( distinct o_s.mentor ) as "Mentor"
	,count( distinct o_s.center ) as "Center"
	,count( distinct c.id ) as "Client Name"
	,sum(lrs.prin_due) as "Prin Due" # current principal
	,sum(lrs.int_due) as "Int Due" #current interest 
	,sum(laa.principal_overdue_derived) as "Arrears (prin)" # overdue principal
	,sum(laa.interest_overdue_derived) as "Arrears (int)" #overdue interest
from # every loan, its client name, branch, mentor, center, prin due, int due, arrears
m_loan as l

left join
	(select # will become lrs
		loan_id		
		, (ifnull(principal_amount, 0) - ifnull(principal_completed_derived, 0) - ifnull(principal_writtenoff_derived, 0) ) as prin_due
		, (ifnull(interest_amount, 0) - ifnull(interest_completed_derived, 0) - ifnull(interest_writtenoff_derived, 0) - ifnull(interest_waived_derived, 0) ) as int_due
	from m_loan_repayment_schedule 
	where duedate between date_sub(curdate(), interval 6 day) and curdate() 
    ) as lrs
    on l.id = lrs.loan_id # lrs.loan_id all unique.

left join m_loan_arrears_aging laa
	on l.id = laa.loan_id

left join m_client as c 
	on l.client_id = c.id # gives one client per loan because every c.id is unique, and every l.client_id is not null.
    
left join 
	(
	select
		o1.id as id,
        o1.`name` as center,
        ifnull(o2.`name`, o1.`name`) as branch,
		s.display_name as mentor
    from m_office as o1
    
    left join m_office as o2
		on o1.parent_id = o2.id
    
    left join m_staff as s on o1.id = s.office_id
	group by o1.id ) as o_s
    on o_s.id = c.office_id
# gives one office (with parent office, mentor) per client because every o.id is unique, and every c.office_id is not null.

where o_s.branch = "Philippines" # Antipolo
)


union # Test

(
select
	o_s.branch as "Branch"
	,o_s.mentor as "Mentor"
	,count( distinct o_s.center) as "Center"
	,count( distinct c.id) as "Client Name"
	,sum(lrs.prin_due) as "Prin Due" # current principal
	,sum(lrs.int_due) as "Int Due" #current interest 
	,sum(laa.principal_overdue_derived) as "Arrears (prin)" # overdue principal
	,sum(laa.interest_overdue_derived) as "Arrears (int)" #overdue interest
from # every loan, its client name, branch, mentor, center, prin due, int due, arrears
m_loan as l

left join
	(select # will become lrs
		loan_id		
		, (ifnull(principal_amount, 0) - ifnull(principal_completed_derived, 0) - ifnull(principal_writtenoff_derived, 0) ) as prin_due
		, (ifnull(interest_amount, 0) - ifnull(interest_completed_derived, 0) - ifnull(interest_writtenoff_derived, 0) - ifnull(interest_waived_derived, 0) ) as int_due
	from m_loan_repayment_schedule 
	where duedate between date_sub(curdate(), interval 6 day) and curdate() 
    ) as lrs
    on l.id = lrs.loan_id # lrs.loan_id all unique.

left join m_loan_arrears_aging laa
	on l.id = laa.loan_id

left join m_client as c 
	on l.client_id = c.id # gives one client per loan because every c.id is unique, and every l.client_id is not null.
    
left join 
	(
	select
		o1.id as id,
        o1.`name` as center,
        ifnull(o2.`name`, o1.`name`) as branch,
		s.display_name as mentor
    from m_office as o1
    
    left join m_office as o2
		on o1.parent_id = o2.id
    
    left join m_staff as s on o1.id = s.office_id
	group by o1.id ) as o_s
    on o_s.id = c.office_id
# gives one office (with parent office, mentor) per client because every o.id is unique, and every c.office_id is not null.

where o_s.branch = "Test"

group by o_s.mentor
)

union #Total. total

(
select
	o_s.branch as "Branch"
	,count( distinct o_s.mentor ) as "Mentor"
	,count( distinct o_s.center ) as "Center"
	,count( distinct c.id ) as "Client Name"
	,sum(lrs.prin_due) as "Prin Due" # current principal
	,sum(lrs.int_due) as "Int Due" #current interest 
	,sum(laa.principal_overdue_derived) as "Arrears (prin)" # overdue principal
	,sum(laa.interest_overdue_derived) as "Arrears (int)" #overdue interest
from # every loan, its client name, branch, mentor, center, prin due, int due, arrears
m_loan as l

left join
	(select # will become lrs
		loan_id		
		, (ifnull(principal_amount, 0) - ifnull(principal_completed_derived, 0) - ifnull(principal_writtenoff_derived, 0) ) as prin_due
		, (ifnull(interest_amount, 0) - ifnull(interest_completed_derived, 0) - ifnull(interest_writtenoff_derived, 0) - ifnull(interest_waived_derived, 0) ) as int_due
	from m_loan_repayment_schedule 
	where duedate between date_sub(curdate(), interval 6 day) and curdate() 
    ) as lrs
    on l.id = lrs.loan_id # lrs.loan_id all unique.

left join m_loan_arrears_aging laa
	on l.id = laa.loan_id

left join m_client as c 
	on l.client_id = c.id # gives one client per loan because every c.id is unique, and every l.client_id is not null.
    
left join 
	(
	select
		o1.id as id,
        o1.`name` as center,
        ifnull(o2.`name`, o1.`name`) as branch,
		s.display_name as mentor
    from m_office as o1
    
    left join m_office as o2
		on o1.parent_id = o2.id
    
    left join m_staff as s on o1.id = s.office_id
	group by o1.id ) as o_s
    on o_s.id = c.office_id
# gives one office (with parent office, mentor) per client because every o.id is unique, and every c.office_id is not null.

where o_s.branch = "Test" 
)

union #Grand total. Doesn't have a where statement

(
select
	'Grand Total' as "Branch"
	,count( distinct o_s.mentor ) as "Mentor"
	,count( distinct o_s.center ) as "Center"
	,count( distinct c.id ) as "Client Name"
	,sum(lrs.prin_due) as "Prin Due" # current principal
	,sum(lrs.int_due) as "Int Due" #current interest 
	,sum(laa.principal_overdue_derived) as "Arrears (prin)" # overdue principal
	,sum(laa.interest_overdue_derived) as "Arrears (int)" #overdue interest
from # every loan, its client name, branch, mentor, center, prin due, int due, arrears
m_loan as l

left join
	(select # lrs
		loan_id		
		, (ifnull(principal_amount, 0) - ifnull(principal_completed_derived, 0) - ifnull(principal_writtenoff_derived, 0) ) as prin_due
		, (ifnull(interest_amount, 0) - ifnull(interest_completed_derived, 0) - ifnull(interest_writtenoff_derived, 0) - ifnull(interest_waived_derived, 0) ) as int_due
	from m_loan_repayment_schedule 
	where duedate between date_sub(curdate(), interval 6 day) and curdate() 
    ) as lrs
    on l.id = lrs.loan_id # lrs.loan_id all unique.

left join m_loan_arrears_aging laa
	on l.id = laa.loan_id

left join m_client as c 
	on l.client_id = c.id # gives one client per loan because every c.id is unique, and every l.client_id is not null.
    
left join 
	( # o_s
	select
		o1.id as id,
        o1.`name` as center,
        ifnull(o2.`name`, o1.`name`) as branch,
		s.display_name as mentor
    from m_office as o1
    
    left join m_office as o2
		on o1.parent_id = o2.id
    
    left join m_staff as s on o1.id = s.office_id
	group by o1.id ) as o_s
    on o_s.id = c.office_id
)
;
#Caloocan
#Caloocan total
#Davao
#Davao total
#Malabon
#Malabon total
#Mandaluyong
#Mandaluyong total
#Manila
#Manila total
#Parañaque
#Parañaque total
#Pasig
#Pasig total
#Quezon City
#Quezon City total
#San Jose del Monte
#San Jose del Monte total
#San Mateo
#San Mateo total
#Grand Total