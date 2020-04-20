with mimicToOmopPerson as (
  select distinct SUBJECT_ID as person_id from `mimic3_demo.DIAGNOSES_ICD` mimic3),
  mimicToOmopVisit as (
  select mimicToOmopPerson.person_id ,mimic3.HADM_ID as visit_occurance_id from mimicToOmopPerson 
  join `mimic3_demo.DIAGNOSES_ICD` mimic3 on mimicToOmopPerson.person_id = mimic3.SUBJECT_ID),
  mimicToOmopCondition as (
select mimicToOmopPerson.person_id ,mimic3.ICD9_CODE as condition_occurance_id from mimicToOmopPerson 
  join `mimic3_demo.DIAGNOSES_ICD` mimic3 on mimicToOmopPerson.person_id = mimic3.SUBJECT_ID), CONDITION_OCCURANCE as (
  select person.person_id, visit.visit_occurance_id, condition.condition_occurance_id from mimicToOmopPerson person inner join mimicToOmopVisit visit on person.person_id = visit.person_id inner join mimicToOmopCondition condition on visit.person_id = condition.person_id)

  select * from CONDITION_OCCURANCE;

-- --USEFUL STATEMENTS
-- select SUBJECT_ID, count(distinct HADM_ID) as CNT_DX
-- from `mimic3_demo.DIAGNOSES_ICD` 
-- group by SUBJECT_ID
-- order by count(distinct HADM_ID) desc