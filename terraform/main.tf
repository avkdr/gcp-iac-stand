// Configure the Yandex.Cloud provider
provider "yandex" {
  token                    = "AgAAAAA6Z18OAATuwaO9An87DESYlst1GNjFz-I"
  cloud_id                 = "b1g25cdqdulerbk46qn1"
  folder_id                = "b1gn51be88cofsgj0ncu"
  zone                     = "ru-central1-a"
}

// Create a new instance of Nexus
resource "yandex_compute_instance" "nexus" {
  name                     = "nexus"
  folder_id                = "b1gn51be88cofsgj0ncu"
  platform_id              = "standard-v1"
  zone                     = "ru-central1-a"

  resources                {
  cores                    = 1
  memory                   = 2
  }

network_interface {
  subnet_id                = "e9bf75an81939s7c4ra0"
  nat                      = true
}

metadata                   = {
  ssh-keys                 = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
}

boot_disk {
  initialize_params {
  image_id                 = "fd830p4prsodpus5ssmr"
    }
  }

}

// Create a new instance of Jenkins
resource "yandex_compute_instance" "jenkins" {
name                     = "jenkins"
folder_id                = "b1gn51be88cofsgj0ncu"
platform_id              = "standard-v1"
zone                     = "ru-central1-a"

resources                {
cores                    = 1
memory                   = 2
}

metadata                 = {
ssh-keys                 = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
}

network_interface {
subnet_id                = "e9bf75an81939s7c4ra0"
nat                      = true
}

boot_disk {
initialize_params {
image_id                 = "fd8iqsp7avtrc09qbq76"
    }
  }
}
