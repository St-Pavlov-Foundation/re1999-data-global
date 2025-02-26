module("modules.logic.prototest.model.ProtoModifyModel", package.seeall)

slot0 = class("ProtoModifyModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0._protoMO = nil
	slot0._depthParamMOs = {}
end

function slot0.getProtoMO(slot0)
	return slot0._protoMO
end

function slot0.getDepthParamMOs(slot0)
	return slot0._depthParamMOs
end

function slot0.getLastMO(slot0)
	if #slot0._depthParamMOs > 0 then
		return slot0._depthParamMOs[slot1]
	else
		return slot0._protoMO
	end
end

function slot0.enterProto(slot0, slot1)
	slot0._protoMO = slot1

	slot0:setList(slot1.value)
end

function slot0.enterParam(slot0, slot1)
	slot2 = nil
	slot2 = (#slot0._depthParamMOs <= 0 or slot0._depthParamMOs[#slot0._depthParamMOs].value[slot1]) and slot0._protoMO.value[slot1]

	table.insert(slot0._depthParamMOs, slot2)

	if slot2:isRepeated() or slot2:isProtoType() then
		slot0:setList(slot2.value)

		if slot2:isRepeated() then
			slot0:addAtLast({
				id = -99999
			})
		end
	end
end

function slot0.exitParam(slot0)
	slot1 = #slot0._depthParamMOs

	table.remove(slot0._depthParamMOs, slot1)

	if slot1 > 1 then
		slot2 = slot0._depthParamMOs[slot1 - 1]

		slot0:setList(slot2.value)

		if slot2:isRepeated() then
			slot0:addAtLast({
				id = -99999
			})
		end
	else
		slot0:setList(slot0._protoMO.value)
	end
end

function slot0.addRepeatedParam(slot0)
	if #slot0._depthParamMOs > 0 then
		if slot0._depthParamMOs[slot1]:isRepeated() then
			slot3 = ProtoTestCaseParamMO.New()
			slot3.id = #slot2.value + 1
			slot3.key = #slot2.value + 1
			slot3.pType = slot2.pType
			slot3.pLabel = ProtoEnum.LabelType.optional
			slot3.repeated = true
			slot3.struct = slot2.struct

			if slot3.struct then
				slot3.value = ProtoParamHelper.buildValueMOsByStructName(slot3.struct)
			end

			table.insert(slot2.value, slot3)
			slot0:addAt(slot3, slot3.id)
		else
			logError("can't remove param, not repeated")
		end
	else
		logError("cant't remove param, not at root")
	end
end

function slot0.removeRepeatedParam(slot0, slot1)
	if #slot0._depthParamMOs > 0 then
		if slot0._depthParamMOs[slot2]:isRepeated() then
			table.remove(slot3.value, slot1)
			slot0:removeAt(slot1)

			for slot7, slot8 in ipairs(slot3.value) do
				slot8.id = slot7
				slot8.key = slot7
			end
		else
			logError("can't remove param, not repeated")
		end
	else
		logError("cant't remove param, not at root")
	end
end

function slot0.isRoot(slot0)
	return #slot0._depthParamMOs == 0
end

slot0.instance = slot0.New()

return slot0
