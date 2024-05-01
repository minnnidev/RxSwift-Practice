import UIKit
import RxSwift

/*
 <repeatElement>
 동일한 요소를 반복적으로 (무한정) 방출하는 옵저버블
 따라서 필요하다면 방출되는 횟수를 제한해야 한다.
 */

let disposeBag = DisposeBag()

Observable.repeatElement("📌")
    .take(5)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(📌)
 next(📌)
 next(📌)
 next(📌)
 next(📌)
 completed
 */
