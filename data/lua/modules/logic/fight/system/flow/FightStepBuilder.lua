module("modules.logic.fight.system.flow.FightStepBuilder", package.seeall)

slot0 = class("FightStepBuilder")
slot0.ActEffectWorkCls = {
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
	[FightEnum.EffectType.REDORBLUECOUNTCHANGE] = FightWorkRedOrBlueCountChange,
	[FightEnum.EffectType.REDORBLUECOUNTEXSKILL] = FightWorkRedOrBlueCountExSkill,
	[FightEnum.EffectType.TOCARDAREAREDORBLUE] = FightWorkToCardAreaRedOrBlue,
	[FightEnum.EffectType.REDORBLUECHANGETRIGGER] = FightWorkRedOrBlueChangeTrigger,
	[FightEnum.EffectType.SAVEFIGHTRECORDUPDATE] = FightWorkSaveFightRecordUpdate,
	[FightEnum.EffectType.ROUNDOFFSET] = FightWorkRoundOffset
}
slot0.EffectType2FlowOrWork = {
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
	[FightEnum.EffectType.DEADLYPOISONORIGINCRIT] = FightWorkDeadlyPoisonCritContainer
}

setmetatable(slot0.EffectType2FlowOrWork, {
	__index = slot0.ActEffectWorkCls
})

function slot0.buildStepWorkList(slot0)
	if not slot0 then
		return
	end

	FightSkillBuffMgr.instance:clearCompleteBuff()

	uv0.ASFDIndex = 0
	slot1 = nil
	slot2 = {}
	slot3 = {}

	for slot7, slot8 in ipairs(slot0) do
		if slot8.actType == FightEnum.ActType.SKILL then
			if FightHelper.isASFDSkill(slot8.actId) then
				uv0._buildASFDSkillWork(slot8, slot2, slot3, slot0[slot7 + 1])
			else
				slot1 = uv0._buildSkillWork(slot0, slot8, slot1, slot0[slot7 + 1], slot2, slot3)
			end
		elseif slot8.actType == FightEnum.ActType.EFFECT then
			slot12 = slot8
			slot13 = nil

			tabletool.addValues(slot2, uv0._buildEffectWorks(slot12, slot13))

			for slot12, slot13 in ipairs(slot8.actEffectMOs) do
				if slot13.effectType == FightEnum.EffectType.DEALCARD1 or slot13.effectType == FightEnum.EffectType.DEALCARD2 or slot13.effectType == FightEnum.EffectType.ROUNDEND then
					slot1 = nil

					break
				end
			end

			table.insert(slot2, FunctionWork.New(function ()
				uv0.hasPlay = true
			end))
		elseif slot8.actType == FightEnum.ActType.CHANGEHERO then
			slot1 = nil

			table.insert(slot2, FightWorkWaitForSkillsDone.New(tabletool.copy(slot3)))
			table.insert(slot2, FightWorkStepChangeHero.New(slot8))
			table.insert(slot2, FunctionWork.New(function ()
				uv0.hasPlay = true
			end))
		elseif slot8.actType == FightEnum.ActType.CHANGEWAVE then
			slot1 = nil

			table.insert(slot2, FightWorkWaitForSkillsDone.New(tabletool.copy(slot3)))
			table.insert(slot2, FightWorkStepChangeWave.New(slot8))
			table.insert(slot2, FightWorkAppearTimeline.New())
			table.insert(slot2, FightWorkStartBornEnemy.New())
			table.insert(slot2, FightWorkFocusMonster.New())
			table.insert(slot2, FunctionWork.New(function ()
				uv0.hasPlay = true

				FightController.instance:beginWave()
			end))
		else
			logError("step actType not implement: " .. slot8.actType)
		end
	end

	return slot2, slot3
end

function slot0._buildSkillWork(slot0, slot1, slot2, slot3, slot4, slot5)
	table.insert(slot4, FightGuideBeforeSkill.New(slot1))

	if not string.nilorempty(FightConfig.instance:getSkinSkillTimeline(FightDataHelper.entityMgr:getById(slot1.fromId) and slot6.skin, slot1.actId)) then
		if FightWorkFbStory.checkHasFbStory() then
			table.insert(slot4, FightWorkFbStory.New(FightWorkFbStory.Type_BeforePlaySkill, slot1.actId))
		end

		table.insert(slot4, FightWorkShowEquipSkillEffect.New(slot1, slot3))

		slot9 = FightSkillFlow.New(slot1)

		table.insert(slot4, slot9)
		table.insert(slot5, slot9)
		slot9:addAfterSkillEffects(uv0._buildEffectWorks(slot1))
		table.insert(slot4, FightParallelPlayNextSkillStep.New(slot1, slot2, slot0))
		table.insert(slot4, FightNextSkillIsSameStep.New(slot1, slot2))

		slot2 = slot1
	else
		table.insert(slot4, FightWorkShowEquipSkillEffect.New(slot1, slot3))
		table.insert(slot4, FightNonTimelineSkillStep.New(slot1))
		tabletool.addValues(slot4, uv0._buildEffectWorks(slot1))
	end

	table.insert(slot4, FunctionWork.New(function ()
		uv0.hasPlay = true

		FightController.instance:dispatchEvent(FightEvent.OnSkillEffectPlayFinish, uv0)
	end))
	table.insert(slot4, FightWorkSkillDelay.New(slot1))
	table.insert(slot4, FightWorkSpecialDelay.New(slot1))

	return slot2
end

slot0.ASFDIndex = 0

function slot0._buildASFDSkillWork(slot0, slot1, slot2, slot3)
	uv0.ASFDIndex = uv0.ASFDIndex + 1
	slot4 = FightASFDFlow.New(slot0, slot3, uv0.ASFDIndex)

	table.insert(slot1, slot4)
	table.insert(slot2, slot4)

	return slot4
end

slot0.lastEffect = nil

function slot0._buildEffectWorks(slot0)
	uv0.lastEffect = nil
	slot1 = FightWorkFlowSequence.New(slot0)

	uv0.addEffectWork(slot1, slot0)

	uv0.lastEffect = nil
	slot2 = FightStepEffectWork.New()

	slot2:setFlow(slot1)

	return {
		slot2
	}
end

function slot0.addEffectWork(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.actEffectMOs) do
		slot8 = false

		if slot6.effectType == FightEnum.EffectType.FIGHTSTEP and not slot6.fightStep then
			slot8 = true
		end

		if not slot8 and uv0.EffectType2FlowOrWork[slot7] then
			slot10 = slot0:registWork(slot9, slot1, slot6)

			if uv0.lastEffect then
				uv0.lastEffect.NEXTEFFECT = slot6
			end

			uv0.lastEffect = slot6

			if slot7 == FightEnum.EffectType.FIGHTSTEP then
				slot11 = FightWorkFlowSequence.New()

				uv0.addEffectWork(slot11, slot6.cus_stepMO)
				slot10:setFlow(slot11)

				slot6.FIGHTSTEPNEXTEFFECT = slot1.actEffectMOs[slot5 + 1]
			end
		end
	end
end

return slot0
