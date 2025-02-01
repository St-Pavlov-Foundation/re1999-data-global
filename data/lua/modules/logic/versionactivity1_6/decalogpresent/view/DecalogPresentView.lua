module("modules.logic.versionactivity1_6.decalogpresent.view.DecalogPresentView", package.seeall)

slot0 = class("DecalogPresentView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtremainTime = gohelper.findChildText(slot0.viewGO, "image_TimeBG/#txt_remainTime")
	slot0._btnClaim = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Claim", AudioEnum.UI.Play_UI_Tags)
	slot0._goNormal = gohelper.findChild(slot0.viewGO, "#btn_Claim/#go_Normal")
	slot0._goHasReceived = gohelper.findChild(slot0.viewGO, "#btn_Claim/#go_Received")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClaim:AddClickListener(slot0._btnClaimOnClick, slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, slot0.refreshReceiveStatus, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClaim:RemoveClickListener()
	slot0._btnClose:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, slot0.refreshReceiveStatus, slot0)
end

function slot0._btnClaimOnClick(slot0)
	DecalogPresentController.instance:receiveDecalogPresent()
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshReceiveStatus()
	slot0:refreshRemainTime()
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, TimeUtil.OneMinuteSecond)
	AudioMgr.instance:trigger(AudioEnum.main_ui.play_ui_task_page)
end

function slot0.refreshRemainTime(slot0)
	slot0._txtremainTime.text = string.format(luaLang("remain"), ActivityModel.instance:getActMO(DecalogPresentModel.instance:getDecalogPresentActId()):getRemainTimeStr3(false, true))
end

function slot0.refreshReceiveStatus(slot0)
	slot3 = ActivityType101Model.instance:isType101RewardCouldGet(DecalogPresentModel.instance:getDecalogPresentActId(), DecalogPresentModel.REWARD_INDEX)

	gohelper.setActive(slot0._goNormal, slot3)
	gohelper.setActive(slot0._goHasReceived, not slot3)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

return slot0
