# Google Keep wrapper
A basic [NeutralinoJS][neu] app that wraps `keep.google.com`.

NeutralinoJS was chosen because it's lighter than Electron, and runs on JS instead of Tauri's Rust.

## How to install NeutralinoJS's runtime
```bash
npm install -g @neutralinojs/neu
```

### What about a new project from scratch?
```bash
neu create folder-name --template neutralinojs/neutralinojs-zero
```

## How to add an icon
1. make sure it's a 256px transparent PNG, for best compatibility (or maybe 128px?)
2. point `modes.window.icon` to that file, coming from the root's project dir
3. add the dir where the icon as `cli.resourcesPath`

## How to debug
Add `modes.window.enableInspector: true` to the `neutralino.config.json` and run it with `neu run`.

## How to build a release file
```bash
$ neu build --release
# ./dist/google-keep/keep-linux_x64
```


[neu]: https://neutralino.js.org
