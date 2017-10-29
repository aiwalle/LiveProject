//
//  LJRoomController.swift
//  LiveProject
//
//  Created by liang on 2017/8/29.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit
import IJKMediaFramework

private let kChatToolsViewHeight : CGFloat = 44
private let kChatContentViewHeight : CGFloat = 200
let kGiftlistViewHeight : CGFloat = kDeviceHeight * 0.5

class LJRoomController: UIViewController, Emitterable {
    @IBOutlet weak var bgImageView: UIImageView!

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var roomNumberLabel: UILabel!
    
    fileprivate lazy var chatContentView : LJChatContentView = LJChatContentView()
    fileprivate lazy var chatToolsView : LJChatToolsView = LJChatToolsView()
    fileprivate lazy var giftListView : LJGiftListView = LJGiftListView.loadFromNib()
    // home: 192.168.0.181
    // comp: 172.16.25.101
    fileprivate lazy var socket = LJSocket(addr: "192.168.0.181", port: 9999)
    
    fileprivate lazy var giftContainerView: LJGiftContainerView = LJGiftContainerView(frame: CGRect(x: 0, y: 100, width: 250, height: 100))
    
    fileprivate var beatTimer : Timer!
    
    fileprivate lazy var roomVM: LJRoomViewModel = LJRoomViewModel()
    
    fileprivate var player: IJKFFMoviePlayerController?
    
    var anchor : AnchorModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_ :)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        
        if socket.connectServe(timeout: 10) {
            socket.readMessage()
            addBeatTimer()
            socket.sendEnterRoom()
            socket.delegate = self
        }
        
        loadRoomInfo()
        
        setupAnchorInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        socket.sendLeaveRoom()
        player?.shutdown()
    }
    
    deinit {
        beatTimer.invalidate()
        beatTimer = nil
        NotificationCenter.default.removeObserver(self)
    }
    
}

// MARK:- 设置UI
extension  LJRoomController {
    fileprivate func setupUI() {
        setupBlurView()
        
        setupBottomView()
        
        view.addSubview(giftContainerView)
    }
    
    fileprivate func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        // 下面这行代码是由于xib中获取到的frame不准确而添加的
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        blurView.frame = bgImageView.bounds
        bgImageView.addSubview(blurView)
    }
    
    fileprivate func setupBottomView() {
        chatContentView.frame = CGRect(x: 0, y: view.bounds.height - 44 - kChatContentViewHeight, width: view.bounds.width, height: kChatContentViewHeight)
//        chatContentView.backgroundColor = UIColor.red
        chatContentView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        view.addSubview(chatContentView)
        
        chatToolsView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: kChatToolsViewHeight)
        chatToolsView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        chatToolsView.delegate = self
        view.addSubview(chatToolsView)
        
        // 设置giftListView 368.0
        giftListView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: kGiftlistViewHeight)
        giftListView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        view.addSubview(giftListView)
        giftListView.delegate = self
    }
    
}


extension LJRoomController {
    fileprivate func loadRoomInfo() {
        if let roomid = anchor?.roomid, let uid = anchor?.uid {
            print(roomid, uid)
            roomVM.loadLiveURL(roomid, uid, {
                self.setupDisplayView()
            })
        }
    }
    
    fileprivate func setupDisplayView() {
        IJKFFMoviePlayerController.setLogReport(false)
        let url = URL(string: roomVM.liveURL)
        player = IJKFFMoviePlayerController(contentURL: url, with: nil)
        if anchor?.push == 1 {
            player?.view.frame = CGRect(x: 0, y: 150, width: kDeviceWidth, height: kDeviceWidth * 3 / 4)
        } else {
            player?.view.frame = UIScreen.main.bounds
        }
        bgImageView.insertSubview((player?.view)!, at: 1)
        
        DispatchQueue.global().async {
            self.player?.prepareToPlay()
            self.player?.play()
        }
    }
    
    fileprivate func setupAnchorInfo() {
        bgImageView.setImage(anchor?.pic74)
        nickNameLabel.text = anchor?.name
        roomNumberLabel.text = "房间号：\(anchor!.roomid)"
        iconImageView.setImage(anchor?.pic51)
    }
}

