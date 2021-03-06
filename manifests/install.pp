class ucspi-tcp::install (
    $pkg_url = 'http://cr.yp.to/ucspi-tcp/ucspi-tcp-0.88.tar.gz',
    $build_dir = '/usr/local/src',
  ){

  if $pkg_url =~ /^.*\/([^\/]*)$/ { $pkg_tarball_name = $1 }
  if $pkg_tarball_name =~ /^(.*)\.tar\.gz$/ { $pkg_name = $1 }

  ## Sure, we'd like an rpm.  But there isn't one in the main distro's repo.
  ## If you have an rpm (or deb, I guess) of ucspi-tcp, just uncomment this
  ## and comment out the manual installation below.

  ## Simple package installation:
  #  package{'ucspi-tcp':
  #    ensure => installed,
  #  }

  ## Manual installation of ucspi-tcp

  file {
    "ucspi-tcp conf-cc":
      mode    => 644,
      owner   => root,
      group   => root,
      path    => "${build_dir}/$pkg_name/conf-cc",
      source  => "puppet:///modules/ucspi-tcp/conf-cc",
      require => Exec['get ucspi-tcp'];
  }

  exec {
    'get ucspi-tcp':
      cwd     => "${build_dir}",
      command => "/usr/bin/wget -q ${pkg_url} && tar xpfz ${pkg_tarball_name} && rm ${build_dir}/${pkg_tarball_name}",
      creates => "${build_dir}/${pkg_name}";

    'install ucspi-tcp':
      cwd     => "${build_dir}/${pkg_name}",
      command => "make && make setup check",
      creates => "/usr/local/bin/tcpserver",
      require => [Exec['get ucspi-tcp'], File['ucspi-tcp conf-cc']];
  }

  ## End manual installation
}
