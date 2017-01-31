//: Playground - noun: a place where people can play

import UIKit

/// Chapter 4 데이터 타입 고급

/*
    
스위프트는 타입에 굉장이 민감하고 엄격하다.
서로 다른 타입끼리의 데이터 교환은 꼭 타입캐스팅을 거쳐야한다.
엄밀하게 말하면 데이터 교환은 타입캐스팅이 아닌 새로운 인스턴스를 생성하여 할당하는 것이다.

*/



/// 4-1 타입 안심과 타입 추론

// 타입을 지정하기 않았으나 타입 추론을 통하여 name은 String 타입으로 선언됩니다.
var name = "Kwanhee"
//name = 100 앞서 타입 추론에 의해 name은 String 타입의 변수로 지정되었기 때문에 정수를 할당하려고 시도하면 오류 발생



/// 4-2 타입 별칭

/*
 typealias를 사용하여 타입에 별칭을 준다.
 */

typealias MyInt = Int
typealias YourInt = Int
typealias MyDouble = Double

let age: MyInt = 100
var year: YourInt = 2080
year = age

let month: Int = 7

let percentage: MyDouble = 99.9



///4-3 튜플 기본

/*
    튜플은 타입의 이름이 따로 지정되어 있지 않은 프로그래머가 마음대로 만드는 타입이다. 
    ' 지정된 데이터의 묶음 ' 이라고 표현할수 있다.
 */

var person: (String, Int, Double) = ("yagom",100,182.5)
//String, Int, Double 타입을 갖는 튜플

print("이름 : \(person.0), 나이:\(person.1), 신장:\(person.2)")
//인데스를 통해서 값을 빼 올 수 있습니다. 

person.1 = 99
person.2 = 178.5

print("이름 : \(person.0), 나이 : \(person.1), 신장 : \(person.2)")



///4-4 튜플 요소 이름 지정 

/* 
    튜플을 사용하면 간편해 보일수 있지만 추후에 다른 프로그래머들이 코드를 볼때 각 요소가 어떤 의미인지 
    유추하기가 어렵기 때문에 튜플의 요소마다 이름을 붙여 줄수 있다.
 */

var personal:(name: String, age: Int, height : Double) = ("yagom",100,182.5)
// String, Int, Double 타입을 갖는 튜플

print("이름: \(personal.name), 나이: \(personal.age), 신장: \(personal.height)")
//요소 이르을 통해서 값을 빼 올 수 있습니다.

personal.age = 99
personal.2 = 178.5

print("이름: \(personal.0),나이: \(personal.1), 신장: \(personal.2)")
//기존처럼 인덱스를 사용하여 값을 빼 올 수도 잇스빈다.



/// 4-5 튜플 별칭 지정

/*
    같은 모양의 튜플을 사용할때 마다 긴 튜플 타입을 모두 써줘야하는 불편함을 별칭지정으로 해결할수 있다.
    typealians
 */

typealias PersonTuple = (name: String, age: Int, height: Double)

let yagom: PersonTuple = ("yagom", 100, 178.5)
let eric: PersonTuple = ("eric", 150, 183.5)

print("이름: \(yagom.name), 나이: \(yagom.age), 신장: \(yagom.height)")
print("이름: \(eric.name), 나이: \(eric.age), 신장: \(eric.height)")


/// 4-6 배열의 선언과 생성

/* 
    컬렉션 타입 
    컬렉션 타입에는 배열(Array), 딕셔너리(Dictionary), 세트(Set)등이 있다.
 
 */

/*
    배열 
     스위프트의 배열은 연결리스트의 형태를 띄고 있다.
 */

var names: Array<String> = ["yagom", "chulsoo", "younghee", "yagom"]
//대괄호를 사용하여 배열임을 표현합니다.

//var names: [String] = ["yagom", "chulsoo", "younghee","yagom"]
//위의 선언과 동일한 표현입니다.
//[String] 은 Array<String>의 축약 표현입니다.

var emptyArray: [Any] = [Any]() //Any 데이터를 요소로 갖는 빈 배열을 생성합니다.
//var emptyArray: [Any] = Array<Any>()    //위의 선언과 정확히 같은 동작을 하는 코드입니다.
//var emptyArray: [Any] = []
// 배열의 타입을 정확히 명시해줬다면 []만으로도 빈 배열을 생성할 수 있습니다.

