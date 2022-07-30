import Orion
import HeadlineNewsWindowC
import UIKit


class SpringBoard_Hook: ClassHook<SpringBoard> {
    @Property(.nonatomic, .retain) var headlineNewsView: HeadLineNewsView? = nil
    @Property(.nonatomic, .retain) var newsWindow: UIWindow? = nil
    @Property(.nonatomic, .retain) var parser: RSSParser? = nil
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        orig.applicationDidFinishLaunching(application)
        
        
        headlineNewsView = HeadLineNewsView()
        newsWindow = UIWindow()
        parser = RSSParser()
        
        setupNewsWindow()
    }
    
    // orion:new
    func setupNewsWindow() {
        guard let headlineNewsView = headlineNewsView,
              let newsWindow = newsWindow else {
            return
        }

        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 20
        newsWindow.bounds = .init(origin: .zero,
                                 size: .init(width: width, height: height))
        newsWindow.center = .init(x: width/2, y: height/2)
        newsWindow.windowLevel = .init(rawValue: 1_000_000_000_000)
        
        newsWindow.addSubview(headlineNewsView)
        headlineNewsView.frame = newsWindow.bounds
        headlineNewsView.speed = 0.5
        
        newsWindow.backgroundColor = .red
        newsWindow.isHidden = false
        newsWindow.makeKeyAndVisible()
        
        let gesture = UITapGestureRecognizer(target: UIApplication.shared, action: Selector("tapped"))
        newsWindow.addGestureRecognizer(gesture)
    }
    
    // orion:new
    func tapped() {
        guard let headlineNewsView = headlineNewsView,
              let parser = parser else {
            return
        }
        
        if headlineNewsView.isRunning {
            headlineNewsView.stopAnimation()
        } else {
            let items = parser.parse(with: URL(string: "https://rss.itmedia.co.jp/rss/2.0/itmedia_all.xml")!) as! [Item]
            headlineNewsView.startAnimating(with: items)
        }
    }
}
