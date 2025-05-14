module("modules.logic.room.controller.RoomNavigateBubbleController", package.seeall)

local var_0_0 = class("RoomNavigateBubbleController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	arg_3_0:release()
end

function var_0_0.init(arg_4_0)
	arg_4_0._isInited = true

	RoomController.instance:registerCallback(RoomEvent.UpdateProduceLineData, arg_4_0.refreshData, arg_4_0)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, arg_4_0.onItemChanged, arg_4_0)
	CurrencyController.instance:registerCallback(CurrencyEvent.CurrencyChange, arg_4_0.onItemChanged, arg_4_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshFaithShow, arg_4_0.onFaithChanged, arg_4_0)
	CharacterController.instance:registerCallback(CharacterEvent.HeroUpdatePush, arg_4_0.onFaithChanged, arg_4_0)
	RoomGiftController.instance:registerCallback(RoomGiftEvent.UpdateActInfo, arg_4_0.onRoomGiftActUpdate, arg_4_0)
	RoomGiftController.instance:registerCallback(RoomGiftEvent.GetBonus, arg_4_0.onRoomGiftActUpdate, arg_4_0)
	PCInputController.instance:registerCallback(PCInputEvent.NotifyRoomCharactorFaith, arg_4_0.gainAllFaithReward, arg_4_0)
	PCInputController.instance:registerCallback(PCInputEvent.NotifyRoomCharactorFaithFull, arg_4_0.focusFaithFullChar, arg_4_0)
	ManufactureController.instance:registerCallback(ManufactureEvent.ManufactureInfoUpdate, arg_4_0.onManufactureInfoUpdate, arg_4_0)
	ManufactureController.instance:registerCallback(ManufactureEvent.ManufactureBuildingInfoChange, arg_4_0.onManufactureInfoUpdate, arg_4_0)
	CritterController.instance:registerCallback(CritterEvent.CritterInfoPushReply, arg_4_0.startCheckTrainEventTask, arg_4_0)
	arg_4_0:refreshData()

	arg_4_0._clickFaithCharacterDict = nil
end

function var_0_0.release(arg_5_0)
	arg_5_0._isInited = false

	RoomController.instance:unregisterCallback(RoomEvent.UpdateProduceLineData, arg_5_0.refreshData, arg_5_0)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, arg_5_0.onItemChanged, arg_5_0)
	CurrencyController.instance:unregisterCallback(CurrencyEvent.CurrencyChange, arg_5_0.onItemChanged, arg_5_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshFaithShow, arg_5_0.onFaithChanged, arg_5_0)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroUpdatePush, arg_5_0.onFaithChanged, arg_5_0)
	PCInputController.instance:unregisterCallback(PCInputEvent.NotifyRoomCharactorFaith, arg_5_0.gainAllFaithReward, arg_5_0)
	PCInputController.instance:unregisterCallback(PCInputEvent.NotifyRoomCharactorFaithFull, arg_5_0.focusFaithFullChar, arg_5_0)
	RoomGiftController.instance:unregisterCallback(RoomGiftEvent.UpdateActInfo, arg_5_0.onRoomGiftActUpdate, arg_5_0)
	RoomGiftController.instance:unregisterCallback(RoomGiftEvent.GetBonus, arg_5_0.onRoomGiftActUpdate, arg_5_0)
	ManufactureController.instance:unregisterCallback(ManufactureEvent.ManufactureInfoUpdate, arg_5_0.onManufactureInfoUpdate, arg_5_0)
	ManufactureController.instance:unregisterCallback(ManufactureEvent.ManufactureBuildingInfoChange, arg_5_0.onManufactureInfoUpdate, arg_5_0)
	CritterController.instance:unregisterCallback(CritterEvent.CritterInfoPushReply, arg_5_0.startCheckTrainEventTask, arg_5_0)
	RoomNavigateBubbleModel.instance:clear()

	arg_5_0._clickFaithCharacterDict = nil
end

function var_0_0.refreshData(arg_6_0)
	if arg_6_0._isInited then
		RoomNavigateBubbleModel.instance:buildCategory()
		arg_6_0:sortData()
		arg_6_0:dispatchEvent(RoomEvent.NavigateBubbleUpdate)
	end
