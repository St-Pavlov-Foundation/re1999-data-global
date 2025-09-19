module("modules.logic.versionactivity2_5.autochess.flow.AutoChessEffectHandleFunc", package.seeall)

local var_0_0 = class("AutoChessEffectHandleFunc")

function var_0_0.ctor(arg_1_0)
	arg_1_0._defineList = {
		[AutoChessEnum.EffectType.LeaderHp] = var_0_0._handleLeaderHp,
		[AutoChessEnum.EffectType.LeaderHpFloat] = var_0_0._handleLeaderHpFloat,
		[AutoChessEnum.EffectType.ChessHp] = var_0_0._handleChessHp,
		[AutoChessEnum.EffectType.ChessHpFloat] = var_0_0._handleChessHpFloat,
		[AutoChessEnum.EffectType.ChessMove] = var_0_0._handleChessMove,
		[AutoChessEnum.EffectType.ChessDie] = var_0_0._handleChessDie,
		[AutoChessEnum.EffectType.AddBuff] = var_0_0._handleAddBuff,
		[AutoChessEnum.EffectType.UpdateBuff] = var_0_0._handleUpdateBuff,
		[AutoChessEnum.EffectType.DelBuff] = var_0_0._handleDelBuff,
		[AutoChessEnum.EffectType.CoinChange] = var_0_0._handleCoinChange,
		[AutoChessEnum.EffectType.ExpChange] = var_0_0._handleExpChange,
		[AutoChessEnum.EffectType.StarChange] = var_0_0._handleStarChange,
		[AutoChessEnum.EffectType.Summon] = var_0_0._handleSummon,
		[AutoChessEnum.EffectType.BattleChange] = var_0_0._handleBattleChange,
		[AutoChessEnum.EffectType.MallUpdate] = var_0_0._handleMallUpdate,
		[AutoChessEnum.EffectType.PlayAttack] = var_0_0._handlePlayAttack,
		[AutoChessEnum.EffectType.UpdateChessPos] = var_0_0._handleUpdateChessPos,
		[AutoChessEnum.EffectType.FightUpdate] = var_0_0._handleFightUpdate,
		[AutoChessEnum.EffectType.LeaderSkillUpdate] = var_0_0._handleLeaderSkillUpdate,
		[AutoChessEnum.EffectType.LeaderChange] = var_0_0._handleLeaderChange,
		[AutoChessEnum.EffectType.UdimoSkill] = var_0_0._handleUdimoSkill
	}
end

function var_0_0._handleLeaderHp(arg_2_0)
	local var_2_0 = arg_2_0.mgr:getLeaderEntity(arg_2_0.effect.targetId)

	if var_2_0 then
		var_2_0:updateHp(arg_2_0.effect.effectNum)
	end

	arg_2_0:finishWork()
end

function var_0_0._handleLeaderHpFloat(arg_3_0)
	if arg_3_0.effect.fromId == arg_3_0.effect.targetId then
		arg_3_0:delayFloatLeader()
	else
		local var_3_0 = arg_3_0.mgr:getLeaderEntity(arg_3_0.effect.fromId)

		if var_3_0 then
			arg_3_0.mgr:flyStarByTeam(var_3_0.data.teamType)
			TaskDispatcher.runDelay(arg_3_0.delayAttack, arg_3_0, 1.1)
		else
			arg_3_0:delayFloatLeader()
			TaskDispatcher.runDelay(arg_3_0.finishWork, arg_3_0, 1)
		end
	end
end

function var_0_0._handleChessHp(arg_4_0)
	local var_4_0 = arg_4_0.mgr:getEntity(arg_4_0.effect.targetId)

	if var_4_0 then
		var_4_0:updateHp(arg_4_0.effect.effectNum)
	end

	arg_4_0:finishWork()
end

function var_0_0._handleChessHpFloat(arg_5_0)
	local var_5_0 = arg_5_0.mgr:getEntity(arg_5_0.effect.targetId)

	if var_5_0 then
		var_5_0:floatHp(arg_5_0.effect.effectNum, arg_5_0.effect.fromId)
	end

	TaskDispatcher.runDelay(arg_5_0.finishWork, arg_5_0, 0.5)
end

