import boto3
import pandas as pd
import io
import os

s3 = boto3.client("s3")

def lambda_handler(event, context):
    bucket_name = os.environ["S3_BUCKET_NAME"]
    anxiety_file_key = "raw/SF_HOMELESS_ANXIETY.csv"
    demographics_file_key = "raw/SF_HOMELESS_DEMOGRAPHICS.csv"
    output_file_key = "processed/merged_data.csv"

    try:
        anxiety_obj = s3.get_object(Bucket=bucket_name, Key=anxiety_file_key)
        demographics_obj = s3.get_object(Bucket=bucket_name, Key=demographics_file_key)

        df_anxiety = pd.read_csv(io.BytesIO(anxiety_obj["Body"].read()))
        df_demographics = pd.read_csv(io.BytesIO(demographics_obj["Body"].read()))

        merged_df = pd.merge(df_anxiety, df_demographics, on="HID")
        output_buffer = io.StringIO()
        merged_df.to_csv(output_buffer, index=False)
        output_buffer.seek(0)

        s3.put_object(Bucket=bucket_name, Key=output_file_key, Body=output_buffer.getvalue())
        return {"statusCode": 200, "body": "Merged dataset uploaded successfully."}

    except Exception as e:
        return {"statusCode": 500, "body": str(e)}
