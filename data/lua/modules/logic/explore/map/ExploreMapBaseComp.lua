module("modules.logic.explore.map.ExploreMapBaseComp", package.seeall)

slot0 = class("ExploreMapBaseComp", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._mapGo = slot1
	slot0._mapStatus = ExploreEnum.MapStatus.Normal

	slot0:onInit()
end

function slot0.onInit(slot0)
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.setMap(slot0, slot1)
	slot0._map = slot1
end

function slot0.setMapStatus(slot0, slot1)
	slot0._mapStatus = slot1
end

function slot0.beginStatus(slot0, slot1)
	return slot0._map:setMapStatus(slot0._mapStatus, slot1)
end

function slot0.onStatusStart(slot0)
end

function slot0.onStatusEnd(slot0)
end

function slot0.onMapClick(slot0, slot1)
	slot0._map:setMapStatus(ExploreEnum.MapStatus.Normal)
end

function slot0.canSwitchStatus(slot0, slot1)
	return true
end

function slot0.onDestroy(slot0)
	slot0._mapGo = nil
end

return slot0
