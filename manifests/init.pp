class riak (
  $node_name = "${hostname}@${ipaddress}",
  $join_cluster = 'false',
  $join_cluster_node = 'UNSET',
  $join_cookie = 'riak'
  $status = 'running'
) iinherits riak::vars {

  file {$riak::vars::riak_conf_file:
    ensure  => file,
    require => Package['riak'],
    content => template('riak/app.config.erb'),
  }

  file {$riak::vars::erl_conf_file:
    ensure  => file,
    require => Package['riak'],
    content => template('riak/vm.args.erb'),
  }

  file {$riak::vars::key_file:
    ensure  => file,
    require => Package['riak'],
    source => "puppet:///modules/riak/key.pem"
  }
  file {$riak::vars::cert_file:
    ensure  => file,
    require => Package['riak'],
    source => "puppet:///modules/riak/cert.pem"
  }

  if $join_cluster == 'true' {
    exec {'join_cluster':
      path    => '/usr/bin/:/usr/sbin/:/usr/local/bin:',
      command => "riak-admin cluster join ${join_cluster_node} && riak-admin cluster plan && riak-admin cluster commit && touch /var/run/riak/clustered",
      creates => "/var/run/riak/clustered",
      require => Service["riak"]
    }
  }
}
  package { 'riak':
    ensure   => installed,
  }

  service { 'riak':
    hasrestart => true,
    hasstatus  => true,
    require    => Package['riak'],
	subscribe  => File[$riak::vars::erl_conf_file, $riak::vars::riak_conf_file],
	ensure     => "${status}"
  }

}
