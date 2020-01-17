provider "google"       {
  credentials              = "${file("../auth/key.json")}"
  project                  = "helical-ranger-260511"
  zone                     = "europe-west1-b"
}

resource "google_compute_instance" "apache" {
  name                     = "gcp-centos7-apache"
  machine_type             = "f1-micro"
  network_interface     {
    network                = "default"
    access_config       {
    }
  }
  boot_disk {
  initialize_params {
             image         = "gcp-centos7-apache"
    }
}
}

resource "google_compute_address" "static" {
  name                     = "static-ip-address"
  address_type             = "EXTERNAL"
}

resource "google_compute_instance" "jenkins-nexus" {
  name                     = "jenkins-nexus-centos7-apache"
  machine_type             = "n1-standard-1"
  network_interface     {
    network                = "default"
    access_config       {
      nat_ip               = "${google_compute_address.static.address}"
    }
  }
  boot_disk {
  initialize_params {
             image         = "jenkins-nexus-centos7-apache"
    }
}
}
