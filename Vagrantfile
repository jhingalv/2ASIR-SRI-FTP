Vagrant.configure("2") do |config|
  
  # Define the anonymous FTP VM
  config.vm.define "anon-ftp" do |ftp|
    ftp.vm.box = "debian/bookworm64"
    ftp.vm.hostname = "anon-ftp"
    ftp.vm.network "private_network", ip: "192.168.56.10"

    ftp.vm.provider "virtualbox" do |vb|
      vb.name = "anon-ftp"
    end

    ftp.vm.provision "ansible" do |ansible|
      ansible.playbook = "./ANON-FTP/ansible/playbook.yml"
      ansible.inventory_path = "./inventory.ini"
    end
  end

end
