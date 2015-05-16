require 'spec_helper'

describe 'solr::core', :type => :define do
  let(:title) { 'default' }
  let(:params) { {
    solr_home: '/usr/share/solr',
    solr_data: '/var/lib/solr'
  } }

  context 'managing conf' do
    it { should contain_file('/usr/share/solr/default').with({
      'ensure'    => 'directory',
      'owner'     => 'jetty',
      'group'     => 'jetty' })
    }

    it { should contain_file('/usr/share/solr/default/conf').with({
      'ensure'    =>    'directory',
      'recurse'   =>    'true',
      'source'    =>    'puppet:///modules/solr/conf' })
    }

    it { should contain_file('/var/lib/solr/default').with({
      'ensure'    => 'directory',
      'owner'     => 'jetty',
      'group'     => 'jetty' })
    }
  end

  context 'not managing conf' do
    let(:params) { {
      manage_conf: false,
      solr_home: '/usr/share/solr',
      solr_data: '/var/lib/solr'
    } }

    it { should contain_file('/usr/share/solr/default').with({
      'ensure'    => 'directory',
      'owner'     => 'jetty',
      'group'     => 'jetty' })
    }

    it { should_not contain_file('/usr/share/solr/default/conf').with({
      'ensure'    =>    'directory',
      'recurse'   =>    'true',
      'source'    =>    'puppet:///modules/solr/conf' })
    }

    it { should contain_file('/var/lib/solr/default').with({
      'ensure'    => 'directory',
      'owner'     => 'jetty',
      'group'     => 'jetty' })
    }
  end
end

