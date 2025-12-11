module("modules.logic.versionactivity3_1.towerdeep.view.TowerDeepOperActPanelView", package.seeall)

local var_0_0 = class("TowerDeepOperActPanelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "root/simage_fullbg/#txt_time")
	arg_1_0._godeep = gohelper.findChild(arg_1_0.viewGO, "root/#go_deep")
	arg_1_0._btntips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_deep/title/txt_title/#btn_tips")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "root/#go_deep/#go_tips")
	arg_1_0._txttip = gohelper.findChildText(arg_1_0.viewGO, "root/#go_deep/#go_tips/txt_tips")
	arg_1_0._btnclosetips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_deep/#go_tips/#btn_closetips")
	arg_1_0._gotask1 = gohelper.findChild(arg_1_0.viewGO, "root/#go_task1")
	arg_1_0._gotask2 = gohelper.findChild(arg_1_0.viewGO, "root/#go_task2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btntips:AddClickListener(arg_2_0._btntipsOnClick, arg_2_0)
	arg_2_0._btnclosetips:AddClickListener(arg_2_0._btnclosetipsOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btntips:RemoveClickListener()
	arg_3_0._btnclosetips:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btntipsOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._gotips, true)
end

function var_0_0._btnclosetipsOnClick(arg_6_0)
	gohelper.setActive(arg_6_0._gotips, false)
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

	arg_10_0._actId = VersionActivity3_1Enum.ActivityId.TowerDeep
	arg_10_0._taskItems = {}
	arg_10_0._deepItems = {}
	arg_10_0._txttip.text = CommonConfig.instance:getConstStr(ConstEnum.TowerDeepTip)

	arg_10_0:_refreshTaskItems()
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

function var_0_0._refreshTaskItems(arg_12_0)
	local var_12_0 = 1
	local var_12_1 = TowerDeepOperActConfig.instance:getTaskCos()

	for iter_12_0, iter_12_1 in LuaUtil.pairsByKeys(var_12_1) do
		if iter_12_1.listenerType ~= TaskEnum.ListenerType.Act209GlobalTowerLayer then
			if not arg_12_0._taskItems[iter_12_1.id] then
				arg_12_0._taskItems[iter_12_1.id] = TowerDeepOperActTaskItem.New()

				arg_12_0._taskItems[iter_12_1.id]:init(arg_12_0["_gotask" .. tostring(var_12_0)], iter_12_1)

				var_12_0 = var_12_0 + 1
			end

			arg_12_0._taskItems[iter_12_1.id]:refresh()
		end
	end
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0:_clearTimeTick()

	if arg_14_0._taskItems then
		for iter_14_0, iter_14_1 in pairs(arg_14_0._taskItems) do
			iter_14_1:destroy()
		end

		arg_14_0._taskItems = nil
	end
end

function var_0_0._clearTimeTick(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._refreshTimeTick, arg_15_0)
end

function var_0_0.onRefresh(arg_16_0)
	arg_16_0:_refreshTimeTick()
end

function var_0_0._refreshTimeTick(arg_17_0)
	arg_17_0._txttime.text = arg_17_0:_getRemainTimeStr()
end

function var_0_0._getRemainTimeStr(arg_18_0)
	local var_18_0 = ActivityModel.instance:getRemainTimeSec(arg_18_0._actId) or 0

	if var_18_0 <= 0 then
		return luaLang("turnback_end")
	end

	local var_18_1, var_18_2, var_18_3, var_18_4 = TimeUtil.secondsToDDHHMMSS(var_18_0)

	if var_18_1 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			var_18_1,
			var_18_2
		})
	elseif var_18_2 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			var_18_2,
			var_18_3
		})
	elseif var_18_3 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			var_18_3
		})
	elseif var_18_4 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			1
		})
	end

	return luaLang("turnback_end")
end

return var_0_0
