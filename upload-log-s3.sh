if [ -z $1 ]; then
echo "Error: no filename passed in... Exiting..."
exit;
fi

echo 'Starting S3 Log Upload...'

# Time stamp and instance id for bucket sub-folders
timestamp=$(date +"%Y%m%d-%H%M")

# Upload log file to Amazon S3 bucket
/usr/bin/s3cmd --access_key=$ACCESS_KEY --secret_key=$SECRET_KEY --host=$S3_HOST sync $1 s3://$BUCKET_NAME/$timestamp/