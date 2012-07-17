class riak inherits riak::vars {

  file {$riak::vars::destination:
    ensure => present,
  }

  file {$riak::vars::riak_inst_path:
    ensure => present,
    source => "puppet:///modules/riak/${riak::vars::package_filename}"
  }

  package { 'riak':
    ensure   => installed,
    source   => $riak::vars::riak_inst_path,
    require  => File[$riak::vars::riak_inst_path],
    provider => $riak::vars::riak_provider,
  }

  service { 'riak':
    ensure     => stopped,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['riak'],
  }

}
