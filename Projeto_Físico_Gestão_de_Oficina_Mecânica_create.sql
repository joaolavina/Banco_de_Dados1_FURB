-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2023-09-13 12:35:42.884

-- tables
-- Table: categoria
CREATE TABLE categoria (
    cd_categoria int  NOT NULL,
    nm_categoria varchar(30)  NOT NULL,
    CONSTRAINT categoria_pk PRIMARY KEY (cd_categoria)
);

-- Table: cliente
CREATE TABLE cliente (
    cd_cliente int  NOT NULL,
    nm_cliente char(50)  NOT NULL,
    nr_telefone char(11)  NOT NULL,
    ds_email varchar(50)  NOT NULL,
    CONSTRAINT cliente_pk PRIMARY KEY (cd_cliente)
);

-- Table: endereco
CREATE TABLE endereco (
    cd_endereco int  NOT NULL,
    ds_logradouro varchar(50)  NOT NULL,
    ds_complemento varchar(50)  NOT NULL,
    nm_bairro varchar(30)  NOT NULL,
    nr_cep char(8)  NOT NULL,
    cd_municipio int  NOT NULL,
    cliente_cd_cliente int  NOT NULL,
    CONSTRAINT endereco_pk PRIMARY KEY (cd_endereco)
);

-- Table: especialidade
CREATE TABLE especialidade (
    cd_especialidade int  NOT NULL,
    nm_especialidade varchar(50)  NOT NULL,
    CONSTRAINT especialidade_pk PRIMARY KEY (cd_especialidade)
);

-- Table: item_nf_peca
CREATE TABLE item_nf_peca (
    cd_nota_fiscal int  NOT NULL,
    cd_peca int  NOT NULL,
    qt_peca int  NOT NULL,
    vl_peca double(8,2)  NOT NULL,
    vl_total_item double(8,2)  NOT NULL,
    CONSTRAINT item_nf_peca_pk PRIMARY KEY (cd_nota_fiscal,cd_peca)
);

-- Table: item_nf_servico
CREATE TABLE item_nf_servico (
    cd_servico int  NOT NULL,
    cd_nota_fiscal int  NOT NULL,
    vl_servicos double(8,2)  NOT NULL,
    vl_total_item double(8,2)  NOT NULL,
    CONSTRAINT item_nf_servico_pk PRIMARY KEY (cd_servico,cd_nota_fiscal)
);

-- Table: item_os_peca
CREATE TABLE item_os_peca (
    nr_ordem_servico int  NOT NULL,
    cd_peca int  NOT NULL,
    qt_peca int  NOT NULL,
    vl_peca double(8,2)  NOT NULL,
    vl_total_item double(8,2)  NOT NULL,
    CONSTRAINT item_os_peca_pk PRIMARY KEY (cd_peca,nr_ordem_servico)
);

-- Table: item_os_servicos
CREATE TABLE item_os_servicos (
    cd_servico int  NOT NULL,
    nr_ordem_servico int  NOT NULL,
    vl_servico double(8,2)  NOT NULL,
    vl_total_item double(8,2)  NOT NULL,
    cd_profissional int  NOT NULL,
    CONSTRAINT item_os_servicos_pk PRIMARY KEY (cd_servico,nr_ordem_servico)
);

-- Table: marca
CREATE TABLE marca (
    cd_marca int  NOT NULL,
    nm_marca varchar(30)  NOT NULL,
    CONSTRAINT marca_pk PRIMARY KEY (cd_marca)
);

-- Table: modelo
CREATE TABLE modelo (
    cd_modelo int  NOT NULL,
    cd_marca int  NOT NULL,
    nm_modelo varchar(30)  NOT NULL,
    ds_detalhes varchar(100)  NOT NULL,
    CONSTRAINT modelo_pk PRIMARY KEY (cd_modelo,cd_marca)
);

-- Table: municipio
CREATE TABLE municipio (
    cd_municipio int  NOT NULL,
    nm_municipio varchar(50)  NOT NULL,
    sg_uf char(2)  NOT NULL,
    CONSTRAINT municipio_pk PRIMARY KEY (cd_municipio)
);

