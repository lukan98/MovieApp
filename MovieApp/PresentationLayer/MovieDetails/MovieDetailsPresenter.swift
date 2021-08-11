import Foundation

class MovieDetailsPresenter {

    private let useCase: MovieUseCaseProtocol

    init(useCase: MovieUseCaseProtocol) {
        self.useCase = useCase
    }

    func getMovieDetails(
        _ completionHandler: @escaping (Result<DetailedMovieViewModel, RequestError>) -> Void,
        for movieId: Int = 103
    ) {
        useCase.getMovieDetails(for: movieId) { result in
            DispatchQueue.main.async {
                completionHandler(result.map { DetailedMovieViewModel(from: $0) } )
            }
        }
    }

    func getMovieCredits(
        maximumCrewMembers max: Int,
        _ completionHandler: @escaping (Result<CreditsViewModel, RequestError>) -> Void,
        for movieId: Int = 103
    ) {
        useCase.getMovieCredits(for: movieId) { result in
            DispatchQueue.main.async {
                completionHandler(result.map { CreditsViewModel(from: $0).sortAndSliceCrew(first: max) } )
            }
        }
    }

    func getReview(
        _ completionHandler: @escaping (Result<ReviewViewModel, RequestError>) -> Void,
        for movieId: Int = 103
    ) {
        let mockReview = ReviewViewModel(
            id: 0,
            author: "The Peruvian Post",
            avatarSource: "https://image.tmdb.org/t/p/w185/xNLOqXXVJf9m7WngUMLIMFsjKgh.jpg",
            review: """
            When I caught up with "Iron Man," a broken hip had delayed me and the movie had already been playing for three weeks. What I heard during that time was that a lot of people loved it, that they were surprised to love it so much, and that Robert Downey Jr.'s performance was special. Apart from that, all I knew was that the movie was about a big iron man. I didn't even know that a human occupied it, and halfway thought that the Downey character's brain had been transplanted into a robot, or a fate equally weird.
            Yes, I knew I was looking at sets and special effects--but I'm referring to the reality of the illusion, if that make any sense. With many superhero movies, all you get is the surface of the illusion. With "Iron Man," you get a glimpse into the depths. You get the feeling, for example, of a functioning corporation. Consider the characters of Pepper Potts (Gwyneth Paltrow), Stark's loyal aide, and Obadiah Stane (Jeff Bridges), Stark's business partner. They don't feel drummed up for the occasion. They seem to have worked together for awhile.

            Much of that feeling is created by the chemistry involving Downey, Paltrow and Bridges. They have relationships that seem fully-formed and resilient enough to last through the whole movie, even if plot mechanics were not about to take them to another level. Between the two men, there are echoes of the relationship between Howard Hughes and Noah Dietrich in Scorsese's "The Aviator" (2004). Obadiah Stane doesn't come onscreen waving flags and winking at the camera to announce he is the villain; he seems adequately explained simply as the voice of reason at Stark's press conference. (Why did "Stark," during that scene, make me think of "staring mad?"). Between Stark and Pepper, there's that classic screen tension between "friends" who know they can potentially become lovers.
            """,
            date: "February 17, 2010")

        DispatchQueue.main.async {
            completionHandler(.success(mockReview))
        }
    }

}
