class riak {

  $version = '1.1.4-1'
  $destination = '/usr/src'
  $package_filename = $::operatingsystem ? {
    /(Debian|Ubuntu)/ => "riak_${::version}_${::architecture}.deb",
    redhat            => "riak_${::version}.el6.${::architecture}.rpm",
  }

  $riak_provider = $::operatingsystem ? {
    /(Debian|Ubuntu)/ => 'dpkg',
    redhat            => 'rpm',
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
