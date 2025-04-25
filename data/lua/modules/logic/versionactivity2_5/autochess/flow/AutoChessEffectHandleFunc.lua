module("modules.logic.versionactivity2_5.autochess.flow.AutoChessEffectHandleFunc", package.seeall)

slot0 = class("AutoChessEffectHandleFunc")

function slot0.ctor(slot0)
	slot0._defineList = {
		[AutoChessEnum.EffectType.LeaderHp] = uv0._handleLeaderHp,
		[AutoChessEnum.EffectType.LeaderHpFloat] = uv0._handleLeaderHpFloat,
		[AutoChessEnum.EffectType.ChessHp] = uv0._handleChessHp,
		[AutoChessEnum.EffectType.ChessHpFloat] = uv0._handleChessHpFloat,
		[AutoChessEnum.EffectType.ChessMove] = uv0._handleChessMove,
		[AutoChessEnum.EffectType.ChessDie] = uv0._handleChessDie,
		[AutoChessEnum.EffectType.AddBuff] = uv0._handleAddBuff,
		[AutoChessEnum.EffectType.UpdateBuff] = uv0._handleUpdateBuff,
		[AutoChessEnum.EffectType.DelBuff] = uv0._handleDelBuff,
		[AutoChessEnum.EffectType.CoinChange] = uv0._handleCoinChange,
		[AutoChessEnum.EffectType.ExpChange] = uv0._handleExpChange,
		[AutoChessEnum.EffectType.StarChange] = uv0._handleStarChange,
		[AutoChessEnum.EffectType.Summon] = uv0._handleSummon,
		[AutoChessEnum.EffectType.BattleChange] = uv0._handleBattleChange,
		[AutoChessEnum.EffectType.MallUpdate] = uv0._handleMallUpdate,
		[AutoChessEnum.EffectType.PlayAttack] = uv0._handlePlayAttack,
		[AutoChessEnum.EffectType.UpdateChessPos] = uv0._handleUpdateChessPos,
		[AutoChessEnum.EffectType.FightUpdate] = uv0._handleFightUpdate,
		[AutoChessEnum.EffectType.LeaderSkillUpdate] = uv0._handleLeaderSkillUpdate,
		[AutoChessEnum.EffectType.LeaderChange] = uv0._handleLeaderChange
	}
end

function slot0._handleLeaderHp(slot0)
	if slot0.mgr:getLeaderEntity(slot0.effect.targetId) then
		slot1:updateHp(slot0.effect.effectNum)
	end

	slot0:finishWork()
end

function slot0._handleLeaderHpFloat(slot0)
	if slot0.mgr:getLeaderEntity(slot0.effect.fromId) then
		slot0.mgr:flyStarByTeam(slot1.data.teamType)
		TaskDispatcher.runDelay(slot0.delayAttack, slot0, 1.1)
	else
		slot0:delayFloatLeader()
		TaskDispatcher.runDelay(slot0.finishWork, slot0, 1)
	end
end

function slot0._handleChessHp(slot0)
	if slot0.mgr:getEntity(slot0.effect.targetId) then
		slot1:updateHp(slot0.effect.effectNum)
	end

	slot0:finishWork()
end

function slot0._handleChessHpFloat(slot0)
	if slot0.mgr:getEntity(slot0.effect.targetId) then
		slot1:floatHp(slot0.effect.effectNum)
	end

	TaskDispatcher.runDelay(slot0.finishWork, slot0, 0.5)
end

function slot0._handleChessMove(slot0)
	if slot0.mgr:getEntity(slot0.effect.targetId) then
		if slot0.context == AutoChessEnum.ContextType.EndBuy or slot0.context == AutoChessEnum.ContextType.Fight then
			fightData = slot0.chessMo.lastSvrFight
		else
			fightData = slot0.chessMo.svrFight
		end

		slot3 = slot0.chessMo:getChessPosition(slot1.warZone, tonumber(slot0.effect.effectNum) + 1, fightData)

		if slot0.chessMo:getChessPosition(slot1.warZone, tonumber(slot0.effect.fromId) + 1, fightData) and slot3 then
			slot3.chess = slot2.chess
			slot2.chess = AutoChessHelper.buildEmptyChess()
		end

		slot1:move(slot0.effect.effectNum)
	end

	TaskDispatcher.runDelay(slot0.finishWork, slot0, AutoChessEnum.ChessAniTime.Jump)
end

function slot0._handleChessDie(slot0)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_death)

	slot1, slot2 = nil

	if slot0.context == AutoChessEnum.ContextType.EndBuy or slot0.context == AutoChessEnum.ContextType.Fight then
		slot1 = slot0.chessMo.lastSvrFight
		slot2 = true
	else
		slot1 = slot0.chessMo.svrFight
		slot2 = false
	end

	if slot0.mgr:getEntity(slot0.effect.targetId) then
		if slot4.go.activeInHierarchy then
			if slot4:die(slot2) then
				slot3 = math.max(AutoChessEnum.ChessAniTime.Die, lua_auto_chess_effect.configDict[slot5].duration)
			end
		else
			slot3 = 0
		end
	end

	slot0.chessMo:getChessPosition(tonumber(slot0.effect.fromId), tonumber(slot0.effect.effectNum) + 1, slot1).chess = AutoChessHelper.buildEmptyChess()

	TaskDispatcher.runDelay(slot0.finishWork, slot0, slot3)
