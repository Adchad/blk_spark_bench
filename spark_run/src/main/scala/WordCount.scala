import org.apache.spark.{SparkConf, SparkContext}
object WordCount {
  def main(args: Array[String]): Unit = {
    val conf = new SparkConf().setAppName("Word count")
    val sc = new SparkContext(conf)


    val peterpan = sc.textFile("/home/adam/data/enwik9")


    val start = System.nanoTime()
    val peterpan_parsed = peterpan.flatMap(line => line.split(" "))
    val peterpan_parsed2 = peterpan_parsed.map(word => (word,1))
    val peterpan_parsed3 = peterpan_parsed2.reduceByKey((a,b) => a+b).collect()
    val end = System.nanoTime()

    val time = end - start

    println("Time: "+time+" ns ")


  }
}
