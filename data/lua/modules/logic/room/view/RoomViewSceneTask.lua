module("modules.logic.room.view.RoomViewSceneTask", package.seeall)

slot0 = class("RoomViewSceneTask", BaseView)

function slot0.onInitView(slot0)
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "go_normalroot/go_taskpanel/go_detail/go_taskContent")
	slot0._gopanel = gohelper.findChild(slot0.viewGO, "go_normalroot/go_taskpanel")
	slot0._btnexpand = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/go_taskpanel/btn_expand")
	slot0._btnfold = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/go_taskpanel/btn_fold")
	slot0._gosimple = gohelper.findChild(slot0.viewGO, "go_normalroot/go_taskpanel/go_simple")
	slot0._godetail = gohelper.findChild(slot0.viewGO, "go_normalroot/go_taskpanel/go_detail")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnexpand:AddClickListener(slot0.onClickExpand, slot0)
	slot0._btnfold:AddClickListener(slot0.onClickExpand, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnexpand:RemoveClickListener()
	slot0._btnfold:RemoveClickListener()
end

slot0.AutoHideTime = 3
slot0.DelayHideToShowTime = 1.5

function slot0._editableInitView(slot0)
	slot0._animatorpanel = slot0._gopanel:GetComponent(typeof(UnityEngine.Animator))
	slot0._rectpanel = slot0._gopanel.transform
	slot0._taskItems = {}
	slot0._needPlayAnimShow = false
	slot0._isBreakAutoHide = false
	slot0._isForceHideArrow = false
	slot0._firstEnterRefresh = true

	gohelper.setActive(slot0._gocontainer, true)
	gohelper.setActive(slot0._godetail, true)
	gohelper.setActive(slot0._btnfold, false)
end

function slot0.onDestroyView(slot0)
	if slot0._taskItems then
		for slot4, slot5 in pairs(slot0._taskItems) do
			slot5.btnnormal:RemoveClickListener()
			gohelper.setActive(slot5.gotask, true)
		end

		slot0._taskItems = nil
	end
end

function slot0.onOpen(slot0)
	slot0:addEventCb(RoomSceneTaskController.instance, RoomEvent.TaskUpdate, slot0.refreshUI, slot0)
	slot0:addEventCb(RoomSceneTaskController.instance, RoomEvent.TaskCanFinish, slot0.playCanGetRewardVfx, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ClientPlaceBlock, slot0.refreshUI, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ClientCancelBlock, slot0.refreshUI, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ClientTryBackBlock, slot0.refreshUI, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ClientCancelBackBlock, slot0.refreshUI, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.TransportPathViewShowChanged, slot0.refreshUI, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.GuideShowSceneTask, slot0._guideShowSceneTask, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.BackBlockShowChanged, slot0.refreshUI, slot0)
	slot0:addEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, slot0.refreshUI, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.handleOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.handleCloseView, slot0)
	slot0:addEventCb(RoomSceneTaskController.instance, RoomEvent.TaskShowHideAnim, slot0.handleTaskHideAnim, slot0)

	slot0._taskAnimIds = {}
	slot0._taskAnimIdMap = {}

	RoomSceneTaskController.instance:init()
	RoomSceneTaskController.instance:setTaskCheckFinishFlag(true)

	slot0._isExpand = true

	slot0:refreshUI()
end

function slot0.onClose(slot0)
	slot0:disposeAllAnim()

	if slot0:isAnimPlaying() then
		UIBlockMgrExtend.setNeedCircleMv(true)
		UIBlockMgr.instance:endBlock(UIBlockKey.RoomTaskFinish)
	end

	RoomSceneTaskController.instance:release()
	TaskDispatcher.cancelTask(slot0.onDelayObAutoHide, slot0)
	TaskDispatcher.cancelTask(slot0.startPlayTaskFinish, slot0)
end

function slot0.enterObAutoHide(slot0)
	slot0:_stopAutoHideTask()

	if RoomController.instance:isObMode() then
		slot0._isBreakAutoHide = false
		slot0._isHasAutoHideTaskRun = true

		TaskDispatcher.runDelay(slot0.onDelayObAutoHide, slot0, uv0.AutoHideTime)
	end
