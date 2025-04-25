module("modules.logic.fight.view.FightViewDialog", package.seeall)

slot0 = class("FightViewDialog", BaseView)
slot0.Type = {
	BeforeSkill = 10,
	MonsterSpawn = 1,
	MonsterDieP = 16,
	AttackStart = 5,
	MonsterWave = 11,
	SkillStart = 7,
	RoundStart = 4,
	DetectFail31 = 32,
	BeforeMonsterA2B = 25,
	RoundEndAndCheckBuff = 22,
	BuffRoundAfter = 19,
	MonsterWaveEnd = 12,
	Success = 36,
	Trigger = 999,
	MonsterWaveEndAndCheckBuffId = 17,
	BuffAdd = 13,
	BuffRoundBefore = 18,
	HPRateAfterSkillP = 14,
	CharacterDie = 6,
	FightFail = 21,
	MonsterChangeAfter = 9,
	BossDieTimelineBefore = 29,
	DetectFail33 = 34,
	CheckDeadEntityCount = 20,
	MonsterChangeBefore = 8,
	MonsterDie = 2,
	HPRateAfterSkillNP = 15,
	checkHaveMagicCircle = 23,
	HaveBuffAndHaveDamageSkill_onlyCheckOnce = 31,
	AfterSummon = 35,
	BeforeStartFightAndXXTimesEnterBattleId = 37,
	DetectHaveCardAfterEndOperation = 33,
	BeforeStartFight = 24,
	AfterAppearTimeline = 27,
	ChangeCareer = 28,
	DeadPerformanceNoCondition = 30,
	AfterMonsterA2B = 26,
	NewHeroSpawn = 3
}
slot1 = nil

function slot0.onInitView(slot0)
	slot0._godialogcontainer = gohelper.findChild(slot0.viewGO, "root/#go_dialogcontainer")
	slot0._godialog = gohelper.findChild(slot0.viewGO, "root/#go_dialogcontainer/#go_dialog")
	slot0._click = gohelper.getClick(slot0._godialogcontainer)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._click:AddClickListener(slot0._onClickThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._click:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._godialogcontainer, false)
	gohelper.setActive(slot0._godialog, false)

	slot0._dialogItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._godialog, FightViewDialogItem, slot0)
	slot0._toShowConfigList = {}
	slot0._showedDialogIdDict = {}
	slot0._showingItemList = {}

	slot0:_initConfig()

	slot0._playedDeadEnemyMOList = {}
end

function slot0._initConfig(slot0)
	slot0._dialogChecks = {}

	if not FightModel.instance:getFightParam() then
		return
	end

	for slot8, slot9 in ipairs(lua_battle_dialog.configList) do
		if slot9.code == slot1.battleId and (not (slot1.episodeId and slot2 ~= 0 and DungeonModel.instance:hasPassLevel(slot2)) or slot9.canRepeat) then
			slot10 = string.splitToNumber(slot9.param, "#")

			table.insert(slot0._dialogChecks, {
				type = slot10[1],
				param1 = slot10[2],
				param2 = slot10[3],
				param3 = slot10[4],
				param4 = slot10[5],
				dialogConfig = slot9
			})
		end
	end
end

function slot0._checkShowDialog(slot0, slot1, slot2, slot3, slot4)
	if slot0:_isReplay() then
		return
	end

	for slot9, slot10 in ipairs(slot0._dialogChecks) do
		slot11 = slot10.dialogConfig
		slot12 = slot10.type == slot1

		if slot12 and (slot11.insideRepeat or not slot0._showedDialogIdDict[slot11.id]) and (slot12 and slot4 and slot4(slot10) or (not slot10.param1 or slot10.param1 == slot2) and (not slot10.param2 or slot10.param2 == slot3)) then
			table.insert(slot0._toShowConfigList, slot11)

			slot0._showedDialogIdDict[slot11.id] = true
			slot5 = 0 + 1
		end
	end

	if slot5 <= 0 then
		return
	end

	uv0.showFightDialog = true
	slot0._showingType = slot0._showingType or {}
	slot0._showingType[slot1] = true

	if slot0._godialogcontainer.activeInHierarchy then
		return #slot0._toShowConfigList > 0
	else
		return slot0:_tryShow()
	end
