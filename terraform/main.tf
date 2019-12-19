provider "google"       {
  credentials              = "${file("../auth/key.json")}"
  project                  = "helical-ranger-260511"
  zone                   = "europe-west1-b"
}
resource "google_compute_instance" "apache" {
  name                  = "gcp-centos7-apache"
  machine_type          = "f1-micro"
  network_interface     {
    network             = "default"
    access_config       {
    }
  }
  boot_disk {
  initialize_params {
             image      = "gcp-centos7-apache"
    }
}
}
resource "google_compute_instance" "jenkins" {
  name                  = "jenkins-centos7-apache"
  machine_type          = "f1-micro"
  network_interface     {
    network             = "default"
    access_config       {
    }
  }
  boot_disk {
  initialize_params {
             image      = "jenkins-centos7-apache"
    }
}
}
resource "google_compute_instance" "nexus" {
  name                  = "nexus-centos7-apache"
  machine_type          = "f1-micro"
  network_interface     {
    network             = "default"
    access_config       {
    }
  }
  boot_disk {
  initialize_params {
            image      = "nexus-centos7-apache"
  }
}
}
