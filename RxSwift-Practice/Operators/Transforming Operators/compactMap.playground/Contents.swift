import UIKit
import RxSwift

/*
 <compactMap>
 nil을 필터링해주는 연산자
 nil이 아닐 때는 값을 언래핑하여 방출
 */

let disposeBag = DisposeBag()

let subject = PublishSubject<String>()


Observable<Int>.interval(.milliseconds(300), scheduler: MainScheduler.instance)
    .take(10)
    .map { _ in
        Bool.random() ? "📌" : nil
    }
    .compactMap { $0 }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(📌)
 next(📌)
 next(📌)
 next(📌)
 completed
 */