end

function slot0._playDialogByTrigger(slot0, slot1)
	table.insert(slot0._toShowConfigList, slot1)

	slot0._showingType = slot0._showingType or {}
	slot0._showingType[uv0.Type.Trigger] = true

	return slot0:_tryShow()
end

function slot0._tryShow(slot0)
	if slot0._audioId then
		AudioEffectMgr.instance:stopAudio(slot0._audioId)

		slot0._audioId = nil
	end

	if #slot0._toShowConfigList <= 0 then
		FightModel.instance:updateRTPCSpeed()

		return false
	end

	gohelper.setActive(slot0._godialogcontainer, true)

	slot1 = slot0._toShowConfigList[1]

	table.remove(slot0._toShowConfigList, 1)

	slot0._tempDialogConfig = slot1

	if slot1.delay and slot1.delay > 0 then
		slot0:_addBlock()
		gohelper.setActive(slot0._godialog, false)
		TaskDispatcher.runDelay(slot0._playDialogItem, slot0, slot1.delay)
	else
		slot0:_playDialogItem()
	end

	uv0.playingDialog = true

	FightController.instance:dispatchEvent(FightEvent.FightDialogShow, slot1)

	return true
end

function slot0._playDialogItem(slot0)
	slot0:_removeBlock()
	gohelper.setActive(slot0._godialog, true)

	slot2 = nil

	if not string.nilorempty(slot0._tempDialogConfig.icon) then
		slot2 = ResUrl.getHeadIconSmall(slot1.icon)
	end

	slot0._dialogItem:showDialogContent(slot2, slot1)

	if slot1.audioId and slot1.audioId ~= 0 then
		slot0._audioId = slot1.audioId

		FightAudioMgr.instance:playAudio(slot1.audioId)
		FightModel.instance:resetRTPCSpeedTo1()
	end

	FightController.instance:dispatchEvent(FightEvent.PlayDialog, slot1.id)
end

function slot0._addBlock(slot0)
	slot0._hasBlockUI = true

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(UIBlockKey.FightDialog)
end

function slot0._removeBlock(slot0)
	if slot0._hasBlockUI then
		slot0._hasBlockUI = nil

		UIBlockMgrExtend.setNeedCircleMv(true)
		UIBlockMgr.instance:endBlock(UIBlockKey.FightDialog)
	end
end

function slot0._onClickThis(slot0)
	uv0.playingDialog = false

	if slot0._tempDialogConfig then
		FightController.instance:dispatchEvent(FightEvent.AfterPlayDialog, slot0._tempDialogConfig.id)
	end

	if not slot0:_tryShow() then
		gohelper.setActive(slot0._godialogcontainer, false)
		gohelper.setActive(slot0._godialog, false)

		slot0._showingType = nil

		if tabletool.copy(slot0._showingType)[uv0.Type.BeforeSkill] then
			FightController.instance:dispatchEvent(FightEvent.DialogContinueSkill)
		end

		if slot1[uv0.Type.Trigger] then
			FightController.instance:dispatchEvent(FightEvent.TriggerDialogEnd)
		end

		FightController.instance:dispatchEvent(FightEvent.FightDialogEnd)
	end
end

