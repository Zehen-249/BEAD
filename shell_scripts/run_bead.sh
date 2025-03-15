#!/bin/bash

# config file updater function
update_config() {
    local type="$1"
    local value="$2"

    awk -v replaceStr="$type" -v targetStr="$value" -F'=' '
    {
        if ($1 ~ replaceStr) {
            print $1 "= " targetStr
        } else {
            print $0
        }
    }' "$bead_path/workspaces/$WS/$PRJ/config/${PRJ}_config.py" > temp && \
    mv temp "$bead_path/workspaces/$WS/$PRJ/config/${PRJ}_config.py"
}


# function to follow the steps for different models, create project, update config, train, detect and plot
function run_model() {

    # generate project name 
    PRJ="${1//_/}_ep500_lr4"

    # create project
    poetry run bead -m new_project -p $WS $PRJ

    update_config "model_name" "${1}" $WS $PRJ
    update_config "intermittent_model_saving" True
    
    # run train detect and plot
    poetry run bead -m chain -p $WS $PRJ -o train_detect_plot
}

# Find the Bead directory 
bead_path=$(find ~/ -type d -path "*/BEAD/bead" -print -quit 2>/dev/null)
# bead_path="/c/Users/1hasa/BEAD/bead"

# open bead directory
cd "$bead_path"



# # activate poetry env
# source ~/miniconda3/etc/profile.d/conda.sh
# conda init
# conda activate poetry-env  

# Define workspace and project name 
WS="monotop_200_A"
PRJ="PlanarConvVAE"

# create Workspace and project
poetry run bead -m new_project -p $WS $PRJ


# firstly add the CSV file at the required location 
# csv path is assumed to be this
csv_path="C:\Users\1hasa\BEAD\bead\workspaces\dq\data\csv\bkg_test_sherpa.csv"
cp $csv_path "$bead_path/workspaces/$WS/data/csv"

# Convert CSV file and prepare inputs
poetry run bead -m chain -p $WS $PRJ -o convertcsv_prepareinputs

# NormFlow + ConvVAE model combinations
models_arr=("Planar_ConvVAE" "RealNVP_ConvVAE" "Glow_ConvVAE" "MAF_ConvVAE" "NSF_ConvVAE")

# iteraate through each model
for model in "${models_arr[@]}";
do
    run_model $model 
done
