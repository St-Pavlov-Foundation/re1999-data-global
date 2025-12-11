module("modules.logic.fight.system.flow.FightStepBuilder", package.seeall)

local var_0_0 = class("FightStepBuilder")

var_0_0.ActEffectWorkCls = {
	[FightEnum.EffectType.MISS] = FightWorkEffectMiss,
	[FightEnum.EffectType.DAMAGE] = FightWorkEffectDamage,
	[FightEnum.EffectType.CRIT] = FightWorkEffectDamage,
	[FightEnum.EffectType.HEAL] = FightWorkEffectHeal,
	[FightEnum.EffectType.HEALCRIT] = FightWorkEffectHeal,
	[FightEnum.EffectType.BUFFADD] = FightWorkStepBuff,
	[FightEnum.EffectType.BUFFDEL] = FightWorkStepBuff,
	[FightEnum.EffectType.BUFFUPDATE] = FightWorkStepBuff,
	[FightEnum.EffectType.BUFFDELNOEFFECT] = FightWorkStepBuff,
	[FightEnum.EffectType.DAMAGEFROMLOSTHP] = FightWorkDamageFromLostHp,
	[FightEnum.EffectType.ENCHANTBURNDAMAGE] = FightWorkEffectEnchantBurnDamage,
	[FightEnum.EffectType.DEAD] = FightWorkEffectDeadPerformance,
	[FightEnum.EffectType.BLOODLUST] = FightWorkEffectHeal,
	[FightEnum.EffectType.ADDACT] = FightWorkEffectAddAct,
	[FightEnum.EffectType.SHIELD] = FightWorkEffectShield,
	[FightEnum.EffectType.BEATBACK] = FightWorkEffectDamage,
	[FightEnum.EffectType.DAMAGEEXTRA] = FightWorkDamageExtra,
	[FightEnum.EffectType.SHIELDCHANGE] = FightWorkEffectShieldChange,
	[FightEnum.EffectType.UNIVERSALCARD] = FightWorkEffectUniversalCard,
	[FightEnum.EffectType.DEALCARD1] = FightWorkEffectDealCard1,
	[FightEnum.EffectType.DEALCARD2] = FightWorkEffectDistributeCard,
	[FightEnum.EffectType.ROUNDEND] = FightWorkEffectRoundEnd,
	[FightEnum.EffectType.SHIELDDEL] = FightWorkEffectShieldDel,
	[FightEnum.EffectType.MONSTERCHANGE] = FightWorkEffectMonsterChange,
	[FightEnum.EffectType.REDEALCARD] = FightWorkEffectRedealCard,
	[FightEnum.EffectType.CARDLEVELCHANGE] = FightWorkEffectCardLevelChange,
	[FightEnum.EffectType.EXTRAMOVEACT] = FightWorkEffectExtraMoveAct,
	[FightEnum.EffectType.CARDEFFECTCHANGE] = FightWorkEffectCardEffectChange,
	[FightEnum.EffectType.SUMMON] = FightWorkEffectSummon,
	[FightEnum.EffectType.SKILLWEIGHTSELECT] = FightWorkEffectDice,
	[FightEnum.EffectType.EXPOINTMAXADD] = FightWorkEffectExpointMaxAdd,
	[FightEnum.EffectType.CLEARUNIVERSALCARD] = FightWorkRemoveUnivesalCards,
	[FightEnum.EffectType.CARDDISAPPEAR] = FightWorkCardDisappear,
	[FightEnum.EffectType.MAXHPCHANGE] = FightWorkMaxHpChange,
	[FightEnum.EffectType.CURRENTHPCHANGE] = FightWorkCurrentHpChange,
	[FightEnum.EffectType.KILL] = FightWorkKill,
	[FightEnum.EffectType.EXPOINTCHANGE] = FightWorkExPointChange,
	[FightEnum.EffectType.EXSKILLPOINTCHANGE] = FightWorkExSkillPointChange,
	[FightEnum.EffectType.INDICATORCHANGE] = FightWorkIndicatorChange,
	[FightEnum.EffectType.MULTIHPCHANGE] = FightWorkMultiHpChange,
	[FightEnum.EffectType.SPCARDADD] = FightWorkSpCardAdd,
	[FightEnum.EffectType.TRIGGER] = FightWorkTrigger,
	[FightEnum.EffectType.POWERMAXADD] = FightWorkEffectPowerMaxAdd,
	[FightEnum.EffectType.POWERCHANGE] = FightWorkEffectPowerChange,
	[FightEnum.EffectType.ORIGINDAMAGE] = FightWorkOriginDamage,
	[FightEnum.EffectType.ORIGINCRIT] = FightWorkOriginCrit,
	[FightEnum.EffectType.SHIELDBROCKEN] = FightWorkEffectShieldBroken,
	[FightEnum.EffectType.CARDREMOVE] = FightWorkCardRemove,
	[FightEnum.EffectType.CARDREMOVE2] = FightWorkCardRemove2,
	[FightEnum.EffectType.SUMMONEDADD] = FightWorkSummonedAdd,
	[FightEnum.EffectType.SUMMONEDDELETE] = FightWorkSummonedDelete,
	[FightEnum.EffectType.SUMMONEDLEVELUP] = FightWorkSummonedLevelUp,
	[FightEnum.EffectType.MAGICCIRCLEADD] = FightWorkMagicCircleAdd,
	[FightEnum.EffectType.MAGICCIRCLEDELETE] = FightWorkMagicCircleDelete,
	[FightEnum.EffectType.MAGICCIRCLEUPDATE] = FightWorkMagicCircleUpdate,
	[FightEnum.EffectType.MAGICCIRCLEUPGRADE] = FightWorkMagicCircleUpgrade340,
	[FightEnum.EffectType.CHANGETOTEMPCARD] = FightWorkChangeToTempCard,
	[FightEnum.EffectType.MASTERPOWERCHANGE] = FightWorkMasterPowerChange,
	[FightEnum.EffectType.ADDHANDCARD] = FightWorkAddHandCard,
	[FightEnum.EffectType.REMOVEENTITYCARDS] = FightWorkRemoveEntityCards,
	[FightEnum.EffectType.CARDSCOMPOSE] = FightWorkCardsCompose,
	[FightEnum.EffectType.BFSGCONVERTCARD] = FightWorkBFSGConvertCard,
	[FightEnum.EffectType.BFSGUSECARD] = FightWorkBFSGUseCard,
	[FightEnum.EffectType.BFSGSKILLEND] = FightWorkBFSGSkillEnd,
	[FightEnum.EffectType.USECARDS] = FightWorkUseCards,
	[FightEnum.EffectType.CARDINVALID] = FightWorkCardInvalid,
	[FightEnum.EffectType.CARDSPUSH] = FightWorkCardsPush,
	[FightEnum.EffectType.BFSGSKILLSTART] = FightWorkBFSGSkillStart,
	[FightEnum.EffectType.CARDACONVERTCARDB] = FightWorkCardAConvertCardB,
	[FightEnum.EffectType.HEROUPGRADE] = FightWorkHeroUpgrade,
	[FightEnum.EffectType.NOTIFYUPGRADEHERO] = FightWorkNotifyUpgradeHero,
	[FightEnum.EffectType.ROUGEPOWERLIMITCHANGE] = FightWorkRougePowerLimitChange,
	[FightEnum.EffectType.ROUGEPOWERCHANGE] = FightWorkRougePowerChange,
	[FightEnum.EffectType.ROUGECOINCHANGE] = FightWorkRougeCoinChange,
	[FightEnum.EffectType.STORAGEINJURY] = FightWorkStorageInjury,
	[FightEnum.EffectType.DAMAGEFROMABSORB] = FightWorkDamageFromAbsorb,
	[FightEnum.EffectType.INJURYBANKHEAL] = FightWorkInjuryBankHeal,
	[FightEnum.EffectType.MASTERCARDREMOVE] = FightWorkMasterCardRemove,
	[FightEnum.EffectType.MASTERADDHANDCARD] = FightWorkMasterAddHandCard,
	[FightEnum.EffectType.FIGHTCOUNTER] = FightWorkFightCounter,
	[FightEnum.EffectType.CHANGECAREER] = FightWorkChangeCareer,
	[FightEnum.EffectType.POLARIZATIONLEVEL] = FightWorkPolarizationLevel,
	[FightEnum.EffectType.RESONANCELEVEL] = FightWorkResonanceLevel,
	[FightEnum.EffectType.MOVE] = FightWorkMove,
	[FightEnum.EffectType.MOVEFRONT] = FightWorkMoveFront,
	[FightEnum.EffectType.MOVEBACK] = FightWorkMoveBack,
	[FightEnum.EffectType.CHANGEROUND] = FightWorkChangeRound,
	[FightEnum.EffectType.FIGHTSTEP] = FightWorkFightStep,
	[FightEnum.EffectType.ADDUSECARD] = FightWorkAddUseCard,
	[FightEnum.EffectType.PLAYAROUNDUPRANK] = FightWorkPlayAroundUpRank,
	[FightEnum.EffectType.PLAYAROUNDDOWNRANK] = FightWorkPlayAroundDownRank,
	[FightEnum.EffectType.PLAYSETGRAY] = FightWorkPlaySetGray,
	[FightEnum.EffectType.EXPOINTOVERFLOWBANK] = FightWorkUpdateStoredExPoint,
	[FightEnum.EffectType.CHANGEHERO] = FightWorkChangeHero,
	[FightEnum.EffectType.SHIELDVALUECHANGE] = FightWorkShieldValueChange,
	[FightEnum.EffectType.PLAYCHANGERANKFAIL] = FightWorkPlayChangeRankFail,
	[FightEnum.EffectType.STRESSTRIGGER] = FightWorkTriggerStress,
	[FightEnum.EffectType.RESISTANCES] = FightWorkTriggerResistance,
	[FightEnum.EffectType.ENTERFIGHTDEAL] = FightWorkEnterFightDeal,
	[FightEnum.EffectType.LAYERHALOSYNC] = FightWorkLayerHaloSync,
	[FightEnum.EffectType.SUBHEROLIFECHANGE] = FightWorkSubHeroLifeChange,
	[FightEnum.EffectType.GUARDCHANGE] = FightWorkGuardChange,
	[FightEnum.EffectType.ENTITYSYNC] = FightWorkEntitySync,
	[FightEnum.EffectType.NOTIFIYHEROCONTRACT] = FightWorkNotifyBindContract,
	[FightEnum.EffectType.SPEXPOINTMAXADD] = FightWorkEffectSpExpointMaxAdd,
	[FightEnum.EffectType.GUARDBREAK] = FightWorkEffectGuardBreak,
	[FightEnum.EffectType.CARDDECKGENERATE] = FightWorkCardDeckGenerate,
	[FightEnum.EffectType.CARDDECKDELETE] = FightWorkCardDeckDelete,
	[FightEnum.EffectType.CARDDECKCLEAR] = FightWorkCardClear,
	[FightEnum.EffectType.CARDDECKNUM] = FightWorkCardDeckNum,
	[FightEnum.EffectType.DELCARDANDDAMAGE] = FightWorkDelCardAndDamage,
	[FightEnum.EffectType.PROGRESSCHANGE] = FightWorkProgressChange,
	[FightEnum.EffectType.ASSISTBOSSSKILLCD] = FightWorkChangeAssistBossCD,
	[FightEnum.EffectType.DAMAGESHAREHP] = FightWorkDamageShareHp,
	[FightEnum.EffectType.PROGRESSMAXCHANGE] = FightWorkProgressMaxChange,
	[FightEnum.EffectType.ASSISTBOSSSKILLCHANGE] = FightWorkAssistBossSkillChange,
	[FightEnum.EffectType.ASSISTBOSSCHANGE] = FightWorkAssistBossChange,
	[FightEnum.EffectType.ZXQREMOVECARD] = FightWorkZXQRemoveCard,
	[FightEnum.EffectType.ADDITIONALDAMAGE] = FightWorkAdditionalDamage,
	[FightEnum.EffectType.ADDITIONALDAMAGECRIT] = FightWorkAdditionalDamageCrit,
	[FightEnum.EffectType.ACT174FIRST] = FightWorkAct174First,
	[FightEnum.EffectType.ACT174USECARD] = FightWorkAct174UseCard,
	[FightEnum.EffectType.CHANGESHIELD] = FightWorkChangeShield,
	[FightEnum.EffectType.TOWERSCORECHANGE] = FightWorkTowerScoreChangeWork,
	[FightEnum.EffectType.ACT174MONSTERAICARD] = FightWorkAct174MonsterAiCard,
	[FightEnum.EffectType.AFTERREDEALCARD] = FightWorkAfterRedealCard,
	[FightEnum.EffectType.SHAREHURT] = FightWorkShareHurt,
	[FightEnum.EffectType.PLAYERFINISHERSKILLCHANGE] = FightWorkPlayerFinisherSkillChange,
	[FightEnum.EffectType.SIMPLEPOLARIZATIONLEVEL] = FightWorkSimplePolarizationLevel,
	[FightEnum.EffectType.CALLMONSTERTOSUB] = FightWorkCallMonsterToSub,
	[FightEnum.EffectType.AVERAGELIFE] = FightWorkAverageLife,
	[FightEnum.EffectType.POWERINFOCHANGE] = FightWorkPowerInfoChange,
	[FightEnum.EffectType.CARDHEATINIT] = FightWorkCardHeatinit,
	[FightEnum.EffectType.CARDHEATVALUECHANGE] = FightWorkCardHeatValueChange,
	[FightEnum.EffectType.ENCHANTDEPRESSEDAMAGE] = FightWorkEnchantDepresseDamage314,
	[FightEnum.EffectType.ADDSPHANDCARD] = FightWorkAddSpHandCard320,
	[FightEnum.EffectType.CLEARMONSTERSUB] = FightWorkClearMonsterSub322,
	[FightEnum.EffectType.FIGHTTASKUPDATE] = FightWorkFightTaskUpdate323,
	[FightEnum.EffectType.REMOVEMONSTERSUB] = FightWorkRemoveMonsterSub325,
	[FightEnum.EffectType.ADDCARDRECORDBYROUND] = FightWorkAddRecordCard,
	[FightEnum.EffectType.FIGHTPARAMCHANGE] = FightWorkFightParamChange330,
	[FightEnum.EffectType.BLOODPOOLMAXCREATE] = FightWorkCreateBloodPool333,
	[FightEnum.EffectType.BLOODPOOLMAXCHANGE] = FightWorkBloodPoolMaxChange334,
	[FightEnum.EffectType.BLOODPOOLVALUECHANGE] = FightWorkBloodPoolValueChange335,
	[FightEnum.EffectType.COLDSATURDAYHURT] = FightWorkColdSaturdayHurt336,
	[FightEnum.EffectType.NEWCHANGEWAVE] = FightWorkNewChangeWave337,
	[FightEnum.EffectType.CLIENTEFFECT] = FightWorkClientEffect339,
	[FightEnum.EffectType.NUODIKARANDOMATTACK] = FightWorkNuoDiKaRandomAttack341,
	[FightEnum.EffectType.NUODIKATEAMATTACK] = FightWorkNuoDiKaTeamAttack342,
	[FightEnum.EffectType.NUODIKARANDOMATTACKNUM] = FightWorkNuoDiKaRandomAttackNum349,
	[FightEnum.EffectType.BUFFACTINFOUPDATE] = FightWorkBuffActInfoUpdate350,
	[FightEnum.EffectType.CURE] = FightBuffTriggerEffect,
	[FightEnum.EffectType.DOT] = FightBuffTriggerEffect,
	[FightEnum.EffectType.REBOUND] = FightBuffTriggerEffect,
	[FightEnum.EffectType.EXPOINTFIX] = FightBuffTriggerEffect,
	[FightEnum.EffectType.ADDTOATTACKER] = FightBuffTriggerEffect,
	[FightEnum.EffectType.ADDTOTARGET] = FightBuffTriggerEffect,
	[FightEnum.EffectType.DODGESPECSKILL] = FightBuffTriggerEffect,
	[FightEnum.EffectType.DODGESPECSKILL2] = FightBuffTriggerEffect,
	[FightEnum.EffectType.EXPOINTADD] = FightBuffTriggerEffect,
	[FightEnum.EffectType.EXPOINTDEL] = FightBuffTriggerEffect,
	[FightEnum.EffectType.IMMUNITY] = FightBuffTriggerEffect,
	[FightEnum.EffectType.EMITTERCREATE] = FightWorkCreateEmitterEntity,
	[FightEnum.EffectType.EMITTERENERGYCHANGE] = FightWorkEmitterEnergyChange,
	[FightEnum.EffectType.EMITTERREMOVE] = FightWorkEmitterRemove,
	[FightEnum.EffectType.TEAMENERGYCHANGE] = FightWorkTeamEnergyChange,
	[FightEnum.EffectType.ALLOCATECARDENERGY] = FightWorkAllocateCardEnergy,
	[FightEnum.EffectType.CHANGECARDENERGY] = FightWorkChangeCardEnergy,
	[FightEnum.EffectType.REDORBLUECOUNTCHANGE] = FightWorkRedOrBlueCountChange,
	[FightEnum.EffectType.REDORBLUECOUNTEXSKILL] = FightWorkRedOrBlueCountExSkill,
	[FightEnum.EffectType.TOCARDAREAREDORBLUE] = FightWorkToCardAreaRedOrBlue,
	[FightEnum.EffectType.REDORBLUECHANGETRIGGER] = FightWorkRedOrBlueChangeTrigger,
	[FightEnum.EffectType.TRIGGERANALYSIS] = FightWorkTriggerAnalysis343,
	[FightEnum.EffectType.GETSECRETKEY] = FightWorkGetSecretKey344,
	[FightEnum.EffectType.SAVEFIGHTRECORDUPDATE] = FightWorkSaveFightRecordUpdate,
	[FightEnum.EffectType.ROUNDOFFSET] = FightWorkRoundOffset,
	[FightEnum.EffectType.EZIOBIGSKILLDAMAGE] = FightWorkEzioBigSkillDamage1000,
	[FightEnum.EffectType.EZIOBIGSKILLORIGINDAMAGE] = FightWorkEzioBigSkillOriginDamage1001,
	[FightEnum.EffectType.UPDATEITEMPLAYERSKILL] = FightWorkUpdateItemPlayerSkill1002,
	[FightEnum.EffectType.EZIOBIGSKILLEXIT] = FightWorkEzioBigSkillExit1003,
	[FightEnum.EffectType.SURVIVALHEALTHCHANGE] = FightWorkSurvivalHealthChange345,
	[FightEnum.EffectType.REALDAMAGEKILL] = FightWorkRealDamageKill351,
	[FightEnum.EffectType.BUFFDELREASON] = FightWorkBuffDelReason352,
	[FightEnum.EffectType.RANDOMDICEUSESKILL] = FightWorkRandomDiceUseSkill353,
	[FightEnum.EffectType.TOWERDEEPCHANGE] = FightWorkTowerDeepChange354
}
var_0_0.EffectType2FlowOrWork = {
	[FightEnum.EffectType.ADDSPHANDCARD] = FightWorkAddSpHandCard320Container,
	[FightEnum.EffectType.SPCARDADD] = FightWorkSpCardAddContainer,
	[FightEnum.EffectType.BUFFADD] = FightWorkBuffAddContainer,
	[FightEnum.EffectType.DEAD] = FightWorkDeadContainer,
	[FightEnum.EffectType.SKILLWEIGHTSELECT] = FightWorkSkillWeightSelectContainer,
	[FightEnum.EffectType.KILL] = FightWorkKillContainer,
	[FightEnum.EffectType.SUMMON] = FightWorkEffectSummonContainer,
	[FightEnum.EffectType.INJURYBANKHEAL] = FightWorkInjuryBankHealContainer,
	[FightEnum.EffectType.ADDHANDCARD] = FightWorkAddHandCardContainer,
	[FightEnum.EffectType.CARDACONVERTCARDB] = FightWorkCardAConvertCardBContainer,
	[FightEnum.EffectType.MASTERADDHANDCARD] = FightWorkMasterAddHandCardContainer,
	[FightEnum.EffectType.MASTERCARDREMOVE] = FightWorkMasterCardRemoveContainer,
	[FightEnum.EffectType.REMOVEENTITYCARDS] = FightWorkRemoveEntityCardsContainer,
	[FightEnum.EffectType.CLEARUNIVERSALCARD] = FightWorkRemoveUnivesalCardsContainer,
	[FightEnum.EffectType.CARDINVALID] = FightWorkCardInvalidContainer,
	[FightEnum.EffectType.CARDLEVELCHANGE] = FightWorkEffectCardLevelChangeContainer,
	[FightEnum.EffectType.CARDREMOVE] = FightWorkCardRemoveContainer,
	[FightEnum.EffectType.CARDREMOVE2] = FightWorkCardRemove2Container,
	[FightEnum.EffectType.ADDUSECARD] = FightWorkAddUseCardContainer,
	[FightEnum.EffectType.CHANGEHERO] = FightWorkChangeHeroContainer,
	[FightEnum.EffectType.PLAYAROUNDUPRANK] = FightWorkPlayAroundUpRankContainer,
	[FightEnum.EffectType.PLAYAROUNDDOWNRANK] = FightWorkPlayAroundDownRankContainer,
	[FightEnum.EffectType.PLAYCHANGERANKFAIL] = FightWorkPlayChangeRankFailContainer,
	[FightEnum.EffectType.GUARDBREAK] = FightWorkEffectGuardBreakContainer,
	[FightEnum.EffectType.ZXQREMOVECARD] = FightWorkZXQRemoveCardContainer,
	[FightEnum.EffectType.DEADLYPOISONORIGINDAMAGE] = FightWorkDeadlyPoisonContainer,
	[FightEnum.EffectType.DEADLYPOISONORIGINCRIT] = FightWorkDeadlyPoisonCritContainer,
	[FightEnum.EffectType.COLDSATURDAYHURT] = FightWorkColdSaturdayHurt336Container
}

