-- PRŮMĚRNÉ CENY POTRTAVIN

CREATE OR REPLACE TABLE t_katerina_tersova_prices AS
	SELECT
		year(date_from) AS Rok,
		cpc.name AS Produkt,
		avg(value) AS Cena
	FROM czechia_price AS cp
	JOIN czechia_price_category AS cpc ON cp.category_code = cpc.code 
	WHERE cp.region_code IS NULL
	GROUP BY year(cp.date_from), cpc.name
;

-- PRŮMĚRNÉ PLATY ZA JEDNOTLIVÉ ROKY A ODBVĚTVÍ

CREATE OR REPLACE TABLE t_katerina_tersova_wages AS
	SELECT
		cp.payroll_year AS Rok,
		cpi.name AS Název_odvětví,
		cpi.code AS Kód_odvětví,
		AVG(cp.value) AS Průměrná_mzda
	FROM czechia_payroll cp 
	JOIN czechia_payroll_industry_branch cpi ON cp.industry_branch_code = cpi.code 
	WHERE industry_branch_code IS NOT NULL AND value_type_code = 5958 AND calculation_code = 100
	GROUP BY payroll_year, industry_branch_code
;

-- A NYNÍ SPOJENÍM TĚCHTO DVOU POMOCNÝCH TABULEK VYTVOŘÍM FINÁLNÍ 'PRIMARY TABLE'

CREATE OR REPLACE TABLE t_katerina_tersova_project_sql_primary_final AS
	SELECT
		tktp.*,
		tktw.Název_odvětví,
		tktw.Kód_odvětví,
		tktw.Průměrná_mzda
	FROM t_katerina_tersova_prices AS tktp
	JOIN t_katerina_tersova_wages AS tktw ON tktp.Rok = tktw.Rok
	JOIN economies eco ON tktp.Rok = eco.year AND eco.country = 'Czech Republic'
	ORDER BY tktp.Rok, tktw.Kód_odvětví
;

-- POMOCNÁ TABULKA PRO OTÁZKU Č. 3 - POMOCÍ CENY V PŘEDCHÁZEJÍCÍM ROCE VŮČI CENY V AKTUÁLNÍM ROCE SI ZOBRAZÍM 
-- MEZIROČNÍ PROCENTUÁLNÍ ZMĚNY V CENÁCH SLEDOVANÝCH PRODUKTŮ

CREATE OR REPLACE TABLE t_katerina_tersova_rocni_zmeny_cen AS 
SELECT 
	DISTINCT(tktf.Produkt),
	tktf.Rok,
	ROUND(tktf.Cena,2) AS Cena,
	ROUND(tktf2.Cena,2) AS Cena_v_předchozím_roce,
	ROUND(((tktf.Cena / tktf2.Cena) * 100)-100, 1) AS Roční_procentuální_změna
FROM t_katerina_tersova_project_sql_primary_final AS tktf 
JOIN t_katerina_tersova_project_sql_primary_final AS tktf2 ON tktf.Rok = tktf2.Rok + 1
WHERE tktf.Produkt = tktf2.Produkt
HAVING tktf.Produkt NOT LIKE 'Jakostní víno bílé'
ORDER BY tktf.Rok
;

-- POMOCNÁ TABULKA PRO OTÁZKU Č. 4 - STEJNĚ JAKO V PŘEDCHÁZEJÍCÍ TABULCE SI ZOBRAZÍM MEZIROČNÍ PROCENUTÁLNÍ ZMĚNY VE VÝŠI MEZD

CREATE OR REPLACE TABLE t_katerina_tersova_rocni_zmeny_mezd AS
SELECT
	Rok,
	Název_odvětví,
	Průměrná_mzda,
	LAG(Průměrná_mzda)
		OVER (PARTITION BY Kód_odvětví ORDER BY Rok) AS Mzda_v_předchozím_roce,
	ROUND((Průměrná_mzda / LAG(Průměrná_mzda)
		OVER (PARTITION BY Kód_odvětví ORDER BY Rok) * 100)-100, 1) AS Roční_procentuální_změna
FROM t_katerina_tersova_project_sql_primary_final AS tktf
GROUP BY Rok, Kód_odvětví
ORDER BY Rok, Název_odvětví
;

-- SEKUNÁDRNÍ TABULKA (NUTNÁ AŽ PRO OTÁZKU Č. 5)

CREATE OR REPLACE TABLE t_katerina_tersova_project_sql_secondary_final  AS
	SELECT 
		e.`year` AS Rok,	
		e.country AS Země,
		e.GDP AS HDP,
		e.population AS Počet_obyvatel,
		e.gini AS Giniho_koeficient
	FROM economies AS e
	JOIN countries AS c 
		ON e.country = c.country 
	WHERE gini IS NOT NULL AND 
		c.continent LIKE 'Europe'
	ORDER BY e.country, e.`year`
;
