//: Playground - noun: a place where people can play

import UIKit

///Chapter 10. 프로퍼티와 메서드


/*
    프로퍼티는 클래스, 구조체 또는 열거형 등에 관련된 값을 뜻합니다.
    메서드는 특정 타입에 관련된 함수를 뜻합니다.
 
    프로퍼티
 
    프로퍼티는 크게 '저장 프로퍼티' , '연산 프로퍼티', '타입 프로퍼티' 로 나눌수 있습니다.
    
    저장 프로퍼티 : 인스턴의 변수 또는 상수를 의미합니다.
    연산 프로퍼티 : 값을 저장한 것이 아니라 특정 연산을 수행한 결과값을 의미합니다. 
 
    저장 프로퍼티는 구조체와 클래스에서만 사용할수 있습니다. 저장 프로퍼티와 연산 프로퍼티는 특정 타입의 인스턴스에 
    사용되는 것을 뜻하지만 특정 타입에 사용되는 프로퍼티도 존재하는 합니다.
 
    타입 프로퍼티 : 특정 타입에 사용되는 프로퍼티
 
    프로퍼티 감시자 (property Observers) : 프로퍼티의 값이 변할 때 값의 변화에 따른 특정 액션을 수햅합니다.
    프로퍼티 감시자는 저장 프로퍼티에 적용할 수 있으며 부모클래스로부터 상속 받을수 있습니다.
 
 
 */



/// 10-1 저장 프로퍼티의 선언 및 인스턴스 생성

/*
//좌표
struct CoordinatePoint {
    var x: Int  //저장 프로퍼티
    var y: Int  //저장 프로퍼티
}

//  구조체는 기본적으로 저장 프로퍼티를 매개변수로 가지는 이니셜라이저가 있습니다.
let yagomPoint: CoordinatePoint = CoordinatePoint(x: 10, y: 5)

// 사람의 위치정보

class Position {
    var point: CoordinatePoint
    // 저장 프로퍼티(변수) - 위치(point)는 변경될 수 있음을 뜻합니다.
    let name: String    // 저장 프로퍼티 (상수)
    
    //  프로퍼티 기본값을 지정해주지 않는다면 이니결라이저를 따로 정의해주어야 합니다.
    init(name: String, currentPoint: CoordinatePoint) {
        self.name = name
        self.point = currentPoint
    }
}

// 사용자 정의 이니셜라이저를 호출해야만 합니다.
//그렇지 않으면 프로퍼티 초깃값을 할당할 수 없기 때문에 인스턴스 생성이 불가능 합니다.
let yagomPosition: Position = Position(name: "yagom", currentPoint: yagomPoint)
*/

/*
    구조체는 기본적으로 이니셜라이저가 존재하지만 클래스는 초깃값을 설정해 주지 않으면 이니셜라이저를 만들어야 한다. 
    물론 초깃값을 지정해 주면 이니셜라이져를 만들어주지 않아도 된다.
 */



/// 10-2 저장 프로퍼티의 초깃값 지정

/*
//좌표
struct CoordinatePoint {
    var x: Int = 0  //저장 프로퍼티
    var y: Int = 0  //저장 프로퍼티
}

//프로퍼티의 초깃값을 할당했다면 굳이 전달인자로 초깃값을 넘길 필요가 없습니다.
let yagomPoint: CoordinatePoint = CoordinatePoint()
//물론 기존에 초깃값을 할당할 수 있는 이니셜라이저도 사용 가능합니다.
let wizplanPoint: CoordinatePoint = CoordinatePoint(x: 10, y: 5)

print("yagom's point : \(yagomPoint.x), \(yagomPoint.y)")
// yagom's point : 0, 0

print("wizplanPoint's point : \(wizplanPoint.x), \(wizplanPoint.y)")
// wizplan's point : 10, 5

// 사람의 위치정보
class Position {
    var point: CoordinatePoint = CoordinatePoint()  //저장 프로퍼티
    var name: String = "Unknown"
}

//초깃값을 지정해 줬다면 사용자 정의 이니셜라이저를 사용하지 않아도 됩니다.
let yagomPosition: Position = Position()

yagomPosition.point = yagomPoint
yagomPosition.name = "yagom"
*/


