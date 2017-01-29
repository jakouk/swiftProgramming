
/// Chap 3 데이터 타입 기본


/**
 swift의 모든 기본 타입은 구조체로 만들어졌다.
 익스텐션과 제네릭을 두루 사용하여 구현됨.
 */


/// 3-1 Int 와 UInt

/**
 
 Int 와 UInt는 서로 다른 타입니다.
 
 */


var integer: Int = -10
let unsignedinteger: UInt = 50
print("integer 값 : \(integer), unsignedInteger 값 : \(unsignedinteger)")
print("Int 최대값 : \(Int.max), Int 최소값 : \(Int.min)")
print("UInt : 최대값 : \(UInt.max), UInt 최소값 : \(UInt.min)")

let largeInteger: Int64 = Int64.max
let smallUnsignedInteger: UInt8 = UInt8.max
print("Int64 최대값 : \(largeInteger), UInt8 최대값: \(smallUnsignedInteger)")

// let tooLarge: Int = Int.max + 1  최대값 초과
//let cannotBeNegetive :UInt = -5  -값 할당 못함

// integer = unsignedintegerinteger  Int와 UInt는 다른 타입임
integer = Int(unsignedinteger)



/// 3-2 진수별 정수 표현

/**
 
 2진수는 0b
 8진수는 0o
 16진수는 0x
 
 */

let decimalInteger: Int = 28
let binaryInteger: Int = 0b11100   //2진수로 10 진수 28을 표현
let octalInteger: Int = 0o34    //8진수로 10진수 28을 표현
let hexadecimalinteger: Int = 0x1C  //16진수로 10진수 28을 표현



///3-3 Bool

/**
 swift의 Bool 타입은 true , false
 Objective-c 의 BOOL 타입은 YES, NO
 */

let boolean: Bool = true
let iLoveYou: Bool = true
let isTimeUnlimited: Bool = false
print("시간은 무한합니까 ? : \(isTimeUnlimited)")



///3-4 Float과 Double

/**
 Float은 32비트  Double은 64비트
 */

var floatValue: Float = 1234567890.1    //자신이 수용할수 있는 범위가 넘어서서 정확도가 떨어짐
let doubleValue: Double = 1234567890.1 // Double은 충분히 수용할 수 있습니다.

print("floatVlaue : \(floatValue) double : \(doubleValue)")

floatValue = 123456.1   //Float이 수용할수 있는 범위의 수로 변경합니다.

print(floatValue)   //문자열 보간법을 사용하지 않고, 단순히 변수 또는 상수의 값만 보고 싶으면 print함수의 전달인자로 변수 또는 상수를 전달하면 됩니다.



/// 3-5 Character

/**
 Character는 1글자 단위이다.
 유니코드 기반이기 때문에 변수명의 한글도 허용된다.
 */

let alphabetA: Character = "A"
print(alphabetA)

let commandCharacter: Character = "H"   //Character 값에 유니코드 문자를 사용할 수 있습닏.
print(commandCharacter)

let 한글변수이름: Character = "ㄱ"
//  한글도 유니코드 무자에 속해 있으므로 스위프트 코드에 변수 이름으로 사용할 수 있습니다.
print("한글의 첫 자음 : \(한글변수이름)")



/// 3-6 String


let name: String = "jakouk" //상수로 선언된 문자열은 변경이 불가능합니다.

//이니셜라이저를 사용하여 빈 문자열을 생성할 수 있습니다.
//var 키워드를 사용하여 변수를 생성하였으므로 문자열의 수정 및 변경이 가능합니다.
var introduce: String = String()

introduce.append("제 이름은")   // append() 메서드를 사용하여 문자열을 이어붙일 수 있습니다.
introduce = introduce + " " + name + "입니다."
// + 연산자를 통해서도 문자열을 이어붙일 수 있습니다.

print(introduce)

print("name의 Character 갯수 : \(name.characters.count)")
//name에 해당하는 문자의 수를 셀 수 있습니다.
print("introduce가 비어있습니까? : \(introduce.isEmpty)")
//빈 문자열인지 확인해볼 수 있습니다.
let unicodeScalarValue: String = "\u{2556}"
//유니코드의 스칼라 값을 사용하면 값에 해당하는 표현이 출력됩니다.( ㄱ )



/// 3 -7 String 타입의 다양한 기능

// 연산자를 통한 문자열 결합

let hello: String = "Hello"
let yagom: String = "yagom"
var greeting: String = "hello" + " " + "yagom" + "!"
print(greeting) //Hello yagom!

greeting = hello
greeting += " "
greeting += yagom
greeting += "!"
print(greeting) //Hello jakouk!


//연산자를 통한 문자열 비교
var isSameString: Bool = false

isSameString = hello == "Hello"
print(isSameString) //true

isSameString = hello == "hello"
print(isSameString)

isSameString = yagom == "yagom"
print(isSameString)

isSameString = yagom == "hello"
print(isSameString)


// 메서드를 통한 접두어, 접미어 확인
var hasPrefix: Bool = false

//hello = Hello

hasPrefix = hello.hasPrefix("He")
print(hasPrefix)


hasPrefix = hello.hasPrefix("HE")
print(hasPrefix)

hasPrefix = greeting.hasPrefix("Hello ")
print(hasPrefix)

hasPrefix = yagom.hasPrefix("gom")
print(hasPrefix)

hasPrefix = hello.hasPrefix("Hello")
print(hasPrefix)

var hasSuffix: Bool = false
hasSuffix = hello.hasSuffix("HE")
print(hasSuffix)

hasSuffix = hello.hasSuffix("llo")
print(hasSuffix)

hasSuffix = greeting.hasSuffix("yagom")
print(hasSuffix)

hasSuffix = greeting.hasSuffix("yagom!")
print(hasSuffix)

hasSuffix = yagom.hasSuffix("gom")
print(hasSuffix)


//메서드를 통한 대소문자 변환
var convertedString: String = ""
convertedString = hello.uppercased()
print(convertedString)

convertedString = hello.lowercased()
print(convertedString)

convertedString = yagom.uppercased()
print(convertedString)

convertedString = greeting.uppercased()
print(convertedString)

convertedString = greeting.lowercased()
print(convertedString)


// 프로퍼티를 통한 빈 문자열 확인
var isEmptyString: Bool = false
isEmptyString = greeting.isEmpty
print(isEmptyString)

greeting = "안녕"
isEmptyString = greeting.isEmpty
print(isEmptyString)

greeting = ""
isEmptyString = greeting.isEmpty
print(isEmptyString)


/// 3-8 문자열 내 특수 문자 사용

/**
 
 \n 줄바꿈 문자
 \\ 문자열 내에서 백슬래시를 표현하고자 할 때 사용
 \" 문자열 내에서 큰따옴표를 표현하고자 할 때 사용
 \t 탭 문자, 키보드의 탭키를 눌렀을 때와 같은 효과
 \o 문자열이 끝났음을 알리는 null 문자
 
 */

print("문자열 내부에\n 이런 \"특수문자\"를 \t사용하면 \\이런 놀라운 결과를 볼 수 있습니다.")

///3-9 Any

/**
 
 Any 는 모든 데이터 타입
 AnyObject 는 모든 클래스의 인스턴스
 
 */

var someVar: Any = "yagom"
someVar = 50
someVar = 100.1


