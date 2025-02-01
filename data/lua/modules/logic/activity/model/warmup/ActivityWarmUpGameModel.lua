module("modules.logic.activity.model.warmup.ActivityWarmUpGameModel", package.seeall)

slot0 = class("ActivityWarmUpGameModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.release(slot0)
	slot0._settings = nil
	slot0._blockDatas = nil
	slot0._matDatas = nil
	slot0._bindMap = nil
	slot0._targetMatList = nil
	slot0.curMatIndex = 0
end

function slot0.init(slot0, slot1, slot2, slot3)
	slot0:release()

	slot0._settings = slot1

	if slot0:checkParamAvalid() then
		slot0._blockDatas = slot0:genLevelData()
	end

	if not slot3 then
		slot0.pointerVal = 0.5
	end

	slot0:initMatTarget(slot2)
	slot0:bindMaterials()
end

function slot0.initMatTarget(slot0, slot1)
	if #slot1 <= 0 then
		logError("totalPoolIds length can't be Zero!")

		return
	end

	slot0._matDatas = tabletool.copy(slot1)
	slot0._targetMatList = {}
	slot0.curMatIndex = 1
	slot2 = tabletool.copy(slot1)

	for slot6 = 1, slot0._settings.blockCount do
		if #slot2 <= 0 then
			for slot11, slot12 in pairs(slot1) do
				slot2[slot11] = slot12
			end

			slot7 = #slot2
		end

		slot8 = math.random(slot7)

		table.insert(slot0._targetMatList, slot2[slot8])
		table.remove(slot2, slot8)
	end
end

function slot0.bindMaterials(slot0)
	slot0._bindMap = {}
	slot1 = tabletool.copy(slot0._targetMatList)

	for slot5, slot6 in ipairs(slot0._blockDatas) do
		slot8 = math.random(#slot1)
		slot0._bindMap[slot6] = slot1[slot8]

		table.remove(slot1, slot8)
	end
end

function slot0.getBlockDataByPointer(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._blockDatas) do
		if slot6.startPos <= slot1 then
			if slot1 <= slot6.endPos then
				return slot6
			end
		else
			return nil
		end
	end
end

function slot0.isCurrentTarget(slot0, slot1)
	if slot0._bindMap[slot1] == slot0._targetMatList[slot0.curMatIndex] then
		return true
	end

	return false
end

function slot0.matIsUsed(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._targetMatList) do
		if slot0.curMatIndex <= slot5 then
			return false
		end

		if slot6 == slot1 then
			return true
		end
	end

	return false
end

function slot0.gotoNextTarget(slot0)
	slot0.curMatIndex = slot0.curMatIndex + 1
end

function slot0.isAllTargetClean(slot0)
	return slot0._settings.blockCount < slot0.curMatIndex
end

function slot0.getBlockDatas(slot0)
	return slot0._blockDatas
end

function slot0.getTargetMatIDs(slot0)
	return slot0._targetMatList
end

function slot0.getBindMatByBlock(slot0, slot1)
	return slot0._bindMap[slot1]
end

function slot0.getRoundInfo(slot0)
	if slot0._settings ~= nil then
		return slot0.round, slot0._settings.victoryRound
	end

	return nil
end

function slot0.genLevelData(slot0)
	slot2 = slot0:step2PickBasePos(slot0:step1BreakInterval())

	slot0:step3Grow(slot2)

	return slot2
end

function slot0.step1BreakInterval(slot0)
	slot3 = {}

	if math.floor(1 / (slot0._settings.minBlock + slot0._settings.blockInterval)) > 200 then
		logWarn("ActivityWarmUpGameModel data amount over 200!")
	end

	for slot7 = 1, slot2 do
		table.insert(slot3, (slot7 - 1) * slot1)
	end

	return slot3
end

function slot0.step2PickBasePos(slot0, slot1)
	slot3 = {}

	for slot7 = 1, slot0._settings.blockCount do
		slot8 = {
			startPos = slot1[slot9] + slot0._settings.blockInterval
		}

		table.remove(slot1, math.random(#slot1))

		slot8.endPos = slot8.startPos + slot0._settings.minBlock

		table.insert(slot3, slot8)
	end

	table.sort(slot3, uv0.sortBlockWithPos)

	return slot3
end

function slot0.step3Grow(slot0, slot1)
	for slot5 = #slot1, 1, -1 do
		slot0:growSingleBlock(slot1[slot5], slot1, slot5)
	end
end

function slot0.growSingleBlock(slot0, slot1, slot2, slot3)
	slot5 = 1

	if slot2[slot3 + 1] then
		slot5 = slot4.startPos - slot0._settings.blockInterval
	end

	slot6 = slot5 - slot1.endPos
	slot8 = math.random() * math.min(slot6, slot0._settings.randomLength)
	slot1.endPos = slot1.endPos + slot8

	if slot6 - slot8 > 0 and slot0._settings.stayProb <= math.random() then
		slot10 = slot6 * math.random()
		slot1.startPos = slot1.startPos + slot10
		slot1.endPos = slot1.endPos + slot10
	end
end

function slot0.sortBlockWithPos(slot0, slot1)
	return slot0.startPos < slot1.startPos
end

function slot0.checkParamAvalid(slot0)
	if (slot0._settings.minBlock + slot0._settings.blockInterval) * slot0._settings.blockCount >= 1 then
		logError("generate param error, min interval too large!")

		return false
	end

	return true
end

slot0.instance = slot0.New()

return slot0
