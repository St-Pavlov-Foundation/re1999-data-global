module("modules.logic.versionactivity2_2.eliminate.controller.EliminateLevelController", package.seeall)

slot0 = class("EliminateLevelController", BaseController)

function slot0.onInit(slot0)
	slot0._canClickCharacter = true
end

function slot0.reInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.enterLevel(slot0, slot1, slot2, slot3)
	slot1 = slot1 or 222101
	slot2 = slot2 or 222002
	slot3 = slot3 or {
		222001,
		222002,
		222003,
		222004,
		22101,
		22102
	}

	EliminateLevelModel.instance:initLevel(slot1, slot2, slot3)
	EliminateRpc.instance:sendStartMatch3WarChessInfoRequest(slot1, slot2, slot3, slot0.openEliminateView, slot0)
end

function slot0.closeLevel(slot0)
	uv0.instance:clear()
	ViewMgr.instance:closeView(ViewName.EliminateLevelRewardView)
	ViewMgr.instance:closeView(ViewName.EliminateLevelResultView)
	ViewMgr.instance:closeView(ViewName.EliminateEffectView)
	ViewMgr.instance:closeView(ViewName.EliminateLevelView)
	slot0:_gc()
end

function slot0._gc(slot0)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, slot0)
end

function slot0.openEliminateResultView(slot0, slot1, slot2)
	TeamChessUnitEntityMgr.instance:setAllEntityCanClick(false)
	TeamChessUnitEntityMgr.instance:setAllEntityCanDrag(false)

	if EliminateTeamChessModel.instance:getWarFightResult() and slot3:haveReward() then
		ViewMgr.instance:openView(ViewName.EliminateLevelRewardView, slot1, slot2)
	else
		ViewMgr.instance:openView(ViewName.EliminateLevelResultView, slot1, slot2)
	end
end

function slot0.openEliminateView(slot0, slot1, slot2)
	if EliminateTeamChessModel.instance:getCurTeamChessWar() == nil then
		return
	end

	slot0._dialogData = EliminateConfig.instance:getEliminateDialogConfig(EliminateLevelModel.instance:getLevelId())

	slot0:clearTrigger()
	slot0:registerCallback(EliminateChessEvent.Match3RoundBegin, slot0.checkLevelDialogMatchRound, slot0)
	slot0:registerCallback(EliminateChessEvent.TeamChessRoundBegin, slot0.checkLevelDialogTeamChessRound, slot0)
	slot0:registerCallback(EliminateChessEvent.TeamChessEnemyPlaceBefore, slot0.checkLevelDialogTeamChessEnemyPlaceBefore, slot0)
	slot0:registerCallback(EliminateChessEvent.SettleAndToHaveDamage, slot0.checkLevelSettleAndHaveDamage, slot0)
	ViewMgr.instance:openView(ViewName.EliminateLevelView, slot1, slot2)
	ViewMgr.instance:openView(ViewName.EliminateEffectView)
end

function slot0.changeRoundType(slot0, slot1)
	slot2 = EliminateLevelModel.instance:getCurRoundType()

	if slot1 and slot2 and slot1 == slot2 then
		slot0:dispatchEvent(EliminateChessEvent.EliminateRoundStateChange, false)

		return
	end

	if slot1 == EliminateEnum.RoundType.Match3Chess then
		EliminateLevelModel.instance:setNeedChangeTeamToEliminate(false)
	elseif EliminateTeamChessModel.instance:getCurTeamRoundStepState() ~= EliminateTeamChessEnum.TeamChessRoundType.enemy then
		EliminateTeamChessModel.instance:setCurTeamRoundStepState(EliminateTeamChessEnum.TeamChessRoundType.player)
	end

	EliminateLevelModel.instance:setCurRoundType(slot1)
	slot0:dispatchEvent(EliminateChessEvent.EliminateRoundStateChange, true)
end

