module("modules.logic.room.view.RoomViewUIPartItem", package.seeall)

local var_0_0 = class("RoomViewUIPartItem", RoomViewUIBaseItem)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._partId = arg_1_1
end

function var_0_0._customOnInit(arg_2_0)
	arg_2_0._txtbuildingname = gohelper.findChildText(arg_2_0._gocontainer, "bottom/txt_buildingName")
	arg_2_0._goskinreddot = gohelper.findChild(arg_2_0._gocontainer, "bottom/#go_reddot")
	arg_2_0._gobubbleContent = gohelper.findChild(arg_2_0._gocontainer, "#go_bubbleContent")
	arg_2_0._goawarn = gohelper.findChild(arg_2_0._gocontainer, "state/#go_warn")
	arg_2_0._gostop = gohelper.findChild(arg_2_0._gocontainer, "state/#go_stop")
	arg_2_0._goadd = gohelper.findChild(arg_2_0._gocontainer, "state/#go_add")
	arg_2_0._txtcount = gohelper.findChildText(arg_2_0._gocontainer, "count/txt_count")
	arg_2_0._gotxtcount = gohelper.findChild(arg_2_0._gocontainer, "count")
	arg_2_0._txtper = gohelper.findChildText(arg_2_0._gocontainer, "count/txt_count/txt")
	arg_2_0._simagegathericon = gohelper.findChildSingleImage(arg_2_0._gocontainer, "simage_gathericon")
	arg_2_0._simagebuildingicon = gohelper.findChildSingleImage(arg_2_0._gocontainer, "simage_buildingicon")
	arg_2_0._goroomgifticon = gohelper.findChild(arg_2_0._gocontainer, "simage_actroomicon")
	arg_2_0._goreddot = gohelper.findChild(arg_2_0._gocontainer, "count/txt_count/go_reddot")
	arg_2_0._goupgrade = gohelper.findChild(arg_2_0._gocontainer, "#go_upgrade")
	arg_2_0._gobg = gohelper.findChild(arg_2_0._gocontainer, "count/bg")
	arg_2_0._gobg1 = gohelper.findChild(arg_2_0._gocontainer, "count/bg1")
	arg_2_0._gobubbleitem = gohelper.findChild(arg_2_0._gocontainer, "bubbleContent/#go_bubbleitem")

	gohelper.setActive(arg_2_0._gobubbleitem, false)

	arg_2_0._bubbleGOList = arg_2_0:getUserDataTb_()
	arg_2_0._isPlayAnimation = false
	arg_2_0._animator = arg_2_0._gocontainer:GetComponent(typeof(UnityEngine.Animator))

	local var_2_0 = RoomInitBuildingEnum.InitBuildingSkinReddot[arg_2_0._partId]

	if var_2_0 then
		RedDotController.instance:addRedDot(arg_2_0._goskinreddot, var_2_0)
	end
end

function var_0_0._customAddEventListeners(arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.UpdateRoomLevel, arg_3_0.refreshUI, arg_3_0)
	RoomController.instance:registerCallback(RoomEvent.ProduceLineLevelUp, arg_3_0._refreshUpgradeUI, arg_3_0)
	RoomController.instance:registerCallback(RoomEvent.UpdateProduceLineData, arg_3_0._updateProduceLineData, arg_3_0)
	RoomController.instance:registerCallback(RoomEvent.GainProductionLineReply, arg_3_0._gainProductionLineCallback, arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.GuideTouchUIPart, arg_3_0._onGuideTouchUIPart, arg_3_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, arg_3_0.refreshRelateDot, arg_3_0)
	arg_3_0:refreshUI(true)
end

function var_0_0._customRemoveEventListeners(arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.UpdateRoomLevel, arg_4_0.refreshUI, arg_4_0)
	RoomController.instance:unregisterCallback(RoomEvent.ProduceLineLevelUp, arg_4_0._refreshUpgradeUI, arg_4_0)
	RoomController.instance:unregisterCallback(RoomEvent.UpdateProduceLineData, arg_4_0._updateProduceLineData, arg_4_0)
	RoomController.instance:unregisterCallback(RoomEvent.GainProductionLineReply, arg_4_0._gainProductionLineCallback, arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.GuideTouchUIPart, arg_4_0._onGuideTouchUIPart, arg_4_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, arg_4_0.refreshRelateDot, arg_4_0)
end

