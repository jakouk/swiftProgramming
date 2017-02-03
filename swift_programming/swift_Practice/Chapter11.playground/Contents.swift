//: Playground - noun: a place where people can play

import UIKit

/// Chapter11 인스턴스 생성 및 소멸 

/*
    초기화 (Initialization)는 클래스나 구조체 또는 열거형의 인스턴스를 사용하기 위한 준비 과정입니다.
    초기화가 완료된 인스턴스는 사용 후 소명 시점이 조면 소멸됩니다.
    이번 장에서는 인스턴스를 생성하는 방법과 클래스의 인스턴스가 소멸될 떄 어떤 프로세스ㅏ 진행되는지 알아보겠습니다.
    (클래스 인스턴스의 소멸 시점은 ARC에서, 클래스의 이니셜라이저와, 이니셜라이저 상속에 관한 부분은 상속에서 자세히 )
 */



/*
    초기화 과정은 새로운 인스턴스가 사용될 준비를 하기 위하여 저장 프로퍼티의 초깃값을 설정하는 등의 일을 수행합니다.
    이니셜라이저를 정의하면 초기화 과정을 직접 구현할 수 있습니다. 그렇게 구현된 이니셜라이저는 새로운 인스턴스를
    생성할 수 있는 특별한 메서드가 됩니다. 스위프트의 이니셜라이저는 반환 값이 없습니다. 이니셜라이저의 역활은 
    그저 인스턴스의 첫 사용을 위해 초기화하는 것 뿐입니다.
 
    이니셜라이저는 func 키워드를 사용하지 않고 오로지 init 키워드를 사용하여 이니셜라이저 메소드임을 표현합니다.
    init 메서드는 클래스, 구조체 열거형 등의 구현부 또는 그 타입의 익스텐션 구현부에 위치합니다. 
    (다만 클래스의 지정 이니셜라이저는 익스텐션에서 구현해 줄 수 없습니다.)
 */

/// 11-1 클래스, 구조체, 열거형의 기본적인 형태의 이니셜라이저

/*
class SomeClass {
    init() {
        // 초기화 시 필요한 코드
    }
}

struct SomeStruct {
    init() {
        // 초기화 시 필요한 코드
    }
}

enum SomeEnum {
    case someCase
    init() {
        // 열거형은 초기화 시 반드시 케이스중 하나가 되어야 합니다.
        self = .someCase
        // 초기화 시 필요한 코드
    }
}
*/


/*
    구조체와 클래스의 인스턴스는 처음 생성될 때 옵셔널 저장 프로퍼티를 제외한 모든 저장 프로퍼티에 적절한 초깃값 
    initial Value를 할당되어야 합니다. 초기화 후에 값이 확정되지 않은 저장 프로퍼티는 존재할 수 없습니다.
    프로퍼티를 정의할 때 프로퍼티 기본값을 할당하면 이니셜라이저에서 따로 초깃값을 할당하지 않더라도 프로퍼티 기본값으로 
    저장 프로퍼티의 값이 초기화 됩니다. 
    
    이니셜라이저를 통해 초깃값을 할당하거나, 프로퍼티 기본값을 통해 처음의 저장 프로퍼티가 초기화될 때에는 프로퍼티
    감시자 메서드가 호출되지 않습니다.
 */

/// 11-2 Area 구조체와 이니셜라이저

/*
struct Area {
    var squareMeter: Double
    
    init() {
        squareMeter = 0.0 // squareMeter의 초깃값 할당
    }
}

let room: Area = Area()
print(room.squareMeter) // 0.0
*/


/// 11-3 프로퍼티 기본값 지정

/*
struct Area {
    var squareMeter: Double = 0.0   // 프로퍼티 기본 값 할당
}

let room: Area = Area()
print(room.squareMeter) // 0.0
*/


/*
    함수나 메서드를 정의할 떄와 마찬가지로 이니셜라이저도 매개변수를 가질수 있습니다.
    즉, 인스터스를 초기화하는 과정에 필요한 값을 전달받을 수 있습니다.
 */

/// 11-4 이니셜라이저 매개변수

struct Area {
    var squareMeter: Double
    
    init(fromPy py: Double) {   // 첫 번째 이니셜라이저
        squareMeter = py * 3.3058
    }
    
    init(fromSquareMeter squareMeter: Double) { // 두 번째 이니셜라이저
        self.squareMeter = squareMeter
    }
    
    init(value: Double) {   // 세 번째 이니셜라이저
        squareMeter = value
    }
    
