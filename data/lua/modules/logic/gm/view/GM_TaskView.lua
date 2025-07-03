module("modules.logic.gm.view.GM_TaskView", package.seeall)

local var_0_0 = class("GM_TaskView")

function var_0_0.register()
	var_0_0.TaskDailyView_register(TaskDailyView)
	var_0_0.TaskWeeklyView_register(TaskWeeklyView)
	var_0_0.TaskListCommonItem_register(TaskListCommonItem)
end

local function var_0_1(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = getGlobal("GMRpc")

	if not var_2_0 then
		logError("are u already login?")

		return
	end

	logNormal(arg_2_0)
	var_2_0.instance:sendGMRequest(arg_2_0, arg_2_1, arg_2_2)
end

local function var_0_2(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_0 then
		if arg_3_1 then
			arg_3_1(arg_3_2)
		end

		return
	end

	local var_3_0 = "set taskfinish "

	if type(arg_3_0) == "table" then
		if #arg_3_0 == 0 then
			return
		end

		var_3_0 = var_3_0 .. table.concat(arg_3_0, " ")
	else
		var_3_0 = var_3_0 .. arg_3_0
	end

	var_0_1(var_3_0, arg_3_1, arg_3_2)
end

local function var_0_3(arg_4_0, arg_4_1)
	if TaskModel.instance:isAllRewardGet(arg_4_0) then
		return
	end

	local var_4_0 = TaskModel.instance:getAllUnlockTasks(arg_4_0)
	local var_4_1 = {}
	local var_4_2 = {}

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		if not TaskModel.instance:taskHasFinished(arg_4_0, iter_4_0) then
			table.insert(var_4_2, iter_4_1)
			table.insert(var_4_1, iter_4_0)
		end
	end

	if #var_4_1 == 0 then
		return
	end

	var_0_2(var_4_1, function(arg_5_0)
		for iter_5_0, iter_5_1 in ipairs(var_4_2) do
			iter_5_1.hasFinished = true
		end

		TaskController.instance:dispatchEvent(TaskEvent.SetTaskList)
	end, arg_4_1)
end

function var_0_0.TaskDailyView_register(arg_6_0)
	GMMinusModel.instance:saveOriginalFunc(arg_6_0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_6_0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_6_0, "removeEvents")

	function arg_6_0._editableInitView(arg_7_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_7_0, "_editableInitView", ...)

		local var_7_0 = GMMinusModel.instance:addBtnGM(arg_7_0)

		UIDockingHelper.setDock(UIDockingHelper.Dock.MR_R, var_7_0.transform, arg_7_0._txtLeftTime.transform, 15)
	end

	function arg_6_0.addEvents(arg_8_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_8_0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(arg_8_0)
		GM_TaskDailyViewContainer.addEvents(arg_8_0)
	end

	function arg_6_0.removeEvents(arg_9_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_9_0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_9_0)
		GM_TaskDailyViewContainer.removeEvents(arg_9_0)
	end

	function arg_6_0._gm_showAllTabIdUpdate(arg_10_0)
		TaskController.instance:dispatchEvent(TaskEvent.SetTaskList)
	end

	function arg_6_0._gm_enableFinishOnSelect(arg_11_0)
		TaskController.instance:dispatchEvent(TaskEvent.SetTaskList)
	end

	function arg_6_0._gm_onClickFinishAll(arg_12_0)
		var_0_3(TaskEnum.TaskType.Daily, arg_12_0)
	end
end

function var_0_0.TaskWeeklyView_register(arg_13_0)
	GMMinusModel.instance:saveOriginalFunc(arg_13_0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_13_0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_13_0, "removeEvents")

	function arg_13_0._editableInitView(arg_14_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_14_0, "_editableInitView", ...)

		local var_14_0 = GMMinusModel.instance:addBtnGM(arg_14_0)

		UIDockingHelper.setDock(UIDockingHelper.Dock.MR_R, var_14_0.transform, arg_14_0._txtLeftTime.transform, 15)
	end

	function arg_13_0.addEvents(arg_15_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_15_0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(arg_15_0)
		GM_TaskWeeklyViewContainer.addEvents(arg_15_0)
	end

	function arg_13_0.removeEvents(arg_16_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_16_0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_16_0)
		GM_TaskWeeklyViewContainer.removeEvents(arg_16_0)
	end

	function arg_13_0._gm_showAllTabIdUpdate(arg_17_0)
		TaskController.instance:dispatchEvent(TaskEvent.SetTaskList)
	end

	function arg_13_0._gm_enableFinishOnSelect(arg_18_0)
		TaskController.instance:dispatchEvent(TaskEvent.SetTaskList)
	end

	function arg_13_0._gm_onClickFinishAll(arg_19_0)
		var_0_3(TaskEnum.TaskType.Weekly, arg_19_0)
	end
end

local var_0_4

function var_0_0.TaskListCommonItem_register(arg_20_0)
	GMMinusModel.instance:saveOriginalFunc(arg_20_0, "init")
	GMMinusModel.instance:saveOriginalFunc(arg_20_0, "_refreshCommonItem")
	GMMinusModel.instance:saveOriginalFunc(arg_20_0, "_btnnotfinishbgOnClick")

	if not var_0_4 then
		var_0_4 = {}

		for iter_20_0, iter_20_1 in pairs(TaskEnum.TaskType) do
			var_0_4[iter_20_1] = iter_20_0
		end
	end

	function arg_20_0.init(arg_21_0, arg_21_1, ...)
		local var_21_0 = gohelper.findChild(arg_21_1, "#go_common/#go_notget/#btn_notfinishbg/text")

		arg_21_0.__btnnotFinishBgText = gohelper.findChildText(var_21_0, "")
		arg_21_0.__btnnotFinishBgTextLangTxtCmp = var_21_0:GetComponent(typeof(SLFramework.LangTxt))

		GMMinusModel.instance:callOriginalSelfFunc(arg_21_0, "init", arg_21_1, ...)
	end

	function arg_20_0._refreshCommonItem(arg_22_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_22_0, "_refreshCommonItem", ...)

		if not arg_22_0._mo then
			return
		end

		arg_20_0._gm_s_callFunc("_refreshCommonItem", arg_22_0, ...)
	end

	function arg_20_0._btnnotfinishbgOnClick(arg_23_0, ...)
		arg_20_0._gm_s_callFunc("_btnnotfinishbgOnClick", arg_23_0, ...)
	end

	local var_20_0 = "_gm_"
	local var_20_1 = var_20_0 .. "s_"

	function arg_20_0._gm_refreshCommonItem_showAllTabId(arg_24_0, ...)
		local var_24_0 = arg_24_0._mo.config
		local var_24_1 = var_24_0.id
		local var_24_2 = gohelper.getRichColorText(tostring(var_24_1), "#FF0000")

		arg_24_0._txttaskdes.text = var_24_2 .. string.format(var_24_0.desc, var_24_0.maxProgress)
	end

	function arg_20_0._gm_refreshCommonItem_enableFinishSelectedTask(arg_25_0, arg_25_1)
		if not arg_25_0.__btnnotFinishBgText then
			return
		end

		arg_25_0.__btnnotFinishBgText.text = arg_25_1 and "立即\n完成" or luaLang("p_task_nofinish")
	end

	function arg_20_0._gm_s_callFunc(arg_26_0, arg_26_1, ...)
		local var_26_0 = arg_26_1._taskType
		local var_26_1 = var_0_4[var_26_0]
		local var_26_2 = arg_26_1[var_20_0 .. arg_26_0 .. var_26_1]

		if var_26_2 then
			var_26_2(arg_26_1, ...)

			return
		end

		local var_26_3 = "GM_Task" .. var_26_1 .. "View"
		local var_26_4 = _G.getModulePath(var_26_3)

		if not var_26_4 then
			logWarn("[GM_TaskView] lua class not found " .. var_26_3)

			return
		end

		local var_26_5 = addGlobalModule(var_26_4)
		local var_26_6 = var_20_1 .. arg_26_0
		local var_26_7 = arg_20_0[var_26_6]

		assert(var_26_7, "please impl default function: T['" .. var_26_6 .. "']")
		var_26_7(var_26_5, arg_26_1, ...)
	end

	function arg_20_0._gm_s__refreshCommonItem(arg_27_0, arg_27_1, ...)
		if arg_27_0.s_ShowAllTabId then
			arg_27_1:_gm_refreshCommonItem_showAllTabId(arg_27_1, ...)
		end

		local var_27_0 = false
		local var_27_1 = arg_27_1._mo

		if arg_27_0.s_enableFinishSelectedTask then
			arg_27_1.__btnnotFinishBgTextLangTxtCmp.enabled = false
			var_27_0 = not var_27_1.hasFinished
		end

		arg_27_1:_gm_refreshCommonItem_enableFinishSelectedTask(var_27_0)
	end

	function arg_20_0._gm_s__btnnotfinishbgOnClick(arg_28_0, arg_28_1, ...)
		local var_28_0 = arg_28_1._mo

		if var_28_0 and arg_28_0.s_enableFinishSelectedTask and not var_28_0.hasFinished then
			local var_28_1 = var_28_0.config.id

			var_0_2(var_28_1, function(arg_29_0)
				var_28_0.hasFinished = true

				TaskController.instance:dispatchEvent(TaskEvent.SetTaskList)
			end, arg_28_1)
		else
			GMMinusModel.instance:callOriginalSelfFunc(arg_28_1, "_btnnotfinishbgOnClick", ...)
		end
	end
end

return var_0_0
