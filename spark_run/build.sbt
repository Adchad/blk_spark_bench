ThisBuild / version := "0.1.0-SNAPSHOT"

ThisBuild / scalaVersion := "2.12.10"

lazy val root = (project in file("."))
  .settings(
    name := "scala"
  )

scalaVersion := "2.12.10"
val sparkVersion = "3.0.3"
libraryDependencies ++= Seq(
  "org.apache.spark" %% "spark-core" % sparkVersion
)
