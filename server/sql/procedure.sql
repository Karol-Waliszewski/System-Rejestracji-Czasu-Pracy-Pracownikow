-- Procedura wyliczajaca ilosc przpracowanych godzin

DELIMITER //
 CREATE PROCEDURE Liczenie_godzin(IN prac_id int, IN od_kiedy date, IN ilosc_dni int, OUT godziny int) -- Procedura wyliczajaca ilosc przepracowanych godzin dla konkretnego pracownika
   BEGIN

SET @stanowisko_id = (SELECT stanowisko_id FROM Pracownicy WHERE pracownik_id = prac_id); -- pobieranie id stanowiska dla obliczenia widelek

Set @licznik = 0;
Set godziny = 0;

WHILE  @licznik < ilosc_dni DO

	set @data_in = (ADDDATE(od_kiedy, INTERVAL @licznik DAY));

	SET @wejscie = (SELECT godzina FROM Odbicia WHERE pracownik_id = prac_id and We_Wy='We' and SUBSTRING(godzina,1,10)= @data_in); -- pobiera i przypisuje date wejscia
	SET @wyjscie = (SELECT godzina FROM Odbicia WHERE pracownik_id = prac_id and We_Wy='Wy' and SUBSTRING(godzina,1,10)= @data_in); -- pobiera i przypisuje date wyjscia

	SET @konwert1 = (EXTRACT(Hour FROM @wejscie)); -- pobiera same godziny
	SET @konwert2 = (EXTRACT(Hour FROM @wyjscie));
	SET @liczba_godzin = @konwert2-@konwert1; -- oblicza roznice

	Set @start = (SELECT godz_rozpoczecia_naliczania_oplaty From Stanowiska WHERE stanowisko_id = @stanowisko_id);
	Set @koniec =(SELECT godz_zakonczenia_naliczania_oplaty From Stanowiska WHERE stanowisko_id = @stanowisko_id);

		SELECT IF(@konwert1>=@start and @konwert2<=@koniec,
          (SELECT  @data_in), -- miesci sie w ramach
          ("Blad odbicia, prosze udac sie do administracji")); -- nie miesci sie w ramach,
          -- ogolnie zawsze bedzie poprawne bo odbicie bedzie sprawdzane przy odbiciu (na wejsciu funkcji zawsze beda poprawne wartosci)

     Set godziny = godziny + @liczba_godzin;
   	 Set @licznik = @licznik +1;


END WHILE;

 SELECT godziny;

   END //
 DELIMITER ; //


CALL Liczenie_godzin (1, "2018-05-30", 2, @godziny); -- 1)Id pracownika, 2)data od ktorej chcemy sprawdzac godziny, 3)ilosc dni dla ktorych chcemy wyznaczyc czas pracy
