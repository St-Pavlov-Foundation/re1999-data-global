module("modules.logic.battlepass.view.BpTaskView", package.seeall)

local var_0_0 = class("BpTaskView", BaseView)

function var_0_0.ctor(arg_1_0)
	arg_1_0._taskLoopType = 1
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._goline = gohelper.findChild(arg_2_0.viewGO, "#go_line")
	arg_2_0._goallcomplete = gohelper.findChild(arg_2_0.viewGO, "#go_allcomplete")
	arg_2_0._gonew = gohelper.findChild(arg_2_0.viewGO, "toggleGroup/toggle3/#go_new")
	arg_2_0._gooperactshow = gohelper.findChild(arg_2_0.viewGO, "#go_operactshow")
	arg_2_0._btnopershow = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#go_operactshow/#btn_jump")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnopershow:AddClickListener(arg_3_0._btnopershowOnClick, arg_3_0)
	arg_3_0:addEventCb(BpController.instance, BpEvent.OnGetInfo, arg_3_0._onTaskUpdate, arg_3_0)
	arg_3_0:addEventCb(BpController.instance, BpEvent.OnTaskUpdate, arg_3_0._onTaskUpdate, arg_3_0)
	arg_3_0:addEventCb(BpController.instance, BpEvent.OnRedDotUpdate, arg_3_0._onRedDotUpdate, arg_3_0)
	arg_3_0:addEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, arg_3_0.updateLineEnable, arg_3_0)
	arg_3_0:addEventCb(arg_3_0.viewContainer, BpEvent.OnTaskFinishAnim, arg_3_0.playFinishAnim, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnopershow:RemoveClickListener()
	arg_4_0:removeEventCb(BpController.instance, BpEvent.OnGetInfo, arg_4_0._onTaskUpdate, arg_4_0)
	arg_4_0:removeEventCb(BpController.instance, BpEvent.OnTaskUpdate, arg_4_0._onTaskUpdate, arg_4_0)
	arg_4_0:removeEventCb(BpController.instance, BpEvent.OnRedDotUpdate, arg_4_0._onRedDotUpdate, arg_4_0)
	arg_4_0:removeEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, arg_4_0.updateLineEnable, arg_4_0)
	arg_4_0:removeEventCb(arg_4_0.viewContainer, BpEvent.OnTaskFinishAnim, arg_4_0.playFinishAnim, arg_4_0)
end

function var_0_0._btnopershowOnClick(arg_5_0)
	local var_5_0 = BpModel.instance.id
	local var_5_1 = BpConfig.instance:getBpCO(var_5_0).activityId

	if var_5_1 and var_5_1 > 0 then
		local var_5_2 = string.format("%s#%s", JumpEnum.JumpView.ActivityView, var_5_1)

		JumpController.instance:jumpByParam(var_5_2)
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._operactAnim = arg_6_0._gooperactshow:GetComponent(typeof(UnityEngine.Animator))

	local var_6_0 = 132
	local var_6_1 = 15
	local var_6_2 = ListScrollParam.New()

	var_6_2.scrollGOPath = "#scroll"
	var_6_2.prefabType = ScrollEnum.ScrollPrefabFromView
	var_6_2.prefabUrl = "#scroll/item"
	var_6_2.cellClass = BpTaskItem
	var_6_2.scrollDir = ScrollEnum.ScrollDirV
	var_6_2.lineCount = 1
	var_6_2.cellWidth = 1330
	var_6_2.cellHeight = var_6_0
	var_6_2.cellSpaceH = 0
	var_6_2.cellSpaceV = var_6_1
	var_6_2.startSpace = -2.5
	var_6_2.frameUpdateMs = 100
	arg_6_0._scrollView = LuaListScrollView.New(BpTaskModel.instance, var_6_2)

	arg_6_0:addChildView(arg_6_0._scrollView)

	arg_6_0._toggleGroupGO = gohelper.findChild(arg_6_0.viewGO, "toggleGroup")
	arg_6_0._toggleGroup = arg_6_0._toggleGroupGO:GetComponent(typeof(UnityEngine.UI.ToggleGroup))
	arg_6_0._redDotGO = gohelper.findChild(arg_6_0.viewGO, "redDot")
	arg_6_0._toggleWraps = arg_6_0:getUserDataTb_()
	arg_6_0._toggleRedDots = arg_6_0:getUserDataTb_()
	arg_6_0._expupGos = arg_6_0:getUserDataTb_()

	local var_6_3 = arg_6_0._toggleGroupGO.transform
	local var_6_4 = var_6_3.childCount

	for iter_6_0 = 1, var_6_4 do
		local var_6_5 = var_6_3:GetChild(iter_6_0 - 1).gameObject
		local var_6_6 = var_6_5:GetComponent(typeof(UnityEngine.UI.Toggle))

		arg_6_0._toggleRedDots[iter_6_0] = gohelper.findChild(arg_6_0._redDotGO, "#go_reddot" .. iter_6_0)

		if var_6_6 then
			local var_6_7 = gohelper.onceAddComponent(var_6_5, typeof(SLFramework.UGUI.ToggleWrap))

			var_6_7:AddOnValueChanged(arg_6_0._onToggleValueChanged, arg_6_0, iter_6_0)

			arg_6_0._toggleWraps[iter_6_0] = var_6_7
		end

		local var_6_8 = gohelper.findChild(var_6_5, "Label/#go_expup")

		table.insert(arg_6_0._expupGos, var_6_8)
	end

	arg_6_0._taskHeight = var_6_0 + var_6_1
	arg_6_0._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(arg_6_0._scrollView)

	arg_6_0._taskAnimRemoveItem:setMoveInterval(0)
	arg_6_0._taskAnimRemoveItem:setMoveAnimationTime(BpEnum.TaskMaskTime - BpEnum.TaskGetAnimTime)
	arg_6_0:_onRedDotUpdate()
	TaskDispatcher.runDelay(arg_6_0._delayPlayTaskAnim, arg_6_0, 0)
