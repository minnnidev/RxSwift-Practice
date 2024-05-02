import UIKit
import RxSwift

/*
<timer>
지연 시간과 반복 주기를 지정하며 정수를 방출
 */

let disposeBag = DisposeBag()

// dueTime: 첫 번째 항목이 구독자에게 전달되는 지연 시간
// period: 반복 주기
Observable<Int>.timer(.seconds(3),
                      period: .seconds(3),
                 scheduler: MainScheduler.instance)
.take(5)
.subscribe { print($0) }
.disposed(by: disposeBag)

/*
 next(0)
 next(1)
 next(2)
 next(3)
 next(4)
 completed
 */
