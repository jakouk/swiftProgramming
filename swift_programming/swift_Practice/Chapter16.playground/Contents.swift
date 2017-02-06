//: Playground - noun: a place where people can play

import UIKit

/// Chapter 16. 모나드 

/*
    함수형 프로그래밍 패러다임을 처음 접하는 독자라면 함수형 프로그래밍 패러다임에서 사용되는 용어나 개념이 매우 생소할 수 
    있습니다. 스위프트에는 함수형 프로그래밍 패러다임에서 파생된 기능이나 개념이 종종 등장하는데, 이 개념을 이해지 못하면
    스위프트 기능의 절반 정도는 제대로 사용하지 못합니다. 이번 장에서 배우는 개념이 함수형 프로그래밍 패러다임을 이해하는 
    첫걸음이 되면 좋겠습니다. 물론 함수형 프로그래밍이라는 것이 단순히 고차함수를 이용한다든가, 함수를 일급 객체로 사용한다든가,
    순환(재귀)함수를 사용한 로직을 구현한다는 등의 특정 테크닉에 국한되는 것은 아니지만 이번에 배워볼 모나드와 관련된 개념을 
    익혀두면 나중에 좀 더 깊이 있게 함수형 프로그래밍을 이해할 수 있으리라 생각합니다.
 
    모나드(Monad)는 특정한 상태로 값을 포장하는 것에서 출발합니다. 스위프트에서는 이를 옵셔널이라는 형태로 구현했는데 값이
    있을지 없을지 모르는 상태 속에 포장하는 것입니다. 스위프트의 옵셔널은 스위프트에서 모나드를 이해하기 좋은 예 중 하나입니다.
    
    함수객체와 모나드는 특정 기능이 아닌 디자인 패턴 혹은 자료구조라고 할 수 있습니다. 모나드를 이해하기에 앞서 이해해야 할
    몇 가지 개념이 있습니다. 옵셔널을 하나하나 파헤쳐 보면서 순서에 따라 조금씩 알아보겠습니다.
 */



/*
    컨텍스트
    컨텍스트(Context)의 사전적 정의를 보면 '맥락', 전후 사정' 등입니다. 이번 파트에서 컨텍스트는 '콘테츠(Content)'를 
    담고 있는 그 무엇인가'를 뜻합니다. 즉, 물컵에 물이 담겨있다면 물은 콘테츠고 물컵은 컨텍스트라고 볼 수 있습니다.
    컨텍스트에 대해 알아보기 전에, 옵셔널을 다시 한 번 되새겨볼 필요가 있습니다. 옵셔널은 열거형으로 구현되어 있어서 열거형
    케이스의 연관 값을 통해 인스턴스 안에 연관값을 가지는 형태입니다. 옵셔널이 값을 가지고 있지 않다면 열거형의 .none 케이스로,
    값을 가지고 있다면 열거형의 .some(value) 케이스의 연관 값을 꺼내오는 것과 같습니다.
 
    2라는 숫자를 옵셔널로 둘러싸면, 컨텍스트 안에 2라는 콘테츠가 들어가는 모양새입니다. 그리고 '컨텍스트는 2라는 값을 가지고 
    있다'고 말할 수 있습니다. 만약 값이 없는 옵셔널 상태라면 '컨텍스트는 존재하지만 내부에 값이 없다'고 할 수 있습니다.
    이처럼 값(콘텐츠)와 컨텍스트의 관계를 이해하는 것이 이 장의 출발입니다. 
 
    옵셔널은 some과 none이라는 두 가지의 컨텍스트를 가집니다.
 */



/// 16-1 addThree 함수

func addThree(_ num: Int) -> Int {
    return num + 3
}

/*
    addThree(_:) 함수의 전달인자로 컨텍스트에 들어있지 않은 순수 값인 2를 전달하면 정상적으로 함수를 실핼 할 수 있습니다.
    addThree(_:) 함수는 매개변수로 Int 타입의 값을 받기 때문입니다.
 */



/// 16-2 일반 값을 연산할 수 있는 addThree 함수
addThree(2) // 5

/*
    그러나 옵셔널을 전달인자로 사용하려고 한다면 오류가 발생합니다. 순수한 값이 아닌 무언가(여기서 옵셔널의 some)로 
    둘러싸인 컨텍스트가 전달되었기 때문입니다.
 */



