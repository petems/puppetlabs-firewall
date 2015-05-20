require 'spec_helper_acceptance'

describe 'firewall on RHEL7', :unless => !is_rhel7( fact('osfamily'), fact('operatingsystem'), fact('operatingsystemrelease') ) do
  it 'should run successfully' do
    pp = "
    class { 'firewall':
    }
    ->
    resources { 'firewall':
      purge   => true,
    }
    ->
    firewall { '555 - test':
      proto  => tcp,
      port   => '555',
      action => accept,
    }
    "

    # Run it twice and test for idempotency
    apply_manifest(pp, :catch_failures => true, :debug => true)
    apply_manifest(pp, :catch_failures => true, :debug => true)
  end

end