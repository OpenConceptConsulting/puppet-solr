# == Class: solr::config
# This class sets up solr install
#
# === Parameters
# - The $cores to create
#
# === Actions
# - Copies a new jetty default file
# - Creates solr home directory
# - Downloads the required solr version, extracts war and copies logging jars
# - Creates solr data directory
# - Creates solr config file with cores specified
# - Links solr home directory to jetty webapps directory
#
class solr::config inherits solr {

  augeas { 'jetty_solr_home':
    context => '/files/etc/default/jetty',
    changes => [
      'set JAVA_OPTIONS \"-Dsolr.solr.home=/usr/share/solr $JAVA_OPTIONS\"',
    ],
  }

  file { "${solr::solr_home}/solr.xml":
    ensure  => file,
    owner   => 'jetty',
    group   => 'jetty',
    content => template('solr/solr.xml.erb'),
    require => File['/etc/default/jetty'],
  }

  file { "${solr::jetty_home}/webapps/solr":
    ensure  => link,
    target  => $solr::solr_home,
    require => [File[$solr::solr_home], File[$solr::jetty_home]],
  }

  solr::core { $solr::cores:
  }
}