function var_0_0.refreshRelateDot(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		if iter_5_0 == RedDotEnum.DotNode.RoomProductionFull or iter_5_0 == RedDotEnum.DotNode.RoomProductionLevel then
			arg_5_0:_refreshReddot()

			break
		end
	end

	for iter_5_2, iter_5_3 in pairs(arg_5_1) do
		if iter_5_2 == RedDotEnum.DotNode.RoomProductionLevel then
			arg_5_0:_refreshUpgradeUI()

			break
		end
	end
end

function var_0_0.refreshUI(arg_6_0, arg_6_1)
	arg_6_0:_refreshBubble()
	arg_6_0:_refreshShow(arg_6_1)
	arg_6_0:_refreshPosition()
	arg_6_0:_refreshUpgradeUI()
end

function var_0_0._refreshUpgradeUI(arg_7_0)
	local var_7_0 = arg_7_0:_canLeveUP()

	gohelper.setActive(arg_7_0._goupgrade, var_7_0)
end

function var_0_0._canLeveUP(arg_8_0)
	local var_8_0 = RoomConfig.instance:getProductionPartConfig(arg_8_0._partId)

	if var_8_0 then
		for iter_8_0, iter_8_1 in ipairs(var_8_0.productionLines) do
			if arg_8_0:_checkProductionLineLeveUP(iter_8_1) then
				return true
			end
		end
	end

	return false
end

function var_0_0._checkProductionLineLeveUP(arg_9_0, arg_9_1)
	local var_9_0 = RoomProductionModel.instance:getLineMO(arg_9_1)

	if not var_9_0 or var_9_0:isLock() or var_9_0.level >= var_9_0.maxLevel or var_9_0.level >= var_9_0.maxConfigLevel then
		return false
	end

	local var_9_1 = RoomConfig.instance:getProductionLineLevelConfig(var_9_0.config.levelGroup, var_9_0.level + 1)

	if var_9_1 == nil then
		return false
	end

	if not string.nilorempty(var_9_1.cost) then
		local var_9_2 = GameUtil.splitString2(var_9_1.cost, true)

		for iter_9_0, iter_9_1 in ipairs(var_9_2) do
			local var_9_3 = iter_9_1[1]
			local var_9_4 = iter_9_1[2]

			if iter_9_1[3] > ItemModel.instance:getItemQuantity(var_9_3, var_9_4) then
				return false
			end
		end
	end

	return true
end

function var_0_0._updateProduceLineData(arg_10_0)
	if arg_10_0._isPlayAnimation then
		return
	end

	arg_10_0:_refreshBubble()
end

function var_0_0._refreshPartInfo(arg_11_0)
	local var_11_0 = RoomConfig.instance:getProductionPartConfig(arg_11_0._partId)

	arg_11_0._lineMOList = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_0.productionLines) do
		local var_11_1 = RoomProductionModel.instance:getLineMO(iter_11_1)

		if var_11_1:isLock() == false then
			table.insert(arg_11_0._lineMOList, var_11_1)
		end
	end

	arg_11_0._txtbuildingname.text = var_11_0.name
end

