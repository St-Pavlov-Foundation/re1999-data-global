module("modules.logic.gm.view.GM_TaskView", package.seeall)

slot0 = class("GM_TaskView")

function slot0.register()
	uv0.TaskDailyView_register(TaskDailyView)
	uv0.TaskWeeklyView_register(TaskWeeklyView)
	uv0.TaskListCommonItem_register(TaskListCommonItem)
end

function slot1(slot0, slot1, slot2)
	if not getGlobal("GMRpc") then
		logError("are u already login?")

		return
	end

	logNormal(slot0)
	slot3.instance:sendGMRequest(slot0, slot1, slot2)
end

function slot2(slot0, slot1, slot2)
	if not slot0 then
		if slot1 then
			slot1(slot2)
		end

		return
	end

	slot3 = "set taskfinish "

	if type(slot0) == "table" then
		if #slot0 == 0 then
			return
		end

		slot3 = slot3 .. table.concat(slot0, " ")
	else
		slot3 = slot3 .. slot0
	end

	uv0(slot3, slot1, slot2)
end

function slot3(slot0, slot1)
	if TaskModel.instance:isAllRewardGet(slot0) then
		return
	end

	slot4 = {}

	for slot9, slot10 in pairs(TaskModel.instance:getAllUnlockTasks(slot0)) do
		if not TaskModel.instance:taskHasFinished(slot0, slot9) then
			table.insert({}, slot10)
			table.insert(slot4, slot9)
		end
	end

	if #slot4 == 0 then
		return
	end

	uv0(slot4, function (slot0)
		for slot4, slot5 in ipairs(uv0) do
			slot5.hasFinished = true
		end

		TaskController.instance:dispatchEvent(TaskEvent.SetTaskList)
	end, slot1)
end

function slot0.TaskDailyView_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(slot0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "removeEvents")

	function slot0._editableInitView(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_editableInitView", ...)
		UIDockingHelper.setDock(UIDockingHelper.Dock.MR_R, GMMinusModel.instance:addBtnGM(slot0).transform, slot0._txtLeftTime.transform, 15)
	end

	function slot0.addEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(slot0)
		GM_TaskDailyViewContainer.addEvents(slot0)
	end

	function slot0.removeEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(slot0)
		GM_TaskDailyViewContainer.removeEvents(slot0)
	end

	function slot0._gm_showAllTabIdUpdate(slot0)
		TaskController.instance:dispatchEvent(TaskEvent.SetTaskList)
	end

	function slot0._gm_enableFinishOnSelect(slot0)
		TaskController.instance:dispatchEvent(TaskEvent.SetTaskList)
	end

	function slot0._gm_onClickFinishAll(slot0)
		uv0(TaskEnum.TaskType.Daily, slot0)
	end
end

function slot0.TaskWeeklyView_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(slot0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "removeEvents")

	function slot0._editableInitView(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_editableInitView", ...)
		UIDockingHelper.setDock(UIDockingHelper.Dock.MR_R, GMMinusModel.instance:addBtnGM(slot0).transform, slot0._txtLeftTime.transform, 15)
	end

	function slot0.addEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(slot0)
		GM_TaskWeeklyViewContainer.addEvents(slot0)
	end

	function slot0.removeEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(slot0)
		GM_TaskWeeklyViewContainer.removeEvents(slot0)
	end

	function slot0._gm_showAllTabIdUpdate(slot0)
		TaskController.instance:dispatchEvent(TaskEvent.SetTaskList)
	end

	function slot0._gm_enableFinishOnSelect(slot0)
		TaskController.instance:dispatchEvent(TaskEvent.SetTaskList)
	end

	function slot0._gm_onClickFinishAll(slot0)
		uv0(TaskEnum.TaskType.Weekly, slot0)
	end
end

slot4 = nil

function slot0.TaskListCommonItem_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "init")
	GMMinusModel.instance:saveOriginalFunc(slot0, "_refreshCommonItem")
	GMMinusModel.instance:saveOriginalFunc(slot0, "_btnnotfinishbgOnClick")

	if not uv0 then
		uv0 = {}

		for slot4, slot5 in pairs(TaskEnum.TaskType) do
			uv0[slot5] = slot4
		end
	end

	function slot0.init(slot0, slot1, ...)
		slot2 = gohelper.findChild(slot1, "#go_common/#go_notget/#btn_notfinishbg/text")
		slot0.__btnnotFinishBgText = gohelper.findChildText(slot2, "")
		slot0.__btnnotFinishBgTextLangTxtCmp = slot2:GetComponent(typeof(SLFramework.LangTxt))

		GMMinusModel.instance:callOriginalSelfFunc(slot0, "init", slot1, ...)
	end

	function slot0._refreshCommonItem(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_refreshCommonItem", ...)

		if not slot0._mo then
			return
		end

		uv0._gm_s_callFunc("_refreshCommonItem", slot0, ...)
	end

	function slot0._btnnotfinishbgOnClick(slot0, ...)
		uv0._gm_s_callFunc("_btnnotfinishbgOnClick", slot0, ...)
	end

	slot2 = "_gm_" .. "s_"

	function slot0._gm_refreshCommonItem_showAllTabId(slot0, ...)
		slot2 = slot0._mo.config
		slot0._txttaskdes.text = gohelper.getRichColorText(tostring(slot2.id), "#FF0000") .. string.format(slot2.desc, slot2.maxProgress)
	end

	function slot0._gm_refreshCommonItem_enableFinishSelectedTask(slot0, slot1)
		if not slot0.__btnnotFinishBgText then
			return
		end

		slot0.__btnnotFinishBgText.text = slot1 and "立即\n完成" or luaLang("p_task_nofinish")
	end

	function slot0._gm_s_callFunc(slot0, slot1, ...)
		if slot1[uv1 .. slot0 .. uv0[slot1._taskType]] then
			slot5(slot1, ...)

			return
		end

		if not getModulePath("GM_Task" .. slot3 .. "View") then
			logWarn("[GM_TaskView] lua class not found " .. slot6)

			return
		end

		slot9 = uv2 .. slot0
		slot10 = uv3[slot9]

		assert(slot10, "please impl default function: T['" .. slot9 .. "']")
		slot10(addGlobalModule(slot7), slot1, ...)
	end

	function slot0._gm_s__refreshCommonItem(slot0, slot1, ...)
		if slot0.s_ShowAllTabId then
			slot1:_gm_refreshCommonItem_showAllTabId(slot1, ...)
		end

		slot2 = false

		if slot0.s_enableFinishSelectedTask then
			slot1.__btnnotFinishBgTextLangTxtCmp.enabled = false
			slot2 = not slot1._mo.hasFinished
		end

		slot1:_gm_refreshCommonItem_enableFinishSelectedTask(slot2)
	end

	function slot0._gm_s__btnnotfinishbgOnClick(slot0, slot1, ...)
		if slot1._mo and slot0.s_enableFinishSelectedTask and not slot2.hasFinished then
			uv0(slot2.config.id, function (slot0)
				uv0.hasFinished = true

				TaskController.instance:dispatchEvent(TaskEvent.SetTaskList)
			end, slot1)
		else
			GMMinusModel.instance:callOriginalSelfFunc(slot1, "_btnnotfinishbgOnClick", ...)
		end
	end
end

return slot0
