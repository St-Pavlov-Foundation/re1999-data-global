module("modules.logic.prototest.model.ProtoParamHelper", package.seeall)

slot0 = _M

function slot0.buildProtoParamsByProto(slot0, slot1)
	slot4 = {}

	for slot8, slot9 in ipairs(getmetatable(slot0)._descriptor.fields) do
		slot11 = ProtoTestCaseParamMO.New()

		slot11:initProto(slot1, slot9, slot0._fields[slot9])
		table.insert(slot4, slot11)
	end

	table.sort(slot4, function (slot0, slot1)
		return slot0.id < slot1.id
	end)

	return slot4
end

function slot0.buildRepeatedParamsByProto(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0) do
		slot8 = ProtoTestCaseParamMO.New()

		slot8:initProtoRepeated(slot1, slot6, slot7)
		table.insert(slot2, slot8)
	end

	table.sort(slot2, function (slot0, slot1)
		return slot0.id < slot1.id
	end)

	return slot2
end

slot1 = nil
slot2 = {}

function slot0.buildProtoByStructName(slot0)
	uv0._firstInitProtoDict()

	if uv1[slot0] then
		return uv1[slot0]()
	end

	for slot4, slot5 in ipairs(uv2) do
		if slot5[slot0] then
			uv1[slot0] = slot5[slot0]

			return uv1[slot0]()
		end
	end
end

function slot0._firstInitProtoDict()
	if not uv0 then
		uv0 = {}

		for slot3, slot4 in pairs(moduleNameToPath) do
			if string.find(slot3, "_pb") then
				if not moduleNameToTables[slot3] then
					callWithCatch(function ()
						slot0 = _G[uv0]
					end)
				end

				table.insert(uv0, moduleNameToTables[slot3])
			end
		end
	end
end

function slot0.buildValueMOsByStructName(slot0)
	slot1 = {}

	for slot8, slot9 in ipairs(getmetatable(uv0.buildProtoByStructName(slot0))._descriptor.fields) do
		slot11 = ProtoTestCaseParamMO.New()

		slot11:initProto(nil, slot9, slot2._fields[slot9])
		table.insert(slot1, slot11)
	end

	return slot1
end

return slot0
