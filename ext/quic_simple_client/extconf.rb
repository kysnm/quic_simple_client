require "mkmf"

RbConfig::MAKEFILE_CONFIG['CC'] = ENV['CC'] if ENV['CC']

$CFLAGS << " #{ENV["CFLAGS"]}"
$CFLAGS << " -g"
$CFLAGS << " -O3" unless $CFLAGS[/-O\d/]
$CFLAGS << " -Wall -Wno-comment"

CWD = File.expand_path(File.dirname(__FILE__))
QUIC_DIR = File.join(CWD, 'libquic')
QUIC_BUILD_DIR = File.join(QUIC_DIR, 'build')

$LDFLAGS << " -L#{QUIC_BUILD_DIR}"

Dir.mkdir(QUIC_BUILD_DIR) if !Dir.exists?(QUIC_BUILD_DIR)

Dir.chdir QUIC_BUILD_DIR do
  system 'cmake ..'
  system 'make -j 4'
end

LIBDIR     = RbConfig::CONFIG['libdir']

$LOCAL_LIBS << '-lquic'

create_makefile("quic_simple_client/quic_simple_client")