end

function slot0._stopAutoHideTask(slot0)
	if slot0._isHasAutoHideTaskRun then
		TaskDispatcher.cancelTask(slot0.onDelayObAutoHide, slot0)

		slot0._isHasAutoHideTaskRun = false
	end
end

function slot0.onDelayObAutoHide(slot0)
	slot0:_stopAutoHideTask()

	if not slot0._isBreakAutoHide then
		slot0:_showHidAnim(true)

		slot0._isBreakAutoHide = false
	end
end

function slot0._showHidAnim(slot0, slot1)
	if slot1 then
		slot0._isBreakAutoHide = true

		slot0:_stopAutoHideTask()
	end

	if slot0._lastAnimHide ~= (slot1 == true) then
		slot0._lastAnimHide = slot2

		slot0._animatorpanel:Play(slot2 and "close" or UIAnimationName.Open)
	end

	slot0._isExpand = not slot1

	slot0:refreshExpand()
end

function slot0._guideShowSceneTask(slot0)
	slot0._isExpand = true

	slot0:refreshExpand()
end

function slot0.onClickExpand(slot0)
	slot0:_showHidAnim(slot0._isExpand)
	slot0:enterObAutoHide()
end

function slot0.onClickNormalOpen(slot0)
	slot2 = slot0.index

	if slot0.self:isAnimPlaying() then
		return
	end

	if not slot1._isExpand then
		slot1:onClickExpand()

		return
	end

	if not RoomSceneTaskController.instance:checkTaskFinished() then
		ViewMgr.instance:openView(ViewName.RoomSceneTaskDetailView)
	end
end

function slot0.refreshUI(slot0)
	if slot0:isAnimPlaying() then
		return
	end

	slot2 = #RoomTaskModel.instance:getShowList() > 0

	if #slot1 > 0 then
		if slot0._firstEnterRefresh then
			slot0._firstEnterRefresh = false

			slot0:enterObAutoHide()
		end

		slot0:refreshExpand()
		slot0:refreshItems()
	end

	if RoomController.instance:isEditMode() and (RoomMapBlockModel.instance:isBackMore() or RoomWaterReformModel.instance:isWaterReform() or ViewMgr.instance:isOpen(ViewName.RoomTransportPathView)) then
		slot2 = false
	end

	gohelper.setActive(slot0._gopanel, slot2)
end

function slot0.refreshExpand(slot0)
	if slot0._isForceHideArrow then
		gohelper.setActive(slot0._btnexpand, false)
	else
		gohelper.setActive(slot0._btnexpand, not slot0._isExpand)
	end
end

function slot0.refreshItems(slot0)
	slot1 = RoomTaskModel.instance:getShowList()

	slot0:refreshItemWithTask(slot0:getOrCreateItem(1), RoomTaskModel.instance:tryGetTaskMO(slot1[1].id), slot1[1])
end

function slot0.refreshItemWithTask(slot0, slot1, slot2, slot3)
	if slot0._needPlayAnimShow then
		slot1.animator:Play(RoomSceneTaskEnum.AnimName.Show, 0, 0)

		slot0._needPlayAnimShow = false
	end

	gohelper.setActive(slot1.go, true)
	gohelper.setActive(slot1.gotask, true)

	if slot2 then
		slot4, slot5 = RoomSceneTaskController.getProgressStatus(slot2)

		if slot4 then
			slot1.txtdesc.text = string.format("%s(%s/%s)", slot3.desc, slot5, slot3.maxProgress)
		else
			slot1.txtdesc.text = string.format("%s(<color=#ba6662>%s</color>/%s)", slot3.desc, slot5, slot3.maxProgress)
		end

		gohelper.setActive(slot1.gohasreward, slot4)
	else
		logNormal("No taskMO with taskID : " .. tostring(slot3.id))

		slot1.txtdesc.text = slot3.desc

		gohelper.setActive(slot1.gohasreward, false)
	end

	if not string.nilorempty(slot3.bonus) and #string.split(slot3.bonus, "|") > 0 then
		slot4 = string.splitToNumber(slot4[1], "#")

		slot1.iconComp:setMOValue(slot4[1], slot4[2], slot4[3])
		slot1.iconComp:isShowEquipAndItemCount(false)
		gohelper.setActive(slot1.countbg, true)
		gohelper.setAsLastSibling(slot1.countbg)

		slot1.count.text = tostring(GameUtil.numberDisplay(slot4[3]))
	end
