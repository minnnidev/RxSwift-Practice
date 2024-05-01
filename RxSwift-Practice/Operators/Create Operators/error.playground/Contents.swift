import UIKit
import RxSwift

/*
 <error>
 error 이벤트를 전달하고 종료하는 옵저버블 생성
 (next 이벤트 전달 x)
 */

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

Observable<Void>.error(MyError.error)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
// error(error)