/*
    저장 프로퍼티가 옵셔널값이면 굳이 이니셜라이저로 프로퍼티에 값을 할당하지 않아도 됩니다.
 */



/// 10-3 옵셔널 저장 프로퍼티

/*
//좌표
struct CoordinatePoint {
    // 위치는 x, y 값을 모두 가져야 하므로 옵셔널이면 안됩니다.
    var x: Int
    var y: Int
}

// 사람의 위치정보
class Position {
    var point: CoordinatePoint?
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

// 이름은 필수지만 위치는 모를 수 있습니다.
let yagomPosition: Position = Position(name: "yagom")

// 위치를 알게되면 그 때 위치 값을 할당해 줍니다.
yagomPosition.point = CoordinatePoint(x: 20, y: 100)
*/


/*
    지연 저장 프로퍼티 
 
    지연 저장 프로퍼티는 굳이 모든 저장 프로퍼티가 사용할 필요가 없을때 많이 사용됩니다.
    필요한 프로퍼티만 생성될때 만들어주고 싶은 경우 지연 저장 프로퍼티를 사용할 수 있다.
    지연 저장 프로퍼티를 사용하면 모든 프로퍼티를 초기화해 줄 필요가 없기 때문에 불필요한 성능저하나 공간낭비를 
    줄일수 있습니다.
 */

/// 10-4 지연 저장 프로퍼티

/*
struct CoordinatePoint {
    var x: Int = 0
    var y: Int = 0
}

class Position {
    lazy var point: CoordinatePoint = CoordinatePoint()
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

let yagomPosition: Position = Position(name: "yagom")

// 이 코드를 통해 point 프로퍼티로 처음 접근할 때 point 프러퍼티의 CoordinatePoint가 생성 됩니다.
print(yagomPosition.point)  // x: 0, y: 0
 */

/*
    다중 스레드 환경에서 지연 저장 프로퍼티에 동시다발적으로 접근할 때에는 한 번만 
    이니셜라이즈된다는 보장은 없습니다. 생성되지 않은 지연 저장 프로퍼티에 비슷한 시점에 많은 스레드가 
    접근한다면, 여러 번 이니셜라이즈될 수 있습니다.
*/



/*
    연산 프로퍼티
 
     연산 프로퍼티는 실제 값을 저장하는 프로퍼티가 아니라, 특정 상태에 따른 값을 연산하는 프로퍼티입니다.
    인스턴스 내/외부의 값을 연산항 적절한 값을 돌려주는 접근자 getter의 역할이나 은닉화된 내부의 프로퍼티 값을 
    간접적으로 설정하는 설정자 setter의 역할을 수행할 수도 있습니다. 
     클래스, 구조체, 열거형에 연산 프로퍼티를 정의할 수 있습니다. 
    '굳이 메서드를 두고 왜 연산 프로퍼티를 쓸까?'라는 생각이 들 수도 있습니다. 그 이유를 생각해보겠습니다.
    인스턴스 외붸서 메서드를 통해 인스턴스 내부 값에 접근하려면 메서드를 두개( 접근자, 설정자 ) 구현해야 합니다.
    또한, 이를 감수하고 메서드로 구현한다 해도 두 메서드가 분산되어 코드의 가독성이 떨어질 위험이 있습니다.
    게다가 프로그래머의 입장에서 보자면 프로퍼티가 메서드 형식보다 훨씬 더 간편하고 직관적입니다.
 
    다만 연산 프로퍼티는 접근자인 get 메서드만 구현해둔 것 처럼 읽기 전용으로 구현하기 쉽지만, 쓰기 전용은 구현할수
    없다는 단점이 있습니다. 메서드로는 설정자 메서드만 구현해여 쓰기 전용을 구현할수 있지만 연산 프로퍼티는 그것이 
    불가능 합니다.
 
 */

/// 10-5 메서드로 구현된 접근자와 설정자 

