- 建立工作目录 mkdir /root/rainy/tomcat8
- 下载 tomcat安装包，解压
- 建立dockerfile 
- 
  1. docker build -t tomcat8:v1 /root/rainy/tomcat8/
  2. docker run -itd -p 8081:8080 --name tomcat8 tomcat8:v1 //8080端口映射8081
  3. docker exec -it tomcat8 /bin/bash
  4. 验证：http://10.110.36.229:8081/MyServlet/
