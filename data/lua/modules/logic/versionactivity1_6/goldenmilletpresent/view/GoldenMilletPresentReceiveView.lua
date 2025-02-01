module("modules.logic.versionactivity1_6.goldenmilletpresent.view.GoldenMilletPresentReceiveView", package.seeall)

slot0 = class("GoldenMilletPresentReceiveView", BaseViewExtended)

function slot0.onInitView(slot0)
	gohelper.setActive(slot0.viewGO, true)

	slot0._txtReceiveRemainTime = gohelper.findChildText(slot0.viewGO, "image_TimeBG/#txt_remainTime")
	slot0._btnClaim = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Claim")
	slot0._goNormal = gohelper.findChild(slot0.viewGO, "#btn_Claim/#go_Normal")
	slot0._goHasReceived = gohelper.findChild(slot0.viewGO, "#btn_Claim/#go_Received")
	slot0._btnCloseReceive = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")
end

function slot0.addEvents(slot0)
	slot0._btnClaim:AddClickListener(slot0._btnClaimOnClick, slot0)
	slot0._btnCloseReceive:AddClickListener(slot0._btnCloseReceiveOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClaim:RemoveClickListener()
	slot0._btnCloseReceive:RemoveClickListener()
end

function slot0._btnClaimOnClick(slot0)
	GoldenMilletPresentController.instance:receiveGoldenMilletPresent(slot0.refreshReceiveStatus, slot0)
end

function slot0._btnCloseReceiveOnClick(slot0)
	slot0.viewContainer:openGoldMilletPresentDisplayView()
end

function slot0.onOpen(slot0)
	slot0:refreshRemainTime()
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, TimeUtil.OneMinuteSecond)
	slot0:refreshReceiveStatus()
	AudioMgr.instance:trigger(AudioEnum.UI.GoldenMilletReceiveViewOpen)
end

function slot0.refreshReceiveStatus(slot0)
	slot1 = GoldenMilletPresentModel.instance:haveReceivedSkin()

	gohelper.setActive(slot0._goNormal, not slot1)
	gohelper.setActive(slot0._goHasReceived, slot1)
end

function slot0.refreshRemainTime(slot0)
	slot0._txtReceiveRemainTime.text = string.format(luaLang("remain"), TimeUtil.SecondToActivityTimeFormat(ActivityModel.instance:getActMO(GoldenMilletPresentModel.instance:getGoldenMilletPresentActId()):getRealEndTimeStamp() - ServerTime.now()))
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

return slot0
