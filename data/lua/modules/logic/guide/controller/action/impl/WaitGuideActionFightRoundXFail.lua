module("modules.logic.guide.controller.action.impl.WaitGuideActionFightRoundXFail", package.seeall)

slot0 = class("WaitGuideActionFightRoundXFail", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._waveRoundDict = nil

	if #string.splitToNumber(slot0.actionParam, "#") > 2 then
		for slot6 = 1, #slot2, 2 do
			if slot2[slot6 + 1] then
				slot0._waveRoundDict = slot0._waveRoundDict or {}
				slot0._waveRoundDict[slot2[slot6] .. "#" .. slot2[slot6 + 1]] = true
			else
				logError(string.format("guide_%d_%d 等待战斗第m波次第n回合失败 配置错误 参数数量应为1或者偶数", slot0.guideId, slot0.stepId))
			end
		end
	elseif #slot2 == 2 then
		slot0._waveRoundDict = slot0._waveRoundDict or {}
		slot0._waveRoundDict[slot2[1] .. "#" .. slot2[2]] = true
	elseif #slot2 == 1 then
		slot0._waveRoundDict = slot0._waveRoundDict or {}
		slot0._waveRoundDict[1 .. "#" .. slot2[1]] = true
	end

	slot0._roundIdInWave = 0

	FightController.instance:registerCallback(FightEvent.OnBeginWave, slot0._onBeginWave, slot0)
	FightController.instance:registerCallback(FightEvent.RespBeginRound, slot0._onBeginRound, slot0)
	FightController.instance:registerCallback(FightEvent.OnStageChange, slot0._onStageChange, slot0)
end

function slot0._onBeginWave(slot0)
	slot0._roundIdInWave = 0
end

function slot0._onBeginRound(slot0)
	slot0._roundIdInWave = slot0._roundIdInWave + 1
end

function slot0._onStageChange(slot0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.EndRound and FightModel.instance:getRecordMO() and slot1.fightResult == FightEnum.FightResult.Fail then
		if not slot0._waveRoundDict or slot0._waveRoundDict[FightModel.instance:getCurWaveId() .. "#" .. slot0._roundIdInWave] then
			slot0:onDone(true)
		end
	end
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnBeginWave, slot0._onBeginWave, slot0)
	FightController.instance:unregisterCallback(FightEvent.RespBeginRound, slot0._onBeginRound, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnStageChange, slot0._onStageChange, slot0)
end

return slot0