end

function var_0_0.onItemChanged(arg_7_0)
	if arg_7_0._isInited then
		RoomNavigateBubbleModel.instance:updateBuildingUpgrade()
		arg_7_0:sortData()
		arg_7_0:dispatchEvent(RoomEvent.NavigateBubbleUpdate)
	end
end

function var_0_0.onFaithChanged(arg_8_0)
	if arg_8_0._isInited then
		RoomNavigateBubbleModel.instance:updateHeroFaith()
		arg_8_0:sortData()
		arg_8_0:dispatchEvent(RoomEvent.NavigateBubbleUpdate)
	end
end

function var_0_0.onRoomGiftActUpdate(arg_9_0)
	if not arg_9_0._isInited then
		return
	end

	RoomNavigateBubbleModel.instance:updateRoomGift()
	arg_9_0:sortData()
	arg_9_0:dispatchEvent(RoomEvent.NavigateBubbleUpdate)
end

function var_0_0.onManufactureInfoUpdate(arg_10_0)
	if not arg_10_0._isInited then
		return
	end

	RoomNavigateBubbleModel.instance:updateManufacture()
	arg_10_0:sortData()
	arg_10_0:dispatchEvent(RoomEvent.NavigateBubbleUpdate)
end

function var_0_0.startCheckTrainEventTask(arg_11_0)
	if not arg_11_0._isHasCheckTrainEventTask then
		arg_11_0._isHasCheckTrainEventTask = true

		TaskDispatcher.runDelay(arg_11_0._onRunCheckTrainEventTask, arg_11_0, 0.1)
	end
end

function var_0_0._onRunCheckTrainEventTask(arg_12_0)
	arg_12_0._isHasCheckTrainEventTask = false

	if not arg_12_0._isInited then
		return
	end

	RoomNavigateBubbleModel.instance:updateCritterEvent()
	arg_12_0:sortData()
	arg_12_0:dispatchEvent(RoomEvent.NavigateBubbleUpdate)
end

function var_0_0.sortData(arg_13_0)
	RoomNavigateBubbleModel.instance:sortCategory()
end

function var_0_0.sortProductProgress(arg_14_0, arg_14_1)
	local var_14_0 = RoomProductionModel.instance:getById(arg_14_0)
	local var_14_1 = RoomProductionModel.instance:getById(arg_14_1)

	if var_14_0 ~= nil and var_14_1 ~= nil then
		return var_0_0.getFinishProgress(var_14_0) > var_0_0.getFinishProgress(var_14_1)
	else
		return arg_14_0 < arg_14_1
	end
end

function var_0_0.sortProductLineUpgrade(arg_15_0, arg_15_1)
	if arg_15_0 == RoomNavigateBubbleEnum.HallId or arg_15_1 == RoomNavigateBubbleEnum.HallId then
		return arg_15_0 == RoomNavigateBubbleEnum.HallId
	end

	return arg_15_0 < arg_15_1
end

function var_0_0.sortManufacture(arg_16_0, arg_16_1)
	return arg_16_0 < arg_16_1
end

function var_0_0.sortCritter(arg_17_0, arg_17_1)
	local var_17_0 = CritterModel.instance:getCritterMOByUid(arg_17_0)
	local var_17_1 = CritterModel.instance:getCritterMOByUid(arg_17_1)

	if not var_17_0 or not var_17_1 then
		return false
	end

	local var_17_2 = var_17_0:isCultivating()

	if var_17_2 ~= var_17_1:isCultivating() then
		return var_17_2
	end

	return arg_17_0 < arg_17_1
end

function var_0_0.getFinishProgress(arg_18_0)
	if arg_18_0 then
		return arg_18_0:getReservePer()
	end

	return 0
end

