/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */

/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_ATRAKCJA_ATRAKCJE__REZERWAC') then
    alter table ATRAKCJA
       delete foreign key FK_ATRAKCJA_ATRAKCJE__REZERWAC
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_DYZURY_DYZURY_PR_PRACOWNI') then
    alter table DYZURY
       delete foreign key FK_DYZURY_DYZURY_PR_PRACOWNI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_KARTA_KARTA_GOS_GOSC') then
    alter table KARTA
       delete foreign key FK_KARTA_KARTA_GOS_GOSC
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_KWALIFIK_KWALIFIKA_KWALIFIK') then
    alter table KWALIFIKACJE_PRACOWNIKA
       delete foreign key FK_KWALIFIK_KWALIFIKA_KWALIFIK
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_KWALIFIK_KWALIFIKA_PRACOWNI') then
    alter table KWALIFIKACJE_PRACOWNIKA
       delete foreign key FK_KWALIFIK_KWALIFIKA_PRACOWNI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PLATNOSC_PLATNOSC__REZERWAC') then
    alter table PLATNOSC
       delete foreign key FK_PLATNOSC_PLATNOSC__REZERWAC
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_POKOJ_JAKA_KLAS_KLASA_PO') then
    alter table POKOJ
       delete foreign key FK_POKOJ_JAKA_KLAS_KLASA_PO
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_REZERWAC_ODPOWIEDZ_PRACOWNI') then
    alter table REZERWACJA
       delete foreign key FK_REZERWAC_ODPOWIEDZ_PRACOWNI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_REZERWAC_POKOJ_W_R_POKOJ') then
    alter table REZERWACJA
       delete foreign key FK_REZERWAC_POKOJ_W_R_POKOJ
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_REZERWAC_REZERWACJ_GOSC') then
    alter table REZERWACJA
       delete foreign key FK_REZERWAC_REZERWACJ_GOSC
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_REZERWAC_REZERWACJ_PARKING') then
    alter table REZERWACJA_MIEJSCA
       delete foreign key FK_REZERWAC_REZERWACJ_PARKING
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_REZERWAC_REZERWACJ_SAMOCHOD') then
    alter table REZERWACJA_MIEJSCA
       delete foreign key FK_REZERWAC_REZERWACJ_SAMOCHOD
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SAMOCHOD_SAMOCHOD__GOSC') then
    alter table SAMOCHOD
       delete foreign key FK_SAMOCHOD_SAMOCHOD__GOSC
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_USTERKA_SZCZEGOLY_RODZAJ_U') then
    alter table USTERKA
       delete foreign key FK_USTERKA_SZCZEGOLY_RODZAJ_U
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_USTERKA_USTERKI_W_POKOJ') then
    alter table USTERKA
       delete foreign key FK_USTERKA_USTERKI_W_POKOJ
end if;

drop index if exists ATRAKCJA.ATRAKCJE_DLA_REZERWACJI_FK;

drop index if exists ATRAKCJA.ATRAKCJA_PK;

drop table if exists ATRAKCJA;

drop index if exists DYZURY.DYZURY_PRACOWNIKA_FK;

drop index if exists DYZURY.DYZURY_PK;

drop table if exists DYZURY;

drop index if exists GOSC.GO  _PK;

drop table if exists GOSC;

drop index if exists KARTA.KARTA_GOSCIA_FK;

drop index if exists KARTA.KARTA_PK;

drop table if exists KARTA;

drop index if exists KLASA_POKOJU.KLASA_POKOJU_PK;

drop table if exists KLASA_POKOJU;

drop index if exists KWALIFIKACJE.KWALIFIKACJE_PK;

drop table if exists KWALIFIKACJE;

drop index if exists KWALIFIKACJE_PRACOWNIKA.KWALIFIKACJE_PRACOWNIKA2_FK;

drop index if exists KWALIFIKACJE_PRACOWNIKA.KWALIFIKACJE_PRACOWNIKA_FK;

