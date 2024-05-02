import UIKit
import RxSwift

let disposeBag = DisposeBag()
let bgScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())

let observable = Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9)
    .filter { num in
        print(Thread.isMainThread ? "Main Thread" : "BackgroundThread", ">> filter")
        return num.isMultiple(of: 2)
    }
    .subscribe(on: bgScheduler)
    .map { num in
        print(Thread.isMainThread ? "Main Thread" : "BackgroundThread", ">> map")
        return num*2
    }

observable.subscribe {
    print(Thread.isMainThread ? "Main Thread" : "BackgroundThread", ">> subscribe")
    print($0)
}
.disposed(by: disposeBag)

/*
 BackgroundThread >> filter
 BackgroundThread >> filter
 BackgroundThread >> map
 BackgroundThread >> subscribe
 next(4)
 BackgroundThread >> filter
 BackgroundThread >> filter
 BackgroundThread >> map
 BackgroundThread >> subscribe
 next(8)
 BackgroundThread >> filter
 BackgroundThread >> filter
 BackgroundThread >> map
 BackgroundThread >> subscribe
 next(12)
 BackgroundThread >> filter
 BackgroundThread >> filter
 BackgroundThread >> map
 BackgroundThread >> subscribe
 next(16)
 BackgroundThread >> filter
 BackgroundThread >> subscribe
 completed
 */
