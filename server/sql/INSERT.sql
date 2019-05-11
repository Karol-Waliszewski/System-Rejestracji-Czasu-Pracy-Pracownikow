delimiter //
CREATE PROCEDURE dorepeat(p1 INT)
BEGIN
SET @x = 0;
REPEAT SET @x = @x + 1; UNTIL @x > p1 END REPEAT;
END
//


INSERT INTO Dzialy (nazwa)
VALUES ('LOGISTYKA'); -- id_1

INSERT INTO Dzialy (nazwa)
VALUES ('SPRZEDAZ');  -- id_2

INSERT INTO Dzialy (nazwa)
VALUES ('PRODUKCJA');  -- id_3

-- LOGISTYKA --------------------
INSERT INTO Stanowiska (
  nazwa_stanowiska,
  stawka_godz,
  godz_rozpoczecia_naliczania_oplaty,
  godz_zakonczenia_naliczania_oplaty,
  dzial_id )
VALUES (
  'SPECJALISTA DO SPRAW LOGISTYKI',
   20.00,
  '8:00:00',
  '22:00:00',
   1 );

INSERT INTO Stanowiska (
  nazwa_stanowiska,
  stawka_godz,
  godz_rozpoczecia_naliczania_oplaty,
  godz_zakonczenia_naliczania_oplaty,
  dzial_id )
VALUES (
  'KIEROWCA',
   15.00,
  '3:00:00',
  '24:00:00',
   1 );

INSERT INTO Stanowiska (
  nazwa_stanowiska,
  stawka_godz,
  godz_rozpoczecia_naliczania_oplaty,
  godz_zakonczenia_naliczania_oplaty,
  dzial_id )
VALUES (
  'MECHANIK SAMOCHODOWY',
   10.00,
  '7:00:00',
  '17:00:00',
   1 );

-- SPRZEDAZ--------------------
INSERT INTO Stanowiska (
  nazwa_stanowiska,
  stawka_godz,
  godz_rozpoczecia_naliczania_oplaty,
  godz_zakonczenia_naliczania_oplaty,
  dzial_id )
VALUES (
  'SPRZEDAWCA',
   13.00,
  '7:00:00',
  '17:00:00',
   2 );

INSERT INTO Stanowiska (
  nazwa_stanowiska,
  stawka_godz,
  godz_rozpoczecia_naliczania_oplaty,
  godz_zakonczenia_naliczania_oplaty,
  dzial_id )
VALUES (
  'KONSULTANT',
   13.00,
  '7:00:00',
  '17:00:00',
   2 );

INSERT INTO Stanowiska (
  nazwa_stanowiska,
  stawka_godz,
  godz_rozpoczecia_naliczania_oplaty,
  godz_zakonczenia_naliczania_oplaty,
  dzial_id )
VALUES (
  'TLUMACZ',
   19.00,
  '7:00:00',
  '17:00:00',
   2 );

INSERT INTO Stanowiska (
  nazwa_stanowiska,
  stawka_godz,
  godz_rozpoczecia_naliczania_oplaty,
  godz_zakonczenia_naliczania_oplaty,
  dzial_id )
VALUES (
  'PRACOWNIK FIZYCZNY',
   10.00,
  '7:00:00',
  '17:00:00',
   3 );

INSERT INTO Stanowiska (
  nazwa_stanowiska,
  stawka_godz,
  godz_rozpoczecia_naliczania_oplaty,
  godz_zakonczenia_naliczania_oplaty,
  dzial_id )
VALUES (
  'OPERATOR PIŁY',
   13.00,
  '7:00:00',
  '17:00:00',
   3 );

INSERT INTO Stanowiska (
  nazwa_stanowiska,
  stawka_godz,
  godz_rozpoczecia_naliczania_oplaty,
  godz_zakonczenia_naliczania_oplaty,
  dzial_id )
