-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 22-Jan-2025 às 13:48
-- Versão do servidor: 10.4.21-MariaDB
-- versão do PHP: 8.0.12

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Banco de dados: `alertify`
--
CREATE DATABASE IF NOT EXISTS `alertify` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `alertify`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `administradores`
--

CREATE TABLE `administradores` (
  `id_admin` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `data_registo` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `administradores`
--

INSERT INTO `administradores` (`id_admin`, `nome`, `email`, `senha`, `data_registo`) VALUES
(1, 'admin', 'admin@sapo.pt', '1233210', '2024-11-29 23:16:32');

-- --------------------------------------------------------

--
-- Estrutura da tabela `autocarros`
--

CREATE TABLE `autocarros` (
  `id_autocarro` int(11) NOT NULL,
  `numero_registo` varchar(20) NOT NULL,
  `modelo` varchar(100) DEFAULT NULL,
  `capacidade` int(11) DEFAULT NULL,
  `id_motorista` int(11) DEFAULT NULL,
  `id_gps` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `autocarros`
--

INSERT INTO `autocarros` (`id_autocarro`, `numero_registo`, `modelo`, `capacidade`, `id_motorista`, `id_gps`) VALUES
(1, 'ABC-1234', 'Mercedes-Benz', 50, 1, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `controlo_rotas`
--

CREATE TABLE `controlo_rotas` (
  `dia` int(11) NOT NULL,
  `id_motorista` int(11) NOT NULL,
  `id_autocarro` int(11) NOT NULL,
  `id_gps` int(11) NOT NULL,
  `id_rota` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `gps`
--

CREATE TABLE `gps` (
  `id_gps` int(11) NOT NULL,
  `data_hora_registo` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `latitude` decimal(20,12) NOT NULL,
  `longitude` decimal(20,12) NOT NULL,
  `gps_historico` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `gps`
--

INSERT INTO `gps` (`id_gps`, `data_hora_registo`, `latitude`, `longitude`, `gps_historico`) VALUES
(1, '2024-11-29 23:16:32', '41.362187000000', '-8.471609000000', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `locations`
--

CREATE TABLE `locations` (
  `id` int(11) NOT NULL,
  `latitude` decimal(20,12) NOT NULL,
  `longitude` decimal(20,12) NOT NULL,
  `cdate` datetime NOT NULL DEFAULT current_timestamp(),
  `status` text NOT NULL,
  `message` text NOT NULL,
  `id_gps` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `locations`
--

INSERT INTO `locations` (`id`, `latitude`, `longitude`, `cdate`, `status`, `message`, `id_gps`) VALUES
(1, '41.369111000000', '-8.481917000000', '2024-12-17 16:36:15', '', '', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `motoristas`
--

CREATE TABLE `motoristas` (
  `id_motorista` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `data_nascimento` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `motoristas`
--

INSERT INTO `motoristas` (`id_motorista`, `nome`, `telefone`, `email`, `data_nascimento`) VALUES
(1, 'João Silva', '912345678', 'joao.silva@exemplo.pt', '1985-05-12');

-- --------------------------------------------------------

--
-- Estrutura da tabela `paragens`
--

CREATE TABLE `paragens` (
  `id_paragem` int(11) NOT NULL,
  `localizacao` varchar(200) NOT NULL,
  `hora_prevista` time NOT NULL,
  `id_rota` int(11) DEFAULT NULL,
  `lat` int(11) NOT NULL,
  `lng` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `paragens`
--

INSERT INTO `paragens` (`id_paragem`, `localizacao`, `hora_prevista`, `id_rota`, `lat`, `lng`) VALUES
(1, 'Paragem A', '07:15:00', 1, 0, 0),
(2, 'Paragem B', '07:30:00', 1, 0, 0),
(3, 'Paragem C', '07:45:00', 1, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `reservas`
--

CREATE TABLE `reservas` (
  `id_reserva` int(11) NOT NULL,
  `id_utilizador` int(11) DEFAULT NULL,
  `id_rota` int(11) DEFAULT NULL,
  `id_paragem` int(11) DEFAULT NULL,
  `hora_reserva` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `reservas`
--

INSERT INTO `reservas` (`id_reserva`, `id_utilizador`, `id_rota`, `id_paragem`, `hora_reserva`) VALUES
(1, 1, 1, 1, '2024-11-29 23:16:32');

-- --------------------------------------------------------

--
-- Estrutura da tabela `rotas`
--

CREATE TABLE `rotas` (
  `id_rota` int(11) NOT NULL,
  `nome_rota` varchar(100) NOT NULL,
  `local_partida` varchar(100) NOT NULL,
  `local_chegada` varchar(100) NOT NULL,
  `id_autocarro` int(11) DEFAULT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fim` time NOT NULL,
  `id_motorista` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `rotas`
--

INSERT INTO `rotas` (`id_rota`, `nome_rota`, `local_partida`, `local_chegada`, `id_autocarro`, `hora_inicio`, `hora_fim`, `id_motorista`) VALUES
(1, 'Rota 1', 'Caldinhas', 'Freamunde', 1, '17:10:00', '18:40:00', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `utilizadores`
--

CREATE TABLE `utilizadores` (
  `id_utilizador` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `data_registo` datetime DEFAULT current_timestamp(),
  `get_all_locations` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `utilizadores`
--

INSERT INTO `utilizadores` (`id_utilizador`, `nome`, `email`, `telefone`, `data_registo`, `get_all_locations`) VALUES
(1, 'Maria Costa', 'maria.costa@exemplo.pt', '965432100', '2024-11-29 23:16:32', 0);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `administradores`
--
ALTER TABLE `administradores`
  ADD PRIMARY KEY (`id_admin`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Índices para tabela `autocarros`
--
ALTER TABLE `autocarros`
  ADD PRIMARY KEY (`id_autocarro`),
  ADD KEY `id_motorista` (`id_motorista`),
  ADD KEY `id_gps` (`id_gps`);

--
-- Índices para tabela `controlo_rotas`
--
ALTER TABLE `controlo_rotas`
  ADD PRIMARY KEY (`dia`,`id_motorista`,`id_autocarro`,`id_gps`,`id_rota`),
  ADD KEY `id_motorista` (`id_motorista`),
  ADD KEY `id_autocarro` (`id_autocarro`),
  ADD KEY `id_gps` (`id_gps`),
  ADD KEY `id_rota` (`id_rota`);

--
-- Índices para tabela `gps`
--
ALTER TABLE `gps`
  ADD PRIMARY KEY (`id_gps`);

--
-- Índices para tabela `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_gps` (`id_gps`);

--
-- Índices para tabela `motoristas`
--
ALTER TABLE `motoristas`
  ADD PRIMARY KEY (`id_motorista`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Índices para tabela `paragens`
--
ALTER TABLE `paragens`
  ADD PRIMARY KEY (`id_paragem`),
  ADD KEY `id_rota` (`id_rota`);

--
-- Índices para tabela `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id_reserva`),
  ADD KEY `id_utilizador` (`id_utilizador`),
  ADD KEY `id_rota` (`id_rota`),
  ADD KEY `id_paragem` (`id_paragem`);

--
-- Índices para tabela `rotas`
--
ALTER TABLE `rotas`
  ADD PRIMARY KEY (`id_rota`),
  ADD KEY `id_autocarro` (`id_autocarro`),
  ADD KEY `fk_motorista_check` (`id_motorista`);

--
-- Índices para tabela `utilizadores`
--
ALTER TABLE `utilizadores`
  ADD PRIMARY KEY (`id_utilizador`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `administradores`
--
ALTER TABLE `administradores`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `autocarros`
--
ALTER TABLE `autocarros`
  MODIFY `id_autocarro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `controlo_rotas`
--
ALTER TABLE `controlo_rotas`
  MODIFY `dia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `gps`
--
ALTER TABLE `gps`
  MODIFY `id_gps` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `motoristas`
--
ALTER TABLE `motoristas`
  MODIFY `id_motorista` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `paragens`
--
ALTER TABLE `paragens`
  MODIFY `id_paragem` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id_reserva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `rotas`
--
ALTER TABLE `rotas`
  MODIFY `id_rota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `utilizadores`
--
ALTER TABLE `utilizadores`
  MODIFY `id_utilizador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `autocarros`
--
ALTER TABLE `autocarros`
  ADD CONSTRAINT `autocarros_ibfk_1` FOREIGN KEY (`id_motorista`) REFERENCES `motoristas` (`id_motorista`),
  ADD CONSTRAINT `autocarros_ibfk_2` FOREIGN KEY (`id_gps`) REFERENCES `gps` (`id_gps`);

--
-- Limitadores para a tabela `controlo_rotas`
--
ALTER TABLE `controlo_rotas`
  ADD CONSTRAINT `controlo_rotas_ibfk_1` FOREIGN KEY (`id_motorista`) REFERENCES `motoristas` (`id_motorista`),
  ADD CONSTRAINT `controlo_rotas_ibfk_2` FOREIGN KEY (`id_autocarro`) REFERENCES `autocarros` (`id_autocarro`),
  ADD CONSTRAINT `controlo_rotas_ibfk_3` FOREIGN KEY (`id_gps`) REFERENCES `gps` (`id_gps`),
  ADD CONSTRAINT `controlo_rotas_ibfk_4` FOREIGN KEY (`id_rota`) REFERENCES `rotas` (`id_rota`);

--
-- Limitadores para a tabela `locations`
--
ALTER TABLE `locations`
  ADD CONSTRAINT `locations_ibfk_1` FOREIGN KEY (`id_gps`) REFERENCES `gps` (`id_gps`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `paragens`
--
ALTER TABLE `paragens`
  ADD CONSTRAINT `paragens_ibfk_1` FOREIGN KEY (`id_rota`) REFERENCES `rotas` (`id_rota`);

--
-- Limitadores para a tabela `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`id_utilizador`) REFERENCES `utilizadores` (`id_utilizador`),
  ADD CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`id_rota`) REFERENCES `rotas` (`id_rota`),
  ADD CONSTRAINT `reservas_ibfk_3` FOREIGN KEY (`id_paragem`) REFERENCES `paragens` (`id_paragem`);

--
-- Limitadores para a tabela `rotas`
--
ALTER TABLE `rotas`
  ADD CONSTRAINT `fk_motorista_check` FOREIGN KEY (`id_motorista`) REFERENCES `motoristas` (`id_motorista`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rotas_ibfk_1` FOREIGN KEY (`id_autocarro`) REFERENCES `autocarros` (`id_autocarro`) ON DELETE CASCADE ON UPDATE CASCADE;
SET FOREIGN_KEY_CHECKS=1;
COMMIT;