print(emptyArray.isEmpty)   //true
print(names.count)  //4



///4-7 배열의 사용

print(names[2]) //younghee
names[2] = "jenny"  //2
print(names[2]) //jenny
//print(names[4]) //인덱스의 범위를 벗어났기 때문에 오류가 발생합니다.

//names[4] = "elsa"   //인덱스의 범위를 벗어났기 때문에 오류가 발생합니다.
names.append("elsa")    //마지막에 elsa가 추가됩니다.
names.append(contentsOf: ["john", "max"])   //마지막에 john과 max가 추가됩니다.
names.insert("happy",at: 2) //인데스가 2에 삽입됩니다.
names.insert(contentsOf: ["jinhee","minsoo"], at: 5)    //인덱스 5의 위치에 jinhee와 minsoo가 삽입됩니다.

print(names[4]) //yagom

print(names.index(of: "yagom"))
print(names.index(of: "christal"))

print(names.first)
print(names.last)

let firstItem: String = names.removeFirst()
let lastItem: String = names.removeLast()
let indexZeroItem: String = names.remove(at: 0)

print(firstItem)
print(lastItem)
print(indexZeroItem)
print(names[1 ... 3])



///4-8  딕셔너리의 선언과 생성

typealias StringIntDictionary = [String: Int]
//typealias를 통해 조금 더 단순하게 표현해볼 수도 있습니다.

//키는 String, 값은 Int 타입인 빈 딕셔너리를 생성합니다.
//var numberForName: Dictionary<String, Int> = Dictionary<String, Int>()

//var numberForName: [String: Int] = [String: Int]()  //위의 선언과 정확히 동일한 표현힙니다.
// [String: Int]는 Dictionary<String, Int>의 축약 표현입니다.

//var numberForName: StringIntDictionary = StringIntDictionary()
//위의 코드와 같은 동작을 합니다.

//딕셔너리의 키와 값 타입을 정확히 명시해줬다면 [:]만으로도 빈 딕셔너리를 생성할 수 있습니다.
//var numberForName: [String: Int] = [:]

var numberForName: [String: Int] = ["yagom":100, "chulsoo":200, "jenny":300]
//초깃값을 주어 생성해줄 수도 있습니다.

print(numberForName.isEmpty)    //false
print(numberForName.count)  //3



///4-9 딕셔너리의 사용

print(numberForName["chulsoo"]) //200
print(numberForName["minji"])   //nil

numberForName["chulsoo"] = 150

print(numberForName["chulsoo"]) //150

numberForName["max"] = 999

print(numberForName["max"]) //999

print(numberForName.removeValue(forKey: "yagom"))   //  100
print(numberForName.removeValue(forKey: "yagom"))
// 위에서 yagom 키에 해당하는 값이 이미 삭제되었으므로 nil이 반환됩니다.



///4-10 세트의 선언과 생성

/*
    세트는 같은 타입의 데이터를 순서 없이 하나의 묶음으로 저장하는 형태의 컬렉션 타입입니다.
    순서가 중요하지 않거나 각 요소가 유일한 값을 가져야 하는 경우
 */


//var named: Set<String> = Set<String>()    //빈 세트 생성
// var named: Set<String> = [] //빈 세트 생성

var named: Set<String> = ["yagom", "chulsoo", "younghee", "yagom"]
// Array와 마찬가지로 대괄호를 상요하빈다. 

var numbers = [100,200,300]
//그렇기 때문에 타입 추론을 사용하게 되면 컴파일러는 Set가 아닌 Array로 타입을 지정합니다.
print(type(of: numbers))    //Array<Int>

print(named.isEmpty)    //false
print(named.count)  // 3 - 중복된 값은 허용되지 않아 yagom은 1개만 남습니다. 



///4-11 세트의 사용

print(named.count)
named.insert("jenny")
print(named.count)

print(named.remove("chulsoo"))  //chulsoo
print(named.remove("john")) //nil



///4-12 세트의 활용 - 집합 연산

