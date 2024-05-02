import UIKit
import RxSwift

/*
 <map>
 원본 옵저버블이 방출하는 요소를 대상으로 함수를 실행한 뒤 해당 결과를 새로운 옵저버블로 리턴
 */

let disposeBag = DisposeBag()
let skills = ["Swift", "SwiftUI", "RxSwift"]

Observable.from(skills)
    .map { "hello" + $0 }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(helloSwift)
 next(helloSwiftUI)
 next(helloRxSwift)
 completed
 */