-- Table: nota_fiscal
CREATE TABLE nota_fiscal (
    cd_nota_fiscal int  NOT NULL,
    fl_tipo char(1)  NOT NULL,
    dt_emissao date  NOT NULL,
    vl_total decimal(8,2)  NOT NULL,
    nr_ordem_servico int  NOT NULL,
    CONSTRAINT nota_fiscal_pk PRIMARY KEY (cd_nota_fiscal)
);

-- Table: ordem_servico
CREATE TABLE ordem_servico (
    nr_ordem_servico int  NOT NULL,
    dt_emissao date  NOT NULL,
    vl_total decimal(8,2)  NOT NULL,
    fl_situacao char(1)  NOT NULL,
    cd_cliente int  NOT NULL,
    cd_placa char(7)  NOT NULL,
    CONSTRAINT ordem_servico_pk PRIMARY KEY (nr_ordem_servico)
);

-- Table: peca
CREATE TABLE peca (
    cd_peca int  NOT NULL,
    nm_peca varchar(50)  NOT NULL,
    qt_estoque int  NOT NULL,
    vl_custo decimal(8,2)  NOT NULL,
    vl_venda decimal(8,2)  NOT NULL,
    cd_categoria int  NOT NULL,
    CONSTRAINT peca_pk PRIMARY KEY (cd_peca)
);

-- Table: profissional
CREATE TABLE profissional (
    cd_profissional int  NOT NULL,
    nm_profissional varchar(30)  NOT NULL,
    ds_email varchar(50)  NOT NULL,
    nr_telofone char(11)  NOT NULL,
    CONSTRAINT profissional_pk PRIMARY KEY (cd_profissional)
);

-- Table: profissional_especialidade
CREATE TABLE profissional_especialidade (
    cd_profissional int  NOT NULL,
    cd_especialidade int  NOT NULL,
    CONSTRAINT profissional_especialidade_pk PRIMARY KEY (cd_profissional,cd_especialidade)
);

-- Table: servico
CREATE TABLE servico (
    cd_servico int  NOT NULL,
    nm_servico int  NOT NULL,
    vl_servico double(8,2)  NOT NULL,
    qt_horas int  NOT NULL,
    CONSTRAINT servico_pk PRIMARY KEY (cd_servico)
);

-- Table: veiculo
CREATE TABLE veiculo (
    cd_placa char(7)  NOT NULL,
    nr_ano_fabricacao char(4)  NOT NULL,
    nr_ano_modelo char(4)  NOT NULL,
    cd_modelo int  NOT NULL,
    cd_marca int  NOT NULL,
    CONSTRAINT veiculo_pk PRIMARY KEY (cd_placa)
);

-- foreign keys
-- Reference: endereco_cliente (table: endereco)
ALTER TABLE endereco ADD CONSTRAINT endereco_cliente FOREIGN KEY endereco_cliente (cliente_cd_cliente)
    REFERENCES cliente (cd_cliente);

-- Reference: endereco_municipio (table: endereco)
ALTER TABLE endereco ADD CONSTRAINT endereco_municipio FOREIGN KEY endereco_municipio (cd_municipio)
    REFERENCES municipio (cd_municipio);

-- Reference: item_nf_peca_nota_fiscal (table: item_nf_peca)
ALTER TABLE item_nf_peca ADD CONSTRAINT item_nf_peca_nota_fiscal FOREIGN KEY item_nf_peca_nota_fiscal (cd_nota_fiscal)
    REFERENCES nota_fiscal (cd_nota_fiscal);

-- Reference: item_nf_peca_peca (table: item_nf_peca)
ALTER TABLE item_nf_peca ADD CONSTRAINT item_nf_peca_peca FOREIGN KEY item_nf_peca_peca (cd_peca)
    REFERENCES peca (cd_peca);

-- Reference: item_nf_servico_nota_fiscal (table: item_nf_servico)
ALTER TABLE item_nf_servico ADD CONSTRAINT item_nf_servico_nota_fiscal FOREIGN KEY item_nf_servico_nota_fiscal (cd_nota_fiscal)
    REFERENCES nota_fiscal (cd_nota_fiscal);

