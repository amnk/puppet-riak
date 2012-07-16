class riak::node  {

  include riak

  $riak_conf_file = '/etc/riak/app.config'
  $erl_conf_file  = '/etc/riak/vm.args'

  file {$riak_conf_file:
    ensure  => file,
    require => Package['riak'],
    source  => template('riak/app.config.erb'),
    notify  => Service['riak'],
  }

  file {$erl_conf_file:
    ensure  => file,
    require => Package['riak'],
    source  => template('riak/vm.args.erb'),
    notify  => Service['riak'],
  }
}
