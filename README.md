# Ansible Playbooks for Deploying XSOAR in HA backed by ElasticSearch

### Pre-requisites
- At least 1 freshly installed RHEL/Rocky/AlmaLinux (tested) or Ubuntu / Debian (not tested yet) server for the NFS group. This will be used for exporting the shared /var/lib/demisto directory.
- At least 2 freshly installed RHEL/Rocky/AlmaLinux (tested) or Ubuntu / Debian (not tested yet) server for the XSOAR app servers group.

### Usage
- Set up the correct parameters in inventory.yaml