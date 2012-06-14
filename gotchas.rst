Configuration Gotchas
-------------------------------------------------------------------------------

1) Make sure compute nodes have '--auth_strategy=keystone' in
   '/etc/nova/nova.conf'.

   Avoid Error:  ImageNotAuthorized: Not authorized for image

That error would crop up during the scheduling phase.

2) Make sure that there is at least 1 network configured for each project (?)

    Avoid Error: RemoteError: Remote error: NoMoreNetworks

That error would crop up during the networking phase.

3) Make sure compute nodes are configured with correct network interface with
   '--vlan_interface=eth0' in '/etc/nova/nova.conf'.

    Avpod Error: Stderr: 'Cannot find device "eth1"\n'

That error occurs during the spawning phase.

4) Make sure host system/compute node is 64-bit otherwise you might hit qemu
   memory simulated error at > 2047 MB requested RAM.
