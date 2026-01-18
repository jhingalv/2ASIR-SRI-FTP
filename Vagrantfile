Vagrant.configure("2") do |config|

  # DNS Server VM
  config.vm.define "dns_server" do |dns|
    dns.vm.box = "debian/bookworm64"
    dns.vm.hostname = "dns.sistema.sol"
    dns.vm.network "private_network", ip: "192.168.56.5"

    dns.vm.provider "virtualbox" do |vb|
      vb.name = "dns_server"
    end

    dns.vm.provision "ansible" do |ansible|
      ansible.playbook = "./DNS/ansible/playbook.yml"
      ansible.inventory_path = "./inventory.ini"
    end
  end

  # Anonymous FTP VM
  config.vm.define "anon_ftp" do |ftp|
    ftp.vm.box = "debian/bookworm64"
    ftp.vm.hostname = "mirror.sistema.sol"
    ftp.vm.network "private_network", ip: "192.168.56.10"

    ftp.vm.provider "virtualbox" do |vb|
      vb.name = "anon_ftp"
    end

    ftp.vm.provision "ansible" do |ansible|
      ansible.playbook = "./ANON-FTP/ansible/playbook.yml"
      ansible.inventory_path = "./inventory.ini"
    end
  end

end
