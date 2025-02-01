module("modules.logic.room.view.RoomViewUIPartItem", package.seeall)

slot0 = class("RoomViewUIPartItem", RoomViewUIBaseItem)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0._partId = slot1
end

function slot0._customOnInit(slot0)
	slot0._txtbuildingname = gohelper.findChildText(slot0._gocontainer, "bottom/txt_buildingName")
	slot0._goskinreddot = gohelper.findChild(slot0._gocontainer, "bottom/#go_reddot")
	slot0._gobubbleContent = gohelper.findChild(slot0._gocontainer, "#go_bubbleContent")
	slot0._goawarn = gohelper.findChild(slot0._gocontainer, "state/#go_warn")
	slot0._gostop = gohelper.findChild(slot0._gocontainer, "state/#go_stop")
	slot0._goadd = gohelper.findChild(slot0._gocontainer, "state/#go_add")
	slot0._txtcount = gohelper.findChildText(slot0._gocontainer, "count/txt_count")
	slot0._gotxtcount = gohelper.findChild(slot0._gocontainer, "count")
	slot0._txtper = gohelper.findChildText(slot0._gocontainer, "count/txt_count/txt")
	slot0._simagegathericon = gohelper.findChildSingleImage(slot0._gocontainer, "simage_gathericon")
	slot0._simagebuildingicon = gohelper.findChildSingleImage(slot0._gocontainer, "simage_buildingicon")
	slot0._goroomgifticon = gohelper.findChild(slot0._gocontainer, "simage_actroomicon")
	slot0._goreddot = gohelper.findChild(slot0._gocontainer, "count/txt_count/go_reddot")
	slot0._goupgrade = gohelper.findChild(slot0._gocontainer, "#go_upgrade")
	slot0._gobg = gohelper.findChild(slot0._gocontainer, "count/bg")
	slot0._gobg1 = gohelper.findChild(slot0._gocontainer, "count/bg1")
	slot0._gobubbleitem = gohelper.findChild(slot0._gocontainer, "bubbleContent/#go_bubbleitem")

	gohelper.setActive(slot0._gobubbleitem, false)

	slot0._bubbleGOList = slot0:getUserDataTb_()
	slot0._isPlayAnimation = false
	slot0._animator = slot0._gocontainer:GetComponent(typeof(UnityEngine.Animator))

	if RoomInitBuildingEnum.InitBuildingSkinReddot[slot0._partId] then
		RedDotController.instance:addRedDot(slot0._goskinreddot, slot1)
	end
end

function slot0._customAddEventListeners(slot0)
	RoomMapController.instance:registerCallback(RoomEvent.UpdateRoomLevel, slot0.refreshUI, slot0)
	RoomController.instance:registerCallback(RoomEvent.ProduceLineLevelUp, slot0._refreshUpgradeUI, slot0)
	RoomController.instance:registerCallback(RoomEvent.UpdateProduceLineData, slot0._updateProduceLineData, slot0)
	RoomController.instance:registerCallback(RoomEvent.GainProductionLineReply, slot0._gainProductionLineCallback, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.GuideTouchUIPart, slot0._onGuideTouchUIPart, slot0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, slot0.refreshRelateDot, slot0)
	slot0:refreshUI(true)
end

function slot0._customRemoveEventListeners(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.UpdateRoomLevel, slot0.refreshUI, slot0)
	RoomController.instance:unregisterCallback(RoomEvent.ProduceLineLevelUp, slot0._refreshUpgradeUI, slot0)
	RoomController.instance:unregisterCallback(RoomEvent.UpdateProduceLineData, slot0._updateProduceLineData, slot0)
	RoomController.instance:unregisterCallback(RoomEvent.GainProductionLineReply, slot0._gainProductionLineCallback, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.GuideTouchUIPart, slot0._onGuideTouchUIPart, slot0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, slot0.refreshRelateDot, slot0)
end

