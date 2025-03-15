# #!/bin/bash

# # define a funtion to handle further commands
function run_model() {

    # # generate project name 
    # PRJ="${1//_/}_ep500_lr4"
    # echo $PRJ

    # # create project
    # poetry run bead -m new_project -p $WS $PRJ
    update_config "model_name" 8
    
}

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




# # replaceStr='c.model_name                   = "Planar_ConvVAE"'
# # targetStr=""
# # models_arr=("Planar_ConvVAE" "RealNVP_ConvVAE" "Glow_ConvVAE" "MAF_ConvVAE" "NSF_ConvVAE")

# # for model in "${models_arr[@]}";
# # do
# #     run_model $model
# # done


# function run_model() {
#     echo "$1_ep500_lr4"
# }
# models_arr=("Planar_ConvVAE" "RealNVP_ConvVAE" "Glow_ConvVAE" "MAF_ConvVAE" "NSF_ConvVAE")

# PRJ="PlanarFlowConvVAE_ep500_lr4"

# for model in "${models_arr[@]}";
# do
#     model="${model//_/}"
#     run_model $model
# done

# Find the Bead directory 
# bead_path=$(find ~/ -type d -path "*/BEAD/bea" -print -quit 2>/dev/null)
bead_path="/c/Users/1hasa/BEAD/bead"

# open bead directory
cd "$bead_path"

# # Define workspace and project name 
WS="test_ws"
PRJ="test"
replaceStr='c.intermittent_model_saving'
targetStr='True'
# sed -i "s/$replaceStr/$targetStr/g" "$bead_path/workspaces/$WS/$PRJ/config/${PRJ}_config.py"

run_model "Happy"
# csv_path="C:\Users\1hasa\BEAD\bead\workspaces\dq\data\csv\bkg_test_sherpa.csv"
# cp $csv_path "$bead_path/workspaces/$WS/data/csv"

# # activate poetry env
# source ~/miniconda3/etc/profile.d/conda.sh
# conda init
# conda activate poetry-env 

# # create Workspace and project
# poetry run bead -m new_project -p $WS $PRJ