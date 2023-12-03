-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Jogador" (
    "nome" TEXT NOT NULL,
    "apelido" TEXT NOT NULL,
    "posicao" TEXT NOT NULL,
    "foto" TEXT,
    "time_nome" TEXT NOT NULL,
    "time_complemento" TEXT NOT NULL,
    "time_anterior" TEXT,
    "data_nascimento" TEXT NOT NULL,
    "nacionalidade" TEXT NOT NULL,
    "suspenso" BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY ("nome", "apelido"),
    CONSTRAINT "Jogador_time_nome_time_complemento_fkey" FOREIGN KEY ("time_nome", "time_complemento") REFERENCES "Time" ("nome", "complemento") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Jogador" ("apelido", "data_nascimento", "foto", "nacionalidade", "nome", "posicao", "suspenso", "time_anterior", "time_complemento", "time_nome") SELECT "apelido", "data_nascimento", "foto", "nacionalidade", "nome", "posicao", "suspenso", "time_anterior", "time_complemento", "time_nome" FROM "Jogador";
DROP TABLE "Jogador";
ALTER TABLE "new_Jogador" RENAME TO "Jogador";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
