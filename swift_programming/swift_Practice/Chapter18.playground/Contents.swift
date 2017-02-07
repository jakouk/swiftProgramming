//: Playground - noun: a place where people can play

import UIKit

// Chapter18. 상속

/*
    클래스나 메서드나 프로퍼티 등을 다른 클래스로부터 상속받을 수 있습니다. 어떤 클래스로부터 상속을 받으면 상속받은 클래스는
    그 어떤 클래스의 자식클래스라고 표현합니다. 자식 클래스에서 자신의 특성을 물려준 클래스를 부모클래스라고 표현합니다. 상속은
    스위프트의 다른 타입과 클래스를 구별 짓는 클래스만의 특징입니다.
 
    스위프트의 클래스는 부모클래스로부터 물려받은 메서드를 호출할 수 있고 프로퍼티에 접근할 수 있으며 서브스크립트도 사용할 수
    있습니다. 또 부모클래스로부터 물려받은 메서드, 프로퍼티, 서브스크립트 등을 자신만의 내용으로 재정의할 수도 있습니다. 스위
    프트는 부모클래스의 요소르 자식클래스에게 재정의할 때 자식클래스가 부모클래스의 것들을 재정의한다는 것을 명확히 확인해주어야
    합니다.
 
    상속받은 프로퍼티에 프로퍼티의 값이 변경되면 알려주는 프로퍼티 감시자도 구현할 수 있습니다. 연산 프로퍼티를 정의해준 클래스
    에서는 연산 프로퍼티에 프로퍼티 감시자를 구현할 수 없지만, 부모클래스에서 연산 프로퍼티로 정의가 된 프로퍼티든 
    저장 프로퍼티로 정의가 된 프로퍼티든 간에 자식클래스에서는 프로퍼티 감시자를 구현할 수 있습니다.
 
    다른 클래스로부터 상속을 받지 않은 클래스를 기반 클래스라고 부릅니다. 우리가 이제까지 어떤 클래스로부터 상속 받지 않고 생성한
    대부분의 클래스를 기반클래스라고 생각해도 무방합니다.
 */



/// 18-1 기반 클래스 Person

class Person {
    var name: String = ""
    var age: Int = 0
    
    var introduction: String {
        return "이름 : \(name). 나이 : \(age)"
    }
    
    func speak() {
        print("가나다라마바사")
    }
}

let yagom: Person = Person()
yagom.name = "yagom"
yagom.age = 99
print(yagom.introduction)   // 이름 : yagom. 나이 : 99
yagom.speak()



/*
    클래스 상속
    수직으로 클래스를 확장할 수 있는 상속
    상속은 기반클래스를 다른 클래스에게 물려받는 것을 말합니다. 부모클래스의 메서드, 프로퍼티등을 재정의하거나, 기반클래스의
    기능이나 프로퍼티를 물려받고 자신의 기능을 추가할 수 있습니다. 
 
    class name: super class {
        properties and method
    }
 */

/// 18-2 Person 클래스를 상속받은 Student 클래스

class Student: Person {
    var grade: String = "F"
    
    func study() {
        print("Study hard...")
    }
}

let jay: Student = Student()
jay.name = "jay"
jay.age = 10
jay.grade = "A"
print(jay.introduction)
jay.speak()
jay.study()



/// 18-3 Student 클래스를 상속받은 UniversityStudent 클래스

class UniversityStudent : Student {
    var major: String = ""
}

let jenny: UniversityStudent = UniversityStudent()
jenny.major = "Art"
jenny.speak()   // 가나다라마바사
jenny.study()   // Study hard...



/*
    재정의 
    자식클래스는 부모로부터 물려받은 특성(인스턴스 메서드, 타입 메서드, 인스턴스 프로퍼티, 타입 프로퍼티, 서브스크립트 등)을 
    그래로 사용하지 않고 자신만의 기능으로 변경하여 사용할 수 있습니다. 이를 재정의라고 합니다.
 
    상속받은 특성들을 재정의하려면 새로운 정의 앞에 override라는 키워드를 사용합니다.
    super 키워드를 사용하면 부모의 메서드나 프로퍼티에 접근할수 있습니다. 
    super.someMethod, super.SomeProperty, super[index]
 
 */



