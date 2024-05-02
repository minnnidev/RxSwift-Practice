import UIKit
import RxSwift

/*
 <take(until:)>
 옵저버블을 파라미터로 받음
 트리거 옵저버블이 next 이벤트를 방출하기 전까지 이벤트를 방출하는 연산자
 */

let disposeBag = DisposeBag()

let subject = PublishSubject<Int>()
let trigger = PublishSubject<Int>()

//subject
//    .take(until: trigger)
//    .subscribe { print($0) }
//    .disposed(by: disposeBag)
//
//subject.onNext(1)
//// next(1)
//
//trigger.onNext(0)
//// completed

// 조건이 true를 리턴하게 되면 completed 이벤트 전달
// false를 리턴할 때는 이벤트를 방출
subject
    .take(until: { $0 > 5 })
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(1)
subject.onNext(2)
subject.onNext(3)
subject.onNext(7)

/*
 next(1)
 next(2)
 next(3)
 completed
 */
