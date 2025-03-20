export class ApiResult {
  // Status : Number
  // StatusCode : string
  // ErrorObj : any
  // Msg ?: string
  // ResultObj ?: any
  responseCode : Number
  header: any
  result: string
  resultObj: any
  cookies: string

}
//这个 ApiResult 类的设计用于表示网络请求的返回结果，包括请求的状态、状态码、错误信息、消息和结果对象。
// 通过这个类的实例，可以更方便地处理网络请求的返回结果，提取所需的信息并进行相应的处理。