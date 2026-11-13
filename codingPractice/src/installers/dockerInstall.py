import subprocess
import logging

#Instantiate module level logger
logger = logging.getLogger(__name__)

#Define a function to install Docker
def install_docker():
    cmd = "sudo apt-get update && sudo apt-get install -y docker.io"
    logger.info(f"Starting Docker installation process... {cmd}")
    
    result = subprocess.run(
        cmd,
        shell=True,
        capture_output=True)
    
    if result.returncode != 0:
        #raise logger.exception(result.stderr)
        raiseexception(result.stderr)
    
    return result.stdout
    

#Define a function to add user to Docker group
def addUser_ToDocker():
    sudoAdd = "usermod -aG docker $USER"
    logger.info(f"Adding $USER to Docker group,{sudoAdd}")
    resultadd = subprocess.run(
        sudoAdd,
        shell=True,
        capture_output=True)

    if resultadd.returncode != 0:
        raiseexception(resultadd.returncode)

    return resultadd

#Raise Exception
def raiseexception(ex):
    raise logger.exception(ex)

#Define Main
def main() -> None:
    is_installed = install_docker()
    if is_installed:
        addUser_ToDocker()


#Create as Module when required
if __name__=="__main__":
    logging.basicConfig(level=logging.debug)

    # Adding Main Execution
    main()
