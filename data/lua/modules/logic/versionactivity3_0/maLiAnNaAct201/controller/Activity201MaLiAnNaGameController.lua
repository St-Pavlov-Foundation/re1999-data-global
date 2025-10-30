module("modules.logic.versionactivity3_0.maLiAnNaAct201.controller.Activity201MaLiAnNaGameController", package.seeall)

local var_0_0 = class("Activity201MaLiAnNaGameController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	if arg_2_0._actionList ~= nil then
		tabletool.clear(arg_2_0._actionList)
	end

	arg_2_0._isPause = true
	arg_2_0._dialogDataCache = {}
	arg_2_0._checkDialogList = {}
	arg_2_0._isOver = false
	arg_2_0._isTriggerBegin = false
	arg_2_0._isTriggerEnd = true
end

function var_0_0.enterGame(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:reInit()

	arg_3_0.episodeId = arg_3_2

	MaLiAnNaStatHelper.instance:enterEpisode(arg_3_2)
	Activity201MaLiAnNaGameModel.instance:initGameData(arg_3_1)
	MaliAnNaSoliderAiMgr.instance:initAiParamsById(arg_3_1)
	ViewMgr.instance:openView(ViewName.MaLiAnNaNoticeView)
	UpdateBeat:Remove(arg_3_0._update, arg_3_0)
	UpdateBeat:Add(arg_3_0._update, arg_3_0)

	arg_3_0._dialogData = Activity201MaLiAnNaConfig.instance:getLevelDialogConfig(arg_3_1)

	arg_3_0:registerCallback(Activity201MaLiAnNaEvent.SoliderDead, arg_3_0._checkSoliderDead, arg_3_0)
	arg_3_0:registerCallback(Activity201MaLiAnNaEvent.OnSelectActiveSkill, arg_3_0._checkUseSkillId, arg_3_0)
	arg_3_0:registerCallback(Activity201MaLiAnNaEvent.SlotChangeCamp, arg_3_0._checkSlotChangeCamp, arg_3_0)
	arg_3_0:registerCallback(Activity201MaLiAnNaEvent.GamePause, arg_3_0._setGamePause, arg_3_0)
	GuideController.instance:registerCallback(GuideEvent.OneKeyFinishGuides, arg_3_0._guideFinish, arg_3_0)
end

function var_0_0.restartGame(arg_4_0)
	MaLiAnNaStatHelper.instance:enterEpisode(arg_4_0.episodeId)
	arg_4_0:reInit()

	local var_4_0 = Activity201MaLiAnNaGameModel.instance:getCurGameId()

	Activity201MaLiAnNaGameModel.instance:clear()
	MaliAnNaSoliderEntityMgr.instance:clear()
	MaliAnNaSoliderAiMgr.instance:clear()
	arg_4_0:setPause(true)
	Activity201MaLiAnNaGameModel.instance:initGameData(var_4_0)
	arg_4_0:dispatchEvent(Activity201MaLiAnNaEvent.OnGameReStart)
	AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.stop_ui_lushang_offensive_loop)
end

function var_0_0.getCurEpisodeId(arg_5_0)
	return arg_5_0.episodeId
end

function var_0_0._setGamePause(arg_6_0, arg_6_1)
	local var_6_0 = tonumber(arg_6_1)

	arg_6_0:setPause(var_6_0 == 1)
end

function var_0_0.setPause(arg_7_0, arg_7_1)
	arg_7_0._isPause = arg_7_1

	if arg_7_1 then
		AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.stop_ui_lushang_offensive_loop)
		AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.stop_ui_lushang_warring_loop)

		arg_7_0._isTriggerBegin = false
	end
end

function var_0_0.getPause(arg_8_0)
	return arg_8_0._isPause
end

function var_0_0._update(arg_9_0)
	if arg_9_0._isPause then
		return
	end

	local var_9_0 = Time.deltaTime

	callWithCatch(arg_9_0._tryCatchUpdate, arg_9_0, var_9_0)
end

