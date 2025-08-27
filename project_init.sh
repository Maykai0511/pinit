#!/bin/bash
# 是否传入项目名
if [[ $# -eq 0 ]]; then
	echo "未输入项目名！"
	exit
fi
PROJECT_NAME=$1

# 创建项目文件夹
mkdir -p ${PROJECT_NAME}
cd ${PROJECT_NAME}

# 创建各目录
mkdir -p include src bin obj

# 创建初始文件
touch Makefile
touch src/makefile
touch src/main.c
touch obj/makefile

# 使用 Here 文档(<<EOF)
#  Makefile
cat <<EOF > Makefile
#  Makefile
PROJECT_PATH:=\$(shell pwd)
SRC_DIRS:=src
OBJ_DIRS:=obj
BIN_DIRS:=bin

CC:=gcc
CFLAGES:=-c
# 最终可执行文件名称
OBJ:=${PROJECT_NAME}

# 命令行参数变量，默认为空
ARGS?=

# 编译参数，默认为空
LINK?=

# 获取 当前路径下 .c 文件
C_SOURCE:=\$(wildcard \$(SRC_DIRS)/*.c)
# 将OBJS赋值，将 .c 文件存为 .o 文件
OBJS:=\$(patsubst \$(SRC_DIRS)/%.c, %.o, \$(C_SOURCE))

export CC CFLAGES OBJ OBJS PROJECT_PATH OBJ_DIRS SRC_DIRS BIN_DIRS LINK

ALL:Compile Run

Compile:
	@make -s -C \$(SRC_DIRS)
	@make -s -C \$(OBJ_DIRS)
	@echo "Compile Finish!"

Run:
	@echo "Run \$(OBJ)..."
	@echo ""
	@\$(BIN_DIRS)/\$(OBJ) \$(ARGS)

.PHONY:clean:
	@\$(RM) \$(OBJ_DIRS)/*.o
	@echo "Clean Finish!"

EOF

# ./src/makefile
cat <<EOF > src/makefile
# ./src/makefile
Compile:\$(OBJS)
	mv \$^ \$(PROJECT_PATH)/\$(OBJ_DIRS)/	
%.o:%.c
	\$(CC) \$(CFLAGES) \$< -o \$@

EOF

# ./obj/makefile
cat <<EOF > obj/makefile
# ./obj/makefile
Link:\$(OBJS)
	\$(CC) \$^ -o \$(OBJ) \$(LINK)
	mv \$(OBJ) \$(PROJECT_PATH)/\$(BIN_DIRS)/

EOF

# ./res/main.c
cat <<EOF > src/main.c


int main(int argc, char *argv[])
{

	return 0;
}
EOF
