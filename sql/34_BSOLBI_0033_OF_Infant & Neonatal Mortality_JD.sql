DROP TABLE IF EXISTS ##OF_InfantDeaths

USE EAT_Reporting_BSOL
select 
CONCAT (
		Left([DATE_OF_DEATH], 4)
		,Right([DATE_OF_DEATH], 2)
		) AS [TimePeriod]
	
,Demo.Ethnic_Code as [Ethnicity_Code]
,[LSOA_OF_RESIDENCE_CODE] as [LSOA2011]
,count(*) as Numerator

Into ##OF_InfantDeaths 

from [Other].[VwDeathsRegister] as DeathsReg
left join (select [Pseudo_NHS_Number], [Ethnic_Code],[GP_Code] from 
			[Demographic].[Ethnicity]
			--where Is_Deceased = 1
			) Demo
			on Demo.[Pseudo_NHS_Number] = DeathsReg.[PatientId]

where [DEC_AGECUNIT] != 1
and left([DATE_OF_DEATH],3) like '20[12]'
and [PatientId] is not NULL
group by  
CONCAT (		
		Left([DATE_OF_DEATH], 4)
		,Right([DATE_OF_DEATH], 2)
		) 
,Demo.Ethnic_Code
,[LSOA_OF_RESIDENCE_CODE]


DROP TABLE IF EXISTS ##OF_NeonatalDeaths
select 
CONCAT (
		Left([DATE_OF_DEATH], 4)
		,Right([DATE_OF_DEATH], 2)
		) AS [TimePeriod]
,Demo.Ethnic_Code as [Ethnicity_Code]
,[LSOA_OF_RESIDENCE_CODE] as [LSOA2011]
,count(*) as Numerator

Into ##OF_NeonatalDeaths

from [Other].[VwDeathsRegister]  as DeathsReg
left join (select [Pseudo_NHS_Number], [Ethnic_Code],[GP_Code] from 
			[Demographic].[Ethnicity]
			--where Is_Deceased = 1
			) Demo
			on Demo.[Pseudo_NHS_Number] = DeathsReg.[PatientId]

where [DEC_AGECUNIT] != 1
AND [NEO_NATE_FLAG] = 1
and left([DATE_OF_DEATH],3) like '20[12]'
and [PatientId] is not NULL
group by  
CONCAT (		
		Left([DATE_OF_DEATH], 4)
		,Right([DATE_OF_DEATH], 2)
		) 
,Demo.Ethnic_Code
,[LSOA_OF_RESIDENCE_CODE]


--Live Births for denominator
DROP TABLE IF EXISTS ##OF_LiveBirths

select 
count(*) as Denominator
,CONCAT (
		Left([Partial_Baby_DOB], 4)
		,Right([Partial_Baby_DOB], 2)
		) AS [TimePeriod]
,[LSOA_MOTHER] as [LSOA2011]
,[Ethnic_Code] as [Ethnicity_Code] 

Into ##OF_LiveBirths

from [Other].[vwBirths_Date_Of_Birth_Registration] act
-- imput ethnicity
left join (select [Pseudo_NHS_Number], [Ethnic_Code] from 
			[Demographic].[Ethnicity]
			) d
			on d.[Pseudo_NHS_Number] = act.[Baby_NHSNumber]

where left([Partial_Baby_DOB],3) like '20[12]'
-- check death lab
and Death_lab is null
and CANCELLED_FLAG='N'
group by  
CONCAT (
		Left([Partial_Baby_DOB], 4)
		,Right([Partial_Baby_DOB], 2)
		) 
,[LSOA_MOTHER]
,[Ethnic_Code]




--/*=================================================================================================
-- 92196 -Infant mortality rate - --Final data for Infant Deaths
--=================================================================================================*/

--INSERT INTO		[EAT_Reporting_BSOL].[OF].[IndicatorDataPredefinedDenominator] 

--(				[IndicatorID]
--,				[ReferenceID]
--,				[TimePeriod]
--,				[TimePeriodDesc]
----,				[GP_Practice]
----,				[PCN]
----,				[Locality_Reg]
--,				[Numerator]
--,				[Denominator]
--,				[Indicator_Level]
--,				[LSOA_2011]
--,				[LSOA_2021]
--,				[Ethnicity_Code]
--)

