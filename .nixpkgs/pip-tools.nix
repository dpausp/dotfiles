{ python3Packages }:

python3Packages.pip-tools.overrideAttrs(oldAttrs: rec {
    version = "4.2.0";
    doInstallCheck = false;
    propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ python3Packages.setuptools ];
    name = "pip-tools-${version}";
    src = python3Packages.fetchPypi {
      inherit version;
      inherit (oldAttrs) pname;
      sha256 = "05s9qyydjixjsz13pimwmpwld3rdkg7cmyw575r4jmhpri6yl9sl";
    };
    meta.broken = false;
  })
