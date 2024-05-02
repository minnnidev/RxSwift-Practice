import UIKit
import RxSwift

/*
 <window>
 buffer 연산자와 유사하지만 수집된 항목을 방출하는 옵저버블을 방출하는 옵저버블을 리턴
 */

let disposeBag = DisposeBag()

Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .window(timeSpan: .seconds(2),
            count: 3,
            scheduler: MainScheduler.instance) // return Observable<Observable<Int>>
    .take(5)
    .subscribe {
        print($0)

        if let observable = $0.element {
            observable.subscribe { print("inner:", $0) }
        }
    }
    .disposed(by: disposeBag)

/*
 next(RxSwift.AddRef<Swift.Int>)
 inner: next(0)
 inner: completed
 next(RxSwift.AddRef<Swift.Int>)
 inner: next(1)
 inner: next(2)
 inner: next(3)
 inner: completed
 next(RxSwift.AddRef<Swift.Int>)
 inner: next(4)
 inner: next(5)
 inner: completed
 next(RxSwift.AddRef<Swift.Int>)
 inner: next(6)
 inner: next(7)
 inner: completed
 next(RxSwift.AddRef<Swift.Int>)
 completed
 inner: next(8)
 inner: next(9)
 inner: completed
 */