/// 18-4 메서드 재정의 

class Person1 {
    var name : String = ""
    var age: Int = 0
    
    var introduction : String {
        return " 이름 : \(name). 나이 : \(age)"
    }
    
    func speark() {
        print("가나다라마바사")
    }
    
    class func introduceClass() -> String {
        return "인류의 소원은 평화입니다"
    }
}

class Student1: Person1 {
    var grade: String = "F"
    
    func study() {
        print("Study hard...")
    }
    
    override func speark() {
        print("저는 학생입니다.")
    }
}

class UniversityStudent1 : Student1 {
    var major: String = ""
    
    class func introduceClass() {
        print(super.introduceClass())
    }
    
    override class func introduceClass() -> String {
        return "대학생의 소원은 A+입니다"
    }
    
    override func speark() {
        super.speark()
        print("대학생이죠.")
    }
}

let yagom1: Person1 = Person1()
yagom1.speark()

let jay1: Student1 = Student1()
jay.speak()

let jenny1: UniversityStudent1 = UniversityStudent1()
jenny1.speark()

print(Person1.introduceClass())
print(Student1.introduceClass())
print(UniversityStudent1.introduceClass() as String)    // 대학생의 소원은 A+입니다.
UniversityStudent1.introduceClass() as Void // 인류의 소원은 평화입니다. 

/*
    함수의 이름은 같지만 반환타입이 다르면 다른 함수이다. 
 */



/*
    프로퍼티의 재정의 
    메서드와 마찬가지로 부모 클래스로부터 상속받은 인스턴스 프로퍼티나 타입 프로퍼티를 자식 클래스에서 용도에 맞게 재정의할 수
    있습니다. 프로퍼티를 쩡의할 때에는 저장 프로퍼티로 재정의할 수는 없습니다. 프로퍼티를 재정의 한다는 것은 프로퍼티 자체가
    아니라 프로퍼티의 접근자, 설정자, 프로퍼티 감시자등을 재정의 하는 것을 의미합니다. 
 
    조상클래스 프로퍼티에서 읽기 전용 프로퍼티였더라도 자식 클래스에서 읽고 쓰기가 가능한 프로퍼티로 재정의해줄 수도 있습니다.
    그러나 읽기 쓰기 모두 가능했던 프로퍼티를 읽기 전용으로 재정의해줄 수는 없습니다.
 */

/// 18-5 프로퍼티 재정의

class Person2 {
    var name: String = ""
    var age: Int = 0
    var koreanAge: Int {
        return self.age + 1
    }
    
    var introduction: String {
        return "이름 : \(name). 나이 \(age)"
    }
}

class Student2: Person2 {
    var grade: String = "F"
    
    override var introduction: String {
        return super.introduction + " " + "학점 : \(self.grade)"
    }
    
    override var koreanAge: Int {
        get {
            return super.koreanAge
        }
        
        set {
            self.age = newValue - 1
        }
    }
}

let yagom2: Person2 = Person2()
yagom2.name = "yagom"
yagom2.age = 55
// yagom2.koreanAge = 56    // 오료 발생
print(yagom2.introduction)
print(yagom2.koreanAge)

let jay2: Student2 = Student2()
jay2.name = "jay"
jay2.age = 14
jay2.koreanAge = 15

print(jay2.introduction)
print(jay2.koreanAge)



/*
    프로퍼티 감시자 재정의
    상수 저장 프로퍼티나 읽기전용 프로퍼티는 프로퍼티 감시자를 재정의할수 없습니다.
    또 프로퍼티 감시자를 재정의하더라도 조상클래스에 정의된 프로퍼티 감시자도 동작한다는점 잊지 마세요.
    프로퍼티의 접근자와 프로퍼티의 감시자는 동시에 재정의할수 없습니다. 만약 둘 다 동작되길 원한다면 재정의하는 
    접근자에 프로퍼티 감시자의 역활을 구현해야 합니ㅏㄷ.
 */

