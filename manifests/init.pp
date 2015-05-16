# == Class: solr
#
# This module helps you create a multi-core solr install
# from scratch. I'm packaging a version of solr in the files
# directory for convenience. You can replace it with a newer
# version if you like.
#
# IMPORTANT: Works only with Ubuntu as of now. Other platform
# support is most welcome.
#
# === Parameters
#
# [*cores*]
#   "Specify the solr cores you want to create (optional)"
#
# === Examples
#
# Default case, which creates a single core called 'default'
#
#  include solr
#
# If you want multiple cores, you can supply them like so:
#
#  class { 'solr':
#    cores => [ 'development', 'staging', 'production' ]
#  }
#
# You can also manage/create your cores from solr web admin panel.
#
# === Authors
#
# Vamsee Kanakala <vamsee AT riseup D0T net>
# Xavier Landreville <xavier AT openconcept DOT ca>
#
# === Copyright
#
# Copyright 2012-2013 Vamsee Kanakala, unless otherwise noted.
# Copyright 2015 OpenConcept Consulting Inc.
#

class solr (
  $cores     = $solr::params::cores,
  $version   = $solr::params::version,
  $dl_mirror = $solr::params::dl_mirror,
  $dl_dir    = $solr::params::dl_dir,
) inherits solr::params {

  anchor { 'solr::begin': } ->
  class { 'solr::install': } ->
  class { 'solr::config': } ~>
  class { 'solr::service': } ->
  anchor { 'solr::end': }

}
