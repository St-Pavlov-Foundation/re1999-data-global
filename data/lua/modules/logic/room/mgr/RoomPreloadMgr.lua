module("modules.logic.room.mgr.RoomPreloadMgr", package.seeall)

slot0 = class("RoomPreloadMgr", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.startPreload(slot0)
	if slot0._loader then
		slot0._loader:dispose()
	end

	slot0._loader = SequenceAbLoader.New()

	slot0:_addPreloadList(slot0:_getSceneLevel())
	slot0:_addPreloadList(slot0:_getView())
	slot0:_addPreloadList(slot0:_getUIUrlList())
	slot0:_addPreloadList(slot0:_getGOUrlList())
	slot0:_addPreloadList(slot0:_getAnimUrlList())
	slot0:_addPreloadList(slot0:_getBuildingUrlList())
	slot0._loader:setConcurrentCount(#slot0._loader._pathList / 5)
	RoomHelper.logElapse("++++++++++++ RoomPreloadMgr:startPreload, count = " .. #slot0._loader._pathList)
	slot0._loader:setOneFinishCallback(slot0._onOneFinish)
	slot0._loader:startLoad(slot0._onLoadFinish, slot0)
end

function slot0._onOneFinish(slot0, slot1, slot2)
	slot2:GetResource(slot2.ResPath)
end

function slot0._onLoadFinish(slot0, slot1)
	RoomHelper.logElapse("---------------- RoomPreloadMgr:preloadFinish, count = " .. #slot0._loader._pathList)
end

function slot0._addPreloadList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0._loader:addPath(slot6)
	end
end

function slot0._getSceneLevel(slot0)
	if SceneConfig.instance:getSceneLevelCOs(RoomEnum.RoomSceneId) then
		return {
			ResUrl.getSceneLevelUrl(slot1[1].id)
		}
	end

	return {}
end

function slot0._getView(slot0)
	slot2 = ViewMgr.instance:getSetting(ViewName.RoomView)

	table.insert({}, slot2.mainRes)

	if slot2.otherRes then
		for slot6, slot7 in ipairs(slot2.otherRes) do
			table.insert(slot1, slot7)
		end
	end

	if slot2.tabRes then
		for slot6, slot7 in pairs(slot2.tabRes) do
			for slot11, slot12 in pairs(slot7) do
				for slot16, slot17 in ipairs(slot12) do
					table.insert(slot1, slot17)
				end
			end
		end
	end

	return slot1
end

function slot0._getMapBlockUrlList(slot0)
	slot1 = {}
	slot5 = "ground/water/water"

	table.insert(slot1, ResUrl.getRoomRes(slot5))
	table.insert(slot1, RoomScenePreloader.DefaultLand)
	table.insert(slot1, RoomScenePreloader.InitLand)
	table.insert(slot1, RoomScenePreloader.ReplaceLand)

	for slot5, slot6 in pairs(RoomRiverEnum.RiverBlockType) do
		table.insert(slot1, RoomResHelper.getMapBlockResPath(RoomResourceEnum.ResourceId.River, slot6))
		table.insert(slot1, RoomResHelper.getMapRiverFloorResPath(slot6))
	end

	for slot5, slot6 in pairs(RoomRiverEnum.LakeBlockType) do
		table.insert(slot1, RoomResHelper.getMapBlockResPath(RoomResourceEnum.ResourceId.River, slot6))
	end

	for slot5, slot6 in pairs(RoomRiverEnum.LakeFloorType) do
		table.insert(slot1, RoomResHelper.getMapRiverFloorResPath(slot6))
	end

	for slot6, slot7 in ipairs(RoomMapBuildingModel.instance:getBuildingMOList()) do
		table.insert(slot1, RoomResHelper.getBuildingPath(slot7.buildingId, slot7.level))
	end

	return slot1
end

function slot0._getUIUrlList(slot0)
	slot1 = {}

	if RoomController.instance:isDebugPackageMode() then
		table.insert(slot1, RoomScenePreloader.ResDebugPackageUI)
	end

	table.insert(slot1, RoomViewConfirm.prefabPath)

	return slot1
end

function slot0._getGOUrlList(slot0)
	slot1 = {}

	if RoomController.instance:isEditMode() then
		table.insert(slot1, RoomScenePreloader.ResEffectB)
		table.insert(slot1, RoomScenePreloader.ResVXPlacingHere)
		table.insert(slot1, RoomScenePreloader.ResSmoke)
	end

	if RoomController.instance:isObMode() then
		table.insert(slot1, RoomScenePreloader.ResEffectE)
		table.insert(slot1, RoomScenePreloader.ResEffectD01)
		table.insert(slot1, RoomScenePreloader.ResEffectD02)
		table.insert(slot1, RoomScenePreloader.ResEffectD05)
		table.insert(slot1, RoomScenePreloader.ResVXXuXian)
		table.insert(slot1, RoomScenePreloader.ResCharacterClickHelper)
		table.insert(slot1, RoomScenePreloader.ResEffectConfirmCharacter)
		table.insert(slot1, RoomScenePreloader.ResEffectCharacterShadow)
		table.insert(slot1, RoomScenePreloader.ResEffectPressingCharacter)
		table.insert(slot1, RoomScenePreloader.ResEffectPlaceCharacter)
	end

	if RoomController.instance:isVisitMode() then
		table.insert(slot1, RoomScenePreloader.ResEffectCharacterShadow)
	end

	for slot5, slot6 in ipairs(RoomScenePreloader.ResEffectWaveList) do
		table.insert(slot1, slot6)
	end

	for slot5, slot6 in ipairs(RoomScenePreloader.ResEffectWaveWithRiverList) do
		table.insert(slot1, slot6)
	end

	if RoomController.instance:isDebugPackageMode() then
		for slot5, slot6 in pairs(RoomScenePreloader.ResDebugPackageColorDict) do
			table.insert(slot1, slot6)
		end
	end

	for slot5, slot6 in ipairs(RoomScenePreloader.ResCommonList) do
		table.insert(slot1, slot6)
	end

	table.insert(slot1, RoomScenePreloader.ResOcean)
	table.insert(slot1, RoomScenePreloader.ResFogParticle)

	if BootNativeUtil.isWindows() then
		table.insert(slot1, RoomScenePreloader.DiffuseGI)
	end

	return slot1
end

function slot0._getAnimUrlList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(RoomScenePreloader.ResAnim) do
		table.insert(slot1, slot6)
	end

	return slot1
end

function slot0._getBuildingUrlList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(RoomMapBuildingModel.instance:getBuildingMOList()) do
		table.insert(slot1, RoomResHelper.getBuildingPath(slot7.buildingId, slot7.level))
	end

	table.insert(slot1, RoomScenePreloader.ResInitBuilding)

	return slot1
end

function slot0.dispose(slot0)
	RoomHelper.logElapse("---------------- RoomPreloadMgr:dispose")

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

slot0.instance = slot0.New()

return slot0