/// 18-6

class Person3 {
    var name: String = ""
    var age: Int = 0 {
        didSet {
            print("Person age: \(self.age)")
        }
    }
    
    var koreanAge: Int {
        return self.age + 1
    }
    
    var fullName: String {
        get {
            return self.name
        }
        set {
            self.name = newValue
        }
    }
}

class Student3 : Person3 {
    var grade: String = "F"
    
    override var age: Int {
        didSet {
            print("Student age : \(self.age)")
        }
    }
    
    override var koreanAge: Int {
        get {
            return super.koreanAge
        }
        set {
            self.age = newValue - 1
        }
        
        /*
        didSet{
            // 오류 발생
        }
         */
    }
    
    override var fullName: String {
        didSet {
            print("Full Name : \(self.fullName)")
        }
    }
}

let yagom3: Person3 = Person3()
yagom3.name = "yagom"
yagom3.age = 55
yagom3.fullName = "Jo yagom"
print(yagom3.koreanAge)

let jay3: Student3 = Student3()
jay3.name = "jay"
jay3.age = 14
// Person age : 14
// Studnet age : 14

jay3.koreanAge = 15
// Person age : 14
// Student age : 14

jay3.fullName = "Kim jay"   // Full Name Kim jay
print(jay3.koreanAge)   // 15



/*
    서브스크립트 재정의
 */

/// 18-7 서브스크립트 재정의

class School {
    var students: [Student] = [Student]()
    
    subscript(number: Int ) -> Student {
        print("School subscropt")
        return students[number]
    }
}

class MiddleSchool : School {
    var middleStudents: [Student] = [Student]()
    
    //  부모(school)에서 상속받은 서브스크립트 재정의
    override subscript(index: Int) -> Student {
        print("MiddleSchool subscript")
        return middleStudents[index]
    }
}

let university: School = School()
university.students.append(Student())
university[0]   // School subscript

let middle : MiddleSchool = MiddleSchool()
middle.middleStudents.append(Student())
middle[0]   // MiddleSchool subscript

/*  
    재정의 방지
    만약 자신을 상속받는 자식클래스에서 몇몇 특성을 재정의할 수 없도록 제한하고 싶다면 재정의를 방지할 수 있는데 재정의를 
    방지하고 싶은 특성 앞에 final 키워드를 명시하면 도비니다.
    final var , final func , final class func , final subscript, final class
 */

/// 18-8 final 키워드의 사용

/*
class Person4 {
    final var name: String = ""
    
    final func speak() {
        print("가나다라마바사")
    }
}

final class Student4: Person4 {
    // 오류! 
    // Person4의 name은 final을 사용하여 재정의 할 수 없도록 하였기 때문입니다.
    
    override var name: String {
        set {
            super.name = newValue
        }
        
        get {
            return "학생"
        }
    }
    
    override func speak() {
        print("저는 학생입니다")
    }

}

class University4 : Student4 {
    
}
 */



