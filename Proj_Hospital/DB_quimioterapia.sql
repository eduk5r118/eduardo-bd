CREATE DATABASE IF NOT EXISTS HospitalQuimioterapia;
USE HospitalQuimioterapia;

CREATE TABLE TiposDeQuimioterapia (
    idTipoQuimio INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    viaAdministracao ENUM('Oral', 'Intravenosa', 'Subcutânea', 'Outro') NOT NULL
);

CREATE TABLE MedicamentosQuimioterapicos (
    idMedicamento INT AUTO_INCREMENT PRIMARY KEY,
    nomeComercial VARCHAR(100) NOT NULL,
    principioAtivo VARCHAR(100),
    dosagem VARCHAR(50),
    formaFarmaceutica VARCHAR(50)
);

CREATE TABLE SessaoQuimioterapia (
    idSessao INT AUTO_INCREMENT PRIMARY KEY,
    idPaciente INT NOT NULL,
    idMedico INT NOT NULL,
    idTipoQuimio INT NOT NULL,
    dataSessao DATETIME NOT NULL,
    duracaoMinutos INT,
    reacoesAdversas TEXT,
    observacoes TEXT,
    FOREIGN KEY (idPaciente) REFERENCES HospitalRecepcao.Pacientes(idPaciente),
    FOREIGN KEY (idMedico) REFERENCES HospitalRecepcao.Medicos(idMedico),
    FOREIGN KEY (idTipoQuimio) REFERENCES TiposDeQuimioterapia(idTipoQuimio)
);

CREATE TABLE Sessao_Medicamento (
    idSessao INT,
    idMedicamento INT,
    quantidadeAdministrada VARCHAR(50),
    PRIMARY KEY (idSessao, idMedicamento),
    FOREIGN KEY (idSessao) REFERENCES SessaoQuimioterapia(idSessao) ON DELETE CASCADE,
    FOREIGN KEY (idMedicamento) REFERENCES MedicamentosQuimioterapicos(idMedicamento)
);

CREATE TABLE ExamesQuimioComplementares (
    idExame INT AUTO_INCREMENT PRIMARY KEY,
    idSessao INT NOT NULL,
    nomeExame VARCHAR(100),
    resultado TEXT,
    dataExame DATE,
    FOREIGN KEY (idSessao) REFERENCES SessaoQuimioterapia(idSessao)
);

CREATE TABLE EnfermeirosQuimio (
    idEnfermeiro INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    coren VARCHAR(20) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE AplicacoesPorEnfermeiro (
    idSessao INT,
    idEnfermeiro INT,
    horaInicio DATETIME,
    horaFim DATETIME,
    observacoes TEXT,
    PRIMARY KEY (idSessao, idEnfermeiro),
    FOREIGN KEY (idSessao) REFERENCES SessaoQuimioterapia(idSessao),
    FOREIGN KEY (idEnfermeiro) REFERENCES EnfermeirosQuimio(idEnfermeiro)
);
