#!/bin/bash

type=$1
className=""
op=""
idir=""

if [ "$type" == "image" ]; 
then
    className="ImageResource"
    op="image_resource"
    idir="images"
elif [ "$type" == "lottie" ];
then
    className="LottieResource"
    op="lottie_resource"
    idir="animations"
else
    className="IconResource"
    op="icon_resource"
    idir="icons"
fi

# Đường dẫn tới thư mục chứa các icon SVG
iconsDir="assets/$idir/"

# Tạo tệp output Dart
outputFile="lib/common/constants/$op.dart"

echo ">>> " "$outputFile"

# Xóa tệp output cũ nếu có
if [ -f "$outputFile" ]; then
  rm "$outputFile"
fi

# Viết phần khởi tạo của tệp Dart
echo "abstract class $className {" >> "$outputFile"
echo "  const $className._();" >> "$outputFile"
echo "" >> "$outputFile"

# Lặp qua các file trong thư mục icon|image
if [ "$type" == "image" ]; 
then
    for imageFile in "$iconsDir"*.png; do
        echo "$imageFile"
        imageName=$(basename "$imageFile")
    
        imageBaseName="${imageName%.*}"

        if [[ $(uname) == "Darwin" ]]; then
            imageConstantName=$(echo "$imageBaseName" | awk '{print tolower(substr($0,1,1)) substr($0,2)}' | sed -e 's/_\([a-z]\)/\U\1/g' -e 's/-\([a-z]\)/\U\1/g' -e 's/-//g' -e 's/_//g')
        else
            imageConstantName=$(echo "$imageBaseName" | sed -e 's/_\([a-z]\)/\U\1/g' -e 's/-\([a-z]\)/\U\1/g' -e 's/^./\L&/' -e 's/-//g' -e 's/_//g')
        fi
    
        echo "  static const String $imageConstantName = '$iconsDir$imageName';" >> "$outputFile"
    done
elif [ "$type" == "lottie" ];
then
    for aniFile in "$iconsDir"*.json; do
        echo "$aniFile"
        aniFileName=$(basename "$aniFile")
        
        aniName="${aniFileName%.*}"

        if [[ $(uname) == "Darwin" ]]; then
            aniNameCamelCase=$(echo "$aniName" | awk '{print tolower(substr($0,1,1)) substr($0,2)}' | sed -e 's/_\([a-z]\)/\U\1/g' -e 's/-\([a-z]\)/\U\1/g' -e 's/-//g' -e 's/_//g')
        else
            aniNameCamelCase=$(echo "$aniName" | sed -e 's/_\([a-z]\)/\U\1/g' -e 's/-\([a-z]\)/\U\1/g' -e 's/^./\L&/' -e 's/-//g' -e 's/_//g')
        fi

        echo "  static const String $aniNameCamelCase = '$aniFile';" >> "$outputFile"
    done  
else
    for svgFile in "$iconsDir"*.svg; do
        echo "$svgFile"
        iconFileName=$(basename "$svgFile")
        
        iconName="${iconFileName%.*}"

        # iconNameCamelCase=$(echo "$iconName" | sed -e 's/_\([a-z]\)/\U\1/g' -e 's/-\([a-z]\)/\U\1/g' -e 's/^./\L&/' -e 's/-//g')
        if [[ $(uname) == "Darwin" ]]; then
            iconNameCamelCase=$(echo "$iconName" | awk '{print tolower(substr($0,1,1)) substr($0,2)}' | sed -e 's/_\([a-z]\)/\U\1/g' -e 's/-\([a-z]\)/\U\1/g' -e 's/-//g' -e 's/_//g')
        else
            iconNameCamelCase=$(echo "$iconName" | sed -e 's/_\([a-z]\)/\U\1/g' -e 's/-\([a-z]\)/\U\1/g' -e 's/^./\L&/' -e 's/-//g' -e 's/_//g')
        fi

        echo "  static const String $iconNameCamelCase = '$svgFile';" >> "$outputFile"
    done
fi



# End
echo "" >> "$outputFile"
echo "}" >> "$outputFile"

echo "Đã tạo $className."