function slot0.refreshRelateDot(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if slot5 == RedDotEnum.DotNode.RoomProductionFull or slot5 == RedDotEnum.DotNode.RoomProductionLevel then
			slot0:_refreshReddot()

			break
		end
	end

	for slot5, slot6 in pairs(slot1) do
		if slot5 == RedDotEnum.DotNode.RoomProductionLevel then
			slot0:_refreshUpgradeUI()

			break
		end
	end
end

function slot0.refreshUI(slot0, slot1)
	slot0:_refreshBubble()
	slot0:_refreshShow(slot1)
	slot0:_refreshPosition()
	slot0:_refreshUpgradeUI()
end

function slot0._refreshUpgradeUI(slot0)
	gohelper.setActive(slot0._goupgrade, slot0:_canLeveUP())
end

function slot0._canLeveUP(slot0)
	if RoomConfig.instance:getProductionPartConfig(slot0._partId) then
		for slot5, slot6 in ipairs(slot1.productionLines) do
			if slot0:_checkProductionLineLeveUP(slot6) then
				return true
			end
		end
	end

	return false
end

function slot0._checkProductionLineLeveUP(slot0, slot1)
	if not RoomProductionModel.instance:getLineMO(slot1) or slot2:isLock() or slot2.maxLevel <= slot2.level or slot2.maxConfigLevel <= slot2.level then
		return false
	end

	if RoomConfig.instance:getProductionLineLevelConfig(slot2.config.levelGroup, slot2.level + 1) == nil then
		return false
	end

	if not string.nilorempty(slot3.cost) then
		for slot8, slot9 in ipairs(GameUtil.splitString2(slot3.cost, true)) do
			if ItemModel.instance:getItemQuantity(slot9[1], slot9[2]) < slot9[3] then
				return false
			end
		end
	end

	return true
end

function slot0._updateProduceLineData(slot0)
	if slot0._isPlayAnimation then
		return
	end

	slot0:_refreshBubble()
end

function slot0._refreshPartInfo(slot0)
	slot0._lineMOList = {}

	for slot5, slot6 in ipairs(RoomConfig.instance:getProductionPartConfig(slot0._partId).productionLines) do
		if RoomProductionModel.instance:getLineMO(slot6):isLock() == false then
			table.insert(slot0._lineMOList, slot7)
		end
	end

	slot0._txtbuildingname.text = slot1.name
end

function slot0._refreshBubble(slot0, slot1)
	gohelper.setActive(slot0._goroomgifticon, false)
	slot0:_refreshPartInfo()

	if not slot0._isPlayAnimation then
		TaskDispatcher.cancelTask(slot0._newBubble, slot0)
		TaskDispatcher.cancelTask(slot0._refreshNewData, slot0)
		TaskDispatcher.cancelTask(slot0._animationDone, slot0)
		slot0._animator:Play("idel", 0, 0)
	end

	table.sort(slot0._lineMOList, function (slot0, slot1)
		if slot0:getReservePer() ~= slot1:getReservePer() then
			return slot2 < slot3
		end

		return slot1.id < slot0.id
	end)

	if slot0._lineMOList[#slot0._lineMOList] then
		slot3, slot0._txtcount.text = slot2:getReservePer()
		slot5 = slot2:isFull()
		slot7 = slot2.config.logic == RoomProductLineEnum.ProductType.Change

		gohelper.setActive(slot0._goawarn, false)
		gohelper.setActive(slot0._gostop, false)
		gohelper.setActive(slot0._simagebuildingicon.gameObject, slot7)
		gohelper.setActive(slot0._simagegathericon.gameObject, slot2.config.logic == RoomProductLineEnum.ProductType.Product)

		if slot7 then
			gohelper.setActive(slot0._gobg, false)
			gohelper.setActive(slot0._gobg1, false)

			slot0._txtcount.text = ""
			slot0._txtper.text = ""

			slot0._simagebuildingicon:LoadImage(ResUrl.getRoomImage("productline/icon_2"))
		else
			slot0._txtper.text = "%"
			slot10 = RoomConfig.instance:getFormulaConfig(slot2.formulaId) and RoomProductionHelper.getFormulaItemParamList(slot9.produce)
			slot12 = nil

			if slot10 and slot10[1] then
				slot13 = nil
				slot13, slot12 = ItemModel.instance:getItemConfigAndIcon(slot11.type, slot11.id)
			end

			if slot12 then
				slot0._simagegathericon:LoadImage(slot12)
			end
		end
	end

	slot0:_refreshReddot()

	if not slot0._isPlayAnimation then
		for slot6 = 1, #slot0._lineMOList - 1 do
			if not slot0._bubbleGOList[slot6] then
				table.insert(slot0._bubbleGOList, gohelper.cloneInPlace(slot0._gobubbleitem, "item" .. slot6))
			end

			gohelper.setActive(slot7, true)
			slot7:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Idle, 0, 0)
		end

		for slot6 = #slot0._lineMOList, #slot0._bubbleGOList do
			if slot0._bubbleGOList[slot6] then
				gohelper.setActive(slot7, false)
			end
		end
	end
end

function slot0._refreshReddot(slot0)
	slot3 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.RoomProductionFull)
	slot4 = false

	for slot8, slot9 in ipairs(RoomConfig.instance:getProductionPartConfig(slot0._partId).productionLines) do
		if slot3 and slot3.infos and slot3.infos[slot9] and slot3.infos[slot9].value > 0 then
			slot4 = true

			break
		end
	end

	gohelper.setActive(slot0._goreddot, slot4)
end

function slot0._refreshShow(slot0, slot1)
	if not RoomProductionHelper.hasUnlockLine(slot0._partId) then
		slot0:_setShow(false, true)

		return
	end

	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		slot0:_setShow(false, slot1)

		return
	end

	if slot0._scene.camera:getCameraState() ~= RoomEnum.CameraState.Overlook and slot2 ~= RoomEnum.CameraState.OverlookAll then
		slot0:_setShow(false, slot1)

		return
	end

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		slot0:_setShow(false, slot1)

		return
	end

	slot0:_setShow(true, slot1)
end

function slot0.getUI3DPos(slot0)
	slot2 = RoomBuildingHelper.getCenterPosition(slot0._scene.buildingmgr:getPartContainerGO(slot0._partId))

	return RoomBendingHelper.worldToBendingSimple(Vector3(slot2.x, 0.5, slot2.z))