function var_0_0._handleChessMove(arg_6_0)
	local var_6_0

	if arg_6_0.context == AutoChessEnum.ContextType.EndBuy or arg_6_0.context == AutoChessEnum.ContextType.Fight then
		var_6_0 = arg_6_0.chessMo.lastSvrFight
	else
		var_6_0 = arg_6_0.chessMo.svrFight
	end

	local var_6_1, var_6_2 = arg_6_0.chessMo:getChessPosition1(arg_6_0.effect.targetId, var_6_0)
	local var_6_3 = arg_6_0.chessMo:getChessPosition(var_6_2, tonumber(arg_6_0.effect.effectNum) + 1, var_6_0)

	if var_6_1 and var_6_3 then
		var_6_1.chess, var_6_3.chess = var_6_3.chess, var_6_1.chess
	else
		logError(string.format("位置: %s %s 的ChessPosition数据为空,请检查", arg_6_0.effect.fromId, arg_6_0.effect.effectNum))
	end

	local var_6_4 = arg_6_0.mgr:getEntity(arg_6_0.effect.targetId)

	if var_6_4 then
		var_6_4:move(arg_6_0.effect.effectNum)
	end

	TaskDispatcher.runDelay(arg_6_0.finishWork, arg_6_0, AutoChessEnum.ChessAniTime.Jump)
end

function var_0_0._handleChessDie(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_death)

	local var_7_0
	local var_7_1
	local var_7_2

	if arg_7_0.context == AutoChessEnum.ContextType.EndBuy or arg_7_0.context == AutoChessEnum.ContextType.Fight then
		var_7_0 = arg_7_0.chessMo.lastSvrFight
		var_7_2 = true
	else
		var_7_0 = arg_7_0.chessMo.svrFight
		var_7_2 = false
	end

	local var_7_3 = AutoChessEnum.ChessAniTime.Die
	local var_7_4 = arg_7_0.mgr:getEntity(arg_7_0.effect.targetId)

	if var_7_4 then
		if var_7_4.go.activeInHierarchy then
			local var_7_5 = var_7_4:die(var_7_2)

			if var_7_5 then
				local var_7_6 = lua_auto_chess_effect.configDict[var_7_5]

				var_7_3 = math.max(var_7_3, var_7_6.duration)
			end
		else
			var_7_3 = 0
		end
	end

	arg_7_0.chessMo:getChessPosition(tonumber(arg_7_0.effect.fromId), tonumber(arg_7_0.effect.effectNum) + 1, var_7_0).chess = AutoChessHelper.buildEmptyChess()

	if var_7_3 == 0 then
		arg_7_0:finishWork()
	else
		TaskDispatcher.runDelay(arg_7_0.finishWork, arg_7_0, var_7_3)
	end
end

function var_0_0._handleAddBuff(arg_8_0)
	local var_8_0 = arg_8_0.mgr:tryGetEntity(arg_8_0.effect.targetId) or arg_8_0.mgr:getLeaderEntity(arg_8_0.effect.targetId)

	if var_8_0 then
		var_8_0:addBuff(arg_8_0.effect.buff)
	end

	arg_8_0:finishWork()
end

function var_0_0._handleUpdateBuff(arg_9_0)
	local var_9_0 = arg_9_0.mgr:tryGetEntity(arg_9_0.effect.targetId) or arg_9_0.mgr:getLeaderEntity(arg_9_0.effect.targetId)

	if var_9_0 then
		var_9_0:updateBuff(arg_9_0.effect.buff)
	end

	arg_9_0:finishWork()
end

function var_0_0._handleDelBuff(arg_10_0)
	local var_10_0 = arg_10_0.mgr:tryGetEntity(arg_10_0.effect.targetId) or arg_10_0.mgr:getLeaderEntity(arg_10_0.effect.targetId)

	if var_10_0 then
		var_10_0:delBuff(arg_10_0.effect.effectNum)
	end

	arg_10_0:finishWork()
end

function var_0_0._handleCoinChange(arg_11_0)
	arg_11_0.chessMo:updateSvrMallCoin(arg_11_0.effect.effectNum)
	arg_11_0:finishWork()
end

function var_0_0._handleExpChange(arg_12_0)
	local var_12_0 = arg_12_0.mgr:getEntity(arg_12_0.effect.targetId)

	if var_12_0 then
		var_12_0:updateExp(arg_12_0.effect.effectNum)
	end

	arg_12_0:finishWork()
end