end

function slot0._handleAddBuff(slot0)
	if slot0.mgr:tryGetEntity(slot0.effect.targetId) or slot0.mgr:getLeaderEntity(slot0.effect.targetId) then
		slot1:addBuff(slot0.effect.buff)
	end

	slot0:finishWork()
end

function slot0._handleUpdateBuff(slot0)
	if slot0.mgr:tryGetEntity(slot0.effect.targetId) or slot0.mgr:getLeaderEntity(slot0.effect.targetId) then
		slot1:updateBuff(slot0.effect.buff)
	end

	slot0:finishWork()
end

function slot0._handleDelBuff(slot0)
	if slot0.mgr:tryGetEntity(slot0.effect.targetId) or slot0.mgr:getLeaderEntity(slot0.effect.targetId) then
		slot1:delBuff(slot0.effect.effectNum)
	end

	slot0:finishWork()
end

function slot0._handleCoinChange(slot0)
	slot0.chessMo:updateSvrMallCoin(slot0.effect.effectNum)
	slot0:finishWork()
end

function slot0._handleExpChange(slot0)
	if slot0.mgr:getEntity(slot0.effect.targetId) then
		slot1:updateExp(slot0.effect.effectNum)
	end

	slot0:finishWork()
end

function slot0._handleStarChange(slot0)
	slot0.chessMo:getChessPosition1(slot0.effect.chess.uid).chess = slot0.effect.chess

	if slot0.mgr:getEntity(slot0.effect.chess.uid) then
		TaskDispatcher.runDelay(slot0.finishWork, slot0, slot2:updateStar(slot0.effect.chess))
	else
		slot0:finishWork()
	end
end

function slot0._handleBattleChange(slot0)
	if slot0.mgr:getEntity(slot0.effect.targetId) then
		slot1:updateBattle(slot0.effect.effectNum)
	end

	slot0:finishWork()
end

function slot0._handleSummon(slot0)
	slot0.mgr:addEntity(slot0.effect.targetId, slot0.effect.chess, slot0.effect.effectNum)

	if slot0.context == AutoChessEnum.ContextType.EndBuy or slot0.context == AutoChessEnum.ContextType.Fight then
		slot0.chessMo:getChessPosition(tonumber(slot0.effect.targetId), tonumber(slot0.effect.effectNum) + 1, slot0.chessMo.lastSvrFight).chess = slot0.effect.chess
	else
		slot0.chessMo:getChessPosition(tonumber(slot0.effect.targetId), tonumber(slot0.effect.effectNum) + 1).chess = slot0.effect.chess
	end

	TaskDispatcher.runDelay(slot0.finishWork, slot0, 0.2)
end

function slot0._handlePlayAttack(slot0)
	slot0.damageWork = AutoChessDamageWork.New(slot0.effect)

	slot0.damageWork:registerDoneListener(slot0.finishWork, slot0)
	slot0.damageWork:onStart(slot0.context)
end

function slot0._handleUpdateChessPos(slot0)
	if slot0.mgr:getEntity(slot0.effect.targetId) then
		if slot0.effect.targetId ~= slot0.chessMo:getChessPosition(tonumber(slot0.effect.fromId), tonumber(slot0.effect.effectNum) + 1).chess.uid then
			slot5 = slot0.chessMo:getChessPosition(slot1.warZone, slot1.index + 1)
			slot5.chess = slot4.chess
			slot4.chess = slot5.chess
		end

		slot1:updateIndex(slot2, slot3)
	end

	slot0:finishWork()
end

function slot0._handleMallUpdate(slot0)
	slot0.chessMo:updateSvrMallRegion(slot0.effect.region, true)
	slot0:finishWork()
end

function slot0._handleFightUpdate(slot0)
	slot0.chessMo:updateSvrFight(slot0.effect.fight)
	slot0:finishWork()
end

function slot0._handleLeaderSkillUpdate(slot0)
	slot0.chessMo.svrFight:unlockMasterSkill(slot0.effect.targetId)
	slot0:finishWork()
end

function slot0._handleLeaderChange(slot0)
	if slot0.mgr:getLeaderEntity(slot0.chessMo.svrFight.mySideMaster.uid) then
		slot1:setData(slot0.effect.master)
	end

	slot0.chessMo.svrFight:updateMaster(slot0.effect.master)
	slot0:finishWork()
end

function slot0.getHandleFunc(slot0, slot1)
	return slot0._defineList[slot1]
end

slot0.instance = slot0.New()

return slot0
