-- Criar o banco de dados ESCOLA
CREATE DATABASE ESCOLA;

-- Usar o banco de dados ESCOLA
USE ESCOLA;

-- Criar a tabela ALUNO
CREATE TABLE ALUNO (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(255),
    EMAIL VARCHAR(255),
    ENDERECO VARCHAR(255)
);

-- Criar a tabela CURSO
CREATE TABLE CURSO (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(255),
    DESCRICAO TEXT
);

-- Criar a tabela MATRICULA
CREATE TABLE MATRICULA (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ALUNO_ID INT,
    CURSO_ID INT,
    DATA_MATRICULA DATE,
    FOREIGN KEY (ALUNO_ID) REFERENCES ALUNO(ID),
    FOREIGN KEY (CURSO_ID) REFERENCES CURSO(ID)
);

-- Criar a tabela LOG_MATRICULA
CREATE TABLE LOG_MATRICULA (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    MATRICULA_ID INT,
    MENSAGEM VARCHAR(255),
    DATA_LOG TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (MATRICULA_ID) REFERENCES MATRICULA(ID)
);

-- Criar o trigger para inserir logs após a inserção na tabela MATRICULA
DELIMITER //

CREATE TRIGGER trg_after_insert_matricula
AFTER INSERT ON MATRICULA
FOR EACH ROW
BEGIN
    INSERT INTO LOG_MATRICULA (MATRICULA_ID, MENSAGEM)
    VALUES (NEW.ID, CONCAT('Nova matrícula adicionada. ID da matrícula: ', NEW.ID));
END //

DELIMITER ;

-- Inserir dados na tabela ALUNO
INSERT INTO ALUNO (NOME, EMAIL, ENDERECO) VALUES
('João Silva', 'joao.silva@example.com', 'Rua A, 123'),
('Maria Oliveira', 'maria.oliveira@example.com', 'Rua B, 456'),
('Pedro Souza', 'pedro.souza@example.com', 'Rua C, 789');

-- Inserir dados na tabela CURSO
INSERT INTO CURSO (NOME, DESCRICAO) VALUES
('Matemática', 'Curso de Matemática Básica'),
('História', 'Curso de História do Brasil'),
('Ciências', 'Curso de Ciências Naturais');

-- Inserir dados na tabela MATRICULA e acionar o trigger
INSERT INTO MATRICULA (ALUNO_ID, CURSO_ID, DATA_MATRICULA) VALUES
(1, 1, '2024-01-15'),
(1, 2, '2024-02-01'),
(2, 1, '2024-03-10'),
(3, 3, '2024-04-05');

-- Consultar a tabela LOG_MATRICULA para verificar se o trigger funcionou
SELECT * FROM LOG_MATRICULA;