drop index if exists KWALIFIKACJE_PRACOWNIKA.KWALIFIKACJE_PRACOWNIKA_PK;

drop table if exists KWALIFIKACJE_PRACOWNIKA;

drop index if exists PARKING.PARKING_PK;

drop table if exists PARKING;

drop index if exists PLATNOSC.PLATNOSC_ZA_REZERWACJE_FK;

drop index if exists PLATNOSC.P ATNO  _PK;

drop table if exists PLATNOSC;

drop index if exists POKOJ.JAKA_KLASA_FK;

drop index if exists POKOJ.POK J_PK;

drop table if exists POKOJ;

drop index if exists PRACOWNIK.PRACOWNIK_PK;

drop table if exists PRACOWNIK;

drop index if exists REZERWACJA.REZERWACJA_GOSCIA_FK;

drop index if exists REZERWACJA.ODPOWIEDZIALNY_PRACOWNIK_FK;

drop index if exists REZERWACJA.REZERWACJA_PK;

drop table if exists REZERWACJA;

drop index if exists REZERWACJA_MIEJSCA.REZERWACJA_MIEJSCA2_FK;

drop index if exists REZERWACJA_MIEJSCA.REZERWACJA_MIEJSCA_FK;

drop index if exists REZERWACJA_MIEJSCA.REZERWACJA_MIEJSCA_PK;

drop table if exists REZERWACJA_MIEJSCA;

drop index if exists RODZAJ_USTERKI.RODZAJ_USTERKI_PK;

drop table if exists RODZAJ_USTERKI;

drop index if exists SAMOCHOD.SAMOCHOD_GOSCIA_FK;

drop index if exists SAMOCHOD.SAMOCH D_PK;

drop table if exists SAMOCHOD;

drop index if exists USTERKA.USTERKI_W_POKOJU_FK;

drop index if exists USTERKA.SZCZEGOLY_USTERKI_FK;

drop index if exists USTERKA.USTERKA_PK;

drop table if exists USTERKA;

/*==============================================================*/
/* Table: ATRAKCJA                                              */
/*==============================================================*/
create table ATRAKCJA 
(
   ID_A                 integer                        not null,
   ID_R                 integer                        not null,
   NAZWA_ATRAKCJI       char(60)                       not null,
   MIEJSCE              varchar(60)                    not null,
   CENA                 float(8)                       not null,
   constraint PK_ATRAKCJA primary key (ID_A)
);

/*==============================================================*/
/* Index: ATRAKCJA_PK                                           */
/*==============================================================*/
create unique index ATRAKCJA_PK on ATRAKCJA (
ID_A ASC
);

/*==============================================================*/
/* Index: ATRAKCJE_DLA_REZERWACJI_FK                            */
/*==============================================================*/
create index ATRAKCJE_DLA_REZERWACJI_FK on ATRAKCJA (
ID_R ASC
);

/*==============================================================*/
/* Table: DYZURY                                                */
/*==============================================================*/
create table DYZURY 
(
   ID_D                 integer                        not null,
   PESEL_P              varchar(11)                    null,
   DATA                 date                           not null,
   GODZINA_OD           time                           not null,
   GODZINA_DO           time                           null,
   constraint PK_DYZURY primary key (ID_D)
);

comment on table DYZURY is 
'Encja okre la informacje dotycz ce dy uru.';

/*==============================================================*/
/* Index: DYZURY_PK                                             */
/*==============================================================*/
create unique index DYZURY_PK on DYZURY (
ID_D ASC
);

/*==============================================================*/
/* Index: DYZURY_PRACOWNIKA_FK                                  */
/*==============================================================*/
create index DYZURY_PRACOWNIKA_FK on DYZURY (
PESEL_P ASC
);

