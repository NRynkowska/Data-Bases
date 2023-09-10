-- Trigger 1: czyPoprawneSamochod
CREATE TRIGGER "czyPoprawneSamochod" AFTER INSERT, UPDATE
ORDER 1 ON "DBA"."SAMOCHOD"
REFERENCING NEW AS NW
FOR EACH ROW
BEGIN
	IF LEN(NW.NR_REJSTRACYJNY) < 7 OR LEN(NW.NR_REJSTRACYJNY) > 8 THEN 
        RAISERROR 17011 'Wprowadzono nieprawidłowy NR REJESTRACYJNY.'
    END IF;
    IF LEN(NW.PESEL_G) <> 11 THEN
        RAISERROR 17012 'Wprowadzono nieprawidłowy PESEL.'
    END IF;
END

-- Trigger 2: czyPoprawnyTelefon

ALTER TRIGGER "czyPoprawnyTelefon" AFTER INSERT
ORDER 1 ON "DBA"."GOSC"
REFERENCING NEW AS NW
FOR EACH ROW
BEGIN
		IF LEN(NW.TELEFON) <> 9 THEN 
        RAISERROR 17011 'Wprowadzono nieprawidłowy nr telefonu.'
    END IF
END

-- Trigger 3: befKlientInfo

ALTER TRIGGER "befKlientInfo" BEFORE DELETE
ORDER 1 ON "DBA"."GOSC"
REFERENCING OLD AS OLDE
FOR EACH ROW
BEGIN
	DECLARE @ILE_REZ INTEGER;
    DECLARE @ILE_ZAPLACIL DECIMAL(8,2);

    SET ILE_REZ = (SELECT COUNT(R.ID_R)
                     FROM REZERWACJA R
                     WHERE R.PESEL_G = OLDE.PESEL_G);

    SET ILE_ZAPLACIL = (SELECT SUM(R.KWOTA)
                     FROM REZERWACJA R
                     WHERE R.PESEL_G = OLDE.PESEL_G
                     GROUP BY R.PESEL_G);

    DELETE FROM GOSC WHERE PESEL_G=OLDE.PESEL_G;
    DELETE FROM KARTA WHERE PSEL_G=OLDE.PESEL_G;

    MESSAGE 'Usunięty klient dotychczas złożył: '|| @ILE_REZ || ' rezerwacji.\n' TO CLIENT;
    MESSAGE 'Hotel zarobił na kliencie: '|| @ILE_ZAPLACIL || ' PLN.\n' TO CLIENT;
END