/// 16-3 옵셔널을 연산할 수 없는 addThree 함수

// addThree(Optional(2))   // 오류 생생

/*
    함수 객체
    우리는 앞서 맵에 대해 알아봤습니다. 맵은 컨테이너의 값을 변형시킬 수 있는 고차함수입니다. 그리고 옵셔널은 컨테이너 (
    컨텍스트가 일종의 컨테이너 역활을 합니다.)와 값을 가지기 때문에 맵 함수를 사용할 수 있습니다. 맵을 사용하면 컨테이너
    안의 값을 처리할 수 있습니다.
 
 */



/// 16-4 맵 메서드를 사용하여 옵셔널을 연산할 수 있는 addThree(_:)함수

Optional(2).map(addThree)   // Optional(5)

/* 
    따로 함수가 없어도 클로저를 사용할 수도 있습니다.
 */



/// 16-5 옵셔널에 맴 메서드와 클로저의 사용

var value: Int? = 2

// value.map{ $0 + 3 } // Optional(5)

// value = nil
// value.map { $0 + 3 }    // nil == option.none

/*
    왜 맵을 업급했냐면, '함수객체란 맵을 적용할 수 있는 컨테이너 타입'이라고 말할수 있기 때문입니다. 우리가 앞서 맵을 
    사용해보았던 Array, Dictionary,, Set 등등 스위프트의 많은 컬렉션 타입이 함수객체라는 것이다. 
    맵을 사용하여 컨테이너 내부의 값을 처리할 수 있다는 것을 살펴 보았는데 도대체 맵은 어떻게 컨테이너 내부의 값을 가지고
    addThree(_:) 함수를 사용할 수 있었던 걸까요??
 
    map(a->b) -> f(a) => f(b)
    1. 맵이 함수를 인자로 받음 예)addThree(_:)
    2. 함수객체에 맵이 전달 받은 함수를 적용 예) Optional(2)
    3. 새로운 함수객체를 반환 예) Optional(5)
 */



/// 16-6 옵셔널의 map 메서드 구현

extension Optional {
    func map<U>(f: (Wrapped) -> U) -> U? {
        switch self {
        case .some(let x): return f(x)
        case .none: return .none
        }
    }
}

/*
    옵셔널의 map(_:) 메서드를 호출하면 옵셔널 스스로 값을 가지고 있는지 없는지 switch구문으로 판단합니다. 값이 있다면 
    전달받은 함수에 자신의 값을 적용한 결괏값을 다시 컨텍스트에 넣어 반환하고, 그렇지 않다면 함수를 실행하지 않고 빈 컨텍스트를
    반환합니다. Optional(2).map(addThree) 코드를 실행할 때 어떤 일이 벌어지는지 알아보겠습니다.
 
    1. 컨텍스트로부터 값 추출
    2. 전달받은 함수 적용
    3. 결괏값을 다시 컨텍스트에 담아 반환
 
    만양 값이 없는 Optional.none.map(addThree)코드와 같은 상황이라면 같은 동작을 수행한다.
 
    1. 컨텍스트에 값이 없음
    2. 함수 적용 안함 
    3. 결과적으로 아무것도 하지 않음
 */



/*
    모나드
 
    모나드(Monad)는 함수 객체의 일종입니다. 함수객체는 맵 함수를 적용할 수 있는, 즉 맵 함수를 지원하는 컨테이너 타입
    이었습니다. 모나드는 거기에 더 나아가 값이 있을지 없을지 모르는 상태를 추가합니다. 즉, 무나드는 값이 있을 수도 있고 없을 
    수도 있는 컨텍스트를 가지는 함수객체타입입니다. 
 
    함수객체는 포장된 값에 함수를 적용할 수 있었습니다. 그래서 모나드도 컨텍스트에 포장된 값을 처리하여 컨텍스트에 포장된 값을
    다시 반환하는 함수를 적용할 수 있습니다. 스위프트에 이와 같은 기능을 수행하기 위한 플랫맵이라는 메서드가 있습니다.
    플랫맵은 값을 받아와서 값이 있으면 포장을 풀어서 값을 처리한 후 포장된 값을 반환하고, 값이 없으면 값이 없는대로 다시 
    포장하여 반환합니다.
    
    맵과 같이 플랫맵도 함수를 매개변수로 받고 옵셔널은 모나드이므로 플랫맵을 사용할 수 있습니다.
 */



