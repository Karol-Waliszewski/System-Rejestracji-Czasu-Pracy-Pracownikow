-- tables
-- Table: Dzialy
CREATE TABLE Dzialy (
    dzial_id integer PRIMARY KEY AUTO_INCREMENT,
    nazwa varchar(30) NOT NULL
);

-- Table: Odbicia
CREATE TABLE Odbicia (
    odbicie_id integer PRIMARY KEY AUTO_INCREMENT,
    godzina timestamp NOT NULL,
    We_Wy varchar(2) NOT NULL,
    pracownik_id integer NOT NULL
);



-- Table: Pracownicy
CREATE TABLE Pracownicy (
    pracownik_id integer PRIMARY KEY AUTO_INCREMENT,
    imie varchar(30) NOT NULL,
    nazwisko varchar(30) NOT NULL,
    data_urodzenia date NOT NULL,
    data_dodania date NOT NULL,
    plec char(1) NOT NULL,
    stanowisko_id integer NOT NULL
);

-- Table: Stanowiska
CREATE TABLE Stanowiska (
    stanowisko_id integer PRIMARY KEY AUTO_INCREMENT,
    nazwa_stanowiska varchar(30) NOT NULL,
    stawka_godz double(5,2) NOT NULL,
    godz_rozpoczecia_naliczania_oplaty time NOT NULL,
    godz_zakonczenia_naliczania_oplaty time NOT NULL,
    dzial_id integer NOT NULL
);

-- Table: Wynagrodzenie
CREATE TABLE Wynagrodzenie (
    wynagrodzenia_id integer PRIMARY KEY AUTO_INCREMENT,
    pracownik_id integer NOT NULL,
    wyplata double(11,2) NOT NULL
);

-- foreign keys
-- Reference: Odbica_Pracownicy (table: Odbicia)
ALTER TABLE Odbicia ADD CONSTRAINT Odbica_Pracownicy FOREIGN KEY Odbica_Pracownicy (pracownik_id)
    REFERENCES Pracownicy (pracownik_id);

-- Reference: Pracownicy_Stanowisko (table: Pracownicy)
ALTER TABLE Pracownicy ADD CONSTRAINT Pracownicy_Stanowisko FOREIGN KEY Pracownicy_Stanowisko (stanowisko_id)
    REFERENCES Stanowiska (stanowisko_id);

-- Reference: Stanowisko_Dzial (table: Stanowiska)
ALTER TABLE Stanowiska ADD CONSTRAINT Stanowisko_Dzial FOREIGN KEY Stanowisko_Dzial (dzial_id)
    REFERENCES Dzialy (dzial_id);

-- Reference: Wynagrodzenie_Pracownicy (table: Wynagrodzenie)
ALTER TABLE Wynagrodzenie ADD CONSTRAINT Wynagrodzenie_Pracownicy FOREIGN KEY Wynagrodzenie_Pracownicy (pracownik_id)
    REFERENCES Pracownicy (pracownik_id);

-- End of file.