/*==============================================================*/
/* Table: GOSC                                                  */
/*==============================================================*/
create table GOSC 
(
   PESEL_G              varchar(11)                    not null,
   IMIE                 char(30)                       not null,
   NAZWISKO             char(30)                       not null,
   TELEFON              varchar(9)                     not null,
   constraint PK_GOSC primary key (PESEL_G)
);

/*==============================================================*/
/* Index: GO  _PK                                               */
/*==============================================================*/
create unique index GO  _PK on GOSC (
PESEL_G ASC
);

/*==============================================================*/
/* Table: KARTA                                                 */
/*==============================================================*/
create table KARTA 
(
   NR_KARTY             varchar(8)                     not null,
   PESEL_G              varchar(11)                    null,
   constraint PK_KARTA primary key (NR_KARTY)
);

/*==============================================================*/
/* Index: KARTA_PK                                              */
/*==============================================================*/
create unique index KARTA_PK on KARTA (
NR_KARTY ASC
);

/*==============================================================*/
/* Index: KARTA_GOSCIA_FK                                       */
/*==============================================================*/
create index KARTA_GOSCIA_FK on KARTA (
PESEL_G ASC
);

/*==============================================================*/
/* Table: KLASA_POKOJU                                          */
/*==============================================================*/
create table KLASA_POKOJU 
(
   ID_KP                integer                        not null,
   NAZWA_KLASY          varchar(60)                    not null,
   POZIOM_KLASY         integer                        not null default 1
   	constraint CKC_POZIOM_KLASY_KLASA_PO check (POZIOM_KLASY in (1,2,3,4)),
   constraint PK_KLASA_POKOJU primary key (ID_KP)
);

comment on table KLASA_POKOJU is 
'Encja okre la informacje dotycz ce jako ci pokoju.';

comment on column KLASA_POKOJU.POZIOM_KLASY is 
'Mo e przyjmowa  warto ci:
1 - klasa ekonomiczna,
2 - klasa wy sza,
3 - klasa premium,
4 - klasa kr lewska.';

/*==============================================================*/
/* Index: KLASA_POKOJU_PK                                       */
/*==============================================================*/
create unique index KLASA_POKOJU_PK on KLASA_POKOJU (
ID_KP ASC
);

/*==============================================================*/
/* Table: KWALIFIKACJE                                          */
/*==============================================================*/
create table KWALIFIKACJE 
(
   ID_K                 varchar(30)                    not null,
   NAZWA_KWALIFIKACJI   char(60)                       not null,
   constraint PK_KWALIFIKACJE primary key (ID_K)
);

comment on table KWALIFIKACJE is 
'Encja okre la informacje dotycz ce kwalifikacji pracownik w.';

/*==============================================================*/
/* Index: KWALIFIKACJE_PK                                       */
/*==============================================================*/
create unique index KWALIFIKACJE_PK on KWALIFIKACJE (
ID_K ASC
);

/*==============================================================*/
/* Table: KWALIFIKACJE_PRACOWNIKA                               */
/*==============================================================*/
create table KWALIFIKACJE_PRACOWNIKA 
(
   ID_K                 varchar(30)                    not null,
   PESEL_P              varchar(11)                    not null,
   constraint PK_KWALIFIKACJE_PRACOWNIKA primary key clustered (ID_K, PESEL_P)
);

comment on table KWALIFIKACJE_PRACOWNIKA is 
'Relacja okre la jakie kwalifikacje posiada pracownik.';

/*==============================================================*/
/* Index: KWALIFIKACJE_PRACOWNIKA_PK                            */
/*==============================================================*/
create unique index KWALIFIKACJE_PRACOWNIKA_PK on KWALIFIKACJE_PRACOWNIKA (
ID_K ASC,
PESEL_P ASC
);

/*==============================================================*/
/* Index: KWALIFIKACJE_PRACOWNIKA_FK                            */
/*==============================================================*/
create index KWALIFIKACJE_PRACOWNIKA_FK on KWALIFIKACJE_PRACOWNIKA (
ID_K ASC
);

