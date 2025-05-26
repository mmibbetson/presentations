# List all recipes by default.
_default:
    @just --list

# Present slides.
present filter="":
    presenterm -p {{filter}} -t terminal-dark 
