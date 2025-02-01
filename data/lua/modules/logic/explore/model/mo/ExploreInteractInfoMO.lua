module("modules.logic.explore.model.mo.ExploreInteractInfoMO", package.seeall)

slot0 = pureTable("ExploreInteractInfoMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1
	slot0.step = 0
	slot0.status = 1
	slot0.status2 = ""
	slot0.statusInfo = {}
end

function slot0.initNO(slot0, slot1)
	slot2 = slot0.status
	slot3 = slot0.status2
	slot0.id = slot1.id
	slot0.status = slot1.status
	slot0.status2 = slot1.status2
	slot0.type = slot1.type
	slot0.step = slot1.step
	slot0.posx = slot1.posx
	slot0.posy = slot1.posy
	slot0.dir = slot1.dir
	slot4 = slot0.statusInfo or {}

	if string.nilorempty(slot0.status2) then
		slot0.statusInfo = {}
	else
		slot0.statusInfo = cjson.decode(slot0.status2)
	end

	if slot2 ~= slot0.status then
		slot0:onStatusChange(slot2, slot0.status)
	end

	if slot3 ~= slot0.status2 then
		slot0:onStatus2Change(slot4, slot0.statusInfo)
	end
end

function slot0.updateStatus(slot0, slot1)
	if slot0.status ~= slot1 then
		slot0.status = slot1

		slot0:onStatusChange(slot0.status, slot0.status)
	end
end

function slot0.updateStatus2(slot0, slot1)
	if slot0.status2 ~= slot1 then
		slot2 = slot0.status2
		slot0.status2 = slot1
		slot3 = slot0.statusInfo or {}

		if string.nilorempty(slot0.status2) then
			slot0.statusInfo = {}
		else
			slot0.statusInfo = cjson.decode(slot0.status2)
		end

		slot0:onStatus2Change(slot3, slot0.statusInfo)
	end
end

function slot0.getBitByIndex(slot0, slot1)
	return bit.rshift(ExploreHelper.getBit(slot0.status, slot1), slot1 - 1)
end

function slot0.setBitByIndex(slot0, slot1, slot2)
	slot0.status = ExploreHelper.setBit(slot0.status, slot1, slot2 == 1)

	if slot0.status ~= slot0.status then
		slot0:onStatusChange(slot3, slot0.status)
	end
end

function slot0.onStatusChange(slot0, slot1, slot2)
	if bit.bxor(slot1, slot2) == 0 then
		return
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.OnUnitStatusChange, slot0.id, slot3)
end

function slot0.onStatus2Change(slot0, slot1, slot2)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnUnitStatus2Change, slot0.id, slot1, slot2)
end

return slot0
