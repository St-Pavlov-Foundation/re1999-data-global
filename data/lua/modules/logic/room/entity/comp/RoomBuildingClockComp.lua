module("modules.logic.room.entity.comp.RoomBuildingClockComp", package.seeall)

slot0 = class("RoomBuildingClockComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot2 = slot0:getMO()
	slot0._audioExtendType = slot2.config.audioExtendType
	slot0._audioExtendIds = string.splitToNumber(slot2.config.audioExtendIds, "#") or {}
end

function slot0.addEventListeners(slot0)
	RoomMapController.instance:registerCallback(RoomEvent.OnHourReporting, slot0._onHourReporting, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.OnHourReporting, slot0._onHourReporting, slot0)
end

function slot0.beforeDestroy(slot0)
	slot0:removeEventListeners()
end

function slot0._onHourReporting(slot0, slot1)
	if RoomController.instance:isEditMode() or not slot1 then
		return
	end

	if slot0._audioExtendType == RoomBuildingEnum.AudioExtendType.Clock12Hour then
		RoomHelper.audioExtendTrigger(slot0._audioExtendIds[(slot1 - 1) % 12 + 1], slot0.go)
	end
end

function slot0.getMO(slot0)
	return slot0.entity:getMO()
end

return slot0