/*==============================================================*/
/* Index: KWALIFIKACJE_PRACOWNIKA2_FK                           */
/*==============================================================*/
create index KWALIFIKACJE_PRACOWNIKA2_FK on KWALIFIKACJE_PRACOWNIKA (
PESEL_P ASC
);

/*==============================================================*/
/* Table: PARKING                                               */
/*==============================================================*/
create table PARKING 
(
   NR_MIEJSCA           integer                        not null,
   constraint PK_PARKING primary key (NR_MIEJSCA)
);

/*==============================================================*/
/* Index: PARKING_PK                                            */
/*==============================================================*/
create unique index PARKING_PK on PARKING (
NR_MIEJSCA ASC
);

/*==============================================================*/
/* Table: PLATNOSC                                              */
/*==============================================================*/
create table PLATNOSC 
(
   ID_PLATNOSCI         integer                        not null,
   ID_R                 integer                        not null,
   SPOSOB_PLATNOSCI     char(10)                       not null default 'GOTOWKA'
   	constraint CKC_SPOSOB_PLATNOSCI_PLATNOSC check (SPOSOB_PLATNOSCI in ('GOTOWKA','KARTA','BON')),
   DATA_PLATNOSCI       date                           not null,
   CZY_FAKTURA          char(1)                        null default 'N'
   	constraint CKC_CZY_FAKTURA_PLATNOSC check (CZY_FAKTURA is null or (CZY_FAKTURA in ('Y','N') and CZY_FAKTURA = upper(CZY_FAKTURA))),
   NIP                  char(20)                       null,
   constraint PK_PLATNOSC primary key (ID_PLATNOSCI)
);

comment on column PLATNOSC.SPOSOB_PLATNOSCI is 
'Przyjmuje trzy dozwolone argumenty: KARTA, GOTOWKA, BON. Okre la czym zap acono za rezerwacje.';

comment on column PLATNOSC.CZY_FAKTURA is 
'Warto   Y okresla,  e faktura zosta a wydana, warto   N,  e oby o si  bez faktury.';

comment on column PLATNOSC.NIP is 
'Je li faktura by a wydana, okre lony jest NIP na jaki zosta a wystawiona.';

/*==============================================================*/
/* Index: P ATNO  _PK                                           */
/*==============================================================*/
create unique index P ATNO  _PK on PLATNOSC (
ID_PLATNOSCI ASC
);

/*==============================================================*/
/* Index: PLATNOSC_ZA_REZERWACJE_FK                             */
/*==============================================================*/
create index PLATNOSC_ZA_REZERWACJE_FK on PLATNOSC (
ID_R ASC
);

/*==============================================================*/
/* Table: POKOJ                                                 */
/*==============================================================*/
create table POKOJ 
(
   ID_KP                integer                        not null,
   NR_POKOJU            integer                        not null,
   LICZBA_MIEJSC        integer                        not null,
   NR_PIETRA            integer                        null,
   constraint PK_POKOJ primary key (ID_KP, NR_POKOJU)
);

comment on table POKOJ is 
'Encja okre la informacje dotycz ce pokoj w.';

/*==============================================================*/
/* Index: POK J_PK                                              */
/*==============================================================*/
create unique index POK J_PK on POKOJ (
ID_KP ASC,
NR_POKOJU ASC
);

/*==============================================================*/
/* Index: JAKA_KLASA_FK                                         */
/*==============================================================*/
create index JAKA_KLASA_FK on POKOJ (
ID_KP ASC
);

/*==============================================================*/
/* Table: PRACOWNIK                                             */
/*==============================================================*/
create table PRACOWNIK 
(
   PESEL_P              varchar(11)                    not null,
   IMIE                 char(30)                       not null,
   NAZWISKO             char(30)                       not null,
   ULICA                char(30)                       not null,
   NR_DOMU              varchar(10)                    not null,
   MIEJSCOWOSC          char(30)                       not null,
   TELEFON              varchar(9)                     not null,
   STANOWISKO           char(30)                       null,
   constraint PK_PRACOWNIK primary key (PESEL_P)
);

