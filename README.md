@@ -1,29 +1,29 @@
<!-- markdownlint-disable first-line-heading -->

# It is custom config of 
## a-quadrato config.nvim 
## kickstart 
## tutorial from typecraft
[a-quadrato](https://github.com/a-quadrato/config.nvim)
[kickstart](https://github.com/nvim-lua/kickstart.nvim)
[typecraft](https://www.youtube.com/playlist?list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn)


# **🔧 Installation**

Simply clone this repository into either `~/.config/neovim`, `~/.neovim`, or `~/.config/nvim`.

All others dependencies and plugins should install automatically once you run `neovim`
with this configuration.

# **📦 Dependencies**

A couple of external dependencies are needed for our configuration of `neovim` to
work correctly. Install the following packages with your preferred package
manager or the language specific one.

## Nvim
```
cd /
sudo npm install -g neovim
```
## JS/Json/Html/CSS
```
cd /
sudo npm install -g typescript typescript-language-server
sudo npm install -g vscode-json-languageserver
sudo npm install -g vscode-langservers-extracted
```
## C#
```
sudo apt install dotnet-sdk-8.0
```
## Python
```
sudo npm install -g pyright
sudo apt install python3.10-venv
```
## Liquid project
``package.json``
```{
  "name": "galentus",
  "private": true,
  "scripts": {
    "dev": "shopify theme dev -e development",
    "check": "shopify theme check",
    "pull": "shopify theme pull -d -o sections/*.json templates/*.json config/*.json"
  },
  "devDependencies": {
    "@shopify/cli": "^3.50.0",
    "@shopify/theme": "^3.50.0",
    "prettier": "^2.8.8",
    "@shopify/prettier-plugin-liquid": "^0.1.0"  
  },
  "prettier": {
    "plugins": ["@shopify/prettier-plugin-liquid"]  
  }
}

```
