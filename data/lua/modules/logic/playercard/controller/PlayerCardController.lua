module("modules.logic.playercard.controller.PlayerCardController", package.seeall)

slot0 = class("PlayerCardController", BaseController)

function slot0.reInit(slot0)
	slot0.viewParam = nil
end

function slot0.openPlayerCardView(slot0, slot1)
end

function slot0._openPlayerCardView(slot0)
	ViewMgr.instance:openView(ViewName.PlayerCardView, slot0.viewParam)
end

function slot0.playChangeEffectAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_5_wulu.play_ui_wulu_seal_cutting_eft)
end

slot0.instance = slot0.New()

return slot0
