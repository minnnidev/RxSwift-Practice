import UIKit
import RxSwift

/*
 <sample>
 dataObservable.sample(triggerObservable)
 trigger 옵저버블이 next 이벤트를 전달할 때마다 
 데이터 옵저버블이 next 이벤트를 방출
 */

enum MyError: Error {
    case error
}

let disposeBag = DisposeBag()

let trigger = PublishSubject<Void>()
let data = PublishSubject<String>()

data.sample(trigger)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

trigger.onNext(())
data.onNext("hi")

trigger.onNext(())
// next(hi)

//data.onError(MyError.error)
// error(error)

data.onCompleted()
trigger.onNext(())
// completed
