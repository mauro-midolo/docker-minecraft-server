# 🧱 Minecraft Server – Docker

Questo progetto fornisce un'immagine Docker pronta all’uso per avviare un server **Minecraft Java Edition**.

L’immagine è disponibile su Docker Hub:

mauromidolo/minecraft-server

---

# 🚀 Avvio rapido

Avvia il server con:

```bash
docker run -d \
  -p 25565:25565 \
  --name minecraft \
  mauromidolo/minecraft-server:latest
```

Il server sarà disponibile sulla porta:

25565

---

# 🌍 Avviare il server con un Seed personalizzato (opzionale)

Puoi specificare il seed del mondo usando il parametro:

--seed

Esempio:

```bash
docker run -d \
  -p 25565:25565 \
  --name minecraft \
  mauromidolo/minecraft-server:latest \
  --seed 123456789
```

Oppure:

```bash
docker run -d \
  -p 25565:25565 \
  --name minecraft \
  mauromidolo/minecraft-server:latest \
  --seed=123456789
```

⚠️ Importante:  
Il seed viene applicato **solo alla prima creazione del mondo**.  
Se esiste già una cartella `world`, Minecraft ignorerà il nuovo seed.

---

# 💾 Salvataggio mondo (consigliato)

Per non perdere il mondo al riavvio del container:

```bash
docker run -d \
  -p 25565:25565 \
  -v minecraft-data:/home/minecraft-user \
  --name minecraft \
  mauromidolo/minecraft-server:latest
```

Oppure con una cartella locale:

```bash
docker run -d \
  -p 25565:25565 \
  -v $(pwd)/data:/home/minecraft-user \
  --name minecraft \
  mauromidolo/minecraft-server:latest
```

Puoi combinare volume + seed:

```bash
docker run -d \
  -p 25565:25565 \
  -v minecraft-data:/home/minecraft-user \
  --name minecraft \
  mauromidolo/minecraft-server:latest \
  --seed 987654321
```

---

# 🔄 Aggiornare il server

1. Ferma il container:

```bash
docker stop minecraft
docker rm minecraft
```

2. Scarica l’ultima versione:

```bash
docker pull mauromidolo/minecraft-server:latest
```

3. Riavvia il container

---

# ⚙️ Dettagli tecnici

- Base: Alpine Linux
- Java: OpenJDK 21
- Utente non-root (minecraft-user)
- Porta esposta: 25565
- Supporto parametro opzionale --seed

---

# 📜 Nota

Assicurati di aver accettato la Minecraft EULA.

Il file `eula.txt` deve contenere:

```
eula=true
```
