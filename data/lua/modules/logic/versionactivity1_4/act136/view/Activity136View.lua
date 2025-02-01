module("modules.logic.versionactivity1_4.act136.view.Activity136View", package.seeall)

slot0 = class("Activity136View", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._txtremainTime = gohelper.findChildText(slot0.viewGO, "timebg/#txt_remainTime")
	slot0._goUninvite = gohelper.findChild(slot0.viewGO, "#go_inviteContent/#go_uninvite")
	slot0._btnInvite = gohelper.findChildButton(slot0.viewGO, "#go_inviteContent/#go_uninvite/#btn_invite")
	slot0._goInvited = gohelper.findChild(slot0.viewGO, "#go_inviteContent/#go_invited")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnInvite:AddClickListener(slot0._btnInviteOnClick, slot0)
	Activity136Controller.instance:registerCallback(Activity136Event.ActivityDataUpdate, slot0.refresh, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnInvite:RemoveClickListener()
	Activity136Controller.instance:unregisterCallback(Activity136Event.ActivityDataUpdate, slot0.refresh, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnInviteOnClick(slot0)
	Activity136Controller.instance:openActivity136ChoiceView()
end

function slot0.onOpen(slot0)
	slot0:refresh()
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, TimeUtil.OneMinuteSecond)
end

function slot0.refresh(slot0)
	slot0:refreshStatus()
	slot0:refreshRemainTime()
end

function slot0.refreshStatus(slot0)
	slot1 = Activity136Model.instance:hasReceivedCharacter()

	gohelper.setActive(slot0._goInvited, slot1)
	gohelper.setActive(slot0._goUninvite, not slot1)
end

function slot0.refreshRemainTime(slot0)
	slot3, slot4 = slot0:_getRemainTimeStr(ActivityModel.instance:getActMO(Activity136Model.instance:getCurActivity136Id()))
	slot0._txtremainTime.text = string.format(luaLang("remain"), slot3)

	if slot4 then
		TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
	end
end

function slot0.onClose(slot0)
	if slot0.viewParam and slot0.viewParam.callback then
		slot0.viewParam.callback(slot0.viewParam.callbackObj)
	end

	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

function slot0._getRemainTimeStr(slot0, slot1)
	slot2 = nil

	if slot1 then
		slot2 = slot1:getRealEndTimeStamp() - ServerTime.now()
	end

	if not slot2 or slot2 <= 0 then
		return luaLang("turnback_end"), true
	end

	slot3, slot4, slot5, slot6 = TimeUtil.secondsToDDHHMMSS(slot2)

	if slot3 > 0 then
		if LangSettings.instance:isEn() then
			slot7 = luaLang("time_day") .. " "
		end

		return slot3 .. slot7 .. slot4 .. luaLang("time_hour2")
	end

	if slot4 > 0 then
		return slot4 .. luaLang("time_hour2")
	end

	if slot5 <= 0 then
		slot5 = "<1"
	end

	return slot5 .. luaLang("time_minute2")
end

return slot0
