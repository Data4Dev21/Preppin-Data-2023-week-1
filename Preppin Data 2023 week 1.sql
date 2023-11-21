--This week we have had a report with a number of transactions that have not just our transactions but other banks' too.

--1.General Data Overview
select * 
    from "TIL_PLAYGROUND"."PREPPIN_DATA_INPUTS"."PD2023_WK01";

--Split the Transaction Code to extract the letters at the start of the transaction code and rename bank_code

select transaction_code
      ,split_part(transaction_code,'-',1) as bank_code
from "TIL_PLAYGROUND"."PREPPIN_DATA_INPUTS"."PD2023_WK01";

--2.Rename the values in the Online or In-person field, Online of the 1 values and In-Person for the 2 values. 

select case
       when online_or_in_person = 1 then 'Online'
       else 'In-person'
       end as online_or_in_person
       from "TIL_PLAYGROUND"."PREPPIN_DATA_INPUTS"."PD2023_WK01";
       
--3.Change the date to be the day of the week
select dayname(to_date(transaction_date, 'DD/MM/YYYY 00:00:00')) as day_of_the_week
       from "TIL_PLAYGROUND"."PREPPIN_DATA_INPUTS"."PD2023_WK01"; 
--NOTE!!! when Converting a date/datetime stored as varchar to date, the FORMAT must always match input not output.

--1,2 and 3
select transaction_code
      ,split_part(transaction_code,'-',1) as bank_code
      ,case
       when online_or_in_person = 1 then 'Online'
       else 'In-person'
       end as online_or_in_person,
       dayname(to_date(transaction_date, 'DD/MM/YYYY 00:00:00')) as day
    from "TIL_PLAYGROUND"."PREPPIN_DATA_INPUTS"."PD2023_WK01";

--4.Different levels of detail are required in the outputs. You will need to sum up the values of the transactions in three ways  

--4a.Total Values of Transactions by each bank
select  split_part(transaction_code,'-',1) as bank_code
       ,sum(value) as total_value
    from "TIL_PLAYGROUND"."PREPPIN_DATA_INPUTS"."PD2023_WK01"
    group by bank_code;
    
--4b.Total Values by Bank, Day of the Week and Type of Transaction (Online or In-Person)
select split_part(transaction_code,'-',1) as bank_code
      ,case
       when online_or_in_person = 1 then 'Online'
       else 'In-person'
       end as online_or_in_person,
       dayname(to_date(transaction_date, 'DD/MM/YYYY 00:00:00')) as day
      ,sum(value) as total_value
    from "TIL_PLAYGROUND"."PREPPIN_DATA_INPUTS"."PD2023_WK01"
    group by 1,2,3
    order by 4;
    
--4c.Total Values by Bank and Customer Code
select split_part(transaction_code,'-',1) as bank_code
      ,customer_code
      ,sum(value) as total_value
    from "TIL_PLAYGROUND"."PREPPIN_DATA_INPUTS"."PD2023_WK01"
    group by 1,2
    order by 3;



    

