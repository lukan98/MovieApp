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

    func setData(optionTitles: [String]) {
        for title in optionTitles {
            let underlinedButton = UnderlinedButtonView(title: title)
            buttonStack.addArrangedSubview(underlinedButton)
            underlinedButton.addTarget(self, action: #selector(onCategorySelection), for: .touchUpInside)
        }
        styleButtons()
        if !optionTitles.isEmpty {
            onButtonSelected(0)
        }
    }

    func styleViews() {
        scrollView.showsHorizontalScrollIndicator = false

        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.spacing = 22

        styleButtons()
    }

    func styleButtons() {
        for (index, subview) in buttonStack.arrangedSubviews.enumerated() {
            guard let underlinedButton = subview as? UnderlinedButtonView else { return }

            if index == selectedButtonIndex {
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

    @objc
    private func onCategorySelection(sender: UIButton) {
        let view = buttonStack.arrangedSubviews.first(
            where: { view in
                guard let underlinedButton = view as? UnderlinedButtonView
                else {
                    return false
                }
                return underlinedButton.button == sender})

        guard
            let previouslySelected = buttonStack.arrangedSubviews[selectedButtonIndex] as? UnderlinedButtonView,
            let newlySelected = view as? UnderlinedButtonView,
            let newlySelectedIndex = buttonStack.arrangedSubviews.firstIndex(of: newlySelected)
        else {
            return
        }

        previouslySelected.styleUnselected()
        selectedButtonIndex = newlySelectedIndex
        onButtonSelected(selectedButtonIndex)
        newlySelected.styleSelected()
    }

}