function var_0_0._refreshBubble(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._goroomgifticon, false)
	arg_12_0:_refreshPartInfo()

	if not arg_12_0._isPlayAnimation then
		TaskDispatcher.cancelTask(arg_12_0._newBubble, arg_12_0)
		TaskDispatcher.cancelTask(arg_12_0._refreshNewData, arg_12_0)
		TaskDispatcher.cancelTask(arg_12_0._animationDone, arg_12_0)
		arg_12_0._animator:Play("idel", 0, 0)
	end

	table.sort(arg_12_0._lineMOList, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_0:getReservePer()
		local var_13_1 = arg_13_1:getReservePer()

		if var_13_0 ~= var_13_1 then
			return var_13_0 < var_13_1
		end

		return arg_13_0.id > arg_13_1.id
	end)

	local var_12_0 = arg_12_0._lineMOList[#arg_12_0._lineMOList]

	if var_12_0 then
		local var_12_1, var_12_2 = var_12_0:getReservePer()

		arg_12_0._txtcount.text = var_12_2

		local var_12_3 = var_12_0:isFull()
		local var_12_4 = var_12_0.config.logic == RoomProductLineEnum.ProductType.Product
		local var_12_5 = var_12_0.config.logic == RoomProductLineEnum.ProductType.Change

		gohelper.setActive(arg_12_0._goawarn, false)
		gohelper.setActive(arg_12_0._gostop, false)
		gohelper.setActive(arg_12_0._simagebuildingicon.gameObject, var_12_5)
		gohelper.setActive(arg_12_0._simagegathericon.gameObject, var_12_4)

		if var_12_5 then
			gohelper.setActive(arg_12_0._gobg, false)
			gohelper.setActive(arg_12_0._gobg1, false)

			arg_12_0._txtcount.text = ""
			arg_12_0._txtper.text = ""

			arg_12_0._simagebuildingicon:LoadImage(ResUrl.getRoomImage("productline/icon_2"))
		else
			arg_12_0._txtper.text = "%"

			local var_12_6 = var_12_0.formulaId
			local var_12_7 = RoomConfig.instance:getFormulaConfig(var_12_6)
			local var_12_8 = var_12_7 and RoomProductionHelper.getFormulaItemParamList(var_12_7.produce)
			local var_12_9 = var_12_8 and var_12_8[1]
			local var_12_10

			if var_12_9 then
				local var_12_11
				local var_12_12

				var_12_12, var_12_10 = ItemModel.instance:getItemConfigAndIcon(var_12_9.type, var_12_9.id)
			end

			if var_12_10 then
				arg_12_0._simagegathericon:LoadImage(var_12_10)
			end
		end
	end

	arg_12_0:_refreshReddot()

	if not arg_12_0._isPlayAnimation then
		for iter_12_0 = 1, #arg_12_0._lineMOList - 1 do
			local var_12_13 = arg_12_0._bubbleGOList[iter_12_0]

			if not var_12_13 then
				var_12_13 = gohelper.cloneInPlace(arg_12_0._gobubbleitem, "item" .. iter_12_0)

				table.insert(arg_12_0._bubbleGOList, var_12_13)
			end

			gohelper.setActive(var_12_13, true)
			var_12_13:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Idle, 0, 0)
		end

		for iter_12_1 = #arg_12_0._lineMOList, #arg_12_0._bubbleGOList do
			local var_12_14 = arg_12_0._bubbleGOList[iter_12_1]

			if var_12_14 then
				gohelper.setActive(var_12_14, false)
			end
		end
	end
end

function var_0_0._refreshReddot(arg_14_0)
	local var_14_0 = RoomConfig.instance:getProductionPartConfig(arg_14_0._partId).productionLines
	local var_14_1 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.RoomProductionFull)
	local var_14_2 = false

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if var_14_1 and var_14_1.infos and var_14_1.infos[iter_14_1] and var_14_1.infos[iter_14_1].value > 0 then
			var_14_2 = true

			break
		end
	end

	gohelper.setActive(arg_14_0._goreddot, var_14_2)
end

function var_0_0._refreshShow(arg_15_0, arg_15_1)
	if not RoomProductionHelper.hasUnlockLine(arg_15_0._partId) then
		arg_15_0:_setShow(false, true)

		return
	end

	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		arg_15_0:_setShow(false, arg_15_1)

		return
	end

	local var_15_0 = arg_15_0._scene.camera:getCameraState()

	if var_15_0 ~= RoomEnum.CameraState.Overlook and var_15_0 ~= RoomEnum.CameraState.OverlookAll then
		arg_15_0:_setShow(false, arg_15_1)

		return
	end

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		arg_15_0:_setShow(false, arg_15_1)

		return
	end

	arg_15_0:_setShow(true, arg_15_1)
end

function var_0_0.getUI3DPos(arg_16_0)
	local var_16_0 = arg_16_0._scene.buildingmgr:getPartContainerGO(arg_16_0._partId)
	local var_16_1 = RoomBuildingHelper.getCenterPosition(var_16_0)
	local var_16_2 = Vector3(var_16_1.x, 0.5, var_16_1.z)

	return (RoomBendingHelper.worldToBendingSimple(var_16_2))
end

function var_0_0._onGuideTouchUIPart(arg_17_0, arg_17_1)
	if tonumber(arg_17_1) == arg_17_0._partId then
		arg_17_0:_onClick()
	end
end

function var_0_0._onClick(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0._isPlayAnimation then
		return
	end

	if arg_18_0:_getReward() then
		RoomSceneTaskController.instance:showHideRoomTopTaskUI(true)

		return
	end

	RoomMapController.instance:openRoomInitBuildingView(0.2, {
		partId = arg_18_0._partId
	})
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_admission_open)
end

function var_0_0._getReward(arg_19_0)
	if arg_19_0._iscustomDestory then
		return false
	end

	local var_19_0
	local var_19_1

	for iter_19_0 = #arg_19_0._lineMOList, 1, -1 do
		local var_19_2 = arg_19_0._lineMOList[iter_19_0]

		if var_19_2:isCanGain() then
			var_19_0 = var_19_0 or {}

			table.insert(var_19_0, var_19_2.id)

			var_19_1 = var_19_2.formulaId
			arg_19_0._isPlayAnimation = true
			arg_19_0._curGainLineMOId = var_19_2.id
		end
	end

	if var_19_0 then
		arg_19_0._flyEffectRewardInfo = RoomProductionHelper.getFormulaRewardInfo(var_19_1)

		RoomRpc.instance:sendGainProductionLineRequest(var_19_0, true)

		return true
	end

	return false
