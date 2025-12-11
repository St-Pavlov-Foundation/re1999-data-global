module("modules.logic.versionactivity3_1.towerdeep.view.TowerDeepOperActFullView", package.seeall)

local var_0_0 = class("TowerDeepOperActFullView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "root/simage_fullbg/#txt_time")
	arg_1_0._godeep = gohelper.findChild(arg_1_0.viewGO, "root/#go_deep")
	arg_1_0._btntips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_deep/title/txt_title/#btn_tips")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "root/#go_deep/#go_tips")
	arg_1_0._txttip = gohelper.findChildText(arg_1_0.viewGO, "root/#go_deep/#go_tips/txt_tips")
	arg_1_0._btnclosetips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_deep/#go_tips/#btn_closetips")
	arg_1_0._gotask1 = gohelper.findChild(arg_1_0.viewGO, "root/#go_task1")
	arg_1_0._gotask2 = gohelper.findChild(arg_1_0.viewGO, "root/#go_task2")
	arg_1_0._gotask3 = gohelper.findChild(arg_1_0.viewGO, "root/#go_task3")
	arg_1_0._btngoto = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_goto")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntips:AddClickListener(arg_2_0._btntipsOnClick, arg_2_0)
	arg_2_0._btnclosetips:AddClickListener(arg_2_0._btnclosetipsOnClick, arg_2_0)
	arg_2_0._btngoto:AddClickListener(arg_2_0._btngotoOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntips:RemoveClickListener()
	arg_3_0._btnclosetips:RemoveClickListener()
	arg_3_0._btngoto:RemoveClickListener()
end

function var_0_0._btntipsOnClick(arg_4_0)
	gohelper.setActive(arg_4_0._gotips, true)
end

function var_0_0._btnclosetipsOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._gotips, false)
end

function var_0_0._btngotoOnClick(arg_6_0)
	GameFacade.jump(JumpEnum.JumpView.TowerDeepOperAct)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._txttime.text = ""

	arg_7_0:_addSelfEvents()
end

function var_0_0._addSelfEvents(arg_8_0)
	arg_8_0:addEventCb(TowerDeepOperActController.instance, TowerDeepOperActEvent.onAct209InfoGet, arg_8_0._refreshDeep, arg_8_0)
	arg_8_0:addEventCb(TowerDeepOperActController.instance, TowerDeepOperActEvent.OnAct209InfoUpdate, arg_8_0._refreshDeep, arg_8_0)
	arg_8_0:addEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_8_0._refreshTaskItems, arg_8_0)
	arg_8_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_8_0._refreshTaskItems, arg_8_0)
end

function var_0_0._removeSelfEvents(arg_9_0)
	arg_9_0:removeEventCb(TowerDeepOperActController.instance, TowerDeepOperActEvent.onAct209InfoGet, arg_9_0._refreshDeep, arg_9_0)
	arg_9_0:removeEventCb(TowerDeepOperActController.instance, TowerDeepOperActEvent.OnAct209InfoUpdate, arg_9_0._refreshDeep, arg_9_0)
	arg_9_0:removeEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_9_0._refreshTaskItems, arg_9_0)
	arg_9_0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_9_0._refreshTaskItems, arg_9_0)
end

function var_0_0.onOpen(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_ripple_entry)

	local var_10_0 = arg_10_0.viewParam.parent

	gohelper.addChild(var_10_0, arg_10_0.viewGO)

	arg_10_0._actId = VersionActivity3_1Enum.ActivityId.TowerDeep
	arg_10_0._taskItems = {}
	arg_10_0._deepItems = {}
	arg_10_0._txttip.text = CommonConfig.instance:getConstStr(ConstEnum.TowerDeepTip)

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.TowerDeep
	}, arg_10_0._onGetTaskInfo, arg_10_0)
	arg_10_0:_refreshDeep()
	arg_10_0:_refreshTimeTick()
	TaskDispatcher.runRepeat(arg_10_0._refreshTimeTick, arg_10_0, 1)
end

local var_0_1 = {
	800,
	1000
}

