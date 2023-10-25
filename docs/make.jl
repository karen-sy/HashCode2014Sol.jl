using HashCode2014Sol
using Documenter

DocMeta.setdocmeta!(HashCode2014Sol, :DocTestSetup, :(using HashCode2014Sol); recursive=true)

makedocs(;
    modules=[HashCode2014Sol],
    authors="Karen Chung <karenchung117@gmail.com> and contributors",
    repo="https://github.com/karen-sy/HashCode2014Sol.jl/blob/{commit}{path}#{line}",
    sitename="HashCode2014Sol.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://karen-sy.github.io/HashCode2014Sol.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/karen-sy/HashCode2014Sol.jl",
    devbranch="master",
)
