-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2023-08-23 00:39:36.042

-- tables
-- Table: Equipamento
CREATE TABLE Equipamento (
    nr_equipamento char(8)  NOT NULL,
    dt_aquisicao date  NOT NULL,
    ds_observacao varchar(50)  NULL,
    Sala_nr_sala char(8)  NOT NULL,
    CONSTRAINT Equipamento_pk PRIMARY KEY (nr_equipamento)
);

-- Table: Sala
CREATE TABLE Sala (
    nr_sala char(8)  NOT NULL,
    ds_sala varchar(50)  NOT NULL,
    CONSTRAINT Sala_pk PRIMARY KEY (nr_sala)
);

-- Table: Software
CREATE TABLE Software (
    cd_software int  NOT NULL,
    nm_software varchar(50)  NOT NULL,
    ds_informacao_add varchar(50)  NULL,
    CONSTRAINT Software_pk PRIMARY KEY (cd_software)
);

-- Table: Software_Equipamento
CREATE TABLE Software_Equipamento (
    cd_software int  NOT NULL,
    nr_equipamento char(8)  NOT NULL,
    CONSTRAINT Software_Equipamento_pk PRIMARY KEY (cd_software,nr_equipamento)
);

-- foreign keys
-- Reference: Equipamento_Sala (table: Equipamento)
ALTER TABLE Equipamento ADD CONSTRAINT Equipamento_Sala FOREIGN KEY Equipamento_Sala (Sala_nr_sala)
    REFERENCES Sala (nr_sala);

-- Reference: Software_Equipamento_Equipamento (table: Software_Equipamento)
ALTER TABLE Software_Equipamento ADD CONSTRAINT Software_Equipamento_Equipamento FOREIGN KEY Software_Equipamento_Equipamento (nr_equipamento)
    REFERENCES Equipamento (nr_equipamento);

-- Reference: Software_Equipamento_Software (table: Software_Equipamento)
ALTER TABLE Software_Equipamento ADD CONSTRAINT Software_Equipamento_Software FOREIGN KEY Software_Equipamento_Software (cd_software)
    REFERENCES Software (cd_software);

-- End of file.

