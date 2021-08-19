#!/bin/bash
L=$HOME/foodmod/
rm -rf $L
git clone git@github.com:Link4Real/FoodMod $L
# file constants 
b=$L/build.gradle
p=$L/gradle.properties
m=$L/src/main/resources/fabric.mod.json
# build.gradle changes
sed -i 's/JavaVersion.VERSION_16/1.8/g' $b
sed -i 's/0.8-SNAPSHOT/0.7-SNAPSHOT/g' $b
sed -i 's/it.options.release = 16/it.options.release = 8/g' $b
# gradle.properties changes
sed -i 's/minecraft_version=.*/minecraft_version=1.16.2/g' $p
sed -i 's/yarn_mappings=.*/yarn_mappings=1.16.2+build.47/g' $p
sed -i 's/loader_version=.*/loader_version=0.11.6/g' $p
sed -i 's/fabric_version=.*/fabric_version=0.38.0+1.16/g' $p
# fabric.mod.json
sed -i 's/1.17.x/1.16.x/g' $m
sed -i 's/"java": ">=16"/"java": ">=8"/g' $m


# loot_tables
LT=$L/src/main/resources/data/minecraft/loot_tables
FT=$L/src/main/resources/data/foodmod/loot_tables
wget https://github.com/legendary-cookie/foodmod-version-compat/raw/master/spruce_leaves.json -O $LT/blocks/spruce_leaves.json

wget https://raw.githubusercontent.com/legendary-cookie/foodmod-version-compat/master/village_plains_house.json -O $LT/chests/village/village_plains_house.json

wget https://github.com/legendary-cookie/foodmod-version-compat/raw/master/tomato_crop.json -O $FT/blocks/tomato_crops.json

rm $LT/chests/village/village_house_plains.json
