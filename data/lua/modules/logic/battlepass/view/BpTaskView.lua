module("modules.logic.battlepass.view.BpTaskView", package.seeall)

local var_0_0 = class("BpTaskView", BaseView)

function var_0_0.ctor(arg_1_0)
	arg_1_0._taskLoopType = 1
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._goline = gohelper.findChild(arg_2_0.viewGO, "#go_line")
	arg_2_0._goallcomplete = gohelper.findChild(arg_2_0.viewGO, "#go_allcomplete")
	arg_2_0._gonew = gohelper.findChild(arg_2_0.viewGO, "toggleGroup/toggle3/#go_new")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:addEventCb(BpController.instance, BpEvent.OnGetInfo, arg_3_0._onTaskUpdate, arg_3_0)
	arg_3_0:addEventCb(BpController.instance, BpEvent.OnTaskUpdate, arg_3_0._onTaskUpdate, arg_3_0)
	arg_3_0:addEventCb(BpController.instance, BpEvent.OnRedDotUpdate, arg_3_0._onRedDotUpdate, arg_3_0)
	arg_3_0:addEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, arg_3_0.updateLineEnable, arg_3_0)
	arg_3_0:addEventCb(arg_3_0.viewContainer, BpEvent.OnTaskFinishAnim, arg_3_0.playFinishAnim, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0:removeEventCb(BpController.instance, BpEvent.OnGetInfo, arg_4_0._onTaskUpdate, arg_4_0)
	arg_4_0:removeEventCb(BpController.instance, BpEvent.OnTaskUpdate, arg_4_0._onTaskUpdate, arg_4_0)
	arg_4_0:removeEventCb(BpController.instance, BpEvent.OnRedDotUpdate, arg_4_0._onRedDotUpdate, arg_4_0)
	arg_4_0:removeEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, arg_4_0.updateLineEnable, arg_4_0)
	arg_4_0:removeEventCb(arg_4_0.viewContainer, BpEvent.OnTaskFinishAnim, arg_4_0.playFinishAnim, arg_4_0)
end

function var_0_0._editableInitView(arg_5_0)
	local var_5_0 = 132
	local var_5_1 = 15
	local var_5_2 = ListScrollParam.New()

	var_5_2.scrollGOPath = "#scroll"
	var_5_2.prefabType = ScrollEnum.ScrollPrefabFromView
	var_5_2.prefabUrl = "#scroll/item"
	var_5_2.cellClass = BpTaskItem
	var_5_2.scrollDir = ScrollEnum.ScrollDirV
	var_5_2.lineCount = 1
	var_5_2.cellWidth = 1330
	var_5_2.cellHeight = var_5_0
	var_5_2.cellSpaceH = 0
	var_5_2.cellSpaceV = var_5_1
	var_5_2.startSpace = -2.5
	var_5_2.frameUpdateMs = 100
	arg_5_0._scrollView = LuaListScrollView.New(BpTaskModel.instance, var_5_2)

	arg_5_0:addChildView(arg_5_0._scrollView)

	arg_5_0._toggleGroupGO = gohelper.findChild(arg_5_0.viewGO, "toggleGroup")
	arg_5_0._toggleGroup = arg_5_0._toggleGroupGO:GetComponent(typeof(UnityEngine.UI.ToggleGroup))
	arg_5_0._redDotGO = gohelper.findChild(arg_5_0.viewGO, "redDot")
	arg_5_0._toggleWraps = arg_5_0:getUserDataTb_()
	arg_5_0._toggleRedDots = arg_5_0:getUserDataTb_()
	arg_5_0._expupGos = arg_5_0:getUserDataTb_()

	local var_5_3 = arg_5_0._toggleGroupGO.transform
	local var_5_4 = var_5_3.childCount

	for iter_5_0 = 1, var_5_4 do
		local var_5_5 = var_5_3:GetChild(iter_5_0 - 1).gameObject
		local var_5_6 = var_5_5:GetComponent(typeof(UnityEngine.UI.Toggle))

		arg_5_0._toggleRedDots[iter_5_0] = gohelper.findChild(arg_5_0._redDotGO, "#go_reddot" .. iter_5_0)

		if var_5_6 then
			local var_5_7 = gohelper.onceAddComponent(var_5_5, typeof(SLFramework.UGUI.ToggleWrap))

			var_5_7:AddOnValueChanged(arg_5_0._onToggleValueChanged, arg_5_0, iter_5_0)

			arg_5_0._toggleWraps[iter_5_0] = var_5_7
		end

		local var_5_8 = gohelper.findChild(var_5_5, "Label/#go_expup")

		table.insert(arg_5_0._expupGos, var_5_8)
	end

	arg_5_0._taskHeight = var_5_0 + var_5_1
	arg_5_0._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(arg_5_0._scrollView)

	arg_5_0._taskAnimRemoveItem:setMoveInterval(0)
	arg_5_0._taskAnimRemoveItem:setMoveAnimationTime(BpEnum.TaskMaskTime - BpEnum.TaskGetAnimTime)
	arg_5_0:_onRedDotUpdate()
	TaskDispatcher.runDelay(arg_5_0._delayPlayTaskAnim, arg_5_0, 0)