function slot0.checkState(slot0)
	slot3 = false
	slot4 = false

	if EliminateTeamChessModel.instance:getCurTeamRoundStepState() and slot1 ~= EliminateTeamChessEnum.TeamChessRoundType.settlement then
		if slot1 == EliminateTeamChessEnum.TeamChessRoundType.enemy then
			EliminateTeamChessModel.instance:setCurTeamRoundStepState(EliminateTeamChessEnum.TeamChessRoundType.player)

			if EliminateLevelModel.instance:getRoundNumber() == 1 then
				slot3 = true
			end
		end
	else
		slot3 = EliminateLevelModel.instance:getNeedChangeTeamToEliminate()
	end

	if slot3 then
		if slot4 then
			EliminateChessController.instance:sendGetMatch3WarChessInfoRequest(EliminateEnum.GetInfoType.OnlyMovePint, function ()
				uv0:changeRoundType(EliminateEnum.RoundType.Match3Chess)
			end)
		else
			slot0:changeRoundType(EliminateEnum.RoundType.Match3Chess)
		end
	end
end

function slot0.changeRoundToTeamChess(slot0)
	WarChessRpc.instance:sendWarChessMyRoundStartRequest(slot0.changeRoundToTeamChessBegin, slot0)
end

function slot0.changeRoundToTeamChessBegin(slot0)
	slot0:changeRoundType(EliminateEnum.RoundType.TeamChess)
end

function slot0.cancelSkillRelease(slot0)
	if slot0._selectSkillMo ~= nil then
		slot0._selectSkillMo:cancelRelease()
	end

	slot0._selectSkillMo = nil
	slot0._releaseSkillCb = nil
	slot0._releaseSkillCbTarget = nil
end

function slot0.canRelease(slot0)
	if slot0._selectSkillMo ~= nil then
		return slot0._selectSkillMo:canRelease()
	end

	return false
end

function slot0.canReleaseByRound(slot0, slot1)
	if (slot1 or slot0._selectSkillMo) == nil then
		return false
	end

	return EliminateLevelModel.instance:getCurRoundType() == slot1:getEffectRound()
end

function slot0.setSkillDataParams(slot0, ...)
	if slot0._selectSkillMo ~= nil then
		slot0._selectSkillMo:setSkillParam(...)
	end
end

function slot0.setCurSelectSkill(slot0, slot1, slot2)
	if slot0._selectSkillMo == nil then
		slot0._selectSkillMo = CharacterSkillMoUtil.createMO(string.split(slot2, "#")[1])

		slot0._selectSkillMo:init(slot1)
	end

	return slot0._selectSkillMo
end

function slot0.getTempSkillMo(slot0, slot1, slot2)
	if slot0._tempSkillMo == nil then
		slot0._tempSkillMo = CharacterSkillMoUtil.createMO(string.split(slot2, "#")[1])

		slot0._tempSkillMo:init(slot1)
	end

	return slot0._tempSkillMo
end

function slot0.getCurSelectSkill(slot0)
	return slot0._selectSkillMo
end

function slot0.releaseSkill(slot0, slot1, slot2)
	if slot0._selectSkillMo ~= nil then
		slot0._selectSkillMo:playAction(slot0._releaseSkill, slot0)

		slot0._releaseSkillCb = slot1
		slot0._releaseSkillCbTarget = slot2
	end
end

function slot0._releaseSkill(slot0)
	if slot0._selectSkillMo == nil then
		return
	end

	if slot0._selectSkillMo:getEffectRound() == EliminateEnum.RoundType.Match3Chess then
		EliminateChessController.instance:dispatchEvent(EliminateChessEvent.PerformBegin)
		EliminateChessController.instance:setFlowEndState(false)
	end

	EliminateLevelModel.instance:addMainUseSkillNum()
	WarChessRpc.instance:sendWarChessCharacterSkillRequest(slot0._selectSkillMo._skillId, slot0._selectSkillMo:getReleaseParam(), EliminateEnum.RoundType.Match3Chess, slot0.onReceiveWarChessCharacterSkillSuccess, slot0)
end

function slot0.onReceiveWarChessCharacterSkillSuccess(slot0)
	slot1 = slot0._selectSkillMo:getEffectRound() == EliminateEnum.RoundType.Match3Chess

	if slot0._releaseSkillCbTarget and slot0._releaseSkillCb then
		slot0._releaseSkillCb(slot0._releaseSkillCbTarget)
	end

	slot0:dispatchEvent(EliminateChessEvent.WarChessCharacterSkillSuccess)

	if slot1 then
		EliminateChessController.instance:setFlowEndState(true)
	end
end

