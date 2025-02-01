module("modules.logic.activity.view.V1a5_DoubleFestival_WishPanelContainer", package.seeall)

slot0 = class("V1a5_DoubleFestival_WishPanelContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		V1a5_DoubleFestival_WishPanel.New()
	}
end

function slot0.playOpenTransition(slot0)
	AudioMgr.instance:trigger(AudioEnum.ui_mail.play_ui_mail_open_1)
	slot0:onPlayOpenTransitionFinish()
end

return slot0
