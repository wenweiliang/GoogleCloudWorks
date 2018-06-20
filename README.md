# GoogleCloudWorks

Various jobs have been run on google cloud.

### PancanFusionValidation

Scripts to run WGS validation pipeline for Pancan Fusion Project.

`generate_yaml.*.sh`: Create site-specific yaml files for each gene fusion.

`*.coordinate*.txt`: Coordinate for fusions. Input of `generate_yaml.*.sh`.

`command.*.sh`: Commend for launching Google Pipeline API.

`samtools_fusion.qc.yaml`: Template yaml for jobs.

### MSIsensorWGS

`TCGA.WGS.msisensor*.txt`: Result of msisensor run on TCGA WGS BAMs.

`generate_command.msisensor.sh`: Launch jobs by using Google Pipeline API.

`msisensor.yaml`: yaml file for running msisensor

`worklog`: Get msisensor result from google cloud storage.
