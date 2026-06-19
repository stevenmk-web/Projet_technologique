create database `test_qi`;
use `test_qi`;
-- 1. Catégories
CREATE TABLE `categories` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `nom` VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- 2. Utilisateurs
CREATE TABLE `utilisateurs` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `nom` VARCHAR(100) NOT NULL,
    `email` VARCHAR(150) NOT NULL UNIQUE,
    `mot_de_passe` VARCHAR(255) NOT NULL,
    `date_inscription` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 3. Questions
CREATE TABLE `questions` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `categorie_id` INT NOT NULL,
    `texte_question` TEXT NOT NULL,
    FOREIGN KEY (`categorie_id`) REFERENCES `categories`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 4. Réponses possibles
CREATE TABLE `reponses` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `question_id` INT NOT NULL,
    `texte_reponse` TEXT NOT NULL,
    `est_correcte` TINYINT(1) DEFAULT 0,
    FOREIGN KEY (`question_id`) REFERENCES `questions`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 5. Tentatives : Suivi de la session de test
CREATE TABLE `tentatives` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `utilisateur_id` INT NOT NULL,
    `date_debut` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `statut` VARCHAR(20) DEFAULT 'en_cours', -- 'en_cours', 'termine', 'abandon'
    FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 6. Résultats : Calculs finaux liés à la tentative
CREATE TABLE `resultats` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `tentative_id` INT NOT NULL UNIQUE,
    `score_qi` INT NOT NULL,
    `bonnes_reponses` INT NOT NULL,
    `total_questions` INT NOT NULL,
    FOREIGN KEY (`tentative_id`) REFERENCES `tentatives`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 7. Historique