end

function var_0_0._delayPlayTaskAnim(arg_6_0)
	arg_6_0.viewContainer:dispatchEvent(BpEvent.TapViewOpenAnimBegin, 2)
end

function var_0_0._onClickbtnGetAll(arg_7_0)
	local var_7_0 = BpTaskModel.instance:getList()
	local var_7_1 = false

	arg_7_0._tweenIndexes = {}

	local var_7_2 = BpModel.instance:isWeeklyScoreFull()

	if not var_7_2 or var_7_2 and arg_7_0._taskLoopType == 3 then
		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			if iter_7_1.progress >= iter_7_1.config.maxProgress and iter_7_1.finishCount == 0 then
				var_7_1 = true

				table.insert(arg_7_0._tweenIndexes, iter_7_0)

				break
			end
		end
	end

	if var_7_1 then
		arg_7_0.viewContainer:dispatchEvent(BpEvent.OnTaskFinishAnim)
		UIBlockMgr.instance:startBlock("BpTaskItemFinish")
		TaskDispatcher.runDelay(arg_7_0.finishAllTask, arg_7_0, BpEnum.TaskMaskTime)
	else
		arg_7_0:finishAllTask()
	end
end

function var_0_0.playFinishAnim(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0._tweenIndexes = {
			arg_8_1
		}
	end

	TaskDispatcher.runDelay(arg_8_0.delayPlayFinishAnim, arg_8_0, BpEnum.TaskGetAnimTime)
end

function var_0_0.delayPlayFinishAnim(arg_9_0)
	arg_9_0._taskAnimRemoveItem:removeByIndexs(arg_9_0._tweenIndexes)
end

function var_0_0.finishAllTask(arg_10_0)
	UIBlockMgr.instance:endBlock("BpTaskItemFinish")
	TaskDispatcher.cancelTask(arg_10_0.finishAllTask, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.delayPlayFinishAnim, arg_10_0)

	arg_10_0._preBpScore = BpModel.instance.score
	BpModel.instance.lockLevelUpShow = true

	local var_10_0 = BpModel.instance:isWeeklyScoreFull()
	local var_10_1

	if var_10_0 then
		var_10_1 = {}

		for iter_10_0, iter_10_1 in pairs(BpTaskModel.instance.serverTaskModel:getList()) do
			local var_10_2 = iter_10_1.config.loopType

			if var_10_2 ~= 1 and var_10_2 ~= 2 and iter_10_1.progress >= iter_10_1.config.maxProgress and iter_10_1.finishCount == 0 and iter_10_1.config.bpId == BpModel.instance.id then
				table.insert(var_10_1, iter_10_1.config.id)
			end
		end
	end

	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.BattlePass, nil, var_10_1, arg_10_0._onTaskSendFinish, arg_10_0)
end