setmetatable(var_0_0.EffectType2FlowOrWork, {
	__index = var_0_0.ActEffectWorkCls
})

function var_0_0.buildStepWorkList(arg_1_0)
	if not arg_1_0 then
		return
	end

	FightSkillBuffMgr.instance:clearCompleteBuff()

	var_0_0.ASFDIndex = 0

	local var_1_0
	local var_1_1 = {}
	local var_1_2 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
		if iter_1_1.actType == FightEnum.ActType.SKILL then
			if FightHelper.isASFDSkill(iter_1_1.actId) then
				local var_1_3 = arg_1_0[iter_1_0 + 1]

				var_0_0._buildASFDSkillWork(iter_1_1, var_1_1, var_1_2, var_1_3)
			else
				var_1_0 = var_0_0._buildSkillWork(arg_1_0, iter_1_1, var_1_0, arg_1_0[iter_1_0 + 1], var_1_1, var_1_2)
			end
		elseif iter_1_1.actType == FightEnum.ActType.EFFECT then
			tabletool.addValues(var_1_1, var_0_0._buildEffectWorks(iter_1_1, nil))

			for iter_1_2, iter_1_3 in ipairs(iter_1_1.actEffect) do
				if iter_1_3.effectType == FightEnum.EffectType.DEALCARD1 or iter_1_3.effectType == FightEnum.EffectType.DEALCARD2 or iter_1_3.effectType == FightEnum.EffectType.ROUNDEND or iter_1_3.effectType == FightEnum.EffectType.NEWCHANGEWAVE then
					if iter_1_3.effectType == FightEnum.EffectType.NEWCHANGEWAVE then
						FightDataHelper.tempMgr.hasNextWave = true

						FightController.instance:dispatchEvent(FightEvent.HaveNextWave)
					end

					var_1_0 = nil

					break
				end
			end

			table.insert(var_1_1, FunctionWork.New(function()
				iter_1_1.hasPlay = true
			end))
		elseif iter_1_1.actType == FightEnum.ActType.CHANGEHERO then
			var_1_0 = nil

			local var_1_4 = tabletool.copy(var_1_2)

			table.insert(var_1_1, FightWorkWaitForSkillsDone.New(var_1_4))
			table.insert(var_1_1, FightWorkStepChangeHero.New(iter_1_1))
			table.insert(var_1_1, FunctionWork.New(function()
				iter_1_1.hasPlay = true
			end))
		elseif iter_1_1.actType == FightEnum.ActType.CHANGEWAVE then
			var_1_0 = nil

			local var_1_5 = tabletool.copy(var_1_2)

			table.insert(var_1_1, FightWorkWaitForSkillsDone.New(var_1_5))
			table.insert(var_1_1, FightWorkStepChangeWave.New())
			table.insert(var_1_1, FightWorkAppearTimeline.New())
			table.insert(var_1_1, FightWorkStartBornEnemy.New())
			table.insert(var_1_1, FightWorkFocusMonster.New())
			table.insert(var_1_1, FunctionWork.New(function()
				iter_1_1.hasPlay = true

				FightController.instance:beginWave()
			end))
		else
			logError("step actType not implement: " .. iter_1_1.actType)
		end
	end

	return var_1_1, var_1_2
