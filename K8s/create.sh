#!/usr/bin/env bash

# Setup Secrets
echo "---Enter your Actions Secrets, empty if it doesn't exists---"
secrets=("cardid" "password" "serverchansckey" "openid" "pptoken" "pptopic")
command="kubectl create secret generic lzu-covid-report-secret"
for secret in ${secrets[*]}
do
    read -p "-"$secret": " content
    command=$command" --from-literal="$secret"="$content
done
$command

# Create cronJob
kubectl create -f LZU-Auto-COVID-Health-Report.yml

# Check Details
kubectl get secret/lzu-covid-report-secret configmap/lzu-covid-report-delays cronjob/lzu-auto-covid-health-report