/*
    클래스의 이니셜라저 - 상속과 재정의 
 
    클래스에서는 지정 이니셜라이저와 편의 이니셜라이저로 역활을 구분합니다. 
 
    지정 이니셜라이저
 
    지정 이니셜라이저는 클래스의 주요 이니셜라이저입니다. 지정 이니셜라이저는 필요에 따라 부모클래스의 이니셜라이저를 호출할수 
    있으며, 이니셜라이저가 정의된 클래스의 모든 프로퍼티를 초기화해야하는 임무를 갖고 있습니다.
    지정 이니셜라이저는 클래스의 이니셜라이저 중에 기둥과 같은 역활을 하므로 클래스에 하나 이상 정의됩니다. 물론 여러개를 
    정의할 수 는 있지만 편의 이니셜라이저에 비하면 적은 수로 정의됩니다. 
 
    모든 클래스는 하나 이상의 지정 이니셜라이저를 갖씁니다. 만약 조상클래스에서 지정 이니셜라이저가 자손클래스의 지정 이니셜라이저
    역활을 충분히 수행할 수 있다면, 자손클래스는 지정 이니셜라이저를 갖지 않을수도 있습니다. 아마도 이런 경우는 조상클래스로부터
    물려받은 프로퍼티를 제외하고 옵셔널 저장 프로퍼티 외에 다른 저장 프로퍼티를 가지지 않을 가능성이 큽니다. 
 
    편의 이니셜라이저
 
    초기화를 좀 더 손쉽게 도와주는 역활을 합니다. 편의 이니셜라이저는 지정 이니셜라이저를 자신 내부에서 호출합니다. 지정
    이니셜라이저의 매개변수가 많아 외부에서 일일이 전달인자를 전달하기 어렵거나 특정 목적에 사용하기 위해서 편의 이니셜라이저를 
    설계할 수도 있습니다. 예를 들어 특정 목적으로 인스턴스를 생설할 때 일부 프로퍼티는 클래스 설계자가 의도한 대로 초깃값을 
    지정해 줘야 합니다. 지정 이니셜라이저를 사용하면 인스턴스를 생성할 때마다 전달인자로 초깃값을 전달해야 하지만 편의 
    이니셜라이저를 사용하면 항상 같은 값으로 초기화가 가능합니다.
    편의 이니셜라이저는 필수 요소는 아닙니다. 다마 클래스 설계자의 의도대로 외부에서 사용되길 원하거나 인스턴스 생성 코드를 
    작성할 때 수고를 덜고자 할 때 유용하게 사용할 수 있습니다.
 
    지정 이니셜라이저
    init(매개변수) {
        초기화 구문
    }
 
    편의 이니셜라이저
 
    convenience init(매개변수) {
        초기화 구문
    }
 */



/*
    클래스의 초기화 위임
 
    1. 자식클래스의 지정 이니셜라이저는 부모클래스의 지정 이니셜라이저를 반드시 호출해야 합니다.
    2. 편의 이니셜라이저는 자신이 정의된 클래스의 다른 이니셜라이저를 반드시 호출해야 합니다.
    3. 편의 이니셜라이저는 궁극적으로 지정 이니셜라이저를 반드시 호출해야 합니다.
 
 
 */



/*
    2단계 초기화
 
    1단계는 클래스에 정의된 각각의 저장 프로퍼티에 초깃값이 할당됩니다. 모든 저장 프로퍼티의 초기 상태가 결정되면 2단계로
    돌입합니다. 2 단계에서는 저장 프로퍼티들이 커스터마이즈될 기회를 얻습니다. 그 후 비로소 새로운 인스턴스가 사용될 준비가 
    됩니다.
 
    2단계 초기화는 프로퍼티가 초기화되기 전에 프로퍼티 값에 접근한는 것을 막아 초기화를 안전하게 할 수 있도록 해줍니다.
    또, 다른 이니셜라이저가 프로퍼티의 값을 실수로 변경하는 것을 방지할 수도 있습니다. 
 
    스위프트 컴파일러는 2단계 초기화를 오류 없이 처리하기 위해 다음과 같은 네 가지 안전확인을 수행합니다.
    1. 자식클래스의 지정 이니셜라이저가 부모클래스의 이니셜라이저를 호출하기 전에 자신의 프로퍼티를 모두 초기화 헀는지
    확인합니다.
    2. 자식 클래스의 지정 이니셜라이저는 상속받은 프로퍼티에 값을 할당하기 전에 반드시 부모클래스의 이니셜라이저를 호출
    해야 합니다. 
    3. 편의 이니셜라이저는 자신의 클래스에 정의된 프로퍼티를 포함하여 그 어떤 프로퍼티라도 값을 할당하기 전에 다른 이니셜라이저
    를 호출해야 합니다.
    4. 초기화 1단계를 마치기 전까지는 이니셜라이저는 인스턴스 메서드를 호출할 수 없습니다. 또, 인스턴스 프로퍼티의 값을 읽어
    들일 수도 없습니다. self 프로퍼티를 자신의 인스턴스를 나타내는 값으로 활용할 수도 없습니다. 
 
    
    클래스의 인스턴스는 초기화 1단계를 마치기 전까지는 아직 유효하지 않습니다. 프로퍼티는 읽기만 가능하며, 메서드는 호출될 
    수 있을 뿐입니다. 클래스의 인스턴스가 초기화 1단계를 마쳤을 때 비로소 유효한 인스턴스가 되는 것입니다.
 */