/*
struct CoordinatePoint {
    var x: Int //저장 프로퍼티
    var y: Int //저장 프로퍼티


    // 대칭점을 구하는 메서드 - 접근자
    func oppositePoint() -> CoordinatePoint {
        return CoordinatePoint(x: -x, y: -y)
    }
    
    // 대칭점을 설정하는 메서드 - 설정자
    // mutating 키워드레 관한 내용은 메서드에서 다룹니다.
    mutating func setOppositePoint(_ oppsite: CoordinatePoint) {
        x = -oppsite.x
        y = -oppsite.y
    }
}

var yagomPosition: CoordinatePoint = CoordinatePoint(x: 10, y: 20)

// 현재 좌표
print(yagomPosition)    // 10, 20

// 대칭 좌표
print(yagomPosition.oppositePoint())    // -10, -20

// 대칭 좌표를 (15, 10)으로 설정하면
yagomPosition.setOppositePoint(CoordinatePoint(x: 15, y: 10))

// 현재 좌표는 -15, -10으로 설정 됩니다.
print(yagomPosition)    // -15, -10
 
*/
// oppositePoint() 메서드로 대칭점을 구할수 있으며, setOppositePoint(_:)로 메서드로 대칭점을 설정해 줘야 합니다.



/// 10-6 연산 프로퍼티의 정의와 사용

/*
struct CoordinatePoint {
    var x: Int  // 저장 프로퍼티
    var y: Int  // 저장 프로퍼티
    
    // 대칭 좌표
    var oppositePoint: CoordinatePoint {    //연산 프로퍼티
        // 접근자
        get {
            return CoordinatePoint(x: -x, y: -y)
        }
        
        //설정자
        set(opposite) {
            x = -opposite.x
            y = -opposite.y
        }
    }
}

var yagomPosition: CoordinatePoint = CoordinatePoint(x: 10, y: 20)

// 현재 좌표
print(yagomPosition)    // 10,20

// 대칭 좌효
print(yagomPosition.oppositePoint)  // -10, -20

// 대칭 좌표를 (15, 20)으로 설정하면
yagomPosition.oppositePoint = CoordinatePoint(x: 15, y: 10)

// 현재 좌표는 -15, -20 으로 설정 됩니다. 
print(yagomPosition)
 
*/

/*
    이런 식으로 연산 프로퍼티를 사용하면 하나의 프로퍼티에 접근자와 설정자가 모두 모여있고,
    해당 프로퍼티가 어떤 역할을 하는지 좀 더 명확하게 표현 가능합니다. 인스턴스를 사용하는 입장에서도
    마치 저장 프로퍼티인 것처럼 편하게 사용할 수 있습니다.
 */



/// 10-7 매개변수 이름을 생략한 설정자 

/*
struct CoordinatePoint {
    var x: Int // 저장 프로퍼티
    var y: Int // 저장 프로퍼티
    
    // 대칭 좌표
    var oppositePoint: CoordinatePoint {    // 연산 프로퍼티
        // 접근자
        get {
            return CoordinatePoint(x: -x, y: -y)
        }
        
        // 설정자
        set {
            x = -newValue.x
            y = -newValue.y
        }
    }
}
*/



/// 10-8 읽기 전용 연산 프로퍼티

struct CoordinatePoint {
    var x: Int  // 저장 프로퍼티
    var y: Int  // 저장 프로퍼티
    
    // 대칭 좌표 
    var oppositePoint: CoordinatePoint {
        // 접근자
        get {
            return CoordinatePoint(x: -x, y: -y)
        }
    }
}

var yagomPosition: CoordinatePoint = CoordinatePoint(x: 10, y: 20)

// 현재 좌표
print(yagomPosition)    // 10, 20

// 대칭 좌표
print(yagomPosition.oppositePoint)  // -10, -20

// 설정자를 구현하지 않았으므로 오류!!
//yagomPosition.oppositePoint = CoordinatePoint(x: 15, y: 10)



