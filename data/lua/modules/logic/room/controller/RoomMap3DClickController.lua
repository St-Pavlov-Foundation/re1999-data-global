module("modules.logic.room.controller.RoomMap3DClickController", package.seeall)

slot0 = class("RoomMap3DClickController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.clear(slot0)
end

function slot0.onTransportSiteClick(slot0, slot1)
	slot2, slot3 = RoomTransportHelper.getSiteFromToByType(slot1)

	if slot2 and slot3 then
		RoomTransportController.instance:openTransportSiteView(slot1)
	end
end

function slot0.onCritterEntityClick(slot0, slot1)
	if not slot1 then
		return
	end

	if not CritterModel.instance:getCritterMOByUid(slot1.id) then
		return
	end

	if slot2:isCultivating() then
		if slot2.trainInfo:isHasEventTrigger() then
			ManufactureController.instance:openCritterBuildingView(nil, RoomCritterBuildingViewContainer.SubViewTabId.Training, slot2.id)
		elseif RoomCameraController.instance:getRoomScene() then
			if slot3.crittermgr:getCritterEntity(slot2.id, SceneTag.RoomCharacter) then
				slot4.critterspine:touch(true)
			end

			if RoomCharacterModel.instance:getCharacterMOById(slot1.heroId) then
				slot5:setLockTime(10)
			end

			if slot3.charactermgr:getCharacterEntity(slot1.heroId, SceneTag.RoomCharacter) then
				slot6.characterspine:play(RoomCharacterEnum.CharacterAnimStateName.Idle)
			end
		end
	elseif slot2.workInfo.workBuildingUid and slot2.workInfo.workBuildingUid ~= 0 then
		slot0:onBuildingEntityClick(RoomMapBuildingModel.instance:getBuildingMOById(slot2.workInfo.workBuildingUid))
	end
end

function slot0.onBuildingEntityClick(slot0, slot1)
	if not slot1 or not slot1.config then
		return
	end

	if slot0:_getBuildingTypeClickFunc(slot1.config.buildingType) then
		slot2(slot0, slot1)
	else
		logWarn("建筑[%s] buildingType:%s 没点击处理function", slot1.config.name or slot1.buildingId, slot1.config.buildingTyp or "nil")
	end
end

function slot0._getBuildingTypeClickFunc(slot0, slot1)
	if not slot0._buildingTypeClickFuncDict then
		slot0._buildingTypeClickFuncDict = {
			[RoomBuildingEnum.BuildingType.Collect] = slot0._onManufactureBuildingClick,
			[RoomBuildingEnum.BuildingType.Process] = slot0._onManufactureBuildingClick,
			[RoomBuildingEnum.BuildingType.Manufacture] = slot0._onManufactureBuildingClick,
			[RoomBuildingEnum.BuildingType.Trade] = slot0._onTradeBuildingClick,
			[RoomBuildingEnum.BuildingType.Rest] = slot0._onRestBuildingClick,
			[RoomBuildingEnum.BuildingType.Interact] = slot0._onInteractBuildingClick
		}
	end

	return slot0._buildingTypeClickFuncDict[slot1]
end

function slot0._onManufactureBuildingClick(slot0, slot1)
	if not (RoomController.instance:isObMode() and ManufactureConfig.instance:isManufactureBuilding(slot1.buildingId) and not RoomBuildingController.instance:isBuildingListShow() and not RoomCharacterController.instance:isCharacterListShow()) then
		return
	end

	ManufactureController.instance:openManufactureBuildingViewByBuilding(slot1)
end

function slot0._onTradeBuildingClick(slot0, slot1)
	ManufactureController.instance:openRoomTradeView(slot1.buildingUid)
end

function slot0._onRestBuildingClick(slot0, slot1)
	if not (RoomController.instance:isObMode() and RoomConfig.instance:getBuildingType(slot1.buildingId) == RoomBuildingEnum.BuildingType.Rest and not RoomBuildingController.instance:isBuildingListShow() and not RoomCharacterController.instance:isCharacterListShow()) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	ManufactureController.instance:openCritterBuildingView(slot1.buildingUid)
end

function slot0._onInteractBuildingClick(slot0, slot1)
	RoomInteractionController.instance:openInteractBuildingView(slot1.buildingUid)
end

slot0.instance = slot0.New()

return slot0