/// 18-9 Person 클래스를 상속받은 Student 클래스

class Person4 {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

class Student4: Person4 {
    var major: String
    
    init(name: String, age: Int, major: String) {
        self.major = "Swift"
        super.init(name: name, age: age)
        
    }
    
    convenience init(name: String) {
        self.init(name:name, age: 7, major: "")
    }
}

/*
    스위프트는 기본적으로 부모클래스의 이니셜라이저를 상속받지 않습니다.
 */



/// 18-10 클래스 이니셜라이저의 재정의 

class Person5 {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    convenience init(name: String) {
        self.init(name: name, age: 0)
    }
}

class Student5 : Person5 {
    var major: String
    
    override init(name: String, age: Int) {
        self.major = "Swift"
        super.init(name: name, age: age)
    }
    
    convenience init(name: String) {
        self.init(name: name, age: 7)
    }
}



/// 18-11 실패 가능한 이니셜라이저의 재정의

class Person6 {
    var name: String
    var age: Int
    
    init(){
        self.name = "Unkown"
        self.age = 0
    }
    
    init?(name: String, age: Int) {
        if name.isEmpty {
            return nil
        }
        self.name = name
        self.age = age
    }
    
    init?(age: Int) {
        if age < 0 {
            return nil
        }
        
        self.name = "Unknown"
        self.age = age
    }
}

class Student6 : Person6 {
    var major: String
    
    override init?(name: String, age: Int) {
        self.major = "Swift"
        super.init(name: name, age: age)
    }
    
    override init(age: Int) {
        self.major = "Swift"
        super.init()
    }
}



/// 18-12 이니셜라이저 자동 상속

class Person7 {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "Unknown")
    }
}

class Student7 : Person7 {
    var major: String = "Swift"
}

// 부모클래스의 지정 이니셜라이저 자동 상속
let yagom7 : Person7 = Person7(name:"yagom")
let hana: Student7 = Student7(name: "hana")
print(yagom7.name) // yagom
print(hana.name)    // hana

// 부모클래스의 편의 이니셜라이저 자동 상속
let wizplan: Person7 = Person7()
let jinSung: Student7 = Student7()
print(wizplan.name) // Unknown
print(jinSung.name) // Unknown



/// 18-13 편의 이니셜라이저 자동 상속

class Person8 {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "Unknwon")
    }
}

class Student8 : Person8 {
    var major: String
    
    override init(name: String) {
        self.major = "Unknown"
        super.init(name: name)
    }
    
    init(name: String, major: String) {
        self.major = major
        super.init(name: name)
    }
}

// 18-14 편의 이니셜라이저 자동 상속2

class Person9 {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "Unknown")
    }
}

class Student9 : Person9 {
    var major: String
    
    convenience init(major: String) {
        self.init()
        self.major = major
    }
    
    override convenience init(name: String) {
        self.init(name: name, major: "Unknown")
    }
    
    init(name: String, major: String) {
        self.major = major
        super.init(name: name)
    }
}

// 부모클래스의 편의 이니셜라이저 자동 상속
let wizplan1: Person9 = Person9()
let jinSung1: Student9 = Student9(major: "Swift")
print(wizplan.name) // Unknown
print(jinSung.name) // Unknown
print(jinSung.major)    // Swift



/// 18-15 편의 이니셜라이저 자동 상속3

