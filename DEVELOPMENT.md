# Development Documentation

## Technical Details

**Namespace:** `rgpvpwvpnfc`
- `rg`: RagedUnicorn (developer prefix)
- `pvpw`: PVPWarn (main addon)
- `vp`: Voice Pack
- `nfc`: Nightelf Female Classic

### Code Structure

The voice pack follows a modular structure:

- `Core.lua` - Main initialization and registration with PVPWarn
- `Constants.lua` - Addon constants and configuration values
- `Environment.lua` - Environment-specific settings
- `Logger.lua` - Logging utilities
- `Frame.xml` - UI frame definitions

### Integration with PVPWarn

The voice pack registers itself with the main PVPWarn addon using:

```lua
rgpvpw.addon.RegisterVoicePack(
    RGPVPW_VP_NFC_CONSTANTS.ADDON_NAME,
    RGPVPW_VP_NFC_CONSTANTS.DISPLAY_NAME,
    RGPVPW_VP_NFC_CONSTANTS.ASSET_PATH
)
```

### Adding New Voice Files

Voice files should be placed in the appropriate directory structure that mirrors PVPWarn's sound organization:
- `assets/sounds/[category]/[spell_name].mp3`

### Development Workflow

1. Clone the repository
2. Make changes to the code
3. Test in-game with PVPWarn installed
4. Ensure all voice files are properly registered
5. Submit pull request with changes

### Debugging

Debug logging is automatically enabled when using the development profile (which is active by default). The development profile sets the appropriate logging levels in `Environment.lua`.

To ensure debug logging is active:
```bash
# Generate development environment files
mvn generate-resources -D generate.sources.overwrite=true -P development
```

This will generate `Environment.lua` with debug logging enabled. You can also manually adjust logging levels in `Environment.lua` if needed.

### Building for Release

1. Ensure all development files are removed
2. Verify all voice files are included
3. Update version in `.toc` file
4. Create release package

## Build System

This project uses Maven for build automation and deployment. The build system handles environment switching, packaging, and deployment to various addon platforms.

### Maven Profiles

The project includes several Maven profiles for different purposes:

#### Development Profile (default)
```bash
mvn clean package
```
- Includes debug logging and development files
- Generates development-specific environment files
- Package includes `development` suffix

#### Release Profile
```bash
mvn clean package -P release
```
- Optimized for production use
- Excludes development files
- Minimal logging

#### Deployment Profiles

**GitHub Release:**
```bash
mvn package -P deploy-github -D github.auth-token=[token]
```

**CurseForge Release:**
```bash
mvn package -P deploy-curseforge -D curseforge.auth-token=[token]
```
- Note: Update `addon.curseforge.projectId` in pom.xml before deploying

**Wago.io Release:**
```bash
mvn package -P deploy-wago -D wago.auth-token=[token]
```
- Note: Update `addon.wago.projectId` in pom.xml before deploying

### Environment Switching

The build system can generate environment-specific files:

```bash
# Switch to development
mvn generate-resources -D generate.sources.overwrite=true -P development

# Switch to release
mvn generate-resources -D generate.sources.overwrite=true -P release
```

This will generate/update:
- `PVPWarn_VoicePack_NFC.toc` (from templates)
- `code/Environment.lua` (from environment.lua.tpl)

**Important:** Always commit files in development state. The repository should maintain development configuration by default.

### Build Resources

The `build-resources/` directory contains:
- `addon-development.properties` - Development environment variables
- `addon-release.properties` - Release environment variables
- `assembly-*.xml` - Package assembly descriptors
- `*.tpl` - Template files for environment-specific generation
- `release-notes.md` - Release notes for deployments

### Creating a New Release

1. Update version in `pom.xml`
2. Update release notes in `build-resources/release-notes.md`
3. Switch to release environment:
   ```bash
   mvn generate-resources -D generate.sources.overwrite=true -P release
   ```
4. Package the addon:
   ```bash
   mvn clean package -P release
   ```
5. Deploy to platforms as needed (see deployment profiles above)
6. Switch back to development:
   ```bash
   mvn generate-resources -D generate.sources.overwrite=true -P development
   ```

### Continuous Integration

The project supports GitHub Actions for automated builds and deployments. See `.github/workflows/` for CI configuration.
