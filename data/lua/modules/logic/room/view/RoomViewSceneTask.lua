module("modules.logic.room.view.RoomViewSceneTask", package.seeall)

local var_0_0 = class("RoomViewSceneTask", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/go_taskpanel/go_detail/go_taskContent")
	arg_1_0._gopanel = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/go_taskpanel")
	arg_1_0._btnexpand = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/go_taskpanel/btn_expand")
	arg_1_0._btnfold = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/go_taskpanel/btn_fold")
	arg_1_0._gosimple = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/go_taskpanel/go_simple")
	arg_1_0._godetail = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/go_taskpanel/go_detail")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnexpand:AddClickListener(arg_2_0.onClickExpand, arg_2_0)
	arg_2_0._btnfold:AddClickListener(arg_2_0.onClickExpand, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnexpand:RemoveClickListener()
	arg_3_0._btnfold:RemoveClickListener()
end

var_0_0.AutoHideTime = 3
var_0_0.DelayHideToShowTime = 1.5

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._animatorpanel = arg_4_0._gopanel:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._rectpanel = arg_4_0._gopanel.transform
	arg_4_0._taskItems = {}
	arg_4_0._needPlayAnimShow = false
	arg_4_0._isBreakAutoHide = false
	arg_4_0._isForceHideArrow = false
	arg_4_0._firstEnterRefresh = true

	gohelper.setActive(arg_4_0._gocontainer, true)
	gohelper.setActive(arg_4_0._godetail, true)
	gohelper.setActive(arg_4_0._btnfold, false)
end

function var_0_0.onDestroyView(arg_5_0)
	if arg_5_0._taskItems then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._taskItems) do
			iter_5_1.btnnormal:RemoveClickListener()
			gohelper.setActive(iter_5_1.gotask, true)
		end

		arg_5_0._taskItems = nil
	end
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(RoomSceneTaskController.instance, RoomEvent.TaskUpdate, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(RoomSceneTaskController.instance, RoomEvent.TaskCanFinish, arg_6_0.playCanGetRewardVfx, arg_6_0)
	arg_6_0:addEventCb(RoomMapController.instance, RoomEvent.ClientPlaceBlock, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(RoomMapController.instance, RoomEvent.ClientCancelBlock, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(RoomMapController.instance, RoomEvent.ClientTryBackBlock, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(RoomMapController.instance, RoomEvent.ClientCancelBackBlock, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(RoomMapController.instance, RoomEvent.TransportPathViewShowChanged, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(RoomMapController.instance, RoomEvent.GuideShowSceneTask, arg_6_0._guideShowSceneTask, arg_6_0)
	arg_6_0:addEventCb(RoomMapController.instance, RoomEvent.BackBlockShowChanged, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_6_0.handleOpenView, arg_6_0)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_6_0.handleCloseView, arg_6_0)
	arg_6_0:addEventCb(RoomSceneTaskController.instance, RoomEvent.TaskShowHideAnim, arg_6_0.handleTaskHideAnim, arg_6_0)

	arg_6_0._taskAnimIds = {}
	arg_6_0._taskAnimIdMap = {}

	RoomSceneTaskController.instance:init()
	RoomSceneTaskController.instance:setTaskCheckFinishFlag(true)

	arg_6_0._isExpand = true

	arg_6_0:refreshUI()
end

function var_0_0.onClose(arg_7_0)
	arg_7_0:disposeAllAnim()

	if arg_7_0:isAnimPlaying() then
		UIBlockMgrExtend.setNeedCircleMv(true)
		UIBlockMgr.instance:endBlock(UIBlockKey.RoomTaskFinish)
	end

	RoomSceneTaskController.instance:release()
	TaskDispatcher.cancelTask(arg_7_0.onDelayObAutoHide, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.startPlayTaskFinish, arg_7_0)
end

function var_0_0.enterObAutoHide(arg_8_0)
	arg_8_0:_stopAutoHideTask()

	if RoomController.instance:isObMode() then
		arg_8_0._isBreakAutoHide = false
		arg_8_0._isHasAutoHideTaskRun = true

		TaskDispatcher.runDelay(arg_8_0.onDelayObAutoHide, arg_8_0, var_0_0.AutoHideTime)
	end
end

function var_0_0._stopAutoHideTask(arg_9_0)
	if arg_9_0._isHasAutoHideTaskRun then
		TaskDispatcher.cancelTask(arg_9_0.onDelayObAutoHide, arg_9_0)

		arg_9_0._isHasAutoHideTaskRun = false
	end
end

function var_0_0.onDelayObAutoHide(arg_10_0)
	arg_10_0:_stopAutoHideTask()

	if not arg_10_0._isBreakAutoHide then
		arg_10_0:_showHidAnim(true)

		arg_10_0._isBreakAutoHide = false
	end
end

function var_0_0._showHidAnim(arg_11_0, arg_11_1)
	if arg_11_1 then
		arg_11_0._isBreakAutoHide = true

		arg_11_0:_stopAutoHideTask()
	end

	local var_11_0 = arg_11_1 == true

	if arg_11_0._lastAnimHide ~= var_11_0 then
		local var_11_1 = var_11_0 and "close" or UIAnimationName.Open

		arg_11_0._lastAnimHide = var_11_0

		arg_11_0._animatorpanel:Play(var_11_1)
	end

	arg_11_0._isExpand = not arg_11_1

	arg_11_0:refreshExpand()
end

function var_0_0._guideShowSceneTask(arg_12_0)
	arg_12_0._isExpand = true

	arg_12_0:refreshExpand()
end

function var_0_0.onClickExpand(arg_13_0)
	arg_13_0:_showHidAnim(arg_13_0._isExpand)
	arg_13_0:enterObAutoHide()
end

function var_0_0.onClickNormalOpen(arg_14_0)
	local var_14_0 = arg_14_0.self
	local var_14_1 = arg_14_0.index

	if var_14_0:isAnimPlaying() then
		return
	end

	if not var_14_0._isExpand then
		var_14_0:onClickExpand()

		return
	end

	if not RoomSceneTaskController.instance:checkTaskFinished() then
		ViewMgr.instance:openView(ViewName.RoomSceneTaskDetailView)
	end
end

function var_0_0.refreshUI(arg_15_0)
	if arg_15_0:isAnimPlaying() then
		return
	end

	local var_15_0 = RoomTaskModel.instance:getShowList()
	local var_15_1 = #var_15_0 > 0

	if #var_15_0 > 0 then
		if arg_15_0._firstEnterRefresh then
			arg_15_0._firstEnterRefresh = false

			arg_15_0:enterObAutoHide()
		end

		arg_15_0:refreshExpand()
		arg_15_0:refreshItems()
	end

	local var_15_2 = RoomWaterReformModel.instance:isWaterReform()
	local var_15_3 = RoomMapBlockModel.instance:isBackMore()

	if RoomController.instance:isEditMode() and (var_15_3 or var_15_2 or ViewMgr.instance:isOpen(ViewName.RoomTransportPathView)) then
		var_15_1 = false
	end

	gohelper.setActive(arg_15_0._gopanel, var_15_1)
end

function var_0_0.refreshExpand(arg_16_0)
	if arg_16_0._isForceHideArrow then
		gohelper.setActive(arg_16_0._btnexpand, false)
	else
		gohelper.setActive(arg_16_0._btnexpand, not arg_16_0._isExpand)
	end
end

function var_0_0.refreshItems(arg_17_0)
	local var_17_0 = RoomTaskModel.instance:getShowList()
	local var_17_1 = 1
	local var_17_2 = arg_17_0:getOrCreateItem(var_17_1)
	local var_17_3 = RoomTaskModel.instance:tryGetTaskMO(var_17_0[1].id)

	arg_17_0:refreshItemWithTask(var_17_2, var_17_3, var_17_0[1])
end

function var_0_0.refreshItemWithTask(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_0._needPlayAnimShow then
		arg_18_1.animator:Play(RoomSceneTaskEnum.AnimName.Show, 0, 0)

		arg_18_0._needPlayAnimShow = false
	end

	gohelper.setActive(arg_18_1.go, true)
	gohelper.setActive(arg_18_1.gotask, true)

	if arg_18_2 then
		local var_18_0, var_18_1 = RoomSceneTaskController.getProgressStatus(arg_18_2)

		if var_18_0 then
			arg_18_1.txtdesc.text = string.format("%s(%s/%s)", arg_18_3.desc, var_18_1, arg_18_3.maxProgress)
		else
			arg_18_1.txtdesc.text = string.format("%s(<color=#ba6662>%s</color>/%s)", arg_18_3.desc, var_18_1, arg_18_3.maxProgress)
		end

		gohelper.setActive(arg_18_1.gohasreward, var_18_0)
	else
		logNormal("No taskMO with taskID : " .. tostring(arg_18_3.id))

		arg_18_1.txtdesc.text = arg_18_3.desc

		gohelper.setActive(arg_18_1.gohasreward, false)
	end

	if not string.nilorempty(arg_18_3.bonus) then
		local var_18_2 = string.split(arg_18_3.bonus, "|")

		if #var_18_2 > 0 then
			local var_18_3 = string.splitToNumber(var_18_2[1], "#")

			arg_18_1.iconComp:setMOValue(var_18_3[1], var_18_3[2], var_18_3[3])
			arg_18_1.iconComp:isShowEquipAndItemCount(false)
			gohelper.setActive(arg_18_1.countbg, true)
			gohelper.setAsLastSibling(arg_18_1.countbg)

			arg_18_1.count.text = tostring(GameUtil.numberDisplay(var_18_3[3]))
		end
	end
end

function var_0_0.playCanGetRewardVfx(arg_19_0, arg_19_1)
	arg_19_0._isBreakAutoHide = true

	if RoomMapModel.instance:isRoomLeveling() or ViewMgr.instance:isOpen(ViewName.RoomLevelUpTipsView) then
		return
	end

	logNormal("notify playCanGetRewardVfx")
	arg_19_0:appendToAnimPipeline(arg_19_1)
end

function var_0_0.appendToAnimPipeline(arg_20_0, arg_20_1)
	local var_20_0 = #arg_20_0._taskAnimIds
	local var_20_1 = var_20_0
	local var_20_2 = {}

	for iter_20_0, iter_20_1 in pairs(arg_20_1) do
		var_20_2[iter_20_1] = true

		if not arg_20_0._taskAnimIdMap[iter_20_1] then
			local var_20_3 = RoomTaskModel.instance:tryGetTaskMO(iter_20_1)

			if var_20_3 then
				local var_20_4 = var_20_1 == 0
				local var_20_5 = {
					self = arg_20_0,
					taskCo = var_20_3.config,
					taskMo = var_20_3,
					isFirst = var_20_4
				}

				table.insert(arg_20_0._taskAnimIds, var_20_5)

				arg_20_0._taskAnimIdMap[iter_20_1] = var_20_5
				var_20_1 = var_20_1 + 1
			end
		end
	end

	for iter_20_2, iter_20_3 in pairs(arg_20_0._taskAnimIdMap) do
		if not var_20_2[iter_20_2] and #arg_20_0._taskAnimIds > 0 and arg_20_0._taskAnimIds[1].taskCo.id ~= iter_20_2 then
			arg_20_0:removeAnimParam(iter_20_2, true)
		end
	end

	if var_20_0 == 0 and var_20_1 ~= 0 then
		arg_20_0._isAnimPlaying = true

		UIBlockMgr.instance:endAll()
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock(UIBlockKey.RoomTaskFinish)
		arg_20_0:_stopAutoHideTask()
		arg_20_0:checkIfNodeHidePlay()
	end
end

function var_0_0.removeAnimParam(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0._taskAnimIdMap[arg_21_1] then
		if arg_21_2 then
			arg_21_0._taskAnimIdMap[arg_21_1] = nil
		end

		for iter_21_0, iter_21_1 in ipairs(arg_21_0._taskAnimIds) do
			if iter_21_1.taskCo.id == arg_21_1 then
				logNormal("delete taskId in array = " .. tostring(arg_21_1))
				table.remove(arg_21_0._taskAnimIds, iter_21_0)

				break
			end
		end
	end
end

function var_0_0.checkIfNodeHidePlay(arg_22_0)
	if arg_22_0._lastAnimHide then
		arg_22_0._isBreakAutoHide = true

		arg_22_0:_showHidAnim(false)
		TaskDispatcher.runDelay(arg_22_0.startPlayTaskFinish, arg_22_0, var_0_0.DelayHideToShowTime)
	else
		arg_22_0:startPlayTaskFinish()
	end
end

function var_0_0.startPlayTaskFinish(arg_23_0)
	local var_23_0 = arg_23_0._taskAnimIds[1]
	local var_23_1 = arg_23_0:getOrCreateItem(1)
	local var_23_2 = var_23_0.isFirst

	arg_23_0:disposeAllAnim()
	arg_23_0:refreshItemWithTask(var_23_1, var_23_0.taskMo, var_23_0.taskCo)

	if not var_23_2 then
		var_23_1.animator:Play(RoomSceneTaskEnum.AnimName.Show, 0, 0)
		var_23_1.animatorEvent:AddEventListener(RoomSceneTaskEnum.AnimEventName.ShowFinish, var_0_0.onAnimShowFinished, var_23_0)
	else
		var_23_1.animator:Play(RoomSceneTaskEnum.AnimName.Play, 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mission_complete)
		var_23_1.animatorEvent:AddEventListener(RoomSceneTaskEnum.AnimEventName.PlayFinish, var_0_0.onAnimPlayFinished, var_23_0)
	end
end

function var_0_0.onAnimShowFinished(arg_24_0)
	local var_24_0 = arg_24_0.self:getOrCreateItem(1)

	var_24_0.animatorEvent:AddEventListener(RoomSceneTaskEnum.AnimEventName.PlayFinish, var_0_0.onAnimPlayFinished, arg_24_0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mission_complete)
	var_24_0.animator:Play(RoomSceneTaskEnum.AnimName.Play, 0, 0)
end

function var_0_0.onAnimPlayFinished(arg_25_0)
	local var_25_0 = arg_25_0.self
	local var_25_1 = arg_25_0.taskCo.id

	var_25_0:removeAnimParam(var_25_1)
	var_25_0:disposeAllAnim()

	if #var_25_0._taskAnimIds > 0 then
		var_25_0:startPlayTaskFinish()
	else
		for iter_25_0, iter_25_1 in pairs(var_25_0._taskAnimIdMap) do
			var_25_0._taskAnimIdMap[iter_25_0] = nil
		end

		var_25_0._needPlayAnimShow = true

		local var_25_2, var_25_3 = RoomSceneTaskController.instance:isFirstTaskFinished()

		if var_25_2 then
			RoomSceneTaskController.instance:setTaskCheckFinishFlag(false)
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Room, nil, var_25_3, var_25_0.onSendAllTaskCompleted, var_25_0)
		end

		UIBlockMgrExtend.setNeedCircleMv(true)
		UIBlockMgr.instance:endBlock(UIBlockKey.RoomTaskFinish)

		var_25_0._isAnimPlaying = false

		var_25_0:enterObAutoHide()
		var_25_0:refreshUI()
	end
end

function var_0_0.disposeAllAnim(arg_26_0)
	local var_26_0 = arg_26_0:getOrCreateItem(1)

	if not gohelper.isNil(var_26_0.animatorEvent) then
		for iter_26_0, iter_26_1 in pairs(RoomSceneTaskEnum.AnimEventName) do
			var_26_0.animatorEvent:RemoveEventListener(iter_26_1)
		end
	end
end

function var_0_0.isAnimPlaying(arg_27_0)
	return arg_27_0._isAnimPlaying == true
end

function var_0_0.onSendAllTaskCompleted(arg_28_0, arg_28_1, arg_28_2)
	RoomSceneTaskController.instance:setTaskCheckFinishFlag(true)
end

function var_0_0.handleOpenView(arg_29_0, arg_29_1)
	if arg_29_1 == ViewName.CommonPropView or arg_29_1 == ViewName.RoomLevelUpTipsView then
		RoomSceneTaskController.instance:setTaskCheckFinishFlag(false)
	elseif arg_29_1 == ViewName.RoomCharacterPlaceView then
		arg_29_0:_showHidAnim(true)
	end
end

function var_0_0.handleCloseView(arg_30_0, arg_30_1)
	if arg_30_1 == ViewName.CommonPropView or arg_30_1 == ViewName.RoomLevelUpTipsView then
		RoomSceneTaskController.instance:setTaskCheckFinishFlag(true)
		RoomSceneTaskController.instance:checkTaskFinished()
	end
end

function var_0_0.getOrCreateItem(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0._taskItems[arg_31_1]

	if not var_31_0 then
		var_31_0 = arg_31_0:getUserDataTb_()

		local var_31_1 = arg_31_0.viewContainer:getSetting().otherRes[4]
		local var_31_2 = arg_31_0:getResInst(var_31_1, arg_31_0._gocontainer, "task_item")

		var_31_2.name = "task_item" .. arg_31_1
		var_31_0.go = var_31_2
		var_31_0.txtdesc = gohelper.findChildText(var_31_2, "go_task/txt_taskitemdesc")
		var_31_0.gotask = gohelper.findChild(var_31_2, "go_task")
		var_31_0.goicon = gohelper.findChild(var_31_2, "go_task/go_icon")
		var_31_0.gohasreward = gohelper.findChild(var_31_2, "go_task/go_hasreward")
		var_31_0.countbg = gohelper.findChild(var_31_2, "go_task/go_icon/countbg")
		var_31_0.count = gohelper.findChildText(var_31_2, "go_task/go_icon/countbg/count")
		var_31_0.btnnormal = gohelper.findChildButtonWithAudio(var_31_2, "btn_normalclick")

		var_31_0.btnnormal:AddClickListener(arg_31_0.onClickNormalOpen, {
			self = arg_31_0,
			index = arg_31_1
		})

		var_31_0.iconComp = IconMgr.instance:getCommonPropItemIcon(var_31_0.goicon)
		var_31_0.animator = var_31_2:GetComponent(typeof(UnityEngine.Animator))
		var_31_0.animatorEvent = var_31_2:GetComponent(typeof(ZProj.AnimationEventWrap))
		arg_31_0._taskItems[arg_31_1] = var_31_0
	end

	return var_31_0
end

function var_0_0.handleTaskHideAnim(arg_32_0, arg_32_1)
	arg_32_0._isForceHideArrow = arg_32_1

	arg_32_0:_showHidAnim(true)
end

return var_0_0