function var_0_0._tryCatchUpdate(arg_10_0, arg_10_1)
	if not arg_10_0._isOver then
		Activity201MaLiAnNaGameModel.instance:update(arg_10_1)
		arg_10_0:useAction()
		MaliAnNaSoliderAiMgr.instance:update(arg_10_1)
	end

	arg_10_0:dispatchEvent(Activity201MaLiAnNaEvent.OnRefreshView)
	arg_10_0:_tickDisPatch()

	if arg_10_0._isOver then
		arg_10_0:setPause(true)
	end
end

function var_0_0._tickDisPatch(arg_11_0)
	if arg_11_0._isPause then
		return
	end

	local var_11_0 = false
	local var_11_1 = false

	if arg_11_0._isTriggerBegin then
		var_11_0 = true
	end

	local var_11_2 = Activity201MaLiAnNaGameModel.instance:allDisPatchSolider()

	for iter_11_0, iter_11_1 in pairs(var_11_2) do
		if iter_11_1:getCamp() == Activity201MaLiAnNaEnum.CampType.Player then
			var_11_1 = true
			var_11_0 = false
		end
	end

	if var_11_1 and not arg_11_0._isTriggerBegin then
		AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_lushang_offensive_loop)

		arg_11_0._isTriggerBegin = true
	end

	if var_11_0 and arg_11_0._isTriggerBegin then
		AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.stop_ui_lushang_offensive_loop)

		arg_11_0._isTriggerBegin = false
	end
end

function var_0_0.dispatchSolider(arg_12_0, arg_12_1)
	if arg_12_1 == nil then
		logError("士兵实体为空, 无法派遣")

		return
	end

	MaliAnNaSoliderEntityMgr.instance:getEntity(arg_12_1)
	Activity201MaLiAnNaGameModel.instance:addDisPatchSolider(arg_12_1)
	arg_12_1:changeState(Activity201MaLiAnNaEnum.SoliderState.Moving)
end

function var_0_0.soliderEnterSlot(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == nil or arg_13_2 == nil then
		logError("士兵实体/据点ID为空, 无法进入据点")

		return
	end

	if arg_13_1:getCurState() == Activity201MaLiAnNaEnum.SoliderState.AttackSlot or arg_13_1:getCurState() == Activity201MaLiAnNaEnum.SoliderState.InSlot then
		return
	end

	local var_13_0 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_13_2)

	if var_13_0 then
		local var_13_1, var_13_2 = var_13_0:enterSoldier(arg_13_1)
		local var_13_3

		if var_13_1 then
			var_13_3 = arg_13_1:getCamp()

			arg_13_1:changeState(Activity201MaLiAnNaEnum.SoliderState.AttackSlot)

			if var_13_2 then
				var_13_2:updateHp(0, true)
			end
		end

		local var_13_4, var_13_5, var_13_6 = var_13_0:getSoliderCount()

		if var_13_3 and var_13_6 == 0 then
			var_13_0:createSolider(var_13_3)
		end
	end

	arg_13_1:changeRecordSoliderState(false)
end

function var_0_0.soliderBattle(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == nil or arg_14_2 == nil then
		return
	end

	if arg_14_1:getCurState() == Activity201MaLiAnNaEnum.SoliderState.Attack or arg_14_2:getCurState() == Activity201MaLiAnNaEnum.SoliderState.Attack then
		return
	end

	local var_14_0, var_14_1 = arg_14_1:getLocalPos()
	local var_14_2, var_14_3 = arg_14_2:getLocalPos()
	local var_14_4 = (var_14_0 + var_14_2) / 2
	local var_14_5 = (var_14_1 + var_14_3) / 2

	arg_14_0:dispatchEvent(Activity201MaLiAnNaEvent.OnShowBattleEffect, var_14_4, var_14_5, Activity201MaLiAnNaEnum.attackTime, true)
	AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_lushang_warring_loop)

	local var_14_6 = arg_14_1:getHp()
	local var_14_7 = arg_14_2:getHp()

	arg_14_1:updateHp(-var_14_7, false)
	arg_14_2:updateHp(-var_14_6, false)
	arg_14_1:changeState(Activity201MaLiAnNaEnum.SoliderState.Attack)
	arg_14_2:changeState(Activity201MaLiAnNaEnum.SoliderState.Attack)
