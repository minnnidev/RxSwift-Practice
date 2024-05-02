import UIKit
import RxSwift

/*
 <merge>
 여러 옵저버블이 방출하는 이벤트를 하나의 옵저버블에서 순서대로 방출하도록 병합
 */

let disposeBag = DisposeBag()

let oddNumbers = BehaviorSubject(value: 1)
let evenNumbers = BehaviorSubject(value: 2)
let negativeNumbers = BehaviorSubject(value: -1)

Observable.of( oddNumbers, evenNumbers)
    .merge()
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(1)
 next(2)
 */

oddNumbers.onNext(3)
evenNumbers.onNext(4)

/*
 next(1)
 next(2)
 next(3)
 next(4)
 */

oddNumbers.onCompleted()
evenNumbers.onCompleted()
// 모든 서브젝트에 onCompleted 이벤트가 전달되어야 종료
// 하나라도 error 이벤트 전달 시 종료