let englishClassStudents: Set<String> = ["john","chulsoo","yagom",]
let koreanClassStrudents: Set<String> = ["jenny","yagom","chulsoo","hana","minisoo"]

let instersecSet: Set<String> = englishClassStudents.intersection(koreanClassStrudents)
//교집합 {"yagom","chulsoo"}

let symmetricDiffSet: Set<String> = englishClassStudents.symmetricDifference(koreanClassStrudents)
//여집합 의 합(배타적 논리합) {"john", "jenny", "hana", minsoo"}

let unionSet: Set<String> = englishClassStudents.union(koreanClassStrudents)
//합집합 {"minsoo", "jenny", "john", "yagom", "chulss", "hana"}

let subtractSet: Set<String> = englishClassStudents.subtracting(koreanClassStrudents)
//차집합 {"john"}

print(unionSet.sorted())    //["chulsoo", "hana", "jenny", "john", "minsoo", "yagom"]



///4-13 서트의 활용 - 포함 관계연산 

let 새: Set<String> = ["비둘기", "닭", "기러기"]
let 포유류: Set<String> = ["사자","호랑이","곰"]
let 동물: Set<String> = 새.union(포유류)    //새와 포유류의 합집합

print(새.isDisjoint(with: 포유류))  //서로 배타적인지 - true
print(새.isSubset(of: 동물))   //새가 동물의 부분집합인가요? -true
print(동물.isSuperset(of: 포유류))   //동물은 포유류의 전체집합인가요? -true
print(동물.isSuperset(of: 새)) //동물은 새의 전체집합인가요? - true



///4-14 School 열거형의 선언

/*
 
 열거형
  제한된 선택지를 주고 싶을 때
  정해진 값 외에는 입력박고 싶지 않을 때
  예상된 입력값이 한정되어 있을 때
 
 연관값이며, 열거형의 데이터 타입은 각각의 타입이다 ( 정수가 아니다 )
 
 */

/*
enum School {
    case primary    //유치원
    case elementary //초등
    case middle     //중등
    case high       //고등
    case college    //대학
    case university //대학교
    case graduate   //대학원
}
*/



///4-15 School 열거형의 선언 

/*
enum School {
    case primary, elemetary, middle, high, college, university, graduate
}
*/



///4-16 School 열거형 변수의 생성 및 값 변경

//var highestEducationLevel: School = School.university
//var highestEducationLevel: School = .university

//highestEducationLevel = .graduate
//같은 타입인 School 내부의 항목으로만 highestEducationLevel의 값을 변경해줄 수 있습니다.



///4-17 열거형의 원시 값 지정과 사용

/*
 원시값도 가질수 있다 ( 원시값 이란 정수, 실수, 문자등의 타입 )
 열거형이 원시값을 가지게 되면 rawValue라는 프로퍼티를 통해 가져올 수 있습니다.
 */

/*
enum School : String {
    case primary =  "유치원"
    case elementaty = "초등학교"
    case middle = "중학교"
    case high = "고등학교"
    case college = "대학"
    case university = "대학교"
    case graduate = "대학원"
}

let highestEducationLevel: School = School.university

print("저의 최종 학력은 \(highestEducationLevel.rawValue) 졸업입니다.")
//저의 최종 학력은 대학교 졸업입니다.
*/

enum WeekDays: Character {
    case mon = "월", tue = "화", wed = "수", thu = "목", fri = "금", sat = "토",
    sun = "일"
}

let today: WeekDays = WeekDays.fri
print("오늘은\(today.rawValue)요일입니다.") //오늘은 금요일입니다.



///4-18 열거형의 원시 값 일부 지정 밀 자동 처리

enum School: String {
    case primary = "유치원"
    case elemetary = "초등학교"
    case middle = "중학교"
    case high = "고등학교"
    case college
    case university
    case graduate
}

let highestEducationLevel: School = School.university

//print("저의 최종학력은 \(highestEducationLevel.rawValue) 졸업입니다")
//저의 최종학력은 university 졸업입니다.
print(School.elemetary.rawValue)    //초등학교

print(School.college.rawValue)  //그냥 이름 그대로 들어간다.
print(type(of:School.college.rawValue)) //School의 타입으로 들어간다.

enum Numbers: Int{
    case zero
    case one
    case two
    case ten = 10
}

