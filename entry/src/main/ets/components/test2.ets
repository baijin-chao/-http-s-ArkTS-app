// index.ets
import fetch from '@system.fetch';

@Entry
@Component
struct MainPage {
  build() {
    Column() {
      Button('Send Message to IoT Cloud')
        .onClick(this.sendMessageToCloud);
    }
  }

  sendMessageToCloud() {
    let url = "https://your-iot-platform.com/api/send";
    let data = JSON.stringify({
      message: "Hello, IoT Cloud!"
    });

    fetch.fetch({
      url: url,
      method: 'POST',
      data: data,
      success: function (response) {
        console.log("Message sent successfully: " + response.data);
      },
      fail: function (error) {
        console.error("Failed to send message: " + error.data);
      }
    });
  }
}
