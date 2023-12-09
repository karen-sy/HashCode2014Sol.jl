using HashCode2014Sol
using Documenter

DocMeta.setdocmeta!(HashCode2014Sol, :DocTestSetup, :(using HashCode2014Sol); recursive=true)

makedocs(;
    modules=[HashCode2014Sol],
    authors="Karen Chung <karenchung117@gmail.com> and contributors",
    repo=Documenter.Remotes.URL("https://github.com/user/project/-/tree/{commit}{path}#{line}","https://github.com/karen-sy/HashCode2014Sol.jl"),
    sitename="HashCode2014Sol.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://karen-sy.github.io/HashCode2014Sol.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "home.md",
        "Quickstart" => "tutorial.md",
        "Functions" => "index.md",
        "Algorithm description" => "algo.md"
    ],
)

deploydocs(;
    repo="github.com/karen-sy/HashCode2014Sol.jl",
    devbranch="master",
)
