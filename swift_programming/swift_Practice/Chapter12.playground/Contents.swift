//: Playground - noun: a place where people can play

import UIKit

/// Chapter12. 접급제어

/*
    객체지향 프로그래밍 패러다임에서 은닉화는 중요한 개념 중의 하나입니다.
    이번장에서는 이를 구현하기 위한 핵심 기능인 접근제어 Access Control에 대해 알아보겠습니다.
 */



/*
    스위프트의 접근제어는 모듈과 소스파일을 기반으로 설계되었습니다.
    
    모듈은 배포할 코드의 묶음 단위입니다. 통상 하나의 프레임워크나 라이브로리 또는 애플리케이션이 모듈 단위가 될 수 있습니다.
    스위프트에서는 import 키워드를 사용하여 불러옵니다.
 
    소스파일은 하나의 스위프트 소스 코드 파일을 의미합니다. 자나나 Objective-C 같은 기존의 프로그래밍 언어에서는 통상
    파일 하나에 타입을 하나만 정의 합니다. 스위프트에서도 보통 파일 하나에 타입 하나만 정의하지만 , 때로는 소스파일 하나에
    여러타입(여러 개의 클래스나 구조체, 열거형 등) 이나 함수 등 많은 것을 정의하거나 구현할 수도 있습니다.
 */



/*
    접근수준
    
    접근제어는 접근수준 키워드를 통해 구현할 수 있습니다. 각 타입(클래스, 구조체, 열거형 등)에 특정 접근수준을 지정할 수 있고,
    타입 내부의 프로퍼티, 메서드, 이니셜라이저, 서브스크립트 각각에도 접근수준을 지정할 수 있습니다. 접근수준을 명시할 수 있는
    키워드는 open, public, internal, fileprivate, private 다섯 가지가 있습니다.
 
    개방 접근수준 - open 모듈 외부까지, 클래스에서만 사용
    공개 접근 수준 - public 모듈 외부까지
    내부 접근 수준 - internal 모듈내부
    파일외부비공개 접근 수준 - fileprivate 파일내부
    비공개 접근 수준 - private 기능 정의 내부
 */



/*
    스위프트의 기본 요소는 모두 공개 접근수준으로 구현되어 있다고 생각하면 됩니다.
 */

/// 12 -1 스위프트 표준 라이러리에 정의되어 있는 Bool 타입

/*
/// A value type whose instances are either 'true' or 'false'
public struct Bool {
    /// Default-initialize Boolean value to 'false'
    public init()
}
*/



/*
    open 키워드로 지정할 수 있는 개발 Open 접근수준은 공개 접근수준 이상으로 접근수준이 높은 수진이며, 클래스와 
    클래스의 멤버에서만 사용할 수 있습니다. 기본적으로 공객 접근수준의 접근수준과 비슷하지만 다음과 같은 차이점이 있습니다.
 
    oepn을 제외한 접근수준의 클래스는 그 클래스가 정의된 모듈안에서만 상속될수 있습니다.
    open을 제외한 접근수준의 클래스 멤버는 그 멤버가 정의된 모듈 안에서만 재정의될 수 있습니다.
 */

/// 12 -2 Foundation 프레임워크에 정의되어 있는 개방 접근수준의 NSString 클래스 

/*
open class NSString : NSObject, NSCopying, NSMutableCopying, NSSecureCoding {
    open var length: Int { get }
    open func character(at indxt: Int) -> unichar
    public init()
    public init?(coder aDecoder: NSCoder)
}
*/



/*
    내부 접근수준, internal 기본적으로 모든 요소에 암묵적으로 지정되어 있는 기본 접근수준
    파일외부비공개 접근수준, fileprivate 그 요소가 구현된 소스파일 내부에서만 사용할 수 있습니다.
    비공개 접근수준, private 접근수준이 지정된 요소는 그 기능이 정의되고 구현된 범위 내에서만 사용될 수 있습니다. 
    같은 소스파일 안에 구현된 다른 타입이나 기능에서도 사용할수 없습니다.
 */



/// 12 -3 접근수준을 명기한 각 요소들의 예

/*
open class OpenClass {
    open var openProperty: Int = 0
    public var publicProperty: Int = 0
    internal var internalProperty: Int = 0
    fileprivate var fileprivateProperty: Int = 0
    private var privateProperty: Int = 0
    
    open func openMethod() {}
    public func publicMethod() {}
    internal func internalMethod() {}
    private func privateMethod() {}
}

public class PublicClass {}
public struct PubliStruct {}
public enum PubliEnum {}
public var publicVariable = 0
public let publicConstant = 0
public func publicFunction(){}

internal class InternalClass {} // internal 키워드는 생략해도 무관합니다.
internal struct InteranlStruct {}
internal enum InteranlEnum {}
internal var interanlVariable = 0
internal let internalConstant = 0
internal func internalFunction() {}

fileprivate class FilePrivateClass {}
fileprivate struct FilePrivateStruct {}
fileprivate enum FilePrivateEnum {}
fileprivate var filePriveVariable = 0
fileprivate let filePrivateConstant = 0
fileprivate func filPrivateFunction() {}

private class PrivateClass {}
private struct PrivateStruct {}
private enum PrivateEnum {}
private var privateVariable = 0
private let privateConstant = 0
private func privateFunction() {}
*/


/*
    상위 요소보다 하위 요소가 더 높은 접근 수준을 가질 수 없다.
*/

/// 12-4 잘못된 접근수준 부여 

private class AClass {
    // 공개 접근수준을 부여해도 AClass의 접근수준이 비공개 접근수준이므로
    // 이 메서드의 접근수준도 비공개 접근수준으로 취급됩니다.
    public func someMethod() {
        // ...
    }
}

// AClass의 접근수준이 비고개 접근수준이므로
// 공개 접근수준 함수의 매개변수나 반환 값 타입으로 사용될 수 없습니다.

/*
public func someFunction(a: AClass) -> AClass {  // 오류 발생
    return a
}
*/



/// 12-5 튜플의 접근수준 부여

internal class InternalClass {} // 내부 접그수준 클래스
private struct PrivateStruct {} // 비공개 접근 수준 구조체

// 요소로 사용되는 InternalClass와 PrivateStruct의 접근 수준이
// publicTuple보다 낮기 때문에 사용할 수 없습니다.

/*
public var publicTuple: (first: InternalClass, secont: PrivateStruct) = (InternalClass(), PrivateStruct())
*/

// 요소로 사용되는 InternalClass와PrivateStruct의 접근수준이 
// privateTuple과 같거나 높기 때문에 사용할 수 있습니다.
private var privateTuple: (first: InternalClass, second: PrivateStruct) = (InternalClass(), PrivateStruct())



/// 12-7 열거형의 접근수준 

private typealias PointValue = Int

// 오류 - PointValue가 Point보다 접근수준이 낮기 떄문에 원시 값으로 사용할 수 없습니다.
// 기본 접근 값이 internal 이기 떄문에 사용할수 없음.

/*
enum Point: PointValue {
    case x, y
}

*/

