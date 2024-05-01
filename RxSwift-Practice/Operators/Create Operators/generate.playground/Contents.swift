import UIKit
import RxSwift

/*
 <generate>
 range에서 증가하는 크기를 바꾸거나 감소하는 옵저버블을 생성할 때
 장수로 제한되지 않는다
 */

let disposeBag = DisposeBag()

// 10보다 작거나 같은 짝수만 방출하기
Observable.generate(initialState: 0,
                    condition: { $0 <= 10 },
                    iterate: { $0 + 2 })
.subscribe { print($0) }
.disposed(by: disposeBag)

/*
 next(0)
 next(2)
 next(4)
 next(6)
 next(8)
 next(10)
 completed
 */

Observable.generate(initialState: 10,
                    condition: { $0 >= 0 },
                    iterate: { $0 - 2 })
.subscribe { print($0) }
.disposed(by: disposeBag)

/*
 next(10)
 next(8)
 next(6)
 next(4)
 next(2)
 next(0)
 completed
 */
