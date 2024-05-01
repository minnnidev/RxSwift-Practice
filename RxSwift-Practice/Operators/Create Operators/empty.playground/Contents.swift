import UIKit
import RxSwift

/*
 <empty>
 completed 이벤트만 전달하는 옵저버블 생성
 -> 옵저버가 아무런 동작 없이 종료해야 할 때 사용
 */

let disposeBag = DisposeBag()

Observable<Void>.empty()
    .subscribe { print($0) }
    .disposed(by: disposeBag)
// completed
