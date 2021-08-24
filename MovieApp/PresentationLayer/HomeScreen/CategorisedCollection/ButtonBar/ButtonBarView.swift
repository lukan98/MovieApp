import UIKit
import Combine

class ButtonBarView: UIView {

    var selectedButtonIndex = 0

    var scrollView: BaseScrollView!
    var contentView: UIView!
    var buttonStack: UIStackView!

    var selectedButtonIndexPublisher: AnyPublisher<Int, Never> {
        selectedButtonIndexSubject
            .removeDuplicates()
            .eraseToAnyPublisher()
    }

    private let selectedButtonIndexSubject = PassthroughSubject<Int, Never>()
    private var disposables = Set<AnyCancellable>()

    init() {
        super.init(frame: .zero)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        defineLayoutForViews()
    }

    func setData(optionTitles: [String]) {
        optionTitles.enumerated().forEach { index, title in
            let underlinedButton = UnderlinedButtonView(title: title)
            buttonStack.addArrangedSubview(underlinedButton)
            underlinedButton.button
                .tapGesture()
                .sink { [weak self] _ in
                    self?.selectedButtonIndexSubject.send(index)
                }
                .store(in: &disposables)
        }

        selectedButtonIndexSubject
            .sink { [weak self] index in
                self?.styleButtons(with: index)
            }
            .store(in: &disposables)

        selectedButtonIndexSubject.send(0)
    }

}
