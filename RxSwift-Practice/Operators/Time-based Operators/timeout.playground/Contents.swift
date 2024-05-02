import UIKit
import RxSwift

/*
<timeout>
 지정된 시간 이내에 항목을 방출하지 않으면 에러 이벤트 전달
 에러가 아닌 다른 항목을 방출하고 싶다면 other 파라미터 활용하기
 */

let disposeBag = DisposeBag()

let sb = PublishSubject<Int>()

sb.timeout(.seconds(3), scheduler: MainScheduler.instance)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

Observable<Int>.timer(.seconds(5), // 첫 번째 이벤트는 5초 후 전달
                      period: .seconds(1),
                      scheduler: MainScheduler.instance)
    .subscribe(onNext: {
        sb.onNext($0)
    })
    .disposed(by: disposeBag)

// error(Sequence timeout.)