/*
    프로퍼티 감시자를 사용하면 프로퍼티의 값이 변경됨에 따라 적절한 액션을 취할 수 있습니다.
    변경되는 값이 현재의 값과 같더라도 호출됩니다.
    프로퍼티 감시자는 지연 저장 프로퍼티에는 사용할수 없으며 오로지 일단 저장 프로퍼티에만 적용할 수 있습니다.
    또한 프로퍼티 재정의를 통해 상속된 저장 프로퍼티 또는 연산 프로퍼티에도 적용이 가능합니다.
 
    물론 상속되지 않은 연산 프로퍼티에는 프로퍼티 감시자를 할 필요가 없으며 할 수도 없습니다. 
    연산 프로퍼티의 점근자와 설정자를 통해 프로퍼티 감시자를 구현할 수 있기 때문입니다. 
    연산 프로퍼티는 상속받았을 때에만 프로퍼티 재정의를 통해 프로퍼티 감시자를 사용합니다. 
 
    프로퍼티 감시자에는 프로퍼티의 값이 변경되기 직전에 호출되는 willSet 메서드와 프로퍼티의 값이 변경된 직후에 호출되는
    didSet 메서드가 있습니다. 
    
    willSet 메서드와 didSet 메서드에는 매개변수가 하나씩 있습니다. 
    wilSet 메서드에서 전달되는 전달인자는 프로퍼티가 변경될 값
    didSet 메서드에서 전달되는 전달인자는 프로퍼티가 변경되지 전의 값입니다.
 
    그래서 매개변수의 이름을 따로 지정해 주지 않으면 willSet 메서드는 newValue가, didSet 메서드는 oldValue가 
    자동으로 지정됩니다.
 */

/// 10-9 프로퍼티 감시자

/*
class Accout {
    var credit: Int = 0 {
        willSet {
            print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다.")
        }
        didSet {
            print("잔액이 \(oldValue)원에서 \(credit)원으로 변경되었습니다.")
        }
    }
}

let myAccout: Accout = Accout()
// 잔액이 0원에서 1000원으로 변경될 예정입니다.

myAccout.credit = 1000
// 잔액이 0 원에서 1000원으로 변경되었습니다.
*/


/// 10-10 상속받은 연산 프로퍼티의 프로퍼티 감시자 구현

/*
class Accout {
    var credit: Int = 0 {   // 저장 프로퍼티
        willSet {
            print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다.")
        }
        didSet {
            print("잔액이 \(oldValue)원에서 \(credit)원으로 변경되었습니다.")
        }
    }
    
    var dollarValue: Double {   // 연산 프로퍼티
        get {
            return Double(credit) / 1000.0
        }
        
        set {
            credit = Int(newValue * 1000)
            print("잔액을 \(newValue)달러로 변경 중입니다.")
        }
    }
}

class ForeignAccout: Accout {
    // 재정의 dollarValue를
    override var dollarValue: Double {
        willSet {
            print("잔액이 \(dollarValue)달러에서 \(newValue)달러로 변경될 예정입니다.")
        }
        didSet {
            print("잔액이 \(oldValue)달러에서 \(dollarValue)달러로 변경되었습니다.")
        }
    }
}

let myAccout : ForeignAccout = ForeignAccout()
//잔액이 0원에서 1000원으로 변경될 예정입니다.

myAccout.credit = 1000
//잔액이 0원에서 1000원으로 변경되었습니다.

myAccout.dollarValue = 2.0
//잔액이 1.0달러에서 2.달러로 변경될 예정입니다.
*/
 
/*
    override dollarValue willSet -> credit willSet -> credit didSet -> dollar set
    -> override dollarValue didSet
 
    처음에 ForeignAccout의 재정의된 dollarValue에 접근해서 willSet 하고 
    접근자가 부모클래스에 있어서 set을 하고 credit을 변경해서 crdit의 willSet 과 didSet 이 되고 부모클래스의 
    Set 이 실행되고 마지막으로 재정의된 dollarValue가 바뀌어서 didSet이 실행된다.
 
    만약 프로퍼티 감시자가 있는 프포퍼티가 함수의 입출력 매개변수의 전달인자로 전달되면 항상 willSet과 didSet 감시자가
    호출 합니다. 함수 내부에서 값이 변경되든 되지 않든 간에 함수가 종료되는 시점에 값을 다시 쓰기 때문입니다.
 */



/*
    전역변수와 지역변수 
    연산 프로퍼티와 프로퍼티 감시자에 해당되는 기능은 전역벽수와 지역변수 모두에 사용될 수 있습니다.
    따라서 프로퍼티에 한정되지 않고 전역에서 쓰일 수 있는 변수와 상수에도 같은 기능을 사용할 수 있습니다. 
    
    전역변수 또는 전역상수는 지연 저장 프로퍼티처럼 처음 접근할 때 최초로 연산이 이루어집니다. lazy 키워드를 사용하여 
    연산을 늦출 필요가 없습니다. 반대로 지역변수 및 지역상수는 절대로 지연 연산 되지 않습니다.
 */

