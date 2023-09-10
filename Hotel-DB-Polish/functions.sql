-- Funkcja 1: fTra_WydluzRezerwacje
CREATE FUNCTION "DBA"."fTra_WydluzRezerwacje"(IN @IN_ID_R INT, IN @IN_DNI INT)
RETURNS DATE
AS
BEGIN
	DECLARE @nowa_data DATE
	DECLARE @stara_data DATE
	
    BEGIN TRANSACTION
    IF (SELECT ID_R FROM REZERWACJA WHERE ID_R=@IN_ID_R) IS NULL -- przerywa transakcję, jeśli nie ma rezerwacji o podanym ID
        ROLLBACK

    SET @stara_data = (SELECT DATA_DO FROM REZERWACJA WHERE ID_R=@IN_ID_R)

    IF @@ERROR <> 0
        ROLLBACK

    SET @nowa_data = (SELECT DATEADD(day,@IN_DNI,@stara_data))
    IF @@ERROR <> 0
        ROLLBACK

    UPDATE REZERWACJA
    SET DATA_DO=@nowa_data
    WHERE ID_R=@IN_ID_R

    IF @@ERROR <> 0
        ROLLBACK
    ELSE
        COMMIT

	RETURN @nowa_data
END

-- Funkcja 2: fCzyAktualnaRezerwacja
CREATE FUNCTION "DBA"."fCzyAktualnaRezerwacja"(IN IN_NR_POKOJU INTEGER)
RETURNS VARCHAR(40)
AS
BEGIN
	DECLARE @RET VARCHAR(40)
    DECLARE @CZY_ZAJETY INT

    SET @CZY_ZAJETY=(SELECT COUNT(R.NR_POKOJU)
                     FROM REZERWACJA R
                     WHERE R.DATA_OD < now() AND R.DATA_DO > now()
                           AND R.NR_POKOJU=@IN_NR_POKOJU)

    IF @CZY_ZAJETY IS NULL OR @CZY_ZAJETY=0
        SET @RET='Pokój jest aktualnie wolny.'
    ELSE
        SET @RET='Pokój jest aktualnie zajęty.'

	RETURN @RET
END

-- Funkcja 3: fRaportOusterkach
CREATE FUNCTION "DBA"."fRaportOusterkach"()
RETURNS INTEGER
AS
BEGIN
	DECLARE @i INTEGER
    DECLARE @K_ID_RU INT
    DECLARE @K_ID_U INT
    DECLARE @K_NR_POKOJU INT
    DECLARE @K_KOSZT_NAPRAWY FLOAT(8)
    DECLARE @K_CZY_NAPRAWIONA CHAR(1)
    DECLARE @NAZWA_USTERKI CHAR(60)
    DECLARE @NAPRAWA CHAR(70)
    SET @i=0
	DECLARE KURSOR CURSOR FOR 
        SELECT U.ID_U, U.ID_RU, U.NR_POKOJU, U.KOSZT_NAPRAWY, U.CZY_NAPRAWIONA INTO @K_ID_U, @K_ID_RU, @K_NR_POKOJU, @K_KOSZT_NAPRAWY, @K_CZY_NAPRAWIONA
        FROM USTERKA U
        ORDER BY U.ID_U ASC

    OPEN KURSOR FETCH NEXT KURSOR INTO @K_ID_U, @K_ID_RU, @K_NR_POKOJU, @K_KOSZT_NAPRAWY, @K_CZY_NAPRAWIONA
    WHILE @@FETCH_STATUS=0
    BEGIN
        SET @i=@i+1
        IF @K_CZY_NAPRAWIONA='Y'
            SET @NAPRAWA='naprawiona.'
        ELSE
            SET @NAPRAWA='nienaprawiona.'
        SET @NAZWA_USTERKI = (SELECT RU.NAZWA_USTERKI FROM RODZAJ_USTERKI RU WHERE RU.ID_RU=@K_ID_RU)

        MESSAGE ''||@K_ID_U||'. Usterka: '||@NAZWA_USTERKI||'. W pokoju nr: '|| @K_NR_POKOJU||
                '. Koszt naprawy: '||'zł. Usterka jest: '||@NAPRAWA TO CLIENT
        FETCH NEXT KURSOR INTO @K_ID_U, @K_ID_RU, @K_NR_POKOJU, @K_KOSZT_NAPRAWY, @K_CZY_NAPRAWIONA
    END
	RETURN @i
END