function var_0_0._onTaskSendFinish(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_2 == 0 and BpModel.instance.lockLevelUpShow and BpModel.instance:checkLevelUp(BpModel.instance.score, arg_11_0._preBpScore) then
		BpModel.instance.preStatus = {
			score = arg_11_0._preBpScore,
			payStatus = BpModel.instance.payStatus
		}

		BpController.instance:onBpLevelUp()
	end

	BpModel.instance.lockLevelUpShow = false
end

function var_0_0._onRedDotUpdate(arg_12_0)
	for iter_12_0 = 1, #arg_12_0._toggleRedDots do
		gohelper.setActive(arg_12_0._toggleRedDots[iter_12_0], BpTaskModel.instance:getHaveRedDot(iter_12_0))
	end
end

function var_0_0._onToggleValueChanged(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_vertical_second_tabs_click)

		arg_13_0._taskLoopType = arg_13_1

		arg_13_0:_onTaskUpdate()
	end

	arg_13_0:_setToggleLabelColor()
end

function var_0_0._setToggleLabelColor(arg_14_0)
	for iter_14_0 = 1, #arg_14_0._toggleWraps do
		local var_14_0 = gohelper.findChildText(arg_14_0._toggleWraps[iter_14_0].gameObject, "Label")

		SLFramework.UGUI.GuiHelper.SetColor(var_14_0, arg_14_0._taskLoopType == iter_14_0 and "#c66030" or "#888888")
	end
end

function var_0_0.onClose(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._delayPlayTaskAnim, arg_15_0)
	UIBlockMgr.instance:endBlock("BpTaskItemFinish")
	TaskDispatcher.cancelTask(arg_15_0.finishAllTask, arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0.delayPlayFinishAnim, arg_15_0)

	BpModel.instance.lockLevelUpShow = false
end

function var_0_0.onDestroyView(arg_16_0)
	for iter_16_0 = 1, #arg_16_0._toggleWraps do
		arg_16_0._toggleWraps[iter_16_0]:RemoveOnValueChanged()
	end

	arg_16_0._toggleWraps = nil
end

function var_0_0.onOpen(arg_17_0)
	BpController.instance:dispatchEvent(BpEvent.SetGetAllCallBack, arg_17_0._onClickbtnGetAll, arg_17_0)

	local var_17_0 = 1

	for iter_17_0 = 1, 3 do
		if BpTaskModel.instance:getHaveRedDot(iter_17_0) then
			var_17_0 = iter_17_0

			break
		end
	end

	arg_17_0._taskLoopType = var_17_0

	for iter_17_1 = 1, #arg_17_0._toggleWraps do
		arg_17_0._toggleWraps[iter_17_1].isOn = iter_17_1 == var_17_0
	end

	BpTaskModel.instance:sortList()
	arg_17_0:_onTaskUpdate()
	arg_17_0:_refreshExpUp()
end

function var_0_0._onTaskUpdate(arg_18_0)
	arg_18_0.viewContainer:dispatchEvent(BpEvent.TaskTabChange, arg_18_0._taskLoopType)
	gohelper.setActive(arg_18_0._goallcomplete, arg_18_0._taskLoopType <= 2 and BpModel.instance:isWeeklyScoreFull())
	BpTaskModel.instance:refreshListView(arg_18_0._taskLoopType)
	arg_18_0:updateLineEnable()
	BpController.instance:dispatchEvent(BpEvent.SetGetAllEnable, BpTaskModel.instance.showQuickFinishTask)

	local var_18_0 = BpModel.instance.id or 0
	local var_18_1 = false

	if BpTaskModel.instance.haveTurnBackTask and GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.BpTurnBackNewMark .. var_18_0, "0") == "0" then
		var_18_1 = true
	end

	if arg_18_0._taskLoopType == 3 and var_18_1 then
		GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.BpTurnBackNewMark .. var_18_0, "1")

		var_18_1 = false
	end

	gohelper.setActive(arg_18_0._gonew, var_18_1)
end

function var_0_0.updateLineEnable(arg_19_0)
	local var_19_0 = true

	if BpTaskModel.instance.showQuickFinishTask then
		var_19_0 = false
	end

	if BpModel.instance.payStatus ~= BpEnum.PayStatus.Pay2 then
		var_19_0 = false
	end

	gohelper.setActive(arg_19_0._goline, var_19_0)
end

function var_0_0._refreshExpUp(arg_20_0)
	if not BpModel.instance:isShowExpUp() then
		for iter_20_0, iter_20_1 in ipairs(arg_20_0._expupGos) do
			gohelper.setActive(iter_20_1, false)
		end

		return
	end

	local var_20_0 = {}

	for iter_20_2, iter_20_3 in pairs(BpTaskModel.instance.serverTaskModel:getList()) do
		local var_20_1 = iter_20_3.config
		local var_20_2 = var_20_1.loopType
		local var_20_3 = 1000 + (var_20_1.bonusScoreTimes or 0) > 1000

		var_20_0[var_20_2] = var_20_0[var_20_2] or var_20_3
	end

	for iter_20_4, iter_20_5 in ipairs(arg_20_0._expupGos) do
		gohelper.setActive(iter_20_5, var_20_0[iter_20_4] or false)
	end
end

return var_0_0
