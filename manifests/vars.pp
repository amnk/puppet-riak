class riak::vars {

  $version = '1.1.4-1'

  $destination = '/usr/src'

  case $::operatingsystem {
    'ubuntu', 'debian': {
           $package_filename = "riak_${version}_${architecture}.deb"
           $riak_provider    = 'dpkg'
           $riak_conf_file = '/etc/riak/app.config'
           $erl_conf_file  = '/etc/riak/vm.args'
                        }
    'centos':           {
           $package_filename = "riak_${version}.el6.${architecture}.rpm"
           $riak_provider    = 'rpm'
           $riak_conf_file = '/etc/riak/app.config'
           $erl_conf_file  = '/etc/riak/vm.args'
                        }
    default:            { fail('WARNING: Unsupported operating system') }

  }

  $riak_inst_path = "${destination}/${package_filename}"

  $core_state_dir = '/var/lib/riak/ring'
  $core_http_ip = '127.0.0.1'
  $core_http_port = '8097'
  $core_https_ip = '127.0.0.1'
  $core_https_port = '8098'
  $core_handoff_port = '8099'

  $kv_pb_ip = '127.0.0.1'
  $kv_pb_port = '8087'
  $bitcask_data_root = '/var/lib/riak/bitcask'
  $eleveldb_data_root = '/var/lib/riak/leveldb'

  $control_enabled = 'false'

}