    init( _ value: Double) {    // 네 번째 이니셜라이저
        squareMeter = value
    }
}

let roomOne: Area = Area(fromPy: 15.0)
print(roomOne.squareMeter)  //49.587

let roomTwo: Area = Area(fromSquareMeter: 33.06)
print(roomTwo.squareMeter)

let roomThree: Area = Area(value: 30.0)
let roomFour: Area = Area(55.0)

//Area()  // 오류 발생!!

/*
    이렇게 사용자 정의 이니셜라이저를 만들면 기존의 기본 이니셜라이저는 별도로 구현하지 않는 이상 사용할수 없습니다.
 */



/// 11-5 Person 클래스

/*
class Person {
    var name: String
    var age: Int?
    
    init(name: String) {
        self.name = name
    }
}

let yagom: Person = Person(name: "yagom")

print(yagom.name)   // "yagom"

print(yagom.age)    // nil

yagom.age = 99

// 옵셔널 바인딩 사용
if let age = yagom.age {
    print(age)
}
print(yagom.age)    // 99

yagom.name = "Eric"

print(yagom.name)   //"Eric"
*/


/*
    상수 프로퍼티는 인스턴스 초기화하는 과정에서만 값이 할당될 수 있습니다.
 */

/// 11-6 상수 프로퍼티의 초기화

/*
class Person {
    let name: String
    var age: Int?
    
    init(name: String) {
        self.name = name
    }
}

let yagom: Person = Person(name: "yagom")
//yagom.name = "Eric"  오류 발생!!
*/


/*
    기본 이니셜라이저와 멤버와이즈 이니셜라이저
 
    구조체는 멤버와이즈 이니셜라이저가 기본으로 제공되지만 클래스는 멤버와이즈 이니셜라이저가 기본적으로 제공되지 않습니다.
 */

/// 11-7 Point 구조체와 Size 구조체의 선언과 멤버와이즈 이니셜라이저의 사용

struct Point {
    var x: Double = 0.0
    var y: Double = 0.0
}

struct Size {
    var width: Double = 0.0
    var height: Double = 0.0
}

let point: Point = Point(x: 0, y: 0)
let size: Size = Size(width: 50.0, height: 50.0)



/*
    초기화 위임
    값 타입인 구조체와 열거형은 코드의 중복을 피하기 위하여 이니셜라이저가 다른 이니셜라이저에게 일부 초기화를 위임하는 초기화
    위임을 간단하게 구현할수 있습니다. 
    값 타입에서 이니셜라이저가 다른 이니셜라이저를 호출 하려면 self.init을 사용합니다. 당연히 self.init은 이니셜라이저
    안에서만 사용할 수 있는데 self.init을 사용한다는 것 자체가 사용자정의 이니셜라이저를 정의하고 있다는 뜻입니다.
    그런데 사용자 정의 이니셜라이저를 정의하면 기본 이니셜라이저와 멤버와이즈 이니셜라이저를 사용할 수 없다고 했습니다.
    따라서 초기화 위임을 하려면 최소 두 개 이상의 사용자정의 이니셜라이저를 정의해야 합니다.
 
    사용자정의 이니셜라이저를 정의할 때에도 기본 이니셜라이저나 멤버와이즈 이니셜라이저를 사용하고 싶다면 익스텐션을 사용하여
    사용자정의 이니셜라이저를 구현하면 됩니다.
 */

/// 11-8 Student 열거형과 초기화 위임

/*
enum Student {
    case elementaty, middle, high
    case none
    
    // 사용자정의 이니셜라이저가 있는 경우, init() 메서드를 구현해주어야 기본 이니셜라이저를 
    // 사용할 수 있습니다.
    init() {
        self = .none
    }
    
    init(koreanAge: Int) {  // 첫 번째 사용자ㅏ정의 이니셜라이저
        switch koreanAge {
        case 8...13:
            self = .elementaty
        case 14...16:
            self = .middle
        case 17...19:
            self = .high
        default:
            self = .none
        }
    }
    
    init(bornAt: Int, currentYear: Int) {   // 두 번째 사용자정의 이니셜라이저
        self.init(koreanAge : currentYear - bornAt + 1)
    }
}

var younger: Student = Student(koreanAge: 16)
print(younger)  // middle

younger = Student(bornAt: 1998, currentYear: 2016)
print(younger)  // high
*/


