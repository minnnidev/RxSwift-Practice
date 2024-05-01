import UIKit
import RxSwift

/*
 <from>
 배열 안의 요소들을 하나씩 순서대로 방출하는 옵저버블을 생성
 */

let disposeBag = DisposeBag()

Observable.from([1, 2, 3, 4])
    .subscribe { event in print(event) }
    .disposed(by: disposeBag)

/*
 next(1)
 next(2)
 next(3)
 next(4)
 completed
 */