end

function var_0_0.consumeSoliderHp(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == nil or arg_15_2 == nil then
		return
	end

	local var_15_0 = MaLiAnNaLaSoliderMoUtil.instance:getSoliderMoById(arg_15_1)

	if var_15_0 == nil then
		return
	end

	if var_15_0:getCurState() == Activity201MaLiAnNaEnum.SoliderState.Dead then
		return
	end

	local var_15_1, var_15_2 = var_15_0:getLocalPos()

	arg_15_0:dispatchEvent(Activity201MaLiAnNaEvent.OnShowBattleEffect, var_15_1, var_15_2, Activity201MaLiAnNaEnum.attackTime2, false)
	AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_youyu_attack_3)
	var_15_0:updateHp(arg_15_2, true)
end

function var_0_0.soliderDead(arg_16_0, arg_16_1)
	if arg_16_1 == nil then
		return
	end

	local var_16_0 = arg_16_1:getId()
	local var_16_1 = arg_16_1:isHero()

	MaliAnNaSoliderEntityMgr.instance:recycleEntity(arg_16_1)
	Activity201MaLiAnNaGameModel.instance:soliderDead(arg_16_1)
	arg_16_1:changeRecordSoliderState(false)
	MaLiAnNaLaSoliderMoUtil.instance:recycleSoliderMo(arg_16_1)

	if var_16_1 then
		var_0_0.instance:dispatchEvent(Activity201MaLiAnNaEvent.SoliderDead, var_16_0)
	end
end