/// 10-11 지역변수의 감시자와 연산변수 

var wonInpocket: Int = 2000 {
    willSet {
        print("주머니의 돈이 \(wonInpocket)원에서 \(newValue)원으로 변경될 예정입니다.")
    }
    didSet {
        print("주머니의 돈이 \(oldValue)원에서 \(wonInpocket)원으로 변경되었습니다.")
    }
}

var dollarInPocket: Double {
    get {
        return Double(wonInpocket)
    }
    set {
        wonInpocket = Int(newValue * 1000.0)
        print("주머니의 달러를 \(newValue)달러로 변경 중입니다.")
    }
}

// 주머니의 돈이 2000원에서 3500원으로 변경될 예정입니다.
// 주머니의 돌이 2000원에서 3500원으로 변경되었습니다.

dollarInPocket = 3.5    // 주머니의 달러를 3.5 달러로 변경 중입니다.



/*
    타입 프로퍼티
 
    각각의 인스턴스가 아닌 타입 자체에 속하게 되는 프로퍼티를 '타입 프로퍼티'라고 합니다.
    타입 프로퍼티는 타입 자체에 영향을 미치는 프로퍼티 입니다. 인스턴스의 생성 여부와 상관없이 타입 프로퍼티의 값은 하나입니다.
    타입 프로퍼티는 그 타입의 모든 인스턴스가 공통으로 사용하는 값 ( C 언어의 static constant와 유사 )이라든지, 
    모든 인스턴스에서 공용으로 접급하고 값을 변경할 수 있는 변수 ( C 언어의 static 변수와 유사 ) 등을 정의할때 유용합니다.
 
    타입 프로퍼티는 두 가지인데 저장 타입 프로퍼티는 변수 또는 상수로 선언할 수 있으며, 연산 타입 프로퍼티는 변수로만 선언할
    수 있습니다. 저장 타입 프로퍼티는 반드시 초깃값을 설정해야 하며 지연 연사 됩니다. 지연 저장 프로퍼티와는 조그 다르게
    다중 스레드 환경이라고 하더라고 간 한 번만 초기화된다는 보장을 받습니다. 지연 연산 된다고 해서 lazy 키워드로 표시해주지는
    않습니다.
 
    클래스 안에서 static으로 선언된 프로퍼티는 objective-c의 클래스 메서드 같은 느낌이다. 
    클래스로 바로 접근하는 클래스 메서드고 static으로 선언되지 않은것은 인스턴스 메서드 같은 느낌이다.
    ( 인스턴스로 구현되야만 사용가능한 것과 아닌것의 차이인것 같다 )
 */

/// 10-12 타입 프로퍼티와 인스턴스 프로퍼티

/*
class AClass {
    
    //  저장 타입 프로퍼티
    static var typeProperty: Int = 0
    
    // 저장 인스턴스 프로퍼티
    var instanceProperty: Int = 0 {
        didSet {
            AClass.typeProperty = instanceProperty + 100
        }
    }
    
    // 연산 타입 프로퍼티
    static var typeComputedProperty: Int {
        get {
            return typeProperty
        }
        
        set {
            typeProperty = newValue
        }
    }
}


AClass.typeProperty = 123

    
let classInstance: AClass = AClass()
classInstance.instanceProperty = 100
print(AClass.typeProperty)  // 200
print(AClass.typeComputedProperty)  // 200

print(AClass.typeProperty)
*/


/// 10-13 타입 프로퍼티의 사용

class Accout {
    static let dollarExchangeRate: Double = 1000.0  // 타입 상수
    
    var credit: Int = 0 // 저장 인스턴스 프로퍼티
    
    var dollarValue: Double {   // 연산 인스턴스 프로퍼티
        get {
            return Double(credit) / Accout.dollarExchangeRate
        }
        set {
            credit = Int(newValue * Accout.dollarExchangeRate)
            print("잔액을 \(newValue)달러로 변경 중입니다.")
        }
    }
}