extension LJRoomController {
    @IBAction func exitBtnClick(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        chatToolsView.inputTextField.resignFirstResponder()
        UIView.animate(withDuration: 0.35, animations: {
            self.giftListView.frame.origin.y = kDeviceHeight
        })
    }
    
    @IBAction func bottomBtnClick(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            chatToolsView.inputTextField.becomeFirstResponder()
        case 1:
            print("点击了分享")
        case 2:
            UIView.animate(withDuration: 0.25, animations: {
                self.giftListView.frame.origin.y = kDeviceHeight - kGiftlistViewHeight
            })
        case 3:
            print("点击了更多")
        case 4:
            sender.isSelected = !sender.isSelected
            let point = CGPoint(x: sender.center.x, y: view.bounds.height - sender.bounds.height * 0.5)
            sender.isSelected ? startEmittering(point) : stopEmittering()
        default:
            fatalError("未处理按钮")
        }
        
    }
}

extension LJRoomController {
    @objc fileprivate func keyboardWillChangeFrame(_ note : Notification) {
        let duration = note.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        let endFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let inputViewY = endFrame.origin.y - kChatToolsViewHeight
        UIView.animate(withDuration: duration, animations: {
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
            let endY = inputViewY == (kDeviceHeight - kChatToolsViewHeight) ? kDeviceHeight : inputViewY
            self.chatToolsView.frame.origin.y = endY
            let contentEndY = inputViewY == (kDeviceHeight - kChatToolsViewHeight) ? (kDeviceHeight - kChatContentViewHeight - 44) : endY - kChatContentViewHeight
            self.chatContentView.frame.origin.y = contentEndY
        })
        
    }
}

extension LJRoomController : LJChatToolsViewDelegate, LJGiftListViewDelegate {
    func chatToolsView(_ chatToolsView: LJChatToolsView, message: String) {
        socket.sendTextMsg(message)
    }
    
    func giftListView(_ giftListView : LJGiftListView, giftModel : LJGiftModel) {
        socket.sendGiftMsg(giftModel.subject, giftUrlStr: giftModel.img2, giftCount: giftModel.coin)
    }
}


extension LJRoomController {
    fileprivate func addBeatTimer() {
        beatTimer = Timer(fireAt: Date(), interval: 9, target: self, selector: #selector(sendHeartBeat), userInfo: nil, repeats: true)
        RunLoop.main.add(beatTimer, forMode: RunLoopMode.commonModes)
    }
    
    @objc func sendHeartBeat() {
        socket.sendHeartBeat()
    }
    
}

// MARK:- 接收到服务器的消息
extension LJRoomController : LJSocketDelegate {
    func socket(_ socket: LJSocket, enterRoom user: UserInfo) {
        chatContentView.insertMsg(LJAttributeStringGenerator.generateRoom(isJoin: true, userName: user.name))
    }
    
    func socket(_ socket: LJSocket, leaveRoom user: UserInfo) {
        chatContentView.insertMsg(LJAttributeStringGenerator.generateRoom(isJoin: false, userName: user.name))
    }
    
    func socket(_ socket: LJSocket, textMsg: ChatMessage) {
        let font = UIFont.systemFont(ofSize: 15)
        chatContentView.insertMsg(LJAttributeStringGenerator.generateChatMessage(textMsg.user.name, textMsg.text, font.lineHeight))
    }
    
    func socket(_ socket: LJSocket, giftMsg: GiftMessage) {
        let font = UIFont.systemFont(ofSize: 15)
        chatContentView.insertMsg(LJAttributeStringGenerator.generateGiftMessage(giftMsg.user.name, giftMsg.giftname, giftMsg.giftUrl, font.lineHeight))
        
        let gift = LJGiftAnimationModel(senderName: giftMsg.user.name, senderURL: giftMsg.user.iconUrl, giftName: giftMsg.giftname, giftURL: giftMsg.giftUrl)
        giftContainerView.showGiftModel(gift)
    }
}



