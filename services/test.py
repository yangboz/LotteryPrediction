from fastapi import FastAPI, File, UploadFile, Form
 
app = FastAPI()
 
@app.post("/files/")
async def create_file(file: bytes = File(...)):
    return {"file_size": len(file)}
 
@app.post("/uploadfile/")
async def create_upload_file(file: UploadFile = File(...)):
    return {"filename": file}
 
 
@app.post('/file/')
# 函数参数即为前端传递过来的文件/字符串
# 1.接收前端上传的文件
async def get_user(
        file: bytes = File(...),            # 把文件对象转为bytes类型，这种类型的文件无法保存
        fileb: UploadFile = File(...),      # UploadFile转为文件对象，可以保存文件到本地
        notes: str = Form(...)              # 获取普通键值对
):
 
    # 2.保存前端上传的文件至本地服务器
    # 2.1 读取前端上传到的fileb文件
    contents = await fileb.read()
    # print(contents)
    # print(fileb.filename)
    # 2.2 打开新文件
    # 第一个参数 文件存储路径+文件名称，存储路径目录需要提前创建好，如果没有指定，则默认会保存在本文件的同级目录下
    # 第二个参数 wb，表示以二进制格式打开文件，用于只写
    with open("test/file/" + fileb.filename, "wb") as f:
        # 2.3 将获取的fileb文件内容，写入到新文件中
        f.write(contents)
 
    # 启动服务后，会在本地FastAPI服务器的static/file/目录下生成 前端上传的文件
 
    return ( {
        'file_size': len(file),
        'file_name': fileb.filename,
        'notes': notes,
        'file_content_type': fileb.content_type
           })
