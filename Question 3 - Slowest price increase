-- OTÁZKA 3: Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

-- PRO OBA SELECTY NÍŽE JE TŘEBA VYTVOŘIT SI POMOCNOU TABULKU t_katerina_tersova_project_sql_primary_final - viz. Tables / SQL_script_complete

-- Nejprve si ověříme, že záznam pro každou kategorii potravin mám ve všech sledovaných obdobích:

SELECT 
	Produkt, 
	COUNT(Rok) AS 'Počet záznamů'
FROM t_katerina_tersova_project_sql_primary_final
GROUP BY Produkt
;

-- Vidíme tedy, že pro jakostní víno bílé nemáme všechny záznamy. Bude tedy lepší tento produkt z analýzy vyjmout.

-- PRO SELECT NÍŽE JE TŘEBA VYTVOŘIT SI POMOCNOU TABULKU t_katerina_tersova_rocni_zmeny_cen - viz. Tables / SQL_script_complete

SELECT 
	Produkt,
	MAX(Roční_procentuální_změna) + ABS(MIN(Roční_procentuální_změna)) AS Maximální_rozdíl_procenta,
	ROUND(AVG(Roční_procentuální_změna), 2) AS Průměrná_roční_změna_procenta
FROM t_katerina_tersova_rocni_zmeny_cen
GROUP BY Produkt
ORDER BY AVG(Roční_procentuální_změna)
;

-- ODPOVĚĎ: Otázka zní který produkt zdražuje nejpomaleji. Dalo by se tedy říct, že hledám nejnižší kladnou hodnotu 
-- průměné roční změny, což jsou Banány žluté (0.83%). Jsou nicméně dvě kategorie potravin - Cukr krystalový a Rajská 
-- jablka červená, které v průměru dokonce zlevňují. Cukr o 1,92%, Jablka o 0,75%.