function slot0.getCurLevelNeedPreloadRes(slot0)
	slot1 = {}

	if EliminateLevelModel.instance:getCurLevelPieceIds() then
		for slot6 = 1, #slot2 do
			if EliminateConfig.instance:getSoldierChessModelPath(slot2[slot6]) then
				table.insert(slot1, slot8)
			end
		end
	end

	for slot6, slot7 in pairs(EliminateTeamChessEnum.VxEffectTypeToPath) do
		table.insert(slot1, slot7)
	end

	return slot1
end

function slot0.checkLevelDialogMatchRound(slot0, slot1)
	slot0:_checkLevelDialog(EliminateEnum.ConditionType.MatchRoundBegin, slot1)
end

function slot0.checkLevelDialogTeamChessRound(slot0, slot1)
	slot0:_checkLevelDialog(EliminateEnum.ConditionType.TeamChessRoundBegin, slot1)
end

function slot0.checkLevelDialogTeamChessEnemyPlaceBefore(slot0, slot1)
	slot0:_checkLevelDialog(EliminateEnum.ConditionType.TeamChessEnemyPlaceBefore, slot1)
end

function slot0.checkLevelSettleAndHaveDamage(slot0, slot1)
	slot0:_checkLevelDialog(EliminateEnum.ConditionType.SettleAndToHaveDamage, slot1)
end

function slot0.clickMainCharacter(slot0)
	if not slot0._canClickCharacter then
		return
	end

	slot0:_checkLevelDialog(EliminateEnum.ConditionType.ClickMainCharacter)
end