end

function slot0.playCanGetRewardVfx(slot0, slot1)
	slot0._isBreakAutoHide = true

	if RoomMapModel.instance:isRoomLeveling() or ViewMgr.instance:isOpen(ViewName.RoomLevelUpTipsView) then
		return
	end

	logNormal("notify playCanGetRewardVfx")
	slot0:appendToAnimPipeline(slot1)
end

function slot0.appendToAnimPipeline(slot0, slot1)
	slot3 = #slot0._taskAnimIds
	slot4 = {
		[slot9] = true
	}

	for slot8, slot9 in pairs(slot1) do
		if not slot0._taskAnimIdMap[slot9] and RoomTaskModel.instance:tryGetTaskMO(slot9) then
			slot12 = {
				self = slot0,
				taskCo = slot10.config,
				taskMo = slot10,
				isFirst = slot3 == 0
			}

			table.insert(slot0._taskAnimIds, slot12)

			slot0._taskAnimIdMap[slot9] = slot12
			slot3 = slot3 + 1
		end
	end

	for slot8, slot9 in pairs(slot0._taskAnimIdMap) do
		if not slot4[slot8] and #slot0._taskAnimIds > 0 and slot0._taskAnimIds[1].taskCo.id ~= slot8 then
			slot0:removeAnimParam(slot8, true)
		end
	end

	if slot2 == 0 and slot3 ~= 0 then
		slot0._isAnimPlaying = true

		UIBlockMgr.instance:endAll()
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock(UIBlockKey.RoomTaskFinish)
		slot0:_stopAutoHideTask()
		slot0:checkIfNodeHidePlay()
	end
end

function slot0.removeAnimParam(slot0, slot1, slot2)
	if slot0._taskAnimIdMap[slot1] then
		if slot2 then
			slot0._taskAnimIdMap[slot1] = nil
		end

		for slot6, slot7 in ipairs(slot0._taskAnimIds) do
			if slot7.taskCo.id == slot1 then
				logNormal("delete taskId in array = " .. tostring(slot1))
				table.remove(slot0._taskAnimIds, slot6)

				break
			end
		end
	end
end

function slot0.checkIfNodeHidePlay(slot0)
	if slot0._lastAnimHide then
		slot0._isBreakAutoHide = true

		slot0:_showHidAnim(false)
		TaskDispatcher.runDelay(slot0.startPlayTaskFinish, slot0, uv0.DelayHideToShowTime)
	else
		slot0:startPlayTaskFinish()
	end
end

function slot0.startPlayTaskFinish(slot0)
	slot1 = slot0._taskAnimIds[1]

	slot0:disposeAllAnim()
	slot0:refreshItemWithTask(slot0:getOrCreateItem(1), slot1.taskMo, slot1.taskCo)

	if not slot1.isFirst then
		slot2.animator:Play(RoomSceneTaskEnum.AnimName.Show, 0, 0)
		slot2.animatorEvent:AddEventListener(RoomSceneTaskEnum.AnimEventName.ShowFinish, uv0.onAnimShowFinished, slot1)
	else
		slot2.animator:Play(RoomSceneTaskEnum.AnimName.Play, 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mission_complete)
		slot2.animatorEvent:AddEventListener(RoomSceneTaskEnum.AnimEventName.PlayFinish, uv0.onAnimPlayFinished, slot1)
	end
end