end

function slot0._onGuideTouchUIPart(slot0, slot1)
	if tonumber(slot1) == slot0._partId then
		slot0:_onClick()
	end
end

function slot0._onClick(slot0, slot1, slot2)
	if slot0._isPlayAnimation then
		return
	end

	if slot0:_getReward() then
		RoomSceneTaskController.instance:showHideRoomTopTaskUI(true)

		return
	end

	RoomMapController.instance:openRoomInitBuildingView(0.2, {
		partId = slot0._partId
	})
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_admission_open)
end

function slot0._getReward(slot0)
	if slot0._iscustomDestory then
		return false
	end

	slot1, slot2 = nil

	for slot6 = #slot0._lineMOList, 1, -1 do
		if slot0._lineMOList[slot6]:isCanGain() then
			table.insert(slot1 or {}, slot7.id)

			slot2 = slot7.formulaId
			slot0._isPlayAnimation = true
			slot0._curGainLineMOId = slot7.id
		end
	end

	if slot1 then
		slot0._flyEffectRewardInfo = RoomProductionHelper.getFormulaRewardInfo(slot2)

		RoomRpc.instance:sendGainProductionLineRequest(slot1, true)

		return true
	end

	return false
end

function slot0._gainProductionLineCallback(slot0, slot1, slot2)
	if slot0._iscustomDestory or not slot0._flyEffectRewardInfo or not slot0._curGainLineMOId then
		return
	end

	if not slot2 or not tabletool.indexOf(slot2, slot0._curGainLineMOId) then
		return
	end

	slot0._curGainLineMOId = nil

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_collect_bubble)
	TaskDispatcher.cancelTask(slot0._newBubble, slot0)
	TaskDispatcher.cancelTask(slot0._refreshNewData, slot0)
	TaskDispatcher.cancelTask(slot0._animationDone, slot0)
	TaskDispatcher.cancelTask(RoomSceneTaskController.instance.showHideRoomTopTaskUI, RoomSceneTaskController.instance)
	TaskDispatcher.runDelay(RoomSceneTaskController.instance.showHideRoomTopTaskUI, RoomSceneTaskController.instance, 3.5)

	if slot1 ~= 0 then
		slot0:_animationDone(true)

		return
	end

	slot0._animator:Play(UIAnimationName.Switch, 0, 0)

	if slot0._bubbleGOList[1] and slot3.activeSelf then
		slot3:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Switch, 0, 0)
		TaskDispatcher.runDelay(slot0._newBubble, slot0, 1.2)
	end

	slot0:_flyEffect()
	RoomSceneTaskController.instance:showHideRoomTopTaskUI(true)
	TaskDispatcher.runDelay(slot0._refreshNewData, slot0, 0.95)
	TaskDispatcher.runDelay(slot0._animationDone, slot0, 1.5)
end

function slot0._flyEffect(slot0)
	if not slot0._flyEffectRewardInfo then
		return
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.UIFlyEffect, {
		startPos = slot0._simagegathericon.gameObject.transform.position,
		itemType = slot0._flyEffectRewardInfo.type,
		itemId = slot0._flyEffectRewardInfo.id,
		startQuantity = slot0._flyEffectRewardInfo.quantity
	})

	slot0._flyEffectRewardInfo = nil
end

function slot0._newBubble(slot0)
	if not slot0._bubbleGOList[#slot0._lineMOList - 1 + 1] then
		table.insert(slot0._bubbleGOList, gohelper.cloneInPlace(slot0._gobubbleitem, "item" .. slot1 + 1))
	end

	gohelper.setActive(slot2, true)
	slot2:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Open, 0, 0)
end

function slot0._refreshNewData(slot0)
	slot0:_refreshBubble()
end

function slot0._animationDone(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._newBubble, slot0)
	TaskDispatcher.cancelTask(slot0._refreshNewData, slot0)
	TaskDispatcher.cancelTask(slot0._animationDone, slot0)

	slot0._isPlayAnimation = false

	slot0:_refreshBubble()

	if not slot1 then
		slot0:_getReward()
	end
end

function slot0._showTopTaskUI(slot0)
	RoomSceneTaskController.instance:showHideRoomTopTaskUI(false)
end

function slot0._customOnDestory(slot0)
	slot0._iscustomDestory = true

	TaskDispatcher.cancelTask(slot0._newBubble, slot0)
	TaskDispatcher.cancelTask(slot0._refreshNewData, slot0)
	TaskDispatcher.cancelTask(slot0._animationDone, slot0)

	if slot0._simagegathericon then
		slot0._simagegathericon:UnLoadImage()

		slot0._simagegathericon = nil
	end

	if slot0._simagebuildingicon then
		slot0._simagebuildingicon:UnLoadImage()

		slot0._simagebuildingicon = nil
	end

	if slot0._bubbleGOList then
		for slot4, slot5 in ipairs(slot0._bubbleGOList) do
			gohelper.destroy(slot5)
		end

		slot0._bubbleGOList = nil
	end
end

return slot0
