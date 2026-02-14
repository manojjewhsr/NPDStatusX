# Quick Rebuild Reference

Quick reference for rebuilding the NPDStatusX project. For detailed documentation, see [REBUILD.md](REBUILD.md).

## Prerequisites

- **Windows**: Visual Studio 2017+ or MSBuild
- **Linux/macOS**: Mono with MSBuild/XBuild
- **All platforms**: Internet connection for package restore

## Quick Start

### Windows

```powershell
# PowerShell (Recommended)
.\rebuild.ps1

# Command Prompt
rebuild.bat

# Make (if installed)
make rebuild
```

### Linux/macOS

```bash
# Bash
./rebuild.sh

# Make
make rebuild
```

## Common Commands

| Action | PowerShell | Bash | Make |
|--------|-----------|------|------|
| Full rebuild | `.\rebuild.ps1` | `./rebuild.sh` | `make rebuild` |
| Build Debug | `.\rebuild.ps1 -Configuration Debug` | `./rebuild.sh -c Debug` | `make build CONFIG=Debug` |
| Clean first | `.\rebuild.ps1 -Clean` | `./rebuild.sh --clean` | `make clean` |
| Restore only | `.\rebuild.ps1 -Restore` | `./rebuild.sh --restore` | `make restore` |
| Build only | `.\rebuild.ps1 -Build` | `./rebuild.sh --build` | `make build` |
| Show help | `.\rebuild.ps1 -Help` | `./rebuild.sh --help` | `make help` |

## Build Output

Successful builds create files in:
- `bin/Release/` - Release build (optimized)
- `bin/Debug/` - Debug build (with symbols)

## Deployment Files

Copy these files to IIS:
```
NPDStatusDashboard.aspx
NPDStatusDashboard.css
Web.config
bin/ (entire folder)
```

## Troubleshooting

| Problem | Solution |
|---------|----------|
| MSBuild not found | Install Visual Studio or Mono |
| NuGet not found | Script will auto-download |
| Build fails | Check error messages, ensure dependencies installed |
| Permission denied (Linux) | `chmod +x rebuild.sh` |

## CI/CD

GitHub Actions workflows are available:
- `.github/workflows/build.yml` - Comprehensive build
- `.github/workflows/quick-build.yml` - Fast build

## Need Help?

- Full documentation: [REBUILD.md](REBUILD.md)
- Installation guide: [INSTALLATION.md](INSTALLATION.md)
- Project overview: [README.md](README.md)
