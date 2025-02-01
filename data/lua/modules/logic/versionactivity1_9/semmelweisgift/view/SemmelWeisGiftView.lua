module("modules.logic.versionactivity1_9.semmelweisgift.view.SemmelWeisGiftView", package.seeall)

slot0 = class("SemmelWeisGiftView", DecalogPresentView)

function slot0.onInitView(slot0)
	slot0._txtremainTime = gohelper.findChildText(slot0.viewGO, "Root/image_TimeBG/#txt_remainTime")
	slot0._btnClaim = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#btn_Claim")
	slot0._goNormal = gohelper.findChild(slot0.viewGO, "Root/#btn_Claim/#go_Normal")
	slot0._goHasReceived = gohelper.findChild(slot0.viewGO, "Root/#btn_Claim/#go_Received")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#btn_Close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._btnClaimOnClick(slot0)
	SemmelWeisGiftController.instance:receiveSemmelWeisGift()
end

function slot0.refreshReceiveStatus(slot0)
	slot3 = ActivityType101Model.instance:isType101RewardCouldGet(SemmelWeisGiftModel.instance:getSemmelWeisGiftActId(), SemmelWeisGiftModel.REWARD_INDEX)

	gohelper.setActive(slot0._goNormal, slot3)
	gohelper.setActive(slot0._goHasReceived, not slot3)
end

function slot0.refreshRemainTime(slot0)
	slot0._txtremainTime.text = string.format(luaLang("remain"), ActivityModel.instance:getActMO(SemmelWeisGiftModel.instance:getSemmelWeisGiftActId()):getRemainTimeStr3(false, true))
end

return slot0
