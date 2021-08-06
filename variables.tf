# You can pass TF_VAR_linktree_endpoint to override the default
variable "linktree_endpoint" {
  default = "https://linktree-website.eidam.workers.dev/links"
}

# You can pass TF_VAR_linktree_title to override the default
variable "linktree_title" {
  default = "Eidam's linktree site"
}

# You can pass TF_VAR_linktree_avatar to override the default
variable "linktree_avatar" {
  default = "https://avatars.githubusercontent.com/u/3592620?s=460&u=6a4caee45a8e507ddc6160c3b4a8a51337fc057c&v=4"
}

# You can pass TF_VAR_linktree_name to override the default
variable "linktree_name" {
  default = "Eidam"
}

# You can pass TF_VAR_linktree_body_class to override the default
variable "linktree_body_class" {
  default = "bg-green-700"
}
