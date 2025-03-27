module("modules.logic.common.model.SimpleRandomModel", package.seeall)

slot0 = class("SimpleRandomModel", BaseModel)
slot1 = math.random
slot2 = math.randomseed
slot3 = table.insert
slot4 = string.format

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._rdHashSet = {}
end

function slot0.getListIdxAndItemIdx(slot0, slot1)
	if isDebugBuild then
		assert(#slot1 > 0)
	end

	slot2 = nil

	for slot7, slot8 in ipairs(slot1) do
		slot3 = 0 + #slot8

		if slot7 == 1 then
			slot0._rdHashSet[slot8] = slot0._rdHashSet[slot8] or {}
			slot2 = slot0._rdHashSet[slot8]
		else
			slot2[slot8] = slot2[slot8] or {}
			slot2 = slot2[slot8]
		end
	end

	if isDebugBuild then
		assert(type(slot2) == "table", "never happen")
		assert(slot3 > 0, "empty reqLists")
	end

	slot6 = slot2.rdIdx2RealIdxPairDict or {}

	if (slot2.curRdIdx or 0) < #(slot2.rdIdxList or {}) then
		slot4 = slot4 + 1
		slot2.curRdIdx = slot4
		slot7 = slot2.rdIdx2RealIdxPairDict[slot4]

		return slot7.whichList, slot7.whichItem
	end

	for slot10 = #slot5 + 1, slot3 do
		uv0(slot5, slot10)
		uv0(slot6, {})
	end

	slot4 = 1

	uv1(os.time())

	slot5 = GameUtil.randomTable(slot5)
	slot7 = {
		[0] = 0
	}

	for slot11, slot12 in ipairs(slot1) do
		slot7[slot11] = slot7[slot11 - 1] + #slot12
	end

	for slot11, slot12 in ipairs(slot5) do
		slot13 = slot6[slot11]

		for slot17 = 1, #slot7 do
			if slot12 <= slot7[slot17] then
				slot13.whichList = slot17
				slot13.whichItem = slot12 - slot7[slot17 - 1]

				break
			end
		end
	end

	slot2.rdIdxList = slot5
	slot2.curRdIdx = slot4
	slot2.rdIdx2RealIdxPairDict = slot6
	slot8 = slot2.rdIdx2RealIdxPairDict[slot4]

	return slot8.whichList, slot8.whichItem
end

function slot0.getRateIndex(slot0, slot1)
	uv0(os.time())

	slot2 = 0

	for slot7, slot8 in ipairs(slot1) do
		if slot8 > 0 then
			slot3 = 0 + slot8
		end
	end

	slot4 = uv1(1, slot3)

	for slot8, slot9 in ipairs(slot1) do
		if slot9 > 0 then
			if slot4 <= slot9 then
				return slot2 + 1
			end

			slot4 = slot4 - slot9
		end
	end

	if isDebugBuild and false then
		slot5 = {}

		uv2("[SimpleRandomModel - getRateIndex] =========== begin")
		uv2("tot: " .. slot3)
		uv2("result index: " .. slot2)

		for slot9, slot10 in ipairs(slot1) do
			uv2(uv3("\t[%s]: %s", slot9, slot10))
		end

		uv2("[SimpleRandomModel - getRateIndex] =========== end")
		logError(table.concat(slot5, "\n"))
	end

	return slot2
end

function slot0.clean(slot0, slot1)
	for slot6, slot7 in ipairs(slot1 or {}) do
		if nil == nil then
			slot2 = slot0._rdHashSet[slot7]
			slot0._rdHashSet[slot7] = nil
		else
			slot2[slot7] = nil

			if not slot2[slot7] then
				break
			end
		end
	end
end

slot0.instance = slot0.New()

return slot0
