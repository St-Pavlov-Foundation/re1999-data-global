module("modules.logic.versionactivity2_4.warmup.model.V2a4_WarmUpGachaWaveMO", package.seeall)

slot0 = math.randomseed
slot1 = table.insert
slot2 = string.format
slot3 = class("V2a4_WarmUpGachaWaveMO")

function slot3.ctor(slot0, slot1, slot2)
	slot0._index = slot1
	slot0._type = slot2
	slot0._roundMOList = {}
end

function slot3._getYesOrNo(slot0)
	slot0.__rdSet = slot0.__rdSet or {}

	if (slot0.__curRdIdx or 0) < #(slot0.__rdIdxList or {}) then
		slot3, slot4 = slot0:_nextRandomYesNo()
		slot5 = 10

		while slot0.__rdSet[slot4] do
			if slot5 - 1 < 0 then
				logError("[V2a4_WarmUpGachaWaveMO - _getYesOrNo] stack overflow")

				break
			end

			slot3, slot4 = slot0:_nextRandomYesNo()
		end

		if slot0.__curRdIdx <= #slot1 then
			slot0.__rdSet[slot4] = true

			return slot3, slot4
		end

		slot0.__rdSet = {}
	end

	slot3 = V2a4_WarmUpConfig.instance:getYesAndNoMaxCount(slot0._type)

	if isDebugBuild then
		assert(slot3 > 0, uv0("unsupported V2a4_WarmUpEnum.AskType.xxx = %s", slot0._type))
	end

	for slot7 = #slot1 + 1, slot3 do
		uv1(slot1, slot7)
	end

	uv2(os.time())

	slot0.__rdIdxList = GameUtil.randomTable(slot1)
	slot0.__curRdIdx = 0
	slot4, slot5 = slot0:_nextRandomYesNo()
	slot0.__rdSet[slot5] = true

	return slot4, slot5
end

function slot3._nextRandomYesNo(slot0)
	slot0.__curRdIdx = slot1

	return slot0.__rdIdxList[slot0.__curRdIdx + 1] % 2 == 0, math.ceil(slot2 / 2)
end

function slot3.index(slot0)
	return slot0._index
end

function slot3.type(slot0)
	return slot0._type
end

function slot3.roundCount(slot0)
	return #slot0._roundMOList
end

function slot3.roundMOList(slot0)
	return slot0._roundMOList
end

function slot3.isAllAskYes(slot0)
	for slot5, slot6 in ipairs(slot0._roundMOList) do
		if slot6:ansIsYes() then
			slot1 = 0 + 1
		end
	end

	return slot1 > 0 and slot1 == slot0:roundCount()
end

function slot3.genRound(slot0, slot1)
	slot2, slot3 = slot0:_getYesOrNo()
	slot5 = V2a4_WarmUpGachaRoundMO.New(slot0, slot0:roundCount() + 1, slot1, slot2, slot3)

	uv0(slot0._roundMOList, slot5)

	return slot5
end

return slot3