var_0_0.sortFunc = {
	[RoomNavigateBubbleEnum.CategoryType.Factory] = {
		[RoomNavigateBubbleEnum.FactoryBubbleType.ProductProgress] = var_0_0.sortProductProgress,
		[RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade] = var_0_0.sortProductLineUpgrade,
		[RoomNavigateBubbleEnum.FactoryBubbleType.Manufacture] = var_0_0.sortManufacture,
		[RoomNavigateBubbleEnum.FactoryBubbleType.Critter] = var_0_0.sortCritter
	}
}

function var_0_0.onClickCall(arg_19_0, arg_19_1)
	if arg_19_1 and arg_19_1:getFirstBubble() then
		local var_19_0 = arg_19_1:getFirstBubble()
		local var_19_1 = var_0_0.showFunc[arg_19_1.showType]

		if var_19_1 then
			var_19_1(arg_19_0, var_19_0, arg_19_1)
		end
	end
end

function var_0_0.lookAtBuildingPart(arg_20_0, arg_20_1)
	local var_20_0 = RoomConfig.instance:getProductionPartByLineId(arg_20_1)

	if var_20_0 ~= nil then
		RoomBuildingController.instance:tweenCameraFocusPart(var_20_0)

		return
	end

	arg_20_0:focusInitBuilding()
end

function var_0_0.openBubbleUpgrade(arg_21_0, arg_21_1)
	if arg_21_1 == RoomNavigateBubbleEnum.HallId then
		RoomMapController.instance:openRoomLevelUpView()
	else
		local var_21_0 = RoomProductionModel.instance:getById(arg_21_1)

		ViewMgr.instance:openView(ViewName.RoomProductLineLevelUpView, {
			lineMO = var_21_0
		})
	end
end

function var_0_0.gainAllFaithReward(arg_22_0, arg_22_1)
	RoomCharacterController.instance:gainAllCharacterFaith()
end

function var_0_0.focusFaithFullChar(arg_23_0, arg_23_1)
	RoomCharacterController.instance:tweenCameraFocusCharacter(arg_23_1, RoomEnum.CameraState.Normal)
	RoomCharacterController.instance:setCharacterFullFaithChecked(arg_23_1)
end

function var_0_0.focusInitBuilding(arg_24_0)
	RoomBuildingController.instance:tweenCameraFocusPart()
end

function var_0_0.openInitBuildingView(arg_25_0, arg_25_1)
	if arg_25_1 == RoomNavigateBubbleEnum.HallId then
		RoomMapController.instance:openRoomInitBuildingView(0.2)
	else
		local var_25_0 = arg_25_1
		local var_25_1 = RoomProductionHelper.getPartIdByLineId(var_25_0)

		RoomMapController.instance:openRoomInitBuildingView(0.2, {
			partId = var_25_1,
			lineId = var_25_0
		})
	end
end