/// 16-7 doubleEven(_:) 함수의 플랫맵의 사용

func doubleEven(_ num: Int) -> Int? {
    if num % 2 == 0 {
        return num * 2
    }
    return nil
}

Optional(3).flatMap(doubleEven)

/*
    플랫맵과 맵의 차이점이라면 내부의 값을 알아서 더 추출해준다는 것입니다. 플랫맵은 내부에 포장된 값도 추출해낼 수 있습니다.
 */



/// 16-8 맵과 플랫맵의 차이

let optionalArr : [Int?] = [1, 2, nil, 5]

let mappedArr: [Int?] = optionalArr.map{ $0 }
let flatmappedArr: [Int] = optionalArr.flatMap{ $0 }

print(mappedArr)    // [Optional(1), Optional(2), nil, Optional(5)]
print(flatmappedArr)    // [1, 2, 5]

/*
    optionalArr는 Array라는 컨테이너의 내부에 Optional이라는 형태의 컨테이너들이 여러개 들어가 있는 형태입니다. 이
    배열의 맵 메서드와 플랫맵 메서드를 각각 호출해 본다면 다른 결과를 볼 수 있습니다. 맵 메서드를 사용한 결과는 Array 
    컨테이너 내부의 값의 타입이나 형태가 어찌 되었든, Array 내부에 값이 있으면 그 값을 그저 클로저의 코드에만 실행하고 
    결과를 다시 Array 컨테이너에 담기만 합니다. 그러나 플랫맵을 통해 클로저를 실행하면 알아서 내부 컨테이너까지 값을 추출
    합니다. 그렇기 때문에 mappedArr는 다시 [Int?] 타입이 되면 flatmappedArr는 [Int] 타입이 됩니다. 
 
    삼중 컨테이너에 대한 중첩된 맵과 플랫맵을 사용해 보았습니다.
 */



/// 16-9 중첩된 컨테이너에서 맵과 플랫맵의 차이

let multipleContainer =  [[1, 2, Optional.none],[3, Optional.none],[4, 5, Optional.none]]

let mappedMultipleContainer = multipleContainer.map{ $0.map{ $0 }}
let flatmappedMultpleContainer = multipleContainer.flatMap{ $0.flatMap{ $0 } }

print(mappedMultipleContainer)
print(flatmappedMultpleContainer)

/*
    결과에서 볼 수 있듯이 컨테이너 내부의 데이터에 다시 맵을 적용했을 때와 플랫맵을 ㅈ거용했을 때의 결과는 확연히 다릅니다.
    플랫맵은 내부의 값을 1차원적으로 펼쳐놓는 작업도 수행하기 때문에, 값을 꺼내서 모두 동일한 위상으로 펼쳐놓는 모양새를 
    갖출 수 있습니다. 그래서 값을 일자로 평평하게 펼친다(Flatren)고 해서 플랫맵이라고 불리는 것입니다. 
 
    스위프트에서 옵셔널에 관련된 여러 컨테이너의 값을 연달아 처리할 때, 바인딩을 통해 체인형식으로 사용할 수 있기에 맵보다는
    플랫맵이 더욱 유용하게 쓰일 수 있습니다.
 */



/// 16-10 플랫맵의 활용

func stringToInt(str: String) -> Int?{
    return Int(str)
}

func intToString(integer : Int) -> String? {
    return "\(integer)"
}

var optionalString: String? = "2"

var result: Any = optionalString.flatMap(stringToInt).flatMap(intToString).flatMap(stringToInt)
print(result)   // Optional(2)
result = optionalString.map(stringToInt)    // 더 이상 체인 연결 불가
print(result)

