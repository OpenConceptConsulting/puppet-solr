# == Definition: solr::core
# This definition sets up solr config and data directories for each core
#
# === Parameters
# - The $core to create
#
# === Actions
# - Creates the solr web app directory for the core
# - Copies over the config directory for the file
# - Creates the data directory for the core
#
define solr::core (
  $core_name   = $title,
  $manage_conf = true,
  $solr_home   = $::solr::solr_home,
  $solr_data   = $::solr::solr_data,
) {

  $core_home = "${solr_home}/${core_name}"
  $core_data = "${solr_data}/${core_name}"

  file { [$core_home, $core_data]:
    ensure => directory,
    owner  => 'jetty',
    group  => 'jetty',
  }

  file { "${core_home}/conf":
    ensure  => directory,
    owner   => 'jetty',
    group   => 'jetty',
    recurse => true,
    source  => 'puppet:///modules/solr/conf',
  }

}
