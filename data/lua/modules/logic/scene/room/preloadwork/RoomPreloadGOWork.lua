module("modules.logic.scene.room.preloadwork.RoomPreloadGOWork", package.seeall)

slot0 = class("RoomPreloadGOWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot0._loader = MultiAbLoader.New()

	for slot6, slot7 in ipairs(slot0:_getUIUrlList()) do
		slot0._loader:addPath(slot7)
	end

	slot0._loader:setLoadFailCallback(slot0._onPreloadOneFail)
	slot0._loader:startLoad(slot0._onPreloadFinish, slot0)
end

function slot0._onPreloadFinish(slot0, slot1)
	for slot6, slot7 in pairs(slot1:getAssetItemDict()) do
		slot0.context.callback(slot0.context.callbackObj, slot6, slot7)
	end

	slot0:onDone(true)
end

function slot0._onPreloadOneFail(slot0, slot1, slot2)
	logError("RoomPreloadGOWork: 加载失败, url: " .. slot2.ResPath)
end

function slot0.clearWork(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

function slot0._getUIUrlList(slot0)
	slot1 = {}

	if RoomController.instance:isEditMode() then
		table.insert(slot1, RoomScenePreloader.ResEffectB)
		table.insert(slot1, RoomScenePreloader.ResVXPlacingHere)
		table.insert(slot1, RoomScenePreloader.ResSmoke)
		table.insert(slot1, RoomScenePreloader.ResSmokeSnow)
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
		table.insert(slot1, RoomScenePreloader.ResCharacterFaithEffect)
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

	table.insert(slot1, RoomScenePreloader.ResOcean)

	if RoomController.instance:isDebugPackageMode() then
		for slot5, slot6 in pairs(RoomScenePreloader.ResDebugPackageColorDict) do
			table.insert(slot1, slot6)
		end
	end

	for slot5, slot6 in ipairs(RoomScenePreloader.ResCommonList) do
		table.insert(slot1, slot6)
	end

	table.insert(slot1, RoomScenePreloader.ResFogParticle)

	for slot5, slot6 in ipairs(slot1) do
		slot0.context.poolGODict[slot6] = 6
	end

	return slot1
end

return slot0
