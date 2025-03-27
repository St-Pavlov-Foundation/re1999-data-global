module("modules.logic.versionactivity2_4.warmup.model.V2a4_WarmUpBattleWaveMO", package.seeall)

slot0 = class("V2a4_WarmUpBattleWaveMO")
slot1 = string.format
slot2 = table.insert

function slot0.ctor(slot0, slot1, slot2)
	slot0._index = slot1
	slot0._gachaMO = slot2
	slot0._isFinished = false
	slot0._isWin = false
	slot0._isPerfectWin = false
	slot0._curRound = 0
	slot0._roundMOList = {}
end

function slot0.genRound(slot0, slot1)
	if slot0._isFinished then
		return
	end

	slot3 = V2a4_WarmUpBattleRoundMO.New(slot0, slot0:roundCount() + 1, slot1)

	table.insert(slot0._roundMOList, slot3)

	return slot3
end

function slot0.index(slot0)
	return slot0._index
end

function slot0.type(slot0)
	return slot0._gachaMO:type()
end

function slot0.isRound_Text(slot0)
	return slot0:type() == V2a4_WarmUpEnum.AskType.Text
end

function slot0.isRound_Photo(slot0)
	return slot0:type() == V2a4_WarmUpEnum.AskType.Photo
end

function slot0.roundMOList(slot0)
	return slot0._roundMOList
end

function slot0.roundCount(slot0)
	return #slot0._roundMOList
end

function slot0.validRoundCount(slot0)
	for slot5, slot6 in ipairs(slot0._roundMOList) do
		if slot6:isFinished() then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.isLastRound(slot0)
	return slot0:roundCount() == slot0._curRound
end

function slot0.isFirstRound(slot0)
	return slot0._curRound == 1
end

function slot0.isWin(slot0)
	return slot0._isWin
end

function slot0.isPerfectWin(slot0)
	return slot0._isPerfectWin
end

function slot0.isFinished(slot0)
	return slot0._isFinished
end

function slot0.nextRound(slot0)
	if slot0._isFinished then
		return false
	end

	if slot0:roundCount() < slot0._curRound + 1 then
		slot0:_onFinish()

		return false
	end

	slot0._curRound = slot1

	return true
end

function slot0._onFinish(slot0)
	if slot0._isFinished then
		return
	end

	slot0._isFinished = true
	slot0._curRound = slot0:roundCount()

	for slot4, slot5 in ipairs(slot0._roundMOList) do
		slot0._isWin = slot5:isWin()

		if slot0._isWin then
			break
		end
	end

	for slot4, slot5 in ipairs(slot0._roundMOList) do
		slot0._isPerfectWin = slot5:isWin()

		if not slot0._isPerfectWin then
			break
		end
	end
end

function slot0.curRound(slot0)
	return slot0._roundMOList[slot0._curRound]
end

function slot0.winRoundCount(slot0)
	for slot5, slot6 in ipairs(slot0._roundMOList) do
		if slot6:isWin() then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.isFirstWave(slot0)
	return slot0._index == 1
end

function slot0.isAllAskYes(slot0)
	return slot0._gachaMO:isAllAskYes()
end

function slot0.s_type(slot0)
	for slot4, slot5 in pairs(V2a4_WarmUpEnum.AskType) do
		if slot0 == slot5 then
			return slot4
		end
	end

	return "[V2a4_WarmUpBattleWaveMO - s_type] error !"
end

function slot0.dump(slot0, slot1, slot2)
	slot3 = string.rep("\t", slot2 or 0)

	uv0(slot1, slot3 .. uv1("index = %s", slot0._index))
	uv0(slot1, slot3 .. uv1("isFinished = %s", slot0._isFinished))
	uv0(slot1, slot3 .. uv1("isWin = %s", slot0._isWin))
	uv0(slot1, slot3 .. uv1("type = %s", uv2.s_type(slot0:type())))
	uv0(slot1, slot3 .. uv1("Cur Round Index = %s --> ", slot0._curRound))
	uv0(slot1, slot3 .. "Rounds = {")

	for slot8 = 1, #slot0._roundMOList do
		slot4[slot8]:dump(slot1, slot2 + 1)
	end

	uv0(slot1, slot3 .. "}")
end

return slot0
