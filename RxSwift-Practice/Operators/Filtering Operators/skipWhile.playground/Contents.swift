import UIKit
import RxSwift

/*
 <skip(while:)>
 while 조건에 따라 이벤트 방출을 결정하는 skip 연산자
 while 클로저에서 false를 반환한 이후부터 모든 이벤트를 방출
 */

let disposeBag = DisposeBag()
let nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

Observable.from(nums)
    .skip(while: { !$0.isMultiple(of: 2) })
    .subscribe { print($0) }
    .disposed(by: disposeBag)
