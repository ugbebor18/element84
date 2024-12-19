import boto3
import pandas as pd
import io
import os

# Initialize S3 client
s3 = boto3.client("s3")

def lambda_handler(event, context):
    """
    Lambda function to merge datasets from S3.
    Downloads two datasets from S3, merges them on 'HID', and uploads the merged dataset back to S3.
    """

    # Get the S3 bucket name from environment variables
    bucket_name = os.environ["S3_BUCKET_NAME"]

    # File paths in S3
    anxiety_file_key = "raw/SF_HOMELESS_ANXIETY.csv"
    demographics_file_key = "raw/SF_HOMELESS_DEMOGRAPHICS.csv"
    output_file_key = "processed/merged_data.csv"

    try:
        # Fetch files from S3
        print(f"Fetching {anxiety_file_key} and {demographics_file_key} from bucket {bucket_name}")
        anxiety_obj = s3.get_object(Bucket=bucket_name, Key=anxiety_file_key)
        demographics_obj = s3.get_object(Bucket=bucket_name, Key=demographics_file_key)

        # Read the files into pandas DataFrames
        df_anxiety = pd.read_csv(io.BytesIO(anxiety_obj["Body"].read()))
        df_demographics = pd.read_csv(io.BytesIO(demographics_obj["Body"].read()))

        # Merge the datasets on 'HID'
        print("Merging datasets on 'HID'")
        merged_df = pd.merge(df_anxiety, df_demographics, on="HID")

        # Save the merged dataset to an in-memory buffer
        output_buffer = io.StringIO()
        merged_df.to_csv(output_buffer, index=False)
        output_buffer.seek(0)

        # Upload the merged dataset back to S3
        print(f"Uploading merged dataset to {output_file_key} in bucket {bucket_name}")
        s3.put_object(Bucket=bucket_name, Key=output_file_key, Body=output_buffer.getvalue())

        print("Merged dataset successfully uploaded to S3")
        return {
            "statusCode": 200,
            "body": "Merged dataset successfully processed and uploaded to S3."
        }

    except Exception as e:
        print(f"Error processing files: {str(e)}")
        return {
            "statusCode": 500,
            "body": f"Error processing files: {str(e)}"
        }