VALUES (
  'KIEROWNIK PRODUKCJI',
   15.00,
  '7:00:00',
  '17:00:00',
   3 );

   -- PRACOWNICY -----------------------

   INSERT INTO Pracownicy (
     imie,
     nazwisko,
     data_urodzenia,
     data_dodania,
     plec,
     stanowisko_id )
     VALUES (
       'Andrzej',
       'Andrzejewicz',
       '1986-07-03',
       '2011-06-04',
       'm',
       9 );

       INSERT INTO Pracownicy (
     imie,
     nazwisko,
     data_urodzenia,
     data_dodania,
     plec,
     stanowisko_id )
     VALUES (
       'Sasha',
       'Michajov',
       '1983-06-29',
       '2012-04-21',
       'm',
       9 );

         INSERT INTO Pracownicy (
     imie,
     nazwisko,
     data_urodzenia,
     data_dodania,
     plec,
     stanowisko_id )
     VALUES (
       'Antoni',
       'Macierewicz',
       '1972-07-03',
       '2012-12-12',
       'm',
       9 );

       INSERT INTO Pracownicy (
     imie,
     nazwisko,
     data_urodzenia,
     data_dodania,
     plec,
     stanowisko_id )
     VALUES (
       'Henryk',
       'Sienkiewicz',
       '1963-05-16',
       '2011-03-15',
       'm',
       9 );

       INSERT INTO Pracownicy (
     imie,
     nazwisko,
     data_urodzenia,
     data_dodania,
     plec,
     stanowisko_id )
     VALUES (
       'Bartlomiej',
       'Babuski',
       '1996-12-30',
       '2011-04-15',
       'm',
       1 );

       INSERT INTO Pracownicy (
     imie,
     nazwisko,
     data_urodzenia,
     data_dodania,
     plec,
     stanowisko_id )
     VALUES (
       'Czarek',
       'Cebulski',
       '1976-05-10',
       '2010-01-05',
       'm',
       2 );
        INSERT INTO Pracownicy (
     imie,
     nazwisko,
     data_urodzenia,
     data_dodania,
     plec,
     stanowisko_id )
     VALUES (
       'Stanislaw',
       'Moniuszko',
       '1967-10-13',
       '2011-04-11',
       'm',
       2 );

       INSERT INTO Pracownicy (
     imie,
     nazwisko,
     data_urodzenia,
     data_dodania,
     plec,
     stanowisko_id )
     VALUES (
       'Czesław',
       'Majster',
       '1966-06-06',
       '2010-05-13',
       'm',
       3 );

        INSERT INTO Pracownicy (
     imie,
     nazwisko,
     data_urodzenia,
     data_dodania,
     plec,
     stanowisko_id )
     VALUES (
       'Monika',
       'Wiernacka',
       '2000-08-01',
       '2010-07-10',
       'k',
       4 );

        INSERT INTO Pracownicy (
     imie,
     nazwisko,
     data_urodzenia,
     data_dodania,
     plec,
     stanowisko_id )
     VALUES (
       'Roksana',
       'Roniek',
       '2000-01-23',
       '2013-10-05',
       'k',
       4 );

        INSERT INTO Pracownicy (
     imie,
     nazwisko,
     data_urodzenia,
     data_dodania,
     plec,
     stanowisko_id )
     VALUES (
       'Wiktoria',
       'Mikulska',
       '1999-03-08',
       '2012-11-14',
       'k',
       5 );

        INSERT INTO Pracownicy (
     imie,
     nazwisko,
     data_urodzenia,
     data_dodania,
     plec,
     stanowisko_id )
     VALUES (
       'Adam',
       'Mickiewicz',
       '1976-06-25',
       '2011-04-19',
       'm',
       6 );

     INSERT INTO Pracownicy (
     imie,
     nazwisko,
     data_urodzenia,
     data_dodania,
     plec,
     stanowisko_id )
     VALUES (
       'Czeslaw',
       'Milosz',
       '1980-04-21',
       '2011-02-14',
       'm',
       7 );

        INSERT INTO Pracownicy (
     imie,
     nazwisko,
     data_urodzenia,
     data_dodania,
     plec,
     stanowisko_id )
     VALUES (
       'Andrzej',
       'Golota',
       '1968-01-05',
       '2012-11-01',
       'm',
       7 );

        INSERT INTO Pracownicy (
     imie,
     nazwisko,
     data_urodzenia,
     data_dodania,
     plec,
     stanowisko_id )
     VALUES (
       'Antoni',
       'Schmidt',
       '1950-08-30',
       '2009-01-03',
       'm',
       8 );
