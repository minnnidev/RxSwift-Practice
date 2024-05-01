import UIKit
import RxSwift

/*
 <range>
 start에서 1씩 증가하는 옵저버블을 생성 +
 정수를 지정된 count 수만큼 방출하는 옵저버블 생성
 */

let disposeBag = DisposeBag()

Observable.range(start: 1, count: 5)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(1)
 next(2)
 next(3)
 next(4)
 next(5)
 completed
 */
