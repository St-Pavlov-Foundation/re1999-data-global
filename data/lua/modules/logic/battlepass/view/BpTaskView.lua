module("modules.logic.battlepass.view.BpTaskView", package.seeall)

slot0 = class("BpTaskView", BaseView)

function slot0.ctor(slot0)
	slot0._taskLoopType = 1
end

function slot0.onInitView(slot0)
	slot0._goline = gohelper.findChild(slot0.viewGO, "#go_line")
	slot0._goallcomplete = gohelper.findChild(slot0.viewGO, "#go_allcomplete")
	slot0._gonew = gohelper.findChild(slot0.viewGO, "toggleGroup/toggle3/#go_new")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnGetInfo, slot0._onTaskUpdate, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnTaskUpdate, slot0._onTaskUpdate, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnRedDotUpdate, slot0._onRedDotUpdate, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, slot0.updateLineEnable, slot0)
	slot0:addEventCb(slot0.viewContainer, BpEvent.OnTaskFinishAnim, slot0.playFinishAnim, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.OnGetInfo, slot0._onTaskUpdate, slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.OnTaskUpdate, slot0._onTaskUpdate, slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.OnRedDotUpdate, slot0._onRedDotUpdate, slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, slot0.updateLineEnable, slot0)
	slot0:removeEventCb(slot0.viewContainer, BpEvent.OnTaskFinishAnim, slot0.playFinishAnim, slot0)
end

function slot0._editableInitView(slot0)
	slot3 = ListScrollParam.New()
	slot3.scrollGOPath = "#scroll"
	slot3.prefabType = ScrollEnum.ScrollPrefabFromView
	slot3.prefabUrl = "#scroll/item"
	slot3.cellClass = BpTaskItem
	slot3.scrollDir = ScrollEnum.ScrollDirV
	slot3.lineCount = 1
	slot3.cellWidth = 1330
	slot3.cellHeight = 132
	slot3.cellSpaceH = 0
	slot3.cellSpaceV = 15
	slot3.startSpace = -2.5
	slot3.frameUpdateMs = 100
	slot0._scrollView = LuaListScrollView.New(BpTaskModel.instance, slot3)

	slot0:addChildView(slot0._scrollView)

	slot0._toggleGroupGO = gohelper.findChild(slot0.viewGO, "toggleGroup")
	slot0._toggleGroup = slot0._toggleGroupGO:GetComponent(typeof(UnityEngine.UI.ToggleGroup))
	slot0._redDotGO = gohelper.findChild(slot0.viewGO, "redDot")
	slot0._toggleWraps = slot0:getUserDataTb_()
	slot0._toggleRedDots = slot0:getUserDataTb_()

	for slot9 = 1, slot0._toggleGroupGO.transform.childCount do
		slot0._toggleRedDots[slot9] = gohelper.findChild(slot0._redDotGO, "#go_reddot" .. slot9)

		if slot4:GetChild(slot9 - 1).gameObject:GetComponent(typeof(UnityEngine.UI.Toggle)) then
			slot13 = gohelper.onceAddComponent(slot11, typeof(SLFramework.UGUI.ToggleWrap))

			slot13:AddOnValueChanged(slot0._onToggleValueChanged, slot0, slot9)

			slot0._toggleWraps[slot9] = slot13
		end
	end

	slot0._taskHeight = slot1 + slot2
	slot0._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(slot0._scrollView)

	slot0._taskAnimRemoveItem:setMoveInterval(0)
	slot0._taskAnimRemoveItem:setMoveAnimationTime(BpEnum.TaskMaskTime - BpEnum.TaskGetAnimTime)
	slot0:_onRedDotUpdate()
	TaskDispatcher.runDelay(slot0._delayPlayTaskAnim, slot0, 0)
end

function slot0._delayPlayTaskAnim(slot0)
	slot0.viewContainer:dispatchEvent(BpEvent.TapViewOpenAnimBegin, 2)
end

function slot0._onClickbtnGetAll(slot0)
	slot1 = BpTaskModel.instance:getList()
	slot2 = false
	slot0._tweenIndexes = {}

	if not BpModel.instance:isWeeklyScoreFull() or slot3 and slot0._taskLoopType == 3 then
		for slot7, slot8 in ipairs(slot1) do
			if slot8.config.maxProgress <= slot8.progress and slot8.finishCount == 0 then
				slot2 = true

				table.insert(slot0._tweenIndexes, slot7)

				break
			end
		end
	end

	if slot2 then
		slot0.viewContainer:dispatchEvent(BpEvent.OnTaskFinishAnim)
		UIBlockMgr.instance:startBlock("BpTaskItemFinish")
		TaskDispatcher.runDelay(slot0.finishAllTask, slot0, BpEnum.TaskMaskTime)
	else
		slot0:finishAllTask()
	end
end

function slot0.playFinishAnim(slot0, slot1)
	if slot1 then
		slot0._tweenIndexes = {
			slot1
		}
	end

	TaskDispatcher.runDelay(slot0.delayPlayFinishAnim, slot0, BpEnum.TaskGetAnimTime)
