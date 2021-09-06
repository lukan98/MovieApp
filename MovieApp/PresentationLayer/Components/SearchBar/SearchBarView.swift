import UIKit
import Combine

class SearchBarView: UIView {

    static let defaultHeight = 40
    static let defaultSpacing: CGFloat = 20
    static let fontSize: CGFloat = 16

    var stackView: UIStackView!
    var searchField: BaseSearchTextField!
    var cancelButton: UIButton!

    var cancelButtonTap: AnyPublisher<Void, Never> {
        cancelButtonTapSubject
            .eraseToAnyPublisher()
    }

    private let cancelButtonTapSubject = PassthroughSubject<Void, Never>()

    private var disposables = Set<AnyCancellable>()

    init() {
        super.init(frame: .zero)

        buildViews()
        bindViews()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        defineLayoutForViews()
    }

    private func bindViews() {
        cancelButton
            .throttledTap()
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.hideCancelButton()
                self.cancelButtonTapSubject.send()
            }
            .store(in: &disposables)

        searchField
            .onEditingStart
            .sink { [weak self] _ in
                self?.showCancelButton()
            }
            .store(in: &disposables)

        searchField
            .rxText
            .sink { [weak self] query in
                self?.searchField.rightView?.isHidden =  query.count == 0
            }
            .store(in: &disposables)

        searchField.rightView?
            .throttledTapGesture()
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.searchField.text = nil
                self.searchField.rightView?.isHidden = true
            }
            .store(in: &disposables)
    }

    private func hideCancelButton() {
        searchField.text = nil
        cancelButton.isHidden = true
        searchField.rightView?.isHidden = true
        searchField.resignFirstResponder()
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.cancelButton.alpha = 0
                self.layoutIfNeeded()
            })
    }

    private func showCancelButton() {
        cancelButton.isHidden = false
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.cancelButton.alpha = 1
                self.layoutIfNeeded()
            })
    }

}
