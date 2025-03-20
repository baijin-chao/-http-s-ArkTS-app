import test22 from "../components/test3"
@Entry
@Component
struct Index {
  build() {
    Column(){
      test22()
    }
    .width("100%")
    .height("100%")
  }//end build
}