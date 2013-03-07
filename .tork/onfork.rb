# Isolate log files; they're required for failed test output. =(
Dir.mkdir( 'log/tork' ) unless Dir.exists?( 'log/tork' )
$tork_log_file.replace File.join( 'log', 'tork', File.basename( $tork_log_file ) )
