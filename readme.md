# Test devenv

[https://devenv.sh/](https://devenv.sh/)

## Installation

### Installation nix

on force la version précédente pour [éviter le bug sur la 2.24](https://github.com/cachix/devenv/issues/1364)
```bash
export NIX_INSTALLER_BINARY_ROOT=https://install.determinate.systems/nix/tag/v0.23.0 
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```



### Installation devenv

dans /etc/nix/nix.conf, ajouter la ligne suivante

```
trusted-users = root <your-user> 
```

<your-user> doit étre remplacé par l'utilisateur courant (ce qu'affiche la commande whoami dans un terminal)

```
nix profile install --accept-flake-config nixpkgs#devenv
```

## Utilisation

Toute la configuration se fait depuis devenv.nix

### Lancement d'un shell contenant tout les outils

```bash
devenv shell
```


## lancement des services



```bash
devenv up
```

=> si vous étes dans un WSL, pensez à lancer sudo chmod 0666 /dev/tty