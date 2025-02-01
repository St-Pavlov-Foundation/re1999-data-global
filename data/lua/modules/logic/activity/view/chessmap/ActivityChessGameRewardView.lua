module("modules.logic.activity.view.chessmap.ActivityChessGameRewardView", package.seeall)

slot0 = class("ActivityChessGameRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg2")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_icon")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._txtrewardnamecn = gohelper.findChildText(slot0.viewGO, "inforoot/#txt_rewardnamecn")
	slot0._txtrewardnameen = gohelper.findChildText(slot0.viewGO, "inforoot/#txt_rewardnamecn/#txt_rewardnameen")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simageicon:UnLoadImage()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PickUpItem)

	if not string.nilorempty(slot0.viewParam.config.showParam) then
		slot0._simageicon:LoadImage(ResUrl.getVersionactivitychessIcon(slot1.showParam))
	end

	slot0._txtrewardnamecn.text = slot1.name
	slot0._txtrewardnameen.text = slot1.name_en or ""
end

function slot0.onClose(slot0)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.RewardIsClose)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

return slot0