end

function var_0_0._delayPlayTaskAnim(arg_7_0)
	arg_7_0.viewContainer:dispatchEvent(BpEvent.TapViewOpenAnimBegin, 2)
end

function var_0_0._onClickbtnGetAll(arg_8_0)
	local var_8_0 = BpTaskModel.instance:getList()
	local var_8_1 = false

	arg_8_0._tweenIndexes = {}

	local var_8_2 = BpModel.instance:isWeeklyScoreFull()

	if not var_8_2 or var_8_2 and arg_8_0._taskLoopType == 3 then
		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			if iter_8_1.progress >= iter_8_1.config.maxProgress and iter_8_1.finishCount == 0 then
				var_8_1 = true

				table.insert(arg_8_0._tweenIndexes, iter_8_0)

				break
			end
		end
	end

	if var_8_1 then
		arg_8_0.viewContainer:dispatchEvent(BpEvent.OnTaskFinishAnim)
		UIBlockMgr.instance:startBlock("BpTaskItemFinish")
		TaskDispatcher.runDelay(arg_8_0.finishAllTask, arg_8_0, BpEnum.TaskMaskTime)
	else
		arg_8_0:finishAllTask()
	end
end

function var_0_0.playFinishAnim(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0._tweenIndexes = {
			arg_9_1
		}
	end

	TaskDispatcher.runDelay(arg_9_0.delayPlayFinishAnim, arg_9_0, BpEnum.TaskGetAnimTime)
end

function var_0_0.delayPlayFinishAnim(arg_10_0)
	arg_10_0._taskAnimRemoveItem:removeByIndexs(arg_10_0._tweenIndexes)
end

function var_0_0.finishAllTask(arg_11_0)
	UIBlockMgr.instance:endBlock("BpTaskItemFinish")
	TaskDispatcher.cancelTask(arg_11_0.finishAllTask, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.delayPlayFinishAnim, arg_11_0)

	arg_11_0._preBpScore = BpModel.instance.score
	BpModel.instance.lockLevelUpShow = true

	local var_11_0 = BpModel.instance:isWeeklyScoreFull()
	local var_11_1

	if var_11_0 then
		var_11_1 = {}

		for iter_11_0, iter_11_1 in pairs(BpTaskModel.instance.serverTaskModel:getList()) do
			local var_11_2 = iter_11_1.config.loopType

			if var_11_2 ~= 1 and var_11_2 ~= 2 and iter_11_1.progress >= iter_11_1.config.maxProgress and iter_11_1.finishCount == 0 and iter_11_1.config.bpId == BpModel.instance.id then
				table.insert(var_11_1, iter_11_1.config.id)
			end
		end
	end

	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.BattlePass, nil, var_11_1, arg_11_0._onTaskSendFinish, arg_11_0)
end

