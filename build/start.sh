#!/bin/bash

service cron start

# Start the Jupyter notebook
jupyter lab --ip=0.0.0.0 --allow-root --no-browser --notebook-dir=/jupyter-folder