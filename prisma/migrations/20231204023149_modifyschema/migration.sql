/*
  Warnings:

  - You are about to drop the column `data_nascimento` on the `Jogador` table. All the data in the column will be lost.
  - Added the required column `idade` to the `Jogador` table without a default value. This is not possible if the table is not empty.

*/
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
    "idade" TEXT NOT NULL,
    "nacionalidade" TEXT NOT NULL,
    "suspenso" BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY ("nome", "apelido"),
    CONSTRAINT "Jogador_time_nome_time_complemento_fkey" FOREIGN KEY ("time_nome", "time_complemento") REFERENCES "Time" ("nome", "complemento") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Jogador" ("apelido", "foto", "nacionalidade", "nome", "posicao", "suspenso", "time_anterior", "time_complemento", "time_nome") SELECT "apelido", "foto", "nacionalidade", "nome", "posicao", "suspenso", "time_anterior", "time_complemento", "time_nome" FROM "Jogador";
DROP TABLE "Jogador";
ALTER TABLE "new_Jogador" RENAME TO "Jogador";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
