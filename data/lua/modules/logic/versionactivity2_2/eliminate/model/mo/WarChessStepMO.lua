module("modules.logic.versionactivity2_2.eliminate.model.mo.WarChessStepMO", package.seeall)

slot0 = class("WarChessStepMO")

function slot0.init(slot0, slot1)
	slot0.actionType = slot1.actionType
	slot0.reasonId = slot1.reasonId
	slot0.fromId = slot1.fromId
	slot0.toId = slot1.toId

	if slot1.effect then
		slot0.effect = GameUtil.rpcInfosToList(slot1.effect, WarChessEffectMO)
	end
end

slot1 = {}

function slot0.buildSteps(slot0)
	slot1 = {}
	slot2 = FlowParallel.New()
	slot3 = FlowParallel.New()

	if slot0.actionType == EliminateTeamChessEnum.StepActionType.chessSkill and not string.nilorempty(EliminateConfig.instance:getSoliderSkillConfig(slot0.reasonId).type) then
		tabletool.clear(uv0)

		uv0.uid = slot0.fromId
		uv0.effectType = EliminateTeamChessEnum.StepWorkType.teamChessShowVxEffect

		if slot4.type == EliminateTeamChessEnum.SoliderSkillType.Die then
			uv0.vxEffectType = EliminateTeamChessEnum.VxEffectType.WangYu
			uv0.time = EliminateTeamChessEnum.VxEffectTypePlayTime[uv0.vxEffectType]
		end

		if slot4.type == EliminateTeamChessEnum.SoliderSkillType.Raw or slot4.type == EliminateTeamChessEnum.SoliderSkillType.GrowUp then
			uv0.vxEffectType = EliminateTeamChessEnum.VxEffectType.ZhanHou
			uv0.time = EliminateTeamChessEnum.VxEffectTypePlayTime[uv0.vxEffectType]
		end

		if slot0.reasonId ~= nil and EliminateTeamChessModel.instance.chessSkillIsGrowUp(tonumber(slot5)) then
			uv0.time = EliminateTeamChessEnum.teamChessGrowUpZhanHouStepTime
		end

		slot1[#slot1 + 1] = EliminateTeamChessStepUtil.createStep(uv0)
	end

	slot4 = true

	for slot8 = 1, #slot0.effect do
		if slot0.effect[slot8].effectType == EliminateTeamChessEnum.StepWorkType.chessPowerChange then
			if slot0.actionType == EliminateTeamChessEnum.StepActionType.chessSkill or slot0.actionType == EliminateTeamChessEnum.StepActionType.strongHoldSkill then
				slot9.needShowDamage = true
			else
				slot9.needShowDamage = false
			end
		end

		if slot9.effectType == EliminateTeamChessEnum.StepWorkType.placeChess and tonumber(slot9.chessPiece.uid) < 0 and slot4 then
			slot1[#slot1 + 1] = EliminateTeamChessStepUtil.createStep(nil, EliminateTeamChessEnum.StepWorkType.teamChessUpdateForecast)
			slot4 = false
		end

		slot10, slot11 = slot9:buildStep(slot0)

		if slot9.effectType == EliminateTeamChessEnum.StepWorkType.chessPowerChange then
			for slot15, slot16 in ipairs(slot10) do
				slot2:addWork(slot16)
			end

			if #slot10 == #slot2:getWorkList() then
				slot1[#slot1 + 1] = slot2
			end
		elseif slot9.effectType == EliminateTeamChessEnum.StepWorkType.chessGrowUpChange then
			for slot15, slot16 in ipairs(slot10) do
				slot3:addWork(slot16)
			end

			if #slot10 == #slot3:getWorkList() then
				slot1[#slot1 + 1] = slot3
			end
		else
			for slot15, slot16 in ipairs(slot10) do
				slot1[#slot1 + 1] = slot16
			end
		end

		if slot11 then
			for slot15, slot16 in ipairs(slot11) do
				slot1[#slot1 + 1] = slot16
			end
		end
	end

	return slot1
end

return slot0
