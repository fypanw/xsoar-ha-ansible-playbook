# Ansible Playbooks for Deploying XSOAR in HA backed by ElasticSearch

### Pre-requisites
- At least 1 freshly installed RHEL/Rocky/AlmaLinux (tested) or Ubuntu / Debian (not tested yet) server for the NFS group. This will be used for exporting the shared /var/lib/demisto directory.
- At least 2 freshly installed RHEL/Rocky/AlmaLinux (tested) or Ubuntu / Debian (not tested yet) server for the XSOAR app servers group.

### Usage
- Set up the correct parameters in inventory.yaml
- Use rhel-prep.yaml to prepare the fresh hosts with necessary packages. Modify the list of packages as needed.
- Use nfs-server-playbook.yaml to setup the NFS server (by default /var/lib/demisto is exported)
- Use xsoar-server-playbook.yaml to deploy XSOAR

### Usage for upgrades
- In case of upgrades, use the 'xsoar_upgrade_installer' setting in inventory. The installer parameter will be ignored.

#### Credits and License
This work is inspired from Hiep Nguyen's work @ https://github.com/hiep4hiep. Special thanks to him for creating that example.

This repository and all associated files are covered by the [Palo Alto Networks Script License](https://www.paloaltonetworks.com/content/dam/pan/en_US/assets/pdf/legal/script-software-license-1-0.pdf). Please refer to LICENSE.md

© 2022 Palo Alto Networks, Inc.  All rights reserved.