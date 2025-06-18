DROP TABLE IF EXISTS EspecialidadesE;

CREATE TABLE EspecialidadesE (
    idEspecialidade INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

INSERT INTO EspecialidadesE (nome, descricao) VALUES
('Psiquiatria Geral', 'Diagnóstico e tratamento de transtornos mentais.'),
('Psiquiatria Infantil', 'Atendimento psiquiátrico para crianças e adolescentes.'),
('Psicogeriatria', 'Foco em saúde mental do idoso.'),
('Dependência Química', 'Tratamento para abuso de substâncias.'),
('Transtornos de Humor', 'Depressão, bipolaridade e afins.'),
('Transtornos Psicóticos', 'Esquizofrenia e transtornos relacionados.'),
('Transtornos de Ansiedade', 'TAG, pânico, fobias, etc.'),
('Neuropsiquiatria', 'Intersecção entre neurologia e psiquiatria.');

INSERT INTO MedicosE (nome, crm, telefone, email, idEspecialidade) VALUES
('Dr. Bruno Torres', 'CRM456789', '11-94444-1234', 'bruno.psy@hospital.com', 1),
('Dra. Helena Prado', 'CRM567890', '11-95555-5678', 'helena.psy@hospital.com', 2),
('Dr. Miguel Andrade', 'CRM678901', '11-96666-6789', 'miguel.psy@hospital.com', 3),
('Dra. Laura Freitas', 'CRM789012', '11-97777-7890', 'laura.psy@hospital.com', 4),
('Dr. Rafael Campos', 'CRM890123', '11-98888-8901', 'rafael.psy@hospital.com', 5),
('Dra. Sofia Martins', 'CRM901234', '11-90000-9012', 'sofia.psy@hospital.com', 6),
('Dr. Daniel Viana', 'CRM012345', '11-91111-0123', 'daniel.psy@hospital.com', 7),
('Dra. Paula Rezende', 'CRM123457', '11-92222-1234', 'paula.psy@hospital.com', 8);

DROP TABLE IF EXISTS SessoesPsiquiatricasE;

CREATE TABLE SessoesPsiquiatricasE (
    idSessao INT AUTO_INCREMENT PRIMARY KEY,
    idPaciente INT NOT NULL,
    idMedico INT NOT NULL,
    dataHora DATETIME NOT NULL,
    duracaoMin INT DEFAULT 50,
    tipoSessao ENUM('Consulta', 'Retorno', 'Emergencial') DEFAULT 'Consulta',
    observacoes TEXT,
    FOREIGN KEY (idPaciente) REFERENCES PacientesE(idPaciente),
    FOREIGN KEY (idMedico) REFERENCES MedicosE(idMedico)
);

DROP TABLE IF EXISTS EvolucoesMentaisE;

CREATE TABLE EvolucoesMentaisE (
    idEvolucao INT AUTO_INCREMENT PRIMARY KEY,
    idSessao INT NOT NULL,
    humor ENUM('Estável', 'Ansioso', 'Depressivo', 'Irritado', 'Eufórico', 'Outro') DEFAULT 'Estável',
    conteudoSessao TEXT,
    conduta TEXT,
    encaminhamento TEXT,
    dataRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idSessao) REFERENCES SessoesPsiquiatricasE(idSessao)
);

INSERT INTO SessoesPsiquiatricasE (idPaciente, idMedico, dataHora, duracaoMin, tipoSessao, observacoes) VALUES
(1, 1, '2025-06-17 14:00:00', 60, 'Consulta', 'Paciente com insônia e ansiedade.'),
(2, 2, '2025-06-17 15:30:00', 50, 'Consulta', 'Transtorno depressivo maior, início recente.'),
(1, 1, '2025-06-24 14:00:00', 60, 'Retorno', 'Verificação de resposta à medicação.'),
(3, 3, '2025-06-18 10:00:00', 45, 'Emergencial', 'Surto psicótico leve.'),
(4, 4, '2025-06-19 11:00:00', 50, 'Consulta', 'Abuso de álcool e tabaco.'),
(5, 5, '2025-06-20 16:00:00', 60, 'Consulta', 'Paciente apresenta sintomas de bipolaridade.'),
(6, 6, '2025-06-21 09:30:00', 50, 'Consulta', 'Paciente com transtorno obsessivo-compulsivo.'),
(7, 7, '2025-06-22 13:00:00', 60, 'Consulta', 'Crises de pânico frequentes.'),
(8, 8, '2025-06-23 15:00:00', 50, 'Consulta', 'Demência em estágio inicial.');

INSERT INTO EvolucoesMentaisE (idSessao, humor, conteudoSessao, conduta, encaminhamento) VALUES
(1, 'Ansioso', 'Paciente relata preocupação excessiva e insônia.', 'Iniciar escitalopram 10mg/dia.', 'Psicoterapia.'),
(2, 'Depressivo', 'Relato de perda de interesse, choro frequente, fadiga.', 'Iniciar sertralina e avaliar em 2 semanas.', ''),
(3, 'Estável', 'Relato de leve melhora no sono e ansiedade.', 'Manter escitalopram, iniciar terapia.', ''),
(4, 'Irritado', 'Paciente chegou agitado, discurso desconexo.', 'Administrado haloperidol. Encaminhado ao psiquiatra plantonista.', 'Internação possível.'),
(5, 'Outro', 'Paciente relatou consumo diário de álcool.', 'Encaminhar para grupo de apoio e iniciar naltrexona.', 'CAPS AD.'),
(6, 'Eufórico', 'Paciente com discurso acelerado, ideias grandiosas.', 'Ajuste de estabilizador de humor.', ''),
(7, 'Ansioso', 'Rituais repetitivos relatados. Paciente se sente angustiado.', 'Iniciar fluvoxamina e encaminhar à TCC.', ''),
(8, 'Ansioso', 'Paciente com medo de sair de casa, sudorese constante.', 'Iniciar clonazepam e agendar retorno em 10 dias.', ''),
(9, 'Estável', 'Lapsos de memória frequentes. Família relatou mudanças de comportamento.', 'Encaminhar para neuropsiquiatria. Iniciar avaliação cognitiva.', '');

DROP TABLE IF EXISTS TerapiasComplementaresE;

CREATE TABLE TerapiasComplementaresE (
    idTerapia INT AUTO_INCREMENT PRIMARY KEY,
    idSessao INT,
    tipoTerapia ENUM('TCC', 'Psicodinâmica', 'Grupo', 'Familiar', 'Ocupacional'),
    profissionalResponsavel VARCHAR(100),
    resumo TEXT,
    FOREIGN KEY (idSessao) REFERENCES SessoesPsiquiatricasE(idSessao)
);

INSERT INTO TerapiasComplementaresE (idSessao, tipoTerapia, profissionalResponsavel, resumo) VALUES
(1, 'TCC', 'Psicóloga Camila Souza', 'Técnicas de reestruturação cognitiva iniciadas.'),
(3, 'TCC', 'Psicóloga Camila Souza', 'Trabalho de crenças automáticas em andamento.'),
(5, 'Grupo', 'Terapeuta Marcos Lima', 'Discussão sobre vícios e recaídas.'),
(7, 'TCC', 'Psicóloga Amanda Rocha', 'Foco na dessensibilização sistemática.'),
(9, 'Familiar', 'Terapeuta Sônia Martins', 'Orientações para cuidadores de idosos.');

