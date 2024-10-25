-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2023-09-27 00:26:56.768

-- tables
-- Table: cliente
CREATE TABLE cliente (
    cd_pessoa int NOT NULL,
    vl_limite_compra decimal(8,2) NOT NULL,
    cd_ramo int NOT NULL,
    CONSTRAINT cliente_pk PRIMARY KEY (cd_pessoa)
);

-- Table: condicao_pagamento
CREATE TABLE condicao_pagamento (
    cd_condicao int NOT NULL,
    ds_condicao varchar(50) NOT NULL,
    vl_expressao varchar(30) NOT NULL,
    CONSTRAINT condicao_pagamento_pk PRIMARY KEY (cd_condicao)
);

-- Table: fornecedor
CREATE TABLE fornecedor (
    cd_pessoa int NOT NULL,
    ds_website varchar(50) NOT NULL,
    CONSTRAINT fornecedor_pk PRIMARY KEY (cd_pessoa)
);

-- Table: item_nota_fiscal_entrada
CREATE TABLE item_nota_fiscal_entrada (
    nr_nota_fiscal int NOT NULL,
    cd_produto int NOT NULL,
    qt_produto int NOT NULL,
    vl_produto decimal(8,2) NOT NULL,
    vl_total decimal(8,2) NOT NULL,
    CONSTRAINT item_nota_fiscal_entrada_pk PRIMARY KEY (nr_nota_fiscal,cd_produto)
);

-- Table: item_nota_fiscal_saida
CREATE TABLE item_nota_fiscal_saida (
    nr_nota_fiscal int NOT NULL,
    cd_produto int NOT NULL,
    qt_produto int NOT NULL,
    vl_produto decimal(8,2) NOT NULL,
    vl_total decimal(8,2) NOT NULL,
    CONSTRAINT item_nota_fiscal_saida_pk PRIMARY KEY (nr_nota_fiscal,cd_produto)
);

-- Table: item_pedido_compra
CREATE TABLE item_pedido_compra (
    nr_pedido int NOT NULL,
    cd_produto int NOT NULL,
    qt_produto int NOT NULL,
    vl_produto decimal(8,2) NOT NULL,
    vl_total_item decimal(8,2) NOT NULL,
    CONSTRAINT item_pedido_compra_pk PRIMARY KEY (nr_pedido,cd_produto)
);

-- Table: municipio
CREATE TABLE municipio (
    cd_municipio int NOT NULL,
    nm_municipio varchar(50) NOT NULL,
    sg_uf char(2) NOT NULL,
    cd_regiao int NOT NULL,
    CONSTRAINT municipio_pk PRIMARY KEY (cd_municipio)
);

-- Table: nota_fiscal_entrada
CREATE TABLE nota_fiscal_entrada (
    nr_nota_fiscal int NOT NULL,
    dt_emissao date NOT NULL,
    vl_total decimal(8,2) NOT NULL,
    cd_fornecedor int NOT NULL,
    CONSTRAINT nota_fiscal_entrada_pk PRIMARY KEY (nr_nota_fiscal)
);

-- Table: nota_fiscal_saida
CREATE TABLE nota_fiscal_saida (
    nr_nota_fiscal int NOT NULL,
    dt_emissao date NOT NULL,
    vl_total decimal(8,2) NOT NULL,
    nr_pedido int NOT NULL,
    cd_cliente int NOT NULL,
    CONSTRAINT nota_fiscal_saida_pk PRIMARY KEY (nr_nota_fiscal)
);

-- Table: pedido_compra
CREATE TABLE pedido_compra (
    nr_pedido int NOT NULL,
    dt_emissao date NOT NULL,
    vl_total decimal(8,2) NOT NULL,
    cd_condicao int NOT NULL,
    fl_finalizado char(1) NOT NULL,
    cd_cliente int NOT NULL,
    cd_vendedor int NOT NULL,
    CONSTRAINT pedido_compra_pk PRIMARY KEY (nr_pedido)
);

-- Table: pessoa
CREATE TABLE pessoa (
    cd_pessoa int NOT NULL,
    nm_cliente varchar(50) NOT NULL,
    ds_logradouro varchar(50) NOT NULL,
    ds_complemento varchar(50) NOT NULL,
    nm_bairro varchar(30) NOT NULL,
    nr_cep char(8) NOT NULL,
    nr_telefone varchar(15) NOT NULL,
    ds_email varchar(50) NOT NULL,
    cd_municipio int NOT NULL,
    CONSTRAINT pessoa_pk PRIMARY KEY (cd_pessoa)
);