-- Reference: item_nf_servico_servico (table: item_nf_servico)
ALTER TABLE item_nf_servico ADD CONSTRAINT item_nf_servico_servico FOREIGN KEY item_nf_servico_servico (cd_servico)
    REFERENCES servico (cd_servico);

-- Reference: item_os_peca_ordem_servico (table: item_os_peca)
ALTER TABLE item_os_peca ADD CONSTRAINT item_os_peca_ordem_servico FOREIGN KEY item_os_peca_ordem_servico (nr_ordem_servico)
    REFERENCES ordem_servico (nr_ordem_servico);

-- Reference: item_os_peca_peca (table: item_os_peca)
ALTER TABLE item_os_peca ADD CONSTRAINT item_os_peca_peca FOREIGN KEY item_os_peca_peca (cd_peca)
    REFERENCES peca (cd_peca);

-- Reference: item_os_servicos_ordem_servico (table: item_os_servicos)
ALTER TABLE item_os_servicos ADD CONSTRAINT item_os_servicos_ordem_servico FOREIGN KEY item_os_servicos_ordem_servico (nr_ordem_servico)
    REFERENCES ordem_servico (nr_ordem_servico);

-- Reference: item_os_servicos_profissional (table: item_os_servicos)
ALTER TABLE item_os_servicos ADD CONSTRAINT item_os_servicos_profissional FOREIGN KEY item_os_servicos_profissional (cd_profissional)
    REFERENCES profissional (cd_profissional);

-- Reference: item_os_servicos_servico (table: item_os_servicos)
ALTER TABLE item_os_servicos ADD CONSTRAINT item_os_servicos_servico FOREIGN KEY item_os_servicos_servico (cd_servico)
    REFERENCES servico (cd_servico);

-- Reference: modelo_marca (table: modelo)
ALTER TABLE modelo ADD CONSTRAINT modelo_marca FOREIGN KEY modelo_marca (cd_marca)
    REFERENCES marca (cd_marca);

-- Reference: nota_fiscal_ordem_servico (table: nota_fiscal)
ALTER TABLE nota_fiscal ADD CONSTRAINT nota_fiscal_ordem_servico FOREIGN KEY nota_fiscal_ordem_servico (nr_ordem_servico)
    REFERENCES ordem_servico (nr_ordem_servico);

-- Reference: ordem_servico_cliente (table: ordem_servico)
ALTER TABLE ordem_servico ADD CONSTRAINT ordem_servico_cliente FOREIGN KEY ordem_servico_cliente (cd_cliente)
    REFERENCES cliente (cd_cliente);

-- Reference: ordem_servico_veiculo (table: ordem_servico)
ALTER TABLE ordem_servico ADD CONSTRAINT ordem_servico_veiculo FOREIGN KEY ordem_servico_veiculo (cd_placa)
    REFERENCES veiculo (cd_placa);

-- Reference: pecas_categoria (table: peca)
ALTER TABLE peca ADD CONSTRAINT pecas_categoria FOREIGN KEY pecas_categoria (cd_categoria)
    REFERENCES categoria (cd_categoria);

-- Reference: profissional_especialidade_especialidade (table: profissional_especialidade)
ALTER TABLE profissional_especialidade ADD CONSTRAINT profissional_especialidade_especialidade FOREIGN KEY profissional_especialidade_especialidade (cd_especialidade)
    REFERENCES especialidade (cd_especialidade);

-- Reference: profissional_especialidade_profissional (table: profissional_especialidade)
ALTER TABLE profissional_especialidade ADD CONSTRAINT profissional_especialidade_profissional FOREIGN KEY profissional_especialidade_profissional (cd_profissional)
    REFERENCES profissional (cd_profissional);

-- Reference: veiculo_modelo (table: veiculo)
ALTER TABLE veiculo ADD CONSTRAINT veiculo_modelo FOREIGN KEY veiculo_modelo (cd_modelo,cd_marca)
    REFERENCES modelo (cd_modelo,cd_marca);

-- End of file.

