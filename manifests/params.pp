# == Class: solr::params
# This class sets up some required parameters
#
# === Actions
# - Specifies jetty and solr home directories
# - Specifies the default core
#
class solr::params {

  $cores     = ['default']
  $version   = '4.7.2'
  $dl_mirror = 'http://www.us.apache.org/dist/lucene/solr'
  $dl_dir    = '/tmp'

  $default_jetty_home = '/usr/share/jetty'
  $default_solr_home  = '/usr/share/solr'
  $default_solr_data  = '/var/lib/solr'

  case $::osfamily {
    Debian: {
      $jetty_home = $default_jetty_home
      $solr_home  = $default_solr_home
      $solr_data  = $default_solr_data
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

}

