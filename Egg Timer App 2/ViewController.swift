
import UIKit
import UserNotifications
import Lottie



class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    
    @IBOutlet weak var progressBar: UIProgressView!
    var eggTimes : [String : Int] = ["Soft": 400 , "Medium": 480 , "Hard": 720]
    
    let softEggTime = 5
    let mediumEggTime = 8
    let hardEggTime = 12
    
    var timer : Timer?
    var counter = 0
    var progresss : Float = 0
    var secondsRemaining : Float = 1000
    var secondsRemainingBefore : Float = 1000
    @IBOutlet weak var doneLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    let center = UNUserNotificationCenter.current()
    
   // center.requestAuthorization(options: [.alert, .sound]){
     //   (granted, error) in}
        
    
    
    lazy var backgroundAnimationView: AnimationView = {
    
    
    
        let animationView = AnimationView()
        
        
        view.addSubview(animationView)
        
        
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
         
  
       animationView.widthAnchor.constraint(equalToConstant: 300).isActive = true
       animationView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        //animationView.frame.size = CGSize(width: 10, height: 10)
       
        
        
        
        
        
        return animationView
        
        
    }()
    
    private func playBackgroundAnimationBoom(){
        let animation = Animation.named("tick")
        backgroundAnimationView.animation = animation
        
        backgroundAnimationView.play{_ in
            self.backgroundAnimationView.isHidden = false
            
        }
        
       
        backgroundAnimationView.play(fromProgress: 0, toProgress: 0.3, loopMode: .playOnce)
        backgroundAnimationView.play { (finished) in
            self.backgroundAnimationView.isHidden = true
        }
        
    }
    
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    
    func sendNotificationFinished() {
        print("sending notification ---------")
        let center = UNUserNotificationCenter.current()
        
        let notificationContent = UNMutableNotificationContent()
        
        
        // notification content object
        notificationContent.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "notification.mp3"))
       
        center.delegate = self
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print(error?.localizedDescription as Any)
            }
        }
                                            
        notificationContent.title = "Egg Timer App"
        notificationContent.body = "Time's Up! Your Egg is Ready!"
        notificationContent.badge = NSNumber(value: 1)
        
       
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1,
                                                        repeats: false)
        
        
        let uuidString = UUID().uuidString

        
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: notificationContent,
                                            trigger: trigger)
        
       
        
        center.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    
    
    func sendNotification() {
        print("sending notification ---------")
        let center = UNUserNotificationCenter.current()
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Egg Timer App"
        notificationContent.body = "Your Chosen Egg Timer Has Started"
        notificationContent.badge = NSNumber(value: 3)
        
       
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1,
                                                        repeats: false)
        
        
        let uuidString = UUID().uuidString

        
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: notificationContent,
                                            trigger: trigger)
        
       
        
        center.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
                
               
            }
        }
    }
    
    
    
    @objc func prozessTimer() {
        
        //secondsRemainingBefore = secondsRemaining
                if secondsRemaining > 0 {
            print("\(secondsRemaining) seconds.")
                   
                    
                    print("\(secondsRemainingBefore)")
                    
                    
                    //progresss = (secondsRemaining / secondsRemainingBefore)
                    progresss = (Float(secondsRemaining) / Float(secondsRemainingBefore))
                    // tutaj zamiast ustalac poszczegolne wartosci jako float mozna by zapisac to po prostu jako: progresss = (float(secondsRemaining) / float(secondsRemainingBefore)
                    
                    
                    progressBar.progress = Float(progresss)
                    
                   /* if progresss <= 0.01 {
                        progressBar.progress = 0
                    }
                    */
                    secondsRemaining -= 1
                    
                   
                    if progresss == 1 {
                        progressBar.progress = 1
                    }
            if secondsRemaining != 0 {
                doneLabel.alpha = 0
            }else{
                sendNotificationFinished()
                progressBar.progress = 0
                doneLabel.alpha = 1
                //titleLabel.alpha = 0.1
                /*
                let center = UNUserNotificationCenter.current()
                
                center.requestAuthorization(options: [.alert, .sound]){
                    (granted, error) in
                    
                }
                
                let content = UNMutableNotificationContent()
                content.title = "Hey"
                content.body = "look"
                
                
                let date = Date().addingTimeInterval(1)
                let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1,
                                                                repeats: false)
                
                let uuidString = UUID().uuidString
                let request = UNNotificationRequest(identifier: "testNotification",
                                                    content: content,
                                                    trigger: trigger)
                center.add(request) { (error) in
                    if let error = error {
                        print("Notification Error: ", error)
                    }
                }
                
                
                
                //self.userNotificationCenter.delegate = self

                    //self.requestNotificationAuthorization()
                    //self.sendNotification()
                */
                
            }
            /*if secondsRemaining <= 0 {
                progressBar.progress = 0
                //doneLabel.alpha = 1
               // titleLabel.alpha = 0}
              */
                
            
            
            
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //userNotificationCenter.delegate = self
     
        UNUserNotificationCenter.current().delegate = self
        if secondsRemaining == 1000{
            progressBar.progress = 0
        }
    }
    @IBAction func softEgg(_ sender: UIButton) {
        sendNotification()
        print("soft egg selected")
        playBackgroundAnimationBoom()
    }
    
  
    @IBAction func mediumEgg(_ sender: UIButton) {
        sendNotification()
        print("medium egg selected")
        playBackgroundAnimationBoom()
    }
    

    @IBAction func hardEgg(_ sender: UIButton) {
        sendNotification()
        print("hard egg selected")
        playBackgroundAnimationBoom()
    }
    
    
    
    @IBAction func hardnessSelection(_ sender: UIButton) {
        
        timer?.invalidate()
        
        
        print(sender.currentTitle)
        
        let hardness = sender.currentTitle!
        /*
        if hardness == "Hard" {
            print(hardEggTime)
        }else if hardness == "Medium"{
            print(mediumEggTime)
        }else if hardness == "Soft"{
            print(softEggTime)
        }
        
           */
       
        secondsRemaining = Float(eggTimes[hardness]!)
        secondsRemainingBefore = Float(eggTimes[hardness]!)
        
        
        print(eggTimes[hardness])
        timer = Timer.scheduledTimer(timeInterval:1, target:self, selector:#selector(prozessTimer), userInfo: nil, repeats: true)
        
        //progressBar.progress = 100
        
        
        
        
        
        
        }
}

