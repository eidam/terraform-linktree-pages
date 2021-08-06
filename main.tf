# Dynamic links from HTTP endpoint
data "http" "links" {
  url = var.linktree_endpoint

  # Optional request headers
  request_headers = {
    Accept = "application/json"
  }
}

# Generate _redirects file
resource "local_file" "_redirects" {
  content  = <<EOT
%{for link in jsondecode(data.http.links.body)}
${urlencode(lower(link.name))} ${link.url} 302
%{endfor}
EOT
  filename = "${path.module}/output/_redirects"
}

# Generate index.html file
resource "local_file" "index_html" {
  content  = <<EOT
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${var.linktree_title}</title>
    <link
      href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css"
      rel="stylesheet"
    />
    <style>
      #links a {
        background: white;
        border: 1px solid white;
        width: 100%;
        padding: 1rem 2rem;
        margin-bottom: 1rem;
        font-weight: 600;
        border-radius: 6px;
        transition: ease-in-out 0.2s;
      }

      #links a:hover {
        background: none;
        color: white;
      }

      #social a {
        height: 32px;
        width: 32px;
        margin: 0 1rem;
      }

      #social a:hover {
        height: 36px;
        width: 36px;
        transition: ease-in-out 0.2s;
      }
    </style>
  </head>
  <body class="${var.linktree_body_class}">
    <div class="mx-auto max-w-2xl min-h-screen flex flex-col items-center py-8">
      <div class="flex flex-col items-center" id="profile">
        <img class="w-24 h-24 rounded-full shadow-md" id="avatar" src="${var.linktree_avatar}" />
        <h1 class="text-md text-white mt-2 font-semibold" id="name">${var.linktree_name}</h1>
      </div>

      <div
        class="flex flex-col space-between w-full px-8 text-center my-8"
        id="links"
      >
        %{for link in jsondecode(data.http.links.body)}
            <a href="/${urlencode(lower(link.name))}" target="_blank">${link.name}</a>
        %{endfor}
      </div>

    </div>
  </body>
</html>
EOT
  filename = "${path.module}/output/index.html"
}