-- Table: produto
CREATE TABLE produto (
    cd_produto int NOT NULL,
    ds_produto varchar(50) NOT NULL,
    qt_estoque int NOT NULL,
    qt_minima int NOT NULL,
    vl_produto decimal(8,2) NOT NULL,
    cd_fornecedor int NOT NULL,
    CONSTRAINT produto_pk PRIMARY KEY (cd_produto)
);

-- Table: ramo_atuacao
CREATE TABLE ramo_atuacao (
    cd_ramo int NOT NULL,
    ds_ramo Varchar(50) NOT NULL,
    CONSTRAINT ramo_atuacao_pk PRIMARY KEY (cd_ramo)
);

-- Table: regiao
CREATE TABLE regiao (
    cd_regiao int NOT NULL,
    nm_regiao varchar(50) NOT NULL,
    CONSTRAINT regiao_pk PRIMARY KEY (cd_regiao)
);

-- Table: titulo_a_pagar
CREATE TABLE titulo_a_pagar (
    nr_titulo int NOT NULL,
    dt_emissao date NOT NULL,
    dt_vencimento date NOT NULL,
    vl_titulo decimal(8,2) NOT NULL,
    nr_nota_fiscal int NOT NULL,
    cd_fornecedor int NOT NULL,
    CONSTRAINT titulo_a_pagar_pk PRIMARY KEY (nr_titulo)
);

-- Table: titulo_a_receber
CREATE TABLE titulo_a_receber (
    nr_titulo int NOT NULL,
    dt_emissao date NOT NULL,
    dt_vencimento date NOT NULL,
    vl_titulo decimal(8,2) NOT NULL,
    nr_nota_fiscal int NOT NULL,
    cd_cliente int NOT NULL,
    CONSTRAINT titulo_a_receber_pk PRIMARY KEY (nr_titulo)
);

-- Table: vendedor
CREATE TABLE vendedor (
    cd_pessoa int NOT NULL,
    dt_nascimento date NOT NULL,
    vl_salario_base decimal(8,2) NOT NULL,
    pc_comissao decimal(4,2) NOT NULL,
    cd_regiao int NOT NULL,
    CONSTRAINT vendedor_pk PRIMARY KEY (cd_pessoa)
);

-- foreign keys
-- Reference: Table_11_nota_fiscal_saida (table: item_nota_fiscal_saida)
ALTER TABLE item_nota_fiscal_saida ADD CONSTRAINT Table_11_nota_fiscal_saida FOREIGN KEY Table_11_nota_fiscal_saida (nr_nota_fiscal)
    REFERENCES nota_fiscal_saida (nr_nota_fiscal);

-- Reference: Table_11_produto (table: item_nota_fiscal_saida)
ALTER TABLE item_nota_fiscal_saida ADD CONSTRAINT Table_11_produto FOREIGN KEY Table_11_produto (cd_produto)
    REFERENCES produto (cd_produto);

-- Reference: Table_15_nota_fiscal_entrada (table: item_nota_fiscal_entrada)
ALTER TABLE item_nota_fiscal_entrada ADD CONSTRAINT Table_15_nota_fiscal_entrada FOREIGN KEY Table_15_nota_fiscal_entrada (nr_nota_fiscal)
    REFERENCES nota_fiscal_entrada (nr_nota_fiscal);

-- Reference: Table_15_produto (table: item_nota_fiscal_entrada)
ALTER TABLE item_nota_fiscal_entrada ADD CONSTRAINT Table_15_produto FOREIGN KEY Table_15_produto (cd_produto)
    REFERENCES produto (cd_produto);

-- Reference: Table_8_pedido_compra (table: item_pedido_compra)
ALTER TABLE item_pedido_compra ADD CONSTRAINT Table_8_pedido_compra FOREIGN KEY Table_8_pedido_compra (nr_pedido)
    REFERENCES pedido_compra (nr_pedido);

-- Reference: Table_8_produto (table: item_pedido_compra)
ALTER TABLE item_pedido_compra ADD CONSTRAINT Table_8_produto FOREIGN KEY Table_8_produto (cd_produto)
    REFERENCES produto (cd_produto);

-- Reference: cliente_pessoa (table: cliente)
ALTER TABLE cliente ADD CONSTRAINT cliente_pessoa FOREIGN KEY cliente_pessoa (cd_pessoa)
    REFERENCES pessoa (cd_pessoa);

-- Reference: cliente_ramo_atuacao (table: cliente)
ALTER TABLE cliente ADD CONSTRAINT cliente_ramo_atuacao FOREIGN KEY cliente_ramo_atuacao (cd_ramo)
    REFERENCES ramo_atuacao (cd_ramo);

-- Reference: fornecedor_pessoa (table: fornecedor)
ALTER TABLE fornecedor ADD CONSTRAINT fornecedor_pessoa FOREIGN KEY fornecedor_pessoa (cd_pessoa)
    REFERENCES pessoa (cd_pessoa);

