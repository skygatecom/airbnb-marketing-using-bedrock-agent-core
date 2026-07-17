# Example usage of the tags module
module "tags" {
  source      = "../tags"
  project     = "my_project"
  environment = "dev"
  owner       = "Platform Team"
}