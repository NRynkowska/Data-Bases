CREATE PROCEDURE "DBA"."dodajNowaRezerwacje"
( IN IN_PESEL_G VARCHAR(11), IN IN_PESEL_P VARCHAR(11), IN IN_NR_POKOJU INTEGER, IN IN_KWOTA FLOAT, IN IN_SP CHAR(10), IN IN_DATA_OD DATE, IN IN_DATA_DO DATE, IN IN_CZYFA CHAR(1), IN IN_NIP CHAR(20))
AS
BEGIN
    BEGIN TRANSACTION

    DECLARE @lastoneRez INTEGER
    DECLARE @lastonePL INTEGER
    DECLARE @klasapokoju INTEGER
    
    SET @lastoneRez=0
    SET @lastonePL=0

    IF (SELECT TOP 1 ID_R
        FROM REZERWACJA
        ORDER BY ID_R DESC) IS NOT NULL -- sprawdzamy, czy jakakolwiek rezerwacja istnieje (aby uniknąć problemu przy dodaniu pierwszej rezerwacji)
            SET @lastoneRez = (SELECT TOP 1 ID_R
                            FROM REZERWACJA
                            ORDER BY ID_R DESC)
    IF @@ERROR <> 0
        ROLLBACK

    IF (SELECT TOP 1 ID_PLATNOSCI
        FROM PLATNOSC
        ORDER BY ID_PLATNOSCI DESC) IS NOT NULL -- to samo co wyżej, tylko z płatnościami
            SET @lastonePL = (SELECT TOP 1 ID_PLATNOSCI
                             FROM PLATNOSC
                             ORDER BY ID_PLATNOSCI DESC)
     IF @@ERROR <> 0
        ROLLBACK

    SET @klasapokoju = (SELECT ID_KP
                        FROM POKOJ
                        WHERE NR_POKOJU=IN_NR_POKOJU)

    IF @@ERROR <> 0
        ROLLBACK
    SET @lastoneRez= @lastoneRez+1
    SET @lastonePL=@lastonePL+1
    INSERT REZERWACJA
    VALUES (@lastoneRez, IN_PESEL_G, IN_PESEL_P, @klasapokoju, IN_NR_POKOJU, IN_DATA_OD, IN_DATA_DO, IN_KWOTA)

    IF @@ERROR <> 0
        ROLLBACK

    INSERT PLATNOSC
    VALUES (@lastonePL, @lastoneRez, IN_SP, getdate(), IN_CZYFA, IN_NIP)
    
    IF @@ERROR <> 0
        ROLLBACK
    ELSE
        COMMIT
END


CREATE PROCEDURE "DBA"."pZamiana_dyzurow"( IN IN_ID_D INT, IN IN_PESEL_P1 VARCHAR(11), IN IN_PESEL_P2 VARCHAR(11))
AS
BEGIN

DECLARE @errorFlag integer
SET @errorFlag=0
IF (SELECT ID_D FROM DYZURY WHERE ID_D=@IN_ID_D) IS NULL
    SET @errorFlag=1

IF (SELECT PESEL_P FROM PRACOWNIK WHERE PESEL_P=@IN_PESEL_P1) IS NULL
    SET @errorFlag=1

IF (SELECT PESEL_P FROM PRACOWNIK WHERE PESEL_P=@IN_PESEL_P2) IS NULL
    SET @errorFlag=1

IF (SELECT ID_D FROM DYZURY WHERE ID_D=@IN_ID_D AND PESEL_P=@IN_PESEL_P1) IS NULL
    SET @errorFlag=1

IF @errorFlag=1
    RAISERROR 17015 'Wystąpił błąd, podano nieprawidłowe dane!'

UPDATE DYZURY
SET PESEL_P=@IN_PESEL_P2
WHERE ID_D=@IN_ID_D

END

CREATE PROCEDURE "DBA"."pOblicz_rabat"(IN IN_PESEL_G VARCHAR(11))
AS
BEGIN
	DECLARE @LICZBA_DNI INTEGER
    DECLARE @LICZBA_REZ INTEGER
    DECLARE @RABAT DECIMAL(4,2)

    SET @LICZBA_DNI = (SELECT SUM(DATEDIFF(DD, R.DATA_OD, R.DATA_DO))
                     FROM REZERWACJA R
                     WHERE R.PESEL_G = IN_PESEL_G
                     GROUP BY R.PESEL_G
                     ORDER BY SUM(DATEDIFF(DD, R.DATA_OD, R.DATA_DO)) )

    SET @LICZBA_REZ = (SELECT COUNT(R.ID_R)
                     FROM REZERWACJA R
                     WHERE R.PESEL_G = IN_PESEL_G)

    MESSAGE 'KLIENT O ID: ' || @IN_PESEL_G || '\n' TO CLIENT
    MESSAGE 'Dokonał dotychczas ' ||@LICZBA_REZ || ' rezerwacji \n' TO CLIENT
    MESSAGE 'o łącznej liczbie dni: ' ||@LICZBA_DNI || ' \n' TO CLIENT

    SET @RABAT = (
        CASE
        WHEN @LICZBA_DNI > 10 AND @LICZBA_DNI <=15 THEN 5
        WHEN @LICZBA_DNI > 15 AND @LICZBA_DNI <=25 THEN 10
        WHEN @LICZBA_DNI > 25 THEN 20
        END
    )
        
    CASE
        WHEN @LICZBA_DNI > 10 THEN MESSAGE 'RABAT W WYSOKOSCI: ' ||@RABAT|| ' PROCENT \n' TO CLIENT
        WHEN @LICZBA_DNI <= 10 OR @LICZBA_DNI IS NULL THEN MESSAGE 'BRAK RABATU \n' TO CLIENT
    END
END

