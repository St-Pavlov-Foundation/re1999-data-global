module("modules.logic.room.controller.RoomNavigateBubbleController", package.seeall)

slot0 = class("RoomNavigateBubbleController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	slot0:release()
end

function slot0.init(slot0)
	slot0._isInited = true

	RoomController.instance:registerCallback(RoomEvent.UpdateProduceLineData, slot0.refreshData, slot0)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, slot0.onItemChanged, slot0)
	CurrencyController.instance:registerCallback(CurrencyEvent.CurrencyChange, slot0.onItemChanged, slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshFaithShow, slot0.onFaithChanged, slot0)
	CharacterController.instance:registerCallback(CharacterEvent.HeroUpdatePush, slot0.onFaithChanged, slot0)
	RoomGiftController.instance:registerCallback(RoomGiftEvent.UpdateActInfo, slot0.onRoomGiftActUpdate, slot0)
	RoomGiftController.instance:registerCallback(RoomGiftEvent.GetBonus, slot0.onRoomGiftActUpdate, slot0)
	PCInputController.instance:registerCallback(PCInputEvent.NotifyRoomCharactorFaith, slot0.gainAllFaithReward, slot0)
	PCInputController.instance:registerCallback(PCInputEvent.NotifyRoomCharactorFaithFull, slot0.focusFaithFullChar, slot0)
	ManufactureController.instance:registerCallback(ManufactureEvent.ManufactureInfoUpdate, slot0.onManufactureInfoUpdate, slot0)
	ManufactureController.instance:registerCallback(ManufactureEvent.ManufactureBuildingInfoChange, slot0.onManufactureInfoUpdate, slot0)
	CritterController.instance:registerCallback(CritterEvent.CritterInfoPushReply, slot0.startCheckTrainEventTask, slot0)
	slot0:refreshData()

	slot0._clickFaithCharacterDict = nil
end

function slot0.release(slot0)
	slot0._isInited = false

	RoomController.instance:unregisterCallback(RoomEvent.UpdateProduceLineData, slot0.refreshData, slot0)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, slot0.onItemChanged, slot0)
	CurrencyController.instance:unregisterCallback(CurrencyEvent.CurrencyChange, slot0.onItemChanged, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshFaithShow, slot0.onFaithChanged, slot0)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroUpdatePush, slot0.onFaithChanged, slot0)
	PCInputController.instance:unregisterCallback(PCInputEvent.NotifyRoomCharactorFaith, slot0.gainAllFaithReward, slot0)
	PCInputController.instance:unregisterCallback(PCInputEvent.NotifyRoomCharactorFaithFull, slot0.focusFaithFullChar, slot0)
	RoomGiftController.instance:unregisterCallback(RoomGiftEvent.UpdateActInfo, slot0.onRoomGiftActUpdate, slot0)
	RoomGiftController.instance:unregisterCallback(RoomGiftEvent.GetBonus, slot0.onRoomGiftActUpdate, slot0)
	ManufactureController.instance:unregisterCallback(ManufactureEvent.ManufactureInfoUpdate, slot0.onManufactureInfoUpdate, slot0)
	ManufactureController.instance:unregisterCallback(ManufactureEvent.ManufactureBuildingInfoChange, slot0.onManufactureInfoUpdate, slot0)
	CritterController.instance:unregisterCallback(CritterEvent.CritterInfoPushReply, slot0.startCheckTrainEventTask, slot0)
	RoomNavigateBubbleModel.instance:clear()

	slot0._clickFaithCharacterDict = nil
end

function slot0.refreshData(slot0)
	if slot0._isInited then
		RoomNavigateBubbleModel.instance:buildCategory()
		slot0:sortData()
		slot0:dispatchEvent(RoomEvent.NavigateBubbleUpdate)
	end
end

function slot0.onItemChanged(slot0)
	if slot0._isInited then
		RoomNavigateBubbleModel.instance:updateBuildingUpgrade()
		slot0:sortData()
		slot0:dispatchEvent(RoomEvent.NavigateBubbleUpdate)
	end
end

function slot0.onFaithChanged(slot0)
	if slot0._isInited then
		RoomNavigateBubbleModel.instance:updateHeroFaith()
		slot0:sortData()
		slot0:dispatchEvent(RoomEvent.NavigateBubbleUpdate)
	end
end

function slot0.onRoomGiftActUpdate(slot0)
	if not slot0._isInited then
		return
	end

	RoomNavigateBubbleModel.instance:updateRoomGift()
	slot0:sortData()
	slot0:dispatchEvent(RoomEvent.NavigateBubbleUpdate)
