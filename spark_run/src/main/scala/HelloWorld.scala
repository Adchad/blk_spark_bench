object HelloWorld {
  def main(args: Array[String] ) = {

    val nums: List[Int] = List(1, 2, 3, 5, 10)

    nums.map( (i : Int) => i*i).filter((p:Int) => p>20).foreach(println)

    println(nums.reduce((A,B) => A+ B))
  }

  def square(v : Int) =  println(v*v)
}
