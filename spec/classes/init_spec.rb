require 'spec_helper'

describe 'solr' do

  {'Ubuntu' => 'Debian', 'Debian' => 'Debian'}.each do |system, family|
    context "when on system #{system}" do
      if system == 'Debian'
        let :facts do
          {
            :osfamily        => family,
            :operatingsystem => system,
            :operatingsystemmajrelease => 7,
          }
        end
      else
        let :facts do
          {
            :osfamily        => family,
            :operatingsystem => system,
          }
        end
      end

      it { should contain_class('solr') }
      it { should contain_class('solr::install') }
      it { should contain_class('solr::config') }
      it { should contain_class('solr::service') }

      it {
        should contain_service('jetty')
      }
    end
  end

  context 'when on an unknown system' do
    it { expect { should raise_error(Puppet::Error) } }
  end
end