-- Reference: municipio_regiao (table: municipio)
ALTER TABLE municipio ADD CONSTRAINT municipio_regiao FOREIGN KEY municipio_regiao (cd_regiao)
    REFERENCES regiao (cd_regiao);

-- Reference: nota_fiscal_entrada_fornecedor (table: nota_fiscal_entrada)
ALTER TABLE nota_fiscal_entrada ADD CONSTRAINT nota_fiscal_entrada_fornecedor FOREIGN KEY nota_fiscal_entrada_fornecedor (cd_fornecedor)
    REFERENCES fornecedor (cd_pessoa);

-- Reference: nota_fiscal_saida_cliente (table: nota_fiscal_saida)
ALTER TABLE nota_fiscal_saida ADD CONSTRAINT nota_fiscal_saida_cliente FOREIGN KEY nota_fiscal_saida_cliente (cd_cliente)
    REFERENCES cliente (cd_pessoa);

-- Reference: nota_fiscal_saida_pedido_compra (table: nota_fiscal_saida)
ALTER TABLE nota_fiscal_saida ADD CONSTRAINT nota_fiscal_saida_pedido_compra FOREIGN KEY nota_fiscal_saida_pedido_compra (nr_pedido)
    REFERENCES pedido_compra (nr_pedido);

-- Reference: pedido_compra_cliente (table: pedido_compra)
ALTER TABLE pedido_compra ADD CONSTRAINT pedido_compra_cliente FOREIGN KEY pedido_compra_cliente (cd_cliente)
    REFERENCES cliente (cd_pessoa);

-- Reference: pedido_compra_condicao_pagamento (table: pedido_compra)
ALTER TABLE pedido_compra ADD CONSTRAINT pedido_compra_condicao_pagamento FOREIGN KEY pedido_compra_condicao_pagamento (cd_condicao)
    REFERENCES condicao_pagamento (cd_condicao);

-- Reference: pedido_compra_vendedor (table: pedido_compra)
ALTER TABLE pedido_compra ADD CONSTRAINT pedido_compra_vendedor FOREIGN KEY pedido_compra_vendedor (cd_vendedor)
    REFERENCES vendedor (cd_pessoa);

-- Reference: pessoa_municipio (table: pessoa)
ALTER TABLE pessoa ADD CONSTRAINT pessoa_municipio FOREIGN KEY pessoa_municipio (cd_municipio)
    REFERENCES municipio (cd_municipio);

-- Reference: produto_fornecedor (table: produto)
ALTER TABLE produto ADD CONSTRAINT produto_fornecedor FOREIGN KEY produto_fornecedor (cd_fornecedor)
    REFERENCES fornecedor (cd_pessoa);

-- Reference: titulo_a_pagar_fornecedor (table: titulo_a_pagar)
ALTER TABLE titulo_a_pagar ADD CONSTRAINT titulo_a_pagar_fornecedor FOREIGN KEY titulo_a_pagar_fornecedor (cd_fornecedor)
    REFERENCES fornecedor (cd_pessoa);

-- Reference: titulo_a_pagar_nota_fiscal_entrada (table: titulo_a_pagar)
ALTER TABLE titulo_a_pagar ADD CONSTRAINT titulo_a_pagar_nota_fiscal_entrada FOREIGN KEY titulo_a_pagar_nota_fiscal_entrada (nr_nota_fiscal)
    REFERENCES nota_fiscal_entrada (nr_nota_fiscal);

-- Reference: titulo_a_receber_cliente (table: titulo_a_receber)
ALTER TABLE titulo_a_receber ADD CONSTRAINT titulo_a_receber_cliente FOREIGN KEY titulo_a_receber_cliente (cd_cliente)
    REFERENCES cliente (cd_pessoa);

-- Reference: titulo_a_receber_nota_fiscal_saida (table: titulo_a_receber)
ALTER TABLE titulo_a_receber ADD CONSTRAINT titulo_a_receber_nota_fiscal_saida FOREIGN KEY titulo_a_receber_nota_fiscal_saida (nr_nota_fiscal)
    REFERENCES nota_fiscal_saida (nr_nota_fiscal);

-- Reference: vendedor_pessoa (table: vendedor)
ALTER TABLE vendedor ADD CONSTRAINT vendedor_pessoa FOREIGN KEY vendedor_pessoa (cd_pessoa)
    REFERENCES pessoa (cd_pessoa);

-- Reference: vendedor_regiao (table: vendedor)
ALTER TABLE vendedor ADD CONSTRAINT vendedor_regiao FOREIGN KEY vendedor_regiao (cd_regiao)
    REFERENCES regiao (cd_regiao);

-- End of file.

