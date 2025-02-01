module("modules.logic.room.entity.comp.RoomBuildingVehicleComp", package.seeall)

slot0 = class("RoomBuildingVehicleComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._vehicleType = slot0:getBuilingMO().config.vehicleType

	slot0:_onSwitchModel()
end

function slot0.addEventListeners(slot0)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, slot0._onSwitchModel, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomController.instance:unregisterCallback(RoomEvent.OnSwitchModeDone, slot0._onSwitchModel, slot0)
end

function slot0.beforeDestroy(slot0)
	slot0:removeEventListeners()
end

function slot0._onSwitchModel(slot0)
	if not RoomController.instance:isEditMode() and not slot0.entity:getVehicleMO() then
		slot1 = true
	end

	if slot0._vehicleType == 1 then
		gohelper.setActive(slot0.entity.containerGO, slot1)
		gohelper.setActive(slot0.entity.staticContainerGO, slot1)
	end
end

function slot0.getBuilingMO(slot0)
	return slot0.entity:getMO()
end

return slot0
