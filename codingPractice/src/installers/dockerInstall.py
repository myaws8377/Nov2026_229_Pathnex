import subprocess
import logging

#Define a function to install Docker
def install_docker():
    cmd = "sudo apt-get update && sudo apt-get install -y docker.io"
    logging.info(f"Starting Docker installation process... {cmd}")
    
    result = subprocess.run(
        cmd,
        shell=True,
        capture_output=True)
    
    if result.returncode != 0:
        raise logging.exception(result.stderr)
    
    return result.stdout