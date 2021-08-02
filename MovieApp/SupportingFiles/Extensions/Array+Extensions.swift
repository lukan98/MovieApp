extension Array {

    /**
     Allows for returning of 'nil' values in case a specified index is out of bounds.

     - parameter index: Index of array element to return.
     - returns: Array element or 'nil' if index is out of array bounds.
     */
    func at(_ index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }

        return self[index]
    }
    
}