function var_0_0._onTaskSendFinish(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_2 == 0 and BpModel.instance.lockLevelUpShow and BpModel.instance:checkLevelUp(BpModel.instance.score, arg_12_0._preBpScore) then
		BpModel.instance.preStatus = {
			score = arg_12_0._preBpScore,
			payStatus = BpModel.instance.payStatus
		}

		BpController.instance:onBpLevelUp()
	end

	BpModel.instance.lockLevelUpShow = false
end

function var_0_0._onRedDotUpdate(arg_13_0)
	for iter_13_0 = 1, #arg_13_0._toggleRedDots do
		gohelper.setActive(arg_13_0._toggleRedDots[iter_13_0], BpTaskModel.instance:getHaveRedDot(iter_13_0))
	end
end

function var_0_0._onToggleValueChanged(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_vertical_second_tabs_click)

		arg_14_0._taskLoopType = arg_14_1

		arg_14_0:_onTaskUpdate()
	end

	arg_14_0:_setToggleLabelColor()
end

function var_0_0._setToggleLabelColor(arg_15_0)
	for iter_15_0 = 1, #arg_15_0._toggleWraps do
		local var_15_0 = gohelper.findChildText(arg_15_0._toggleWraps[iter_15_0].gameObject, "Label")

		SLFramework.UGUI.GuiHelper.SetColor(var_15_0, arg_15_0._taskLoopType == iter_15_0 and "#c66030" or "#888888")
	end
end

function var_0_0.onClose(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._delayPlayTaskAnim, arg_16_0)
	UIBlockMgr.instance:endBlock("BpTaskItemFinish")
	TaskDispatcher.cancelTask(arg_16_0.finishAllTask, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.delayPlayFinishAnim, arg_16_0)

	BpModel.instance.lockLevelUpShow = false
end

function var_0_0.onDestroyView(arg_17_0)
	for iter_17_0 = 1, #arg_17_0._toggleWraps do
		arg_17_0._toggleWraps[iter_17_0]:RemoveOnValueChanged()
	end

	arg_17_0._toggleWraps = nil
end

function var_0_0.onOpen(arg_18_0)
	BpController.instance:dispatchEvent(BpEvent.SetGetAllCallBack, arg_18_0._onClickbtnGetAll, arg_18_0)

	local var_18_0 = 1

	for iter_18_0 = 1, 3 do
		if BpTaskModel.instance:getHaveRedDot(iter_18_0) then
			var_18_0 = iter_18_0

			break
		end
	end

	arg_18_0._taskLoopType = var_18_0

	for iter_18_1 = 1, #arg_18_0._toggleWraps do
		arg_18_0._toggleWraps[iter_18_1].isOn = iter_18_1 == var_18_0
	end

	BpTaskModel.instance:sortList()
	arg_18_0:_onTaskUpdate()
	arg_18_0:_refreshExpUp()
end

function var_0_0._onTaskUpdate(arg_19_0)
	arg_19_0.viewContainer:dispatchEvent(BpEvent.TaskTabChange, arg_19_0._taskLoopType)
	BpTaskModel.instance:refreshListView(arg_19_0._taskLoopType)
	arg_19_0:updateLineEnable()
	BpController.instance:dispatchEvent(BpEvent.SetGetAllEnable, BpTaskModel.instance.showQuickFinishTask)

	local var_19_0 = BpModel.instance.id or 0
	local var_19_1 = false

	if BpTaskModel.instance.haveTurnBackTask and GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.BpTurnBackNewMark .. var_19_0, "0") == "0" then
		var_19_1 = true
	end

	if arg_19_0._taskLoopType == 3 and var_19_1 then
		GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.BpTurnBackNewMark .. var_19_0, "1")

		var_19_1 = false
	end

	gohelper.setActive(arg_19_0._gonew, var_19_1)

	local var_19_2 = BpTaskModel.instance:isLoopTypeTaskAllFinished(arg_19_0._taskLoopType)
	local var_19_3 = V3a1_BpOperActModel.instance:isAllTaskFinihshed()
	local var_19_4 = BpModel.instance:isMaxLevel()
	local var_19_5 = ActivityModel.instance:getActivityInfo()[VersionActivity3_1Enum.ActivityId.BpOperAct]
	local var_19_6 = var_19_5:isOpen() and var_19_5:isOnline() and not var_19_5:isExpired()
	local var_19_7 = var_19_2 and not var_19_4 and not var_19_3 and var_19_6

	gohelper.setActive(arg_19_0._gooperactshow, var_19_7)

	if var_19_7 then
		arg_19_0._operactAnim:Play("open", 0, 0)

		return
	end

	local var_19_8 = not var_19_7 and arg_19_0._taskLoopType <= 2 and BpModel.instance:isWeeklyScoreFull()

	gohelper.setActive(arg_19_0._goallcomplete, var_19_8)
end

function var_0_0.updateLineEnable(arg_20_0)
	local var_20_0 = true

	if BpTaskModel.instance.showQuickFinishTask then
		var_20_0 = false
	end

	if BpModel.instance.payStatus ~= BpEnum.PayStatus.Pay2 then
		var_20_0 = false
	end

	gohelper.setActive(arg_20_0._goline, var_20_0)
end

function var_0_0._refreshExpUp(arg_21_0)
	if not BpModel.instance:isShowExpUp() then
		for iter_21_0, iter_21_1 in ipairs(arg_21_0._expupGos) do
			gohelper.setActive(iter_21_1, false)
		end

		return
	end

	local var_21_0 = {}

	for iter_21_2, iter_21_3 in pairs(BpTaskModel.instance.serverTaskModel:getList()) do
		local var_21_1 = iter_21_3.config
		local var_21_2 = var_21_1.loopType
		local var_21_3 = 1000 + (var_21_1.bonusScoreTimes or 0) > 1000

		var_21_0[var_21_2] = var_21_0[var_21_2] or var_21_3
	end

	for iter_21_4, iter_21_5 in ipairs(arg_21_0._expupGos) do
		gohelper.setActive(iter_21_5, var_21_0[iter_21_4] or false)
	end
end

return var_0_0