function slot0.onOpen(slot0)
	FightController.instance:registerCallback(FightEvent.OnStartSequenceFinish, slot0._onStartSequenceFinish, slot0)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	FightController.instance:registerCallback(FightEvent.OnStartChangeEntity, slot0._onStartChangeEntity, slot0)
	FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, slot0._beforeDeadEffect1, slot0)
	FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, slot0._beforeDeadEffect2, slot0)
	FightController.instance:registerCallback(FightEvent.OnStartFightPlayBornNormal, slot0._onStartFightPlayBornNormal, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:registerCallback(FightEvent.OnInvokeSkill, slot0._onInvokeSkill, slot0)
	FightController.instance:registerCallback(FightEvent.BeforeSkillDialog, slot0._beforeSkill, slot0)
	FightController.instance:registerCallback(FightEvent.FightDialog, slot0._onFightDialogCheck, slot0)
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
end

function slot0.onClose(slot0)
	uv0.playingDialog = false

	FightController.instance:unregisterCallback(FightEvent.OnStartSequenceFinish, slot0._onStartSequenceFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnStartChangeEntity, slot0._onStartChangeEntity, slot0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, slot0._beforeDeadEffect1, slot0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, slot0._beforeDeadEffect2, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnStartFightPlayBornNormal, slot0._onStartFightPlayBornNormal, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnInvokeSkill, slot0._onInvokeSkill, slot0)
	FightController.instance:unregisterCallback(FightEvent.BeforeSkillDialog, slot0._beforeSkill, slot0)
	FightController.instance:unregisterCallback(FightEvent.FightDialog, slot0._onFightDialogCheck, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onCloseSpecialView, slot0)
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot2 == FightEnum.EffectType.BUFFADD then
		slot0:_checkShowDialog(uv0.Type.BuffAdd, slot3)
	end
end

function slot0._isReplay(slot0)
	return FightReplayModel.instance:isReplay()
end

function slot0._onStartSequenceFinish(slot0)
	if slot0:_isReplay() then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.FightSpecialTipView) then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCloseSpecialView, slot0)

		return
	end

	slot0:_checkShowDialog(uv0.Type.RoundStart, FightModel.instance:getCurRoundId())
end

function slot0._onCloseSpecialView(slot0, slot1)
	if slot1 == ViewName.FightSpecialTipView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onCloseSpecialView, slot0)
		slot0:_checkShowDialog(uv0.Type.RoundStart, FightModel.instance:getCurRoundId())
	end
end

function slot0._onRoundSequenceFinish(slot0)
	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Distribute and slot1 ~= FightEnum.Stage.Card then
		return
	end

	slot0:_checkShowDialog(uv0.Type.RoundStart, FightModel.instance:getCurRoundId())
end

function slot0._onStartChangeEntity(slot0, slot1)
	if not slot1 then
		return
	end

	if not FightModel.instance:getFightParam().mySideSubUids then
		return
	end

	for slot7, slot8 in ipairs(slot3) do
		if slot8 == slot1.uid then
			slot0:_checkShowDialog(uv0.Type.NewHeroSpawn, slot7)

			return
		end
	end
end

function slot0._beforeDeadEffect1(slot0, slot1)
	if not FightDataHelper.entityMgr:getById(slot1) then
		return
	end

	for slot9, slot10 in ipairs(FightModel.instance:getFightParam().monsterGroupIds) do
		if slot10 == FightModel.instance:getCurMonsterGroupId() then
			break
		end

		for slot16, slot17 in ipairs(FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[slot10].monster, "#")) do
			if slot17 == tonumber(slot2.modelId) then
				return
			end
		end

		if not string.nilorempty(slot11.spMonster) then
			for slot17, slot18 in ipairs(FightStrUtil.instance:getSplitToNumberCache(slot11.spMonster, "#")) do
				if slot18 == tonumber(slot2.modelId) then
					return
				end
			end
		end
	end

	slot6 = {}

	for slot10, slot11 in ipairs(FightDataHelper.entityMgr:getEnemyNormalList()) do
		if slot11:isStatusDead() then
			table.insert(slot6, slot11)
		end
	end

	for slot11, slot12 in ipairs(slot6) do
		table.insert({}, slot12)
	end

	for slot11, slot12 in ipairs(slot0._playedDeadEnemyMOList) do
		table.insert(slot7, slot12)
	end

	for slot11, slot12 in ipairs(slot7) do
		if slot12.uid ~= slot2.uid and slot12.modelId == slot2.modelId then
			return
		end

		if slot12.uid == slot2.uid then
			break
		end
	end

	table.insert(slot0._playedDeadEnemyMOList, slot2)
	slot0:_checkShowDialog(uv0.Type.MonsterDie, tonumber(slot2.modelId))
