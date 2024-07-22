#!/bin/bash

PROJECT_DIR="/Users/daiki.takano/Development/DependencyGraph"
RESOURCES_DIR="$PROJECT_DIR/Resources"
TMP_LOG=$(mktemp /tmp/dependency_graph_log.XXXXXX)

# 最新のビルドディレクトリを見つける
BUILD_DIR=$(find ~/Library/Developer/Xcode/DerivedData/ -type d -name "DependencyGraph-*" | sort -n | tail -1)/Build/Products/Debug
APP_NAME="DependencyGraph.app"
DEST_DIR="$PROJECT_DIR"

echo "Using build directory: $BUILD_DIR"

echo "Copying application bundle..."
cp -R "$BUILD_DIR/$APP_NAME" "$DEST_DIR"
if [ $? -ne 0 ]; then
    echo "Failed to copy application bundle."
    exit 1
fi
echo "Application bundle copied."

# 依存関係データをJSON形式で作成
echo "Creating JSON file..."
echo '{
    "name": "Project",
    "dependencies": [
        {
            "name": "Library A",
            "dependencies": [
                {
                    "name": "Library C",
                    "dependencies": []
                }
            ]
        },
        {
            "name": "Library B",
            "dependencies": [
                {
                    "name": "Library D",
                    "dependencies": []
                }
            ]
        }
    ]
}' > "$RESOURCES_DIR/dependencies.json"

sudo chmod 644 "$RESOURCES_DIR/dependencies.json"

if [ -f "$RESOURCES_DIR/dependencies.json" ]; then
    echo "JSON file created at $RESOURCES_DIR/dependencies.json"
else
    echo "Failed to create JSON file."
    exit 1
fi

# macOSアプリケーションのパスを設定
APP_PATH="$DEST_DIR/$APP_NAME"

# macOSアプリケーションを起動し、JSONファイルのパスとログファイルのパスを渡す
echo "Opening application..."
/usr/bin/open -a "$APP_PATH" --args "$RESOURCES_DIR/dependencies.json" "$TMP_LOG"
if [ $? -ne 0 ]; then
    echo "Failed to open application."
    exit 1
fi
echo "Application opened."

# ログファイルの内容を表示
sleep 5  # アプリケーションの起動とログ書き込みのための待機時間
echo "Log file contents:"
cat "$TMP_LOG"

TMP_IMAGE_PATH="/Users/daiki.takano/Library/Containers/com.dddaiki-t.DependencyGraph/Data/tmp/dependencies.png"
DEST_IMAGE_PATH="$(pwd)/Resources/dependencies.png"
if [ -f "$TMP_IMAGE_PATH" ]; then
    mv "$TMP_IMAGE_PATH" "$DEST_IMAGE_PATH"
    echo "Image moved to $DEST_IMAGE_PATH"
else
    echo "Image not found in $TMP_IMAGE_PATH"
fi
