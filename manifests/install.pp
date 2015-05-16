# == Class: solr::install
# This class installs the required packages for jetty
#
# === Actions
# - Installs default jdk
# - Installs jetty and extra libs
# - Downloads and extracts solr
#

class solr::install inherits solr {

  $dl_name = "solr-${solr::version}.tgz"
  $dl_url  = "${solr::dl_mirror}/${solr::version}/${dl_name}"

  package { 'default-jdk':
    ensure => present,
  } ->
  package { 'jetty':
    ensure => present,
  } ->
  package { 'libjetty-extra':
    ensure => present,
  }

  if ! defined(Package['wget']) {
    package { 'wget':
      ensure => present,
    }
  }

  if ! defined(Package['curl']) {
    package { 'curl':
      ensure => present,
    }
  }
  
  file { $solr::solr_home:
    ensure  => directory,
    owner   => 'jetty',
    group   => 'jetty',
    require => Package['jetty'],
  }

  file { $solr::solr_data:
    ensure  => directory,
    owner   => 'jetty',
    group   => 'jetty',
    mode    => '0700',
    require => Package['jetty'],
  }

  exec { 'download-solr':
    path    => [ '/bin', '/sbin' , '/usr/bin', '/usr/sbin', '/usr/local/bin' ],
    command => "wget ${dl_url}",
    cwd     => $solr::dl_dir,
    creates => "${solr::dl_dir}/${dl_name}",
    onlyif  => "test ! -d ${solr::solr_home}/WEB-INF && test ! -f ${solr::dl_dir}/${dl_name}",
    timeout => 0,
  }

  exec { 'extract-solr':
    path    => [ '/bin', '/sbin' , '/usr/bin', '/usr/sbin', '/usr/local/bin' ],
    command => "tar xvf ${dl_name}",
    cwd     => $solr::dl_dir,
    onlyif  => "test -f ${solr::dl_dir}/${dl_name} && test ! -d ${solr::dl_dir}/solr-${solr::version}",
    require => Exec['download-solr'],
  }

  exec { 'copy-solr':
    path    => [ '/bin', '/sbin' , '/usr/bin', '/usr/sbin', '/usr/local/bin' ],
    command => "jar xvf ${solr::dl_dir}/solr-${solr::version}/dist/solr-${solr::version}.war; \
    cp ${solr::dl_dir}/solr-${solr::version}/example/lib/ext/*.jar WEB-INF/lib",
    cwd     => $solr::solr_home,
    onlyif  => "test ! -d ${solr::solr_home}/WEB-INF",
    require => [Exec['extract-solr'], File[$solr::solr_home]]
  }

}