end

function slot0._beforeDeadEffect2(slot0, slot1)
	if not FightDataHelper.entityMgr:getById(slot1) then
		return
	end

	if not slot2:isCharacter() then
		return
	end

	slot0:_checkShowDialog(uv0.Type.CharacterDie)
end

function slot0._onStartFightPlayBornNormal(slot0, slot1)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	if not FightDataHelper.entityMgr:getById(slot1) then
		return
	end

	for slot9, slot10 in ipairs(FightModel.instance:getFightParam().monsterGroupIds) do
		if slot10 == FightModel.instance:getCurMonsterGroupId() then
			break
		end

		for slot16, slot17 in ipairs(FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[slot10].monster, "#")) do
			if slot17 == tonumber(slot2.modelId) then
				return
			end
		end

		if not string.nilorempty(slot11.spMonster) then
			for slot17, slot18 in ipairs(FightStrUtil.instance:getSplitToNumberCache(slot11.spMonster, "#")) do
				if slot18 == tonumber(slot2.modelId) then
					return
				end
			end
		end
	end

	slot6 = {}
	slot11 = true

	for slot11, slot12 in ipairs(FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.EnemySide, nil, slot11)) do
		table.insert(slot6, slot12)
	end

	for slot11, slot12 in ipairs(slot6) do
		if slot12.uid ~= slot2.uid and slot12.modelId == slot2.modelId then
			return
		end

		if slot12.uid == slot2.uid then
			break
		end
	end

	slot0:_checkShowDialog(uv0.Type.MonsterSpawn, tonumber(slot2.modelId))
end

function slot0.onDestroyView(slot0)
	slot0:_removeBlock()
	UIBlockMgr.instance:endBlock(UIBlockKey.FightDialog)
	TaskDispatcher.cancelTask(slot0._playDialogItem, slot0)
	slot0._dialogItem:onDestroy()
end

function slot0._onSkillPlayStart(slot0, slot1, slot2, slot3)
	slot5 = FightHelper.getEntity(slot3.toId)
	slot6 = FightHelper.getEntity(slot3.fromId) and slot4:getMO()
	slot7 = slot5 and slot5:getMO()

	slot0:_checkShowDialog(uv0.Type.AttackStart, slot6 and slot6.modelId, slot7 and slot7.modelId)
	slot0:_checkShowDialog(uv0.Type.SkillStart, slot3.actId)
end

function slot0._onInvokeSkill(slot0, slot1)
	slot0:_checkShowDialog(uv0.Type.SkillStart, slot1.actId)
end

function slot0._beforeSkill(slot0, slot1)
	if slot0:_checkShowDialog(uv0.Type.BeforeSkill, slot1) then
		FightWorkStepSkill.needWaitBeforeSkill = true
	end
end