var yagomInPoket: Accout = Accout()
yagomInPoket.dollarValue = 1
print(yagomInPoket.credit)



/*
    메서드
 
    메서드는 특정 타입에 관련된 함수를 뜻합니다. 클래스, 구조체, 열거형 등은 각각의 인스턴스가 특정 작업을 수행하는 기능을 
    캡슐화하기 위해 인스턴스 메서드를 정의할 수 있습니다. 또한, 타입 자체와 관련된 기능을 수행하기 위해 타입 메서드를 
    정의할 수도 있습니다. 타입메서드는 기존의 프로그래밍 언어에서의 클래스 메서드와 유사한 개념입니다. 
 
    구조체와 열거형이 메서드를 가질 수 있다는 것은 기존 프로그래밍 언어와 스위프트의 큰 차이점 중 하나입니다.
    스위프트에서는 프로그래머가 정의하는 타입(클래스, 구조체, 열거형 등)에 자유롭게 메서드를 정의할수 있습니다.
 */



/*
    인스턴스 메서드
 
    인스턴스 메서드는 특정 타입의 인스턴스에 속한 함수를 뜻합니다. 인스턴스 내부의 프로퍼티값을 변경하거나 특정 연산 
    결과를 반환하는 등 인스턴스와 관련된 기능을 수행합니다. 인스턴스 메서드는 함수의 문법이 같으므로 문법은 함수를 참조
 
    인스턴스 메서드는 함수와 달리 특정 타입 내부에 구현됩니다. 따라서 인스턴스가 존재할 때만 사용할 수있습니다. 이 점이 
    함수와 유일한 차이점 입니다.
 */

/// 10-14 클래스의 인스턴스 메서드

/*
class levelClass {
    // 현재 레벨을 저장하는 저장 프로퍼티
    var level: Int = 0 {
        // 프로퍼티 값이 변경되면 호츨되는 프로퍼티 감시자
        didSet {
            print("Level \(level)")
        }
    }
    
    // 레벨이 올랐을 때 호출할 메서드
    func levelUp() {
        print("Level Up!")
        level += 1
    }
    
    // 레벨이 감소했을 때 호출할 메서드
    func levelDown() {
        print("Level Down")
        level -= 1
        if level < 0 {
            reset()
        }
    }
    
    // 특정 레벨로 이동할 때 호출할 메서드
    /*
    func jumpLevel(to: Int) {
        print("Jump to \(to)")
        level = to
    }
    */
    
    func jumpLevel(to level: Int) {
        print("Jump to \(level)")
        self.level = level
    }
    
    
    // 레벨을 초기화할 때 호출할 메서드
    func reset() {
        print("Reset")
        level = 0
    }
}

var levelClassInstance: levelClass = levelClass()
levelClassInstance.levelUp()    // Level up!
// Level 1
levelClassInstance.levelDown()  // Level Down
// Level 0
levelClassInstance.levelDown() // Level Down
// Level -1
// Reset!
// Level 0
levelClassInstance.jumpLevel(to: 3) // Jump to 3
// Level 3
*/


/*
    구조체나 열거형등의 값타입이므로 메서드 앞에 mutating 키워드를 붙여서 해당 메서드가 인스턴스 내부의 값을 
    변경한다는 것을 명시해야 합니다.
 */

/// 10-15 mutating 키워드의 사용

/*
struct LevelStruct {
    var level: Int = 0 {
        didSet {
            print("Level \(level)")
        }
    }
    
    mutating func levelUp() {
        print("Level Up!")
        level += 1
    }
    
    mutating func levelDown() {
        print("Level Down")
        level -= 1
        if level < 0 {
            reset()
        }
    }
    

    mutating func jumpLevel(to: Int) {
        print("Jump to \(to)")
        level = to
    }
    
    
    mutating func reset() {
        print("Reset!")
        level = 0
    }
}

var levelStructInstance: LevelStruct = LevelStruct()
levelStructInstance.levelUp()   // Level Up!
// Level 1
levelStructInstance.levelDown() // Level Down!
// Level 0
levelStructInstance.levelDown() // Level Down!
// Level -1
// Reser!
// Level 0
levelStructInstance.jumpLevel(to: 3)    // Jump to 3
// Level 3
*/