/*
    String 타입을 Int 타입으로 변환하는 것은 실패한 가능성을 내포하기 때문에 결괏값을 옵셔널 타입으로 반환합니다. 반대도 
    Int 타입에서 String 타입으로의 변환은 실패 가능성은 없지만 예를 들고자 옵셔널 타입으로 변환해주어습니다. 플랫맵을
    사용하여 체인을 연결하였을 떄 결과는 옵셔널 타입입니다. 그러나 맵을 사용하여 체인을 연결하면 옵셔널의 옵셔널 형태로 
    반환됩니다. 그 이유는 플랫맵은 함수의 결괏값이 값이 있다면 추출해서 평평하게 만드는 과정을 내포하고, 맵은 그렇지 않기 
    때문입니다. 맵은 옵셔널 타입의 값을 옵셔널이라는 컨에너 안에 다시 집어넣어 반환하고, 플랫맵은 추출 작업을 통해 옵셔널에서
    꺼내온 값을 다시 옵셔널에 넣어주기 떄문에 이같은 연 쇄 연산도 가능한 것입니다.
 */



/// 16-11 옵셔널의 맵과 플랫맵 정의

/*
public func map<U>(_ transform: (Wrapped) throws -> U ) rethrows -> U?
public func flatMap<U>(_ transfrom: (Wrapped) throws -> U?) rethrows -> U?
*/

/*
    옵셔널의 map과 flatMap의 정의를 보면 결과가 왜 그렇게 나왔는지 모금 더 명확해집니다. 맵에서 전달받은 함수 transform은 
    포장된 값을 매개변수로 갖고 U를 반환하는 함수입니다. 예를 들어 stringToInt(_:)는 String 타입을 전달받고
    Int? 타입을 반환합니다. U == Int?가 되겠죠? U 대신 Int? 를 대입해보세요. 그렇게 생각해 보면 슬슬 결과가 보이기 시작
    할 것입니다. String 옵셔널의 맵에 stringToInt(_:) 함수를 전달하면 최종 반환타입인 Int??가 됩니다.
    반면 플랫맵이 전달받는 transform에 StringToInt(_:)를 대입해 생각해보면 U? == Int? 가 됩니다. 즉, U == Int가
    되기 때문에 플랫맵읜 동작 결과는 최종적으로 Int? 타입을 반환하게 됩니다.
    만약 플랫맵을 사용하지 않으면서도 플랫맵과 같은 효과를 얻으려면 바인딩을 직접 해주어야 합니다.
 */



/// 16-12 옵셔널 바인딩을 통한 연산

if let str: String = optionalString {
    if let num: Int = stringToInt(str: str) {
        if let finalStr: String = intToString(integer: num) {
            if let finalNum: Int = stringToInt(str: finalStr) {
                result = Optional(finalNum)
            }
        }
    }
}

print(result)   // Optional(2)

if let str: String = optionalString, let num: Int = stringToInt(str: str) , let finalStr: String = intToString(integer: num), let finalNum: Int = stringToInt(str: finalStr) {
    result = Optional(finalNum)
}

print(result)   // Optional(2)



/*
    플랫맵은 체이닝 중간에, 연산에 실패하는 경우나 값이 없어지는 경우(.none이 된다거나 nil이 된다는 등) 이후에는 별도의
    예외 처리없이 빈 컨테이너를 반환하게 됩니다.
 */

/// 16-13 플랫맵 체이닝 중 빈 컨텍스트를 만났을 때의 결과 

func intToNil(param: Int) -> String? {
    return nil
}

result = optionalString.flatMap(stringToInt).flatMap(intToNil).flatMap(stringToInt)
print(result)   // nil

/*
    flatMap(intToNil)부분에서 nil, 즉 Optional.none을 반환받기 때문에 이후에 호출되는 메서드는 무시됩니다.
    이는 앞서 우리가 알아본 옵셔널 체이닝과 완전히 같은 동작이죠? 바로 옵셔널이 모나드이기 떄문에 가능한 것입니다.
 
    지금까지 알아본 것과 같이 옵셔널 체이닝, 옵셔널 바인딩, 플랫맵 등은 모나드와 관련된 연산입니다. 스위프트의 기본 모나드
    타입이 아니더라도 플랫맵 모양의 모다드 연산자를 구현하면 사용자정의 타입 ( 흔히 클래스 또는 구조체 등)도 모나드로 사용할 수 
    있습니다. 이 책을 끝까지 읽으면 스스로 모나드 타입을 정의하고 구현해볼 수 있을 것입니다. 플랫맵의 사용자 정의 구현은 
    프로토콜 지향 프로그래밍에서 자세히 다뤄보겠습니다.
 */