end

function slot0.onManufactureInfoUpdate(slot0)
	if not slot0._isInited then
		return
	end

	RoomNavigateBubbleModel.instance:updateManufacture()
	slot0:sortData()
	slot0:dispatchEvent(RoomEvent.NavigateBubbleUpdate)
end

function slot0.startCheckTrainEventTask(slot0)
	if not slot0._isHasCheckTrainEventTask then
		slot0._isHasCheckTrainEventTask = true

		TaskDispatcher.runDelay(slot0._onRunCheckTrainEventTask, slot0, 0.1)
	end
end

function slot0._onRunCheckTrainEventTask(slot0)
	slot0._isHasCheckTrainEventTask = false

	if not slot0._isInited then
		return
	end

	RoomNavigateBubbleModel.instance:updateCritterEvent()
	slot0:sortData()
	slot0:dispatchEvent(RoomEvent.NavigateBubbleUpdate)
end

function slot0.sortData(slot0)
	RoomNavigateBubbleModel.instance:sortCategory()
end

function slot0.sortProductProgress(slot0, slot1)
	slot3 = RoomProductionModel.instance:getById(slot1)

	if RoomProductionModel.instance:getById(slot0) ~= nil and slot3 ~= nil then
		return uv0.getFinishProgress(slot3) < uv0.getFinishProgress(slot2)
	else
		return slot0 < slot1
	end
end

function slot0.sortProductLineUpgrade(slot0, slot1)
	if slot0 == RoomNavigateBubbleEnum.HallId or slot1 == RoomNavigateBubbleEnum.HallId then
		return slot0 == RoomNavigateBubbleEnum.HallId
	end

	return slot0 < slot1
end

function slot0.sortManufacture(slot0, slot1)
	return slot0 < slot1
end

function slot0.sortCritter(slot0, slot1)
	slot3 = CritterModel.instance:getCritterMOByUid(slot1)

	if not CritterModel.instance:getCritterMOByUid(slot0) or not slot3 then
		return false
	end

	if slot2:isCultivating() ~= slot3:isCultivating() then
		return slot4
	end

	return slot0 < slot1
end

function slot0.getFinishProgress(slot0)
	if slot0 then
		return slot0:getReservePer()
	end

	return 0
end

slot0.sortFunc = {
	[RoomNavigateBubbleEnum.CategoryType.Factory] = {
		[RoomNavigateBubbleEnum.FactoryBubbleType.ProductProgress] = slot0.sortProductProgress,
		[RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade] = slot0.sortProductLineUpgrade,
		[RoomNavigateBubbleEnum.FactoryBubbleType.Manufacture] = slot0.sortManufacture,
		[RoomNavigateBubbleEnum.FactoryBubbleType.Critter] = slot0.sortCritter
	}
}

function slot0.onClickCall(slot0, slot1)
	if slot1 and slot1:getFirstBubble() then
		if uv0.showFunc[slot1.showType] then
			slot3(slot0, slot1:getFirstBubble(), slot1)
		end
	end
end

function slot0.lookAtBuildingPart(slot0, slot1)
	if RoomConfig.instance:getProductionPartByLineId(slot1) ~= nil then
		RoomBuildingController.instance:tweenCameraFocusPart(slot2)

		return
	end

	slot0:focusInitBuilding()
end

function slot0.openBubbleUpgrade(slot0, slot1)
	if slot1 == RoomNavigateBubbleEnum.HallId then
		RoomMapController.instance:openRoomLevelUpView()
	else
		ViewMgr.instance:openView(ViewName.RoomProductLineLevelUpView, {
			lineMO = RoomProductionModel.instance:getById(slot1)
		})
	end
end

function slot0.gainAllFaithReward(slot0, slot1)
	RoomCharacterController.instance:gainAllCharacterFaith()
end

function slot0.focusFaithFullChar(slot0, slot1)
	RoomCharacterController.instance:tweenCameraFocusCharacter(slot1, RoomEnum.CameraState.Normal)
	RoomCharacterController.instance:setCharacterFullFaithChecked(slot1)
end

function slot0.focusInitBuilding(slot0)
	RoomBuildingController.instance:tweenCameraFocusPart()
end

function slot0.openInitBuildingView(slot0, slot1)
	if slot1 == RoomNavigateBubbleEnum.HallId then
		RoomMapController.instance:openRoomInitBuildingView(0.2)
	else
		slot2 = slot1

		RoomMapController.instance:openRoomInitBuildingView(0.2, {
			partId = RoomProductionHelper.getPartIdByLineId(slot2),
			lineId = slot2
		})
	end
