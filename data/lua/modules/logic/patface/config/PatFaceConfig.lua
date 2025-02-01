module("modules.logic.patface.config.PatFaceConfig", package.seeall)

slot0 = class("PatFaceConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._patFaceConfigList = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"pat_face"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot0[string.format("%sConfigLoaded", slot1)] then
		slot4(slot0, slot2)
	end
end

function slot1(slot0, slot1)
	if (slot0.order or 0) ~= (slot1.order or 0) then
		return slot2 < slot3
	end

	return slot0.id < slot1.id
end

function slot0.pat_faceConfigLoaded(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1.configList) do
		slot2[#slot2 + 1] = {
			id = slot7.id,
			order = slot7.patFaceOrder,
			config = slot7
		}
	end

	table.sort(slot2, uv0)

	slot0._patFaceConfigList = slot2
end

function slot2(slot0, slot1)
	slot2 = nil

	if slot0 then
		slot2 = lua_pat_face.configDict[slot0]
	end

	if not slot2 and not slot1 then
		logError(string.format("PatFaceConfig:getCfg error, cfg is nil, id:%s", slot0))
	end

	return slot2
end

function slot0.getPatFaceActivityId(slot0, slot1)
	slot2 = 0

	if uv0(slot1) then
		slot2 = slot3.patFaceActivityId
	end

	return slot2
end

function slot0.getPatFaceViewName(slot0, slot1)
	slot2 = ""

	if uv0(slot1) then
		slot2 = slot3.patFaceViewName
	end

	return slot2
end

function slot0.getPatFaceStoryId(slot0, slot1)
	slot2 = 0

	if uv0(slot1) then
		slot2 = slot3.patFaceStoryId
	end

	return slot2
end

function slot0.getPatFaceOrder(slot0, slot1)
	slot2 = 0

	if uv0(slot1) then
		slot2 = slot3.patFaceOrder
	end

	return slot2
end

function slot0.getPatFaceConfigList(slot0)
	return slot0._patFaceConfigList or {}
end

slot0.instance = slot0.New()

return slot0