function var_0_0._refreshDeep(arg_11_0)
	local var_11_0 = TowerDeepOperActModel.instance:getMaxLayer()
	local var_11_1 = 1

	for iter_11_0 = 1, 2 do
		if var_11_0 >= var_0_1[iter_11_0] then
			var_11_1 = iter_11_0 + 1
		end
	end

	for iter_11_1 = 1, 3 do
		if not arg_11_0._deepItems[iter_11_1] then
			arg_11_0._deepItems[iter_11_1] = {}
			arg_11_0._deepItems[iter_11_1].go = gohelper.findChild(arg_11_0.viewGO, "root/#go_deep/deep" .. tostring(iter_11_1))
			arg_11_0._deepItems[iter_11_1].txt = gohelper.findChildText(arg_11_0.viewGO, string.format("root/#go_deep/deep%s/#txt_deep_%s", tostring(iter_11_1), tostring(iter_11_1)))
		end

		gohelper.setActive(arg_11_0._deepItems[iter_11_1].go, var_11_1 == iter_11_1)

		if var_11_1 == iter_11_1 then
			arg_11_0._deepItems[iter_11_1].txt.text = var_11_0
		end
	end
end

function var_0_0._onGetTaskInfo(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	Activity209Rpc.instance:sendGetAct209InfoRequest(arg_12_0._actId, arg_12_0._refreshTaskItems, arg_12_0)
end

function var_0_0._refreshTaskItems(arg_13_0)
	arg_13_0._taskIndex = 1

	local var_13_0 = TowerDeepOperActConfig.instance:getTaskCos()

	if arg_13_0._taskItems then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._taskItems) do
			iter_13_1:destroy()
		end

		arg_13_0._taskItems = {}
	end

	for iter_13_2, iter_13_3 in LuaUtil.pairsByKeys(var_13_0) do
		local var_13_1 = TowerDeepOperActModel.instance:isTaskFinished(iter_13_3.id)
		local var_13_2 = TowerDeepOperActModel.instance:getNextTaskId(iter_13_3.id)

		if var_13_2 and var_13_2 ~= 0 then
			if not var_13_1 then
				arg_13_0:_createOrResetTaskItem(iter_13_3.id, arg_13_0._taskIndex)
			end
		elseif LuaUtil.isEmptyStr(iter_13_3.prepose) then
			arg_13_0:_createOrResetTaskItem(iter_13_3.id, arg_13_0._taskIndex)
		elseif TowerDeepOperActModel.instance:isTaskFinished(tonumber(iter_13_3.prepose)) then
			arg_13_0:_createOrResetTaskItem(iter_13_3.id, arg_13_0._taskIndex)
		end
	end
end

function var_0_0._createOrResetTaskItem(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_0._taskItems[arg_14_1] then
		arg_14_0._taskItems[arg_14_1] = TowerDeepOperActTaskItem.New()

		local var_14_0 = TowerDeepOperActConfig.instance:getTaskCO(arg_14_1)

		arg_14_0._taskItems[var_14_0.id]:init(arg_14_0["_gotask" .. tostring(arg_14_2)], var_14_0)

		arg_14_0._taskIndex = arg_14_2 + 1
	end

	arg_14_0._taskItems[arg_14_1]:refresh()
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0:_removeSelfEvents()
	arg_16_0:_clearTimeTick()

	if arg_16_0._taskItems then
		for iter_16_0, iter_16_1 in pairs(arg_16_0._taskItems) do
			iter_16_1:destroy()
		end

		arg_16_0._taskItems = nil
	end
end

function var_0_0._clearTimeTick(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._refreshTimeTick, arg_17_0)
end

function var_0_0.onRefresh(arg_18_0)
	arg_18_0:_refreshTimeTick()
end

function var_0_0._refreshTimeTick(arg_19_0)
	arg_19_0._txttime.text = arg_19_0:_getRemainTimeStr()
end

function var_0_0._getRemainTimeStr(arg_20_0)
	local var_20_0 = ActivityModel.instance:getRemainTimeSec(arg_20_0._actId) or 0

	if var_20_0 <= 0 then
		return luaLang("turnback_end")
	end

	local var_20_1, var_20_2, var_20_3, var_20_4 = TimeUtil.secondsToDDHHMMSS(var_20_0)

	if var_20_1 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			var_20_1,
			var_20_2
		})
	elseif var_20_2 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			var_20_2,
			var_20_3
		})
	elseif var_20_3 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			var_20_3
		})
	elseif var_20_4 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			1
		})
	end

	return luaLang("turnback_end")
end

return var_0_0
