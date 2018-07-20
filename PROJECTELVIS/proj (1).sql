/*DBSOCCER*/
-- -----------------------------------------------------
-- Table `Campionato`
-- -----------------------------------------------------
set foreign_key_checks= 0;
DROP TABLE IF EXISTS `Campionato`;
DROP TABLE IF EXISTS `Stadio`;
DROP TABLE IF EXISTS `Squadra`;
DROP TABLE IF EXISTS `Giocatore`;
DROP TABLE IF EXISTS `Arbitro`;
DROP TABLE IF EXISTS `Partita`;
DROP TABLE IF EXISTS `Allenatore`;
DROP TABLE IF EXISTS `Evento`;
DROP TABLE IF EXISTS `Prestazione`;
DROP TABLE IF EXISTS `Notizie`;
-- -----------------------------------------------------
-- Table `Utente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Utente` (
`username` VARCHAR(50) NOT NULL,
`nome` VARCHAR(50) NOT NULL,
`cognome` VARCHAR(50) NOT NULL,
`email` VARCHAR(100) NOT NULL,
`squadrapref` VARCHAR(50) NOT NULL,
`moderatore` BOOLEAN DEFAULT 0,
PRIMARY KEY (`email`),
    FOREIGN KEY (`squadrapref`)
    REFERENCES `Squadra` (`nome`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
  )
ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS `Campionato` (
  `idCampionato` VARCHAR(13) NOT NULL,
  `logoc` VARCHAR(50) NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `stagione` VARCHAR(15) NOT NULL,
  `fondazione` INT NOT NULL,
  `Paese` VARCHAR(50) NULL,
  PRIMARY KEY (`idCampionato`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stadio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stadio` (
  `idstadio` VARCHAR(20) NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `inaugurazione` INT UNSIGNED NOT NULL,
  `capienza` INT UNSIGNED NOT NULL,
  `proprietario` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`idstadio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Squadra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Squadra` (
  `logo` VARCHAR(50) NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `città` VARCHAR(50) NOT NULL,
  `fondazione` INT UNSIGNED NULL,
  `presidente` VARCHAR(45) NOT NULL,
  `stadio` VARCHAR(50) NOT NULL,
  `campionato` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`nome`),
    FOREIGN KEY (`stadio`)
    REFERENCES `Stadio` (`idstadio`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
    FOREIGN KEY (`campionato`)
    REFERENCES `Campionato` (`idCampionato`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Notizie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Notizie` (
  `idnotizia` INT UNSIGNED NOT NULL,
  `datan` DATETIME NOT NULL,
  `titolo` VARCHAR(50) NOT NULL,
  `immagine` VARCHAR(100) NOT NULL,
  `articolo` text NOT NULL,
  `tag` VARCHAR(250) NOT NULL,
  `fonte` VARCHAR(50) NOT NULL DEFAULT 'Easyfootball',
  PRIMARY KEY (`idnotizia`)
  )
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `Giocatore`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Giocatore` (
  `idT` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(50) NOT NULL,
  `cognome` VARCHAR(50) NOT NULL,
  `nascita` YEAR NOT NULL,
  `altezza` FLOAT UNSIGNED NOT NULL,
  `nazionalità` VARCHAR(35) NOT NULL,
  `valoremercato` INT UNSIGNED NOT NULL,
  `ruolo` VARCHAR(15) NOT NULL,
  `numero` INT UNSIGNED NOT NULL,
  `squadra` VARCHAR(50) NOT NULL,
  `presenze` INT UNSIGNED NOT NULL DEFAULT 0,
  `piedepreferito` ENUM('E','D','S') NOT NULL,
  PRIMARY KEY (`idT`),
    FOREIGN KEY (`squadra`)
    REFERENCES `Squadra` (`nome`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Arbitro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Arbitro` (
  `idarbitro` VARCHAR(3) NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `cognome` VARCHAR(50) NOT NULL,
  `sezione` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`idarbitro`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Partita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Partita` (
  `idpartita` VARCHAR(6) NOT NULL,
  `squadracasa` VARCHAR(50) NOT NULL,
  `squadraospite` VARCHAR(50) NOT NULL,
  `ngiornata` INT NOT NULL CHECK ((ngiornata<=38)&&(ngiornata>=1)),
  `datap` DATE NOT NULL,
  `ora` TIME NOT NULL ,
  `stadio` VARCHAR(20) NOT NULL,
  `golcasa` INT NOT NULL,
  `golospite` INT NOT NULL,
  `arbitro` VARCHAR(3) NOT NULL,
  `campionato` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`idpartita`),
    FOREIGN KEY (`squadracasa`)
    REFERENCES `Squadra` (`nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`squadraospite`)
    REFERENCES `Squadra` (`nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`stadio`)
    REFERENCES `Stadio` (`idstadio`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
    FOREIGN KEY (`arbitro`)
    REFERENCES `Arbitro` (`idarbitro`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
    FOREIGN KEY (`campionato`)
    REFERENCES `Campionato` (`idCampionato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Allenatore`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Allenatore` (
  `idT` VARCHAR(7) NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `cognome` VARCHAR(50) NOT NULL,
  `nascita` YEAR NOT NULL,
  `salario` INT UNSIGNED NOT NULL,
  `presenze` INT UNSIGNED DEFAULT 0 CHECK(`presenze`>=0 && `presenze` <=38),
  `modulopreferito` VARCHAR(15) not NULL,
  `squadra` VARCHAR(25) NOT NULL,
  `nazionalità` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idT`),
    FOREIGN KEY (`squadra`)
    REFERENCES `Squadra` (`nome`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Evento` (
  `minuto` TINYINT UNSIGNED NOT NULL,
  `partita` VARCHAR(7) NOT NULL,
  `giocatore` INT UNSIGNED NOT NULL,
  `tipo` enum('GOL','AUTOGOL','OCCASIONE') NOT NULL,
  `commento` VARCHAR(250) NULL,
  PRIMARY KEY (`minuto`,`partita`,`giocatore`),
    FOREIGN KEY (`giocatore`)
    REFERENCES `Giocatore` (`idT`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (`partita`)
    REFERENCES `Partita` (`idpartita`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prestazione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prestazione` (
  `giocatore` INT UNSIGNED NOT NULL,
  `partita` VARCHAR(7) NOT NULL,
  `ammonizione` BOOLEAN DEFAULT FALSE,
  `espulsione` BOOLEAN DEFAULT FALSE,
  `numero falli` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`giocatore`, `partita`),
    FOREIGN KEY (`giocatore`)
    REFERENCES `Giocatore` (`idT`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
    FOREIGN KEY (`partita`)
    REFERENCES `Partita` (`idpartita`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `Campionato`
-- -----------------------------------------------------


INSERT INTO `Campionato` (`idCampionato`, `logoc`, `nome`, `stagione`, `fondazione`, `Paese`) VALUES ('SerieA1617', 'seriea.png', 'Serie A', '2016-2017', 1898, 'Italia');
INSERT INTO `Campionato` (`idCampionato`, `logoc`, `nome`, `stagione`, `fondazione`, `Paese`) VALUES ('serieA1516', 'seriea.png', 'Serie A', '2015-2016', 1898, 'Italia');
INSERT INTO `Campionato` (`idCampionato`, `logoc`, `nome`, `stagione`, `fondazione`, `Paese`) VALUES ('LigaSant1617', 'liga.png', 'Liga Santander', '2016-2017', 1928, 'Spagna');
INSERT INTO `Campionato` (`idCampionato`, `logoc`, `nome`, `stagione`, `fondazione`, `Paese`) VALUES ('PremierL1617', 'premier.png', 'Premier League', '2016-2017', 1888, 'Inghilterra');
INSERT INTO `Campionato` (`idCampionato`, `logoc`, `nome`, `stagione`, `fondazione`, `Paese`) VALUES ('Bundes1617', 'bundesliga.png', 'Bundesliga', '2016-2017', 1971, 'Germania');


-- -----------------------------------------------------
-- Data for table `Stadio`
-- -----------------------------------------------------


INSERT INTO `Stadio` (`idstadio`, `nome`, `inaugurazione`, `capienza`, `proprietario`) VALUES ('sit001', 'Juventus Stadium', 2011, 41507, 'Juventus FC');
INSERT INTO `Stadio` (`idstadio`, `nome`, `inaugurazione`, `capienza`, `proprietario`) VALUES ('sit002', 'Atleti Azzurri d´Italia', 1928, 21300, 'Comune di Bergamo');
INSERT INTO `Stadio` (`idstadio`, `nome`, `inaugurazione`, `capienza`, `proprietario`) VALUES ('sit003', 'Renato Dall’Ara', 1927, 38279, 'Comune di Bologna');
INSERT INTO `Stadio` (`idstadio`, `nome`, `inaugurazione`, `capienza`, `proprietario`) VALUES ('sit004', 'San Siro-Giuseppe Meazza', 1926, 80018, 'Comune di Milano');
INSERT INTO `Stadio` (`idstadio`, `nome`, `inaugurazione`, `capienza`, `proprietario`) VALUES ('sit006', 'Artemio Franchi', 1931, 46366, 'Comune di Firenze');
INSERT INTO `Stadio` (`idstadio`, `nome`, `inaugurazione`, `capienza`, `proprietario`) VALUES ('sit007', 'Renzo Barbera', 1932, 36349, 'Comune di Palermo');
INSERT INTO `Stadio` (`idstadio`, `nome`, `inaugurazione`, `capienza`, `proprietario`) VALUES ('sit008', 'Stadio Olimpico Grande Torino', 1933, 27958, 'Comune di Torino');
INSERT INTO `Stadio` (`idstadio`, `nome`, `inaugurazione`, `capienza`, `proprietario`) VALUES ('sit009', 'San Paolo', 1959, 60240, 'Comune di Napoli');
INSERT INTO `Stadio` (`idstadio`, `nome`, `inaugurazione`, `capienza`, `proprietario`) VALUES ('sit010', 'Olimpico di Roma', 1953, 70634, 'CONI');
INSERT INTO `Stadio` (`idstadio`, `nome`, `inaugurazione`, `capienza`, `proprietario`) VALUES ('sit011', 'Sant´Elia', 1970, 16074, 'Comune di Cagliari');
INSERT INTO `Stadio` (`idstadio`, `nome`, `inaugurazione`, `capienza`, `proprietario`) VALUES ('sit012', 'Carlo Castellani', 1965, 16284, 'Comune di Empoli');
INSERT INTO `Stadio` (`idstadio`, `nome`, `inaugurazione`, `capienza`, `proprietario`) VALUES ('sit013', 'Ezio Schida', 1946, 16640, 'Comune di Crotone');
INSERT INTO `Stadio` (`idstadio`, `nome`, `inaugurazione`, `capienza`, `proprietario`) VALUES ('sit014', 'Luigi Ferraris', 1911, 36599, 'Luigi Ferraris Srl');
INSERT INTO `Stadio` (`idstadio`, `nome`, `inaugurazione`, `capienza`, `proprietario`) VALUES ('sit015', 'Dacia Arena', 1976, 25132, 'Comune di Udine');
INSERT INTO `Stadio` (`idstadio`, `nome`, `inaugurazione`, `capienza`, `proprietario`) VALUES ('sit016', 'Marcantonio Bentegodi', 1963, 39211, 'Comune di Verona');
INSERT INTO `Stadio` (`idstadio`, `nome`, `inaugurazione`, `capienza`, `proprietario`) VALUES ('sit017', 'Adriatico', 1955, 20515, 'Comune di Pescara');
INSERT INTO `Stadio` (`idstadio`, `nome`, `inaugurazione`, `capienza`, `proprietario`) VALUES ('sit018', 'Mapei Stadium - Città del Tricolore', 1995, 23717, 'Mapei S.p.A.');




-- -----------------------------------------------------
-- Data for table `Squadra`
-- -----------------------------------------------------


INSERT INTO `Squadra` (`logo`,`nome`, `città`, `fondazione`, `presidente`, `stadio`, `campionato`) VALUES ('atalanta.png', 'Atalanta BC', 'Bergamo', 1907, 'Antonio Percassi', 'sit002', 'SerieA1617');
INSERT INTO `Squadra` (`logo`,`nome`, `città`, `fondazione`, `presidente`, `stadio`, `campionato`) VALUES ('bologna.png', 'Bologna FC 1909', 'Bologna', 1909, 'Joey Saputo', 'sit003', 'SerieA1617');
INSERT INTO `Squadra` (`logo`,`nome`, `città`, `fondazione`, `presidente`, `stadio`, `campionato`) VALUES ('chievo.png', 'AC Chievo Verona', 'Verona', 1928, 'Luca Campedelli', 'sit016', 'SerieA1617');
INSERT INTO `Squadra` (`logo`,`nome`, `città`, `fondazione`, `presidente`, `stadio`, `campionato`) VALUES ('cagliari.png', 'Cagliari Calcio', 'Cagliari', 1920, 'Tommaso Giulini', 'sit011', 'SerieA1617');
INSERT INTO `Squadra` (`logo`,`nome`, `città`, `fondazione`, `presidente`, `stadio`, `campionato`) VALUES ('empoli.png', 'Empoli FC', 'Empoli', 1920, 'Fabrizio Corsi', 'sit012', 'SerieA1617');
INSERT INTO `Squadra` (`logo`,`nome`, `città`, `fondazione`, `presidente`, `stadio`, `campionato`) VALUES ('sassuolo.png', 'US Sassuolo', 'Sassuolo', 1920, 'Carlo Rossi', 'sit018', 'SerieA1617');
INSERT INTO `Squadra` (`logo`,`nome`, `città`, `fondazione`, `presidente`, `stadio`, `campionato`) VALUES ('juventus.png', 'Juventus FC', 'Torino', 1897, 'Andrea Agnelli', 'sit001', 'SerieA1617');
INSERT INTO `Squadra` (`logo`,`nome`, `città`, `fondazione`, `presidente`, `stadio`, `campionato`) VALUES ('roma.png', 'AS Roma', 'Roma', 1927, 'James Pallotta', 'sit010', 'SerieA1617');
INSERT INTO `Squadra` (`logo`,`nome`, `città`, `fondazione`, `presidente`, `stadio`, `campionato`) VALUES ('inter.png', 'FC Internazionale', 'Milano', 1908, 'Erick Thohir', 'sit004', 'SerieA1617');
INSERT INTO `Squadra` (`logo`,`nome`, `città`, `fondazione`, `presidente`, `stadio`, `campionato`) VALUES ('milan.png', 'AC Milan', 'Milano', 1899, 'Li Yonghong', 'sit004', 'SerieA1617');
INSERT INTO `Squadra` (`logo`,`nome`, `città`, `fondazione`, `presidente`, `stadio`, `campionato`) VALUES ('lazio.png', 'SS Lazio', 'Roma', 1900, 'Claudio Lotito', 'sit010', 'SerieA1617');
INSERT INTO `Squadra` (`logo`,`nome`, `città`, `fondazione`, `presidente`, `stadio`, `campionato`) VALUES ('pescara.png', 'Delfino Pescara 1936', 'Pescara', 1936, 'Daniele Sebastiani', 'sit017', 'SerieA1617');
INSERT INTO `Squadra` (`logo`,`nome`, `città`, `fondazione`, `presidente`, `stadio`, `campionato`) VALUES ('palermo.png', 'US città di Palermo', 'Palermo', 1900, 'Paul Baccaglini', 'sit007', 'SerieA1617');
INSERT INTO `Squadra` (`logo`,`nome`, `città`, `fondazione`, `presidente`, `stadio`, `campionato`) VALUES ('udinese.png', 'Udinese Calcio', 'Udine', 1896, 'Giampaolo Pozzo', 'sit015', 'SerieA1617');
INSERT INTO `Squadra` (`logo`,`nome`, `città`, `fondazione`, `presidente`, `stadio`, `campionato`) VALUES ('sampdoria.png', 'UC Sampdoria', 'Genova', 1946, 'Massimo Ferrero', 'sit014', 'SerieA1617');
INSERT INTO `Squadra` (`logo`,`nome`, `città`, `fondazione`, `presidente`, `stadio`, `campionato`) VALUES ('genoa.png', 'Genoa CFC', 'Genova', 1893, 'Enrico Preziosi', 'sit014', 'SerieA1617');
INSERT INTO `Squadra` (`logo`,`nome`, `città`, `fondazione`, `presidente`, `stadio`, `campionato`) VALUES ('crotone.png', 'FC Crotone', 'Crotone', 1922, 'Raffaele Vrenna', 'sit013', 'SerieA1617');
INSERT INTO `Squadra` (`logo`,`nome`, `città`, `fondazione`, `presidente`, `stadio`, `campionato`) VALUES ('torino.png', 'Torino FC', 'Torino', 1906, 'Urbano Cairo', 'sit008', 'SerieA1617');
INSERT INTO `Squadra` (`logo`,`nome`, `città`, `fondazione`, `presidente`, `stadio`, `campionato`) VALUES ('fiorentina.png', 'ACF Fiorentina', 'Firenze', 1926, 'Mario Cognigni', 'sit006', 'SerieA1617');
INSERT INTO `Squadra` (`logo`,`nome`, `città`, `fondazione`, `presidente`, `stadio`, `campionato`) VALUES ('napoli.png', 'SSC Napoli', 'Napoli', 1926, 'Aurelio de Laurentis', 'sit009', 'SerieA1617');




-- -----------------------------------------------------
-- Data for table `Giocatore`
-- -----------------------------------------------------


INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Etrit', 'Berisha', 1989, 1.94, 'Albania', 4500000, 'POR', 1, 'Atalanta BC', 25, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Pierluigi', 'Gollini', 1995, 1.88, 'Italia', 4000000, 'POR', 91, 'Atalanta BC', 3, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Francesco', 'Rossi', 1991, 1.93, 'Italia', 175000, 'POR', 31, 'Atalanta BC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Mattia', 'Caldara', 1994, 1.87, 'Italia', 1200000, 'DC', 13, 'Atalanta BC', 27, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Rafael', 'Toloi', 1990, 1.85, 'Brasile', 4800000, 'DC', 3, 'Atalanta BC', 29, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Ervin', 'Zukanovic', 1987, 1.88, 'Bosnia', 3800000, 'DC', 6, 'Atalanta BC', 19, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Andrea', 'Masiello', 1986, 1.85, 'Italia', 1800000, 'DC', 5, 'Atalanta BC', 32, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Alessandro', 'Bastoni', 1999, 1.90, 'Italia', 800000, 'DC', 95, 'Atalanta BC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Boukary', 'Dramè', 1985, 1.80, 'Senegal', 2000000, 'TS', 93, 'Atalanta BC', 10, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Andrea', 'Conti', 1994, 1.84, 'Italia', 6000000, 'TD', 24, 'Atalanta BC', 30, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Hans', 'Hateboer', 1994, 1.87, 'Olanda', 1000000, 'TD', 33, 'Atalanta BC', 4,'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Abdoulay', 'Konko', 1984, 1.84, 'Francia', 800000, 'TD', 25, 'Atalanta BC', 10, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Franck', 'Kessiè', 1996, 1.83, 'Costa D\'Avorio', 15000000, 'MED', 19, 'Atalanta BC', 27, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Jasmin', 'Kurtic', 1989, 1.86, 'Slovenia', 6000000, 'CC', 27, 'Atalanta BC', 34, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Remo', 'Freuler', 1992, 1.81, 'Svizzera', 5500000, 'CC', 11, 'Atalanta BC', 30, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Alberto', 'Grassi', 1995, 1.83, 'Italia', 3500000, 'CC', 88, 'Atalanta BC', 17, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Bryan', 'Cristante', 1995, 1.86, 'Italia', 2000000, 'CC', 4, 'Atalanta BC', 26, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Giulio', 'Migliaccio', 1981, 1.78, 'Italia', 200000, 'CC', 8, 'Atalanta BC', 2, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Cristian', 'Raimondi', 1981, 1.82, 'Italia', 100000, 'ED', 77, 'Atalanta BC', 7, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Leonardo', 'Spinazzola', 1993, 1.86, 'Italia', 4000000, 'ES', 37, 'Atalanta BC', 27, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Papu', 'Gomez', 1988, 1.65, 'Argentina', 13000000, 'AS', 10, 'Atalanta BC', 34, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Anthony', 'Mounier', 1987, 1.74, 'Francia', 3000000, 'AD', 87, 'Atalanta BC', 11, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Marco', 'D\'Alessandro', 1991, 1.73, 'Italia', 1500000, 'AD', 7, 'Atalanta BC', 24, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Andrea', 'Petagna', 1995, 1.90, 'Italia', 5000000, 'PC', 29, 'Atalanta BC', 31, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Alberto', 'Paloschi', 1990, 1.83, 'Italia', 5000000, 'PC', 43, 'Atalanta BC', 11, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Antonio', 'Mirante', 1983, 1.93, 'Italia', 2300000, 'POR', 83, 'Bologna FC 1909', 19, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Angelo', 'Da Costa', 1983, 1.86, 'Italia', 500000, 'POR', 1, 'Bologna FC 1909', 17, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Mouhmadou', 'Sarr', 1997, 1.90, 'Senegal', 75000, 'POR', 97, 'Bologna FC 1909', 3, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Marios', 'Oikonomou', 1992, 1.89, 'Grecia', 2000000, 'DC', 2, 'Bologna FC 1909', 17, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Filip', 'Helander', 1993, 1.92, 'Svezia', 1400000, 'DC', 18, 'Bologna FC 1909', 9, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Daniele', 'Gastaldello', 1983, 1.85, 'Italia', 700000, 'DC', 28, 'Bologna FC 1909', 23, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Domenico', 'Maietta', 1982, 1.85, 'Italia', 400000, 'DC', 20, 'Bologna FC 1909', 28, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Adam', 'Masina', 1994, 1.91, 'Italia', 4000000, 'TS', 25, 'Bologna FC 1909', 31, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Ibrahima', 'Mbaye', 1994, 1.88, 'Senegal', 3000000, 'TD', 15, 'Bologna FC 1909', 13, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Emil', 'Krafth', 1994, 1.85, 'Svezia', 1500000, 'TD', 4, 'Bologna FC 1909', 23, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Vasilios', 'Torosidis', 1985, 1.86, 'Grecia', 1000000, 'TD', 35, 'Bologna FC 1909', 25, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Federico', 'Viviani', 1992, 1.80, 'Italia', 3800000, 'MED', 6, 'Bologna FC 1909', 16, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Adam', 'Nagy', 1995, 1.75, 'Bulgaria', 3000000, 'MED', 16, 'Bologna FC 1909', 24, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Erick', 'Pulgar', 1994, 1.86, 'Cile', 1800000, 'CC', 5, 'Bologna FC 1909', 25, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Saphir', 'Taider', 1992, 1.80, 'Algeria', 5500000, 'CC', 8, 'Bologna FC 1909', 21, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Godfred', 'Donsah', 1996, 1.76, 'Ghana', 5000000, 'CC', 17, 'Bologna FC 1909', 11, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Luca', 'Rizzo', 1992, 1.88, 'Italia', 3200000, 'CC', 22, 'Bologna FC 1909', 11, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Simone', 'Verdi', 1992, 1.71, 'Italia', 5000000, 'TRQ', 9, 'Bologna FC 1909', 26, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Juan Manuel', 'Valencia', 1998, 1.85, 'Colombia', 500000, 'TRQ', 12, 'Bologna FC 1909', 4, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Ledislav', 'Krejci', 1992, 1.79, 'Rep.Ceca', 4500000, 'AS', 11, 'Bologna FC 1909', 34, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Orji', 'Okwonkwo', 1998, 1.81, 'Nigeria', 50000, 'AS', 30, 'Bologna FC 1909', 6, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Federico', 'Di Francesco', 1994, 1.78, 'Italia', 1800000, 'AD', 14, 'Bologna FC 1909', 22, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Mattia', 'Destro', 1991, 1.78, 'Italia', 8000000, 'PC', 10, 'Bologna FC 1909', 27, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Umar', 'Sadiq', 1997, 1.92, 'Nigeria', 2500000, 'PC', 19, 'Bologna FC 1909', 7, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Bruno', 'Petkovic', 1994, 1.92, 'Croazia', 1200000, 'PC', 21, 'Bologna FC 1909', 17, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Gabriel', 'Ferreira', 1992, 1.89, 'Brasile', 1800000, 'POR', 28, 'Cagliari Calcio', 19, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Rafael', 'Bittencourt', 1982, 1.87, 'Brasile', 500000, 'POR', 1, 'Cagliari Calcio', 1, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Roberto', 'Colombo', 1975, 1.90, 'Italia', 50000, 'POR', 13, 'Cagliari Calcio', 0, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Luca', 'Ceppitelli', 1989, 1.89, 'Italia', 2000000, 'DC', 23, 'Cagliari Calcio', 19, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Bartosz', 'Salamon', 1991, 1.94, 'Polonia', 2000000, 'DC', 35, 'Cagliari Calcio', 15, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Bruno', 'Alves', 1981, 1.89, 'Portogallo', 1000000, 'DC', 2, 'Cagliari Calcio', 34, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Marco', 'Capuano', 1991, 1.86, 'Italia', 1000000, 'DC', 24, 'Cagliari Calcio', 12, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Nicola', 'Murru', 1994, 1.80, 'Italia', 2500000, 'TS', 29, 'Cagliari Calcio', 23, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Senna', 'Miangue', 1997, 1.92, 'Belgio', 2000000, 'TS', 12, 'Cagliari Calcio', 6, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Fabio', 'Pisacane', 1986, 1.78, 'Italia', 800000, 'TD', 19, 'Cagliari Calcio', 26, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Davide', 'Di Gennaro', 1988, 1.80, 'Italia', 3000000, 'MED', 8, 'Cagliari Calcio', 20, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Panagiotis', 'Tachtsidis', 1991, 1.91, 'Grecia', 2000000, 'MED', 77, 'Cagliari Calcio', 23, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Nicolò', 'Barella', 1997, 1.72, 'Italia', 4000000, 'CC', 18, 'Cagliari Calcio', 27, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Artur', 'Ionita', 1990, 1.84, 'Romania', 3300000, 'CC', 21, 'Cagliari Calcio', 15, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Paolo', 'Faragò', 1993, 1.87, 'Italia', 2500000, 'CC', 16, 'Cagliari Calcio', 7, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Daniele', 'Dessena', 1987, 1.83, 'Italia', 1600000, 'CC', 4, 'Cagliari Calcio', 18, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Alessandro', 'Deiola', 1995, 1.90, 'Italia', 1500000, 'CC', 27, 'Cagliari Calcio', 4, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Simone', 'Padoin', 1984, 1.77, 'Italia', 1000000, 'CC', 20, 'Cagliari Calcio', 28, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Mauricio', 'Isla', 1988, 1.76, 'Cile', 4000000, 'ED', 3, 'Cagliari Calcio', 32, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Joao', 'Pedro', 1992, 1.84, 'Brasile', 4000000, 'TRQ', 10, 'Cagliari Calcio', 19, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Diego', 'Farias', 1990, 1.72, 'Brasile', 3800000, 'AD', 17, 'Cagliari Calcio', 17, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Marco', 'Sau', 1987, 1.69, 'Italia', 4000000, 'PC', 25, 'Cagliari Calcio', 32, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Federico', 'Melchiorri', 1987, 1.84, 'Italia', 2200000, 'PC', 9, 'Cagliari Calcio', 10, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Marco', 'Borriello', 1982, 1.86, 'Italia', 800000, 'PC', 22, 'Cagliari Calcio', 33, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Kwang Song', 'Han', 1998, 1.78, 'Corea del Nord', 100000, 'PC', 32, 'Cagliari Calcio', 2, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Alex', 'Cordaz', 1983, 1.88, 'Italia', 700000, 'POR', 1, 'FC Crotone', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Marco', 'Festa', 1992, 1.90, 'Italia', 200000, 'POR', 5, 'FC Crotone', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Aniello', 'Viscovo', 1999, 1.90, 'Italia', 175000, 'POR', 33, 'FC Crotone', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Gianmarco', 'Ferrari', 1992, 1.89, 'Italia', 2500000, 'DC', 13, 'FC Crotone', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Noe', 'Dussenne', 1992, 1.91, 'Belgio', 1200000, 'DC', 23, 'FC Crotone', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Federico', 'Ceccherini', 1992, 1.87, 'Italia', 900000, 'DC', 17, 'FC Crotone', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Claiton', 'Machado dos Santos', 1984, 1.86, 'Brasile', 500000, 'DC', 3, 'FC Crotone', 10, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Giuseppe', 'Cuomo', 1998, 1.90, 'Italia', 175000, 'DC', 21, 'FC Crotone', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Bruno', 'Martella', 1992, 1.84, 'Italia', 1000000, 'TS', 87, 'FC Crotone', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Djamel', 'Mesbah', 1984, 1.80, 'Algeria', 400000, 'TS', 15, 'FC Crotone', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Aleandro', 'Rosi', 1987, 1.84, 'Italia', 1000000, 'TD', 22, 'FC Crotone', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Mario', 'Sanpirisi', 1992, 1.88, 'Italia', 800000, 'TD', 31, 'FC Crotone', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Lorenzo', 'Cristig', 1993, 1.83, 'Italia', 2800000, 'MED', 8, 'FC Crotone', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Leonardo', 'Capezzi', 1995, 1.78, 'Italia', 1800000, 'CC', 28, 'FC Crotone', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Andrea', 'Barberis', 1993, 1.77, 'Italia', 1000000, 'CC', 18, 'FC Crotone', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Marcus', 'Rhoden', 1991, 1.78, 'Svezia', 1100000, 'ED', 6, 'FC Crotone', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Manuel', 'Nicoletti', 1998, 1.82, 'Italia', 200000, 'ES', 98, 'FC Crotone', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Andrei', 'Kotnik', 1995, 1.89, 'Slovenia', 250000, 'TRQ', 20, 'FC Crotone', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Adrian', 'Stoian', 1991, 1.78, 'Romania', 900000, 'AS', 12, 'FC Crotone', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Aleksander', 'Tonev', 1990, 1.78, 'Bulgaria', 700000, 'AS', 24, 'FC Crotone', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Maxwell', 'Acosty', 1991, 1.79, 'Ghana', 1000000, 'AD', 27, 'FC Crotone', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Andrea', 'Nalini', 1990, 1.80, 'Italia', 250000, 'AD', 9, 'FC Crotone', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Diego', 'Falcinelli', 1991, 1.86, 'Italia', 2000000, 'PC', 11, 'FC Crotone', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Marcello', 'Trotta', 1992, 1.88, 'Italia', 2000000, 'PC', 29, 'FC Crotone', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Simeon', 'Nwankwo', 1992, 1.98, 'Nigeria', 850000, 'PC', 99, 'FC Crotone', 19, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Stefano', 'Sorrentino', 1979, 1.86, 'Italia', 800000, 'POR', 70, 'AC Chievo Verona', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Andrea', 'Seculin', 1990, 1.90, 'Italia', 400000, 'POR', 90, 'AC Chievo Verona', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Walter', 'Bressan', 1981, 1.83, 'Italia', 100000, 'POR', 32, 'AC Chievo Verona', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Nicolàs', 'Spolli', 1983, 1.90, 'Argentina', 500000, 'DC', 2, 'AC Chievo Verona', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Alessandro', 'Gamberini', 1981, 1.91, 'Italia', 400000, 'DC', 5, 'AC Chievo Verona', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Dario', 'Dainelli', 1979, 1.91, 'Italia', 300000, 'DC', 3, 'AC Chievo Verona', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Massimo', 'Gobbi', 1980, 1.83, 'Italia', 300000, 'TS', 18, 'AC Chievo Verona', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Bostjan', 'Cesar', 1982, 1.83, 'Slovenia', 400000, 'DC', 12, 'AC Chievo Verona', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Fabrizio', 'Cacciatore', 1986, 1.82, 'Italia', 1800000, 'TD', 29, 'AC Chievo Verona', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Nicolas', 'Frey', 1984, 1.84, 'Francia', 500000, 'TD', 21, 'AC Chievo Verona', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Michele', 'Troiani', 1996, 1.81, 'Italia', 250000, 'TD', 7, 'AC Chievo Verona', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Gennaro', 'Sardo', 1979, 1.90, 'Italia', 100000, 'TD', 20, 'AC Chievo Verona', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Ivan', 'Rdovanovic', 1988, 1.86, 'Serbia', 2500000, 'MED', 8, 'AC Chievo Verona', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Lucas', 'Castro', 1989, 1.82, 'Argentina', 7000000, 'CC', 19, 'AC Chievo Verona', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Perparim', 'Hetemaj', 1986, 1.79, 'Finlandia', 4500000, 'CC', 56, 'AC Chievo Verona', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Nicola', 'Rigoni', 1990, 1.85, 'Italia', 1900000, 'CC', 4, 'AC Chievo Verona', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Samuel', 'Bastien', 1996, 1.77, 'Belgio', 800000, 'CC', 28, 'AC Chievo Verona', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Mariano', 'Izco', 1983, 1.80, 'Argentina', 700000, 'CC', 13, 'AC Chievo Verona', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'N\'Diaye', 'Djiby', 1994, 1.86, 'Senegal', 75000, 'CC', 94, 'AC Chievo Verona', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Vladimir', 'Birsa', 1986, 1.86, 'Slovenia', 4500000, 'TRQ', 23, 'AC Chievo Verona', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Jonathan', 'de Guzmàn', 1987, 1.84, 'Olanda', 3000000, 'TRQ', 1, 'AC Chievo Verona', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Serge', 'Gakpè', 1987, 1.73, 'Togo', 1500000, 'AD', 7, 'AC Chievo Verona', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Riccardo', 'Meggiorini', 1985, 1.82, 'Italia', 3000000, 'SP', 69, 'AC Chievo Verona', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Roberto', 'Inglese', 1991, 1.87, 'Italia', 2500000, 'PC', 45, 'AC Chievo Verona', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Sergio', 'Pellissier', 1979, 1.75, 'Italia', 200000, 'PC', 31, 'AC Chievo Verona', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Lukasz', 'Skorupski', 1991, 1.87, 'Polonia', 5000000, 'POR', 28, 'Empoli FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Alberto', 'Pelagotti', 1989, 1.86, 'Italia', 500000, 'POR', 23, 'Empoli FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Maurizio', 'Pugliesi', 1976, 1.88, 'Italia', 25000, 'POR', 1, 'Empoli FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Giuseppe', 'Bellusci', 1989, 1.84, 'Italia', 1800000, 'DC', 6, 'Empoli FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Federico', 'Barba', 1993, 1.88, 'Italia', 1500000, 'DC', 19, 'Empoli FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Andrea', 'Costa', 1986, 1.82, 'Italia', 1100000, 'DC', 15, 'Empoli FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Uros', 'Cosic', 1992, 1.87, 'Serbia', 700000, 'DC', 24, 'Empoli FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Federico', 'Dimarco', 1997, 1.75, 'Italia', 1500000, 'TS', 4, 'Empoli FC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Manuel', 'Pasqual', 1982, 1.78, 'Italia', 600000, 'TS', 21, 'Empoli FC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Frederic', 'Veseli', 1992, 1.73, 'Albania', 800000, 'TD', 13, 'Empoli FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Marco', 'Zambelli', 1985, 1.83, 'Italia', 400000, 'TD', 3, 'Empoli FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Assane', 'Dioussè', 1997, 1.80, 'Senegal', 4000000, 'MED', 8, 'Empoli FC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Jose', 'Mauri', 1996, 1.75, 'Italia', 4000000, 'CC', 5, 'Empoli FC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Marcel', 'Buchel', 1991, 1.69, 'Liechtenstein', 1700000, 'CC', 77, 'Empoli FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Andres', 'Tello', 1996, 1.75, 'Colombia', 1000000, 'CC', 88, 'Empoli FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Rade', 'Krunic', 1993, 1.80, 'Bosnia', 900000, 'CC', 33, 'Empoli FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Miha', 'Zajc', 1994, 1.84, 'Slovenia', 800000, 'CC', 17, 'Empoli FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Vincent', 'Laurini', 1989, 1.78, 'Italia', 1400000, 'TD', 2, 'Empoli FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Daniele', 'Croce', 1982, 1.75, 'Italia', 500000, 'CC', 11, 'Empoli FC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Alberto', 'Picchi', 1997, 1.85, 'Italia', 350000, 'CC', 71, 'Empoli FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Omar', 'El Kaddouri', 1990, 1.85, 'Marocco', 4500000, 'TRQ', 10, 'Empoli FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Mame', 'Thiam', 1992, 1.74, 'Senegal', 1250000, 'AS', 27, 'Empoli FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Manuel', 'Pucciarelli', 1991, 1.74, 'Italia', 3700000, 'SP', 20, 'Empoli FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Guido', 'Marilungo', 1989, 1.74, 'Italia', 600000, 'SP', 89, 'Empoli FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Levan', 'Mchedlidze', 1990, 1.92, 'Georgia', 500000, 'PC', 9, 'Empoli FC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Marco', 'Sportiello', 1992, 1.92, 'Italia', 7000000, 'POR', 57, 'ACF Fiorentina', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Ciprian', 'Tatarusanu', 1997, 1.98, 'Romania', 4500000, 'POR', 12, 'ACF Fiorentina', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Bartolomiej', 'Dragowski', 1997, 1.91, 'Polonia', 3000000, 'POR', 97, 'ACF Fiorentina', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Giacomo', 'Satalino', 1999, 1.88, 'Italia', 100000, 'POR', 23, 'ACF Fiorentina', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Daniele', 'Astori', 1987, 1.88, 'Italia', 8500000, 'DC', 13, 'ACF Fiorentina', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Nenad', 'Tomovic', 1987, 1.84, 'Serbia', 4500000, 'DC', 40, 'ACF Fiorentina', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Gonzalo', 'Rodriguez', 1984, 1.82, 'Argentina', 4000000, 'DC', 2, 'ACF Fiorentina', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Carlos', 'Salcedo', 1993, 1.85, 'Messico', 4000000, 'DC', 18, 'ACF Fiorentina', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Sebastien', 'De Maio', 1987, 1.90, 'Francia', 2000000, 'DC', 4, 'ACF Fiorentina', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Hrvoje', 'Milic', 1989, 1.83, 'Croazia', 2000000, 'TS', 31, 'ACF Fiorentina', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Maximiliano', 'Olivera', 1992, 1.81, 'Uruguay', 1000000, 'TS', 15, 'ACF Fiorentina', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Milan', 'Badelj', 1989, 1.86, 'Croazia', 11000000, 'MED', 5, 'ACF Fiorentina', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Carlos', 'Sanchez', 1986, 1.82, 'Colombia', 3000000, 'MED', 6, 'ACF Fiorentina', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Matias', 'Vecino', 1991, 1.87, 'Uruguay', 11000000, 'CC', 8, 'ACF Fiorentina', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Borja', 'Valero', 1985, 1.75, 'Spagna', 10000000, 'CC', 20, 'ACF Fiorentina', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Sebastian', 'Cristoforo', 1993, 1.73, 'Uruguay', 2800000, 'CC', 19, 'ACF Fiorentina', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Federico', 'Chiesa', 1997, 1.75, 'Italia', 8000000, 'ED', 25, 'ACF Fiorentina', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Josip', 'Ilicic', 1988, 1.90, 'Slovenia', 13500000, 'TRQ', 72, 'ACF Fiorentina', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Riccardo', 'Saponara', 1991, 1.84, 'Italia', 12000000, 'TRQ', 21, 'ACF Fiorentina', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Ianis', 'Hagi', 1998, 1.80, 'Romania', 750000, 'TRQ', 24, 'ACF Fiorentina', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Federico', 'Bernardeschi', 1994, 1.83, 'Italia', 24000000, 'AD', 10, 'ACF Fiorentina', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Cristian', 'Tello', 1991, 1.78, 'Spagna', 10000000, 'AD', 16, 'ACF Fiorentina', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Nikola', 'Kalinic', 1988, 1.87, 'Croazia', 20000000, 'PC', 9, 'ACF Fiorentina', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Khouma', 'Babacar', 1993, 1.85, 'Senegal', 7500000, 'PC', 30, 'ACF Fiorentina', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Mattia', 'Perin', 1992, 1.88, 'Italia', 15000000, 'POR', 1, 'Genoa CFC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Eugenio', 'Lamanna', 1989, 1.87, 'Italia', 2500000, 'POR', 23, 'Genoa CFC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Lukas', 'Zima', 1994, 1.86, 'Rep.Ceca', 100000, 'POR', 38, 'Genoa CFC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Fernando', 'Rubinho', 1982, 1.84, 'Brasile', 75000, 'POR', 83, 'Genoa CFC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Armando', 'Izzo', 1992, 1.83, 'Italia', 6500000, 'DC', 5, 'Genoa CFC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Ezequiel', 'Munoz', 1990, 1.85, 'Argentina', 3300000, 'DC', 24, 'Genoa CFC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Santiago', 'Gentiletti', 1985, 1.82, 'Argentina', 500000, 'DC', 3, 'Genoa CFC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Nicolas', 'Burdisso', 1981, 1.83, 'Argentina', 400000, 'DC', 8, 'Genoa CFC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Davide', 'Biraschi', 1994, 1.82, 'Italia', 400000, 'DC', 14, 'Genoa CFC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Lucas', 'Orban', 1989, 1.84, 'Argentina', 2500000, 'TS', 21, 'Genoa CFC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Davide', 'Brivio', 1988, 1.84, 'Italia', 1000000, 'TS', 28, 'Genoa CFC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Miguel', 'Veloso', 1986, 1.80, 'Portogallo', 5000000, 'MED', 44, 'Genoa CFC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Danilo', 'Cataldi', 1994, 1.80, 'Italia', 7000000, 'CC', 94, 'Genoa CFC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Oscar', 'Hiljemark', 1992, 1.84, 'Svezia', 3800000, 'CC', 15, 'Genoa CFC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Luca', 'Rigoni', 1984, 1.85, 'Italia', 2500000, 'CC', 30, 'Genoa CFC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Isaac', 'Cofie', 1991, 1.78, 'Ghana', 1800000, 'CC', 4, 'Genoa CFC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Darko', 'Lazovic', 1990, 1.81, 'Serbia', 2500000, 'ED', 22, 'Genoa CFC', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Diego', 'Laxalt', 1993, 1.78, 'Uruguay', 8000000, 'ES', 93, 'Genoa CFC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Leonardo', 'Morosini', 1995, 1.75, 'Italia', 2200000, 'TRQ', 32, 'Genoa CFC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Nikola', 'Ninkovic', 1994, 1.82, 'Serbia', 1000000, 'AS', 99, 'Genoa CFC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Raffaele', 'Palladino', 1984, 1.80, 'Italia', 400000, 'AS', 11, 'Genoa CFC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Goran', 'Pandev', 1983, 1.84, 'Macedonia', 400000, 'SP', 27, 'Genoa CFC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Giovanni', 'Simeone', 1995, 1.79, 'Argentina', 8000000, 'PC', 9, 'Genoa CFC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Andrea', 'Beghetti', 1994, 1.82, 'Italia', 600000, 'ES', 16, 'Genoa CFC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Mauricio', 'Pinilla', 1984, 1.87, 'Cile', 1000000, 'PC', 51, 'Genoa CFC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Samir', 'Handanovic', 1984, 1.93, 'Slovenia', 12500000, 'POR', 1, 'FC Internazionale', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Juan Pablo', 'Carrizo', 1984, 1.89, 'Argentina', 500000, 'POR', 30, 'FC Internazionale', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Andrei', 'Radu', 1997, 1.88, 'Romania', 300000, 'POR', 97, 'FC Internazionale', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Jeison', 'Murillo', 1992, 1.82, 'Colombia', 14000000, 'DC', 24, 'FC Internazionale', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Joao', 'Miranda', 1984, 1.86, 'Brasile', 14000000, 'DC', 25, 'FC Internazionale', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Gary', 'Medel', 1987, 1.71, 'Cile', 13000000, 'DC', 17, 'FC Internazionale', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Marco', 'Andreolli', 1986, 1.87, 'Italia', 2000000, 'DC', 2, 'FC Internazionale', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Eloge', 'Yao', 1996, 1.82, 'Costa D\'Avorio', 1800000, 'DC', 94, 'FC Internazionale', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Cristian', 'Ansaldi', 1986, 1.81, 'Argentina', 6000000, 'TS', 15, 'FC Internazionale', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Davide', 'Santon', 1991, 1.86, 'Italia', 5500000, 'TS', 21, 'FC Internazionale', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Yuto', 'Nagatomo', 1986, 1.70, 'Giappone', 4300000, 'TS', 55, 'FC Internazionale', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Danilo', 'D\'Ambrosio', 1988, 1.80, 'Italia', 10000000, 'TD', 33, 'FC Internazionale', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Joao', 'Mario', 1993, 1.79, 'Portogallo', 35000000, 'CC', 6, 'FC Internazionale', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Marcelo', 'Brozovic', 1992, 1.81, 'Croazia', 22000000, 'CC', 77, 'FC Internazionale', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Geoffrey', 'Kondogbia', 1993, 1.88, 'Francia', 19000000, 'CC', 7, 'FC Internazionale', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Roberto', 'Gagliardini', 1994, 1.88, 'Italia', 15000000, 'CC', 5, 'FC Internazionale', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Ever', 'Banega', 1988, 1.74, 'Argentina', 19000000, 'TRQ', 19, 'FC Internazionale', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Ivan', 'Perisic', 1989, 1.87, 'Croazia', 25000000, 'AS', 44, 'FC Internazionale', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Eder', 'Martins', 1986, 1.78, 'Italia', 11000000, 'AS', 23, 'FC Internazionale', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Andrea', 'Candreva', 1987, 1.81, 'Italia', 23000000, 'AD', 87, 'FC Internazionale', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Gabriel', 'Barbosa', 1996, 1.78, 'Brasile', 20000000, 'AD', 96, 'FC Internazionale', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Jonathan', 'Biabiany', 1988, 1.77, 'Francia', 4000000, 'AD', 11, 'FC Internazionale', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Mauro', 'Icardi', 1993, 1.81, 'Argentina', 50000000, 'PC', 9, 'FC Internazionale', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Rodrigo', 'Palacio', 1982, 1.75, 'Argentina', 1000000, 'PC', 8, 'FC Internazionale', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Andrea', 'Pinamonti', 1999, 1.85, 'Italia', 500000, 'PC', 99, 'FC Internazionale', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Norberto', 'Neto', 1989, 1.91, 'Brasile', 6000000, 'POR', 25, 'Juventus FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Gianluigi', 'Buffon', 1978, 1.92, 'Italia', 2000000, 'POR', 1, 'Juventus FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Emil', 'Audero', 1997, 1.90, 'Italia', 300000, 'POR', 32, 'Juventus FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Leonardo', 'Bonucci', 1992, 1.90, 'Italia', 40000000, 'DC', 19, 'Juventus FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Daniele', 'Rugani', 1994, 1.90, 'Italia', 17000000, 'DC', 24, 'Juventus FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Medhi', 'Benatia', 1987, 1.90, 'Marocco', 15000000, 'DC', 4, 'Juventus FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Giorgio', 'Chiellini', 1984, 1.87, 'Italia', 10000000, 'DC', 3, 'Juventus FC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Andrea', 'Barzagli', 1981, 1.87, 'Italia', 2000000, 'DC', 15, 'Juventus FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Alex', 'Sandro', 1991, 1.81, 'Brasile', 30000000, 'TS', 12, 'Juventus FC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Daniel', 'Alves', 1983, 1.72, 'Brasile', 6000000, 'TD', 23, 'Juventus FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Stephan', 'Lichsteiner', 1984, 1.82, 'Svizzera', 4000000, 'TD', 26, 'Juventus FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Tomas', 'Rincon', 1988, 1.77, 'Venezuela', 9000000, 'MED', 28, 'Juventus FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Rolando', 'Mandragora', 1997, 1.83, 'Italia', 3000000, 'MED', 38, 'Juventus FC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Miralem', 'Pjanic', 1990, 1.80, 'Bosnia', 38000000, 'CC', 5, 'Juventus FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Claudio', 'Marchisio', 1986, 1.80, 'Italia', 28000000, 'CC', 8, 'Juventus FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Sami', 'Khedira', 1987, 1.89, 'Germania', 23000000, 'CC', 6, 'Juventus FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Stefano', 'Sturaro', 1993, 1.81, 'Italia', 11500000, 'CC', 27, 'Juventus FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Kwadwo', 'Asamoah', 1988, 1.73, 'Ghana', 11000000, 'CC', 22, 'Juventus FC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Mario', 'Lemina', 1993, 1.84, 'Gabon', 8000000, 'CC', 18, 'Juventus FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Federico', 'Mattiello', 1995, 1.82, 'Italia', 400000, 'ED', 14, 'Juventus FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Marko', 'Pjaca', 1995, 1.86, 'Croazia', 18000000, 'AS', 20, 'Juventus FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Juan', 'Cuadrado', 1988, 1.78, 'Colombia', 25000000, 'AD', 7, 'Juventus FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Paulo', 'Dybala', 1993, 1.77, 'Argentina', 50000000, 'SP', 21, 'Juventus FC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Gonzalo', 'Higuain', 1987, 1.84, 'Argentina', 75000000, 'PC', 9, 'Juventus FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Mario', 'Mandzukic', 1986, 1.90, 'Croazia', 18000000, 'PC', 17, 'Juventus FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Federico', 'Marchetti', 1983, 1.88, 'Italia', 3000000, 'POR', 22, 'SS Lazio', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Thomas', 'Strakosha', 1995, 1.86, 'Albania', 2500000, 'POR', 1, 'SS Lazio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Ivan', 'Vargic', 1987, 1.92, 'Croazia', 1200000, 'POR', 55, 'SS Lazio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Stefan', 'de Vraj', 1992, 1.89, 'Olanda', 20000000, 'DC', 3, 'SS Lazio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Wallace', 'dos Santos', 1994, 1.91, 'Brasile', 8000000, 'DC', 13, 'SS Lazio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Wesley', 'Hoedt', 1994, 1.88, 'Olanda', 6000000, 'DC', 2, 'SS Lazio', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Jacinto Batolomeu', 'Quassiga', 1991, 1.80, 'Angola', 4000000, 'DC', 15, 'SS Lazio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Stefan', 'Radu', 1986, 1.83, 'Romania', 6000000, 'TS', 26, 'SS Lazio', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Jordan', 'Lukaku', 1994, 1.77, 'Belgio', 3800000, 'TS', 6, 'SS Lazio', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Dusan', 'Basta', 1984, 1.83, 'Serbia', 3500000, 'TD', 8, 'SS Lazio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Sergio', 'Patric', 1993, 1.84, 'Spagna', 1000000, 'TD', 4, 'SS Lazio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Lucas', 'Biglia', 1986, 1.78, 'Argentina', 20000000, 'MED', 20, 'SS Lazio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Sergej', 'Milinkovic-Savic', 1995, 1.91, 'Serbia', 15000000, 'CC', 21, 'SS Lazio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Marco', 'Parolo', 1985, 1.84, 'Italia', 7000000, 'CC', 16, 'SS Lazio', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Alessandro', 'Murgia', 1996, 1.85, 'Italia', 1000000, 'CC', 96, 'SS Lazio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Abukar', 'Mohamed', 1999, 1.86, 'Finlandia', 50000, 'CC', 99, 'SS Lazio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Felipe', 'Anderson', 1993, 1.75, 'Brasile', 24000000, 'ED', 10, 'SS Lazio', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Senad', 'Lulic', 1986, 1.83, 'Bosnia', 7000000, 'ED', 19, 'SS Lazio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Luca', 'Crecco', 1995, 1.83, 'Italia', 650000, 'ES', 11, 'SS Lazio', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Luis', 'Alberto', 1992, 1.83, 'Spagna', 4000000, 'TRQ', 18, 'SS Lazio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Keita', 'Baldè', 1995, 1.84, 'Senegal', 17000000, 'AS', 14, 'SS Lazio', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Cristiano', 'Lombardi', 1995, 1.80, 'Italia', 500000, 'SP', 18, 'SS Lazio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Ciro', 'Immobile', 1990, 1.85, 'Italia', 15000000, 'PC', 17, 'SS Lazio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Filip', 'Djordjevic', 1987, 1.86, 'Serbia', 2800000, 'PC', 9, 'SS Lazio', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Mamadou', 'Toukara', 1996, 1.84, 'Spagna', 400000, 'PC', 71, 'SS Lazio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Gianluca', 'Donnarumma', 1999, 1.96, 'Italia', 20000000, 'POR', 99, 'AC Milan', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Marco', 'Storari', 1977, 1.87, 'Italia', 400000, 'POR', 30, 'AC Milan', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Alessio', 'Romagnoli', 1995, 1.88, 'Italia', 25000000, 'DC', 13, 'AC Milan', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Gabriel', 'Paletta', 1986, 1.87, 'Argentina', 6500000, 'DC', 29, 'AC Milan', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Gustavo', 'Gomez', 1993, 1.85, 'Paraguay', 6000000, 'DC', 15, 'AC Milan', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Cristian', 'Zapata', 1986, 1.87, 'Colombia', 2500000, 'DC', 17, 'AC Milan', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Luca', 'Antonelli', 1987, 1.84, 'Italia', 6500000, 'TS', 31, 'AC Milan', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Leonel', 'Vangioni', 1987, 1.81, 'Argentina', 2000000, 'TS', 21, 'AC Milan', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Mattia', 'De Sciglio', 1992, 1.83, 'Italia', 8500000, 'TD', 2, 'AC Milan', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Ignazio', 'Abate', 1986, 1.80, 'Italia', 8000000, 'TD', 20, 'AC Milan', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Manuel', 'Locatelli', 1998, 1.86, 'Italia', 5000000, 'MED', 73, 'AC Milan', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Riccardo', 'Montolivo', 1985, 1.82, 'Italia', 3500000, 'MED', 18, 'AC Milan', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Giacomo', 'Bonaventura', 1989, 1.80, 'Italia', 24000000, 'CC', 5, 'AC Milan', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Andrea', 'Bertolacci', 1991, 1.79, 'Italia', 10000000, 'CC', 91, 'AC Milan', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Juraj', 'Kucka', 1987, 1.86, 'Slovenia', 9000000, 'CC', 33, 'AC Milan', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Mario', 'Pasalic', 1995, 1.88, 'Croazia', 6500000, 'CC', 80, 'AC Milan', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Matias', 'Fernandez', 1986, 1.78, 'Cile', 5500000, 'CC', 14, 'AC Milan', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Andrea', 'Poli', 1989, 1.82, 'Italia', 4500000, 'CC', 16, 'AC Milan', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Jose', 'Sosa', 1985, 1.79, 'Argentina', 6000000, 'TRQ', 23, 'AC Milan', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Lucas', 'Ocampos', 1994, 1.87, 'Argentina', 6000000, 'AS', 11, 'AC Milan', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Jesús Joaquín', 'Sáez de la Torre', 1993, 1.77, 'Spagna', 13000000, 'AD', 8, 'AC Milan', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Gerard', 'Deulofeu', 1994, 1.74, 'Spagna', 9000000, 'AD', 7, 'AC Milan', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Keisuke', 'Honda', 1986, 1.82, 'Giappone', 3500000, 'AD', 10, 'AC Milan', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Carlos', 'Bacca', 1986, 1.81, 'Colombia', 23000000, 'PC', 70, 'AC Milan', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Gianluca', 'Lapadula', 1990, 1.78, 'Italia', 8000000, 'PC', 9, 'AC Milan', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Pepe', 'Reina', 1982, 1.88, 'Spagna', 3000000, 'POR', 25, 'SSC Napoli', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Luigi', 'Sepe', 1991, 1.85, 'Italia', 2800000, 'POR', 22, 'SSC Napoli', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Rafael', 'Barbosa', 1990, 1.86, 'Brasile', 1700000, 'POR', 1, 'SSC Napoli', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Kalidou', 'Koulibaly', 1991, 1.87, 'Senegal', 30000000, 'DC', 26, 'SSC Napoli', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Nikola', 'Maksimovic', 1991, 1.93, 'Serbia', 12000000, 'DC', 19, 'SSC Napoli', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Raul', 'Albiol', 1985, 1.90, 'Spagna', 8500000, 'DC', 33, 'SSC Napoli', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Lorenzo', 'Tonelli', 1990, 1.83, 'Italia', 8000000, 'DC', 62, 'SSC Napoli', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Vlad', 'Chiriches', 1989, 1.84, 'Romania', 6500000, 'DC', 21, 'SSC Napoli', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Faouzi', 'Ghoulam', 1991, 1.84, 'Algeria', 15000000, 'TS', 31, 'SSC Napoli', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Ivan', 'Strinic', 1987, 1.86, 'Croazia', 4500000, 'TS', 3, 'SSC Napoli', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Elseid', 'Hysaj', 1994, 1.82, 'Albania', 14000000, 'TD', 2, 'SSC Napoli', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Christian', 'Maggio', 1982, 1.84, 'Italia', 500000, 'TD', 11, 'SSC Napoli', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Jorge Luiz Frello ', 'Jorginho', 1991, 1.80, 'Brasile', 19000000, 'MED', 8, 'SSC Napoli', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Amadou', 'Diawara', 1997, 1.83, 'Guinea', 15000000, 'MED', 42, 'SSC Napoli', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Marek', 'Hamsik', 1987, 1.83, 'Slovacchia', 40000000, 'CC', 17, 'SSC Napoli', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Allan', 'Loureiro', 1991, 1.75, 'Brasile', 16000000, 'CC', 5, 'SSC Napoli', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Piotr', 'Zielinski', 1994, 1.80, 'Polonia', 16000000, 'CC', 20, 'SSC Napoli', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Marko', 'Rog', 1995, 1.80, 'Croazia', 8000000, 'CC', 30, 'SSC Napoli', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Emanuele', 'Giaccherini', 1985, 1.67, 'Italia', 2500000, 'ED', 4, 'SSC Napoli', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Lorenzo', 'Insigne', 1991, 1.63, 'Italia', 28000000, 'AS', 24, 'SSC Napoli', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Dries', 'Mertens', 1987, 1.69, 'Belgio', 25000000, 'AS', 14, 'SSC Napoli', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Leandro Henrique', 'do Nascimento', 1998, 1.74, 'Brasile', 750000, 'AS', 18, 'SSC Napoli', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Josè', 'Callejon', 1987, 1.78, 'Spagna', 23000000, 'AD', 7, 'SSC Napoli', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Arkadiusz', 'Milik', 1994, 1.86, 'Polonia', 20000000, 'PC', 99, 'SSC Napoli', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES (  'Leonardo', 'Pavoletti', 1988, 1.88, 'Italia', 13000000, 'PC', 32, 'SSC Napoli', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Josip', 'Posavec', 1996, 1.90, 'Croazia', 2000000, 'POR', 1, 'US Città di Palermo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Leonardo', 'Marson', 1998, 1.94, 'Italia', 100000, 'POR', 55, 'US Città di Palermo', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Andrea', 'Fulignati', 1994, 1.88, 'Italia', 100000, 'POR', 68, 'US Città di Palermo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Giancarlo', 'Gonzalez', 1988, 1.86, 'Costa Rica', 2500000, 'DC', 12, 'US Città di Palermo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Edoardo', 'Goldaniga', 1993, 1.88, 'Italia', 2000000, 'DC', 6, 'US Città di Palermo', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Slobodan', 'Rajkovic', 1989, 1.91, 'Serbia', 1300000, 'DC', 5, 'US Città di Palermo', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Toni', 'Sunjic', 1988, 1.93, 'Bosnia', 1000000, 'DC', 44, 'US Città di Palermo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Thiago', 'Cionek', 1986, 1.84, 'Polonia', 750000, 'DC', 15, 'US Città di Palermo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Sinisa', 'Andelkovic', 1986, 1.86, 'Slovenia', 650000, 'DC', 4, 'US Città di Palermo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Roberto', 'Vitiello', 1983, 1.76, 'Italia', 300000, 'DC', 2, 'US Città di Palermo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Giuseppe', 'Pezzella', 1997, 1.87, 'Italia', 500000, 'TS', 97, 'US Città di Palermo', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Haitam', 'Aleesami', 1991, 1.81, 'Norvegia', 1800000, 'TS', 19, 'US Città di Palermo', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Andrea', 'Rispoli', 1988, 1.83, 'Italia', 1000000, 'TD', 3, 'US Città di Palermo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Michel', 'Morganella', 1989, 1.84, 'Svizzera', 800000, 'TD', 89, 'US Città di Palermo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Bruno', 'Henrique', 1989, 1.80, 'Brasile', 2700000, 'MED', 25, 'US Città di Palermo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Mato', 'Jajalo', 1988, 1.80, 'Bosnia', 1000000, 'MED', 28, 'US Città di Palermo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Alessandro', 'Gazzi', 1983, 1.84, 'Italia', 500000, 'MED', 14, 'US Città di Palermo', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Ivaylo', 'Chochev', 1993, 1.87, 'Bulgaria', 1800000, 'CC', 18, 'US Città di Palermo', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Roland', 'Sallai', 1997, 1.80, 'Bulgaria', 1000000, 'TRQ', 20, 'US Città di Palermo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Carlos', 'Embalo', 1994, 1.77, 'Guinea-Bissau', 2000000, 'AS', 11, 'US Città di Palermo', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Alexandar', 'Trajkovski', 1992, 1.79, 'Macedonia', 1000000, 'AS', 8, 'US Città di Palermo', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Alessandro', 'Diamanti', 1983, 1.80, 'Italia', 500000, 'SP', 23, 'US Città di Palermo', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Simone', 'Lo Faso', 1998, 1.80, 'Italia', 300000, 'SP', 98, 'US Città di Palermo', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Ilija', 'Nestorovski', 1990, 1.82, 'Macedonia', 3500000, 'PC', 30, 'US Città di Palermo', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Norbert', 'Balogh', 1996, 1.97, 'Bulgaria', 1400000, 'PC', 22, 'US Città di Palermo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Vincenzo', 'Fiorillo', 1990, 1.90, 'Italia', 600000, 'POR', 1, 'Delfino Pescara 1936', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Albano', 'Bizzarri', 1977, 1.88, 'Italia', 200000, 'POR', 31, 'Delfino Pescara 1936', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Michele', 'Fornasier', 1993, 1.86, 'Italia', 800000, 'DC', 44, 'Delfino Pescara 1936', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Cesare', 'Bovo', 1983, 1.81, 'Italia', 500000, 'DC', 83, 'Delfino Pescara 1936', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Guglielmo', 'Stendardo', 1981, 1.90, 'Italia', 300000, 'DC', 86, 'Delfino Pescara 1936', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Hugo', 'Campagnaro', 1980, 1.81, 'Argentina', 200000, 'DC', 14, 'Delfino Pescara 1936', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Andrea', 'Coda', 1985, 1.88, 'Italia', 200000, 'DC', 35, 'Delfino Pescara 1936', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Cristiano', 'Biraghi', 1992, 1.84, 'Italia', 2500000, 'DC', 3, 'Delfino Pescara 1936', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Alessandro', 'Crescenzi', 1991, 1.78, 'Italia', 2000000, 'TS', 2, 'Delfino Pescara 1936', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Francesco', 'Zampano', 1993, 1.77, 'Italia', 2500000, 'TD', 11, 'Delfino Pescara 1936', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Davide', 'Vitturini', 1997, 1.80, 'Italia', 650000, 'TD', 26, 'Delfino Pescara 1936', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Andres', 'Cubas', 1996, 1.65, 'Argentina', 3500000, 'MED', 36, 'Delfino Pescara 1936', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Gaston', 'Brugman', 1992, 1.75, 'Uruguay', 1500000, 'MED', 16, 'Delfino Pescara 1936', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Valerio', 'Verre', 1994, 1.81, 'Italia', 4000000, 'CC', 7, 'Delfino Pescara 1936', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Ledian', 'Memushaj', 1986, 1.75, 'Albania', 2300000, 'CC', 8, 'Delfino Pescara 1936', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Sulley', 'Muntari', 1984, 1.79, 'Ghana', 1000000, 'CC', 13, 'Delfino Pescara 1936', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Ahmed', 'Benali', 1992, 1.73, 'Libia', 2500000, 'TRQ', 10, 'Delfino Pescara 1936', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Alexandru', 'Mitrita', 1995, 1.69, 'Romania', 700000, 'TRQ', 28, 'Delfino Pescara 1936', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Simone', 'Pepe', 1983, 1.78, 'Italia', 400000, 'AD', 21, 'Delfino Pescara 1936', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Ferdinando', 'Del Sole', 1998, 1.79, 'Italia', 200000, 'AD', 98, 'Delfino Pescara 1936', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Gianluca', 'Caprari', 1993, 1.71, 'Italia', 4500000, 'SP', 17, 'Delfino Pescara 1936', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Robert', 'Muric', 1996, 1.80, 'Croazia', 800000, 'AD', 30, 'Delfino Pescara 1936', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Jean-Christophe', 'Behabeck', 1993, 1.82, 'Francia', 2300000, 'PC', 15, 'Delfino Pescara 1936', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Alberto', 'Cerri', 1996, 1.94, 'Italia', 2200000, 'PC', 20, 'Delfino Pescara 1936', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Alberto', 'Gilardino', 1982, 1.84, 'Italia', 500000, 'PC', 19, 'Delfino Pescara 1936', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Wojciech', 'Szczesny', 1990, 1.96, 'Polonia', 14000000, 'POR', 1, 'AS Roma', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Alisson', 'Ramses Becker', 1992, 1.91, 'Brasile', 7000000, 'POR', 19, 'AS Roma', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Bogdan', 'Lobont', 1978, 1.85, 'Romania', 100000, 'POR', 18, 'AS Roma', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Konstantinos', 'Manolas', 1991, 1.89, 'Grecia', 28000000, 'DC', 44, 'AS Roma', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Antonio', 'Rudiger', 1993, 1.91, 'Germania', 18000000, 'DC', 2, 'AS Roma', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Federico', 'Fazio', 1987, 1.95, 'Argentina', 9000000, 'DC', 20, 'AS Roma', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Juan', 'Jesus', 1991, 1.85, 'Brasile', 7500000, 'DC', 3, 'AS Roma', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Thomas', 'Vermaelen', 1985, 1.83, 'Belgio', 4000000, 'DC', 15, 'AS Roma', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Mario', 'Rui', 1991, 1.70, 'Portogallo', 8000000, 'TS', 21, 'AS Roma', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Emerson', 'dos Santos', 1994, 1.76, 'Brasile', 6000000, 'TS', 33, 'AS Roma', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Bruno', 'Peres', 1990, 1.78, 'Brasile', 13000000, 'TD', 13, 'AS Roma', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Abdullahi', 'Nura', 1997, 1.82, 'Nigeria', 900000, 'TD', 99, 'AS Roma', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Leandro', 'Paredes', 1994, 1.80, 'Argentina', 10000000, 'MED', 5, 'AS Roma', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Daniele', 'De Rossi', 1983, 1.85, 'Italia', 5000000, 'MED', 16, 'AS Roma', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Radja', 'Nainggolan', 1988, 1.75, 'Belgio', 40000000, 'CC', 4, 'AS Roma', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Kevin', 'Strootman', 1990, 1.86, 'Olanda', 20000000, 'CC', 6, 'AS Roma', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Alessandro', 'Florenzi', 1991, 1.73, 'Italia', 20000000, 'CC', 24, 'AS Roma', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Clement', 'Grenier', 1991, 1.86, 'Francia', 3500000, 'CC', 7, 'AS Roma', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Gerson', 'Santos da Silva', 1997, 1.84, 'Brasile', 9000000, 'TRQ', 30, 'AS Roma', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Diego', 'Perotti', 1988, 1.79, 'Argentina', 18000000, 'AS', 8, 'AS Roma', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Stephan', 'El Shaarawy', 1992, 1.78, 'Italia', 16000000, 'AS', 92, 'AS Roma', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Mohamed', 'Salah', 1992, 1.75, 'Egitto', 30000000, 'AD', 11, 'AS Roma', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Edin', 'Dzeko', 1986, 1.92, 'Bosnia', 18000000, 'PC', 9, 'AS Roma', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Francesco', 'Totti', 1976, 1.80, 'Italia', 1000000, 'PC', 10, 'AS Roma', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Emiliano', 'Viviano', 1985, 1.95, 'Italia', 5000000, 'POR', 2, 'UC Sampdoria', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Christian', 'Puggioni', 1981, 1.87, 'Italia', 300000, 'POR', 1, 'UC Sampdoria', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Wladimiro', 'Falcone', 1995, 1.95, 'Italia', 200000, 'POR', 30, 'UC Sampdoria', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Titas', 'Krapikas', 1999, 1.95, 'Lituania', 100000, 'POR', 12, 'UC Sampdoria', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Milan', 'Skriniar', 1995, 1.87, 'Slovacchia', 4000000, 'DC', 37, 'UC Sampdoria', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Matias', 'Silvestre', 1984, 1.85, 'Argentina', 2000000, 'DC', 26, 'UC Sampdoria', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Lorenco', 'Simic', 1996, 1.95, 'Croazia', 1000000, 'DC', 4, 'UC Sampdoria', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'José Rodolfo', 'Ribeiro Dodo', 1992, 1.77, 'Brasile', 3000000, 'TS', 5, 'UC Sampdoria', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Vasco', 'Regini', 1990, 1.85, 'Italia', 2500000, 'TS', 19, 'UC Sampdoria', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Daniel', 'Pavlovic', 1988, 1.83, 'Bosnia', 800000, 'TS', 20, 'UC Sampdoria', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Jacopo', 'Sala', 1991, 1.81, 'Italia', 2500000, 'TD', 22, 'UC Sampdoria', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Bartosz', 'Bereszynski', 1992, 1.82, 'Polonia', 1500000, 'TD', 24, 'UC Sampdoria', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Lucas', 'Torreira', 1996, 1.67, 'Uruguay', 6000000, 'MED', 34, 'UC Sampdoria', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Luca', 'Cigarini', 1986, 1.75, 'Italia', 3000000, 'MED', 21, 'UC Sampdoria', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Angelo', 'Palombo', 1981, 1.77, 'Italia', 300000, 'MED', 17, 'UC Sampdoria', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Dennis', 'Praet', 1994, 1.81, 'Belgio', 9000000, 'CC', 18, 'UC Sampdoria', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Karol', 'Linetty', 1995, 1.76, 'Polonia', 6000000, 'CC', 16, 'UC Sampdoria', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Edgar', 'Barreto', 1984, 1.80, 'Paraguay', 1500000, 'CC', 8, 'UC Sampdoria', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Bruno', 'Fernandes', 1994, 1.79, 'Portogallo', 7000000, 'TRQ', 10, 'UC Sampdoria', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Ricardo', 'Alvarez', 1988, 1.88, 'Argentina', 5000000, 'TRQ', 11, 'UC Sampdoria', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Filip', 'Djuricic', 1992, 1.81, 'Serbia', 3000000, 'TRQ', 23, 'UC Sampdoria', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Luis', 'Muriel', 1991, 1.79, 'Colombia', 17000000, 'PC', 9, 'UC Sampdoria', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Patrik', 'Schick', 1996, 1.87, 'Rep.Ceca', 7000000, 'PC', 14, 'UC Sampdoria', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Fabio', 'Quagliarella', 1983, 1.82, 'Italia', 2000000, 'PC', 27, 'UC Sampdoria', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Ante', 'Budmir', 1991, 1.90, 'Croazia', 2000000, 'PC', 47, 'UC Sampdoria', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Andrea', 'Consigli', 1987, 1.89, 'Italia', 8000000, 'POR', 47, 'US Sassuolo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Gianluca', 'Pegolo', 1981, 1.83, 'Italia', 300000, 'POR', 79, 'US Sassuolo', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Francesco', 'Acerbi', 1988, 1.92, 'Italia', 10000000, 'DC', 15, 'US Sassuolo', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Timo', 'Letschert', 1993, 1.88, 'Olanda', 3000000, 'DC', 55, 'US Sassuolo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Luca', 'Antei', 1992, 1.86, 'Italia', 1400000, 'DC', 5, 'US Sassuolo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Paolo', 'Cannavaro', 1981, 1.85, 'Italia', 400000, 'DC', 28, 'US Sassuolo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Federico', 'Peluso', 1984, 1.88, 'Italia', 1000000, 'TS', 13, 'US Sassuolo', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Cristian', 'Dell\'Orco', 1994, 1.83, 'Italia', 1000000, 'TS', 39, 'US Sassuolo', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Pol', 'Lirola', 1997, 1.83, 'Spagna', 2500000, 'TD', 20, 'US Sassuolo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Claud', 'Adjapong', 1998, 1.80, 'Ghana', 700000, 'TD', 98, 'US Sassuolo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Marcello', 'Gazzola', 1985, 1.83, 'Italia', 400000, 'TD', 23, 'US Sassuolo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Stefano', 'Sensi', 1995, 1.68, 'Italia', 4000000, 'MED', 12, 'US Sassuolo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Francesco', 'Magnanelli', 1984, 1.82, 'Italia', 3000000, 'MED', 4, 'US Sassuolo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Luca', 'Mazzitelli', 1995, 1.84, 'Italia', 2000000, 'MED', 22, 'US Sassuolo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Lorenzo', 'Pellegrini', 1996, 1.86, 'Italia', 8000000, 'CC', 6, 'US Sassuolo', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Alfred', 'Duncan', 1991, 1.78, 'Ghana', 8000000, 'CC', 32, 'US Sassuolo', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Simone', 'Missiroli', 1986, 1.91, 'Italia', 500000, 'CC', 7, 'US Sassuolo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Alberto', 'Aquilani', 1984, 1.86, 'Italia', 1500000, 'CC', 21, 'US Sassuolo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Antonino', 'Ragusa', 1990, 1.83, 'Italia', 2000000, 'AS', 90, 'US Sassuolo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Domenico', 'Berardi', 1994, 1.83, 'Italia', 20000000, 'AD', 25, 'US Sassuolo', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Matteo', 'Politano', 1993, 1.71, 'Italia', 5000000, 'AD', 16, 'US Sassuolo', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Federico', 'Ricci', 1994, 1.75, 'Italia', 4000000, 'AD', 27, 'US Sassuolo', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Gregoire', 'Defrel', 1991, 1.79, 'Francia', 9000000, 'PC', 11, 'US Sassuolo', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Pietro', 'Iammello', 1992, 1.80, 'Italia', 1000000, 'PC', 9, 'US Sassuolo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Alessandro', 'Matri', 1984, 1.83, 'Italia', 900000, 'PC', 10, 'US Sassuolo', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Joe', 'Hart', 1987, 1.96, 'Inghilterra', 15000000, 'POR', 21, 'Torino FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Daniele', 'Padelli', 1985, 1.91, 'Italia', 1000000, 'POR', 1, 'Torino FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Leandro', 'Castan', 1986, 1.86, 'Brasile', 6500000, 'DC', 4, 'Torino FC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Luca', 'Rossettini', 1985, 1.87, 'Italia', 2500000, 'DC', 13, 'Torino FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Arlind', 'Ajeti', 1993, 1.84, 'Albania', 1800000, 'DC', 93, 'Torino FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Carlos Roberto', 'Carlao', 1986, 1.83, 'Brasile', 800000, 'DC', 5, 'Torino FC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Emiliano', 'Moretti', 1981, 1.82, 'Italia', 500000, 'DC', 24, 'Torino FC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Antonio', 'Berreca', 1995, 1.80, 'Italia', 3000000, 'TS', 23, 'Torino FC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Danilo', 'Avelar', 1989, 1.85, 'Brasile', 2000000, 'TS', 26, 'Torino FC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Cristian', 'Molinaro', 1983, 1.82, 'Italia', 400000, 'TS', 9, 'Torino FC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Davide', 'Zappacosta', 1992, 1.82, 'Italia', 6000000, 'TD', 7, 'Torino FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Lorenzo', 'De Silvestri', 1988, 1.86, 'Italia', 4000000, 'TD', 29, 'Torino FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Mirko', 'Valdifiori', 1986, 1.85, 'Italia', 4000000, 'MED', 18, 'Torino FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Sasa', 'Lukic', 1996, 1.83, 'Serbia', 1500000, 'MED', 25, 'Torino FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Marco', 'Benassi', 1994, 1.84, 'Italia', 10000000, 'CC', 15, 'Torino FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Daniele', 'Baselli', 1992, 1.82, 'Italia', 7000000, 'CC', 8, 'Torino FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Afriyie', 'Acquah', 1992, 1.79, 'Ghana', 2800000, 'CC', 6, 'Torino FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ('Joel', 'Obi', 1991, 1.77, 'Nigeria', 1500000, 'CC', 22, 'Torino FC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Samuel', 'Gustafson', 1995, 1.87, 'Svezia', 700000, 'CC', 16, 'Torino FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Adem', 'Ljajic', 1991, 1.81, 'Serbia', 11000000, 'AS', 10, 'Torino FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Iago', 'Falque', 1990, 1.74, 'Spagna', 8500000, 'AD', 14, 'Torino FC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Juan', 'Iturbe', 1993, 1.72, 'Argentina', 8000000, 'AD', 19, 'Torino FC', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Andrea', 'Belotti', 1993, 1.81, 'Italia', 30000000, 'PC', 9, 'Torino FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Lucas', 'Boyè', 1996, 1.80, 'Argentina', 2500000, 'PC', 31, 'Torino FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Maxi', 'Lopez', 1984, 1.85, 'Argentina', 800000, 'PC', 11, 'Torino FC', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Orestis', 'Karnezis', 1985, 1.90, 'Grecia', 5000000, 'POR', 1, 'Udinese Calcio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Simone', 'Scuffet', 1996, 1.87, 'Italia', 4000000, 'POR', 22, 'Udinese Calcio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Samir', 'de Souza Santos', 1994, 1.88, 'Brasile', 6000000, 'DC', 3, 'Udinese Calcio', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Thomas', 'Heurtaux', 1988, 1.83, 'Francia', 3300000, 'DC', 75, 'Udinese Calcio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Danilo', 'Larangeira', 1984, 1.84, 'Brasile', 3000000, 'DC', 5, 'Udinese Calcio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Gabriele', 'Angella', 1989, 1.89, 'Italia', 1500000, 'DC', 4, 'Udinese Calcio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ('Felipe', 'da Silva dal Belo', 1984, 1.88, 'Brasile', 800000, 'DC', 30, 'Udinese Calcio', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Gabriel', 'Silva', 1991, 1.79, 'Brasile', 3000000, 'TS', 34, 'Udinese Calcio', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Ali', 'Adnan', 1991, 1.85, 'Egitto', 2000000, 'TS', 53, 'Udinese Calcio', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Silvan', 'Widmer', 1993, 1.82, 'Svizzera', 7500000, 'TD', 27, 'Udinese Calcio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Sven', 'Kums', 1988, 1.76, 'Belgio', 5500000, 'MED', 26, 'Udinese Calcio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Seko', 'Fofana', 1995, 1.83, 'Costa D\'Avorio', 6000000, 'CC', 6, 'Udinese Calcio', DEFAULT, 'E');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Emmanuel', 'Badu', 1990, 1.73, 'Ghana', 5500000, 'CC', 8, 'Udinese Calcio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Jakub', 'Jankto', 1996, 1.84, 'Rep.Ceca', 4000000, 'CC', 14, 'Udinese Calcio', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Emil', 'Hallfredsson', 1984, 1.85, 'Islanda', 1600000, 'CC', 23, 'Udinese Calcio', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Assane', 'Gnoukouri', 1996, 1.80, 'Costa D\'Avorio', 1000000, 'CC', 7, 'Udinese Calcio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Davide', 'Faraoni', 1991, 1.80, 'Italia', 1200000, 'ED', 37, 'Udinese Calcio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Andrija', 'Balic', 1997, 1.80, 'Croazia', 3000000, 'TRQ', 99, 'Udinese Calcio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Lucas', 'Evangelista', 1995, 1.81, 'Brasile', 2000000, 'TRQ', 95, 'Udinese Calcio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Rodrigo', 'de Paul', 1994, 1.80, 'Argentina', 3000000, 'AD', 10, 'Udinese Calcio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ('Ewandro', 'de Lima Costa', 1996, 1.74, 'Brasile', 1000000, 'AD', 96, 'Udinese Calcio', DEFAULT, 'S');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Ryder', 'Matos', 1993, 1.81, 'Brasile', 2500000, 'SP', 19, 'Udinese Calcio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Duvan', 'Zapata', 1991, 1.89, 'Colombia', 8000000, 'PC', 9, 'Udinese Calcio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Stipe', 'Perica', 1995, 1.92, 'Croazia', 2500000, 'PC', 18, 'Udinese Calcio', DEFAULT, 'D');
INSERT INTO `Giocatore` (  `Nome`, `cognome`, `nascita`, `altezza`, `nazionalità`, `valoremercato`, `ruolo`, `numero`, `squadra`, `presenze`, `piedepreferito`) VALUES ( 'Cyril', 'Thereau', 1983, 1.89, 'Francia', 1800000, 'PC', 77, 'Udinese Calcio', DEFAULT, 'D');




-- -----------------------------------------------------
-- Data for table `Arbitro`
-- -----------------------------------------------------


INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A01', 'Luca', 'Banti', 'Livorno');
INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A02', 'Gianpaolo', 'Calvarese', 'Teramo');
INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A03', 'Domenico', 'Celi', 'Bari');
INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A04', 'Antonio', 'Damato', 'Barletta');
INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A05', 'Marco', 'Di Bello', 'Brindisi');
INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A06', 'Daniele', 'Doveri', 'Roma 1');
INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A07', 'Michael', 'Fabbri', 'Ravenna');
INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A08', 'Claudio', 'Gavillucci', 'Latina');
INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A09', 'Piero', 'Giacomelli', 'Trieste');
INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A10', 'Marco', 'Guida', 'Torre Annunziata');
INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A11', 'Massimiliano', 'Irrati', 'Pistoia');
INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A12', 'Fabio', 'Maresca', 'Napoli');
INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A13', 'Maurizio', 'Mariani', 'Aprilia');
INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A14', 'Davide', 'Massa', 'Imperia');
INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A15', 'Paolo Silvio', 'Mazzoleni', 'Bergamo');
INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A16', 'Daniele', 'Orsato', 'Schio');
INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A17', 'Luca', 'Pairetto', 'Nichelino');
INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A18', 'Nicola', 'Rizzoli', 'Bologna');
INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A19', 'Gianluca', 'Rocchi', 'Firenze');
INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A20', 'Carmine', 'Russo', 'Nola');
INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A21', 'Paolo', 'Tagliavento', 'Terni');
INSERT INTO `Arbitro` (`idarbitro`, `nome`, `cognome`, `sezione`) VALUES ('A22', 'Paolo', 'Valeri', 'Roma 2');



-- -----------------------------------------------------
-- Data for table `Partita`
-- -----------------------------------------------------


INSERT INTO `Partita` (`idpartita`, `squadracasa`, `squadraospite`, `ngiornata`, `stadio`, `golcasa`, `golospite`, `arbitro`, `campionato`,`datap`, `ora`) VALUES ('G1P1', 'Atalanta BC', 'SS Lazio', 1, 'sit002', 3, 4, 'A01', 'SerieA1617','2018-06-13', '21:00:00');
INSERT INTO `Partita` (`idpartita`, `squadracasa`, `squadraospite`, `ngiornata`, `stadio`, `golcasa`, `golospite`, `arbitro`, `campionato`,`datap`, `ora`) VALUES ('G1P2', 'Bologna FC 1909', 'FC Crotone', 1, 'sit003', 1, 0, 'A08', 'SerieA1617','2018-06-13', '21:00:00');
INSERT INTO `Partita` (`idpartita`, `squadracasa`, `squadraospite`, `ngiornata`, `stadio`, `golcasa`, `golospite`, `arbitro`, `campionato`,`datap`, `ora`) VALUES ('G1P3', 'AC Chievo Verona', 'FC Internazionale', 1, 'sit016', '2', 0, 'A11', 'SerieA1617','2018-06-13', '21:00:00');
INSERT INTO `Partita` (`idpartita`, `squadracasa`, `squadraospite`, `ngiornata`, `stadio`, `golcasa`, `golospite`, `arbitro`, `campionato`,`datap`, `ora`) VALUES ('G1P4', 'Empoli FC', 'UC Sampdoria', 1, 'sit012', 0, 1, 'A13', 'SerieA1617','2018-06-13', '21:00:00');
INSERT INTO `Partita` (`idpartita`, `squadracasa`, `squadraospite`, `ngiornata`, `stadio`, `golcasa`, `golospite`, `arbitro`, `campionato`,`datap`, `ora`) VALUES ('G1P5', 'Genoa CFC', 'Cagliari Calcio', 1, 'sit014', 3, 1, 'A16', 'SerieA1617','2018-06-13', '21:00:00');
INSERT INTO `Partita` (`idpartita`, `squadracasa`, `squadraospite`, `ngiornata`, `stadio`, `golcasa`, `golospite`, `arbitro`, `campionato`,`datap`, `ora`) VALUES ('G1P6', 'US Città di Palermo', 'US Sassuolo', 1, 'sit007', 0, 1, 'A17', 'SerieA1617','2018-06-13', '21:00:00');
INSERT INTO `Partita` (`idpartita`, `squadracasa`, `squadraospite`, `ngiornata`, `stadio`, `golcasa`, `golospite`, `arbitro`, `campionato`,`datap`, `ora`) VALUES ('G1P7', 'Delfino Pescara 1936', 'SSC Napoli', 1, 'sit017', 2, 2, 'A09', 'SerieA1617','2018-06-13', '21:00:00');
INSERT INTO `Partita` (`idpartita`, `squadracasa`, `squadraospite`, `ngiornata`, `stadio`, `golcasa`, `golospite`, `arbitro`, `campionato`,`datap`, `ora`) VALUES ('G1P8', 'AC Milan', 'Torino FC', 1, 'sit004', 3, 2, 'A04', 'SerieA1617','2018-06-13', '21:00:00');
INSERT INTO `Partita` (`idpartita`, `squadracasa`, `squadraospite`, `ngiornata`, `stadio`, `golcasa`, `golospite`, `arbitro`, `campionato`,`datap`, `ora`) VALUES ('G1P9', 'Juventus FC', 'ACF Fiorentina', 1, 'sit001', 2, 1, 'A14', 'SerieA1617','2018-06-13', '21:00:00');
INSERT INTO `Partita` (`idpartita`, `squadracasa`, `squadraospite`, `ngiornata`, `stadio`, `golcasa`, `golospite`, `arbitro`, `campionato`,`datap`, `ora`) VALUES ('GIP10', 'AS Roma', 'Udinese Calcio', 1, 'sit010', 4, 0, 'A05', 'SerieA1617','2018-06-13', '21:00:00');




-- -----------------------------------------------------
-- Data for table `Allenatore`
-- -----------------------------------------------------

INSERT INTO `Allenatore` ( `idT` , `nome`, `cognome`, `nascita`, `salario`, `presenze`, `modulopreferito`, `squadra`, `nazionalità`) VALUES ('AtaAl', 'Gian Piero', 'Gasperini', 1958, 800000, NULL, '3-4-2-1', 'Atalanta BC', 'Italia');
INSERT INTO `Allenatore` ( `idT` , `nome`, `cognome`, `nascita`, `salario`, `presenze`, `modulopreferito`, `squadra`, `nazionalità`) VALUES ('BolAl', 'Roberto', 'Donadoni', 1963, 1000000, NULL, '4-3-3', 'Bologna FC 1909', 'Italia');
INSERT INTO `Allenatore` ( `idT` , `nome`, `cognome`, `nascita`, `salario`, `presenze`, `modulopreferito`, `squadra`, `nazionalità`) VALUES ('CalAl', 'Massimo', 'Rastelli', 1968, 400000, NULL, '4-3-1-2-rombo', 'Cagliari Calcio', 'Italia');
INSERT INTO `Allenatore` ( `idT` , `nome`, `cognome`, `nascita`, `salario`, `presenze`, `modulopreferito`, `squadra`, `nazionalità`) VALUES ('JuvAl', 'Massimiliano', 'Allegri', 1967, 5000000, NULL, '3-5-2', 'Juventus FC', 'Italia');
INSERT INTO `Allenatore` ( `idT` , `nome`, `cognome`, `nascita`, `salario`, `presenze`, `modulopreferito`, `squadra`, `nazionalità`) VALUES ('RomAl', 'Luciano', 'Spaletti', 1959, 3000000, NULL, '4-2-3-1', 'AS Roma', 'Italia');
INSERT INTO `Allenatore` (  `idT` ,`nome`, `cognome`, `nascita`, `salario`, `presenze`, `modulopreferito`, `squadra`, `nazionalità`) VALUES ('MilAl', 'Vincenzo', 'Montella', 1974, 2200000, NULL, '4-3-3', 'AC Milan', 'Italia');
INSERT INTO `Allenatore` ( `idT` , `nome`, `cognome`, `nascita`, `salario`, `presenze`, `modulopreferito`, `squadra`, `nazionalità`) VALUES ('NapAl', 'Maurizio', 'Sarri', 1959, 1400000, NULL, '4-3-3', 'SSC Napoli', 'Italia');
INSERT INTO `Allenatore` ( `idT`, `nome`, `cognome`, `nascita`, `salario`, `presenze`, `modulopreferito`, `squadra`, `nazionalità`) VALUES ('TorAl', 'Sinisa', 'Mihajlovic', 1969, 1500000, NULL, '4-3-3', 'Torino FC', 'Serbia');
INSERT INTO `Allenatore` (  `idT`,`nome`, `cognome`, `nascita`, `salario`, `presenze`, `modulopreferito`, `squadra`, `nazionalità`) VALUES ('FioAl', 'Paulo', 'Sosa', 1970, 1500000, NULL, '3-4-2-1', 'ACF Fiorentina', 'Portogallo');
INSERT INTO `Allenatore` (  `idT`,`nome`, `cognome`, `nascita`, `salario`, `presenze`, `modulopreferito`, `squadra`, `nazionalità`) VALUES ('SasAl', 'Eusebio', 'Di Francesco', 1969, 1000000, NULL, '4-3-3', 'US Sassuolo', 'Italia');
INSERT INTO `Allenatore` (  `idT`,`nome`, `cognome`, `nascita`, `salario`, `presenze`, `modulopreferito`, `squadra`, `nazionalità`) VALUES ('IntAl', 'Stefano', 'Pioli', 1965, 1500000, NULL, '4-2-3-1', 'FC Internazionale', 'Italia');
INSERT INTO `Allenatore` ( `idT`, `nome`, `cognome`, `nascita`, `salario`, `presenze`, `modulopreferito`, `squadra`, `nazionalità`) VALUES ('ChvAl', 'Rolando', 'Maran', 1963, 400000, NULL, '4-3-1-2 rombo', 'AC Chievo Verona', 'Italia');
INSERT INTO `Allenatore` (  `idT`,`nome`, `cognome`, `nascita`, `salario`, `presenze`, `modulopreferito`, `squadra`, `nazionalità`) VALUES ('CroAl', 'Davide', 'Nicola', 1973, 200000, NULL, '4-3-3', 'FC Crotone', 'Italia');
INSERT INTO `Allenatore` (  `idT`,`nome`, `cognome`, `nascita`, `salario`, `presenze`, `modulopreferito`, `squadra`, `nazionalità`) VALUES ('EmpAl', 'Giovanni', 'Martusciello', 1971, 200000, NULL, '4-3-1-2 rombo', 'Empoli FC', 'Italia');
INSERT INTO `Allenatore` (  `idT`,`nome`, `cognome`, `nascita`, `salario`, `presenze`, `modulopreferito`, `squadra`, `nazionalità`) VALUES ('LazAl', 'Simone', 'Inzaghi', 1976, 800000,NULL, '4-3-3', 'SS Lazio', 'Italia');
INSERT INTO `Allenatore` (  `idT`,`nome`, `cognome`, `nascita`, `salario`, `presenze`, `modulopreferito`, `squadra`, `nazionalità`) VALUES ('SmpAl', 'Marco', 'GianPaolo', 1967, 800000, NULL, '4-3-1-2 rombo', 'UC Sampdoria', 'Italia');
INSERT INTO `Allenatore` (  `idT`,`nome`, `cognome`, `nascita`, `salario`, `presenze`, `modulopreferito`, `squadra`, `nazionalità`) VALUES ('UdnAl', 'Luigi', 'Del Neri', 1950, 700000, NULL, '4-3-3', 'Udinese Calcio', 'Italia');
INSERT INTO `Allenatore` (  `idT`,`nome`, `cognome`, `nascita`, `salario`, `presenze`, `modulopreferito`, `squadra`, `nazionalità`) VALUES ('PesAl', 'Zdeněk', 'Zeman', 1947, 500000, NULL, '4-3-3', 'Delfino Pescara 1936', 'Rep.Ceca');
INSERT INTO `Allenatore` (  `idT`,`nome`, `cognome`, `nascita`, `salario`, `presenze`, `modulopreferito`, `squadra`, `nazionalità`) VALUES ('PalAl', 'Diego', 'Bortoluzzi', 1966, 150000, NULL, '4-3-3', 'US Città di Palermo', 'Italia');
INSERT INTO `Allenatore` (  `idT`,`nome`, `cognome`, `nascita`, `salario`, `presenze`, `modulopreferito`, `squadra`, `nazionalità`) VALUES ('GenAl', 'Ivan', 'Juric', 1975, 300000, NULL, '3-4-3', 'Genoa CFC', 'Croazia');




-- -----------------------------------------------------
-- Data for table `Evento`
-- -----------------------------------------------------


INSERT INTO `Evento` (`minuto`, `partita`, `giocatore`, `tipo`, `commento`) VALUES (63, 'G1P1', '14', 'GOL', 'in movimento spacca la difesa e raccoglie un ottimo passaggio, carica il tiro e batte il portiere. La palla termina all\'angolino basso di destra.');
INSERT INTO `Evento` (`minuto`, `partita`, `giocatore`, `tipo`, `commento`) VALUES (67, 'G1P1', '14', 'GOL', ' ribadisce in rete all\'angolino basso di sinistra dopo che il pallone è rimbalzato sui suoi piedi in area');
INSERT INTO `Evento` (`minuto`, `partita`, `giocatore`, `tipo`, `commento`) VALUES (91, 'G1P1', '25', 'GOL', 'riceve palla in area e con grande reattività spara un rasoterra che si infila in rete sulla sinistra');
INSERT INTO `Evento` (`minuto`, `partita`, `giocatore`, `tipo`, `commento`) VALUES (8, 'G1P1', '4', 'OCCASIONE', 'controlla palla al limite, si infila in area e scarica un tiro potente contro la traversa');
INSERT INTO `Evento` (`minuto`, `partita`, `giocatore`, `tipo`, `commento`) VALUES (15, 'G1P1', '262 ', 'GOL', 'arriva davanti al portiere e non sbaglia. Il suo rasoterra sbatte sul palo destro ed entra in porta');
INSERT INTO `Evento` (`minuto`, `partita`, `giocatore`, `tipo`, `commento`) VALUES (20, 'G1P1',  '272 ', 'GOL', 'calcia in area la punizione e la palla trova la testa di Wesley Hoedt e insacca all\'angolino basso di sinistra');
INSERT INTO `Evento` (`minuto`, `partita`, `giocatore`, `tipo`, `commento`) VALUES (30, 'G1P1', '273 ',  'GOL', 'come un falco si fionda sul rimbalzo e ribatte in rete!');
INSERT INTO `Evento` (`minuto`, `partita`, `giocatore`, `tipo`, `commento`) VALUES (89, 'G1P1',  '274 ', 'GOL', 'tiro ben eseguito si spegne in rete sotto la traversa assist di Basta');




-- -----------------------------------------------------
-- Data for table `Prestazione`
-- -----------------------------------------------------


INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ('1', 'G1P1', false, false, '0');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ('20', 'G1P1', true, false, '5');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ('7', 'G1P1', false, false, '4');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ('6', 'G1P1', false, false, '3');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ('10', 'G1P1', false, false, '2');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ('15', 'G1P1', false, false, '1');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ('14', 'G1P1', false, false, '3');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ('11', 'G1P1', true, false, '6');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ('4', 'G1P1', false, false, '0');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ('22', 'G1P1', false, false, '1');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ('21', 'G1P1', false, false, '0');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ('24', 'G1P1', false, false, '0');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ('25', 'G1P1', false, false, '0');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ( '250' ,'G1P1', false, false, '0');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ( '254' , 'G1P1', false, false, '2');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ( '255' ,'G1P1', false, false, '3');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ( '256' ,'G1P1', true, false, '4');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ( '259' , 'G1P1', false, false, '1');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ( '260' , 'G1P1', false, false, '4');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ( '262' , 'G1P1', false, false, '2');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ( '263' , 'G1P1', false, false, '3');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES	( '264' , 'G1P1', false, false, '1');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ( '272' , 'G1P1', true, false, '3');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ( '273' , 'G1P1', false, false, '0');
INSERT INTO `Prestazione` (`giocatore`, `partita`,  `ammonizione`, `espulsione`, `numero falli`) VALUES ( '274' ,'G1P1', false, true, '2');



set foreign_key_checks= 1;