function var_0_0._sortFaithCharacter(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getCurrentInteractionId()
	local var_26_1 = arg_26_1:getCurrentInteractionId()

	if var_26_0 and not var_26_1 then
		return true
	elseif not var_26_0 and var_26_1 then
		return false
	end

	return arg_26_0.currentFaith > arg_26_1.currentFaith
end

function var_0_0.checkNextCharacter(arg_27_0)
	arg_27_0._clickFaithCharacterDict = arg_27_0._clickFaithCharacterDict or {}

	local var_27_0 = RoomCharacterModel.instance:getList()
	local var_27_1 = {}

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		if iter_27_1.currentFaith > 0 then
			table.insert(var_27_1, iter_27_1)
		end
	end

	if #var_27_1 <= 0 then
		return
	end

	table.sort(var_27_1, var_0_0._sortFaithCharacter)

	local var_27_2 = var_27_1[1]:getCurrentInteractionId()

	if var_27_2 then
		RoomCharacterController.instance:startInteraction(var_27_2, true, true)
	elseif arg_27_0:checkShowTimeBuildingInteraction() then
		-- block empty
	else
		local var_27_3 = var_27_1[math.random(1, #var_27_1)]

		var_27_3:endMove(true)

		local var_27_4 = var_27_3.currentPosition
		local var_27_5 = var_27_3.heroId
		local var_27_6 = GameSceneMgr.instance:getCurScene()

		local function var_27_7()
			RoomCharacterController.instance:gainAllCharacterFaith(nil, nil, var_27_5)

			local var_28_0 = GameSceneMgr.instance:getCurScene().charactermgr:getCharacterEntity(var_27_5, SceneTag.RoomCharacter)

			if var_28_0 and var_28_0.characterspine then
				var_28_0.characterspine:touch(true)
			end
		end

		var_27_6.camera:switchCameraState(RoomEnum.CameraState.Normal, {
			focusX = var_27_4.x,
			focusY = var_27_4.z
		}, nil, var_27_7, nil)
	end
end

function var_0_0.checkShowTimeBuildingInteraction(arg_29_0)
	local var_29_0 = {}

	tabletool.addValues(var_29_0, RoomMapInteractionModel.instance:getBuildingInteractionMOList())
	RoomHelper.randomArray(var_29_0)

	local var_29_1 = {}

	for iter_29_0 = 1, #var_29_0 do
		local var_29_2 = var_29_0[iter_29_0]
		local var_29_3 = RoomCharacterModel.instance:getCharacterMOById(var_29_2.config.heroId)

		if var_29_2.hasInteraction and var_29_3 then
			if var_29_3.currentFaith > 0 then
				table.insert(var_29_1, 1, var_29_2)
			else
				table.insert(var_29_1, var_29_2)
			end
		end
	end

	for iter_29_1 = 1, #var_29_1 do
		if RoomInteractionController.instance:showTimeByInteractionMO(var_29_1[iter_29_1], RoomCharacterEnum.ShowTimeFaithOp.FaithAll) then
			return true
		end
	end

	return false
end

function var_0_0.clickedCharacterFaithBubble(arg_30_0)
	arg_30_0:checkNextCharacter()
end

function var_0_0.focusManufactureBuildingCanReceive(arg_31_0, arg_31_1)
	RoomBuildingController.instance:tweenCameraFocusBuilding(arg_31_1)
end

function var_0_0.clickCritterBubble(arg_32_0, arg_32_1)
	local var_32_0 = CritterModel.instance:getCritterMOByUid(arg_32_1)

	if not var_32_0 then
		return
	end

	if var_32_0:isCultivating() then
		local var_32_1 = var_32_0.trainInfo:isHasEventTrigger()
		local var_32_2 = var_32_0.trainInfo:isTrainFinish()

		if var_32_1 or var_32_2 then
			ManufactureController.instance:openCritterBuildingView(nil, RoomCritterBuildingViewContainer.SubViewTabId.Training, arg_32_1)

			return
		end
	end

	if var_32_0:isNoMoodWorking() then
		local var_32_3 = ManufactureModel.instance:getCritterWorkingBuilding(arg_32_1)

		if var_32_3 then
			RoomBuildingController.instance:tweenCameraFocusBuilding(var_32_3)
		else
			local var_32_4 = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(arg_32_1)

			if var_32_4 then
				local var_32_5 = RoomTransportHelper.fromTo2SiteType(var_32_4.fromType, var_32_4.toType)

				RoomTransportController.instance:openTransportSiteView(var_32_5)
			end
		end
	end
end

var_0_0.showFunc = {
	[RoomNavigateBubbleEnum.FactoryBubbleType.ProductProgress] = var_0_0.lookAtBuildingPart,
	[RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade] = var_0_0.lookAtBuildingPart,
	[RoomNavigateBubbleEnum.FactoryBubbleType.FaithReward] = var_0_0.clickedCharacterFaithBubble,
	[RoomNavigateBubbleEnum.FactoryBubbleType.FaithFull] = var_0_0.focusFaithFullChar,
	[RoomNavigateBubbleEnum.FactoryBubbleType.RoomGift] = var_0_0.lookAtBuildingPart,
	[RoomNavigateBubbleEnum.FactoryBubbleType.Manufacture] = var_0_0.focusManufactureBuildingCanReceive,
	[RoomNavigateBubbleEnum.FactoryBubbleType.Critter] = var_0_0.clickCritterBubble
}
var_0_0.instance = var_0_0.New()

return var_0_0
