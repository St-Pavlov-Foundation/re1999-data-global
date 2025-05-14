module("modules.logic.room.controller.RoomMap3DClickController", package.seeall)

local var_0_0 = class("RoomMap3DClickController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.clear(arg_3_0)
	return
end

function var_0_0.onTransportSiteClick(arg_4_0, arg_4_1)
	local var_4_0, var_4_1 = RoomTransportHelper.getSiteFromToByType(arg_4_1)

	if var_4_0 and var_4_1 then
		RoomTransportController.instance:openTransportSiteView(arg_4_1)
	end
end

function var_0_0.onCritterEntityClick(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return
	end

	local var_5_0 = CritterModel.instance:getCritterMOByUid(arg_5_1.id)

	if not var_5_0 then
		return
	end

	if var_5_0:isCultivating() then
		if var_5_0.trainInfo:isHasEventTrigger() then
			ManufactureController.instance:openCritterBuildingView(nil, RoomCritterBuildingViewContainer.SubViewTabId.Training, var_5_0.id)
		else
			local var_5_1 = RoomCameraController.instance:getRoomScene()

			if var_5_1 then
				local var_5_2 = var_5_1.crittermgr:getCritterEntity(var_5_0.id, SceneTag.RoomCharacter)

				if var_5_2 then
					var_5_2.critterspine:touch(true)
				end

				local var_5_3 = RoomCharacterModel.instance:getCharacterMOById(arg_5_1.heroId)

				if var_5_3 then
					var_5_3:setLockTime(10)
				end

				local var_5_4 = var_5_1.charactermgr:getCharacterEntity(arg_5_1.heroId, SceneTag.RoomCharacter)

				if var_5_4 then
					var_5_4.characterspine:play(RoomCharacterEnum.CharacterAnimStateName.Idle)
				end
			end
		end
	elseif var_5_0.workInfo.workBuildingUid and var_5_0.workInfo.workBuildingUid ~= 0 then
		local var_5_5 = RoomMapBuildingModel.instance:getBuildingMOById(var_5_0.workInfo.workBuildingUid)

		arg_5_0:onBuildingEntityClick(var_5_5)
	end
end

function var_0_0.onBuildingEntityClick(arg_6_0, arg_6_1)
	if not arg_6_1 or not arg_6_1.config then
		return
	end

	local var_6_0 = arg_6_0:_getBuildingTypeClickFunc(arg_6_1.config.buildingType)

	if var_6_0 then
		var_6_0(arg_6_0, arg_6_1)
	else
		logWarn("建筑[%s] buildingType:%s 没点击处理function", arg_6_1.config.name or arg_6_1.buildingId, arg_6_1.config.buildingTyp or "nil")
	end
end

function var_0_0._getBuildingTypeClickFunc(arg_7_0, arg_7_1)
	if not arg_7_0._buildingTypeClickFuncDict then
		arg_7_0._buildingTypeClickFuncDict = {
			[RoomBuildingEnum.BuildingType.Collect] = arg_7_0._onManufactureBuildingClick,
			[RoomBuildingEnum.BuildingType.Process] = arg_7_0._onManufactureBuildingClick,
			[RoomBuildingEnum.BuildingType.Manufacture] = arg_7_0._onManufactureBuildingClick,
			[RoomBuildingEnum.BuildingType.Trade] = arg_7_0._onTradeBuildingClick,
			[RoomBuildingEnum.BuildingType.Rest] = arg_7_0._onRestBuildingClick,
			[RoomBuildingEnum.BuildingType.Interact] = arg_7_0._onInteractBuildingClick
		}
	end

	return arg_7_0._buildingTypeClickFuncDict[arg_7_1]
end

function var_0_0._onManufactureBuildingClick(arg_8_0, arg_8_1)
	local var_8_0 = RoomController.instance:isObMode()
	local var_8_1 = arg_8_1.buildingId

	var_8_0 = var_8_0 and ManufactureConfig.instance:isManufactureBuilding(var_8_1)
	var_8_0 = var_8_0 and not RoomBuildingController.instance:isBuildingListShow()
	var_8_0 = var_8_0 and not RoomCharacterController.instance:isCharacterListShow()

	if not var_8_0 then
		return
	end

	ManufactureController.instance:openManufactureBuildingViewByBuilding(arg_8_1)
end

function var_0_0._onTradeBuildingClick(arg_9_0, arg_9_1)
	ManufactureController.instance:openRoomTradeView(arg_9_1.buildingUid)
end

function var_0_0._onRestBuildingClick(arg_10_0, arg_10_1)
	local var_10_0 = RoomController.instance:isObMode()
	local var_10_1 = arg_10_1.buildingId
	local var_10_2 = RoomConfig.instance:getBuildingType(var_10_1)

	var_10_0 = var_10_0 and var_10_2 == RoomBuildingEnum.BuildingType.Rest
	var_10_0 = var_10_0 and not RoomBuildingController.instance:isBuildingListShow()
	var_10_0 = var_10_0 and not RoomCharacterController.instance:isCharacterListShow()

	if not var_10_0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	ManufactureController.instance:openCritterBuildingView(arg_10_1.buildingUid)
end

function var_0_0._onInteractBuildingClick(arg_11_0, arg_11_1)
	RoomInteractionController.instance:openInteractBuildingView(arg_11_1.buildingUid)
end

var_0_0.instance = var_0_0.New()

return var_0_0
