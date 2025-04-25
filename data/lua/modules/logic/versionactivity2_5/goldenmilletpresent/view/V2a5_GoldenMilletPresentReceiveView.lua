module("modules.logic.versionactivity2_5.goldenmilletpresent.view.V2a5_GoldenMilletPresentReceiveView", package.seeall)

slot0 = class("V2a5_GoldenMilletPresentReceiveView", BaseViewExtended)

function slot0.onInitView(slot0)
	gohelper.setActive(slot0.viewGO, true)

	slot0._txtReceiveRemainTime = gohelper.findChildText(slot0.viewGO, "image_TimeBG/#txt_remainTime")
	slot0._btnClaim = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Claim")
	slot0._goNormal = gohelper.findChild(slot0.viewGO, "#btn_Claim/#go_Normal")
	slot0._goHasReceived = gohelper.findChild(slot0.viewGO, "#btn_Claim/#go_Received")
	slot0._btnCloseReceive = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")
	slot0._btnBgClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "close")
end

function slot0.addEvents(slot0)
	slot0._btnClaim:AddClickListener(slot0._btnClaimOnClick, slot0)

	if slot0._btnCloseReceive then
		slot0._btnCloseReceive:AddClickListener(slot0._btnCloseReceiveOnClick, slot0)
	end

	if slot0._btnBgClose then
		slot0._btnBgClose:AddClickListener(slot0._btnCloseReceiveOnClick, slot0)
	end

	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.afterReceive, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClaim:RemoveClickListener()

	if slot0._btnCloseReceive then
		slot0._btnCloseReceive:RemoveClickListener()
	end

	if slot0._btnBgClose then
		slot0._btnBgClose:RemoveClickListener()
	end

	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.afterReceive, slot0)
end

function slot0._btnClaimOnClick(slot0)
	GoldenMilletPresentController.instance:receiveGoldenMilletPresent(slot0.afterReceive, slot0)
	AudioMgr.instance:trigger(AudioEnum.GoldenMillet.stop_ui_tangren_songpifu_loop)
end

function slot0._btnCloseReceiveOnClick(slot0)
	slot0.viewContainer:openGoldMilletPresentDisplayView()
	AudioMgr.instance:trigger(AudioEnum.GoldenMillet.stop_ui_tangren_songpifu_loop)
end

function slot0.onOpen(slot0)
	slot0:refreshRemainTime()
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, TimeUtil.OneMinuteSecond)
	slot0:refreshReceiveStatus()
	AudioMgr.instance:trigger(AudioEnum.UI.GoldenMilletReceiveViewOpen)
	AudioMgr.instance:trigger(AudioEnum.GoldenMillet.play_ui_tangren_songpifu_loop)
end

function slot0.refreshReceiveStatus(slot0)
	slot1 = GoldenMilletPresentModel.instance:haveReceivedSkin()

	gohelper.setActive(slot0._goNormal, not slot1)
	gohelper.setActive(slot0._goHasReceived, slot1)
end

function slot0.afterReceive(slot0, slot1)
	if slot1 == ViewName.CharacterSkinGainView then
		slot0.viewContainer:openGoldMilletPresentDisplayView()
	end
end

function slot0.refreshRemainTime(slot0)
	slot0._txtReceiveRemainTime.text = string.format(luaLang("remain"), ActivityModel.instance:getActMO(GoldenMilletPresentModel.instance:getGoldenMilletPresentActId()):getRemainTimeStr3(false, true))
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
	AudioMgr.instance:trigger(AudioEnum.GoldenMillet.stop_ui_tangren_songpifu_loop)
end

return slot0
