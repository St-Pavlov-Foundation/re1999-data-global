module("modules.logic.player.model.KeyValueSimplePropertyMO", package.seeall)

slot0 = pureTable("KeyValueSimplePropertyMO")

function slot0.ctor(slot0)
	slot0._isNumber = true
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.property = slot1.property
	slot0._map = {}
	slot6 = "#"

	for slot6, slot7 in ipairs(GameUtil.splitString2(slot1.property, slot0._isNumber, "|", slot6)) do
		slot0._map[slot7[1]] = slot7[2]
	end
end

function slot0.getValue(slot0, slot1, slot2)
	return slot0._map and slot0._map[slot1] or slot2
end

function slot0.setValue(slot0, slot1, slot2)
	if not slot0._map then
		slot0._map = {}
	end

	slot0._map[slot1] = slot2
end

function slot0.getString(slot0)
	if not slot0._map then
		return ""
	end

	for slot5, slot6 in pairs(slot0._map) do
		slot7 = string.format("%s#%s", slot5, slot6)
		slot1 = not string.nilorempty(slot1) and slot1 .. "|" .. slot7 or slot7
	end

	return slot1
end

return slot0
