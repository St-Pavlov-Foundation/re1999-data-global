module("modules.logic.scene.room.preloadwork.RoomPreloadCharacterWork", package.seeall)

slot0 = class("RoomPreloadCharacterWork", BaseWork)

function slot0.onStart(slot0, slot1)
	if slot0:_getUrlList() and #slot2 > 0 then
		slot0._loader = MultiAbLoader.New()

		for slot6, slot7 in ipairs(slot2) do
			slot0._loader:addPath(slot7)
		end

		slot0._loader:setLoadFailCallback(slot0._onPreloadOneFail)
		slot0._loader:startLoad(slot0._onPreloadFinish, slot0)
	else
		slot0:onDone(true)
	end
end

function slot0._onPreloadFinish(slot0, slot1)
	slot0:onDone(true)
end

function slot0._onPreloadOneFail(slot0, slot1, slot2)
	logError("RoomPreloadCharacterWork: 加载失败, url: " .. slot2.ResPath)
end

function slot0.clearWork(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

function slot0._getUrlList(slot0)
	if not RoomController.instance:isObMode() and not RoomController.instance:isVisitMode() then
		return nil
	end

	slot1 = {
		RoomCharacterEnum.MaterialPath
	}

	for slot6, slot7 in pairs(RoomCharacterModel.instance:getList()) do
		slot0:_addListUrl(slot1, RoomResHelper.getCharacterPath(slot7.skinId))
		slot0:_addListUrl(slot1, RoomResHelper.getCharacterCameraAnimABPath(slot7.roomCharacterConfig.cameraAnimPath))
		slot0:_addListUrl(slot1, RoomResHelper.getCharacterEffectABPath(slot7.roomCharacterConfig.effectPath))
		slot0:_addCharacterEffectUrl(slot1, slot7.skinId)
	end

	return slot1
end

function slot0._addListUrl(slot0, slot1, slot2)
	if not string.nilorempty(slot2) then
		table.insert(slot1, slot2)
	end
end

function slot0._addCharacterEffectUrl(slot0, slot1, slot2)
	if RoomConfig.instance:getCharacterEffectList(slot2) then
		for slot7, slot8 in ipairs(slot3) do
			if not RoomCharacterEnum.maskInteractAnim[slot8.animName] then
				slot0:_addListUrl(slot1, RoomResHelper.getCharacterEffectABPath(slot8.effectRes))
			end
		end
	end
end

return slot0
