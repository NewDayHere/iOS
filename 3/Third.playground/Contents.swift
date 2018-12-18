import UIKit

//（1）
func getDate(date: Date, zone: Int = 0) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy年MM月dd日EEEE aa KK:mm"
    formatter.locale = Locale.current
    if zone >= 0 { //为正数时，在东半区
        formatter.timeZone = TimeZone(abbreviation: "UTC+\(zone):00")
    } else {  //为负数时，在西半区
        formatter.timeZone = TimeZone(abbreviation: "UTC\(zone):00")
    }
    let dateString = formatter.string(from: now)  //将传入的日期格式化为字符串
    return dateString
}
let now = Date()  //获取当前时间日期
let beijing = getDate(date: now, zone: +8)  //获取当前北京的时间
print("北京: \(beijing)")
let tokyo = getDate(date: now, zone: 9)  //获取当前东京的时间
print("东京: \(tokyo)")
let newYork = getDate(date: now, zone: -5)  //获取当前纽约的时间
print("纽约: \(newYork)")
let london = getDate(date: now)  ////获取当前伦敦的时间
print("伦敦: \(london)")
//（2）
let parentString = "Swift is a powerful and intuitive programming language for iOS, OS X, tvOS, and watchOS."
let subString = parentString.replacingOccurrences(of: "OS", with: "")
print(subString)

//（3）
let dic = ["date": ["beijing": beijing, "tokyo": tokyo, "newYork": newYork, "london": london], "string": subString] as AnyObject
let defaultDoc = FileManager.default

if var path = defaultDoc.urls(for: .documentDirectory, in: .userDomainMask).first?.path {
    path.append("/test.txt")
    print(dic.write(toFile: path, atomically: true))
}
//（4）
let image = try Data(contentsOf: URL(string: "https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png")!) //通过指定的url获取图片，并转换为二进制数据

if var url = defaultDoc.urls(for: .documentDirectory, in: .userDomainMask).first {
    url.appendPathComponent("image.png")
    try image.write(to: url)  //将转换后的二进制数据存储为png图片
}
//（5）
let url = URL(string: "http://www.weather.com.cn/data/sk/101110101.html")!
let data = try Data(contentsOf: url)
let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)

if let dic = json as? [String: Any] {
    if let weather = dic["weatherinfo"] as? [String: Any] {
        let city = weather["city"]!
        let temp = weather["temp"]!
        let wd = weather["WD"]!
        let ws = weather["WS"]!
        print("城市: \(city), 温度: \(temp), 风向: \(wd), 风力: \(ws)")
    }
}





