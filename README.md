# DependencyGraph

## 概要

**DependencyGraph**は、Xcodeプロジェクトの依存関係を可視化するツールです。このスクリプトは、ビルドディレクトリからアプリケーションバンドルをコピーし、依存関係をJSON形式で作成し、macOSアプリケーションを起動して依存関係グラフを生成します。

## 特徴

- **依存関係の抽出と可視化**: Xcodeのビルド結果から依存関係を解析し、JSON形式で保存し、それを基にグラフを生成します。
- **自動化**: スクリプトで一連のプロセスを自動化。

## インストール

1. リポジトリをクローンします:
   ```sh
   git clone https://github.com/daikinetic/DependencyGraph.git
   ```
2. スクリプトを実行して依存関係を生成します:
   ```sh
   cd DependencyGraph
   bash generate_dependencies.sh
   ```
3. `DependencyGraph/` 配下に `dependencies.png` が生成されます（これはイメージ画像）
   
![image](https://github.com/user-attachments/assets/3af62dee-d07b-4654-9c11-955be26ccc3d)