class UniversityStudent2 : Student9 {
    var grade: String = "A+"
    var description: String {
        return "\(self.name) \(self.major) \(self.grade)"
    }
    
    convenience init(name: String, major: String, grade: String) {
        self.init(name: name, major: major)
        self.grade = grade
    }
}

let nova: UniversityStudent2 = UniversityStudent2()
print(nova.description) // Unknown Unkown A+

let raon: UniversityStudent2 = UniversityStudent2(name:"raon")
print(nova.description) // raon Unknown A+

let joker: UniversityStudent2 = UniversityStudent2(name: "joker", major: "Programming")
print(joker.description)    // joker Proframming A+

let chope: UniversityStudent2 = UniversityStudent2(name: "chope", major: "Computer", grade: "C")
print(chope.description)    // chope Computer C



/*
    요구 이니셜라이저
    required 수식어를 클래스의 이니셜라이저 앞에 명시해주면 이 클래스를 상속받은 자신클래스에서 반드시 해당 이니셜라이저를 
    구현해주어야 합니다. 다시 말하면 상속받을 때 반드시 재정의되어야 하는 이니셜라이저 앞에 required 수식어를 붙여줍니다.
    다만, 자식 클래스에소 요구 이니셜라이저를 재정의할 때는 override 수식어 대신에 required 수식어를 사용합니다.
 */

/// 18-16 요구 이니셜라이저 정의

class Person10 {
    var name: String
    
    // 요구 이니셜라이저 정의
    required init() {
        self.name = "Unknown"
    }
}

class Student10: Person10 {
    var major: String = "Unknown"
}

let miJeong: Student10 = Student10()



/// 18-17 요구 이니셜라이저 재구현

class Person11 {
    var name: String
    
    // 요구 이니셜라이저 정의
    required init() {
        self.name = "Unknown"
    }
}

class Student11 : Person11 {
    var major: String = "Unknown"
    
    // 자신의 지정 이니셜라이저 구현
    init(major: String) {
        self.major = major
        super.init()
    }
    
    required init() {
        self.major = "Unknown"
        super.init()
    }
}

class UniversityStudent3: Student11 {
    var grade: String
    
    // 자신의 지정 이니셜라이저 구현
    init(grade: String) {
        self.grade = grade
        super.init()
    }
    
    required init() {
        self.grade = "F"
        super.init()
    }
}

let jiSoo : Student11 = Student11()
print(jiSoo.major)  // Unknown

let yagom4: Student11 = Student11(major: "Swfit")
print(yagom4.major) // Swift

let junhyun: UniversityStudent3 = UniversityStudent3(grade: "A+")
print(junhyun.grade)    // A+



/// 18-18 일반 이니셜라이저의 요구 이니셜라이저 변경

class Person12 {
    var name: String
    
    init() {
        self.name = "Unknown"
    }
}

class Student12 : Person12 {
    var major: String = "Unknown"
    
    init(major: String) {
        self.major = major
        super.init()
    }
    
    // 부모클래스의 이니셜라이저를 재정의함과 동시에 요구 이니셜라이저로 변경됨을 알립니다.
    required override init() {
        self.major = "Unknown"
        super.init()
    }
    
    // 이 요구 이니셜라이저는 앞으로 계속 요구됩니다.
    required convenience init(name: String) {
        self.init()
        self.name = name
    }
}

class UniversityStudent4: Student12 {
    var grade: String
    
    init(grade: String) {
        self.grade = grade
        super.init()
    }
    
    // Student 클래스에서 요구하였으므로 구현해주어야 합니다.
    required init() {
        self.grade = "F"
        super.init()
    }
    
    // Student 클래스에서 요구하였으므로 구현해주어야 합니다.
    required convenience init(name: String) {
        self.init()
        self.name = name
    }
}

let yagom5: UniversityStudent4 = UniversityStudent4()
print(yagom5.grade) // F

let juHyun1: UniversityStudent4 = UniversityStudent4(name: "JuHyun")
print(juHyun1.name) // JuHyun

