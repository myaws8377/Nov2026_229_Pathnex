from ast import Not
import cmd
import os
import logging
from pickle import TRUE
import subprocess

from concurrent.interpreters import is_shareable

#Instantiate module level logger
logger = logging.getLogger(__name__)

def get_AWSEndPointPub_IP():
	
	#Get the EC2 Public IP Address
	endpointip = "curl -s https://checkip.amazonaws.com"
	logger.info(f"Getting Public IP from AWS Endpoint {endpointip}")
	AWSEndPointResult = subprocess.run(
		endpointip,
		shell=True,
		capture_output=True
	)

	if AWSEndPointResult.returncode != 0:
		raiseexception(AWSEndPointResult.stderr)

	return AWSEndPointResult

def get_ifconfig_pubIP():
	ifconfig_PubIP = "curl -s ifconfig.me"
	logger.info(f"Getting public IP from curl -s ifconfig.me {ifconfig_PubIP}")
	ifconfigResult = subprocess.run(
		ifconfig_PubIP,
		shell=True,
		capture_output=True
	)

	if ifconfigResult.returncode != 0:
		raiseexception(ifconfigResult.stderr)

	return ifconfigResult

def get_digPubIP():
	dig_PubIP = "dig +short myip.opendns.com @resolver1.opendns.com"
	logger.info(f"Getting public IP from dig command {dig_PubIP}")
	dig_cmd_result = subprocess.run (
		dig_PubIP,
		shell=True,
		capture_output=True
	)

	if dig_cmd_result.returncode != 0:
		raiseexception(dig_cmd_result.stderr)

	return dig_cmd_result

#Alternative Endpoints. Run curl -s ifconfig.me or dig +short myip.opendns.com 
#@resolver1.opendns.com if the AWS endpoint is unreachable.

#Raise Exception
def raiseexception(ex):
	raise logger.exception(ex)

#Main Function
def main() -> None:
	is_AWSEndPointPub_IP_Success = get_AWSEndPointPub_IP()

	if not is_AWSEndPointPub_IP_Success:
		is_pubIP_Success = get_ifconfig_pubIP()

	
	if not is_pubIP_Success:
		is_digpubIP_Success = get_digPubIP()

#Create module when required
if __name__ == "__main__":
	logging.basicConfig(level=logging.debug)

	#Adding main execution
	main()