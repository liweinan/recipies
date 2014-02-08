node 'master', 'slave' {
	file { '/tmp/hello': content => "Hello world\n" }
}