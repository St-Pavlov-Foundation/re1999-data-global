module("modules.logic.room.controller.RoomVehicleController", package.seeall)

slot0 = class("RoomVehicleController", BaseController)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	RoomMapVehicleModel.instance:clear()
	RoomMapPathPlanModel.instance:clear()
end

function slot0.init(slot0)
	RoomMapPathPlanModel.instance:initPath()
	RoomMapVehicleModel.instance:initVehicle()
end

function slot0.addConstEvents(slot0)
end

slot0.instance = slot0.New()

return slot0
