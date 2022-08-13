import Orion
import HeadlineNewsWindowC
import UIKit

var localSettings = Settings()

struct tweak: HookGroup {}

class SpringBoard_Hook: ClassHook<SpringBoard> {
    typealias Group = tweak
    
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
        
        headlineNewsView.speed = localSettings.textSpeed
        headlineNewsView.backgroundColor = localSettings.backgroundColor
        headlineNewsView.font = .systemFont(ofSize: localSettings.fontSize)
        headlineNewsView.textColor = localSettings.textColor
        
        newsWindow.isHidden = false
        newsWindow.makeKeyAndVisible()
        
        let gesture = UITapGestureRecognizer(target: UIApplication.shared, action: #selector(tapped))
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
            
            let items = parser.parse(with: localSettings.rssURLs) as! [Item]
            headlineNewsView.startAnimating(with: items)
        }
    }
}

func readPrefs() {
    let path = "/var/mobile/Library/Preferences/com.p-x9.headlinenewswindow.pref.plist"
    let url = URL(fileURLWithPath: path)
    
    //Reading values
    guard let data = try? Data(contentsOf: url) else {
        return
    }
    let decoder = PropertyListDecoder()
    localSettings =  (try? decoder.decode(Settings.self, from: data)) ?? Settings()
}

func settingChanged() {
    readPrefs()
}

func observePrefsChange() {
    let NOTIFY = "com.p-x9.headlinenewswindow.prefschanged" as CFString

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    nil, { _, _, _, _, _ in
        settingChanged()
    }, NOTIFY, nil, CFNotificationSuspensionBehavior.deliverImmediately)
}


struct CCAnimator: Tweak {
    init() {
        readPrefs()
        observePrefsChange()
        
        guard localSettings.isTweakEnabled else {
            return
        }
        
        tweak().activate()
    }
}
