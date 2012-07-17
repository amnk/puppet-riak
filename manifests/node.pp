class riak::node(
  $node_name = "inode1@${ipaddress}",
  $join_cluster = 'false',
  $join_cluster_node = 'UNSET',
) inherits riak {

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

  Service['riak'] {
    subscribe => File[$riak::vars::erl_conf_file, $riak::vars::riak_conf_file],
  }

  if $join_cluster == 'true' {
    exec {'join_cluster':
      path    => '/usr/bin/:/usr/sbin/:/usr/local/bin:',
      command => "riak-admin join ${join_cluster_node}",
    }
  }
}