end

function var_0_0._gainProductionLineCallback(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_0._iscustomDestory or not arg_20_0._flyEffectRewardInfo or not arg_20_0._curGainLineMOId then
		return
	end

	if not arg_20_2 or not tabletool.indexOf(arg_20_2, arg_20_0._curGainLineMOId) then
		return
	end

	arg_20_0._curGainLineMOId = nil

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_collect_bubble)
	TaskDispatcher.cancelTask(arg_20_0._newBubble, arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._refreshNewData, arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._animationDone, arg_20_0)
	TaskDispatcher.cancelTask(RoomSceneTaskController.instance.showHideRoomTopTaskUI, RoomSceneTaskController.instance)
	TaskDispatcher.runDelay(RoomSceneTaskController.instance.showHideRoomTopTaskUI, RoomSceneTaskController.instance, 3.5)

	if arg_20_1 ~= 0 then
		arg_20_0:_animationDone(true)

		return
	end

	arg_20_0._animator:Play(UIAnimationName.Switch, 0, 0)

	local var_20_0 = arg_20_0._bubbleGOList[1]

	if var_20_0 and var_20_0.activeSelf then
		var_20_0:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Switch, 0, 0)
		TaskDispatcher.runDelay(arg_20_0._newBubble, arg_20_0, 1.2)
	end

	arg_20_0:_flyEffect()
	RoomSceneTaskController.instance:showHideRoomTopTaskUI(true)
	TaskDispatcher.runDelay(arg_20_0._refreshNewData, arg_20_0, 0.95)
	TaskDispatcher.runDelay(arg_20_0._animationDone, arg_20_0, 1.5)
end

function var_0_0._flyEffect(arg_21_0)
	if not arg_21_0._flyEffectRewardInfo then
		return
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.UIFlyEffect, {
		startPos = arg_21_0._simagegathericon.gameObject.transform.position,
		itemType = arg_21_0._flyEffectRewardInfo.type,
		itemId = arg_21_0._flyEffectRewardInfo.id,
		startQuantity = arg_21_0._flyEffectRewardInfo.quantity
	})

	arg_21_0._flyEffectRewardInfo = nil
end

function var_0_0._newBubble(arg_22_0)
	local var_22_0 = #arg_22_0._lineMOList - 1
	local var_22_1 = arg_22_0._bubbleGOList[var_22_0 + 1]

	if not var_22_1 then
		var_22_1 = gohelper.cloneInPlace(arg_22_0._gobubbleitem, "item" .. var_22_0 + 1)

		table.insert(arg_22_0._bubbleGOList, var_22_1)
	end

	gohelper.setActive(var_22_1, true)
	var_22_1:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Open, 0, 0)
end

function var_0_0._refreshNewData(arg_23_0)
	arg_23_0:_refreshBubble()
end

function var_0_0._animationDone(arg_24_0, arg_24_1)
	TaskDispatcher.cancelTask(arg_24_0._newBubble, arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._refreshNewData, arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._animationDone, arg_24_0)

	arg_24_0._isPlayAnimation = false

	arg_24_0:_refreshBubble()

	if not arg_24_1 then
		arg_24_0:_getReward()
	end
end

function var_0_0._showTopTaskUI(arg_25_0)
	RoomSceneTaskController.instance:showHideRoomTopTaskUI(false)
end

function var_0_0._customOnDestory(arg_26_0)
	arg_26_0._iscustomDestory = true

	TaskDispatcher.cancelTask(arg_26_0._newBubble, arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0._refreshNewData, arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0._animationDone, arg_26_0)

	if arg_26_0._simagegathericon then
		arg_26_0._simagegathericon:UnLoadImage()

		arg_26_0._simagegathericon = nil
	end

	if arg_26_0._simagebuildingicon then
		arg_26_0._simagebuildingicon:UnLoadImage()

		arg_26_0._simagebuildingicon = nil
	end

	if arg_26_0._bubbleGOList then
		for iter_26_0, iter_26_1 in ipairs(arg_26_0._bubbleGOList) do
			gohelper.destroy(iter_26_1)
		end

		arg_26_0._bubbleGOList = nil
	end
end

return var_0_0
