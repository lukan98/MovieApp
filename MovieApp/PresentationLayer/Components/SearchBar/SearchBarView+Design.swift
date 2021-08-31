import UIKit

extension SearchBarView: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
    }

    func createViews() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        addSubview(stackView)

        searchField = BaseSearchTextField()

        let searchIcon = UIImageView(image: .search)
        searchIcon.contentMode = .center
        searchField.leftView = searchIcon

        let deleteButton = UIButton()
        deleteButton.setImage(.xImage, for: .normal)
        deleteButton.contentMode = .center
        searchField.rightView = deleteButton
        deleteButton.isHidden = true
        stackView.addArrangedSubview(searchField)

        cancelButton = UIButton()
        stackView.addArrangedSubview(cancelButton)
    }

    func styleViews() {
        searchField.backgroundColor = .gray
        searchField.layer.cornerRadius = 10
        searchField.leftViewMode = .always
        searchField.rightViewMode = .always

        let font = ProximaNova.medium.of(size: SearchBarView.fontSize)
        let color = UIColor.darkBlue

        let placeholder = NSAttributedString(
            string: "Search",
            attributes: [
                NSAttributedString.Key.font: font as Any,
                NSAttributedString.Key.foregroundColor: color.withAlphaComponent(0.5) as Any])
        searchField.attributedPlaceholder = placeholder

        searchField.font = ProximaNova.medium.of(size: SearchBarView.fontSize)
        searchField.textColor = .darkBlue

        let attributedTitle = NSAttributedString(
            string: "Cancel",
            attributes: [
                NSAttributedString.Key.font: font as Any,
                NSAttributedString.Key.foregroundColor: color as Any])
        cancelButton.setAttributedTitle(attributedTitle, for: .normal)
        cancelButton.isHidden = true
        cancelButton.alpha = 0
    }

    func defineLayoutForViews() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(SearchBarView.defaultHeight)
        }

        stackView.spacing = SearchBarView.defaultSpacing
    }

}
