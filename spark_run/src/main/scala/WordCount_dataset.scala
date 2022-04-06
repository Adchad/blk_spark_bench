import org.apache.spark.{SparkConf, SparkContext}
object WordCount_dataset {
  def main(args: Array[String]): Unit = {
    val conf = new SparkConf().setAppName("Word count dataset")
    val sc = new SparkContext(conf)

    val filename = args(0)


    val peterpan = sc.textFile("/home/adam/data/"+ filename)


    val start = System.currentTimeMillis()
    val peterpan_parsed = peterpan.flatMap(line => line.split(" "))
    val peterpan_parsed2 = peterpan_parsed.map(word => (word,1))
    val peterpan_parsed3 = peterpan_parsed2.reduceByKey((a,b) => a+b).collect()
    val end = System.currentTimeMillis()

    val time = end - start

    println("Time: "+time+" ms ")


  }
}
