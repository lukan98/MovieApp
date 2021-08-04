struct TimeComponentsViewModel {

    var uiString: String {
        "\(hours)h \(minutes)m"
    }

    let hours: Int
    let minutes: Int

}

extension TimeComponentsViewModel {

    init(minutes: Int) {
        hours = minutes / 60
        self.minutes = minutes % 60
    }

}
