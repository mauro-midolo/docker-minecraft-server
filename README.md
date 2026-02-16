# 🧱 Minecraft Server – Docker

Questo progetto fornisce un'immagine Docker pronta all’uso per avviare un server Minecraft Java Edition.

L’immagine è disponibile su Docker Hub:

mauromidolo/minecraft-server

---

# 🚀 Avvio rapido

Avvia il server con:

docker run -d \
  -p 25565:25565 \
  --name minecraft \
  mauromidolo/minecraft-server:latest

Il server sarà disponibile sulla porta:

25565

---

# 💾 Salvataggio mondo (consigliato)

Per non perdere il mondo al riavvio del container:

docker run -d \
  -p 25565:25565 \
  -v minecraft-data:/home/minecraft-user \
  --name minecraft \
  mauromidolo/minecraft-server:latest

Oppure con una cartella locale:

docker run -d \
  -p 25565:25565 \
  -v $(pwd)/data:/home/minecraft-user \
  --name minecraft \
  mauromidolo/minecraft-server:latest

---

# 🔄 Aggiornare il server

1. Ferma il container
2. Esegui:

docker pull mauromidolo/minecraft-server:latest

3. Riavvia il container

---

# ⚙️ Dettagli

- Base: Alpine Linux
- Java: OpenJDK 21
- Utente non-root (minecraft-user)
- Porta esposta: 25565

---

# 📜 Nota

Assicurati di aver accettato la EULA Minecraft.