function slot0._checkLevelDialog(slot0, slot1, slot2)
	slot3 = nil
	slot4 = false
	slot5 = ""
	slot0._lastConditionType = slot1
	slot6 = ""
	slot6 = (slot1 == EliminateEnum.ConditionType.MatchRoundBegin or slot1 == EliminateEnum.ConditionType.TeamChessRoundBegin) and (#string.split(slot2, "_") >= 2 and slot7[2] or nil) or slot2

	if slot0._dialogData ~= nil and tabletool.len(slot0._dialogData) > 0 then
		slot7 = EliminateLevelModel.instance:getWarChessCharacterId()

		for slot11, slot12 in ipairs(slot0._dialogData) do
			if slot1 == string.split(slot12.trigger, "#")[1] then
				slot15, slot16 = nil

				if slot1 == EliminateEnum.ConditionType.MatchRoundBegin or slot1 == EliminateEnum.ConditionType.TeamChessRoundBegin or slot1 == EliminateEnum.ConditionType.SettleAndToHaveDamage then
					slot15 = tonumber(slot13[3])
					slot16 = slot13[2]
				else
					slot15 = tonumber(slot13[2])
				end

				if slot15 == -1 and slot16 == nil or slot15 == slot7 and slot16 == slot6 then
					slot18 = #slot12.dialogId
					slot4 = slot12.auto == 1
					slot3 = slot17[slot18]

					if slot18 > 1 then
						slot3 = slot17[math.random(1, slot18)]
					end

					break
				end
			end
		end
	end

	if slot3 ~= nil and slot1 ~= EliminateEnum.ConditionType.ClickMainCharacter and slot0:isTrigger(slot5) then
		slot3 = nil
	end

	if slot3 ~= nil then
		TipDialogController.instance:openTipDialogView(slot3, slot0._levelDialogClose, slot0, slot4, slot4 and EliminateConfig.instance:getConstValue(35) / 1000 or nil, slot4 and EliminateConfig.instance:getConstValue(34) / 100 or nil)
		slot0:setTrigger(slot5)
	else
		slot0:_levelDialogClose()
	end
end

function slot0.setTrigger(slot0, slot1)
	if slot0.trigger == nil then
		slot0.trigger = {}
	end

	slot0.trigger[slot1] = slot1
end

function slot0.clearTrigger(slot0)
	slot0.trigger = nil
end

function slot0.isTrigger(slot0, slot1)
	return slot0.trigger ~= nil and slot0.trigger[slot1] ~= nil
end

function slot0._levelDialogClose(slot0)
	if slot0._lastConditionType and slot0._lastConditionType == EliminateEnum.ConditionType.TeamChessEnemyPlaceBefore then
		slot0:dispatchEvent(EliminateChessEvent.LevelDialogClosed)
	end

	if slot0._lastConditionType and slot0._lastConditionType == EliminateEnum.ConditionType.ClickMainCharacter then
		slot0._canClickCharacter = true
	end
end

function slot0.queryBgm()
	if EliminateTeamSelectionModel.instance:getSelectedEpisodeId() == nil then
		slot0 = EliminateLevelModel.instance:getLevelId()
	end

	if EliminateConfig.instance:getEliminateEpisodeConfig(slot0) then
		if slot1.levelPosition == EliminateLevelEnum.levelType.normal then
			return AudioBgmEnum.Layer.NormalBattleV2_2
		else
			return AudioBgmEnum.Layer.BossBattleV2_2
		end
	else
		return AudioBgmEnum.Layer.NormalBattleV2_2
	end
end

function slot0.BgSwitch(slot0, slot1)
	if slot0.switchGroupId == nil then
		slot0.switchGroupId = AudioMgr.instance:getIdFromString("Checkpointstate")
		slot0.fightNormal = AudioMgr.instance:getIdFromString("Fightnormal")
		slot0.victory = AudioMgr.instance:getIdFromString("Victory")
		slot0.comeShow = AudioMgr.instance:getIdFromString("Comeshow")
	end

	if slot1 == EliminateEnum.AudioFightStep.ComeShow then
		AudioMgr.instance:setSwitch(slot0.switchGroupId, slot0.comeShow)
	end

	if slot1 == EliminateEnum.AudioFightStep.FightNormal then
		AudioMgr.instance:setSwitch(slot0.switchGroupId, slot0.fightNormal)
	end

	if slot1 == EliminateEnum.AudioFightStep.Victory then
		AudioMgr.instance:setSwitch(slot0.switchGroupId, slot0.victory)
	end
end

function slot0.checkMainSkill(slot0)
	if EliminateTeamChessModel.instance:getCurTeamMyInfo() and EliminateConfig.instance:getMainCharacterSkillConfig(EliminateConfig.instance:getTeamChessCharacterConfig(slot1.id).activeSkillIds).cost <= slot1.power then
		slot0:dispatchEvent(EliminateChessEvent.TeamChessRoundBeginAndMainCharacterSkillCanUse, string.format("%s_%s", EliminateLevelModel.instance:getLevelId(), slot1.id))
	end
end

function slot0.checkPlayerSoliderCount(slot0)
	for slot6, slot7 in pairs(EliminateTeamChessModel.instance:getStrongholds()) do
		slot2 = 0 + slot7:getPlayerSoliderCount()
	end

	if slot2 > 0 then
		slot0:dispatchEvent(EliminateChessEvent.TeamChessRoundBeginAndMainCharacterSkillCanUse, string.format("%s_%s", EliminateLevelModel.instance:getLevelId(), slot2))
	end
end

function slot0.updatePlayerExtraWinCondition(slot0, slot1)
	slot2 = EliminateTeamChessModel.instance:getCurTeamChessWar()
	slot3 = EliminateTeamChessModel.instance:getServerTeamChessWar()

	slot3:updateCondition(slot3.winCondition, slot1)

	if slot2:updateCondition(slot2.winCondition, slot1) then
		slot0:dispatchEvent(EliminateChessEvent.LevelConditionChange)
	end
end

function slot0.clear(slot0)
	slot0:unregisterCallback(EliminateChessEvent.Match3RoundBegin, slot0.checkLevelDialogMatchRound, slot0)
	slot0:unregisterCallback(EliminateChessEvent.TeamChessRoundBegin, slot0.checkLevelDialogTeamChessRound, slot0)
	slot0:unregisterCallback(EliminateChessEvent.TeamChessEnemyPlaceBefore, slot0.checkLevelDialogTeamChessEnemyPlaceBefore, slot0)
	slot0:unregisterCallback(EliminateChessEvent.SettleAndToHaveDamage, slot0.checkLevelSettleAndHaveDamage, slot0)
	EliminateTeamChessController.instance:clear()
	EliminateChessController.instance:clear()
	slot0:cancelSkillRelease()

	slot0._tempSkillMo = nil

	EliminateLevelModel.instance:clear()
	TeamChessEffectPool.dispose()
end

slot0.instance = slot0.New()

return slot0
