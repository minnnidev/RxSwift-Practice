import UIKit
import RxSwift

/*
 <throttle>
 지정된 주기 동안 하나의 이벤트만 구독자에게 전달
 dueTime: 반복 주기
 */

let disposeBag = DisposeBag()

let buttonTap = Observable<String>.create { observer in
    DispatchQueue.global().async {
        for i in 1...10 {
            observer.onNext("Tap \(i)")
            Thread.sleep(forTimeInterval: 0.3)
        }

        Thread.sleep(forTimeInterval: 1)

        for i in 11...20 {
            observer.onNext("Tap \(i)")
            Thread.sleep(forTimeInterval: 0.5)
        }

        observer.onCompleted()
    }
    return Disposables.create()
}

buttonTap
    .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(Tap 1)
 next(Tap 4)
 next(Tap 7)
 next(Tap 10)
 next(Tap 11)
 next(Tap 12)
 next(Tap 14)
 next(Tap 16)
 next(Tap 18)
 next(Tap 20)
 completed
 */
