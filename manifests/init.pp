class riak inherits riak::vars {

  package { 'riak':
    ensure   => installed,
  }

  service { 'riak':
    hasrestart => true,
    hasstatus  => true,
    require    => Package['riak'],
  }

}
