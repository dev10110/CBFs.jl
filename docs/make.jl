using Documenter
using CBFs

DocMeta.setdocmeta!(CBFs, :DocTestSetup, :(using CBFs); recursive=true)


makedocs(;
    modules = [CBFs],
    authors = "Devansh Agrawal",
    repo="https://github.com/dev10110/CBFs.jl/blob/{commit}{path}#{line}",
    sitename = "CBFs.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://dev10110.github.io/CBFs.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Reference" => "reference.md"
    ],
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(;
    repo="github.com/dev10110/CBFs.jl",
    devbranch="main",
)
