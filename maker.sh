#!/bin/bash
curl https://raw.githubusercontent.com/legendary-cookie/foodmod-version-compat/master/banner.txt 1>/dev/stdout 2>/dev/null
echo "Made by legendary-cookie"
echo
L=$HOME/foodmod/
rm -rf $L
echo "Cloning git repository ..."
git clone -q https://github.com/Link4Real/FoodMod $L
echo "Cloned git repository ..."
sleep 0.2
# file constants
b=$L/build.gradle
p=$L/gradle.properties
m=$L/src/main/resources/fabric.mod.json
# build.gradle changes
echo "Patching build.gradle ..."
sleep 0.2
sed -i 's/JavaVersion.VERSION_16/1.8/g' $b
sed -i 's/0.8-SNAPSHOT/0.7-SNAPSHOT/g' $b
sed -i 's/it.options.release = 16/it.options.release = 8/g' $b
# gradle.properties changes
echo "Patching gradle.properties ..."
sleep 0.2
sed -i 's/minecraft_version=.*/minecraft_version=1.16.2/g' $p
sed -i 's/yarn_mappings=.*/yarn_mappings=1.16.2+build.47/g' $p
sed -i 's/loader_version=.*/loader_version=0.11.6/g' $p
sed -i 's/fabric_version=.*/fabric_version=0.38.0+1.16/g' $p
# fabric.mod.json
echo "Patching fabric.mod.json"
sleep 0.2
sed -i 's/1.17.x/1.16.x/g' $m
sed -i 's/"java": ">=16"/"java": ">=8"/g' $m
# loot_tables
printf "Patching loot_tables ...\n"
sleep 0.2
LT=$L/src/main/resources/data/minecraft/loot_tables
FT=$L/src/main/resources/data/foodmod/loot_tables
printf "\tDownloading 'spruce_leaves.json' ...\n"
sleep 0.2
curl -sL https://github.com/legendary-cookie/foodmod-version-compat/raw/master/loot_tables/spruce_leaves.json --output $LT/blocks/spruce_leaves.json 
printf "\tDownloading 'village_plains_house.json' ...\n"
sleep 0.2
curl -sL https://raw.githubusercontent.com/legendary-cookie/foodmod-version-compat/master/loot_tables/village_plains_house.json --output $LT/chests/village/village_plains_house.json
printf "\tDownloading 'tomato_crops.json' ...\n"
sleep 0.2
curl -sL https://github.com/legendary-cookie/foodmod-version-compat/raw/master/loot_tables/tomato_crop.json --output $FT/blocks/tomato_crops.json
rm $LT/chests/village/village_house_plains.json
sleep 0.2
echo
echo "Building jar ..."
cd $L
chmod 0755 ./gradlew
./gradlew -Dorg.gradle.logging.level=quiet build
rm build/libs/*-dev.jar
rm build/libs/*-sources.jar
