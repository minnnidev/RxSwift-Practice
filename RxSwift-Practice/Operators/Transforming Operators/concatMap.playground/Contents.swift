import UIKit
import RxSwift

/*
 <concatMap>
 flatMap에서 인터리빙을 허용하지 않는 연산자
 방출 순서를 보장함
 */

let disposeBag = DisposeBag()
let redCircle = "🔴"
let greenCircle = "🟢"
let blueCircle = "🔵"
let redHeart = "♥️"
let greenHeart = "💚"
let blueHeart = "💙"

Observable.from([redCircle, greenCircle, blueCircle])
    .concatMap { circle -> Observable<String> in
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
 next(♥️)
 next(♥️)
 next(♥️)
 next(💚)
 next(💚)
 next(💚)
 next(💚)
 next(💚)
 next(💙)
 next(💙)
 next(💙)
 next(💙)
 next(💙)
 completed
 */
