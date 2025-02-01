module("modules.logic.room.model.map.RoomWeatherModel", package.seeall)

slot0 = class("RoomWeatherModel", BaseModel)

function slot0.onInit(slot0)
	slot0:_clearData()
end

function slot0.reInit(slot0)
	slot0:_clearData()
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)
	slot0:_clearData()
end

function slot0._clearData(slot0)
end

function slot0.setIsNight(slot0, slot1)
	slot0._isNight = slot1 == true
end

function slot0.getIsNight(slot0)
	return slot0._isNight
end

slot0.instance = slot0.New()

return slot0