comment on table PRACOWNIK is 
'Encja okre la informacje dotycz ce pracownik w.';

/*==============================================================*/
/* Index: PRACOWNIK_PK                                          */
/*==============================================================*/
create unique index PRACOWNIK_PK on PRACOWNIK (
PESEL_P ASC
);

/*==============================================================*/
/* Table: REZERWACJA                                            */
/*==============================================================*/
create table REZERWACJA 
(
   ID_R                 integer                        not null,
   PESEL_G              varchar(11)                    not null,
   PESEL_P              varchar(11)                    null,
   ID_KP                integer                        not null,
   NR_POKOJU            integer                        not null,
   DATA_OD              date                           not null,
   DATA_DO              date                           not null,
   KWOTA                float(8)                       not null,
   constraint PK_REZERWACJA primary key (ID_R)
);

/*==============================================================*/
/* Index: REZERWACJA_PK                                         */
/*==============================================================*/
create unique index REZERWACJA_PK on REZERWACJA (
ID_R ASC
);

/*==============================================================*/
/* Index: ODPOWIEDZIALNY_PRACOWNIK_FK                           */
/*==============================================================*/
create index ODPOWIEDZIALNY_PRACOWNIK_FK on REZERWACJA (
PESEL_P ASC
);

/*==============================================================*/
/* Index: REZERWACJA_GOSCIA_FK                                  */
/*==============================================================*/
create index REZERWACJA_GOSCIA_FK on REZERWACJA (
PESEL_G ASC
);

/*==============================================================*/
/* Table: REZERWACJA_MIEJSCA                                    */
/*==============================================================*/
create table REZERWACJA_MIEJSCA 
(
   NR_MIEJSCA           integer                        not null,
   NR_REJSTRACYJNY      varchar(8)                     not null,
   OD_KIEDY             date                           null,
   DO_KIEDY             date                           null,
   constraint PK_REZERWACJA_MIEJSCA primary key clustered (NR_MIEJSCA, NR_REJSTRACYJNY)
);

comment on table REZERWACJA_MIEJSCA is 
'Odpowiada za zarezerwowanie miejsca parkingowego.';

/*==============================================================*/
/* Index: REZERWACJA_MIEJSCA_PK                                 */
/*==============================================================*/
create unique index REZERWACJA_MIEJSCA_PK on REZERWACJA_MIEJSCA (
NR_MIEJSCA ASC,
NR_REJSTRACYJNY ASC
);

/*==============================================================*/
/* Index: REZERWACJA_MIEJSCA_FK                                 */
/*==============================================================*/
create index REZERWACJA_MIEJSCA_FK on REZERWACJA_MIEJSCA (
NR_MIEJSCA ASC
);

/*==============================================================*/
/* Index: REZERWACJA_MIEJSCA2_FK                                */
/*==============================================================*/
create index REZERWACJA_MIEJSCA2_FK on REZERWACJA_MIEJSCA (
NR_REJSTRACYJNY ASC
);

/*==============================================================*/
/* Table: RODZAJ_USTERKI                                        */
/*==============================================================*/
create table RODZAJ_USTERKI 
(
   ID_RU                integer                        not null,
   NAZWA_USTERKI        char(60)                       not null,
   constraint PK_RODZAJ_USTERKI primary key (ID_RU)
);

comment on table RODZAJ_USTERKI is 
'Encja okre la informacje dotycz ce rodzaj w usterek.';

/*==============================================================*/
/* Index: RODZAJ_USTERKI_PK                                     */
/*==============================================================*/
create unique index RODZAJ_USTERKI_PK on RODZAJ_USTERKI (
ID_RU ASC
);

