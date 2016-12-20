#include "quic_simple_client.h"

VALUE rb_mQuicSimpleClient;

void
Init_quic_simple_client(void)
{
  rb_mQuicSimpleClient = rb_define_module("QuicSimpleClient");
}
