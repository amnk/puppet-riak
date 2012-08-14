class riak::vars {
  $core_state_dir = '/var/lib/riak/ring'
  $core_http_ip = '0.0.0.0'
  $core_http_port = '8097'
  $core_https_ip = '0.0.0.0'
  $core_https_port = '8098'
  $core_handoff_port = '8099'

  $kv_pb_ip = '0.0.0.0'
  $kv_pb_port = '8087'
  $bitcask_data_root = '/var/lib/riak/bitcask'
  $eleveldb_data_root = '/var/lib/riak/leveldb'

  $control_enabled = 'true'
  $search_enabled = 'true'

  $riak_conf_file = "/etc/riak/app.config"
  $erl_conf_file = "/etc/riak/vm.args"
  $key_file = "/etc/riak/key.pem"
  $cert_file = "/etc/riak/cert.pem"
}