function var_0_0._handleStarChange(arg_13_0)
	local var_13_0

	if arg_13_0.context == AutoChessEnum.ContextType.EndBuy or arg_13_0.context == AutoChessEnum.ContextType.Fight then
		var_13_0 = arg_13_0.chessMo:getChessPosition1(arg_13_0.effect.chess.uid, arg_13_0.chessMo.lastSvrFight)
	else
		var_13_0 = arg_13_0.chessMo:getChessPosition1(arg_13_0.effect.chess.uid)
	end

	if var_13_0 then
		var_13_0.chess = arg_13_0.effect.chess
	end

	local var_13_1 = arg_13_0.mgr:getEntity(arg_13_0.effect.chess.uid)

	if var_13_1 then
		local var_13_2 = var_13_1:updateStar(arg_13_0.effect.chess)

		TaskDispatcher.runDelay(arg_13_0.finishWork, arg_13_0, var_13_2)
	else
		arg_13_0:finishWork()
	end
end

function var_0_0._handleBattleChange(arg_14_0)
	local var_14_0 = arg_14_0.mgr:getEntity(arg_14_0.effect.targetId)

	if var_14_0 then
		var_14_0:updateBattle(arg_14_0.effect.effectNum)
	end

	arg_14_0:finishWork()
end

function var_0_0._handleSummon(arg_15_0)
	arg_15_0.mgr:addEntity(arg_15_0.effect.targetId, arg_15_0.effect.chess, arg_15_0.effect.effectNum)

	if arg_15_0.context == AutoChessEnum.ContextType.EndBuy or arg_15_0.context == AutoChessEnum.ContextType.Fight then
		arg_15_0.chessMo:getChessPosition(tonumber(arg_15_0.effect.targetId), tonumber(arg_15_0.effect.effectNum) + 1, arg_15_0.chessMo.lastSvrFight).chess = arg_15_0.effect.chess
	else
		arg_15_0.chessMo:getChessPosition(tonumber(arg_15_0.effect.targetId), tonumber(arg_15_0.effect.effectNum) + 1).chess = arg_15_0.effect.chess
	end

	TaskDispatcher.runDelay(arg_15_0.finishWork, arg_15_0, 0.2)
end

function var_0_0._handlePlayAttack(arg_16_0)
	arg_16_0.damageWork = AutoChessDamageWork.New(arg_16_0.effect)

	arg_16_0.damageWork:registerDoneListener(arg_16_0.finishWork, arg_16_0)
	arg_16_0.damageWork:onStart(arg_16_0.context)
end

function var_0_0._handleUpdateChessPos(arg_17_0)
	local var_17_0 = arg_17_0.mgr:getEntity(arg_17_0.effect.targetId)

	if var_17_0 then
		local var_17_1 = tonumber(arg_17_0.effect.fromId)
		local var_17_2 = tonumber(arg_17_0.effect.effectNum)
		local var_17_3 = arg_17_0.chessMo:getChessPosition(var_17_1, var_17_2 + 1)

		if arg_17_0.effect.targetId ~= var_17_3.chess.uid then
			local var_17_4 = arg_17_0.chessMo:getChessPosition(var_17_0.warZone, var_17_0.index + 1)

			var_17_3.chess, var_17_4.chess = var_17_4.chess, var_17_3.chess
		end

		var_17_0:updateIndex(var_17_1, var_17_2)
	end

	arg_17_0:finishWork()
end

function var_0_0._handleMallUpdate(arg_18_0)
	arg_18_0.chessMo:updateSvrMallRegion(arg_18_0.effect.region, true)
	arg_18_0:finishWork()
end

function var_0_0._handleFightUpdate(arg_19_0)
	arg_19_0.chessMo:updateSvrFight(arg_19_0.effect.fight)
	arg_19_0:finishWork()
end

function var_0_0._handleLeaderSkillUpdate(arg_20_0)
	arg_20_0.chessMo.svrFight:unlockMasterSkill(arg_20_0.effect.targetId)
	arg_20_0:finishWork()
end

function var_0_0._handleLeaderChange(arg_21_0)
	local var_21_0 = arg_21_0.mgr:getLeaderEntity(arg_21_0.chessMo.svrFight.mySideMaster.uid)

	if var_21_0 then
		var_21_0:setData(arg_21_0.effect.master)
	end

	arg_21_0.chessMo.svrFight:updateMaster(arg_21_0.effect.master)
	arg_21_0:finishWork()
end

function var_0_0._handleUdimoSkill(arg_22_0)
	arg_22_0.chessMo:updateSvrMallRegion(arg_22_0.effect.region, true)
	arg_22_0:finishWork()
end

function var_0_0.getHandleFunc(arg_23_0, arg_23_1)
	return arg_23_0._defineList[arg_23_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
