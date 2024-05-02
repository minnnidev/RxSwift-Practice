import UIKit
import RxSwift

/*
 <debounce>
 dueTime: next이벤트를 방출할지 결정하는 조건
 옵저버가 next 이벤트를 방출한 다음 지정된 시간 동안 다른 next 이벤트를 방출하지 않는다면, 해당 시점에 가장 마지막에 방출된 이벤트를 구독자에게 전달
 지정된 시간 내에 다른 next 이벤트를 방출했다면 타이머 초기화
 scheduler: 타이머를 실행할 스케줄러
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
    .debounce(.milliseconds(1000), scheduler: MainScheduler.instance)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(Tap 10)
 next(Tap 20)
 completed
 */
