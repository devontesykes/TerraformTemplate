{\rtf1\ansi\ansicpg1252\cocoartf1671\cocoasubrtf600
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c0\c1\c1;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 variable "ssh_key" \cf2 \{\CocoaLigature0 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClSpg4eAhg87dwXJ2ur5xO5FvwqCHExKFLjx0zo/4eyxhF3fqjYc3hkj7MYd8bLErO9fXaWUs+T/5aGLf2k+qyhbQXlrO+cp9I6rxlTX7HdYYjD+DG2d718d6E646ZMf1qdAuznluQD2MkyAM1f1JdZxaLBwnEgLn1CUyfcJz05p5aCskSpkp2cl5AXAjejKzNfioUHzzLqev0TvRK/LQ1pyOlCTLMg/X3IfMJgmK/MnQ3aoejeReENJiL4UrvvwX87BJvLJuDon9aRS0eCmMwdbKw4tCLR9WXHnsGFqLeaVCLJcnjlB9c7iqnZtszYxUCspXnsId0tW+mjUMTx9nx Devonte Sykes\cf0 \CocoaLigature1 \}\
variable "resource_group" \{\cf2 \expnd0\expndtw0\kerning0
473f10a3af9a4dada30e4ad47c75d2b5\cf0 \kerning1\expnd0\expndtw0 \}\
\
provider "ibm" \{\
  generation = 1\
  region = "us-south"\
\}\
\
locals \{\
  BASENAME = "schematics" \
  ZONE     = "us-south-1"\
\}\
\
resource ibm_is_vpc "vpc" \{\
  name = "$\{local.BASENAME\}-vpc"\
\}\
\
resource ibm_is_security_group "sg1" \{\
  name = "$\{local.BASENAME\}-sg1"\
  vpc  = "$\{ibm_is_vpc.vpc.id\}"\
\}\
\
# allow all incoming network traffic on port 22\
resource "ibm_is_security_group_rule" "ingress_ssh_all" \{\
  group     = "$\{ibm_is_security_group.sg1.id\}"\
  direction = "inbound"\
  remote    = "0.0.0.0/0"                       \
\
  tcp = \{\
    port_min = 22\
    port_max = 22\
  \}\
\}\
\
resource ibm_is_subnet "subnet1" \{\
  name = "$\{local.BASENAME\}-subnet1"\
  vpc  = "$\{ibm_is_vpc.vpc.id\}"\
  zone = "$\{local.ZONE\}"\
  total_ipv4_address_count = 256\
\}\
\
data ibm_is_image "ubuntu" \{\
  name = "ubuntu-18.04-amd64"\
\}\
\
data ibm_is_ssh_key "ssh_key_id" \{\
  name = "$\{var.ssh_key\}"\
\}\
\
data ibm_resource_group "group" \{\
  name = "$\{var.resource_group\}"\
\}\
\
resource ibm_is_instance "vsi1" \{\
  name    = "$\{local.BASENAME\}-vsi1"\
  resource_group = "$\{data.ibm_resource_group.group.id\}"\
  vpc     = "$\{ibm_is_vpc.vpc.id\}"\
  zone    = "$\{local.ZONE\}"\
  keys    = ["$\{data.ibm_is_ssh_key.ssh_key_id.id\}"]\
  image   = "$\{data.ibm_is_image.ubuntu.id\}"\
  profile = "cc1-2x4"\
\
  primary_network_interface = \{\
    subnet          = "$\{ibm_is_subnet.subnet1.id\}"\
    security_groups = ["$\{ibm_is_security_group.sg1.id\}"]\
  \}\
\}\
\
resource ibm_is_floating_ip "fip1" \{\
  name   = "$\{local.BASENAME\}-fip1"\
  target = "$\{ibm_is_instance.vsi1.primary_network_interface.0.id\}"\
\}\
\
output sshcommand \{\
  value = "ssh root@$\{ibm_is_floating_ip.fip1.address\}"\
\}\
\
}