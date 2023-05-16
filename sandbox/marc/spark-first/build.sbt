ThisBuild / version := "0.1.0-SNAPSHOT"

ThisBuild / scalaVersion := "2.12.15"

ThisBuild / name := "Word Count"

libraryDependencies += "org.apache.spark" % "spark-core_2.10" % "1.4.0" % "provided"
