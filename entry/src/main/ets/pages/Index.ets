import test1 from "../components/test1"
import fetch from '@system.fetch';
@Entry
@Component
struct Index {

  build() {
    Column(){
      test1()
    }
    .width("100%")
    .height("100%")
  }//end build-
}



