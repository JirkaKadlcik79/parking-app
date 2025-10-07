# Claude Instructions for parking-app

## Auto-commit & Push
**DŮLEŽITÉ:** Všechny změny v tomto projektu automaticky commitovat a pushovat na GitHub.

### GitHub Info
- Repository: https://github.com/JirkaKadlcik79/parking-app
- User: JirkaKadlcik79
- Branch: main

### Workflow po každé změně:
```bash
cd /mnt/c/Users/kadlcik/parking-app
git add .
git commit -m "Popis změny

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
git push https://JirkaKadlcik79:TOKEN@github.com/JirkaKadlcik79/parking-app.git main
```

### Nebo pomocí auto-push scriptu:
```bash
./.git-auto-push.sh "Popis změny"
```

## Project Structure
- `backend/` - Node.js API server
- `frontend/` - Single-page HTML aplikace
- `.gitignore` - Git ignore rules
- `README.md` - Dokumentace projektu