/// 10-17 self 프로퍼티와 mutating 키워드

class LevelClass {
    var level: Int = 0
    
    func reset() {
        // 오류! self 프로퍼티 참조 변경 불가!
        //self = LevelClass()
    }
}

struct LevelStruct {
    var level: Int = 0
    
    mutating func levelUp() {
        print("Level Up!")
        level += 1
    }
    
    mutating func reset() {
        print("Reset!")
        self = LevelStruct()
    }
}

var levelStructInstance: LevelStruct  = LevelStruct()
levelStructInstance.levelUp()   // Level Up!
// Level 1
levelStructInstance.reset() // Reset
print(levelStructInstance)  // 0

// self가 on이 true이면 off, false 이면 on
enum OnOffSwitch {
    case on, off
    mutating func nextState() {
        self = self == .on ? .off : .on
    }
}

var toggle: OnOffSwitch = OnOffSwitch.off
toggle.nextState()
print(toggle)



/*
    타입 메소드
    
    인스턴스 프로퍼티와 타입 프로퍼티가 있듯이 메서드에도 인스턴스 메서드와 타입 메서드가 있습니다.
    타입 자체에 호출이 가능한 메서드를 타입 메서드 ( 흔히 객체 지향 프로그래밍에서 지칭하는 클래스 메서드와 유사 )
    라고 부릅니다. 
    메서드 앞에 static 키워드와 class 키워드를 사용할수 있는데 static 으로 정의하면 상속 후 메서드 재정의가 불가능하고 
    class로 정의하면 상속 후 재정의가 가능합니다.
 */

/// 10-18 클래스의 타입 메서드

class AClass {
    static func staticTypeMethod() {
        print("AClass staticTypeMethod")
    }
    
    class func classTypeMethod() {
        print("AClass classTypeMethod")
    }
}

class BClass : AClass {
/*
     // 오류 발생!! 재정의 불가!
     override static func staticTypeMethod() {
     
     }
 */
    override class func classTypeMethod() {
        print("BClass classTypeMethod")
    }
}

AClass.staticTypeMethod()   //AClass staticTypeMethod
AClass.classTypeMethod()    //AClass classTypeMethod
BClass.classTypeMethod()    //BClass classTypeMethod

/*
    타입 메서드는 인스턴스 메서드와 달리 self 프로퍼티가 타입 그 자체를 가리킨다는 점이 다릅니다. 
    인스턴스 메서드에서는 self가 인스턴스를 가리킨다면 타입 메서드의 self는 타입을 가리킵니다.
    그래서 타입 메서드 내부에서 타입 이름과 self는 같은 뜻이라고 볼수 있습니다.
    그래서 타입 메서드에서 self 프로퍼티를 사용하면 타입 프로퍼티 및 타임 메서드를 호출할 수 있습니다.
 */



/// 10-19 타입 프로퍼티와 타입 메서드의 사용

//시스템 음량은 한 기기에서 유일한 값을 가져야 합니다.
struct SystemVolume {
    // 타입 프로퍼티로 가지게 되면 언제나 유일한 값이 됩니다.
    static var volume: Int = 5
    
    // 타입 프로퍼티를 제어하기 위해 타입 메서드를 사용합니다.
    static func mute() {
        self.volume = 0 // SystemVolum.volume = 0 과 동일한 표현입니다.
    }
}

// 네비게이션 역할은 여러 인스턴스가 수행할 수 있습니다.

class Navigation {
    
    // 네비게이션 인스턴스마다 음량을 따로 설정할 수 있습니다.
    var volume: Int = 5
    
    // 길안내 음성 재생
    func guideWay() {
        // 네비게이션 외 다른 재생원 음소거
        SystemVolume.mute()
    }
    
    // 길안내 음성 종료
    func finishSuideWay() {
        // 기존 재생원 음량 복구
        SystemVolume.volume = self.volume
    }
}

SystemVolume.volume = 10

let myNavi: Navigation = Navigation()

myNavi.guideWay()
print(SystemVolume.volume)  // 0
myNavi.finishSuideWay()
print(SystemVolume.volume)  // 5




