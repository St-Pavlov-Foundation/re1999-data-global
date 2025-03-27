module("modules.logic.versionactivity2_4.warmup.model.V2a4_WarmUpBattleModel", package.seeall)

slot0 = class("V2a4_WarmUpBattleModel", BaseModel)
slot1 = string.format
slot2 = table.insert

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._levelId = 0
	slot0._startTs = 0
	slot0._endTs = -1
	slot0._waveList = {}
end

function slot0.curWaveIndex(slot0)
	return #slot0._waveList
end

function slot0.curWave(slot0)
	return slot0._waveList[slot0:curWaveIndex()]
end

function slot0.curRound(slot0)
	if not slot0:curWave() then
		return nil, 
	end

	return slot1:curRound(), slot1
end

function slot0.curRoundIndex(slot0)
	if not slot0:curRound() then
		return 0
	end

	return slot1:index()
end

function slot0.genWave(slot0, slot1)
	slot3 = V2a4_WarmUpBattleWaveMO.New(slot0:curWaveIndex() + 1, slot1)

	for slot8, slot9 in ipairs(slot1:roundMOList()) do
		slot3:genRound(slot9)
	end

	uv0(slot0._waveList, slot3)

	return slot3
end

function slot0.clean(slot0)
	slot0._levelId = 0
	slot0._startTs = 0
	slot0._endTs = 0
	slot0._waveList = {}
end

function slot0.restart(slot0, slot1)
	slot0:clean()

	slot0._levelId = slot1
	slot0._startTs = ServerTime.now()
	slot0._endTs = slot0._startTs + V2a4_WarmUpConfig.instance:getDurationSec()
end

function slot0.levelId(slot0)
	return slot0._levelId
end

function slot0.isTimeout(slot0)
	return slot0._endTs < slot0._startTs or slot0._endTs <= ServerTime.now()
end

function slot0.getRemainTime(slot0)
	return slot0._endTs - ServerTime.now()
end

function slot0.isFirstWaveDone(slot0)
	if slot0:curWaveIndex() >= 2 then
		return true
	end

	if not slot0:curWave() then
		return false
	end

	return slot1:isFinished()
end

function slot0.getResultInfo(slot0)
	slot1 = false
	slot2 = 0
	slot3 = 0
	slot4 = 0
	slot5 = 0
	slot6 = 0
	slot7 = 0
	slot8 = slot0:isFirstWaveDone()

	for slot12, slot13 in ipairs(slot0._waveList) do
		slot15 = nil
		slot16 = 0

		for slot20, slot21 in ipairs(slot13:roundMOList()) do
			if slot21:isFinished() then
				if slot21:userAnsIsYes() then
					slot6 = slot6 + 1
				else
					slot7 = slot7 + 1
				end

				slot16 = slot16 + 1

				if slot21:isWin() then
					slot5 = slot5 + 1

					if slot15 == nil then
						slot15 = true
					end
				else
					slot15 = false
				end
			else
				slot15 = false
			end
		end

		if slot16 == #slot14 then
			slot2 = slot2 + 1
		end

		slot3 = slot3 + slot16

		if slot15 then
			slot1 = true
			slot4 = slot4 + 1
		end
	end

	if not slot8 then
		slot1 = false
	end

	return {
		isWin = slot1,
		isPerfectWin = slot1 and slot3 == slot5,
		sucHelpCnt = slot4,
		totValidWaveCnt = slot2,
		totValidRoundCnt = slot3,
		totBingoRoundCnt = slot5,
		totWrontRoundCnt = slot3 - slot5,
		totWaveCnt = slot0:curWaveIndex(),
		totAnsYesCnt = slot6,
		totAnsNoCnt = slot7
	}
end

function slot0.dump(slot0, slot1, slot2)
	slot3 = string.rep("\t", slot2 or 0)

	uv0(slot1, slot3 .. uv1("level = %s (%s)s", slot0._levelId, slot0:getRemainTime()))
	uv0(slot1, slot3 .. "Waves = {")

	for slot8 = #slot0._waveList, 1, -1 do
		slot4[slot8]:dump(slot1, slot2 + 1)
	end

	uv0(slot1, slot3 .. "}")
end

slot0.instance = slot0.New()

return slot0
