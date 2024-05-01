import UIKit
import RxSwift

/*
 <elementAt>
 특정 인덱스에 위치한 요소를 제한적으로 방출
 */

let disposebag = DisposeBag()
let nums = [0, 1, 2, 3, 4, 5]

Observable.from(nums)
    .element(at: 2)
    .subscribe { print($0) }
    .disposed(by: disposebag)

/*
 next(2)
 completed
 */
