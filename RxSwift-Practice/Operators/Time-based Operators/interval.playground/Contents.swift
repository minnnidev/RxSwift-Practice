import UIKit
import RxSwift

/*
<interval>
 특정 주기마다 정수를 방출
 */

let disposeBag = DisposeBag()

Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(10)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(0)
 next(1)
 next(2)
 next(3)
 next(4)
 next(5)
 next(6)
 next(7)
 next(8)
 next(9)
 completed
 */
