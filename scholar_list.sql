WITH
scholars AS (
    SELECT
        ioa_student_id AS sa_scholar_id,
        school_code AS school_name
    FROM dbt_staging.stg_scholar_enrollment_and_attrition_scholar_attrition_data_fpna
    WHERE school_year = '2021-2022'
),
cd_dup AS (
	SELECT
		sa_scholar_id,
		address,
		ROW_NUMBER() OVER (PARTITION BY sa_scholar_id ORDER BY address) AS dupcnt_cd
	FROM prod_scholar_contact.prod_scholar_contact_details
	WHERE sa_scholar_id IN (SELECT sa_scholar_id FROM scholars)
),
cd AS (
	SELECT 
		sa_scholar_id,
		address
	FROM cd_dup
	WHERE dupcnt_cd = 1
),
final AS (
    SELECT
        scholars.sa_scholar_id,
        school_name,
        address
    FROM scholars
        LEFT JOIN cd 
    ON scholars.sa_scholar_id = cd.sa_scholar_id
)
SELECT * FROM final