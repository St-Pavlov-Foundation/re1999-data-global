module("modules.logic.versionactivity1_7.doubledrop.view.V1a7_DoubleDropView", package.seeall)

slot0 = class("V1a7_DoubleDropView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtTime = gohelper.findChildTextMesh(slot0.viewGO, "go_time/#go_deadline2/#txt_deadline2")
	slot0._txtDesc = gohelper.findChildTextMesh(slot0.viewGO, "go_desc/#scroll_desc/Viewport/#txt_desc")
	slot0._txtTotalTimes = gohelper.findChildTextMesh(slot0.viewGO, "go_times/go_total/#txt_totaltimes")
	slot0._goToday = gohelper.findChild(slot0.viewGO, "go_times/go_today")
	slot0._txtTotalDayTimes = gohelper.findChildTextMesh(slot0.viewGO, "go_times/go_today/#txt_totalday")
	slot0._btnJump = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_jump")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0._btnJump, slot0._onClickJump, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeClickCb(slot0._btnJump)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
	slot0.actId = slot0.viewParam.actId

	slot0:refresh()
end

function slot0.onOpen(slot0)
	StatController.instance:track(StatEnum.EventName.EnterDoubleEquip)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_page_turn)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)

	slot0.actId = slot0.viewParam.actId

	slot0:refresh()
end

function slot0.refresh(slot0)
	if (slot2 and slot2.config and slot2.config.totalLimit or 0) - (DoubleDropModel.instance:getById(slot0.actId) and slot2.totalCount or 0) > 0 then
		slot0._txtTotalTimes.text = string.format("<color=#DE9854>%s</color>/%s", slot5, slot4)
	else
		slot0._txtTotalTimes.text = string.format("<color=#BF2E11>%s</color>/%s", slot5, slot4)
	end

	slot6, slot7 = DoubleDropModel.instance:getDailyRemainTimes(slot1)

	if slot6 > 0 then
		slot0._txtTotalDayTimes.text = string.format("<color=#DE9854>%s</color>/%s", slot6, slot7)
	else
		slot0._txtTotalDayTimes.text = string.format("<color=#BF2E11>%s</color>/%s", slot6, slot7)
	end

	gohelper.setActive(slot0._goToday, slot5 > 0)

	slot0._txtDesc.text = ActivityConfig.instance:getActivityCo(slot1) and slot8.actDesc or ""

	slot0:refreshRemainTime()
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, 1)
end

function slot0.refreshRemainTime(slot0)
	if not ActivityModel.instance:getActMO(slot0.actId) then
		return
	end

	if slot1:getRealEndTimeStamp() - ServerTime.now() > 0 then
		slot0._txtTime.text = TimeUtil.SecondToActivityTimeFormat(slot2)
	else
		slot0._txtTime.text = luaLang("ended")
	end
end

function slot0._onClickJump(slot0)
	GameFacade.jump(3601)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
