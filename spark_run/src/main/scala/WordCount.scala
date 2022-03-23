import org.apache.spark.{SparkConf, SparkContext}
object WordCount {
  def main(args: Array[String]): Unit = {
    val conf = new SparkConf().setAppName("Word count")
    val sc = new SparkContext(conf)


    val peterpan = sc.textFile("/home/adam/data/peter_pan.txt")


    val start = System.nanoTime()
    peterpan.flatMap(line => line.split(" ")).map(word => (word,1)).reduceByKey((a,b) => a+b).persist()
    val end = System.nanoTime()

    val time = end - start

    println("Time: "+time+" ns ")


  }
}