end

function var_0_0._buildSkillWork(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	table.insert(arg_5_4, FightGuideBeforeSkill.New(arg_5_1))

	local var_5_0 = FightDataHelper.entityMgr:getById(arg_5_1.fromId)
	local var_5_1 = var_5_0 and var_5_0.skin
	local var_5_2 = FightConfig.instance:getSkinSkillTimeline(var_5_1, arg_5_1.actId)

	if not string.nilorempty(var_5_2) then
		local var_5_3 = FightWorkFbStory.checkHasFbStory()

		if var_5_3 then
			table.insert(arg_5_4, FightWorkFbStory.New(FightWorkFbStory.Type_BeforePlaySkill, arg_5_1.actId))
		end

		table.insert(arg_5_4, FightWorkShowEquipSkillEffect.New(arg_5_1, arg_5_3))

		local var_5_4 = FightSkillFlow.New(arg_5_1)

		table.insert(arg_5_4, var_5_4)
		table.insert(arg_5_5, var_5_4)
		var_5_4:addAfterSkillEffects(var_0_0._buildEffectWorks(arg_5_1))

		if var_5_3 then
			table.insert(arg_5_4, FightWorkFbStory.New(FightWorkFbStory.Type_AfterPlaySkill, arg_5_1.actId))
		end

		table.insert(arg_5_4, FightParallelPlayNextSkillStep.New(arg_5_1, arg_5_2, arg_5_0))
		table.insert(arg_5_4, FightNextSkillIsSameStep.New(arg_5_1, arg_5_2))

		arg_5_2 = arg_5_1
	else
		table.insert(arg_5_4, FightWorkShowEquipSkillEffect.New(arg_5_1, arg_5_3))
		table.insert(arg_5_4, FightNonTimelineSkillStep.New(arg_5_1))
		tabletool.addValues(arg_5_4, var_0_0._buildEffectWorks(arg_5_1))
	end

	table.insert(arg_5_4, FunctionWork.New(function()
		arg_5_1.hasPlay = true

		FightController.instance:dispatchEvent(FightEvent.OnSkillEffectPlayFinish, arg_5_1)
	end))
	table.insert(arg_5_4, FightWorkSkillDelay.New(arg_5_1))
	table.insert(arg_5_4, FightWorkSpecialDelay.New(arg_5_1))

	return arg_5_2
end

var_0_0.ASFDIndex = 0

function var_0_0._buildASFDSkillWork(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	var_0_0.ASFDIndex = var_0_0.ASFDIndex + 1

	local var_7_0 = FightASFDFlow.New(arg_7_0, arg_7_3, var_0_0.ASFDIndex)

	table.insert(arg_7_1, var_7_0)
	table.insert(arg_7_2, var_7_0)

	return var_7_0
end

var_0_0.lastEffect = nil

function var_0_0._buildEffectWorks(arg_8_0)
	var_0_0.lastEffect = nil

	local var_8_0 = FightWorkFlowSequence.New()

	var_0_0.addEffectWork(var_8_0, arg_8_0)

	var_0_0.lastEffect = nil

	local var_8_1 = FightStepEffectWork.New()

	var_8_1:setFlow(var_8_0)

	return {
		var_8_1
	}
end

function var_0_0.addEffectWork(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1.actEffect) do
		local var_9_0 = iter_9_1.effectType
		local var_9_1 = false

		if var_9_0 == FightEnum.EffectType.FIGHTSTEP and not iter_9_1.fightStep then
			var_9_1 = true
		end

		if not var_9_1 then
			local var_9_2 = var_0_0.EffectType2FlowOrWork[var_9_0]

			if var_9_2 then
				local var_9_3 = arg_9_0:registWork(var_9_2, arg_9_1, iter_9_1)

				if var_0_0.lastEffect then
					var_0_0.lastEffect.nextActEffectData = iter_9_1
				end

				var_0_0.lastEffect = iter_9_1

				if var_9_0 == FightEnum.EffectType.FIGHTSTEP then
					local var_9_4 = FightWorkFlowSequence.New()

					var_0_0.addEffectWork(var_9_4, iter_9_1.fightStep)
					var_9_3:setFlow(var_9_4)

					iter_9_1.fightStepNextActEffectData = arg_9_1.actEffect[iter_9_0 + 1]
				end
			end
		end
	end
end

return var_0_0
