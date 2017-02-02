//: Playground - noun: a place where people can play

import UIKit

/// Chapter9 구조체와 클래스 

/*
    구조체는 struct 키워드로 정의합니다.
    구조체는 새로운 타입을 생성해 주는 것과 마찬가지이므로 기본 타입 이름처럼 대문자 카멜케이스를 사용하여
    이름을 지어줍니다. 프로퍼티와 메서드는 소문자 카멜케이스를 사용하여 이름을 지어줍니다.
 
    struct 구조체 이름 {
        프로퍼티와 메서드들
    }
 
 */



/// 9-1 BasicInformation 구조체 정의

/*
struct BasicInformation {
    var name : String
    var age: Int
}
*/


/// 9-2 BasicInformation 구조체의 인스턴스 생성 및 사용

/*
//프로퍼티 이름 (name, age)으로 자동 생성된 이니셜라이져를 사용하여 구조체를 생성합니다.
var yagomInfo: BasicInformation = BasicInformation(name: "yagom", age: 99)
yagomInfo.age = 100 //변경 가능!
yagomInfo.name = "Seba" //변경 가능!

//프로퍼티 이름 (name, age)으로 자동 생성된 이니셜라이져를 사용하여 구조체를 생성합니다.
let jennyInfo: BasicInformation = BasicInformation(name: "Seba", age: 99)
//jennyInfo.age = 100 상수기 때문에 오류 발생
*/


/*
    스위프트의 클래스는 부모클래스가 없더라도 상속 없이 단독으로 정의가 가능합니다. 
    
    클래스를 정의할 때는 class라는 키워드를 사용합니다.
    클래스도 대문자 카멜케이스를 사용합니다.
 
    class 클래스 이름 {
        프로퍼티와 메서드들
    }
 
    : 뒤에 오는 것은 상속 받을 클래스의 이름입니다.
 
    class 클래스 이름 : 부모클래스 이름 {
        프로퍼티와 메서드들
    }
 */



/// 9-3 Person 클래스의 정의 

/*
class Person {
    var height: Float = 0.0
    var weight: Float = 0.0
}
 */

/*
    흔히 클래스의 인스턴스를 객체라고 표현하지만 스위프트 공식문서에는 좀더 한정적인 인스턴스라는 용어를 상요합니다.
    이 책의 초반부에는 다른 프로그래밍 언어를 사용하던 독자를 위해 객체라는 용어를 사용했지만, 
    지금 부터는 인스턴스라는 용어를 사용합니다. 보통 객체지향 프로그래밍 패러다임을 지향하는 언어에서는 클래스와 인스턴스를
    객체라고 통칭합니다.
 */



/// 9-4 Person 클래스의 인스턴스 생성 및 사용

/*
var yagom: Person = Person()
yagom.height = 123.4
yagom.weight = 123.4

let jenny: Person = Person()
jenny.height = 123.4
jenny.weight = 123.4
*/
 
/*
    이니셜라이즈는 objective-c 의 init인 초기화메소드와 비슷한 의미로 추정됨.
 */



/*
 
    클래스의 인스턴스는 참조 타입이므로 더는 참조할 필요가 없을 떄 메모리에서 해제됩니다.
    이 과정을 소멸이라고 칭하는데 소멸되기 직전 deinit라는 메소드가 호출됩니다. 
    deinit메서드를 디이니셜라이저라고 부릅니다. deinit 메서드는 클래스당 하나만 구현할 수 있으며,
    매개변수와 반환 값을 가짌 ㅜ없습니다.
 
 */
 
 
/// 9-5 Person 클래스의 인스턴스 생성 및 소멸

class Person {
    var height: Float = 0.0
    var weight: Float = 0.0

    deinit {
        print("Person 클래스의 인스턴스가 소멸됩니다.")
    }
}

/*
var yagom: Person? = Person()
yagom = nil //Person 클래스의 인스턴스가 소멸됩니다. 
*/
 
/*
    deinit 메소드에는 인스턴스가 메모리에서 해제되기 직전에 처리할 코드를 넣어줍니다.
    예를 들어 인스턴스 소멸 전에 데이터를 저장한다거나 다른 객체에 인스턴스 소멸을 알려야 할 때는 
    특히 deinit 메서드를 구현해야 합니다.
 */



