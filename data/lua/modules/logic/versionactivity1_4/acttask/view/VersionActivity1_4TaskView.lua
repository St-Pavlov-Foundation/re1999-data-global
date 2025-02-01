module("modules.logic.versionactivity1_4.acttask.view.VersionActivity1_4TaskView", package.seeall)

slot0 = class("VersionActivity1_4TaskView", BaseView)

function slot0.onInitView(slot0)
	slot0.simageFullBg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0.txtTime = gohelper.findChildTextMesh(slot0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	slot0.btnNote = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/Note/#btn_note")
	slot0.goFinish = gohelper.findChild(slot0.viewGO, "Left/Note/#simage_finished")
	slot0.btnReward = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnReward")
	slot0.simageIcon = gohelper.findChildSingleImage(slot0.viewGO, "btnReward/#simage_icon")
	slot0._redDot = RedDotController.instance:addRedDot(gohelper.findChild(slot0.viewGO, "Left/#go_reddot"), 1095)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.simageFullBg:LoadImage("singlebg/v1a4_taskview_singlebg/v1a4_taskview_fullbg.png")
	slot0:addClickCb(slot0.btnReward, slot0.onClickRewad, slot0)
	slot0:addClickCb(slot0.btnNote, slot0.onClickNote, slot0)
end

function slot0.onClickRewad(slot0)
	slot0.viewContainer:getScrollView():moveToByCheckFunc(function (slot0)
		return slot0.config and slot0.config.isKeyReward == 1 and slot0.finishCount < slot0.config.maxFinishCount
	end, 0.5, slot0.onFouceReward, slot0)
end

function slot0.onFouceReward(slot0)
end

function slot0.onClickNote(slot0)
	Activity132Controller.instance:openCollectView(VersionActivity1_4Enum.ActivityId.Collect)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)

	slot0.actId = slot0.viewParam.activityId

	slot0:initTab()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, slot0._onOpen, slot0)
	ActivityEnterMgr.instance:enterActivity(slot0.actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		slot0.actId
	})
end

function slot0.initTab(slot0)
	slot0.tabList = {}

	for slot4 = 1, 3 do
		slot0.tabList[slot4] = slot0:createTab(slot4)
	end
end

function slot0.createTab(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.actId = slot0.actId
	slot2.index = slot1
	slot2.go = gohelper.findChild(slot0.viewGO, string.format("Top/#go_tab%s", slot1))
	slot2.goChoose = gohelper.findChild(slot2.go, "#go_choose")
	slot2.goRed = gohelper.findChild(slot2.go, "#go_reddot")
	slot2.btn = gohelper.findChildButtonWithAudio(slot2.go, "#btn")

	function slot2.refreshRed(slot0)
		slot0.redDot.show = VersionActivity1_4TaskListModel.instance:checkTaskRedByPage(slot0.actId, slot0.index)

		slot0.redDot:showRedDot(1)
	end

	slot2.redDot = MonoHelper.addNoUpdateLuaComOnceToGo(slot2.goRed, CommonRedDotIcon)

	slot2.redDot:setMultiId({
		id = 1096
	})
	slot2.redDot:overrideRefreshDotFunc(slot2.refreshRed, slot2)
	slot2.redDot:refreshDot()
	slot0:addClickCb(slot2.btn, slot0.onClickTab, slot0, slot1)

	return slot2
end

function slot0.refreshTabRed(slot0)
	for slot4, slot5 in pairs(slot0.tabList) do
		slot5.redDot:refreshDot()
	end
end

function slot0.onClickTab(slot0, slot1)
	if slot0.tabIndex == slot1 then
		return
	end

	slot0.tabIndex = slot1

	for slot5, slot6 in ipairs(slot0.tabList) do
		gohelper.setActive(slot6.goChoose, slot5 == slot0.tabIndex)
	end

	slot0:refreshRight()
end

function slot0._onOpen(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0.refreshRight, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0.refreshRight, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0.refreshRight, slot0)
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, TimeUtil.OneMinuteSecond)
	slot0:refreshLeft()
	slot0:onClickTab(1)
end

function slot0.refreshLeft(slot0)
	slot0:refreshRemainTime()
end

function slot0.refreshRemainTime(slot0)
	slot0.txtTime.text = string.format(luaLang("remain"), slot0:_getRemainTimeStr(ActivityModel.instance:getActMO(slot0.actId)))
end

function slot0.refreshRight(slot0)
	VersionActivity1_4TaskListModel.instance:sortTaskMoList(slot0.actId, slot0.tabIndex)

	slot2 = VersionActivity1_4TaskListModel.instance:getKeyRewardMo() ~= nil

	gohelper.setActive(slot0.btnReward, slot2)

	if slot2 then
		slot4 = GameUtil.splitString2(slot1.config.bonus, true, "|", "#")[1]
		slot7, slot8 = ItemModel.instance:getItemConfigAndIcon(slot4[1], slot4[2], true)

		slot0.simageIcon:LoadImage(slot8)
	end

	gohelper.setActive(slot0.goFinish, VersionActivity1_4TaskListModel.instance.allTaskFinish)
	slot0:refreshTabRed()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

function slot0.onDestroyView(slot0)
	slot0.simageFullBg:UnLoadImage()
	slot0.simageIcon:UnLoadImage()
end

function slot0._getRemainTimeStr(slot0, slot1)
	slot2 = nil

	if slot1 then
		slot2 = slot1:getRealEndTimeStamp() - ServerTime.now()
	end

	if not slot2 or slot2 <= 0 then
		return luaLang("turnback_end")
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
