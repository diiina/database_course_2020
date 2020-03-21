WITH RECURSIVE
    CTE(DT) AS (
        SELECT MIN(CAST(BEGIN_DTTM AS DATE)) AS DT
        FROM SESSIONS
        UNION ALL
        SELECT DT + INTERVAL 1 DAY
        FROM CTE
        WHERE DT + INTERVAL 1 DAY <= (SELECT MAX(CAST(BEGIN_DTTM AS DATE)) FROM SESSIONS)
    ),
    DAU AS (
        SELECT CAST(SESSIONS.BEGIN_DTTM AS DATE) AS DT, COUNT(DISTINCT USER_ID) AS COUNT_USER
        FROM SESSIONS
        GROUP BY DT
    ),
    SUMM AS (
        SELECT CAST(PAYMENTS.PAYMENT_DTTM AS DATE) AS DT, SUM(PAYMENT_SUM) AS SUM
        FROM PAYMENTS
        GROUP BY DT
    )
SELECT CTE.DT, COALESCE(SUM, 0) / COALESCE(COUNT_USER, 1) AS PPU
FROM CTE
         LEFT JOIN DAU ON CTE.DT = DAU.DT
         LEFT JOIN SUMM ON CTE.DT = SUMM.DT;

/*
 2018-08-02	0
2018-08-03	0
2018-08-04	0
2018-08-05	0
2018-08-06	0
2018-08-07	451
2018-08-08	0
2018-08-09	0
2018-08-10	63.4
2018-08-11	54
2018-08-12	55
2018-08-13	0
2018-08-14	113.33333333333333
2018-08-15	248
2018-08-16	2.5454545454545454
2018-08-17	209
2018-08-18	64.53846153846153
2018-08-19	54.5
2018-08-20	63.5
2018-08-21	25.181818181818183
2018-08-22	0
2018-08-23	59.13333333333333
2018-08-24	158.92857142857142
2018-08-25	81.3076923076923
2018-08-26	0
2018-08-27	272.8333333333333
2018-08-28	158.4375
2018-08-29	38.357142857142854
2018-08-30	100.36842105263158
2018-08-31	50.76470588235294
2018-09-01	61.888888888888886
2018-09-02	15.45
2018-09-03	0
2018-09-04	68.625
2018-09-05	50
2018-09-06	115.78260869565217
2018-09-07	48.666666666666664
2018-09-08	112.125
2018-09-09	58.92307692307692
2018-09-10	96.88461538461539
2018-09-11	133.7391304347826
2018-09-12	87.76
2018-09-13	61.38461538461539
2018-09-14	59.916666666666664
2018-09-15	121.34482758620689
2018-09-16	172.2258064516129
2018-09-17	64.34615384615384
2018-09-18	23.333333333333332
2018-09-19	102.28125
2018-09-20	111.42857142857143
2018-09-21	124.41176470588235
2018-09-22	35.06666666666667
2018-09-23	114.59375
2018-09-24	211.74285714285713
2018-09-25	145.47368421052633
2018-09-26	342.7567567567568
2018-09-27	163.63888888888889
2018-09-28	321.6764705882353
2018-09-29	261.6666666666667
2018-09-30	326.9268292682927

 */