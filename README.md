## Technology
This project is created with:
- Java
- JSP
- Maven
- Tomcat

## Installation
Follow these steps to run the project locally:
1. Clone the repository.
```shell
git clone https://github.com/bharaaa/jsp-webapp.git
```
2. Navigate to directory
```shell
cd jsp-webapp
```
3. Install dependencies:
open POM.xml and click refresh button
4. Run the project with these command (if you are using homebrew):
```shell
mvn clean package  
```
```shell
cp target/jsp-webapp-1.0.war /opt/homebrew/Cellar/tomcat/10.1.24/libexec/webapps/
```
*replace the path with your tomcat directory
```shell
brew services start tomcat
```
Then open your browser and access via localhost
http://localhost:8080/jsp-webapp-1.0/