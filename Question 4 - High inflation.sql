-- OTÁZKA 4: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

-- PRO SELECT NÍŽE JE JIŽ TŘEBA MÍT VYTVOŘENU POMOCNÉ TABULKY:
-- t_katerina_tersova_rocni_zmeny_mezd 
-- t_katerina_tersova_rocni_zmeny_cen
-- A PRIMÁRNÍ TABULKU t_katerina_tersova_project_sql_primary_final - viz. Tables / SQL_script_complete

SELECT 
	ceny.Rok, 
	ROUND(AVG(ceny.Roční_procentuální_změna), 2) AS Průměr_cen, 
	ROUND(AVG(mzdy.Roční_procentuální_změna), 2) AS Průměr_mezd,
	ROUND(AVG(ceny.Roční_procentuální_změna) - AVG(mzdy.Roční_procentuální_změna), 2) AS Rozdíl_mezd_a_cen
FROM t_katerina_tersova_rocni_zmeny_mezd AS mzdy
JOIN t_katerina_tersova_rocni_zmeny_cen AS ceny 
	ON mzdy.Rok = ceny.Rok 
GROUP BY ceny.Rok
ORDER BY Rozdíl_mezd_a_cen DESC
;

-- Vidím, že rozdíl větší než 10% nenastal v žádném roce. Nejblíže tomu byl rok 2013, kdy ceny potravin rostly o 6.78% rychleji, než mzdy. 
-- ODPOVĚĎ: Ne, neextuje rok, ve kterém by meziroční nárůst cen potravin byl o více než 10% vyšší, než růst mezd.
