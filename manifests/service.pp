# == Class: solr::service
# This class sets up solr service
#
# === Actions
# - Sets up jetty service
#
class solr::service inherits solr {

  service { 'jetty':
    ensure => running,
    enable => true,
  }

}