end

function slot0._sortFaithCharacter(slot0, slot1)
	if slot0:getCurrentInteractionId() and not slot1:getCurrentInteractionId() then
		return true
	elseif not slot2 and slot3 then
		return false
	end

	return slot1.currentFaith < slot0.currentFaith
end

function slot0.checkNextCharacter(slot0)
	slot0._clickFaithCharacterDict = slot0._clickFaithCharacterDict or {}
	slot2 = {}

	for slot6, slot7 in ipairs(RoomCharacterModel.instance:getList()) do
		if slot7.currentFaith > 0 then
			table.insert(slot2, slot7)
		end
	end

	if #slot2 <= 0 then
		return
	end

	table.sort(slot2, uv0._sortFaithCharacter)

	if slot2[1]:getCurrentInteractionId() then
		RoomCharacterController.instance:startInteraction(slot3, true, true)
	elseif not slot0:checkShowTimeBuildingInteraction() then
		slot5 = slot2[math.random(1, #slot2)]

		slot5:endMove(true)

		slot6 = slot5.currentPosition
		slot7 = slot5.heroId

		GameSceneMgr.instance:getCurScene().camera:switchCameraState(RoomEnum.CameraState.Normal, {
			focusX = slot6.x,
			focusY = slot6.z
		}, nil, function ()
			RoomCharacterController.instance:gainAllCharacterFaith(nil, , uv0)

			if GameSceneMgr.instance:getCurScene().charactermgr:getCharacterEntity(uv0, SceneTag.RoomCharacter) and slot1.characterspine then
				slot1.characterspine:touch(true)
			end
		end, nil)
	end
end

function slot0.checkShowTimeBuildingInteraction(slot0)
	slot1 = {}

	tabletool.addValues(slot1, RoomMapInteractionModel.instance:getBuildingInteractionMOList())
	RoomHelper.randomArray(slot1)

	slot2 = {}

	for slot6 = 1, #slot1 do
		slot7 = slot1[slot6]
		slot8 = RoomCharacterModel.instance:getCharacterMOById(slot7.config.heroId)

		if slot7.hasInteraction and slot8 then
			if slot8.currentFaith > 0 then
				table.insert(slot2, 1, slot7)
			else
				table.insert(slot2, slot7)
			end
		end
	end

	for slot6 = 1, #slot2 do
		if RoomInteractionController.instance:showTimeByInteractionMO(slot2[slot6], RoomCharacterEnum.ShowTimeFaithOp.FaithAll) then
			return true
		end
	end

	return false
end

function slot0.clickedCharacterFaithBubble(slot0)
	slot0:checkNextCharacter()
end

function slot0.focusManufactureBuildingCanReceive(slot0, slot1)
	RoomBuildingController.instance:tweenCameraFocusBuilding(slot1)
end

function slot0.clickCritterBubble(slot0, slot1)
	if not CritterModel.instance:getCritterMOByUid(slot1) then
		return
	end

	if slot2:isCultivating() then
		if slot2.trainInfo:isHasEventTrigger() or slot2.trainInfo:isTrainFinish() then
			ManufactureController.instance:openCritterBuildingView(nil, RoomCritterBuildingViewContainer.SubViewTabId.Training, slot1)

			return
		end
	end

	if slot2:isNoMoodWorking() then
		if ManufactureModel.instance:getCritterWorkingBuilding(slot1) then
			RoomBuildingController.instance:tweenCameraFocusBuilding(slot5)
		elseif RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(slot1) then
			RoomTransportController.instance:openTransportSiteView(RoomTransportHelper.fromTo2SiteType(slot6.fromType, slot6.toType))
		end
	end
end

slot0.showFunc = {
	[RoomNavigateBubbleEnum.FactoryBubbleType.ProductProgress] = slot0.lookAtBuildingPart,
	[RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade] = slot0.lookAtBuildingPart,
	[RoomNavigateBubbleEnum.FactoryBubbleType.FaithReward] = slot0.clickedCharacterFaithBubble,
	[RoomNavigateBubbleEnum.FactoryBubbleType.FaithFull] = slot0.focusFaithFullChar,
	[RoomNavigateBubbleEnum.FactoryBubbleType.RoomGift] = slot0.lookAtBuildingPart,
	[RoomNavigateBubbleEnum.FactoryBubbleType.Manufacture] = slot0.focusManufactureBuildingCanReceive,
	[RoomNavigateBubbleEnum.FactoryBubbleType.Critter] = slot0.clickCritterBubble
}
slot0.instance = slot0.New()

return slot0
