require 'spec_helper'
describe 'git', :type => :class do
  context "on a later (post 12) Debian OS" do
    let :facts do
      {
        :osfamily   => 'Debian',
        :operatingsystemrelease => '12',
      }
    end
    describe "with no parameters" do
      it { should include_class('git::params') }
      it { should contain_package('git').with(
        'ensure'  => 'installed',
        'name'    => 'git'
      ) }
      it { should contain_package('git-svn').with(
        'ensure'  => 'installed',
        'name'    => 'git-svn'
      ) }
      it { should contain_package('git-gui').with(
        'ensure'  => 'absent',
        'name'    => 'git-gui'
      ) }
    end
    describe "with ensure => absent" do
      let :params do
        {
          :ensure => 'absent',
        }
      end
      it { should include_class('git::params') }
      it { should contain_package('git').with(
        'ensure'  => 'absent'
      ) }
      it { should contain_package('git-svn').with(
        'ensure'  => 'absent'
      ) }
      it { should contain_package('git-gui').with(
        'ensure'  => 'absent'
      ) }
    end
    describe "with svn => absent" do
      let :params do
        {
          :svn => 'absent',
        }
      end
      it { should include_class('git::params') }
      it { should contain_package('git-svn').with(
        'ensure'  => 'absent'
      ) }
    end
    describe "with gui => installed" do
      let :params do
        {
          :gui => 'installed',
        }
      end
      it { should include_class('git::params') }
      it { should contain_package('git-gui').with(
        'ensure'  => 'installed'
      ) }
    end
  end

  context "on an early (pre 12) Debian OS" do
    let :facts do
      {
        :osfamily               => 'Debian',
        :operatingsystemrelease => '11',
      }
    end
    describe "with no parameters" do
      it { should include_class('git::params') }
      it { should contain_package('git').with(
        'ensure'  => 'installed',
        'name'    => 'git-core'
      ) }
    end
  end

  context "on a RedHat OS" do
    let :facts do
      {
        :osfamily   => 'RedHat',
      }
    end
    describe "with no parameters" do
      it { should include_class('git::params') }
      it { should contain_package('git').with(
        'ensure'  => 'installed',
        'name'    => 'git'
      ) }
    end
  end

  context "on a ArchLinux OS" do
    let :facts do
      {
        :osfamily   => 'ArchLinux',
      }
    end
    describe "with no parameters" do
      it { should include_class('git::params') }
      it { should contain_package('git').with(
        'ensure'  => 'installed',
        'name'    => 'git'
      ) }
    end
  end

  context "on an Unknown OS" do
    let :facts do
      {
        :osfamily   => 'Unknown',
      }
    end
    it do
      expect {
        should include_class('puppet::params')
      }.to raise_error(Puppet::Error, /The NeSI Git Puppet module does not support Unknown family of operating systems/)
    end
  end

end