--(				SELECT
--				22													As [IndicatorID]
--,				'92196'												as [ReferenceID]
--,				COALESCE(LB.[TimePeriod], ID.[TimePeriod])			as [TimePeriod]
--,				'Month'												as TimePeriodDesc
----,				NULL												as GP_Code
----,				NULL												as PCN
----,				NULL												as Locality_Reg
--,				ID.[Numerator]										as [Numerator]
--,				LB.[Denominator]									as [Denominator]
--,				'Ward Level'										as IndicatorLevel
--,				COALESCE(LB.[LSOA2011], ID.[LSOA2011])				as LSOA2011
--				--Sloppy bodge; if counts in numerator but no counts in denominator (likely DQ issue anyway), no LSOA 2021 will map- so just use 2011 as minimal change. ? fix with cross apply?
--,				COALESCE(LSOA2011to2022.[LSOA11CD],ID.[LSOA2011])	AS LSOA2021
--,				COALESCE(LB.[Ethnicity_Code], ID.[Ethnicity_Code])	as [Ethnicity_Code]

--FROM			##OF_LiveBirths as LB

--FULL OUTER JOIN ##OF_InfantDeaths AS ID
--on				LB.[LSOA2011]=ID.[LSOA2011]
--AND				LB.[TimePeriod]=ID.[TimePeriod]
--AND				LB.[Ethnicity_Code]=ID.[Ethnicity_Code]

--LEFT JOIN		(SELECT [LSOA11CD]
--				,		[LSOA21CD]
--				FROM	[EAT_Reporting_BSOL].[Reference].[LSOA_2011_to_LSOA_2021]
--				) AS	LSOA2011to2022 ON LB.LSOA2011 = LSOA2011to2022.[LSOA11CD]

----ORDER BY		TimePeriod, Ethnicity_Code 

--)



--/*=================================================================================================
-- 92705 - Neonatal mortality rate --Final Data for Neonatal Deaths
--=================================================================================================*/

--INSERT INTO		[EAT_Reporting_BSOL].[OF].[IndicatorDataPredefinedDenominator] 

--(				[IndicatorID]
--,				[ReferenceID]
--,				[TimePeriod]
--,				[TimePeriodDesc]
----,				[GP_Practice]
----,				[PCN]
----,				[Locality_Reg]
--,				[Numerator]
--,				[Denominator]
--,				[Indicator_Level]
--,				[LSOA_2011]
--,				[LSOA_2021]
--,				[Ethnicity_Code]
--)

--(
--SELECT			33													As [IndicatorID]
--,				'92705'												as [ReferenceID]
--,				COALESCE(LB.[TimePeriod], ND.[TimePeriod])			as [TimePeriod]
--,				'Month'												as TimePeriodDesc
----,				NULL												as GP_Code
----,				NULL												as PCN
----,				NULL												as Locality_Reg
--,				ND.[Numerator]										as [Numerator]
--,				LB.[Denominator]									as [Denominator]
--,				'Ward Level'										as IndicatorLevel
--,				COALESCE(LB.[LSOA2011], ND.[LSOA2011])				as LSOA2011
----Sloppy bodge; if counts in numerator but no counts in denominator (likely DQ issue anyway), no LSOA 2021 will map- so just use 2011 as minimal change. ? fix with cross apply?
--,				COALESCE(LSOA2011to2022.[LSOA11CD],ND.[LSOA2011])	AS LSOA2021
--,				COALESCE(LB.[Ethnicity_Code], ND.[Ethnicity_Code])	as [Ethnicity_Code]

--FROM			##OF_LiveBirths as LB
--FULL OUTER JOIN ##OF_NeonatalDeaths AS ND
--on				LB.[LSOA2011]=ND.[LSOA2011]
--AND				LB.[TimePeriod]=ND.[TimePeriod]
--AND				LB.[Ethnicity_Code]=ND.[Ethnicity_Code]
--LEFT JOIN		(SELECT [LSOA11CD]
--				,		[LSOA21CD]
--				FROM	[EAT_Reporting_BSOL].[Reference].[LSOA_2011_to_LSOA_2021]
--				) AS LSOA2011to2022 ON LB.LSOA2011 = LSOA2011to2022.[LSOA11CD]
----ORDER BY TimePeriod, Ethnicity_Code 

--)