end

function slot0.delayPlayFinishAnim(slot0)
	slot0._taskAnimRemoveItem:removeByIndexs(slot0._tweenIndexes)
end

function slot0.finishAllTask(slot0)
	UIBlockMgr.instance:endBlock("BpTaskItemFinish")
	TaskDispatcher.cancelTask(slot0.finishAllTask, slot0)
	TaskDispatcher.cancelTask(slot0.delayPlayFinishAnim, slot0)

	slot0._preBpScore = BpModel.instance.score
	BpModel.instance.lockLevelUpShow = true
	slot2 = nil

	if BpModel.instance:isWeeklyScoreFull() then
		for slot6, slot7 in pairs(BpTaskModel.instance.serverTaskModel:getList()) do
			if slot7.config.loopType ~= 1 and slot8 ~= 2 and slot7.config.maxProgress <= slot7.progress and slot7.finishCount == 0 and slot7.config.bpId == BpModel.instance.id then
				table.insert({}, slot7.config.id)
			end
		end
	end

	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.BattlePass, nil, slot2, slot0._onTaskSendFinish, slot0)
end

function slot0._onTaskSendFinish(slot0, slot1, slot2, slot3)
	if slot2 == 0 and BpModel.instance.lockLevelUpShow and BpModel.instance:checkLevelUp(BpModel.instance.score, slot0._preBpScore) then
		BpModel.instance.preStatus = {
			score = slot0._preBpScore,
			payStatus = BpModel.instance.payStatus
		}

		BpController.instance:onBpLevelUp()
	end

	BpModel.instance.lockLevelUpShow = false
end

function slot0._onRedDotUpdate(slot0)
	for slot4 = 1, #slot0._toggleRedDots do
		gohelper.setActive(slot0._toggleRedDots[slot4], BpTaskModel.instance:getHaveRedDot(slot4))
	end
end

function slot0._onToggleValueChanged(slot0, slot1, slot2)
	if slot2 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_vertical_second_tabs_click)

		slot0._taskLoopType = slot1

		slot0:_onTaskUpdate()
	end

	slot0:_setToggleLabelColor()
end

function slot0._setToggleLabelColor(slot0)
	for slot4 = 1, #slot0._toggleWraps do
		SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildText(slot0._toggleWraps[slot4].gameObject, "Label"), slot0._taskLoopType == slot4 and "#c66030" or "#888888")
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._delayPlayTaskAnim, slot0)
	UIBlockMgr.instance:endBlock("BpTaskItemFinish")
	TaskDispatcher.cancelTask(slot0.finishAllTask, slot0)
	TaskDispatcher.cancelTask(slot0.delayPlayFinishAnim, slot0)

	BpModel.instance.lockLevelUpShow = false
end

function slot0.onDestroyView(slot0)
	for slot4 = 1, #slot0._toggleWraps do
		slot0._toggleWraps[slot4]:RemoveOnValueChanged()
	end

	slot0._toggleWraps = nil
end

function slot0.onOpen(slot0)
	slot5 = slot0

	BpController.instance:dispatchEvent(BpEvent.SetGetAllCallBack, slot0._onClickbtnGetAll, slot5)

	slot1 = 1

	for slot5 = 1, 3 do
		if BpTaskModel.instance:getHaveRedDot(slot5) then
			slot1 = slot5

			break
		end
	end

	slot0._taskLoopType = slot1

	for slot5 = 1, #slot0._toggleWraps do
		slot0._toggleWraps[slot5].isOn = slot5 == slot1
	end

	BpTaskModel.instance:sortList()
	slot0:_onTaskUpdate()
end

function slot0._onTaskUpdate(slot0)
	slot0.viewContainer:dispatchEvent(BpEvent.TaskTabChange, slot0._taskLoopType)
	gohelper.setActive(slot0._goallcomplete, slot0._taskLoopType <= 2 and BpModel.instance:isWeeklyScoreFull())
	BpTaskModel.instance:refreshListView(slot0._taskLoopType)
	slot0:updateLineEnable()
	BpController.instance:dispatchEvent(BpEvent.SetGetAllEnable, BpTaskModel.instance.showQuickFinishTask)

	slot2 = false

	if BpTaskModel.instance.haveTurnBackTask and GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.BpTurnBackNewMark .. (BpModel.instance.id or 0), "0") == "0" then
		slot2 = true
	end

	if slot0._taskLoopType == 3 and slot2 then
		GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.BpTurnBackNewMark .. slot1, "1")

		slot2 = false
	end

	gohelper.setActive(slot0._gonew, slot2)
end

function slot0.updateLineEnable(slot0)
	slot1 = true

	if BpTaskModel.instance.showQuickFinishTask then
		slot1 = false
	end

	if BpModel.instance.payStatus ~= BpEnum.PayStatus.Pay2 then
		slot1 = false
	end

	gohelper.setActive(slot0._goline, slot1)
end

return slot0
