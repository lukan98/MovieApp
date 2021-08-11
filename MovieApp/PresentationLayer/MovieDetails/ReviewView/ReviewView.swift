import UIKit

class ReviewView: UIView {

    var headerView: UIView!
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    var dateLabel: UILabel!
    var avatarImageView: UIImageView!
    var reviewLabel: UILabel!

    init() {
        super.init(frame: .zero)

        buildViews()
        setData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        
    }

    private func setData() {
        titleLabel.text = "A review by The Peruvian Post"

        subtitleLabel.text = "Written by The Peruvian Post on"
        dateLabel.text = "February 17, 2020"

        avatarImageView.image = UIImage(named: "Reviewer-avatar")

        reviewLabel.text = """
When I caught up with "Iron Man," a broken hip had delayed me and the movie had already been playing for three weeks. What I heard during that time was that a lot of people loved it, that they were surprised to love it so much, and that Robert Downey Jr.'s performance was special. Apart from that, all I knew was that the movie was about a big iron man. I didn't even know that a human occupied it, and halfway thought that the Downey character's brain had been transplanted into a robot, or a fate equally weird.
Yes, I knew I was looking at sets and special effects--but I'm referring to the reality of the illusion, if that make any sense. With many superhero movies, all you get is the surface of the illusion. With "Iron Man," you get a glimpse into the depths. You get the feeling, for example, of a functioning corporation. Consider the characters of Pepper Potts (Gwyneth Paltrow), Stark's loyal aide, and Obadiah Stane (Jeff Bridges), Stark's business partner. They don't feel drummed up for the occasion. They seem to have worked together for awhile.

Much of that feeling is created by the chemistry involving Downey, Paltrow and Bridges. They have relationships that seem fully-formed and resilient enough to last through the whole movie, even if plot mechanics were not about to take them to another level. Between the two men, there are echoes of the relationship between Howard Hughes and Noah Dietrich in Scorsese's "The Aviator" (2004). Obadiah Stane doesn't come onscreen waving flags and winking at the camera to announce he is the villain; he seems adequately explained simply as the voice of reason at Stark's press conference. (Why did "Stark," during that scene, make me think of "staring mad?"). Between Stark and Pepper, there's that classic screen tension between "friends" who know they can potentially become lovers.

Downey's performance is intriguing, and unexpected. He doesn't behave like most superheroes: he lacks the psychic weight and gravitas. Tony Stark is created from the persona Downey has fashioned through many movies: irreverent, quirky, self-deprecating, wise-cracking. The fact that Downey is allowed to think and talk the way he does while wearing all that hardware represents a bold decision by the director, Jon Favreau. If he hadn't desired that, he probably wouldn't have hired Downey. So comfortable is Downey with Tony Stark's dialogue, so familiar does it sound coming from him, that the screenplay seems almost to have been dictated by Downey's persona.
There are some things that some actors can safely say onscreen, and other things they can't. The Robert Downey Jr. persona would find it difficult to get away with weighty, profound statements (in an "entertainment," anyway--a more serious film like "Zodiac" is another matter). Some superheroes speak in a kind of heightened, semi-formal prose, as if dictating to Bartlett's Familiar Quotations. Not Tony Stark. He could talk that way and be Juno's uncle. "Iron Man" doesn't seem to know how seriously most superhero movies take themselves. If there is wit in the dialog, the superhero is often supposed to be unaware of it. If there is broad humor, it usually belongs to the villain. What happens in "Iron Man," however, is that sometimes we wonder how seriously even Stark takes it. He's flippant in the face of disaster, casual on the brink of ruin.
"""
    }

}