/*==============================================================*/
/* Table: SAMOCHOD                                              */
/*==============================================================*/
create table SAMOCHOD 
(
   NR_REJSTRACYJNY      varchar(8)                     not null,
   PESEL_G              varchar(11)                    not null,
   MARKA                varchar(30)                    not null,
   constraint PK_SAMOCHOD primary key (NR_REJSTRACYJNY)
);

/*==============================================================*/
/* Index: SAMOCH D_PK                                           */
/*==============================================================*/
create unique index SAMOCH D_PK on SAMOCHOD (
NR_REJSTRACYJNY ASC
);

/*==============================================================*/
/* Index: SAMOCHOD_GOSCIA_FK                                    */
/*==============================================================*/
create index SAMOCHOD_GOSCIA_FK on SAMOCHOD (
PESEL_G ASC
);

/*==============================================================*/
/* Table: USTERKA                                               */
/*==============================================================*/
create table USTERKA 
(
   ID_RU                integer                        not null,
   ID_U                 integer                        not null,
   ID_KP                integer                        not null,
   NR_POKOJU            integer                        not null,
   KOSZT_NAPRAWY        float(8)                       not null,
   CZY_NAPRAWIONA       char(1)                        not null default 'N'
   	constraint CKC_CZY_NAPRAWIONA_USTERKA check (CZY_NAPRAWIONA in ('Y','N')),
   constraint PK_USTERKA primary key (ID_RU, ID_U)
);

comment on table USTERKA is 
'Encja okre la informacje dotycz ce usterki, kt ra jest lub by a.';

comment on column USTERKA.CZY_NAPRAWIONA is 
'Je li Y, to usterka ju  naprawiona. Je li N, to usterka nadal wyst puje.';

/*==============================================================*/
/* Index: USTERKA_PK                                            */
/*==============================================================*/
create unique index USTERKA_PK on USTERKA (
ID_RU ASC,
ID_U ASC
);

/*==============================================================*/
/* Index: SZCZEGOLY_USTERKI_FK                                  */
/*==============================================================*/
create index SZCZEGOLY_USTERKI_FK on USTERKA (
ID_RU ASC
);

/*==============================================================*/
/* Index: USTERKI_W_POKOJU_FK                                   */
/*==============================================================*/
create index USTERKI_W_POKOJU_FK on USTERKA (
ID_KP ASC,
NR_POKOJU ASC
);

alter table ATRAKCJA
   add constraint FK_ATRAKCJA_ATRAKCJE__REZERWAC foreign key (ID_R)
      references REZERWACJA (ID_R)
      on update restrict
      on delete restrict;

comment on foreign key ATRAKCJA.FK_ATRAKCJA_ATRAKCJE__REZERWAC is 
'Relacja okre la jakie atrakcje zosta y dokupione do rezerwacji.';

alter table DYZURY
   add constraint FK_DYZURY_DYZURY_PR_PRACOWNI foreign key (PESEL_P)
      references PRACOWNIK (PESEL_P)
      on update restrict
      on delete restrict;

comment on foreign key DYZURY.FK_DYZURY_DYZURY_PR_PRACOWNI is 
'Relacja okre la kiedy pracownik pe ni dy ur.';

alter table KARTA
   add constraint FK_KARTA_KARTA_GOS_GOSC foreign key (PESEL_G)
      references GOSC (PESEL_G)
      on update restrict
      on delete restrict;

alter table KWALIFIKACJE_PRACOWNIKA
   add constraint FK_KWALIFIK_KWALIFIKA_KWALIFIK foreign key (ID_K)
      references KWALIFIKACJE (ID_K)
      on update restrict
      on delete restrict;

comment on foreign key KWALIFIKACJE_PRACOWNIKA.FK_KWALIFIK_KWALIFIKA_KWALIFIK is 
'Relacja okre la jakie kwalifikacje posiada pracownik.';

