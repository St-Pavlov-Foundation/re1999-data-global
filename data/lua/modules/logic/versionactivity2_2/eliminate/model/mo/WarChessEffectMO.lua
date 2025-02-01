module("modules.logic.versionactivity2_2.eliminate.model.mo.WarChessEffectMO", package.seeall)

slot0 = class("WarChessEffectMO")

function slot0.init(slot0, slot1)
	slot0.effectType = slot1.effectType
	slot0.effectNum = slot1.effectNum
	slot0.targetId = slot1.targetId
	slot0.extraData = slot1.extraData
	slot0.chessPiece = slot1.chessPiece

	if slot1.nextFightStep then
		slot0.nextFightStep = WarChessStepMO.New()

		slot0.nextFightStep:init(slot1.nextFightStep)
	end
end

function slot0.buildStep(slot0, slot1)
	slot2 = {}

	if slot1.actionType == EliminateTeamChessEnum.StepActionType.chessSkill then
		slot0.reasonId = slot1.reasonId
	end

	if slot0.effectType == EliminateTeamChessEnum.StepWorkType.chessPowerChange then
		slot3 = {
			uid = slot0.targetId,
			effectType = EliminateTeamChessEnum.StepWorkType.teamChessShowVxEffect,
			vxEffectType = EliminateTeamChessEnum.VxEffectType.PowerDown
		}

		if tonumber(slot0.effectNum) < 0 then
			-- Nothing
		else
			slot3.vxEffectType = EliminateTeamChessEnum.VxEffectType.PowerUp
		end

		slot3.time = EliminateTeamChessEnum.VxEffectTypePlayTime[slot3.vxEffectType]

		if slot1.actionType == EliminateTeamChessEnum.StepActionType.chessSkill and slot1.reasonId ~= nil and EliminateTeamChessModel.instance.chessSkillIsGrowUp(tonumber(slot5)) then
			slot3.time = EliminateTeamChessEnum.teamChessGrowUpToChangePowerStepTime
		end

		slot2[#slot2 + 1] = EliminateTeamChessStepUtil.createStep(slot3)
	end

	if slot0.effectType ~= EliminateTeamChessEnum.StepWorkType.effectNestStruct then
		slot2[#slot2 + 1] = EliminateTeamChessStepUtil.createStep(slot0)
	end

	if slot0.nextFightStep ~= nil then
		return slot2, slot0.nextFightStep:buildSteps()
	end

	return slot2, nil
end

return slot0
