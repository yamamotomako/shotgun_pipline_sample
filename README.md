# shotgun_pipline_sample

ショットガンパイプラインの簡易サンプルです。<br><br>

元祖パイプライン（木村さん作）のソフトウェアを実行している部分(一行)だけを、同じオプションで引き継いだものです。<br>
実行ファイルは、どこかにsrcをコンパイルするのではなく、HOMEにminicondaをインストールして、そこのbinをパス追加する方法を想定しています。<br>
（コンパイル形式が良いのかもしれませんし、conda形式だと実行ユーザーアカウントを作成するか、誰かのアカウントをそれに充てる必要がありますね）<br>
基本的に、１ソフトウェアに対して、１シェルファイルの構造です。<br>
各ファイルは大元のrunall.shで、hold_jidにより順次実行します。<br>
指定メモリはハードコーディングしています。<br>

<br><br>
・操作方法<br>
１、sample.txtに解析したいサンプル(フォルダ)名称を縦書きする。<br>
２、runall.shのCUR_DIR=${HOME}/以降に、これらのファイルを置いているパスを記載する。＜br＞
３、bash runall.shで実行。<br>