function slot0._onFightDialogCheck(slot0, slot1, slot2, slot3, slot4)
	uv0.showFightDialog = nil

	if slot1 == uv0.Type.MonsterWave then
		if slot0:_checkShowDialog(slot1, slot2) then
			if slot5 == 1 then
				FightStartSequence.needStopMonsterWave = true
			else
				FightWorkStepChangeWave.needStopMonsterWave = true
			end
		end
	elseif slot1 == uv0.Type.MonsterWaveEnd then
		if slot0:_checkShowDialog(slot1, slot2) then
			if slot5 < FightModel.instance.maxWave then
				FightWorkStepChangeWave.needStopMonsterWave = true
			else
				FightEndSequence.needStopMonsterWave = true
			end
		end
	elseif slot1 == uv0.Type.HPRateAfterSkillP then
		if slot0:_checkShowDialog(slot1, nil, , slot0._checkHpLessThan) then
			FightWorkStepSkill.needStopSkillEnd = true
		end
	elseif slot1 == uv0.Type.HPRateAfterSkillNP then
		slot0:_checkShowDialog(slot1, nil, , slot0._checkHpLessThan)
	elseif slot1 == uv0.Type.MonsterDieP then
		uv1 = slot2

		if uv1 and slot0:_checkShowDialog(slot1, nil, , slot0._detectMonsterDie) then
			FightWorkEffectDeadNew.needStopDeadWork = true
		end
	elseif slot1 == uv0.Type.MonsterWaveEndAndCheckBuffId then
		if slot0:_checkShowDialog(slot1, slot2, nil, slot0._checkMonsterWaveEndAndCheckBuffId) then
			if slot5 < FightModel.instance.maxWave then
				FightWorkStepChangeWave.needStopMonsterWave = true
			else
				FightEndSequence.needStopMonsterWave = true
			end
		end
	elseif slot1 == uv0.Type.Trigger then
		slot0:_playDialogByTrigger(slot2)
	elseif slot1 == uv0.Type.BuffRoundBefore then
		if slot0:_checkShowDialog(slot1, nil, , slot0._checkFirstGetBuff) then
			FightWorkShowBuffDialog.needStopWork = slot0._tempDialogConfig
		end
	elseif slot1 == uv0.Type.BuffRoundAfter then
		if slot0:_checkShowDialog(slot1, nil, , slot0._checkHasBuff) then
			FightWorkShowBuffDialog.needStopWork = slot0._tempDialogConfig
		end
	elseif slot1 == uv0.Type.RoundEndAndCheckBuff then
		if slot0:_checkShowDialog(slot1, nil, , slot0._checkEntityBuff) then
			FightWorkShowBuffDialog.needStopWork = slot0._tempDialogConfig
		end
	elseif slot1 == uv0.Type.checkHaveMagicCircle then
		if slot0:_checkShowDialog(slot1, nil, , slot0._checkHaveMagicCircle) and not slot0._playedShuZhen then
			slot0._playedShuZhen = true
			FightWorkShowBuffDialog.needStopWork = slot0._tempDialogConfig
		end
	elseif slot1 == uv0.Type.CheckDeadEntityCount then
		slot0:_checkShowDialog(slot1, #FightDataHelper.entityMgr:getDeadList(FightEnum.EntitySide.MySide))
	elseif slot1 == uv0.Type.FightFail then
		slot0:_checkShowDialog(slot1)
	elseif slot1 == uv0.Type.BeforeStartFight then
		slot0:_checkShowDialog(slot1)
	elseif slot1 == uv0.Type.BeforeMonsterA2B then
		slot0:_checkShowDialog(slot1, slot2)
	elseif slot1 == uv0.Type.AfterMonsterA2B then
		slot0:_checkShowDialog(slot1, slot2)
	elseif slot1 == uv0.Type.MonsterChangeBefore then
		slot0:_checkShowDialog(slot1, slot2)
	elseif slot1 == uv0.Type.MonsterChangeAfter then
		slot0:_checkShowDialog(slot1, slot2)
	elseif slot1 == uv0.Type.AfterAppearTimeline then
		slot0:_checkShowDialog(slot1, slot2)
	elseif slot1 == uv0.Type.ChangeCareer then
		slot0:_checkShowDialog(slot1)
	elseif slot1 == uv0.Type.BossDieTimelineBefore then
		slot0:_checkShowDialog(slot1, slot2)
	elseif slot1 == uv0.Type.DeadPerformanceNoCondition then
		slot0:_checkShowDialog(slot1, slot2)
	elseif slot1 == uv0.Type.HaveBuffAndHaveDamageSkill_onlyCheckOnce then
		slot0:_onHaveBuffAndHaveDamageSkill_onlyCheckOnce()
	elseif slot1 == uv0.Type.DetectHaveCardAfterEndOperation then
		slot0:_onDetectHaveCardAfterEndOperation(slot2)
	elseif slot1 == uv0.Type.AfterSummon then
		slot0:_checkShowDialog(slot1, slot2)
	elseif slot1 == uv0.Type.Success then
		slot0:_checkShowDialog(slot1, slot2)
	elseif slot1 == uv0.Type.BeforeStartFightAndXXTimesEnterBattleId then
		slot0:_checkShowDialog(slot1, nil, , slot0._onCheckBeforeStartFightAndXXTimesEnterBattleId)
	end
end

function slot0._haveSkillCard(slot0, slot1)
	for slot6, slot7 in ipairs(FightCardModel.instance:getCardOps()) do
		if slot7:isPlayCard() and slot1 == slot7.skillId then
			return true
		end
	end
end

function slot0._onDetectHaveCardAfterEndOperation(slot0)
	for slot4, slot5 in ipairs(slot0._dialogChecks) do
		slot6 = slot5.dialogConfig

		if slot5.type == uv0.Type.DetectHaveCardAfterEndOperation and (slot6.insideRepeat or not slot0._showedDialogIdDict[slot6.id]) then
			slot9 = slot5.param1
			slot10 = slot5.param2

			for slot15, slot16 in ipairs(FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.EnemySide)) do
				if slot16.side == FightEnum.EntitySide.EnemySide then
					for slot22, slot23 in pairs(slot16:getBuffDic()) do
						if slot23.buffId == slot9 then
							if slot0:_haveSkillCard(slot10) then
								slot0:_checkShowDialog(slot5.type, slot9, slot10)
							else
								slot0:_checkShowDialog(uv0.Type.DetectFail33, slot9, slot10)
							end

							slot0._showedDialogIdDict[slot6.id] = true
						end
					end
				end
			end
		end
	end
