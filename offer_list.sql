SELECT
	sf_round_app_createddate AS create_date,
	pac.id AS round_app_application_id,
	phac.id AS hed_application_id,
	sf_round_app_name AS application_id,
	application_name,
	address__c AS address,
	apt__c AS apt,
	city,
	sf_student_zip_code AS zip_code,
	grade_applying_to,
	school_applying_to,
	best_offer_school,
	phac.priority_group_verbiage__c AS preference_structure_verbiage
FROM prod_scholar_acquisition_and_retention.prod_scholar_acquisition_and_retention_salesforce_app_offers_base base
LEFT JOIN salesforce_prod.prod_hed__application__c phac
	ON base.application_name = phac.name
LEFT JOIN salesforce_prod.prod_application__c pac
	ON base.sf_round_app_name = pac.name
WHERE (grade_applying_to IN ('5', '6') AND offer_bucket = 'Current Offer') OR (grade_applying_to IN ('K','1', '2', '3', '4') AND offer_bucket IN ('Past Offer', 'Current Offer'))