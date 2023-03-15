from http import client
import boto3

LOCAL_FILENAME = "training/github_shalonningram/Load_Balancing_Mini_Lab/Red.zip"

s3_client = boto3.client("s3")
s3_client.upload_file(Filename = LOCAL_FILENAME, 
                   Bucket = "site-files-shalonn",
                   Key = "Red.zip")