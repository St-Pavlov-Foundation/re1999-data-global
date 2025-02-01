module("modules.logic.room.model.transport.RoomTransportPathModel", package.seeall)

slot0 = class("RoomTransportPathModel", BaseModel)

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

function slot0.initPath(slot0, slot1)
	RoomTransportHelper.initTransportPathModel(slot0, slot1)
end

function slot0.removeByIds(slot0, slot1)
	if slot1 and #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			slot0:remove(slot0:getById(slot6))
		end
	end
end

function slot0.updateInofoById(slot0, slot1, slot2)
	if slot0:getById(slot1) and slot2 then
		slot3:updateInfo(slot2)
	end
end

function slot0.getTransportPathMO(slot0, slot1)
	return slot0:getById(slot1)
end

function slot0.getTransportPathMOList(slot0)
	return slot0:getList()
end

function slot0.setIsJumpTransportSite(slot0, slot1)
	slot0._isJumpTransportSite = slot1
end

function slot0.getisJumpTransportSite(slot0)
	return slot0._isJumpTransportSite
end

slot0.instance = slot0.New()

return slot0
