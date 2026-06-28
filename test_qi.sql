-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : sam. 27 juin 2026 à 23:21
-- Version du serveur : 8.4.7
-- Version de PHP : 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `test_qi`
--

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `historique_choix`
--

DROP TABLE IF EXISTS `historique_choix`;
CREATE TABLE IF NOT EXISTS `historique_choix` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tentative_id` int NOT NULL,
  `question_id` int NOT NULL,
  `reponse_choisie_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tentative_id` (`tentative_id`),
  KEY `question_id` (`question_id`),
  KEY `reponse_choisie_id` (`reponse_choisie_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `questions`
--

DROP TABLE IF EXISTS `questions`;
CREATE TABLE IF NOT EXISTS `questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categorie_id` int NOT NULL,
  `texte_question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `categorie_id` (`categorie_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `reponses`
--

DROP TABLE IF EXISTS `reponses`;
CREATE TABLE IF NOT EXISTS `reponses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_id` int NOT NULL,
  `texte_reponse` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `est_correcte` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `resultats`
--

DROP TABLE IF EXISTS `resultats`;
CREATE TABLE IF NOT EXISTS `resultats` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tentative_id` int NOT NULL,
  `score_qi` int NOT NULL,
  `bonnes_reponses` int NOT NULL,
  `total_questions` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tentative_id` (`tentative_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `tentatives`
--

DROP TABLE IF EXISTS `tentatives`;
CREATE TABLE IF NOT EXISTS `tentatives` (
  `id` int NOT NULL AUTO_INCREMENT,
  `utilisateur_id` int NOT NULL,
  `date_debut` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `date_fin_prevue` timestamp NULL DEFAULT NULL,
  `date_fin_reelle` timestamp NULL DEFAULT NULL,
  `statut` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'en_cours',
  PRIMARY KEY (`id`),
  KEY `utilisateur_id` (`utilisateur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mot_de_passe` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_inscription` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`id`, `nom`, `email`, `mot_de_passe`, `date_inscription`) VALUES
(1, 'admin', 'mhsudais66@gmail.com', '$2y$10$N4dR4PpU41fD0kW1dN61QOBuNNFrWwBc.aQ56WwfFRd5PebW36/CG', '2026-06-24 03:38:39');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `historique_choix`
--
ALTER TABLE `historique_choix`
  ADD CONSTRAINT `historique_choix_ibfk_1` FOREIGN KEY (`tentative_id`) REFERENCES `tentatives` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `historique_choix_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `historique_choix_ibfk_3` FOREIGN KEY (`reponse_choisie_id`) REFERENCES `reponses` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`categorie_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `reponses`
--
ALTER TABLE `reponses`
  ADD CONSTRAINT `reponses_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `resultats`
--
ALTER TABLE `resultats`
  ADD CONSTRAINT `resultats_ibfk_1` FOREIGN KEY (`tentative_id`) REFERENCES `tentatives` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `tentatives`
--
ALTER TABLE `tentatives`
  ADD CONSTRAINT `tentatives_ibfk_1` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : sam. 27 juin 2026 à 23:21
-- Version du serveur : 8.4.7
-- Version de PHP : 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `test_qi`
--

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `historique_choix`
--

DROP TABLE IF EXISTS `historique_choix`;
CREATE TABLE IF NOT EXISTS `historique_choix` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tentative_id` int NOT NULL,
  `question_id` int NOT NULL,
  `reponse_choisie_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tentative_id` (`tentative_id`),
  KEY `question_id` (`question_id`),
  KEY `reponse_choisie_id` (`reponse_choisie_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `questions`
--

DROP TABLE IF EXISTS `questions`;
CREATE TABLE IF NOT EXISTS `questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categorie_id` int NOT NULL,
  `texte_question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `categorie_id` (`categorie_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `reponses`
--

DROP TABLE IF EXISTS `reponses`;
CREATE TABLE IF NOT EXISTS `reponses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_id` int NOT NULL,
  `texte_reponse` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `est_correcte` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `resultats`
--

DROP TABLE IF EXISTS `resultats`;
CREATE TABLE IF NOT EXISTS `resultats` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tentative_id` int NOT NULL,
  `score_qi` int NOT NULL,
  `bonnes_reponses` int NOT NULL,
  `total_questions` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tentative_id` (`tentative_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `tentatives`
--

DROP TABLE IF EXISTS `tentatives`;
CREATE TABLE IF NOT EXISTS `tentatives` (
  `id` int NOT NULL AUTO_INCREMENT,
  `utilisateur_id` int NOT NULL,
  `date_debut` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `date_fin_prevue` timestamp NULL DEFAULT NULL,
  `date_fin_reelle` timestamp NULL DEFAULT NULL,
  `statut` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'en_cours',
  PRIMARY KEY (`id`),
  KEY `utilisateur_id` (`utilisateur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mot_de_passe` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_inscription` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`id`, `nom`, `email`, `mot_de_passe`, `date_inscription`) VALUES
(1, 'admin', 'mhsudais66@gmail.com', '$2y$10$N4dR4PpU41fD0kW1dN61QOBuNNFrWwBc.aQ56WwfFRd5PebW36/CG', '2026-06-24 03:38:39');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `historique_choix`
--
ALTER TABLE `historique_choix`
  ADD CONSTRAINT `historique_choix_ibfk_1` FOREIGN KEY (`tentative_id`) REFERENCES `tentatives` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `historique_choix_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `historique_choix_ibfk_3` FOREIGN KEY (`reponse_choisie_id`) REFERENCES `reponses` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`categorie_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `reponses`
--
ALTER TABLE `reponses`
  ADD CONSTRAINT `reponses_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `resultats`
--
ALTER TABLE `resultats`
  ADD CONSTRAINT `resultats_ibfk_1` FOREIGN KEY (`tentative_id`) REFERENCES `tentatives` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `tentatives`
--
ALTER TABLE `tentatives`
  ADD CONSTRAINT `tentatives_ibfk_1` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
