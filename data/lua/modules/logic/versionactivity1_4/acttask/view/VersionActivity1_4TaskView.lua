module("modules.logic.versionactivity1_4.acttask.view.VersionActivity1_4TaskView", package.seeall)

local var_0_0 = class("VersionActivity1_4TaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.simageFullBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0.txtTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0.btnNote = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/Note/#btn_note")
	arg_1_0.goFinish = gohelper.findChild(arg_1_0.viewGO, "Left/Note/#simage_finished")
	arg_1_0.btnReward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnReward")
	arg_1_0.simageIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "btnReward/#simage_icon")

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "Left/#go_reddot")

	arg_1_0._redDot = RedDotController.instance:addRedDot(var_1_0, 1095)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.simageFullBg:LoadImage("singlebg/v1a4_taskview_singlebg/v1a4_taskview_fullbg.png")
	arg_4_0:addClickCb(arg_4_0.btnReward, arg_4_0.onClickRewad, arg_4_0)
	arg_4_0:addClickCb(arg_4_0.btnNote, arg_4_0.onClickNote, arg_4_0)
end

function var_0_0.onClickRewad(arg_5_0)
	arg_5_0.viewContainer:getScrollView():moveToByCheckFunc(function(arg_6_0)
		return arg_6_0.config and arg_6_0.config.isKeyReward == 1 and arg_6_0.finishCount < arg_6_0.config.maxFinishCount
	end, 0.5, arg_5_0.onFouceReward, arg_5_0)
end

function var_0_0.onFouceReward(arg_7_0)
	return
end

function var_0_0.onClickNote(arg_8_0)
	Activity132Controller.instance:openCollectView(VersionActivity1_4Enum.ActivityId.Collect)
end

function var_0_0.onOpen(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)

	arg_9_0.actId = arg_9_0.viewParam.activityId

	arg_9_0:initTab()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, arg_9_0._onOpen, arg_9_0)
	ActivityEnterMgr.instance:enterActivity(arg_9_0.actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		arg_9_0.actId
	})
end

function var_0_0.initTab(arg_10_0)
	arg_10_0.tabList = {}

	for iter_10_0 = 1, 3 do
		arg_10_0.tabList[iter_10_0] = arg_10_0:createTab(iter_10_0)
	end
end

function var_0_0.createTab(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getUserDataTb_()

	var_11_0.actId = arg_11_0.actId
	var_11_0.index = arg_11_1
	var_11_0.go = gohelper.findChild(arg_11_0.viewGO, string.format("Top/#go_tab%s", arg_11_1))
	var_11_0.goChoose = gohelper.findChild(var_11_0.go, "#go_choose")
	var_11_0.goRed = gohelper.findChild(var_11_0.go, "#go_reddot")
	var_11_0.btn = gohelper.findChildButtonWithAudio(var_11_0.go, "#btn")

	function var_11_0.refreshRed(arg_12_0)
		arg_12_0.redDot.show = VersionActivity1_4TaskListModel.instance:checkTaskRedByPage(arg_12_0.actId, arg_12_0.index)

		arg_12_0.redDot:showRedDot(1)
	end

	var_11_0.redDot = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_0.goRed, CommonRedDotIcon)

	var_11_0.redDot:setMultiId({
		id = 1096
	})
	var_11_0.redDot:overrideRefreshDotFunc(var_11_0.refreshRed, var_11_0)
	var_11_0.redDot:refreshDot()
	arg_11_0:addClickCb(var_11_0.btn, arg_11_0.onClickTab, arg_11_0, arg_11_1)

	return var_11_0
end

function var_0_0.refreshTabRed(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.tabList) do
		iter_13_1.redDot:refreshDot()
	end
end

function var_0_0.onClickTab(arg_14_0, arg_14_1)
	if arg_14_0.tabIndex == arg_14_1 then
		return
	end

	arg_14_0.tabIndex = arg_14_1

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.tabList) do
		gohelper.setActive(iter_14_1.goChoose, iter_14_0 == arg_14_0.tabIndex)
	end

	arg_14_0:refreshRight()
end

function var_0_0._onOpen(arg_15_0)
	arg_15_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_15_0.refreshRight, arg_15_0)
	arg_15_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_15_0.refreshRight, arg_15_0)
	arg_15_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_15_0.refreshRight, arg_15_0)
	TaskDispatcher.runRepeat(arg_15_0.refreshRemainTime, arg_15_0, TimeUtil.OneMinuteSecond)
	arg_15_0:refreshLeft()
	arg_15_0:onClickTab(1)
end

function var_0_0.refreshLeft(arg_16_0)
	arg_16_0:refreshRemainTime()
end

function var_0_0.refreshRemainTime(arg_17_0)
	local var_17_0 = ActivityModel.instance:getActMO(arg_17_0.actId)

	arg_17_0.txtTime.text = string.format(luaLang("remain"), arg_17_0:_getRemainTimeStr(var_17_0))
end

function var_0_0.refreshRight(arg_18_0)
	VersionActivity1_4TaskListModel.instance:sortTaskMoList(arg_18_0.actId, arg_18_0.tabIndex)

	local var_18_0 = VersionActivity1_4TaskListModel.instance:getKeyRewardMo()
	local var_18_1 = var_18_0 ~= nil

	gohelper.setActive(arg_18_0.btnReward, var_18_1)

	if var_18_1 then
		local var_18_2 = GameUtil.splitString2(var_18_0.config.bonus, true, "|", "#")[1]
		local var_18_3 = var_18_2[1]
		local var_18_4 = var_18_2[2]
		local var_18_5, var_18_6 = ItemModel.instance:getItemConfigAndIcon(var_18_3, var_18_4, true)

		arg_18_0.simageIcon:LoadImage(var_18_6)
	end

	gohelper.setActive(arg_18_0.goFinish, VersionActivity1_4TaskListModel.instance.allTaskFinish)
	arg_18_0:refreshTabRed()
end

function var_0_0.onClose(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0.refreshRemainTime, arg_19_0)
end

function var_0_0.onDestroyView(arg_20_0)
	arg_20_0.simageFullBg:UnLoadImage()
	arg_20_0.simageIcon:UnLoadImage()
end

function var_0_0._getRemainTimeStr(arg_21_0, arg_21_1)
	local var_21_0

	if arg_21_1 then
		var_21_0 = arg_21_1:getRealEndTimeStamp() - ServerTime.now()
	end

	if not var_21_0 or var_21_0 <= 0 then
		return luaLang("turnback_end")
	end

	local var_21_1, var_21_2, var_21_3, var_21_4 = TimeUtil.secondsToDDHHMMSS(var_21_0)

	if var_21_1 > 0 then
		local var_21_5 = luaLang("time_day")

		if LangSettings.instance:isEn() then
			var_21_5 = var_21_5 .. " "
		end

		return (var_21_1 .. var_21_5) .. var_21_2 .. luaLang("time_hour2")
	end

	if var_21_2 > 0 then
		return var_21_2 .. luaLang("time_hour2")
	end

	if var_21_3 <= 0 then
		var_21_3 = "<1"
	end

	return var_21_3 .. luaLang("time_minute2")
end

return var_0_0
