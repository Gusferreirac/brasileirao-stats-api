-- CreateTable
CREATE TABLE "Time" (
    "nome" TEXT NOT NULL,
    "complemento" TEXT NOT NULL,
    "escudo" TEXT NOT NULL,
    "tecnico" TEXT NOT NULL,
    "estadio" TEXT NOT NULL,
    "cidade" TEXT NOT NULL,
    "vitorias" INTEGER NOT NULL DEFAULT 0,
    "empates" INTEGER NOT NULL DEFAULT 0,
    "derrotas" INTEGER NOT NULL DEFAULT 0,

    PRIMARY KEY ("nome", "complemento")
);

-- CreateTable
CREATE TABLE "Partida" (
    "num_partida" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "mandante_nome" TEXT NOT NULL,
    "mandante_complemento" TEXT NOT NULL,
    "visitante_nome" TEXT NOT NULL,
    "visitante_complemento" TEXT NOT NULL,
    "rodada" INTEGER NOT NULL,
    "data_hora" TEXT NOT NULL,
    "arbitros" TEXT NOT NULL,
    "local" TEXT NOT NULL,
    CONSTRAINT "Partida_mandante_nome_mandante_complemento_fkey" FOREIGN KEY ("mandante_nome", "mandante_complemento") REFERENCES "Time" ("nome", "complemento") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Partida_visitante_nome_visitante_complemento_fkey" FOREIGN KEY ("visitante_nome", "visitante_complemento") REFERENCES "Time" ("nome", "complemento") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Jogador" (
    "nome" TEXT NOT NULL,
    "apelido" TEXT NOT NULL,
    "posicao" TEXT NOT NULL,
    "foto" TEXT NOT NULL,
    "time_nome" TEXT NOT NULL,
    "time_complemento" TEXT NOT NULL,
    "time_anterior" TEXT NOT NULL,
    "data_nascimento" TEXT NOT NULL,
    "nacionalidade" TEXT NOT NULL,
    "suspenso" BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY ("nome", "apelido"),
    CONSTRAINT "Jogador_time_nome_time_complemento_fkey" FOREIGN KEY ("time_nome", "time_complemento") REFERENCES "Time" ("nome", "complemento") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Gol" (
    "tempo" INTEGER NOT NULL,
    "num_partida" INTEGER NOT NULL,
    "jogador_gol_nome" TEXT NOT NULL,
    "jogador_gol_apelido" TEXT NOT NULL,
    "jogador_assistencia_nome" TEXT NOT NULL,
    "jogador_assistencia_apelido" TEXT NOT NULL,
    "tipo" TEXT NOT NULL,
    "time" TEXT NOT NULL,
    "minuto" INTEGER NOT NULL,

    PRIMARY KEY ("tempo", "num_partida"),
    CONSTRAINT "Gol_num_partida_fkey" FOREIGN KEY ("num_partida") REFERENCES "Partida" ("num_partida") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Gol_jogador_gol_nome_jogador_gol_apelido_fkey" FOREIGN KEY ("jogador_gol_nome", "jogador_gol_apelido") REFERENCES "Jogador" ("nome", "apelido") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Gol_jogador_assistencia_nome_jogador_assistencia_apelido_fkey" FOREIGN KEY ("jogador_assistencia_nome", "jogador_assistencia_apelido") REFERENCES "Jogador" ("nome", "apelido") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Falta" (
    "tempo" INTEGER NOT NULL,
    "time_faltoso" TEXT NOT NULL,
    "participante_faltoso" TEXT NOT NULL,
    "tipo_falta" TEXT NOT NULL,
    "cartao" TEXT NOT NULL,
    "num_partida" INTEGER NOT NULL,

    PRIMARY KEY ("tempo", "num_partida"),
    CONSTRAINT "Falta_num_partida_fkey" FOREIGN KEY ("num_partida") REFERENCES "Partida" ("num_partida") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Time_Pass" (
    "nome" TEXT NOT NULL,
    "complemento" TEXT NOT NULL,
    "nome_jogador" TEXT NOT NULL,
    "apellido_jogador" TEXT NOT NULL,

    PRIMARY KEY ("nome", "complemento"),
    CONSTRAINT "Time_Pass_nome_jogador_apellido_jogador_fkey" FOREIGN KEY ("nome_jogador", "apellido_jogador") REFERENCES "Jogador" ("nome", "apelido") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Substituicoes" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nome_jogador_entra" TEXT NOT NULL,
    "nome_jogador_sai" TEXT NOT NULL,
    "apelido_jogador_entra" TEXT NOT NULL,
    "apelido_jogador_sai" TEXT NOT NULL,
    "tempo_partida" INTEGER NOT NULL,
    "num_partida" INTEGER NOT NULL,
    "nome_time" TEXT NOT NULL,
    "complemento_time" TEXT NOT NULL,
    CONSTRAINT "Substituicoes_nome_time_complemento_time_fkey" FOREIGN KEY ("nome_time", "complemento_time") REFERENCES "Time" ("nome", "complemento") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Substituicoes_num_partida_fkey" FOREIGN KEY ("num_partida") REFERENCES "Partida" ("num_partida") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Joga" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nome_jogador" TEXT NOT NULL,
    "apelido_jogador" TEXT NOT NULL,
    "posicao_jogador" TEXT NOT NULL,
    "num_partida" INTEGER NOT NULL,
    "substituicoes_id" INTEGER NOT NULL,
    CONSTRAINT "Joga_nome_jogador_apelido_jogador_fkey" FOREIGN KEY ("nome_jogador", "apelido_jogador") REFERENCES "Jogador" ("nome", "apelido") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Joga_num_partida_fkey" FOREIGN KEY ("num_partida") REFERENCES "Partida" ("num_partida") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Joga_substituicoes_id_fkey" FOREIGN KEY ("substituicoes_id") REFERENCES "Substituicoes" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
