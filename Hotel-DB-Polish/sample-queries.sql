SELECT P.NR_POKOJU, P.LICZBA_MIEJSC, COUNT(R.ID_R)
FROM POKOJ P LEFT JOIN REZERWACJA R ON R.NR_POKOJU=P.NR_POKOJU
GROUP BY P.NR_POKOJU, P.LICZBA_MIEJSC
ORDER BY COUNT(R.ID_R) DESC, P.NR_POKOJU ASC;

SELECT P.PESEL_P, P.IMIE, P.NAZWISKO, P.STANOWISKO, COUNT(R.ID_R) AS LICZBA_REZERWACJI
FROM PRACOWNIK P INNER JOIN REZERWACJA R ON R.PESEL_P=P.PESEL_P
GROUP BY P.PESEL_P, P.IMIE, P.NAZWISKO, P.STANOWISKO
ORDER BY COUNT(R.ID_R) DESC;

SELECT P.ID_KP, KP.NAZWA_KLASY, COUNT(P.NR_POKOJU)
FROM POKOJ P INNER JOIN KLASA_POKOJU KP ON P.ID_KP=KP.ID_KP
GROUP BY P.ID_KP, KP.NAZWA_KLASY
ORDER BY COUNT(P.NR_POKOJU) DESC, P.ID_KP ASC;

SELECT R.PESEL_G, SUM(R.KWOTA)
FROM REZERWACJA R
GROUP BY R.PESEL_G;

SELECT ID_R, PESEL_G, PESEL_P, ID_KP, NR_POKOJU, DATA_OD, DATA_DO, KWOTA
FROM REZERWACJA
WHERE DATEDIFF(month, DATA_DO, now())<1;

SELECT U.ID_U, RU.NAZWA_USTERKI, U.NR_POKOJU, U.KOSZT_NAPRAWY
FROM USTERKA U INNER JOIN RODZAJ_USTERKI RU ON U.ID_RU=RU.ID_RU
WHERE U.CZY_NAPRAWIONA='N';

SELECT K.NR_KARTY, SUM(R.KWOTA)
FROM KARTA K INNER JOIN GOSC G ON G.PESEL_G=K.PESEL_G
    INNER JOIN REZERWACJA R ON R.PESEL_G=G.PESEL_G
    INNER JOIN PLATNOSC PL ON PL.ID_R=R.ID_R
WHERE PL.SPOSOB_PLATNOSCI='KARTA'
GROUP BY K.NR_KARTY;

SELECT TOP 1 NR_POKOJU, COUNT(NR_POKOJU)
FROM REZERWACJA R
GROUP BY NR_POKOJU
ORDER BY COUNT(NR_POKOJU) DESC;

SELECT TOP 3 P.PESEL_P, P.IMIE, P.NAZWISKO, P.STANOWISKO, COUNT(KP.ID_K)
FROM PRACOWNIK P INNER JOIN KWALIFIKACJE_PRACOWNIKA KP ON KP.PESEL_P=P.PESEL_P
GROUP BY P.PESEL_P, P.IMIE, P.NAZWISKO, P.STANOWISKO
ORDER BY COUNT(KP.ID_K) DESC;