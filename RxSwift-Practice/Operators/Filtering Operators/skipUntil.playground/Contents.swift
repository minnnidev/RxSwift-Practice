import UIKit
import RxSwift

/*
 <skip(until:)>
 다른 옵저버블을 파라미터로 받음.
 trigger 옵저버블(파라미터 옵저버블)이 이벤트를 방출하기 전까지 next 이벤트를 무시하는 skip 연산자
 */

let disposeBag = DisposeBag()

let sb = PublishSubject<Int>()
let trigger = PublishSubject<Int>()

sb.skip(until: trigger)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

sb.onNext(1)

trigger.onNext(0)
sb.onNext(2)
// next(2)

