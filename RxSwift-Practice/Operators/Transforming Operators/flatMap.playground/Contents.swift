import UIKit
import RxSwift

/*
 <flatMap>
옵저버블이 방출한 항목을 원하는 옵저버블로 변환한 뒤,
하나의 옵저버블로 평탄화하는 연산자

 but, 이벤트의 방출 순서는 보장되지 않음
 */

let disposeBag = DisposeBag()
let redCircle = "🔴"
let greenCircle = "🟢"
let blueCircle = "🔵"
let redHeart = "♥️"
let greenHeart = "💚"
let blueHeart = "💙"

Observable.from([redCircle, greenCircle, blueCircle])
    .flatMap { circle -> Observable<String> in
        switch circle {
        case redCircle:
            return Observable.repeatElement(redHeart)
                .take(5)
        case greenCircle:
            return Observable.repeatElement(greenHeart)
                .take(5)
        case blueCircle:
            return Observable.repeatElement(blueHeart)
                .take(5)
        default:
            return Observable.just("")
        }
    }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

/*
 next(♥️)
 next(♥️)
 next(💚)
 next(♥️)
 next(💚)
 next(💙)
 next(♥️)
 next(💚)
 next(💙)
 next(♥️)
 next(💚)
 next(💙)
 next(💚)
 next(💙)
 next(💙)
 completed
 */