alter table KWALIFIKACJE_PRACOWNIKA
   add constraint FK_KWALIFIK_KWALIFIKA_PRACOWNI foreign key (PESEL_P)
      references PRACOWNIK (PESEL_P)
      on update restrict
      on delete restrict;

comment on foreign key KWALIFIKACJE_PRACOWNIKA.FK_KWALIFIK_KWALIFIKA_PRACOWNI is 
'Relacja okre la jakie kwalifikacje posiada pracownik.';

alter table PLATNOSC
   add constraint FK_PLATNOSC_PLATNOSC__REZERWAC foreign key (ID_R)
      references REZERWACJA (ID_R)
      on update restrict
      on delete restrict;

comment on foreign key PLATNOSC.FK_PLATNOSC_PLATNOSC__REZERWAC is 
'Encja okre la p atno   za rezerwacj .';

alter table POKOJ
   add constraint FK_POKOJ_JAKA_KLAS_KLASA_PO foreign key (ID_KP)
      references KLASA_POKOJU (ID_KP)
      on update restrict
      on delete restrict;

comment on foreign key POKOJ.FK_POKOJ_JAKA_KLAS_KLASA_PO is 
'Relacja okre la jakiej klasy jest dany pok j.';

alter table REZERWACJA
   add constraint FK_REZERWAC_ODPOWIEDZ_PRACOWNI foreign key (PESEL_P)
      references PRACOWNIK (PESEL_P)
      on update restrict
      on delete restrict;

comment on foreign key REZERWACJA.FK_REZERWAC_ODPOWIEDZ_PRACOWNI is 
'Relacja okre la jaki pracownik jest odpowiedzialny za dan  rezerwacj .';

alter table REZERWACJA
   add constraint FK_REZERWAC_POKOJ_W_R_POKOJ foreign key (ID_KP, NR_POKOJU)
      references POKOJ (ID_KP, NR_POKOJU)
      on update restrict
      on delete restrict;

comment on foreign key REZERWACJA.FK_REZERWAC_POKOJ_W_R_POKOJ is 
'Encja okre la jaki pok j wchodzi w sk ad dokonanej rezerwacji.';

alter table REZERWACJA
   add constraint FK_REZERWAC_REZERWACJ_GOSC foreign key (PESEL_G)
      references GOSC (PESEL_G)
      on update restrict
      on delete restrict;

comment on foreign key REZERWACJA.FK_REZERWAC_REZERWACJ_GOSC is 
'Relacja okre laj ca jaki go   jest odpowiedzialny za wykonanie rezerwacji.';

alter table REZERWACJA_MIEJSCA
   add constraint FK_REZERWAC_REZERWACJ_PARKING foreign key (NR_MIEJSCA)
      references PARKING (NR_MIEJSCA)
      on update restrict
      on delete restrict;

alter table REZERWACJA_MIEJSCA
   add constraint FK_REZERWAC_REZERWACJ_SAMOCHOD foreign key (NR_REJSTRACYJNY)
      references SAMOCHOD (NR_REJSTRACYJNY)
      on update restrict
      on delete restrict;

alter table SAMOCHOD
   add constraint FK_SAMOCHOD_SAMOCHOD__GOSC foreign key (PESEL_G)
      references GOSC (PESEL_G)
      on update restrict
      on delete restrict;

alter table USTERKA
   add constraint FK_USTERKA_SZCZEGOLY_RODZAJ_U foreign key (ID_RU)
      references RODZAJ_USTERKI (ID_RU)
      on update restrict
      on delete restrict;

alter table USTERKA
   add constraint FK_USTERKA_USTERKI_W_POKOJ foreign key (ID_KP, NR_POKOJU)
      references POKOJ (ID_KP, NR_POKOJU)
      on update restrict
      on delete restrict;

comment on foreign key USTERKA.FK_USTERKA_USTERKI_W_POKOJ is 
'Relacja okre la jaka usterka wyst puje w pokoju.';

