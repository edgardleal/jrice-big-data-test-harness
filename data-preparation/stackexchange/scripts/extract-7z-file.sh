getFileName() {
	FILE_PATH=$1
	b=$(basename $FILE_PATH)
	
	echo $b
}
getFileNameWithoutExtension() {
	a=$1
	xpath=${a%/*}
	xbase=${a##*/}
	xfext=${xbase##*.}
	xpref=${xbase%.*}
	
	echo ${xpref}
}
getFileNameExtension() {
	a=$1
	xpath=${a%/*}
	xbase=${a##*/}
	xfext=${xbase##*.}
	xpref=${xbase%.*}
	
	echo ${xfext}
}

COMPRESSED_FILE_NAME=$1
COMPRESSED_FILE_NAME_NO_EXT=

#COMPRESSED_FILE_DIR=~/big-data-datasets/stack-exchange-uncompressed
#UNCOMPRESS_ROOT_DIR=/home/ubuntu/big-data-datasets/stack-exchange-uncompressed/uncompress

COMPRESSED_FILE_DIR=/home/ubuntu/big-data-datasets/stack-exchange
UNCOMPRESS_ROOT_DIR=/home/ubuntu/big-data-datasets/stack-exchange-uncompressed
#UNCOMPRESS_FILE_DIR=$UNCOMPRESS_ROOT_DIR/$COMPRESSED_FILE_NAME
UNCOMPRESS_FILE_DIR=$UNCOMPRESS_ROOT_DIR
#mkdir -p $UNCOMPRESS_FILE_DIR

7z e -o$UNCOMPRESS_FILE_DIR $COMPRESSED_FILE_DIR/$COMPRESSED_FILE_NAME



getFileName "vi.meta.stackexchange.com.7z"
getFileNameWithoutExtension "vi.meta.stackexchange.com.7z"
getFileNameWithoutExtension "PostHistory.xml"