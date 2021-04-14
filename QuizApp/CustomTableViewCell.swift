
import UIKit

class CustomTableViewCell: UITableViewCell {

    var imgQuiz : UIImageView!
    var titleQuiz : UILabel!
    var descriptionQuiz : UILabel!
    var levelQuiz : UILabel!
    
    //var imgQuiz = UIImageView()
    //var titleQuiz = UILabel()
    //var descriptionQuiz = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            buildViews()
            imgQuiz.translatesAutoresizingMaskIntoConstraints = false
            titleQuiz.translatesAutoresizingMaskIntoConstraints = false
            descriptionQuiz.translatesAutoresizingMaskIntoConstraints = false
            addConstraints()
        }

    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViews() {
        imgQuiz = UIImageView()
        titleQuiz = UILabel()
        titleQuiz.font = UIFont.boldSystemFont(ofSize: 20.0)
        titleQuiz.lineBreakMode = .byWordWrapping // notice the 'b' instead of 'B'
        titleQuiz.numberOfLines = 0
        descriptionQuiz = UILabel()
        descriptionQuiz.lineBreakMode = .byWordWrapping // notice the 'b' instead of 'B'
        descriptionQuiz.numberOfLines = 0
        levelQuiz = UILabel()
        levelQuiz.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        
        addSubview(imgQuiz)
        addSubview(titleQuiz)
        addSubview(descriptionQuiz)
        addSubview(levelQuiz)
    }
    
    private func addConstraints() {
        imgQuiz.autoPinEdge(toSuperviewSafeArea: .top, withInset: 20)
        imgQuiz.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 20)
        imgQuiz.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        imgQuiz.autoSetDimension(.width, toSize: 100)
        
        titleQuiz.autoPinEdge(.leading, to: .trailing, of: imgQuiz, withOffset: 10)
        titleQuiz.autoPinEdge(toSuperviewSafeArea: .top, withInset: 20)
        titleQuiz.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 10)
        
        descriptionQuiz.autoPinEdge(.top, to: .bottom, of: titleQuiz, withOffset: 10)
        descriptionQuiz.autoPinEdge(.leading, to: .trailing, of: imgQuiz, withOffset: 10)
        descriptionQuiz.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 10)
        
        levelQuiz.autoPinEdge(.top, to: .bottom, of: descriptionQuiz, withOffset: 10)
        levelQuiz.autoPinEdge(.leading, to: .trailing, of: imgQuiz, withOffset: 20)
        levelQuiz.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 10)
    }
    

}
