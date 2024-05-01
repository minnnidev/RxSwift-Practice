import UIKit
import RxSwift

/*
 <just>
 하나의 항목을 방출하는 옵저버블 생성
 */

let disposeBag = DisposeBag()

Observable.just("hi")
    .subscribe { event in print(event) }
    .disposed(by: disposeBag)
/*
 next(hi)
 completed
 */

Observable.just([1, 2, 3])
    .subscribe { event in print(event) }
    .disposed(by: disposeBag)
/*
 next([1, 2, 3])
 completed
 */

