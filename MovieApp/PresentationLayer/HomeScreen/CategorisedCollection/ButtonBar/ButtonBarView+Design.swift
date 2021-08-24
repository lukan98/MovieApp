import UIKit

extension ButtonBarView: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
    }

    func createViews() {
        scrollView = BaseScrollView()
        addSubview(scrollView)

        contentView = UIView()
        scrollView.addSubview(contentView)

        buttonStack = UIStackView()
        contentView.addSubview(buttonStack)
    }

    func styleViews() {
        scrollView.showsHorizontalScrollIndicator = false

        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.spacing = 22
    }

    func styleButtons(with selectedIndex: Int) {
        for (index, subview) in buttonStack.arrangedSubviews.enumerated() {
            guard let underlinedButton = subview as? UnderlinedButtonView else { return }

            if index == selectedIndex {
                underlinedButton.styleSelected()
            } else {
                underlinedButton.styleUnselected()
            }
        }
    }

    func defineLayoutForViews() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }

        buttonStack.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }

}
