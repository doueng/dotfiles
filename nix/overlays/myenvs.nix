# Enviroment for various programing languages and related tools
self: super: {
  myenvs = {
    python = self.pkgs.python3.withPackages (
      ps: [
        ps.mypy
        ps.pylint
        ps.yapf
      ]
    );
  };
}