function var_0_0.addAction(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0._actionList == nil then
		arg_17_0._actionList = {}
	end

	table.insert(arg_17_0._actionList, 1, {
		effect = tabletool.copy(arg_17_1),
		params = tabletool.copy(arg_17_2)
	})
end

function var_0_0.useAction(arg_18_0)
	if arg_18_0._actionList == nil or #arg_18_0._actionList == 0 then
		return
	end

	local var_18_0 = #arg_18_0._actionList

	for iter_18_0 = 1, var_18_0 do
		local var_18_1 = table.remove(arg_18_0._actionList, 1)
		local var_18_2 = var_18_1.effect
		local var_18_3 = var_18_2[1]
		local var_18_4 = var_18_1.params
		local var_18_5 = MaLiAnNaActionUtils.instance:getHandleFunc(var_18_3)

		if var_18_5 then
			var_18_5(var_18_4, var_18_2)
		else
			logError("没有找到对应的action处理函数: ", var_18_3)
		end
	end
end

function var_0_0.gameIsOver(arg_19_0)
	local var_19_0, var_19_1, var_19_2 = Activity201MaLiAnNaGameModel.instance:gameIsOver()

	if var_19_0 then
		arg_19_0._isOver = true

		if var_19_1 then
			arg_19_0:_checkGameOverAndWin()
		else
			local var_19_3 = Activity201MaLiAnNaEnum.FailResultType.timeOut
			local var_19_4, var_19_5 = Activity201MaLiAnNaGameModel.instance:isLoseByTarget()

			if var_19_4 and var_19_5 then
				local var_19_6 = var_19_5[1]

				if var_19_6 == Activity201MaLiAnNaEnum.ConditionType.occupySlot then
					var_19_3 = Activity201MaLiAnNaEnum.FailResultType.mySlotDead
				end

				if var_19_6 == Activity201MaLiAnNaEnum.ConditionType.soldierHeroDead then
					var_19_3 = Activity201MaLiAnNaEnum.FailResultType.myHeroDead
				end
			end

			MaLiAnNaStatHelper.instance:sendGameExit(Activity201MaLiAnNaEnum.resultType.fail, var_19_3)
			ViewMgr.instance:openView(ViewName.MaLiAnNaResultView, {
				isWin = var_19_1
			})
		end
	else
		arg_19_0:setPause(false)
	end
end

function var_0_0._guideFinish(arg_20_0)
	arg_20_0:setPause(false)
end

function var_0_0.exitGame(arg_21_0)
	arg_21_0:unregisterCallback(Activity201MaLiAnNaEvent.SoliderDead, arg_21_0._checkSoliderDead, arg_21_0)
	arg_21_0:unregisterCallback(Activity201MaLiAnNaEvent.SlotChangeCamp, arg_21_0._checkSlotChangeCamp, arg_21_0)
	arg_21_0:unregisterCallback(Activity201MaLiAnNaEvent.OnSelectActiveSkill, arg_21_0._checkUseSkillId, arg_21_0)
	arg_21_0:unregisterCallback(Activity201MaLiAnNaEvent.GamePause, arg_21_0._setGamePause, arg_21_0)
	GuideController.instance:unregisterCallback(GuideEvent.OneKeyFinishGuides, arg_21_0._guideFinish, arg_21_0)
	ViewMgr.instance:closeView(ViewName.TipDialogView)
	arg_21_0:setPause(true)
	UpdateBeat:Remove(arg_21_0._update, arg_21_0)
	Activity201MaLiAnNaGameModel.instance:destroy()
end

function var_0_0._checkSoliderDead(arg_22_0, arg_22_1)
	arg_22_0:checkLevelDialog(Activity201MaLiAnNaEnum.ConditionType.soldierHeroDead)
end

function var_0_0._checkSlotChangeCamp(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 ~= nil then
		local var_23_0 = Activity201MaLiAnNaConfig.instance:getSlotConfigById(arg_23_1)
		local var_23_1 = ""

		if arg_23_2 == Activity201MaLiAnNaEnum.CampType.Player then
			var_23_1 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("maliannagame_tip_player"), var_23_0.name)
		end

		if arg_23_2 == Activity201MaLiAnNaEnum.CampType.Enemy then
			var_23_1 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("maliannagame_tip_enemy"), var_23_0.name)
		end

		if not string.nilorempty(var_23_1) then
			arg_23_0:dispatchEvent(Activity201MaLiAnNaEvent.ShowBattleEvent, arg_23_2, var_23_1, true)

			local var_23_2 = arg_23_2 == Activity201MaLiAnNaEnum.CampType.Player and AudioEnum3_0.MaLiAnNa.play_ui_lushang_our_occupy or AudioEnum3_0.MaLiAnNa.play_ui_lushang_enemy_occupy

			AudioMgr.instance:trigger(var_23_2)
		end
	end

	arg_23_0:checkLevelDialog(Activity201MaLiAnNaEnum.ConditionType.occupySlot)
end

function var_0_0._checkGameStart(arg_24_0)
	arg_24_0:checkLevelDialog(Activity201MaLiAnNaEnum.ConditionType.gameStart)
end

function var_0_0._checkGameOverAndWin(arg_25_0)
	arg_25_0:checkLevelDialog(Activity201MaLiAnNaEnum.ConditionType.gameOverAndWin)
end

function var_0_0._checkUseSkillId(arg_26_0, arg_26_1)
	local var_26_0

	if arg_26_1 ~= nil then
		var_26_0 = arg_26_1:getConfigId()
	end

	arg_26_0:checkLevelDialog(Activity201MaLiAnNaEnum.ConditionType.useSkill, {
		skillId = var_26_0
	})
end

