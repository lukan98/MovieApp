import UIKit

extension UILabel {

    var visibleTextLength: Int {
        layoutIfNeeded()

        let labelWidth = frame.size.width
        let labelHeight = frame.size.height
        let sizeConstraint = CGSize(width: labelWidth, height: .greatestFiniteMagnitude)

        if let labelText = text {
            let attributes = [NSAttributedString.Key.font: font]
            let attributedText = NSAttributedString(
                string: labelText,
                attributes: attributes as [NSAttributedString.Key : Any])
            let boundingRect = attributedText.boundingRect(
                with: sizeConstraint,
                options: .usesLineFragmentOrigin,
                context: nil)

            if boundingRect.size.height > labelHeight {
                var currentIndex = 0
                var previousIndex = 0

                repeat {
                    previousIndex = currentIndex
                    if lineBreakMode == .byCharWrapping {
                        currentIndex += 1
                    } else {
                        currentIndex = NSString(string: labelText)
                            .rangeOfCharacter(
                                from: .whitespacesAndNewlines,
                                options: [],
                                range: _NSRange(location: currentIndex + 1, length: labelText.count - currentIndex - 1))
                            .location
                    }
                } while
                    currentIndex != NSNotFound &&
                    currentIndex < labelText.count &&
                    NSString(string: NSString(string: labelText).substring(to: currentIndex))
                    .boundingRect(
                        with: sizeConstraint,
                        options: .usesLineFragmentOrigin,
                        attributes: attributes as [NSAttributedString.Key : Any],
                        context: nil)
                    .size
                    .height <= labelHeight
                return previousIndex
            }
        }

        if self.text == nil {
            return 0
        } else {
            return self.text!.count
        }
    }

    func addTrailing(
        with trailingText: String,
        appendageText: String,
        appendageFont: UIFont?,
        appendageColor: UIColor?
    ) {
        let readMoreText = trailingText + appendageText
        if visibleTextLength == 0 { return }

        if let labelText = text {
            let mutableString = labelText
            let trimmedString: String? = NSString(string: mutableString)
                .replacingCharacters(
                    in: _NSRange(
                        location: visibleTextLength,
                        length: labelText.count - visibleTextLength),
                    with: "")

            guard let safeTrimmedString = trimmedString else { return }

            if safeTrimmedString.count <= readMoreText.count { return }

            let trimmedForReadMore = NSString(string: safeTrimmedString)
                .replacingCharacters(
                    in: NSRange(location: safeTrimmedString.count - readMoreText.count, length: readMoreText.count),
                    with: "") + trailingText
            let attributedText = NSMutableAttributedString(
                string: trimmedForReadMore,
                attributes: [
                    NSAttributedString.Key.font: font as Any,
                    NSAttributedString.Key.foregroundColor: textColor as Any])
            let attributedReadMore = NSMutableAttributedString(
                string: appendageText,
                attributes: [
                    NSAttributedString.Key.font: appendageFont as Any,
                    NSAttributedString.Key.foregroundColor: appendageColor as Any])
            attributedText.append(attributedReadMore)
            self.attributedText = attributedText
        }

    }

}
