import UIKit
import RxSwift

/*
 <buffer>
 특정 주기 동안 옵저버블이 방출하는 항목을 수집하여 배열을 방출하는 옵저버블을 리턴
 timeSpan: 항목을 수집할 최대 시간
 count: 수집할 항목의 최대 숫자
 두 파라미터는 모두 최대임을 주의
 */

let disposeBag = DisposeBag()

Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .buffer(timeSpan: .seconds(2),
            count: 3,
            scheduler: MainScheduler.instance)
    .take(5)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 시간과 연관된 연산자는 항상 오차가 있을 수도 있다는 점
 next([0])
 next([1, 2, 3])
 next([4, 5])
 next([6, 7])
 next([8, 9])
 completed
 */
