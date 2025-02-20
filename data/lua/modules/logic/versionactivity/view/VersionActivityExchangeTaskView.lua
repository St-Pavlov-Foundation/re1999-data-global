module("modules.logic.versionactivity.view.VersionActivityExchangeTaskView", package.seeall)

slot0 = class("VersionActivityExchangeTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close1")
	slot0._scrolltasklist = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_tasklist")
	slot0._gotaskitem = gohelper.findChild(slot0.viewGO, "#scroll_tasklist/Viewport/Content/#go_taskitem")
	slot0._btnclose2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close2")
	slot0._godailytask = gohelper.findChild(slot0.viewGO, "option/#go_dailytask")
	slot0._godailyselected = gohelper.findChild(slot0.viewGO, "option/#go_dailytask/#go_daily_selected")
	slot0._godailyunselected = gohelper.findChild(slot0.viewGO, "option/#go_dailytask/#go_daily_unselected")
	slot0._btndailyclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "option/#go_dailytask/#btn_daily_click")
	slot0._gochallengetask = gohelper.findChild(slot0.viewGO, "option/#go_challengetask")
	slot0._gochallengeselected = gohelper.findChild(slot0.viewGO, "option/#go_challengetask/#go_challenge_selected")
	slot0._gochallengeunselected = gohelper.findChild(slot0.viewGO, "option/#go_challengetask/#go_challenge_unselected")
	slot0._btnchallengeclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "option/#go_challengetask/#btn_challenge_click")
	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "#txt_remaintime")
	slot0._gotaskdayreddot1 = gohelper.findChild(slot0.viewGO, "option/#go_dailytask/#go_daily_selected/#go_taskdayreddot")
	slot0._gotaskdayreddot2 = gohelper.findChild(slot0.viewGO, "option/#go_dailytask/#go_daily_unselected/#go_taskdayreddot")
	slot0._gotaskchallengereddot1 = gohelper.findChild(slot0.viewGO, "option/#go_challengetask/#go_challenge_unselected/#go_taskchallengereddot")
	slot0._gotaskchallengereddot2 = gohelper.findChild(slot0.viewGO, "option/#go_challengetask/#go_challenge_selected/#go_taskchallengereddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose1:AddClickListener(slot0._btnclose1OnClick, slot0)
	slot0._btnclose2:AddClickListener(slot0._btnclose2OnClick, slot0)
	slot0._btndailyclick:AddClickListener(slot0._btndailyclickOnClick, slot0)
	slot0._btnchallengeclick:AddClickListener(slot0._btnchallengeclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose1:RemoveClickListener()
	slot0._btnclose2:RemoveClickListener()
	slot0._btndailyclick:RemoveClickListener()
	slot0._btnchallengeclick:RemoveClickListener()
end

function slot0._btndailyclickOnClick(slot0)
	slot0._isDailyTaskType = true

	slot0:_refreshTop()
	slot0:_refreshTask()
end

function slot0._btnchallengeclickOnClick(slot0)
	slot0._isDailyTaskType = false

	slot0:_refreshTop()
	slot0:_refreshTask()
end

function slot0._btnclose1OnClick(slot0)
	slot0:closeThis()
end

function slot0._btnclose2OnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.taskItemList = {}

	gohelper.setActive(slot0._gotaskitem, false)
	RedDotController.instance:addRedDot(slot0._gotaskdayreddot1, RedDotEnum.DotNode.VersionActivityExchangeTaskDay)
	RedDotController.instance:addRedDot(slot0._gotaskdayreddot2, RedDotEnum.DotNode.VersionActivityExchangeTaskDay)
	RedDotController.instance:addRedDot(slot0._gotaskchallengereddot1, RedDotEnum.DotNode.VersionActivityExchangeTaskChallenge)
	RedDotController.instance:addRedDot(slot0._gotaskchallengereddot2, RedDotEnum.DotNode.VersionActivityExchangeTaskChallenge)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(VersionActivityController.instance, VersionActivityEvent.VersionActivity112TaskGetBonus, slot0.onGetBonus, slot0)
	slot0:addEventCb(VersionActivityController.instance, VersionActivityEvent.VersionActivity112TaskUpdate, slot0._refreshTask, slot0)
	TaskDispatcher.runRepeat(slot0.updateDeadline, slot0, 60)

	slot0._isDailyTaskType = true
	slot0.actId = slot0.viewParam.actId
	slot0._actMO = ActivityModel.instance:getActMO(slot0.actId)

	slot0:_refreshTop()
	slot0:_refreshTask(true)
	slot0:updateDeadline()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(VersionActivityController.instance, VersionActivityEvent.VersionActivity112TaskGetBonus, slot0.onGetBonus, slot0)
	slot0:removeEventCb(VersionActivityController.instance, VersionActivityEvent.VersionActivity112TaskUpdate, slot0._refreshTask, slot0)
	TaskDispatcher.cancelTask(slot0.updateDeadline, slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.taskItemList) do
		slot5:onDestroyView()
	end

	slot0.taskItemList = nil
end

function slot0._refreshTop(slot0)
	gohelper.setActive(slot0._godailyselected, slot0._isDailyTaskType)
	gohelper.setActive(slot0._godailyunselected, slot0._isDailyTaskType == false)
	gohelper.setActive(slot0._gochallengeselected, slot0._isDailyTaskType == false)
	gohelper.setActive(slot0._gochallengeunselected, slot0._isDailyTaskType)
end

function slot0._refreshTask(slot0, slot1)
	slot6 = slot0._isDailyTaskType

	VersionActivity112TaskListModel.instance:updateTaksList(slot0.actId, slot6)

	for slot6, slot7 in ipairs(VersionActivity112TaskListModel.instance:getList()) do
		if slot0.taskItemList[slot6] == nil then
			slot9 = gohelper.cloneInPlace(slot0._gotaskitem, "item" .. slot6)

			gohelper.setActive(slot9, true)

			slot0.taskItemList[slot6] = MonoHelper.addLuaComOnceToGo(slot9, VersionActivityExchangeTaskItem, slot0)
		end

		slot8:onUpdateMO(slot7, slot6, slot1)
		gohelper.setActive(slot8.go, true)
	end

	for slot6 = #slot2 + 1, #slot0.taskItemList do
		gohelper.setActive(slot0.taskItemList[slot6].go, false)
	end
end

function slot0.onGetBonus(slot0, slot1)
	slot0:_refreshTask()
end

function slot0.updateDeadline(slot0)
	slot4, slot5 = TimeUtil.secondToRoughTime2(math.max(0, ActivityModel.instance:getActEndTime(slot0.actId) / 1000 - tonumber(slot0._actMO.config.param) * 3600 - ServerTime.now()))
	slot0._txtremaintime.text = string.format(luaLang("activity_task_remain_time"), string.format("%s%s", slot4, slot5))
end

return slot0