function slot0.onAnimShowFinished(slot0)
	slot2 = slot0.self:getOrCreateItem(1)

	slot2.animatorEvent:AddEventListener(RoomSceneTaskEnum.AnimEventName.PlayFinish, uv0.onAnimPlayFinished, slot0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mission_complete)
	slot2.animator:Play(RoomSceneTaskEnum.AnimName.Play, 0, 0)
end

function slot0.onAnimPlayFinished(slot0)
	slot1 = slot0.self

	slot1:removeAnimParam(slot0.taskCo.id)
	slot1:disposeAllAnim()

	if #slot1._taskAnimIds > 0 then
		slot1:startPlayTaskFinish()
	else
		for slot6, slot7 in pairs(slot1._taskAnimIdMap) do
			slot1._taskAnimIdMap[slot6] = nil
		end

		slot1._needPlayAnimShow = true
		slot3, slot4 = RoomSceneTaskController.instance:isFirstTaskFinished()

		if slot3 then
			RoomSceneTaskController.instance:setTaskCheckFinishFlag(false)
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Room, nil, slot4, slot1.onSendAllTaskCompleted, slot1)
		end

		UIBlockMgrExtend.setNeedCircleMv(true)
		UIBlockMgr.instance:endBlock(UIBlockKey.RoomTaskFinish)

		slot1._isAnimPlaying = false

		slot1:enterObAutoHide()
		slot1:refreshUI()
	end
end

function slot0.disposeAllAnim(slot0)
	if not gohelper.isNil(slot0:getOrCreateItem(1).animatorEvent) then
		for slot5, slot6 in pairs(RoomSceneTaskEnum.AnimEventName) do
			slot1.animatorEvent:RemoveEventListener(slot6)
		end
	end
end

function slot0.isAnimPlaying(slot0)
	return slot0._isAnimPlaying == true
end

function slot0.onSendAllTaskCompleted(slot0, slot1, slot2)
	RoomSceneTaskController.instance:setTaskCheckFinishFlag(true)
end

function slot0.handleOpenView(slot0, slot1)
	if slot1 == ViewName.CommonPropView or slot1 == ViewName.RoomLevelUpTipsView then
		RoomSceneTaskController.instance:setTaskCheckFinishFlag(false)
	elseif slot1 == ViewName.RoomCharacterPlaceView then
		slot0:_showHidAnim(true)
	end
end

function slot0.handleCloseView(slot0, slot1)
	if slot1 == ViewName.CommonPropView or slot1 == ViewName.RoomLevelUpTipsView then
		RoomSceneTaskController.instance:setTaskCheckFinishFlag(true)
		RoomSceneTaskController.instance:checkTaskFinished()
	end
end

function slot0.getOrCreateItem(slot0, slot1)
	if not slot0._taskItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot4 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[4], slot0._gocontainer, "task_item")
		slot4.name = "task_item" .. slot1
		slot2.go = slot4
		slot2.txtdesc = gohelper.findChildText(slot4, "go_task/txt_taskitemdesc")
		slot2.gotask = gohelper.findChild(slot4, "go_task")
		slot2.goicon = gohelper.findChild(slot4, "go_task/go_icon")
		slot2.gohasreward = gohelper.findChild(slot4, "go_task/go_hasreward")
		slot2.countbg = gohelper.findChild(slot4, "go_task/go_icon/countbg")
		slot2.count = gohelper.findChildText(slot4, "go_task/go_icon/countbg/count")
		slot2.btnnormal = gohelper.findChildButtonWithAudio(slot4, "btn_normalclick")

		slot2.btnnormal:AddClickListener(slot0.onClickNormalOpen, {
			self = slot0,
			index = slot1
		})

		slot2.iconComp = IconMgr.instance:getCommonPropItemIcon(slot2.goicon)
		slot2.animator = slot4:GetComponent(typeof(UnityEngine.Animator))
		slot2.animatorEvent = slot4:GetComponent(typeof(ZProj.AnimationEventWrap))
		slot0._taskItems[slot1] = slot2
	end

	return slot2
end

function slot0.handleTaskHideAnim(slot0, slot1)
	slot0._isForceHideArrow = slot1

	slot0:_showHidAnim(true)
end

return slot0
