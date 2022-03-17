//
//  VideoContainerView.swift
//  Manila
//
//  Created by Neil Sardesai on 3/10/22.
//

import AVKit
import Cocoa

class VideoContainerView: NSView {
    
    private var playerLooper: AVPlayerLooper!
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setUpPlayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpPlayer()
    }
    
    override var wantsUpdateLayer: Bool { true }
    
    override func updateLayer() {
        layer!.cornerCurve = .continuous
        layer!.cornerRadius = 8
        layer!.masksToBounds = true
    }
    
    private func setUpPlayer() {
        let playerView = AVPlayerView()
        playerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(playerView)
        NSLayoutConstraint.activate([
            playerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            playerView.topAnchor.constraint(equalTo: topAnchor),
            playerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        let asset = AVAsset(url: Bundle.main.url(forResource: "Welcome", withExtension: "mp4")!)
        let item = AVPlayerItem(asset: asset)
        let player = AVQueuePlayer(playerItem: item)
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        playerView.player = player
        playerView.updatesNowPlayingInfoCenter = false
        playerView.showsFullScreenToggleButton = true
        player.play()
    }
    
}