print("\(Numbers.zero.rawValue), \(Numbers.one.rawValue), \(Numbers.two.rawValue), \(Numbers.ten.rawValue)") // 0, 1, 2, 10



///4-19 연관 값을 가지는 열거형

/*
 열거형이 원시 값을 갖는 열거형일 때, 열거형의 원시 값 정보를 알고 있다면 원시 값을 통해 
 열거형 변수 또는 상수를 생성해줄 수도 있습니다. 만약 올바르지 않은 원시 값을 통해 
 생성하려고 한다면 nil을 반환합니다. 이는 실패 가능한 이니셜라이져 기능입니다.
 
 let primary = School(rawValue: "유치원") 의 의미는 rawValue중 유치원이라는 단어인 primary를 찾은 것이다.
 */

let primary = School(rawValue: "유치원")   //primary
let graduate = School(rawValue: "석박사")  //nil

let one = Numbers(rawValue: 1)  //one
let three = Numbers(rawValue: 3)    //nil

print(primary)



///4-20 연관 값을 가지는 열거형

/*
 열거형 내의 항목(case)이 자신과 연관된 값을 가질 수 있습니다. 연관값은 각 항목 옆에 소괄호로 묶어 표현할 수 있습니다.
 다른 항목이 연관 값을 가진다고 모든 항목이 연관 값을 가질 필요는 없습니다.
 */

/*
enum MainDish {
    case pasta(tasete: String)
    case pizza(dough: String, topping: String)
    case chicken(withSauce: Bool)
    case rice
}

var dinner: MainDish = MainDish.pasta(tasete: "크림") //크림파스타
dinner = .pizza(dough: "치즈크러스트", topping: "불로기")    //불고기 치즈크러스트 피자
dinner = .chicken(withSauce: true)
dinner = .rice  //밥
*/


///4-21 여러 열거형의 응용

/*
 여러 열거형을 사용하여서 열거형의 열거형으로 묶을수 있다.
 */

enum PastaTaste {
    case cream, tomato
}

enum PizzaDough {
    case cheesCrust, thin, original
}

enum PizzaTopping {
    case peperoni, cheese, bacon
}

enum MainDish {
    case pasta(taste: PastaTaste)
    case pizza(dough: PizzaDough, topping : PizzaTopping)
    case chicken(withSauce: Bool)
    case rice
}

var dinner: MainDish = MainDish.pasta(taste: PastaTaste.tomato)
dinner = MainDish.pizza(dough: PizzaDough.cheesCrust, topping: PizzaTopping.bacon)



///4-22 특정 항목에 순환 열거형 항목 명시

/*
    순환 열거형은 열거형 항목의 연관 값이 열거형 자신의 값이고자 할 때 사용합니다. 순환 열거형을 명시하고 싶다면
    indirect 키워드를 사용하면 됩니다. 특정 항목에만 한정하고 싶다면 case 키워드 앞에 indirect를 붙이면 되고,
    열거형 전체에 적용하고 싶다면 enum 키워 앞에 indirect 키워드를 붙이면 됩니다.
 
    열거형이 자기자신일때 사용함 School 열거형을 School 안의 case 값으로 School을 사용함.
 */

/*
enum ArithmeticExperssion {
    case number(Int)
    indirect case additon(ArithmeticExperssion, ArithmeticExperssion)
    indirect case multiplication(ArithmeticExperssion, ArithmeticExperssion)
}
*/


///4-23 열거형 전체에 순환 열거형 명시

indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression,ArithmeticExpression)
    case multiplication(ArithmeticExpression,ArithmeticExpression)
}



///4-24 순환 열거형의 사용

/*
    evaluate는 ArithmeticExpression의 계산을 도와주는 순환 함수(Recursive Function)
 */

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let final = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate( _ expression: ArithmeticExpression) -> Int {
    switch expression {
        case .number(let value):
        return value
    case .addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}

let result: Int = evaluate(final)
print("(5 + 4) * 2 = \(result)")

/*
    indirect 키워드는 [코드 4-24]의 예제뿐만 아니라, 이진 탐색 트리 등의 
    순환 알고리즘을 사용할 때 유용하게 사용할 수 있습니다.
 */



