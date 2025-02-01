module("modules.logic.versionactivity2_2.act136.view.Activity136FullView", package.seeall)

slot0 = class("Activity136FullView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtremainTime = gohelper.findChildText(slot0.viewGO, "timebg/#txt_remainTime")
	slot0._gouninvite = gohelper.findChild(slot0.viewGO, "#go_inviteContent/#go_uninvite")
	slot0._btninvite = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_inviteContent/#go_uninvite/#btn_invite")
	slot0._goinvited = gohelper.findChild(slot0.viewGO, "#go_inviteContent/#go_invited")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btninvite:AddClickListener(slot0._btninviteOnClick, slot0)
	Activity136Controller.instance:registerCallback(Activity136Event.ActivityDataUpdate, slot0.refresh, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btninvite:RemoveClickListener()
	Activity136Controller.instance:unregisterCallback(Activity136Event.ActivityDataUpdate, slot0.refresh, slot0)
end

function slot0._btninviteOnClick(slot0)
	Activity136Controller.instance:openActivity136ChoiceView()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
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

	gohelper.setActive(slot0._goinvited, slot1)
	gohelper.setActive(slot0._gouninvite, not slot1)
end

function slot0.refreshRemainTime(slot0)
	slot0._txtremainTime.text = string.format(luaLang("remain"), ActivityModel.instance:getActMO(Activity136Model.instance:getCurActivity136Id()):getRemainTimeStr3())
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

return slot0
