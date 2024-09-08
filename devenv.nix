{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  # packages = [ pkgs.git ];

  # https://devenv.sh/languages/
  # languages.rust.enable = true;


  languages = {
    php = {
        enable = true;
        version = "8.3";
        extensions = ["redis"];
    };
    javascript = {
      enable = true;
      package = pkgs.nodejs_20;
      corepack.enable = true;
    };
};
services = {
  adminer = {
    enable = true;
  };
  postgres = {
    enable = true;
    package = pkgs.postgresql_16;
    initialDatabases = [
      {
        name = "app";
      }
    ];
    initialScript = ''
      CREATE ROLE admin WITH LOGIN SUPERUSER PASSWORD 'admin';
    '';
  };
  rabbitmq = {
    enable = true;
    managementPlugin.enable = true;
  };
  redis = {
    enable = true;
  };
  mailhog = {
    enable = true;
  };
};

services = {
  caddy = {
    enable = true;
    config = ''
      :1234 {
        route /api/* {
            uri strip_prefix /api
            reverse_proxy localhost:8000
        }
      
        reverse_proxy localhost:3000
      }
    '';
  };
};

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  enterShell = ''
    hello there
  '';

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
  '';

  processes = {
    symfony.exec = "cd symfony && ${pkgs.symfony-cli}/bin/symfony server:start";
    nextjs.exec = "cd front && npm run dev";
  };
# process-managers.overmind.enable = true;

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