function var_0_0.checkLevelDialog(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_0._lastConditionType == nil then
		arg_27_0:_checkLevelDialog(arg_27_1, arg_27_2)
	else
		table.insert(arg_27_0._checkDialogList, {
			conditionType = arg_27_1,
			params = arg_27_2
		})
	end
end

function var_0_0._checkNextDialog(arg_28_0)
	if arg_28_0._lastConditionType == nil and arg_28_0._checkDialogList ~= nil then
		local var_28_0 = table.remove(arg_28_0._checkDialogList, 1)

		if var_28_0 then
			arg_28_0:_checkLevelDialog(var_28_0.conditionType, var_28_0.params)
		end
	end
end

function var_0_0._checkLevelDialog(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_0._isOver and arg_29_1 ~= Activity201MaLiAnNaEnum.ConditionType.gameOverAndWin then
		arg_29_0:_checkNextDialog()

		return
	end

	local var_29_0
	local var_29_1
	local var_29_2 = false

	arg_29_0._lastConditionType = arg_29_1

	if arg_29_0._dialogData ~= nil then
		for iter_29_0, iter_29_1 in pairs(arg_29_0._dialogData) do
			local var_29_3 = Activity201MaLiAnNaConfig.instance:getTriggerList(iter_29_1.trigger)
			local var_29_4, var_29_5 = Activity201MaLiAnNaGameModel.instance:checkCondition(var_29_3, arg_29_2)

			if var_29_4 and var_29_5 == arg_29_0._lastConditionType and not arg_29_0:isTrigger(arg_29_0.episodeId, iter_29_1.dialogSeq) then
				var_29_0 = iter_29_1.dialogId
				var_29_1 = iter_29_1.dialogSeq
			end
		end
	end

	if var_29_0 ~= nil then
		arg_29_0:setPause(true)
		arg_29_0:setTrigger(arg_29_0.episodeId, var_29_1, true)
		TipDialogController.instance:openTipDialogView(var_29_0, arg_29_0._levelDialogClose, arg_29_0, var_29_2, var_29_2 and EliminateConfig.instance:getConstValue(35) / 1000 or nil, var_29_2 and EliminateConfig.instance:getConstValue(34) / 100 or nil)
	else
		arg_29_0:_levelDialogClose()
	end
end

function var_0_0.isTrigger(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_0._dialogDataCache == nil or arg_30_0._dialogDataCache[arg_30_1] == nil then
		return false
	end

	return arg_30_0._dialogDataCache[arg_30_1][arg_30_2]
end

function var_0_0.setTrigger(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if arg_31_0._dialogDataCache == nil then
		arg_31_0._dialogDataCache = {}
	end

	if arg_31_0._dialogDataCache[arg_31_1] == nil then
		arg_31_0._dialogDataCache[arg_31_1] = {}
	end

	arg_31_0._dialogDataCache[arg_31_1][arg_31_2] = arg_31_3
end

function var_0_0._levelDialogClose(arg_32_0)
	if arg_32_0._lastConditionType and arg_32_0._lastConditionType == Activity201MaLiAnNaEnum.ConditionType.occupySlot then
		arg_32_0:gameIsOver()
	end

	if arg_32_0._lastConditionType and arg_32_0._lastConditionType == Activity201MaLiAnNaEnum.ConditionType.soldierHeroDead then
		arg_32_0:gameIsOver()
	end

	if arg_32_0._lastConditionType and arg_32_0._lastConditionType == Activity201MaLiAnNaEnum.ConditionType.gameOverAndWin then
		arg_32_0:setPause(true)
		Activity201MaLiAnNaController.instance:_onGameFinished(VersionActivity3_0Enum.ActivityId.MaLiAnNa, arg_32_0.episodeId)
		MaLiAnNaStatHelper.instance:sendGameExit(Activity201MaLiAnNaEnum.resultType.success)
	end

	if arg_32_0._lastConditionType and arg_32_0._lastConditionType == Activity201MaLiAnNaEnum.ConditionType.gameStart then
		arg_32_0:setPause(false)
		var_0_0.instance:dispatchEvent(Activity201MaLiAnNaEvent.GameStart, arg_32_0.episodeId)
	end

	arg_32_0._lastConditionType = nil

	arg_32_0:_checkNextDialog()
end

function var_0_0.finishGame(arg_33_0)
	arg_33_0:setPause(true)
	arg_33_0:_checkGameOverAndWin()
end

var_0_0.instance = var_0_0.New()

return var_0_0
