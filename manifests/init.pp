class riak {

  $version = '1.1.4-1'
  $destination = '/usr/src'

  case $::operatingsystem {
    'ubuntu', 'debian': {
                          $package_filename = "riak_${::version}_${::architecture}.deb"
                          $riak_provider    = 'dpkg'
                        }
    'centos':           {
                          $package_filename = "riak_${::version}.el6.${::architecture}.rpm"
                          $riak_provider    = 'rpm'
                        }
    default:            { fail("WARNING: Unsupported operating system") }

  }

  $riak_inst_path = "${destination}/${package_filename}"

  file {$destination:
    ensure => present,
  }

  file {$riak_inst_path:
    ensure => present,
    source => "puppet:///modules/riak/${::package_filename}"
  }

  package { 'riak':
    ensure   => installed,
    source   => $riak_inst_path,
    require  => File[$riak_inst_path],
    provider => $riak_provider,
  }

  service { 'riak':
    ensure     => stopped,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['riak'],
  }

}