/*
    실패 가능한 이니셜라이저 
    실패 가능성을 내포한 이니셜라이저를 '실패 가능한 이니셜라이저' 라고 부릅니다.
    실패 가능한 이니셜라이저는 클래스, 구조체, 열거형 등에 모두 정의할 수 있습니다.
    실패 가능한 이니셜라이저는 실패하였을 때 nil을 반환해주므로 반환 타입이 옵셔널로 지정됩니다.
    따라서 실패가능한 이니셜라이저는 init 대신에 init? 키워드를 사용합니다.
 */

/// 11-9 실패 가능한 이니셜라이저

class Person {
    let name: String
    var age: Int?
    
    init?(name: String) {
        
        
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
    
    init?(name: String, age: Int) {
        if name.isEmpty || age < 0 {
            return nil
        }
        self.name = name
        self.age = age
    }
}

let yagom: Person? = Person(name: "yagom", age: 99)

if let person:Person = yagom {
    print(person.name)
} else {
    print("Person wasn't initialized")
}
// yagom

let chope: Person? = Person(name: "chope", age: -10)

if let person: Person = chope {
    print(person.name)
} else {
    print("Person wasn't initialized")
}
// Person wasn't initialized


let eric: Person? = Person(name: "", age: 30)

if let person: Person = eric {
    print(person.name)
} else {
    print("Person wans't initialized")
}
// Person wasn't initialized



/*
    실패 가능 이니셜라이저는 구조체와 클래스에서도 유용하지만 특히 열거형에서 유용하게 사용될 수 있습니다.
    특정 케이스가 맞지 않는 값이 들어보면 생성에 실패할 수 있습니다.
    rawValue로 초기화할 때, 잘못된 rawValue가 전달되어 들어온다면 열거형 인스턴스를 생성하지 못할 수 있습니다.
 */

/// 코드 11-10 열거형의 실패 가능한 이니셜라이저

/*
enum Student : String {
    case elemetary = "초등학생", middle = "중학생", high = "고등학생"
    
    init?(koreanAge: Int) {
        switch koreanAge {
        case 8...13:
            self = .elemetary
        case 14...16:
            self = .middle
        case 17...19:
            self = .high
        default:
            return nil
            
        }
    }
    
    init?(bornAt: Int, currentYear: Int) {
        self.init(koreanAge: currentYear - bornAt + 1)
    }
}

var younger: Student? = Student(koreanAge: 20)
print(younger)  // nil

younger = Student(bornAt: 2020, currentYear: 2016)
print(younger)

younger = Student(rawValue: "대학생")
print(younger)

younger = Student(rawValue: "고등학생")
print(younger)
*/


/*
    함수를 사용한 프로퍼티 기본값 세팅
 
    만약 사용자정의 연산을 통해 저장 프로퍼티 기본값을 설정하고자 한다면 클로저나 함수를 사용하여 프로퍼티 기본값을 제공할 수
    있습니다. 인스턴스가 초기화될 때 함수나 클로저가 호출되면서 연산을 통한 결괏값을 프로퍼티 기본값으로 제공해줍니다.
    그렇기 때문에 클로저나 함수의 반환 타입은 프로퍼티의 타입과 일치해야 합니다. 만약 프로퍼티 기본값을 세팅해주기 위해서
    클로저를 사용한다면 클로저가 실행되는 시점은 이니셜라이즈(초기화)될 때 인스턴스의 다른 프로퍼티의 값이 세팅되기 전이라는 것도
    꼭 명심해야합니다. 즉, 클로저 내부에서는 인스턴스의 다른 프로퍼티를 사용하여 연산할수는 없다는 것입니다. 다른 프로퍼티가 
    기본값을 가지고 있다고 해도 안됩니다. 또한 클로저 내부에서 self 프로퍼티도 사룔할 수 없으며, 인스턴스메서드를 
    호출할수도 없습니다.
 */

/// 11-1 클로저를 통한 프로퍼티 기본값 세팅

class SomeThingClass {
    let someProperty: Int = {
        // 새로운 인스턴스를 생성하고 사용자정의 연산을 통한 후 반환해줍니다.
        // 반환되는 값의 타입은 SomeType과 같은 타입이어야 합니다.
        var age: Int = 1
        return age
    }()
}

/*
    클로저 뒤에 소괄호가 붙은 이유는 클로러가 실행하기 위해서입니다. 클로저 뒤에 소괄호가 붙어 클로저를 실행한 결괏값은
    프로퍼티의 기본값이 됩니다. 만약 소괄호가 없다면 프로퍼티의 기본값은 클로저 그 자체가 됩니다. 우리가 의도했던 것과는 
    전혀 다른 의미가 되는 것이죠
*/



/// 11-12 클로저를 통한 student 프포퍼티 기본값 세팅 

struct Student {
    var name: String?
    var number: Int?
}

class SchoolClass {
    var students: Array<Student> = {
        // 새로운 인스턴스를 생성하고 사용자정의 연산을 통한 후 반환해줍니다.
        // 반환되는 값의 타입은 [Student] 타입이어야 합니다.
        
        var arr: [Student] = Array<Student>()
        
        for num in 1...15 {
            var student: Student = Student(name: nil, number: num)
            arr.append(student)
        }
        return arr
    }()
}

let myClass: SchoolClass = SchoolClass()
print(myClass.students.count)   // 15

/*
    SchoolClass 클래스의 인스턴스를 초기화 하면 student 프로퍼티의 기본값을 제공하기 위해 클로저가 동작하고 
    1번부터 15번까지의 학생을 생성하여 배열에 할당합니다. myClass 인스턴스는 생성되자마자 students 프로퍼에 15명의
    학생을 가지고 있는 상태가 되는 것입니다. 
 
    iOS 에서의 활용
    스위프트 언어와는 크게 관계가 없지만 iOS UI 등을 구성할 때, UI 컴포넌트를 클래스의 프로퍼티로 구현하고,
    UI 컴포넌트의 생성과 동시에 컴포넌트의 프로퍼티를 기본적으로 세팅할 때 유용하게 사용하 수 있습니다.
 */



/*
    인스턴스 소멸
    클래스의 인스턴스는 디이니셜라이저를 구현할 수 있습니다. 디이니셜라이저는 이니셜라이저와 반대 역할을 수행합니다.
    메모리에서 해제되기 직전 클래스 인스턴스와 관련하여 원하는 정리 작없을 구현할 수 있습니다.
 
    디이니셜라이저는 클래스의 인스턴스가 메모리에서 소멸되기 직전에 호출됩니다.
    deinit 키워드를 사용하여 디이니셜라이저를 구현하면 자동으로 호추됩니다. 디이니셜라이저는 킬래스의 인스턴스에만 구현할
    수 있습니다.
    스위프트는 인스턴스가 더이상 필요하지 않으면 자동으로 메모리에서 소멸시킵니다.(ARC) 대부분 인스턴스가 소멸될 때
    디이니셜라이저를 사요해 별도의 메모리 관리 작업을 할 필요가 없습니다. 그얼지만 예를 들어 인스턴스 내부에서 파일을 불러와
    열어보는 등의 외부 리소스를 사용했다면 인스턴스가 소멸되기 직전에 파일을 다시 저장하고 닫아주는 등의 부가작업을 수행해야 
    합니다. 
 
    클래스에는 디이니셜라이저를 단 한나만 구현할 수 있습니다. 디이니셜라이저는 이니셜라이저와는 다르게 매개변수를 가지지 않으며
    소괄호도 적어주지 않습니다. 또 자동으로 호출되기 때무에 별도의 코드로 호출할 수도 업습니다. 
 
    디이니셜라이저는 인스턴스가 소멸되기 직전에 호출되므로 인스턴스의 모든 프로퍼티에 접근할 수 있으며
    (큰 의미는 없을 수도 있지만) 프로퍼티의 값을 변경할 수도 있습니다.
 */

/// 11-13 디이니셜라이저의 구현

class SomeClass {
    deinit {
        print("Instance Will be deallocated immediately")
    }
}

var instance: SomeClass? = SomeClass()
instance = nil  // Instance will be deallocated immediately



/// 11-14 FileManager 클래스의 디이셜라이저 활용

class FileManager {
    var fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func openFile() {
        print("Open File : \(self.fileName)")
    }
    
    func modifyFile() {
        print("Modify File : \(self.fileName)")
    }
    
    func writeFile() {
        print("Write File : \(self.fileName)")
    }
    
    func closeFile() {
        print("Close File : \(self.fileName)")
    }
    
    deinit {
        print("Deinit instance")
        self.writeFile()
        self.closeFile()
    }
}

var fileManager: FileManager? = FileManager(fileName: "abc.txt")

if let manager: FileManager = fileManager {
    manager.openFile()  // Open File : abc.txt
    manager.modifyFile()    // Modify File : abc.txt
}

fileManager = nil

/*
    객체가 사라지기전에 객체의 값들을 deinit을 통해서 미리 저장할수 있을것 같다. 
 */


