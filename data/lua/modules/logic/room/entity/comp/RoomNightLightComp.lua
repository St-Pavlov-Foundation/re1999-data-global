module("modules.logic.room.entity.comp.RoomNightLightComp", package.seeall)

slot0 = class("RoomNightLightComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._effectKey = RoomEnum.EffectKey.BuildingGOKey
	slot0._isNight = RoomWeatherModel.instance:getIsNight()
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
end

function slot0.setEffectKey(slot0, slot1)
	slot0._effectKey = slot1
end

function slot0.addEventListeners(slot0)
	RoomMapController.instance:registerCallback(RoomEvent.MapEntityNightLight, slot0._onNightLight, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.MapEntityNightLight, slot0._onNightLight, slot0)
end

function slot0._onNightLight(slot0, slot1)
	if slot1 ~= nil and slot0._isNight ~= slot1 then
		slot0._isNight = slot1

		slot0:_updateNight()
	end
end

function slot0._updateNight(slot0)
	if slot0.entity.effect:getGameObjectsByName(slot0._effectKey, RoomEnum.EntityChildKey.NightLightGOKey) then
		for slot5, slot6 in ipairs(slot1) do
			gohelper.setActive(slot6, slot0._isNight)
		end
	end
end

function slot0.beforeDestroy(slot0)
end

function slot0.onEffectRebuild(slot0)
	if slot0.entity.effect:isHasEffectGOByKey(slot0._effectKey) and not slot1:isSameResByKey(slot0._effectKey, slot0._effectRes) then
		slot0._effectRes = slot1:getEffectRes(slot0._effectKey)

		slot0:_updateNight()
	end
end

return slot0
