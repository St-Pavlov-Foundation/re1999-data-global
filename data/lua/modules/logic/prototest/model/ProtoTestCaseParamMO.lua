module("modules.logic.prototest.model.ProtoTestCaseParamMO", package.seeall)

slot0 = pureTable("ProtoTestCaseParamMO")

function slot0.initProto(slot0, slot1, slot2, slot3)
	slot0.key = slot2.name
	slot0.value = slot3
	slot0.id = slot2.number
	slot0.pType = slot2.type
	slot0.pLabel = slot2.label
	slot0.repeated = false

	if slot0:isRepeated() then
		slot0.value = ProtoParamHelper.buildRepeatedParamsByProto(slot3 or {}, slot0)

		if slot2.message_type then
			slot0.struct = slot2.message_type.name
		end
	elseif slot0:isProtoType() then
		if slot3 then
			slot0.struct = getmetatable(slot3)._descriptor.name
			slot0.value = ProtoParamHelper.buildProtoParamsByProto(slot3, slot0)
		else
			slot0.struct = slot2.message_type.name
			slot0.value = ProtoParamHelper.buildProtoParamsByProto(ProtoParamHelper.buildProtoByStructName(slot0.struct), slot0)
		end
	end
end

function slot0.initProtoRepeated(slot0, slot1, slot2, slot3)
	slot0.key = slot2
	slot0.value = slot3
	slot0.id = slot2
	slot0.pType = slot1.pType
	slot0.pLabel = ProtoEnum.LabelType.optional
	slot0.repeated = true

	if slot0:isProtoType() then
		slot0.struct = getmetatable(slot3)._descriptor.name
		slot0.value = ProtoParamHelper.buildProtoParamsByProto(slot3, slot0)
	end
end

function slot0.isProtoType(slot0)
	return slot0.pType == ProtoEnum.ParamType.proto
end

function slot0.isOptional(slot0)
	return slot0.pLabel == ProtoEnum.LabelType.optional
end

function slot0.isRepeated(slot0)
	return slot0.pLabel == ProtoEnum.LabelType.repeated
end

function slot0.getParamDescLine(slot0)
	if slot0:isRepeated() then
		slot1 = {}

		for slot5, slot6 in ipairs(slot0.value) do
			table.insert(slot1, slot6:getParamDescLine())
		end

		return string.format("%s:{%s}", slot0.key, table.concat(slot1, ","))
	elseif slot0:isProtoType() then
		slot1 = {}

		if slot0.value then
			for slot5, slot6 in ipairs(slot0.value) do
				table.insert(slot1, slot6:getParamDescLine())
			end
		end

		if slot0.repeated then
			return string.format("{%s}", table.concat(slot1, ","))
		else
			return string.format("%s:{%s}", slot0.key, table.concat(slot1, ","))
		end
	elseif slot0.repeated then
		return cjson.encode(slot0.value)
	else
		return string.format("%s:%s", slot0.key, slot0.value)
	end
end

function slot0.clone(slot0)
	slot1 = uv0.New()
	slot1.key = slot0.key
	slot1.value = slot0.value
	slot1.id = slot0.id
	slot1.pType = slot0.pType
	slot1.pLabel = slot0.pLabel
	slot1.struct = slot0.struct
	slot1.repeated = slot0.repeated

	if slot0:isRepeated() then
		slot1.value = {}

		for slot5, slot6 in ipairs(slot0.value) do
			table.insert(slot1.value, slot6:clone())
		end
	elseif slot0:isProtoType() then
		slot1.value = {}

		for slot5, slot6 in ipairs(slot0.value) do
			table.insert(slot1.value, slot6:clone())
		end
	end

	return slot1
end

function slot0.fillProtoMsg(slot0, slot1)
	if not slot0.value then
		return
	end

	if slot0:isRepeated() then
		for slot5, slot6 in ipairs(slot0.value) do
			slot6:fillProtoMsg(slot1[slot0.key])
		end
	elseif slot0:isProtoType() then
		if slot0.repeated then
			slot2 = ProtoParamHelper.buildProtoByStructName(slot0.struct)

			for slot6, slot7 in ipairs(slot0.value) do
				slot7:fillProtoMsg(slot2)
			end

			table.insert(slot1, slot2)
		else
			for slot5, slot6 in ipairs(slot0.value) do
				slot6:fillProtoMsg(slot1[slot0.key])
			end
		end
	elseif slot0.repeated then
		table.insert(slot1, slot0.value)
	else
		if not slot1 then
			logError(slot0.key)
		end

		slot1[slot0.key] = slot0.value
	end
end

function slot0.serialize(slot0)
	if slot0:isRepeated() or slot0:isProtoType() then
		for slot5, slot6 in ipairs(slot0.value) do
			table.insert(slot1.value, slot6:serialize())
		end
	end

	return {
		key = slot0.key,
		value = slot0.value,
		id = slot0.id,
		pType = slot0.pType,
		pLabel = slot0.pLabel,
		repeated = slot0.repeated,
		struct = slot0.struct,
		value = {}
	}
end

function slot0.deserialize(slot0, slot1)
	slot0.key = slot1.key
	slot0.value = slot1.value
	slot0.id = slot1.id
	slot0.pType = slot1.pType
	slot0.pLabel = slot1.pLabel
	slot0.repeated = slot1.repeated
	slot0.struct = slot1.struct

	if slot0:isRepeated() or slot0:isProtoType() then
		slot0.value = {}

		for slot5, slot6 in ipairs(slot1.value) do
			slot7 = uv0.New()

			slot7:deserialize(slot6)
			table.insert(slot0.value, slot7)
		end
	end
end

return slot0
