class riak::node inherits riak {

  $riak_conf_file = '/etc/riak/app.config'
  $erl_conf_file  = '/etc/riak/vm.args'

  file {$riak_conf_file:
    ensure  => file,
    require => Package['riak'],
    content => template('riak/app.config.erb'),
  }

  file {$erl_conf_file:
    ensure  => file,
    require => Package['riak'],
    content => template('riak/vm.args.erb'),
  }

  Service['riak'] {
    subscribe => File[$erl_conf_file, $riak_conf_file],
  }
}
