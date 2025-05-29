module("modules.logic.versionactivity2_6.xugouji.model.Activity188Model", package.seeall)

local var_0_0 = class("Activity188Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:_initData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_initData()
end

function var_0_0._initData(arg_3_0)
	arg_3_0._passEpisodes = {}
	arg_3_0._unlockEpisodes = {}
	arg_3_0._episodeDatas = {}
	arg_3_0._unLockCount = 0
	arg_3_0._finishedCount = 0

	arg_3_0:clearGameInfo()
end

function var_0_0.clearGameInfo(arg_4_0)
	arg_4_0._round = 0
	arg_4_0._isMyTurn = true
	arg_4_0._curTurnOperateTime = 0
	arg_4_0._gameState = XugoujiEnum.GameStatus.Operatable
	arg_4_0._gameViewState = XugoujiEnum.GameViewState.PlayerOperating
	arg_4_0._playerInitialHP = 0
	arg_4_0._enemyInitialHP = 0
	arg_4_0._curHP = 0
	arg_4_0._enenyHP = 0
	arg_4_0._curPairCount = 0
	arg_4_0._enenyPairCount = 0
	arg_4_0._playerAbilityIds = {}
	arg_4_0._enemyAbilityIds = {}
	arg_4_0._curTurnOperateTime = 0
	arg_4_0._enemyOperateTimeLeft = 0
	arg_4_0._curCardUid = 0
	arg_4_0._cardsInfo = {}
	arg_4_0._cardsInfoList = {}
	arg_4_0._cardsEffect = {}
	arg_4_0._cardItemState = {}
	arg_4_0._lastCardStatus = 0
	arg_4_0._lastCardId = 0
	arg_4_0._lastCardInfoUId = 0
	arg_4_0._playerBuffs = {}
	arg_4_0._enemyBuffs = {}
	arg_4_0._guideMode = false
	arg_4_0._isHpZero = false
end

function var_0_0.onAct188GameInfoUpdate(arg_5_0, arg_5_1)
	arg_5_0:clearGameInfo()

	arg_5_0._cardsInfo = arg_5_0._cardsInfo and arg_5_0._cardsInfo or {}

	local var_5_0 = var_0_0.instance:getCurEpisodeId()

	arg_5_0._gameId = Activity188Config.instance:getEpisodeCfgByEpisodeId(var_5_0).gameId

	if arg_5_0._gameId then
		arg_5_0:setRound(arg_5_1.round)

		local var_5_1 = arg_5_1.cards

		arg_5_0:updateCardInfo(var_5_1)
		arg_5_0:_setCurHP(arg_5_1.team.hp)
		arg_5_0:_setEnemyHP(arg_5_1.bossTeam.hp)
		arg_5_0:setInitialHP(arg_5_1.team.hp, arg_5_1.bossTeam.hp)
		arg_5_0:_setCurPairCount(arg_5_1.team.pairCount)
		arg_5_0:_setEnemyPairCount(arg_5_1.bossTeam.pairCount)
		arg_5_0:setPlayerAbilityIds(arg_5_1.team.abilityIds)
		arg_5_0:setEnemyAbilityIds(arg_5_1.bossTeam.abilityIds)
		arg_5_0:setCurTurnOperateTime(arg_5_1.team.maxReverseCount)
		arg_5_0:setCurTurnOperateTime(arg_5_1.bossTeam.maxReverseCount, true)
	end
end

function var_0_0.updateCardInfo(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		arg_6_0._cardsInfo[iter_6_1.uid] = iter_6_1
		arg_6_0._cardsInfoList[iter_6_0] = iter_6_1
	end
end

function var_0_0.updateCardStatus(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:getCardInfo(arg_7_1)

	if var_7_0 then
		var_7_0.status = arg_7_2
		arg_7_0._lastUid = arg_7_1
		arg_7_0._lastCardStatus = arg_7_2
		arg_7_0._lastCardId = var_7_0.id
	end
end

function var_0_0.updateCardEffectStatus(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_0:getCardEffect(arg_8_1) then
		arg_8_0._cardsEffect[arg_8_1] = {}
	end

	if arg_8_2 then
		arg_8_0._cardsEffect[arg_8_1][arg_8_3] = true
	elseif arg_8_3 == 0 then
		arg_8_0._cardsEffect[arg_8_1] = {}
	else
		arg_8_0._cardsEffect[arg_8_1][arg_8_3] = false
	end
end

function var_0_0.clearCardsInfo(arg_9_0)
	arg_9_0._cardsInfo = {}
	arg_9_0._cardsInfoList = {}
	arg_9_0._cardsEffect = {}
	arg_9_0._cardItemState = {}
end

function var_0_0.getCardsInfo(arg_10_0)
	return arg_10_0._cardsInfo
end

function var_0_0.getCardsInfoList(arg_11_0)
	return arg_11_0._cardsInfoList
end

function var_0_0.getCardsInfoSortedList(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = var_0_0.instance:getCardColNum()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._cardsInfoList) do
		var_12_0[iter_12_1.y + 1 + iter_12_1.x * var_12_1] = iter_12_1
	end

	return var_12_0
end

function var_0_0.getCardColNum(arg_13_0)
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._cardsInfoList) do
		var_13_0 = var_13_0 < iter_13_1.y and iter_13_1.y or var_13_0
	end

	return var_13_0 + 1
end

function var_0_0.getCardInfo(arg_14_0, arg_14_1)
	return arg_14_0._cardsInfo[arg_14_1]
end

function var_0_0.getCardEffect(arg_15_0, arg_15_1)
	return arg_15_0._cardsEffect[arg_15_1]
end

function var_0_0.addOpenedCard(arg_16_0, arg_16_1)
	arg_16_0._openedCardList = arg_16_0._openedCardList and arg_16_0._openedCardList or {}
	arg_16_0._openedCardList[#arg_16_0._openedCardList + 1] = arg_16_1
end

function var_0_0.getLastCardPair(arg_17_0)
	if not arg_17_0._openedCardList or #arg_17_0._openedCardList < 2 then
		return nil
	end

	return arg_17_0._openedCardList[#arg_17_0._openedCardList], arg_17_0._openedCardList[#arg_17_0._openedCardList - 1]
end

function var_0_0.getLastCardUid(arg_18_0)
	return arg_18_0._lastUid
end

function var_0_0.getLastCardStatus(arg_19_0)
	return arg_19_0._lastCardStatus
end

function var_0_0.getLastCardId(arg_20_0)
	return arg_20_0._lastCardId
end

function var_0_0.setLastCardInfoUId(arg_21_0, arg_21_1)
	arg_21_0._lastCardInfoUId = arg_21_1
end

function var_0_0.getLastCardInfoUId(arg_22_0)
	return arg_22_0._lastCardInfoUId
end

function var_0_0.setCurCardUid(arg_23_0, arg_23_1)
	arg_23_0._curCardUid = arg_23_1
end

function var_0_0.getCurCardUid(arg_24_0)
	return arg_24_0._curCardUid
end

function var_0_0.setCurActId(arg_25_0, arg_25_1)
	arg_25_0._curActId = arg_25_1
end

function var_0_0.getCurActId(arg_26_0)
	return arg_26_0._curActId
end

function var_0_0.setCurEpisodeId(arg_27_0, arg_27_1)
	arg_27_0._curEpisodeId = arg_27_1
end

function var_0_0.getCurEpisodeId(arg_28_0)
	return arg_28_0._curEpisodeId
end

function var_0_0.setCurBattleEpisodeId(arg_29_0, arg_29_1)
	arg_29_0._curBattleEpisodeId = arg_29_1
end

function var_0_0.getCurBattleEpisodeId(arg_30_0)
	return arg_30_0._curBattleEpisodeId
end

function var_0_0.isEpisodeFinish(arg_31_0, arg_31_1)
	return arg_31_0._passEpisodes[arg_31_1]
end

function var_0_0.getCurGameId(arg_32_0)
	return arg_32_0._gameId
end

function var_0_0.setCurTurnOperateTime(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_2 then
		arg_33_0._enemyOperateTimeLeft = arg_33_1
	else
		arg_33_0._curTurnOperateTime = arg_33_1
	end
end

function var_0_0.getCurTurnOperateTime(arg_34_0)
	return arg_34_0._curTurnOperateTime
end

function var_0_0.getEnemyOperateTime(arg_35_0)
	return arg_35_0._enemyOperateTimeLeft
end

function var_0_0.setRound(arg_36_0, arg_36_1)
	arg_36_0._round = arg_36_1
end

function var_0_0.getRound(arg_37_0)
	return arg_37_0._round
end

function var_0_0.getGameTurn(arg_38_0)
	return arg_38_0._curCardUid
end

function var_0_0.isMyTurn(arg_39_0)
	return arg_39_0._isMyTurn
end

function var_0_0.setTurn(arg_40_0, arg_40_1)
	if arg_40_0._isMyTurn == false and arg_40_1 then
		arg_40_0:setRound(arg_40_0:getRound() + 1)
	end

	arg_40_0._isMyTurn = arg_40_1
end

function var_0_0.updateHp(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = tonumber(arg_41_2)

	if arg_41_1 then
		arg_41_0._curHP = arg_41_0._curHP + var_41_0
	else
		arg_41_0._enenyHP = arg_41_0._enenyHP + var_41_0
	end
end

function var_0_0.checkHpZero(arg_42_0, arg_42_1)
	local var_42_0 = tonumber(arg_42_1)

	arg_42_0._isHpZero = arg_42_0._curHP + var_42_0 <= 0

	return arg_42_0._isHpZero
end

function var_0_0.isHpZero(arg_43_0)
	return arg_43_0._isHpZero
end

function var_0_0._setCurHP(arg_44_0, arg_44_1)
	arg_44_0._curHP = arg_44_1 and arg_44_1 or 0
end

function var_0_0.getCurHP(arg_45_0)
	return arg_45_0._curHP
end

function var_0_0._setEnemyHP(arg_46_0, arg_46_1)
	arg_46_0._enenyHP = arg_46_1 and arg_46_1 or 0
end

function var_0_0.getEnemyHP(arg_47_0)
	return arg_47_0._enenyHP
end

function var_0_0.setInitialHP(arg_48_0, arg_48_1, arg_48_2)
	arg_48_0._playerInitialHP = tonumber(arg_48_1)
	arg_48_0._enemyInitialHP = tonumber(arg_48_2)
end

function var_0_0.getPlayerInitialHP(arg_49_0)
	return arg_49_0._playerInitialHP
end

function var_0_0.getEnemyInitialHP(arg_50_0)
	return arg_50_0._enemyInitialHP
end

function var_0_0.setPairCount(arg_51_0, arg_51_1, arg_51_2)
	if arg_51_2 then
		arg_51_0._curPairCount = arg_51_1
	else
		arg_51_0._enenyPairCount = arg_51_1
	end
end

function var_0_0._setCurPairCount(arg_52_0, arg_52_1)
	arg_52_0._curPairCount = arg_52_1
end

function var_0_0.getCurPairCount(arg_53_0)
	return arg_53_0._curPairCount
end

function var_0_0._setEnemyPairCount(arg_54_0, arg_54_1)
	arg_54_0._enenyPairCount = arg_54_1
end

function var_0_0.getEnemyPairCount(arg_55_0)
	return arg_55_0._enenyPairCount
end

function var_0_0.setPlayerAbilityIds(arg_56_0, arg_56_1)
	arg_56_0._playerAbilityIds = arg_56_1
end

function var_0_0.getPlayerAbilityIds(arg_57_0)
	return arg_57_0._playerAbilityIds
end

function var_0_0.setEnemyAbilityIds(arg_58_0, arg_58_1)
	arg_58_0._enemyAbilityIds = arg_58_1
end

function var_0_0.getEnemyAbilityIds(arg_59_0)
	return arg_59_0._enemyAbilityIds
end

function var_0_0.setBuffs(arg_60_0, arg_60_1, arg_60_2)
	if arg_60_2 then
		arg_60_0._playerBuffs = arg_60_1
	else
		arg_60_0._enemyBuffs = arg_60_1
	end
end

function var_0_0.getBuffs(arg_61_0, arg_61_1)
	return arg_61_1 and arg_61_0._playerBuffs or arg_61_0._enemyBuffs
end

function var_0_0.setGameState(arg_62_0, arg_62_1)
	arg_62_0._gameState = arg_62_1
end

function var_0_0.getGameState(arg_63_0)
	return arg_63_0._gameState
end

function var_0_0.setGameViewState(arg_64_0, arg_64_1)
	arg_64_0._gameViewState = arg_64_1
end

function var_0_0.getGameViewState(arg_65_0)
	return arg_65_0._gameViewState
end

function var_0_0.setCardItemStatue(arg_66_0, arg_66_1, arg_66_2)
	arg_66_0._cardItemState[arg_66_1] = arg_66_2
end

function var_0_0.getCardItemStatue(arg_67_0, arg_67_1)
	return arg_67_0._cardItemState[arg_67_1]
end

function var_0_0.setGameGuideMode(arg_68_0, arg_68_1)
	arg_68_0._guideMode = arg_68_1 and tonumber(arg_68_1) == 1
end

function var_0_0.isGameGuideMode(arg_69_0)
	return arg_69_0._guideMode
end

function var_0_0.onGetActInfoReply(arg_70_0, arg_70_1)
	arg_70_0._unLockCount = 0
	arg_70_0._finishedCount = 0

	for iter_70_0, iter_70_1 in ipairs(arg_70_1) do
		local var_70_0 = iter_70_1.episodeId

		arg_70_0._episodeDatas[var_70_0] = iter_70_1
		arg_70_0._unlockEpisodes[var_70_0] = true
		arg_70_0._unLockCount = arg_70_0._unLockCount + 1

		if iter_70_1.isFinished then
			arg_70_0._passEpisodes[var_70_0] = true
			arg_70_0._finishedCount = arg_70_0._finishedCount + 1
		end
	end
end

function var_0_0.onEpisodeInfoUpdate(arg_71_0, arg_71_1, arg_71_2)
	local var_71_0 = Activity188Config.instance:getEpisodeCfgByEpisodeId(arg_71_1)

	if var_71_0 and not arg_71_0._unlockEpisodes[arg_71_1] then
		arg_71_0._unlockEpisodes[arg_71_1] = true
		arg_71_0._unLockCount = arg_71_0._unLockCount + 1

		local var_71_1 = var_71_0.preEpisodeId

		if not arg_71_0._passEpisodes[var_71_1] then
			arg_71_0._passEpisodes[var_71_1] = true
			arg_71_0._finishedCount = arg_71_0._finishedCount + 1
		end
	end
end

function var_0_0.onStoryEpisodeFinish(arg_72_0, arg_72_1)
	if not arg_72_0._passEpisodes[arg_72_1] then
		arg_72_0._passEpisodes[arg_72_1] = true
		arg_72_0._finishedCount = arg_72_0._finishedCount + 1
	end

	local var_72_0 = Activity188Config.instance:getEpisodeCfgByPreEpisodeId(arg_72_1)

	if var_72_0 and not arg_72_0._unlockEpisodes[var_72_0.episodeId] then
		arg_72_0._unlockEpisodes[var_72_0.episodeId] = true
		arg_72_0._unLockCount = arg_72_0._unLockCount + 1
	end
end

function var_0_0.getUnlockCount(arg_73_0)
	return arg_73_0._unLockCount and arg_73_0._unLockCount or 10
end

function var_0_0.getFinishedCount(arg_74_0)
	return arg_74_0._finishedCount
end

function var_0_0.isEpisodeUnlock(arg_75_0, arg_75_1)
	return arg_75_0._unlockEpisodes[arg_75_1]
end

function var_0_0.isEpisodeFinished(arg_76_0, arg_76_1)
	return arg_76_0._passEpisodes[arg_76_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
