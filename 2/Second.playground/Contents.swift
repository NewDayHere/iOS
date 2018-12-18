import UIKit


//作业一
//(1)
let dictionary1 = [["name": "Jerry", "age": 18], ["name": "Tom", "age": 19], ["name": "William", "age": 20]]
let ages = dictionary1.map( { $0["age"]! } )
print(ages)
//(2)
let arr1 = ["33527", "iqhwi", "1y289w", "123"]
let arr2 = arr1.filter( { Int($0) != nil } )
print(arr2)
//(3)
let arr3 = ["he", "has", "3","aaples"]
var str1 = arr3.reduce("", { $0 + "," + $1 })
str1.remove(at: str1.startIndex)
print(str1)
//(4)
var intArr = [13,47,93,47]
let tuple = intArr.reduce((max: intArr[0], min: intArr[0], sum: 0), { (max: max($0.max, $1), min: min($0.min, $1), $0.sum + $1) })
print(tuple)  //输出(44, 11, 99)
//(5)
func f1(a: Int) -> Int {
    return a
}  //函数类型为(Int) -> Int

func f2(a: String) -> Int {
    return Int(a)!
}  //函数类型为(String) -> Int

func f3() -> Int {
    return 2
}  //函数类型为() -> Int

func f4(a: Int) {
    
}  //函数类型为(Int) -> Void

func f5(a: Int) -> Int {
    return a + 1
}  //函数类型为(Int) -> Int

let funArr: [Any] = [f1, f2, f3, f4, f5]
for (index, value) in funArr.enumerated() {
    if value is (Int) -> Int {
        print(index)
    }
}
//(6)
extension Int {
    func sqrt() -> Double {
        return Darwin.sqrt(Double(self))
    }
}
//(7)
func getMaxAndMin<T: Comparable>(a: T...) -> (T, T) {
    var max = a[0]
    var min = a[0]
    
    for item in a {
        if item > max {
            max = item
        } else if item < min {
            min = item
        }
    }
    return (max, min)
}
print(getMaxAndMin(a: 1, 2, 3, 9, 2, 88))
print(getMaxAndMin(a: 1.0, 2.0, 3.0, 9.0, 2.0, 88.0))
print(getMaxAndMin(a: "a", "b", "A", "sss"))
//作业二
enum Gender:Int{
    case male
    case female
    static func >(gen1:Gender,gen2:    Gender) ->Bool {
        return gen1.rawValue < gen2.rawValue
    }
}

enum Department:String{
    case teacher
    case student
}

protocol SchoolProtocol{
    func lendbook()
    var department:Department{get set}
}

//Person类
class Person:CustomStringConvertible{
    //存储属性
    var firstName:String
    var lastName:String
    var age:Int
    var gender:Gender
    //计算属性
    var fullname:String{
        get{
            return firstName + " " + lastName
        }
    }
    //构造函数
    init(firstName:String,lastName:String,age:Int,gender:Gender){
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.gender = gender
    }
    //便利构造函数
    convenience init(name:String){
        self.init(firstName: name,lastName: "",age:18, gender: Gender.male)
    }
    
    //用==和!=进行比较两个Person实例对象
    static func ==(per1:Person,per2:Person)  -> Bool{
        return per1.fullname == per2.fullname
    }
    static func !=(per1:Person,per2:Person)  -> Bool{
        return !(per1.fullname == per2.fullname)
    }
    
    //输出函数
    var description:String{
        return "Name:\(fullname) Age:\(age) Gender:\(gender)"
    }
    //Person增加run方法(方法里面直接print输出Person XXX is running;
    func run(){
        print("Person \(self.fullname) is running")
    }
}
//定义两个人
let p1 = Person(firstName:"li",lastName:"guiyang",age:43,gender:Gender.male)
let p2 = Person(name:"gaoyuexiang")
let p3 = Person(firstName:"gaoyuexiang",lastName:"",age:18,gender:Gender.male)
//输出Person实例
print(p1.description)
print(p2.description)
//两个Person实例对象用==和!=进行比较
print(p1 != p2)
print(p2 == p3)
print(p2 != p3)

//Teacher类
class Teacher:Person{
    var title:String //新增title属性
    var department:Department
    init(title:String,firstName:String,lastName:String,age:Int,gender:Gender){
        self.title = title
        self.department = Department.teacher
        super.init(firstName:firstName,lastName:lastName,age:age,gender:gender)
    }
    
    convenience init(name:String){
        self.init(title:"Title of teacher ",firstName:name, lastName: "", age: 18, gender:Gender.male)
    }
    
    //重载输出函数
    override var description:String{
        return "Title:\(title) \(super.description)"
    }
    override func run(){
        print("Teacher \(self.fullname) is running")
    }
    func lendbook(){
        print("Teacher \(self.fullname) lend one book from library")
    }
}


//Student类
class Student:Person{
    var stuNo:Int
    var department:Department
    init(stuNo:Int,firstName:String,lastName:String,age:Int,gender:Gender){
        self.stuNo = stuNo
        self.department = Department.student
        super.init(firstName:firstName,lastName:lastName,age:age,gender:gender)
    }
    convenience init(name:String){
        self.init(stuNo:20161101,firstName: name, lastName: "", age: 18, gender: Gender.male)
    }
    //重载输出函数
    override var description:String{
        return "StuNo:\(stuNo) \(super.description)"
    }
    
    override func run(){
        print("Student \(self.fullname) is running")
    }
    
    func lendbook(){
        print("Student \(self.fullname) borrow one book from library")
    }
}

//分别构造多个Person、Teacher和Student对象，并将这些对象存入同一个数组中
var recordArray = [Person]()
for i in 1...2{
    let perArray = Person(firstName:"第\(i)个", lastName:"person", age: i + 20, gender:Gender.male)
    recordArray.append(perArray)
}

for i in 1...3{
    let teaArray = Teacher(title:"teacher", firstName:"第\(i)个",lastName:"teacher",age:i + 30,gender:Gender.male)
    recordArray.append(teaArray)
}
for i in 1...4{
    let stuArray = Student(stuNo:i+20161100,firstName:"第\(i)个",lastName:"student",age:i + 16,gender:Gender.male)
    recordArray.append(stuArray)
}

var dictionary = ["Person":0,"Teacher":0,"Student":0]
for traverseArray in recordArray{
    if traverseArray is Student{
        dictionary["Student"]! += 1
    }else if traverseArray is Teacher{
        dictionary["Teacher"]! += 1
    }else{
        dictionary["Person"]! += 1
    }
}
print("输出字典内容：")
for (key,value) in dictionary{
    print("\(key):\(value)个")
}


//对数组按age排序并输出
recordArray.sort(by:{
    return $0.age < $1.age
})
for traverseArray in recordArray{
    print(traverseArray)
}

//对数组按fullName排序并输出
recordArray.sort(by:{
    return $0.fullname < $1.fullname
})
for traverseArray in recordArray{
    print(traverseArray)
}

//对数组按gender+age排序并输出
recordArray.sort(by:{
    return ($0.age < $1.age) && ($0.gender > $1.gender)
})
for traverseArray in recordArray{
    print(traverseArray)
}

var tea = Teacher(name:"Li")
var stu = Student(name:"Wang")
print(tea)
tea.run()
tea.lendbook()
print(stu)
stu.run()
stu.lendbook()
