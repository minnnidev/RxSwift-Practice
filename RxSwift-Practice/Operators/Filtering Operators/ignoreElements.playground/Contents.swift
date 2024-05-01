import UIKit
import RxSwift

/*
 <ignoreElements>
 next 이벤트는 필터링하고
 compelte, error 이벤트만 구독자에게 전달
 */


let disposeBag = DisposeBag()
let nums = [1, 2, 3, 4, 5]

Observable.from(nums)
    .ignoreElements()
    .subscribe { print($0) }
    .disposed(by: disposeBag)
// completed
