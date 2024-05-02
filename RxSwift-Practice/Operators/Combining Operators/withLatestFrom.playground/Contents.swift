import UIKit
import RxSwift

/*
 <withLatestFrom>
 trigger.sample(dataObservable)
 trigger 옵저버블이 next 이벤트를 방출하면 데이터 옵저버블이
 가장 최근에 방출한 next 이벤트를 구독자에게 전달
 */

let disposeBag = DisposeBag()

let trigger = PublishSubject<Void>()
let data = PublishSubject<String>()

trigger.withLatestFrom(data)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

data.onNext("hello")
trigger.onNext(())
// next(hello)

trigger.onNext(())
// next(hello)

data.onCompleted()
// nothing
