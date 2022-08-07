# Dockerize Spark and Zeppelin

Hi! I'm a new learner in **Dockerizing Services**. I've managed to create dockerfile, entrypoint.sh, docker-compose.yml


1. Open your powershell/ Command Prompt and Run Below Command
**curl -LO https://raw.githubusercontent.com/codechef97/standalone-spark/master/docker-compose.yml**
 > _Note: If you get any error regarding curl, please run : **remove-item alias:curl**_
2. if command runs successfully, Please run 
	**docker-compose up**
3. You will see images on the docker and just start those images


Another Way 
-
> we'll have to do some changes in the file [entrypoint.sh]
1. Keep dockerfile and entrypoint.sh in one folder and change directory to that folder
	Run Command  - **docker build -t "spark_standalone" .**
2. Create Spark Master Container using newly created spark_standalone image
	docker run  --add-host sparkmaster:127.0.0.1 -ti -v ./spark:/spark 
	  -p 8080:8080 
	  -p 7077:7077 
	  -p 8888:8888 
	  -p 8081:8081 -h sparkmaster
	 -e INIT_DAEMON_STEP='setup_spark' 
	 -e SPARK_MASTER='spark://spark-master:7077' --name spark_standalone spark_standalone bash;
3. Set Spark master as  `spark://<hostname>:7077`  in Zeppelin  **Interpreters**  setting page.




References 
- 
- https://docs.docker.com/compose/compose-file/compose-file-v3/
- https://github.com/Ideamaxwu/zeppelin/blob/48c809fcd93406046829743791ab546fc559481e/docs/install/spark_cluster_mode.md
- 
