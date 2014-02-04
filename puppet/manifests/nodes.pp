node 'master' {
	file { '/tmp/hello': content => "Hello world\n" }
}