from argparse import ArgumentParser
from os.path import exists
from subprocess import run


def __entry__() -> None:
    parser = ArgumentParser(prog="Erbium CLI", description="Erbium Command Line Interface",
                            epilog="GitHub: https://github.com/ProjectNeura/Erbium")
    parser.add_argument("action", choices=("pack", "run"))
    parser.add_argument("-v", "--version", default="latest")
    parser.add_argument("-i", "--input", default="P:/SharedDatasets")
    parser.add_argument("-o", "--output", default="P:/SharedWeights/Erbium")
    parser.add_argument("target", default=None)
    args = parser.parse_args()
    match args.action:
        case "pack":
            if not exists(f"{args.target}/Dockerfile"):
                raise FileNotFoundError(f"Dockerfile not found in {args.target}")
            target = args.target if args.target else "docker"
            run(("docker", "build", "-t", f"erbium:{args.version}", target))
        case "run":
            run(("docker", "run", "--ipc=host", "--rm", "-v", f"{args.input}:/workspace/input:ro", "-v",
                 f"{args.output}:/workspace/output", args.target))
