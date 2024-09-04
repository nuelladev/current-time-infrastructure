provider "google" {
  credentials = file("C:/Users/admin/Downloads/my-current-time-5cde0474ce73.json")
  project     = "my-current-time"
  region      = var.region
}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.gke_cluster.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate)
}

resource "google_compute_network" "vpc_network" {
  name                    = "my-vpc-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "new_subnetwork" {
  name          = "my-new-subnetwork"
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region

  secondary_ip_range {
    range_name    = "new-pod-range"
    ip_cidr_range = "10.3.0.0/16"
  }

  secondary_ip_range {
    range_name    = "new-service-range"
    ip_cidr_range = "10.4.0.0/16"
  }
}

resource "google_container_cluster" "gke_cluster" {
  name     = "my-gke-cluster"
  location = var.region

  deletion_protection = false
  initial_node_count  = 1

  node_config {
    machine_type = "e2-small"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    disk_size_gb = 30
  }

  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {
    cluster_secondary_range_name  = "new-pod-range"
    services_secondary_range_name = "new-service-range"
  }

  network    = google_compute_network.vpc_network.id
  subnetwork = google_compute_subnetwork.new_subnetwork.id
}

resource "google_compute_router" "nat_router" {
  name    = "my-nat-router"
  network = google_compute_network.vpc_network.id
  region  = var.region
}

resource "google_compute_router_nat" "nat_gateway" {
  name                   = "my-nat-gateway"
  router                 = google_compute_router.nat_router.name
  region                 = var.region
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_global_address" "default" {
  name = "my-global-address"
}

data "google_client_config" "default" {}

resource "kubernetes_deployment" "api_deployment" {
  metadata {
    name      = "api-deployment"
    namespace = "default"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "api"
      }
    }
    template {
      metadata {
        labels = {
          app = "api"
        }
      }
      spec {
        container {
          name  = "api-container"
          image = "gcr.io/my-current-time/current-time-api:latest"
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "api_service" {
  metadata {
    name      = "api-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = "api"
    }
    port {
      port        = 80
      target_port = 8080
    }
    type = "LoadBalancer"
  }
}

resource "google_project_iam_member" "iam_member_oemmanuella" {
  project = "my-current-time"
  role    = "roles/viewer"
  member  = "user:oemmanuella559@gmail.com"
}

resource "google_project_iam_member" "iam_member_emmanuellaassistant" {
  project = "my-current-time"
  role    = "roles/viewer"
  member  = "user:emmanuellaokafor42@gmail.com"
}
