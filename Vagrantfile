# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'
VAGRANT_BOX = 'bento/ubuntu-18.04'
vm_specs = [
  { name: 'lb',   ip: '192.168.1.10', playbook: 'main.yml', app: 'lb' },
  { name: 'app1', ip: '192.168.1.11', playbook: 'main.yml', app: 'nginx' },
  { name: 'app2', ip: '192.168.1.12', playbook: 'main.yml', app: 'nginx' },
  { name: 'app3', ip: '192.168.1.13', playbook: 'main.yml', app: 'nginx' },
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  ##############################################################################
  # 共通
  ##############################################################################
  config.vm.box = VAGRANT_BOX
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.synced_folder './ansible', '/home/vagrant/ansible',
    create: true, type: :rsync, owner: :vagrant, group: :vagrant,
    rsync__exclude: ['*.swp']
  config.vm.provider :virtualbox do |vb|
    vb.gui    = false
    vb.memory = 1024 * 1
    vb.cpus   = 1
  end
  config.vm.provision :hosts, :sync_hosts => true

  ##############################################################################
  # 各VM
  ##############################################################################
  vm_specs.each do |spec|
    config.vm.define spec[:name] do |machine|
      machine.vm.hostname = spec[:name]
      machine.vm.network 'private_network', ip: spec[:ip]
      machine.vm.provider :virtualbox do |vb|
        vb.name = spec[:name]
      end
      # App
      machine.vm.synced_folder './'+spec[:app], '/home/vagrant/'+spec[:app],
        create: true, type: :rsync, owner: :vagrant, group: :vagrant,
        rsync__exclude: ['*.swp']
      machine.vm.provision 'ansible_local' do |ansible|
        ansible.provisioning_path = '/home/vagrant/'
        ansible.playbook          = '/home/vagrant/ansible/' + spec[:playbook]
        ansible.inventory_path    = '/home/vagrant/ansible/inventories/hosts'
        #ansible.install_mode      = 'pip'
        #ansible.version           = '2.9.7'
        ansible.version           = 'latest'
        ansible.verbose           = false
        ansible.install           = true
        ansible.limit             = spec[:name]
      end
    end
  end
end