end

function slot0._detectStepIsDamgeSkill(slot0, slot1)
	if slot1.actType == FightEnum.ActType.SKILL or slot1.actType == FightEnum.ActType.EFFECT then
		if slot1.actType == FightEnum.ActType.SKILL and slot1.fromId ~= FightEntityScene.MySideId and FightHelper.getEntity(slot1.fromId) and slot2:isMySide() and lua_skill.configDict[slot1.actId] and slot3.damageRate > 0 then
			return true
		end

		if slot0:_haveDamageSkillActEffectMOS(slot1.actEffectMOs) then
			return true
		end
	end
end

function slot0._haveDamageSkill(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0:_detectStepIsDamgeSkill(slot6) then
			return true
		end
	end
end

function slot0._haveDamageSkillActEffectMOS(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot6.cus_stepMO and slot0:_detectStepIsDamgeSkill(slot7) then
			return
		end
	end
end

function slot0._onCheckBeforeStartFightAndXXTimesEnterBattleId(slot0)
	if FightDataHelper.fieldMgr.battleId == slot0.param1 then
		slot3 = PlayerPrefsKey.EnterBattleIdTimes .. slot1
		slot4 = PlayerPrefsHelper.getNumber(slot3, 0) + 1

		PlayerPrefsHelper.setNumber(slot3, slot4)

		if slot0.param2 <= slot4 then
			return true
		end
	end
end

function slot0._onHaveBuffAndHaveDamageSkill_onlyCheckOnce(slot0)
	for slot4, slot5 in ipairs(slot0._dialogChecks) do
		slot6 = slot5.dialogConfig

		if slot5.type == uv0.Type.HaveBuffAndHaveDamageSkill_onlyCheckOnce and (slot6.insideRepeat or not slot0._showedDialogIdDict[slot6.id]) then
			slot9 = slot5.param1

			for slot14, slot15 in ipairs(FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.EnemySide)) do
				if slot15.side == FightEnum.EntitySide.EnemySide then
					for slot21, slot22 in pairs(slot15:getBuffDic()) do
						if slot22.buffId == slot9 then
							if slot0:_haveDamageSkill(FightModel.instance:getCurRoundMO().fightStepMOs) then
								slot0:_checkShowDialog(slot5.type, slot9)
							else
								slot0:_checkShowDialog(uv0.Type.DetectFail31, slot9)
							end

							slot0._showedDialogIdDict[slot6.id] = true
						end
					end
				end
			end
		end
	end
end

function slot0._checkFirstGetBuff(slot0)
	uv0._checkBuffState(slot0.param1)

	if not FightWorkShowBuffDialog.addBuffRoundId and slot0.param2 == FightModel.instance:getCurRoundId() then
		return true
	end
end

function slot0._checkEntityBuff(slot0)
	if uv0._hasBuff(slot0.param1) then
		return true
	end
end

function slot0._checkHaveMagicCircle(slot0)
	if FightModel.instance:getMagicCircleInfo().magicCircleId then
		if slot1.magicCircleId == slot0.param1 then
			return true
		end

		if slot1.magicCircleId == slot0.param2 then
			return true
		end

		if slot1.magicCircleId == slot0.param3 then
			return true
		end

		if slot1.magicCircleId == slot0.param4 then
			return true
		end
	end
end

function slot0._checkHasBuff(slot0)
	uv0._checkBuffState(slot0.param1)

	if FightWorkShowBuffDialog.addBuffRoundId and not FightWorkShowBuffDialog.delBuffRoundId then
		return slot0.param2 == FightModel.instance:getCurRoundId() - FightWorkShowBuffDialog.addBuffRoundId + 1
	end
end

function slot0._checkBuffState(slot0)
	if uv0._hasBuff(slot0) then
		if not FightWorkShowBuffDialog.addBuffRoundId then
			FightWorkShowBuffDialog.addBuffRoundId = FightModel.instance:getCurRoundId()
		end
	elseif FightWorkShowBuffDialog.addBuffRoundId and not FightWorkShowBuffDialog.delBuffRoundId then
		FightWorkShowBuffDialog.delBuffRoundId = slot1
	end
end

function slot0._hasBuff(slot0)
	for slot5, slot6 in ipairs(FightHelper.getAllEntitys()) do
		for slot11, slot12 in pairs(slot6:getMO():getBuffDic()) do
			if slot12.buffId == slot0 then
				return true
			end
		end
	end
end

slot2 = nil

function slot0._checkHpLessThan(slot0)
	slot1 = slot0.type
	slot4 = slot0.param3
	slot5 = slot0.param4
	uv0 = nil

	if slot0.param2 == 0 then
		uv0 = FightHelper.getSideEntitys(slot0.param1 == 1 and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide, false)
	else
		uv0 = uv0 or {}

		tabletool.clear(uv0)

		if GameSceneMgr.instance:getCurScene().entityMgr:getEntityByPosId(slot2 == 1 and SceneTag.UnitMonster or SceneTag.UnitPlayer, slot3) then
			table.insert(uv0, slot8)
		end
	end

	for slot9, slot10 in ipairs(uv0) do
		if (slot10:getMO() and slot11.currentHp or 0) / (slot11.attrMO and slot11.attrMO.hp > 0 and slot11.attrMO.hp or 1) < slot4 / 1000 then
			if slot5 then
				if slot5 == slot11.modelId then
					return true
				end
			else
				return true
			end
		end
	end
end

function slot0._checkMonsterWaveEndAndCheckBuffId(slot0)
	if FightModel.instance:getCurWaveId() ~= slot0.param1 then
		return
	end

	slot2 = slot0.param2

	for slot7, slot8 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)) do
		if slot8:getMO() and slot9:getBuffDic() then
			for slot14, slot15 in pairs(slot10) do
				if slot15.buffId == slot2 then
					return true
				end
			end
		end
	end
end

function slot0._detectMonsterDie(slot0)
	for slot5 = 2, #FightStrUtil.instance:getSplitToNumberCache(slot0.dialogConfig.param, "#") do
		if uv0 == slot1[slot5] then
			return true
		end
	end
end

return slot0
