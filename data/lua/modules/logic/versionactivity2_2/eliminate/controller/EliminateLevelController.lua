module("modules.logic.versionactivity2_2.eliminate.controller.EliminateLevelController", package.seeall)

local var_0_0 = class("EliminateLevelController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._canClickCharacter = true
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.enterLevel(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_1 = arg_4_1 or 222101
	arg_4_2 = arg_4_2 or 222002
	arg_4_3 = arg_4_3 or {
		222001,
		222002,
		222003,
		222004,
		22101,
		22102
	}

	EliminateLevelModel.instance:initLevel(arg_4_1, arg_4_2, arg_4_3)
	EliminateRpc.instance:sendStartMatch3WarChessInfoRequest(arg_4_1, arg_4_2, arg_4_3, arg_4_0.openEliminateView, arg_4_0)
end

function var_0_0.closeLevel(arg_5_0)
	var_0_0.instance:clear()
	ViewMgr.instance:closeView(ViewName.EliminateLevelRewardView)
	ViewMgr.instance:closeView(ViewName.EliminateLevelResultView)
	ViewMgr.instance:closeView(ViewName.EliminateEffectView)
	ViewMgr.instance:closeView(ViewName.EliminateLevelView)
	arg_5_0:_gc()
end

function var_0_0._gc(arg_6_0)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, arg_6_0)
end

function var_0_0.openEliminateResultView(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = EliminateTeamChessModel.instance:getWarFightResult()

	TeamChessUnitEntityMgr.instance:setAllEntityCanClick(false)
	TeamChessUnitEntityMgr.instance:setAllEntityCanDrag(false)

	if var_7_0 and var_7_0:haveReward() then
		ViewMgr.instance:openView(ViewName.EliminateLevelRewardView, arg_7_1, arg_7_2)
	else
		ViewMgr.instance:openView(ViewName.EliminateLevelResultView, arg_7_1, arg_7_2)
	end
end

function var_0_0.openEliminateView(arg_8_0, arg_8_1, arg_8_2)
	if EliminateTeamChessModel.instance:getCurTeamChessWar() == nil then
		return
	end

	arg_8_0._dialogData = EliminateConfig.instance:getEliminateDialogConfig(EliminateLevelModel.instance:getLevelId())

	arg_8_0:clearTrigger()
	arg_8_0:registerCallback(EliminateChessEvent.Match3RoundBegin, arg_8_0.checkLevelDialogMatchRound, arg_8_0)
	arg_8_0:registerCallback(EliminateChessEvent.TeamChessRoundBegin, arg_8_0.checkLevelDialogTeamChessRound, arg_8_0)
	arg_8_0:registerCallback(EliminateChessEvent.TeamChessEnemyPlaceBefore, arg_8_0.checkLevelDialogTeamChessEnemyPlaceBefore, arg_8_0)
	arg_8_0:registerCallback(EliminateChessEvent.SettleAndToHaveDamage, arg_8_0.checkLevelSettleAndHaveDamage, arg_8_0)
	ViewMgr.instance:openView(ViewName.EliminateLevelView, arg_8_1, arg_8_2)
	ViewMgr.instance:openView(ViewName.EliminateEffectView)
end

function var_0_0.changeRoundType(arg_9_0, arg_9_1)
	local var_9_0 = EliminateLevelModel.instance:getCurRoundType()

	if arg_9_1 and var_9_0 and arg_9_1 == var_9_0 then
		arg_9_0:dispatchEvent(EliminateChessEvent.EliminateRoundStateChange, false)

		return
	end

	if arg_9_1 == EliminateEnum.RoundType.Match3Chess then
		EliminateLevelModel.instance:setNeedChangeTeamToEliminate(false)
	elseif EliminateTeamChessModel.instance:getCurTeamRoundStepState() ~= EliminateTeamChessEnum.TeamChessRoundType.enemy then
		EliminateTeamChessModel.instance:setCurTeamRoundStepState(EliminateTeamChessEnum.TeamChessRoundType.player)
	end

	EliminateLevelModel.instance:setCurRoundType(arg_9_1)
	arg_9_0:dispatchEvent(EliminateChessEvent.EliminateRoundStateChange, true)
end

function var_0_0.checkState(arg_10_0)
	local var_10_0 = EliminateTeamChessModel.instance:getCurTeamRoundStepState()
	local var_10_1 = EliminateLevelModel.instance:getRoundNumber()
	local var_10_2 = false
	local var_10_3 = false

	if var_10_0 and var_10_0 ~= EliminateTeamChessEnum.TeamChessRoundType.settlement then
		if var_10_0 == EliminateTeamChessEnum.TeamChessRoundType.enemy then
			EliminateTeamChessModel.instance:setCurTeamRoundStepState(EliminateTeamChessEnum.TeamChessRoundType.player)

			if var_10_1 == 1 then
				var_10_2 = true
			end
		end
	else
		var_10_3 = EliminateLevelModel.instance:getNeedChangeTeamToEliminate()
		var_10_2 = var_10_3
	end

	if var_10_2 then
		if var_10_3 then
			EliminateChessController.instance:sendGetMatch3WarChessInfoRequest(EliminateEnum.GetInfoType.OnlyMovePint, function()
				arg_10_0:changeRoundType(EliminateEnum.RoundType.Match3Chess)
			end)
		else
			arg_10_0:changeRoundType(EliminateEnum.RoundType.Match3Chess)
		end
	end
end

function var_0_0.changeRoundToTeamChess(arg_12_0)
	WarChessRpc.instance:sendWarChessMyRoundStartRequest(arg_12_0.changeRoundToTeamChessBegin, arg_12_0)
end

function var_0_0.changeRoundToTeamChessBegin(arg_13_0)
	arg_13_0:changeRoundType(EliminateEnum.RoundType.TeamChess)
end

function var_0_0.cancelSkillRelease(arg_14_0)
	if arg_14_0._selectSkillMo ~= nil then
		arg_14_0._selectSkillMo:cancelRelease()
	end

	arg_14_0._selectSkillMo = nil
	arg_14_0._releaseSkillCb = nil
	arg_14_0._releaseSkillCbTarget = nil
end

function var_0_0.canRelease(arg_15_0)
	if arg_15_0._selectSkillMo ~= nil then
		return arg_15_0._selectSkillMo:canRelease()
	end

	return false
end

function var_0_0.canReleaseByRound(arg_16_0, arg_16_1)
	arg_16_1 = arg_16_1 or arg_16_0._selectSkillMo

	if arg_16_1 == nil then
		return false
	end

	return EliminateLevelModel.instance:getCurRoundType() == arg_16_1:getEffectRound()
end

function var_0_0.setSkillDataParams(arg_17_0, ...)
	if arg_17_0._selectSkillMo ~= nil then
		arg_17_0._selectSkillMo:setSkillParam(...)
	end
end

function var_0_0.setCurSelectSkill(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0._selectSkillMo == nil then
		local var_18_0 = string.split(arg_18_2, "#")[1]

		arg_18_0._selectSkillMo = CharacterSkillMoUtil.createMO(var_18_0)

		arg_18_0._selectSkillMo:init(arg_18_1)
	end

	return arg_18_0._selectSkillMo
end

function var_0_0.getTempSkillMo(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_0._tempSkillMo == nil then
		local var_19_0 = string.split(arg_19_2, "#")[1]

		arg_19_0._tempSkillMo = CharacterSkillMoUtil.createMO(var_19_0)

		arg_19_0._tempSkillMo:init(arg_19_1)
	end

	return arg_19_0._tempSkillMo
end

function var_0_0.getCurSelectSkill(arg_20_0)
	return arg_20_0._selectSkillMo
end

function var_0_0.releaseSkill(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0._selectSkillMo ~= nil then
		arg_21_0._selectSkillMo:playAction(arg_21_0._releaseSkill, arg_21_0)

		arg_21_0._releaseSkillCb = arg_21_1
		arg_21_0._releaseSkillCbTarget = arg_21_2
	end
end

function var_0_0._releaseSkill(arg_22_0)
	if arg_22_0._selectSkillMo == nil then
		return
	end

	if arg_22_0._selectSkillMo:getEffectRound() == EliminateEnum.RoundType.Match3Chess then
		EliminateChessController.instance:dispatchEvent(EliminateChessEvent.PerformBegin)
		EliminateChessController.instance:setFlowEndState(false)
	end

	EliminateLevelModel.instance:addMainUseSkillNum()
	WarChessRpc.instance:sendWarChessCharacterSkillRequest(arg_22_0._selectSkillMo._skillId, arg_22_0._selectSkillMo:getReleaseParam(), EliminateEnum.RoundType.Match3Chess, arg_22_0.onReceiveWarChessCharacterSkillSuccess, arg_22_0)
end

function var_0_0.onReceiveWarChessCharacterSkillSuccess(arg_23_0)
	local var_23_0 = arg_23_0._selectSkillMo:getEffectRound() == EliminateEnum.RoundType.Match3Chess

	if arg_23_0._releaseSkillCbTarget and arg_23_0._releaseSkillCb then
		arg_23_0._releaseSkillCb(arg_23_0._releaseSkillCbTarget)
	end

	arg_23_0:dispatchEvent(EliminateChessEvent.WarChessCharacterSkillSuccess)

	if var_23_0 then
		EliminateChessController.instance:setFlowEndState(true)
	end
end

function var_0_0.getCurLevelNeedPreloadRes(arg_24_0)
	local var_24_0 = {}
	local var_24_1 = EliminateLevelModel.instance:getCurLevelPieceIds()

	if var_24_1 then
		for iter_24_0 = 1, #var_24_1 do
			local var_24_2 = var_24_1[iter_24_0]
			local var_24_3 = EliminateConfig.instance:getSoldierChessModelPath(var_24_2)

			if var_24_3 then
				table.insert(var_24_0, var_24_3)
			end
		end
	end

	for iter_24_1, iter_24_2 in pairs(EliminateTeamChessEnum.VxEffectTypeToPath) do
		table.insert(var_24_0, iter_24_2)
	end

	return var_24_0
end

function var_0_0.checkLevelDialogMatchRound(arg_25_0, arg_25_1)
	arg_25_0:_checkLevelDialog(EliminateEnum.ConditionType.MatchRoundBegin, arg_25_1)
end

function var_0_0.checkLevelDialogTeamChessRound(arg_26_0, arg_26_1)
	arg_26_0:_checkLevelDialog(EliminateEnum.ConditionType.TeamChessRoundBegin, arg_26_1)
end

function var_0_0.checkLevelDialogTeamChessEnemyPlaceBefore(arg_27_0, arg_27_1)
	arg_27_0:_checkLevelDialog(EliminateEnum.ConditionType.TeamChessEnemyPlaceBefore, arg_27_1)
end

function var_0_0.checkLevelSettleAndHaveDamage(arg_28_0, arg_28_1)
	arg_28_0:_checkLevelDialog(EliminateEnum.ConditionType.SettleAndToHaveDamage, arg_28_1)
end

function var_0_0.clickMainCharacter(arg_29_0)
	if not arg_29_0._canClickCharacter then
		return
	end

	arg_29_0:_checkLevelDialog(EliminateEnum.ConditionType.ClickMainCharacter)
end

function var_0_0._checkLevelDialog(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0
	local var_30_1 = false
	local var_30_2 = ""

	arg_30_0._lastConditionType = arg_30_1

	local var_30_3 = ""

	if arg_30_1 == EliminateEnum.ConditionType.MatchRoundBegin or arg_30_1 == EliminateEnum.ConditionType.TeamChessRoundBegin then
		local var_30_4 = string.split(arg_30_2, "_")

		var_30_3 = #var_30_4 >= 2 and var_30_4[2] or nil
	else
		var_30_3 = arg_30_2
	end

	if arg_30_0._dialogData ~= nil and tabletool.len(arg_30_0._dialogData) > 0 then
		local var_30_5 = EliminateLevelModel.instance:getWarChessCharacterId()

		for iter_30_0, iter_30_1 in ipairs(arg_30_0._dialogData) do
			var_30_2 = iter_30_1.trigger

			local var_30_6 = string.split(var_30_2, "#")

			if arg_30_1 == var_30_6[1] then
				local var_30_7
				local var_30_8

				if arg_30_1 == EliminateEnum.ConditionType.MatchRoundBegin or arg_30_1 == EliminateEnum.ConditionType.TeamChessRoundBegin or arg_30_1 == EliminateEnum.ConditionType.SettleAndToHaveDamage then
					var_30_7 = tonumber(var_30_6[3])
					var_30_8 = var_30_6[2]
				else
					var_30_7 = tonumber(var_30_6[2])
				end

				if var_30_7 == -1 and var_30_8 == nil or var_30_7 == var_30_5 and var_30_8 == var_30_3 then
					local var_30_9 = iter_30_1.dialogId
					local var_30_10 = #var_30_9

					var_30_1 = iter_30_1.auto == 1
					var_30_0 = var_30_9[var_30_10]

					if var_30_10 > 1 then
						var_30_0 = var_30_9[math.random(1, var_30_10)]
					end

					break
				end
			end
		end
	end

	if var_30_0 ~= nil and arg_30_1 ~= EliminateEnum.ConditionType.ClickMainCharacter and arg_30_0:isTrigger(var_30_2) then
		var_30_0 = nil
	end

	if var_30_0 ~= nil then
		TipDialogController.instance:openTipDialogView(var_30_0, arg_30_0._levelDialogClose, arg_30_0, var_30_1, var_30_1 and EliminateConfig.instance:getConstValue(35) / 1000 or nil, var_30_1 and EliminateConfig.instance:getConstValue(34) / 100 or nil)
		arg_30_0:setTrigger(var_30_2)
	else
		arg_30_0:_levelDialogClose()
	end
end

function var_0_0.setTrigger(arg_31_0, arg_31_1)
	if arg_31_0.trigger == nil then
		arg_31_0.trigger = {}
	end

	arg_31_0.trigger[arg_31_1] = arg_31_1
end

function var_0_0.clearTrigger(arg_32_0)
	arg_32_0.trigger = nil
end

function var_0_0.isTrigger(arg_33_0, arg_33_1)
	return arg_33_0.trigger ~= nil and arg_33_0.trigger[arg_33_1] ~= nil
end

function var_0_0._levelDialogClose(arg_34_0)
	if arg_34_0._lastConditionType and arg_34_0._lastConditionType == EliminateEnum.ConditionType.TeamChessEnemyPlaceBefore then
		arg_34_0:dispatchEvent(EliminateChessEvent.LevelDialogClosed)
	end

	if arg_34_0._lastConditionType and arg_34_0._lastConditionType == EliminateEnum.ConditionType.ClickMainCharacter then
		arg_34_0._canClickCharacter = true
	end
end

function var_0_0.queryBgm()
	local var_35_0 = EliminateTeamSelectionModel.instance:getSelectedEpisodeId()

	if var_35_0 == nil then
		var_35_0 = EliminateLevelModel.instance:getLevelId()
	end

	local var_35_1 = EliminateConfig.instance:getEliminateEpisodeConfig(var_35_0)

	if var_35_1 then
		if var_35_1.levelPosition == EliminateLevelEnum.levelType.normal then
			return AudioBgmEnum.Layer.NormalBattleV2_2
		else
			return AudioBgmEnum.Layer.BossBattleV2_2
		end
	else
		return AudioBgmEnum.Layer.NormalBattleV2_2
	end
end

function var_0_0.BgSwitch(arg_36_0, arg_36_1)
	if arg_36_0.switchGroupId == nil then
		arg_36_0.switchGroupId = AudioMgr.instance:getIdFromString("Checkpointstate")
		arg_36_0.fightNormal = AudioMgr.instance:getIdFromString("Fightnormal")
		arg_36_0.victory = AudioMgr.instance:getIdFromString("Victory")
		arg_36_0.comeShow = AudioMgr.instance:getIdFromString("Comeshow")
	end

	if arg_36_1 == EliminateEnum.AudioFightStep.ComeShow then
		AudioMgr.instance:setSwitch(arg_36_0.switchGroupId, arg_36_0.comeShow)
	end

	if arg_36_1 == EliminateEnum.AudioFightStep.FightNormal then
		AudioMgr.instance:setSwitch(arg_36_0.switchGroupId, arg_36_0.fightNormal)
	end

	if arg_36_1 == EliminateEnum.AudioFightStep.Victory then
		AudioMgr.instance:setSwitch(arg_36_0.switchGroupId, arg_36_0.victory)
	end
end

function var_0_0.checkMainSkill(arg_37_0)
	local var_37_0 = EliminateTeamChessModel.instance:getCurTeamMyInfo()

	if var_37_0 then
		local var_37_1 = EliminateConfig.instance:getTeamChessCharacterConfig(var_37_0.id)

		if EliminateConfig.instance:getMainCharacterSkillConfig(var_37_1.activeSkillIds).cost <= var_37_0.power then
			local var_37_2 = EliminateLevelModel.instance:getLevelId()

			arg_37_0:dispatchEvent(EliminateChessEvent.TeamChessRoundBeginAndMainCharacterSkillCanUse, string.format("%s_%s", var_37_2, var_37_0.id))
		end
	end
end

function var_0_0.checkPlayerSoliderCount(arg_38_0)
	local var_38_0 = EliminateTeamChessModel.instance:getStrongholds()
	local var_38_1 = 0

	for iter_38_0, iter_38_1 in pairs(var_38_0) do
		var_38_1 = var_38_1 + iter_38_1:getPlayerSoliderCount()
	end

	if var_38_1 > 0 then
		local var_38_2 = EliminateLevelModel.instance:getLevelId()

		arg_38_0:dispatchEvent(EliminateChessEvent.TeamChessRoundBeginAndMainCharacterSkillCanUse, string.format("%s_%s", var_38_2, var_38_1))
	end
end

function var_0_0.updatePlayerExtraWinCondition(arg_39_0, arg_39_1)
	local var_39_0 = EliminateTeamChessModel.instance:getCurTeamChessWar()
	local var_39_1 = EliminateTeamChessModel.instance:getServerTeamChessWar()

	var_39_1:updateCondition(var_39_1.winCondition, arg_39_1)

	if var_39_0:updateCondition(var_39_0.winCondition, arg_39_1) then
		arg_39_0:dispatchEvent(EliminateChessEvent.LevelConditionChange)
	end
end

function var_0_0.clear(arg_40_0)
	arg_40_0:unregisterCallback(EliminateChessEvent.Match3RoundBegin, arg_40_0.checkLevelDialogMatchRound, arg_40_0)
	arg_40_0:unregisterCallback(EliminateChessEvent.TeamChessRoundBegin, arg_40_0.checkLevelDialogTeamChessRound, arg_40_0)
	arg_40_0:unregisterCallback(EliminateChessEvent.TeamChessEnemyPlaceBefore, arg_40_0.checkLevelDialogTeamChessEnemyPlaceBefore, arg_40_0)
	arg_40_0:unregisterCallback(EliminateChessEvent.SettleAndToHaveDamage, arg_40_0.checkLevelSettleAndHaveDamage, arg_40_0)
	EliminateTeamChessController.instance:clear()
	EliminateChessController.instance:clear()
	arg_40_0:cancelSkillRelease()

	arg_40_0._tempSkillMo = nil

	EliminateLevelModel.instance:clear()
	TeamChessEffectPool.dispose()
end

var_0_0.instance = var_0_0.New()

return var_0_0
