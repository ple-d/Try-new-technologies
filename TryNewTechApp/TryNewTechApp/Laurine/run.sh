set -x

#--------- START OF CONFIGURATION

# Get base path to project
BASE_PATH="$PROJECT_DIR/$PROJECT_NAME"

# Get path to Laurine Generator script
LAURINE_PATH="$BASE_PATH/Laurine/LaurineGenerator.swift"

# Get path to main localization file (usually english).
SOURCE_PATH="$BASE_PATH/Resources/ru.lproj/Localizable.strings"

# Get path to output. If you use ObjC version of output, set implementation file (.m), as header will be generated automatically
OUTPUT_PATH="$BASE_PATH/Generated/Localizations.swift"

#--------- END OF CONFIGURATION

# Add permission to generator for script execution
chmod 755 "$LAURINE_PATH"

# Actually generate output. -- CUSTOMIZE -- parameters to your needs (see documentation).
# Will only re-generate script if something changed
#if [ "$OUTPUT_PATH" -ot "$SOURCE_PATH" ]; then
"$LAURINE_PATH" -i "$SOURCE_PATH" -o "$OUTPUT_PATH"
#fi

