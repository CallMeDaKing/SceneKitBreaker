import UIKit
import SceneKit

class  GameViewController :UIViewController{
    
    var scnView  :SCNView!
    var scnScene :SCNScene!
    var horizonalCameraNode :SCNNode!
    var verticalCameraNode  :SCNNode!
    var ballNode :SCNNode!
    var paddleNode: SCNNode!
    
    //调用游戏单俐（已经封装好的扩展方法等，尝试学会怎么用），可以快速开发，让你把更多的精力放到API的使用上
    var game = GameHelper.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScene()
        setUpSounds()
        setUpNode()
        
    }
    
    func  setUpScene() {
        
        scnView = self.view as! SCNView
        scnView.delegate = self
        
        scnScene = SCNScene(named: "Breaker.scnassets/Scenes/Game.scn")
//            SCNScene.init(named: "Breaker.scnassets/Scenes/Game.scn")
        scnView.scene = scnScene
    }
    
    func setUpNode() {
        
        scnScene.rootNode.addChildNode(game.hudNode)
        horizonalCameraNode = scnScene.rootNode.childNode(withName: "HorizontalCamera", recursively: true)
        verticalCameraNode = scnScene.rootNode.childNode(withName: "verticalCamera", recursively: true)
        ballNode = scnScene.rootNode.childNode(withName: "Ball", recursively: true)
        paddleNode = scnScene.rootNode.childNode(withName: "Paddle", recursively: true)
    }
    
    func  setUpSounds() {
        
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        let deviceOrientation = UIDevice.current.orientation
        
        switch (deviceOrientation) {
        case .portrait:
            
            scnView.pointOfView = verticalCameraNode
        default:
            scnView.pointOfView = horizonalCameraNode
        }
    }
    
    
    override var shouldAutorotate: Bool {return true}
    override var prefersStatusBarHidden: Bool {return true}
}

extension GameViewController :SCNSceneRendererDelegate{
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        game.updateHUD()
    }
}