/*
    구조체와 클래스의 차이
 
    같은 점 
 
    값을 저장하기 위해 프로퍼티를 정의할 수 있습니다.
    기능 수행을 위해 메서드를 정의할 수 있습니다.
    서브스크립트 문법을 통해 구조체 또는 크래스가 가지는 값(프로퍼티)에 접근하도록 서브스크립트를 정의할 수 있습니다.
    초기화될 때의 상태를 지정하기 위해 이니셜라이저를 정의할수 있습니다.
    초기구현과 더불어 새로운 기능 추가를 위해 익스텐션을 통해 확장할 수 있습니다.
    특정 기능을 수행하기 위해 특정 프로토콜을 준수할 수 있습니다.
 
    다른 점
 
    구조체는 상속할 수 없습니다.
    타입캐스팅은 클래스의 인스턴스에만 허용됩니다.
    디이니셜라이저는 클래스의 인스턴스에만 활용할 수 있습니다.
    참조 횟수 계산 (Reference Counting)은 클래스의 인스턴스에만 적용됩니다. 
 
    값 타입과 참조타입은 어떤 함수의 전달인자로 데이터를 넘길때 값타입은 복사되어 넘어가고 참조타임은 주소값이 넘어 간다.
 
 */



/// 9-6 값 타입과 참조 타입의 차이


/*
struct BasicInformation {
    let name: String
    var age: Int
}

var yagomInfo:BasicInformation = BasicInformation(name: "yagom", age:99)
yagomInfo.age = 100

var friendInfo: BasicInformation = yagomInfo
//yagomInfo의 값을 복사하여 할당합니다!

print("yagom's age : \(yagomInfo.age)") //100
print("friend's age: \(friendInfo.age)")    //100

friendInfo.age = 999

print("yagom's age: \(yagomInfo.age)")  //100 - yagom의 값은 변동 없습니다.
print("friend's age: \(friendInfo.age)")    //999
//999 - friendInfo는 yagomInfo의 값을 복사해왔기 때문에 별개의 값을 가집니다.

var yagom: Person = Person()

var friend: Person = yagom

print("yagom's height: \(yagom.height)")    //0.0
print("friend's height: \(friend.height)")  //0.0

friend.height = 185.5

print("yagom's height : \(yagom.height)")
//185.5 - friend는 yagom을 참조하기때문에 값이 변동됩니다.
print("friend's height: \(friend.height)")
//185.5 - 이를 통해 yagom이 참조하는 곳과 friend가 참조하는 곳이 같음을 알 수 있습니다.

func changeBasicInfo(_ info: BasicInformation) {
    var copiedInfo: BasicInformation = info
    copiedInfo.age = 1
}

func changePersonInfo(_ info: Person) {
    info.height = 155.3
}

changeBasicInfo(yagomInfo)
print("yagom's age : \(yagomInfo.age)") //100
// chageBasicInfo(_:)로 전달되는
// 전달인자는 값이 복사되어 전달되기 때문에 yagomInfo의 값만 전달되는 것입니다.

changePersonInfo(yagom)
print("yagom's height : \(yagom.height)")   //155.4
// chagePersonInfo(_:)의
// 전달인자로 yagom의 참조가 전달되었기 때문에 yagom이 참조하고 있는 값들의 변화가 생깁니다.
// 값타입의 데이터가 함수의 전달인자로 전달되면 메모리에 전달인자를 위한 인스턴스가 새로 생성됩니다. 

*/



/// 9-7 식별 연산자의 사용

var yagom: Person = Person() //yagom의 참조를 할당합니다.
let friend: Person = yagom  //새로운 인스턴스를 생성합니다.
let anotherFriend: Person = Person()

print(yagom === friend) //true
print(yagom === anotherFriend) //false
print(friend !== anotherFriend) //tre



/// 9-8 스위프트 String 타입의 정의

/*
 
 public struct String {
    ///An empty 'String'
    public init()
 }
 
 스위프트의 기본 데이터 타입은 모두 구조체입니다. 
 기본 데이터는 모두 값타입
 
 
 */



/*
 
    구조체와 클래스 선택해서 사용하기
 
    애플의 가이드 라인의 구조체 사용 권고
 
    연관된 간단한 값의 집합을 캡슐화 하는 것만이 목적일 때
    캡슐화된 값이 참조되는 것보다 복사되는 것이 합당할 때
    구조체에 저장된 프로퍼티가 값 타입이며 참조되는 것보다 복사되는 것이 합당할 때
    다른 타입으로부터 상속받거나 자신이 상속될 필요가 없을 때
 
    구조체로 사용한 예
 
    좌표계 , 물건크기 이런 상황 이외에는 클래스를 사용하는것이 좋다. 
 
    스위프트는 똑똑하게 복사를 처리한다. 스위프트는 꼭 필요한 경우에만 진짜 복사를 한다. 
 
 */





