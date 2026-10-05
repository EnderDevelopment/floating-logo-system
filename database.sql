CREATE TABLE IF NOT EXISTS floating_logo_settings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    logo_enabled BOOLEAN DEFAULT FALSE,
    auto_shoot_enabled BOOLEAN DEFAULT FALSE,
    UNIQUE KEY (player_id)
);

INSERT INTO floating_logo_settings (player_id, logo_enabled, auto_shoot_enabled) VALUES
(1, FALSE, FALSE);