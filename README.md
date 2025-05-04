# Tauri-wrapped web apps

These are an unofficial wrappers for a bunch of web apps I use on my routine, all based on [Tauri](https://tauri.app).

## But why?!

> AKA: can't you just create an app from Vivaldi/Chrome?

For some reason, the Cinnamon Desktop can't find proper icons for web apps created from Chrome or Vivaldi, even if you try to force the icon on the `.desktop` file. Actually, sometimes it works, but it's a big hit-and-miss.

Besides that, even when it worked (back when I used the Mate DE), every now and then the browser would crash (because why wouldn't it), and then it would take down all web apps with it.

This solves both issues: icons are well-defined, and the web apps are not tied to the main program I use to navigate websites and do my daily job.

## Boilerplate instructions

### How to create icons

1. find an icon that should be, ideally, at least 1024x1024. You may want to add some padding to it, if you're building for mobile devices (specially iOS)

2. get into `src-tauri` and run `npm tauri icon «your-file»` __(possible complaints if the file is in the parent directory... create a temporary copy into `src-tauri`)_

3. delete what you won't be using, such as:

4.  - `icons/icon.icns` (Mac stuff)
   
    - `icons/Square*` (why all those odd sizes??)
   
    - `icons/ios`
   
    - `icons/android`

4- make sure the useful icons are listed in `src-tauri/tauri.conf.json5:bundle.icon`

### The rest of useful config entries

> [Reference with all config fields](https://tauri.app/reference/config/)

#### `src-tauri/Cargo.toml`

- `version`: remove it, as the recommended field is from the JSON5

- `name`: no clue why this needs to be repeated between TOML and JSON files...

- `description`: removable

- `edition`: this seems to be the file format version or something similar. 2021 or 2024 should suffice.

- `authors`: used for something I don't recall anymore

- `license`: important

- `homepage`: useful, I guess, and used by some bundles

- `[lib] name`: also needs manual editing (why couldn't this be based on the main `name`??)
  
   - Then, change this at `src-tauri/src/main.ts` as well.

- `[build-dependencies]` and `[dependencies]`: this is where you [configure] it to accept JSON5 — which accepts comments!!

#### `src-tauri/tauri.conf.json5`

- `identifier`: usual reverse-domain notation. This is important for some internal stuff
  
   - It's also used to extract the publisher name (the second element in here)... but only if there's no `authors` in the TOML.

- `productName`: it can accept a humanized name, but please don't — that's used for the bundle files!

- `app`:
  
   - `enableGTKAppId`...?
  
   - `windows`: (Not about the OS! This is a list of configurable windows for the application)
     
      - `url`: **THIS IS WHAT YOU NEED TO CONFIGURE TO POINT TO THE ACTUAL WEB APP YOU WANT TO WRAP!!!!**
     
      - `title`: and please, set the window title as well
     
      - `visibleOnAllWorkspaces`: if it makes sense
     
      - `zoomHotkeysEnabled`: (1) why not (2) not sure what's the default

- `bundle`:
  
   - `shortDescription` and maybe `longDescription`
  
   - `targets`: right now, setting it only to `['deb']` should suffice 🙃 [Check the docs for other packaging methods](https://tauri.app/distribute/)
  
   - `category`: See the [category options in the docs](https://tauri.app/reference/config/#category)
  
   - `homepage`: if not set, defaults to the TOML value
  
   - `license`: also defaults to the TOML value
  
   - `licenseFile`: if you want to point to the file path as well



### How to test it

```bash
$ npm run tauri dev
```

### How to build it

```bash
$ npm run tauri build
```

Bundle files go to `src-tauri/target/release/bundle/`.
The raw executable goes to `src-tauri/target/release/`.

#### How to install it

```bash
$ apt install "src-tauri/target/release/bundle/[...].deb"
```
