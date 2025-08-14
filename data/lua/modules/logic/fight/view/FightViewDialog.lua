module("modules.logic.fight.view.FightViewDialog", package.seeall)

local var_0_0 = class("FightViewDialog", BaseView)

var_0_0.Type = {
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
	NoCondition = 38,
	NewHeroSpawn = 3
}

local var_0_1

function var_0_0.onInitView(arg_1_0)
	arg_1_0._godialogcontainer = gohelper.findChild(arg_1_0.viewGO, "root/#go_dialogcontainer")
	arg_1_0._godialog = gohelper.findChild(arg_1_0.viewGO, "root/#go_dialogcontainer/#go_dialog")
	arg_1_0._click = gohelper.getClick(arg_1_0._godialogcontainer)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._click:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._godialogcontainer, false)
	gohelper.setActive(arg_4_0._godialog, false)
	gohelper.addChild(arg_4_0.viewGO, arg_4_0._godialogcontainer)

	arg_4_0._dialogItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._godialog, FightViewDialogItem, arg_4_0)
	arg_4_0._toShowConfigList = {}
	arg_4_0._showedDialogIdDict = {}
	arg_4_0._showingItemList = {}

	arg_4_0:_initConfig()

	arg_4_0._playedDeadEnemyMOList = {}
end

function var_0_0._initConfig(arg_5_0)
	arg_5_0._dialogChecks = {}

	local var_5_0 = FightModel.instance:getFightParam()

	if not var_5_0 then
		return
	end

	local var_5_1 = var_5_0.episodeId
	local var_5_2 = var_5_1 and var_5_1 ~= 0 and DungeonModel.instance:hasPassLevel(var_5_1)
	local var_5_3 = var_5_0.battleId

	for iter_5_0, iter_5_1 in ipairs(lua_battle_dialog.configList) do
		if iter_5_1.code == var_5_3 and (not var_5_2 or iter_5_1.canRepeat) then
			local var_5_4 = string.splitToNumber(iter_5_1.param, "#")
			local var_5_5 = {
				type = var_5_4[1],
				param1 = var_5_4[2],
				param2 = var_5_4[3],
				param3 = var_5_4[4],
				param4 = var_5_4[5],
				dialogConfig = iter_5_1
			}

			table.insert(arg_5_0._dialogChecks, var_5_5)
		end
	end
end

function var_0_0._checkShowDialog(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_0:_isReplay() then
		return
	end

	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._dialogChecks) do
		local var_6_1 = iter_6_1.dialogConfig
		local var_6_2 = iter_6_1.type == arg_6_1
		local var_6_3 = var_6_1.insideRepeat or not arg_6_0._showedDialogIdDict[var_6_1.id]
		local var_6_4 = var_6_2 and arg_6_4 and arg_6_4(iter_6_1)
		local var_6_5 = not iter_6_1.param1 or iter_6_1.param1 == arg_6_2
		local var_6_6 = not iter_6_1.param2 or iter_6_1.param2 == arg_6_3

		if var_6_2 and var_6_3 and (var_6_4 or var_6_5 and var_6_6) then
			table.insert(arg_6_0._toShowConfigList, var_6_1)

			arg_6_0._showedDialogIdDict[var_6_1.id] = true
			var_6_0 = var_6_0 + 1
		end
	end

	if var_6_0 <= 0 then
		return
	end

	var_0_0.showFightDialog = true
	arg_6_0._showingType = arg_6_0._showingType or {}
	arg_6_0._showingType[arg_6_1] = true

	if arg_6_0._godialogcontainer.activeInHierarchy then
		return #arg_6_0._toShowConfigList > 0
	else
		return arg_6_0:_tryShow()
	end
end

function var_0_0._playDialogByTrigger(arg_7_0, arg_7_1)
	table.insert(arg_7_0._toShowConfigList, arg_7_1)

	arg_7_0._showingType = arg_7_0._showingType or {}
	arg_7_0._showingType[var_0_0.Type.Trigger] = true

	return arg_7_0:_tryShow()
end

function var_0_0._tryShow(arg_8_0)
	if arg_8_0._audioId then
		AudioEffectMgr.instance:stopAudio(arg_8_0._audioId)

		arg_8_0._audioId = nil
	end

	if #arg_8_0._toShowConfigList <= 0 then
		FightModel.instance:updateRTPCSpeed()

		return false
	end

	gohelper.setActive(arg_8_0._godialogcontainer, true)

	local var_8_0 = arg_8_0._toShowConfigList[1]

	table.remove(arg_8_0._toShowConfigList, 1)

	arg_8_0._tempDialogConfig = var_8_0

	if var_8_0.delay and var_8_0.delay > 0 then
		arg_8_0:_addBlock()
		gohelper.setActive(arg_8_0._godialog, false)
		TaskDispatcher.runDelay(arg_8_0._playDialogItem, arg_8_0, var_8_0.delay)
	else
		arg_8_0:_playDialogItem()
	end

	var_0_0.playingDialog = true

	FightController.instance:dispatchEvent(FightEvent.FightDialogShow, var_8_0)

	return true
end

function var_0_0._playDialogItem(arg_9_0)
	arg_9_0:_removeBlock()
	gohelper.setActive(arg_9_0._godialog, true)

	local var_9_0 = arg_9_0._tempDialogConfig
	local var_9_1

	if not string.nilorempty(var_9_0.icon) then
		var_9_1 = ResUrl.getHeadIconSmall(var_9_0.icon)
	end

	arg_9_0._dialogItem:showDialogContent(var_9_1, var_9_0)

	if var_9_0.audioId and var_9_0.audioId ~= 0 then
		arg_9_0._audioId = var_9_0.audioId

		FightAudioMgr.instance:playAudio(var_9_0.audioId)
		FightModel.instance:resetRTPCSpeedTo1()
	end

	FightController.instance:dispatchEvent(FightEvent.PlayDialog, var_9_0.id)
end

function var_0_0._addBlock(arg_10_0)
	arg_10_0._hasBlockUI = true

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(UIBlockKey.FightDialog)
end

function var_0_0._removeBlock(arg_11_0)
	if arg_11_0._hasBlockUI then
		arg_11_0._hasBlockUI = nil

		UIBlockMgrExtend.setNeedCircleMv(true)
		UIBlockMgr.instance:endBlock(UIBlockKey.FightDialog)
	end
end

function var_0_0._onClickThis(arg_12_0)
	var_0_0.playingDialog = false

	if arg_12_0._tempDialogConfig then
		FightController.instance:dispatchEvent(FightEvent.AfterPlayDialog, arg_12_0._tempDialogConfig.id)
	end

	if not arg_12_0:_tryShow() then
		gohelper.setActive(arg_12_0._godialogcontainer, false)
		gohelper.setActive(arg_12_0._godialog, false)

		local var_12_0 = tabletool.copy(arg_12_0._showingType)

		arg_12_0._showingType = nil

		if var_12_0[var_0_0.Type.BeforeSkill] then
			FightController.instance:dispatchEvent(FightEvent.DialogContinueSkill)
		end

		if var_12_0[var_0_0.Type.Trigger] then
			FightController.instance:dispatchEvent(FightEvent.TriggerDialogEnd)
		end

		FightController.instance:dispatchEvent(FightEvent.FightDialogEnd)
	end
end

function var_0_0.onOpen(arg_13_0)
	FightController.instance:registerCallback(FightEvent.OnStartSequenceFinish, arg_13_0._onStartSequenceFinish, arg_13_0)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, arg_13_0._onRoundSequenceFinish, arg_13_0)
	FightController.instance:registerCallback(FightEvent.OnStartChangeEntity, arg_13_0._onStartChangeEntity, arg_13_0)
	FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, arg_13_0._beforeDeadEffect1, arg_13_0)
	FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, arg_13_0._beforeDeadEffect2, arg_13_0)
	FightController.instance:registerCallback(FightEvent.OnStartFightPlayBornNormal, arg_13_0._onStartFightPlayBornNormal, arg_13_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, arg_13_0._onSkillPlayStart, arg_13_0)
	FightController.instance:registerCallback(FightEvent.OnInvokeSkill, arg_13_0._onInvokeSkill, arg_13_0)
	FightController.instance:registerCallback(FightEvent.BeforeSkillDialog, arg_13_0._beforeSkill, arg_13_0)
	FightController.instance:registerCallback(FightEvent.FightDialog, arg_13_0._onFightDialogCheck, arg_13_0)
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, arg_13_0._onBuffUpdate, arg_13_0)
end

function var_0_0.onClose(arg_14_0)
	var_0_0.playingDialog = false

	FightController.instance:unregisterCallback(FightEvent.OnStartSequenceFinish, arg_14_0._onStartSequenceFinish, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, arg_14_0._onRoundSequenceFinish, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.OnStartChangeEntity, arg_14_0._onStartChangeEntity, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, arg_14_0._beforeDeadEffect1, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, arg_14_0._beforeDeadEffect2, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.OnStartFightPlayBornNormal, arg_14_0._onStartFightPlayBornNormal, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, arg_14_0._onSkillPlayStart, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.OnInvokeSkill, arg_14_0._onInvokeSkill, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.BeforeSkillDialog, arg_14_0._beforeSkill, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.FightDialog, arg_14_0._onFightDialogCheck, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, arg_14_0._onBuffUpdate, arg_14_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_14_0._onCloseSpecialView, arg_14_0)
end

function var_0_0._onBuffUpdate(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	if arg_15_2 == FightEnum.EffectType.BUFFADD then
		arg_15_0:_checkShowDialog(var_0_0.Type.BuffAdd, arg_15_3)
	end
end

function var_0_0._isReplay(arg_16_0)
	return FightReplayModel.instance:isReplay()
end

function var_0_0._onStartSequenceFinish(arg_17_0)
	if arg_17_0:_isReplay() then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.FightSpecialTipView) then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_17_0._onCloseSpecialView, arg_17_0)

		return
	end

	local var_17_0 = FightModel.instance:getCurRoundId()

	arg_17_0:_checkShowDialog(var_0_0.Type.RoundStart, var_17_0)
end

function var_0_0._onCloseSpecialView(arg_18_0, arg_18_1)
	if arg_18_1 == ViewName.FightSpecialTipView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_18_0._onCloseSpecialView, arg_18_0)

		local var_18_0 = FightModel.instance:getCurRoundId()

		arg_18_0:_checkShowDialog(var_0_0.Type.RoundStart, var_18_0)
	end
end

function var_0_0._onRoundSequenceFinish(arg_19_0)
	local var_19_0 = FightModel.instance:getCurStage()

	if var_19_0 ~= FightEnum.Stage.Distribute and var_19_0 ~= FightEnum.Stage.Card then
		return
	end

	local var_19_1 = FightModel.instance:getCurRoundId()

	arg_19_0:_checkShowDialog(var_0_0.Type.RoundStart, var_19_1)
end

function var_0_0._onStartChangeEntity(arg_20_0, arg_20_1)
	if not arg_20_1 then
		return
	end

	local var_20_0 = FightModel.instance:getFightParam().mySideSubUids

	if not var_20_0 then
		return
	end

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		if iter_20_1 == arg_20_1.uid then
			arg_20_0:_checkShowDialog(var_0_0.Type.NewHeroSpawn, iter_20_0)

			return
		end
	end
end

function var_0_0._beforeDeadEffect1(arg_21_0, arg_21_1)
	local var_21_0 = FightDataHelper.entityMgr:getById(arg_21_1)

	if not var_21_0 then
		return
	end

	local var_21_1 = FightModel.instance:getFightParam().monsterGroupIds
	local var_21_2 = FightModel.instance:getCurMonsterGroupId()

	for iter_21_0, iter_21_1 in ipairs(var_21_1) do
		if iter_21_1 == var_21_2 then
			break
		end

		local var_21_3 = lua_monster_group.configDict[iter_21_1]
		local var_21_4 = FightStrUtil.instance:getSplitToNumberCache(var_21_3.monster, "#")

		for iter_21_2, iter_21_3 in ipairs(var_21_4) do
			if iter_21_3 == tonumber(var_21_0.modelId) then
				return
			end
		end

		if not string.nilorempty(var_21_3.spMonster) then
			local var_21_5 = FightStrUtil.instance:getSplitToNumberCache(var_21_3.spMonster, "#")

			for iter_21_4, iter_21_5 in ipairs(var_21_5) do
				if iter_21_5 == tonumber(var_21_0.modelId) then
					return
				end
			end
		end
	end

	local var_21_6 = {}

	for iter_21_6, iter_21_7 in ipairs(FightDataHelper.entityMgr:getEnemyNormalList()) do
		if iter_21_7:isStatusDead() then
			table.insert(var_21_6, iter_21_7)
		end
	end

	local var_21_7 = {}

	for iter_21_8, iter_21_9 in ipairs(var_21_6) do
		table.insert(var_21_7, iter_21_9)
	end

	for iter_21_10, iter_21_11 in ipairs(arg_21_0._playedDeadEnemyMOList) do
		table.insert(var_21_7, iter_21_11)
	end

	for iter_21_12, iter_21_13 in ipairs(var_21_7) do
		if iter_21_13.uid ~= var_21_0.uid and iter_21_13.modelId == var_21_0.modelId then
			return
		end

		if iter_21_13.uid == var_21_0.uid then
			break
		end
	end

	table.insert(arg_21_0._playedDeadEnemyMOList, var_21_0)
	arg_21_0:_checkShowDialog(var_0_0.Type.MonsterDie, tonumber(var_21_0.modelId))
end

function var_0_0._beforeDeadEffect2(arg_22_0, arg_22_1)
	local var_22_0 = FightDataHelper.entityMgr:getById(arg_22_1)

	if not var_22_0 then
		return
	end

	if not var_22_0:isCharacter() then
		return
	end

	arg_22_0:_checkShowDialog(var_0_0.Type.CharacterDie)
end

function var_0_0._onStartFightPlayBornNormal(arg_23_0, arg_23_1)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	local var_23_0 = FightDataHelper.entityMgr:getById(arg_23_1)

	if not var_23_0 then
		return
	end

	local var_23_1 = FightModel.instance:getFightParam().monsterGroupIds
	local var_23_2 = FightModel.instance:getCurMonsterGroupId()

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		if iter_23_1 == var_23_2 then
			break
		end

		local var_23_3 = lua_monster_group.configDict[iter_23_1]
		local var_23_4 = FightStrUtil.instance:getSplitToNumberCache(var_23_3.monster, "#")

		for iter_23_2, iter_23_3 in ipairs(var_23_4) do
			if iter_23_3 == tonumber(var_23_0.modelId) then
				return
			end
		end

		if not string.nilorempty(var_23_3.spMonster) then
			local var_23_5 = FightStrUtil.instance:getSplitToNumberCache(var_23_3.spMonster, "#")

			for iter_23_4, iter_23_5 in ipairs(var_23_5) do
				if iter_23_5 == tonumber(var_23_0.modelId) then
					return
				end
			end
		end
	end

	local var_23_6 = {}
	local var_23_7 = FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.EnemySide, nil, true)

	for iter_23_6, iter_23_7 in ipairs(var_23_7) do
		table.insert(var_23_6, iter_23_7)
	end

	for iter_23_8, iter_23_9 in ipairs(var_23_6) do
		if iter_23_9.uid ~= var_23_0.uid and iter_23_9.modelId == var_23_0.modelId then
			return
		end

		if iter_23_9.uid == var_23_0.uid then
			break
		end
	end

	arg_23_0:_checkShowDialog(var_0_0.Type.MonsterSpawn, tonumber(var_23_0.modelId))
end

function var_0_0.onDestroyView(arg_24_0)
	arg_24_0:_removeBlock()
	UIBlockMgr.instance:endBlock(UIBlockKey.FightDialog)
	TaskDispatcher.cancelTask(arg_24_0._playDialogItem, arg_24_0)
	arg_24_0._dialogItem:onDestroy()
end

function var_0_0._onSkillPlayStart(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = FightHelper.getEntity(arg_25_3.fromId)
	local var_25_1 = FightHelper.getEntity(arg_25_3.toId)
	local var_25_2 = var_25_0 and var_25_0:getMO()
	local var_25_3 = var_25_1 and var_25_1:getMO()
	local var_25_4 = var_25_2 and var_25_2.modelId
	local var_25_5 = var_25_3 and var_25_3.modelId

	arg_25_0:_checkShowDialog(var_0_0.Type.AttackStart, var_25_4, var_25_5)
	arg_25_0:_checkShowDialog(var_0_0.Type.SkillStart, arg_25_3.actId)
end

function var_0_0._onInvokeSkill(arg_26_0, arg_26_1)
	arg_26_0:_checkShowDialog(var_0_0.Type.SkillStart, arg_26_1.actId)
end

function var_0_0._beforeSkill(arg_27_0, arg_27_1)
	if arg_27_0:_checkShowDialog(var_0_0.Type.BeforeSkill, arg_27_1) then
		FightWorkStepSkill.needWaitBeforeSkill = true
	end
end

function var_0_0._onFightDialogCheck(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	var_0_0.showFightDialog = nil

	if arg_28_1 == var_0_0.Type.MonsterWave then
		local var_28_0 = arg_28_2

		if arg_28_0:_checkShowDialog(arg_28_1, var_28_0) then
			if var_28_0 == 1 then
				FightStartSequence.needStopMonsterWave = true
			else
				FightWorkStepChangeWave.needStopMonsterWave = true
			end
		end
	elseif arg_28_1 == var_0_0.Type.MonsterWaveEnd then
		local var_28_1 = arg_28_2

		if arg_28_0:_checkShowDialog(arg_28_1, var_28_1) then
			if var_28_1 < FightModel.instance.maxWave then
				FightWorkStepChangeWave.needStopMonsterWave = true
			else
				FightEndSequence.needStopMonsterWave = true
			end
		end
	elseif arg_28_1 == var_0_0.Type.HPRateAfterSkillP then
		if arg_28_0:_checkShowDialog(arg_28_1, nil, nil, arg_28_0._checkHpLessThan) then
			FightWorkStepSkill.needStopSkillEnd = true
		end
	elseif arg_28_1 == var_0_0.Type.HPRateAfterSkillNP then
		arg_28_0:_checkShowDialog(arg_28_1, nil, nil, arg_28_0._checkHpLessThan)
	elseif arg_28_1 == var_0_0.Type.MonsterDieP then
		var_0_1 = arg_28_2

		if var_0_1 and arg_28_0:_checkShowDialog(arg_28_1, nil, nil, arg_28_0._detectMonsterDie) then
			FightWorkEffectDeadNew.needStopDeadWork = true
		end
	elseif arg_28_1 == var_0_0.Type.MonsterWaveEndAndCheckBuffId then
		local var_28_2 = arg_28_2

		if arg_28_0:_checkShowDialog(arg_28_1, var_28_2, nil, arg_28_0._checkMonsterWaveEndAndCheckBuffId) then
			if var_28_2 < FightModel.instance.maxWave then
				FightWorkStepChangeWave.needStopMonsterWave = true
			else
				FightEndSequence.needStopMonsterWave = true
			end
		end
	elseif arg_28_1 == var_0_0.Type.Trigger then
		arg_28_0:_playDialogByTrigger(arg_28_2)
	elseif arg_28_1 == var_0_0.Type.BuffRoundBefore then
		if arg_28_0:_checkShowDialog(arg_28_1, nil, nil, arg_28_0._checkFirstGetBuff) then
			FightWorkShowBuffDialog.needStopWork = arg_28_0._tempDialogConfig
		end
	elseif arg_28_1 == var_0_0.Type.BuffRoundAfter then
		if arg_28_0:_checkShowDialog(arg_28_1, nil, nil, arg_28_0._checkHasBuff) then
			FightWorkShowBuffDialog.needStopWork = arg_28_0._tempDialogConfig
		end
	elseif arg_28_1 == var_0_0.Type.RoundEndAndCheckBuff then
		if arg_28_0:_checkShowDialog(arg_28_1, nil, nil, arg_28_0._checkEntityBuff) then
			FightWorkShowBuffDialog.needStopWork = arg_28_0._tempDialogConfig
		end
	elseif arg_28_1 == var_0_0.Type.checkHaveMagicCircle then
		if arg_28_0:_checkShowDialog(arg_28_1, nil, nil, arg_28_0._checkHaveMagicCircle) and not arg_28_0._playedShuZhen then
			arg_28_0._playedShuZhen = true
			FightWorkShowBuffDialog.needStopWork = arg_28_0._tempDialogConfig
		end
	elseif arg_28_1 == var_0_0.Type.CheckDeadEntityCount then
		local var_28_3 = #FightDataHelper.entityMgr:getDeadList(FightEnum.EntitySide.MySide)

		arg_28_0:_checkShowDialog(arg_28_1, var_28_3)
	elseif arg_28_1 == var_0_0.Type.FightFail then
		arg_28_0:_checkShowDialog(arg_28_1)
	elseif arg_28_1 == var_0_0.Type.BeforeStartFight then
		arg_28_0:_checkShowDialog(arg_28_1)
	elseif arg_28_1 == var_0_0.Type.BeforeMonsterA2B then
		arg_28_0:_checkShowDialog(arg_28_1, arg_28_2)
	elseif arg_28_1 == var_0_0.Type.AfterMonsterA2B then
		arg_28_0:_checkShowDialog(arg_28_1, arg_28_2)
	elseif arg_28_1 == var_0_0.Type.MonsterChangeBefore then
		arg_28_0:_checkShowDialog(arg_28_1, arg_28_2)
	elseif arg_28_1 == var_0_0.Type.MonsterChangeAfter then
		arg_28_0:_checkShowDialog(arg_28_1, arg_28_2)
	elseif arg_28_1 == var_0_0.Type.AfterAppearTimeline then
		arg_28_0:_checkShowDialog(arg_28_1, arg_28_2)
	elseif arg_28_1 == var_0_0.Type.ChangeCareer then
		arg_28_0:_checkShowDialog(arg_28_1)
	elseif arg_28_1 == var_0_0.Type.BossDieTimelineBefore then
		arg_28_0:_checkShowDialog(arg_28_1, arg_28_2)
	elseif arg_28_1 == var_0_0.Type.DeadPerformanceNoCondition then
		arg_28_0:_checkShowDialog(arg_28_1, arg_28_2)
	elseif arg_28_1 == var_0_0.Type.HaveBuffAndHaveDamageSkill_onlyCheckOnce then
		arg_28_0:_onHaveBuffAndHaveDamageSkill_onlyCheckOnce()
	elseif arg_28_1 == var_0_0.Type.DetectHaveCardAfterEndOperation then
		arg_28_0:_onDetectHaveCardAfterEndOperation(arg_28_2)
	elseif arg_28_1 == var_0_0.Type.AfterSummon then
		arg_28_0:_checkShowDialog(arg_28_1, arg_28_2)
	elseif arg_28_1 == var_0_0.Type.Success then
		arg_28_0:_checkShowDialog(arg_28_1, arg_28_2)
	elseif arg_28_1 == var_0_0.Type.BeforeStartFightAndXXTimesEnterBattleId then
		arg_28_0:_checkShowDialog(arg_28_1, nil, nil, arg_28_0._onCheckBeforeStartFightAndXXTimesEnterBattleId)
	elseif arg_28_1 == var_0_0.Type.NoCondition then
		arg_28_0:_checkShowDialog(arg_28_1, arg_28_2)
	end
end

function var_0_0._haveSkillCard(arg_29_0, arg_29_1)
	local var_29_0 = FightDataHelper.operationDataMgr:getOpList()

	for iter_29_0, iter_29_1 in ipairs(var_29_0) do
		if iter_29_1:isPlayCard() and arg_29_1 == iter_29_1.skillId then
			return true
		end
	end
end

function var_0_0._onDetectHaveCardAfterEndOperation(arg_30_0)
	for iter_30_0, iter_30_1 in ipairs(arg_30_0._dialogChecks) do
		local var_30_0 = iter_30_1.dialogConfig

		if iter_30_1.type == var_0_0.Type.DetectHaveCardAfterEndOperation and (var_30_0.insideRepeat or not arg_30_0._showedDialogIdDict[var_30_0.id]) then
			local var_30_1 = iter_30_1.param1
			local var_30_2 = iter_30_1.param2
			local var_30_3 = FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.EnemySide)

			for iter_30_2, iter_30_3 in ipairs(var_30_3) do
				if iter_30_3.side == FightEnum.EntitySide.EnemySide then
					local var_30_4 = iter_30_3:getBuffDic()

					for iter_30_4, iter_30_5 in pairs(var_30_4) do
						if iter_30_5.buffId == var_30_1 then
							if arg_30_0:_haveSkillCard(var_30_2) then
								arg_30_0:_checkShowDialog(iter_30_1.type, var_30_1, var_30_2)
							else
								arg_30_0:_checkShowDialog(var_0_0.Type.DetectFail33, var_30_1, var_30_2)
							end

							arg_30_0._showedDialogIdDict[var_30_0.id] = true
						end
					end
				end
			end
		end
	end
end

function var_0_0._detectStepIsDamgeSkill(arg_31_0, arg_31_1)
	if arg_31_1.actType == FightEnum.ActType.SKILL or arg_31_1.actType == FightEnum.ActType.EFFECT then
		if arg_31_1.actType == FightEnum.ActType.SKILL and arg_31_1.fromId ~= FightEntityScene.MySideId then
			local var_31_0 = FightHelper.getEntity(arg_31_1.fromId)

			if var_31_0 and var_31_0:isMySide() then
				local var_31_1 = lua_skill.configDict[arg_31_1.actId]

				if var_31_1 and var_31_1.damageRate > 0 then
					return true
				end
			end
		end

		if arg_31_0:_haveDamageSkillactEffect(arg_31_1.actEffect) then
			return true
		end
	end
end

function var_0_0._haveDamageSkill(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(arg_32_1) do
		if arg_32_0:_detectStepIsDamgeSkill(iter_32_1) then
			return true
		end
	end
end

function var_0_0._haveDamageSkillactEffect(arg_33_0, arg_33_1)
	for iter_33_0, iter_33_1 in ipairs(arg_33_1) do
		local var_33_0 = iter_33_1.fightStep

		if var_33_0 and arg_33_0:_detectStepIsDamgeSkill(var_33_0) then
			return
		end
	end
end

function var_0_0._onCheckBeforeStartFightAndXXTimesEnterBattleId(arg_34_0)
	local var_34_0 = FightDataHelper.fieldMgr.battleId

	if var_34_0 == arg_34_0.param1 then
		local var_34_1 = PlayerPrefsKey.EnterBattleIdTimes .. var_34_0
		local var_34_2 = PlayerPrefsHelper.getNumber(var_34_1, 0) + 1

		PlayerPrefsHelper.setNumber(var_34_1, var_34_2)

		if var_34_2 >= arg_34_0.param2 then
			return true
		end
	end
end

function var_0_0._onHaveBuffAndHaveDamageSkill_onlyCheckOnce(arg_35_0)
	for iter_35_0, iter_35_1 in ipairs(arg_35_0._dialogChecks) do
		local var_35_0 = iter_35_1.dialogConfig

		if iter_35_1.type == var_0_0.Type.HaveBuffAndHaveDamageSkill_onlyCheckOnce and (var_35_0.insideRepeat or not arg_35_0._showedDialogIdDict[var_35_0.id]) then
			local var_35_1 = iter_35_1.param1
			local var_35_2 = FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.EnemySide)

			for iter_35_2, iter_35_3 in ipairs(var_35_2) do
				if iter_35_3.side == FightEnum.EntitySide.EnemySide then
					local var_35_3 = iter_35_3:getBuffDic()

					for iter_35_4, iter_35_5 in pairs(var_35_3) do
						if iter_35_5.buffId == var_35_1 then
							local var_35_4 = FightDataHelper.roundMgr:getRoundData()

							if var_35_4 and arg_35_0:_haveDamageSkill(var_35_4.fightStep) then
								arg_35_0:_checkShowDialog(iter_35_1.type, var_35_1)
							else
								arg_35_0:_checkShowDialog(var_0_0.Type.DetectFail31, var_35_1)
							end

							arg_35_0._showedDialogIdDict[var_35_0.id] = true
						end
					end
				end
			end
		end
	end
end

function var_0_0._checkFirstGetBuff(arg_36_0)
	local var_36_0 = arg_36_0.param1

	var_0_0._checkBuffState(var_36_0)

	local var_36_1 = arg_36_0.param2

	if not FightWorkShowBuffDialog.addBuffRoundId and var_36_1 == FightModel.instance:getCurRoundId() then
		return true
	end
end

function var_0_0._checkEntityBuff(arg_37_0)
	local var_37_0 = arg_37_0.param1

	if var_0_0._hasBuff(var_37_0) then
		return true
	end
end

function var_0_0._checkHaveMagicCircle(arg_38_0)
	local var_38_0 = FightModel.instance:getMagicCircleInfo()

	if var_38_0.magicCircleId then
		if var_38_0.magicCircleId == arg_38_0.param1 then
			return true
		end

		if var_38_0.magicCircleId == arg_38_0.param2 then
			return true
		end

		if var_38_0.magicCircleId == arg_38_0.param3 then
			return true
		end

		if var_38_0.magicCircleId == arg_38_0.param4 then
			return true
		end
	end
end

function var_0_0._checkHasBuff(arg_39_0)
	local var_39_0 = arg_39_0.param1

	var_0_0._checkBuffState(var_39_0)

	local var_39_1 = FightModel.instance:getCurRoundId()
	local var_39_2 = arg_39_0.param2

	if FightWorkShowBuffDialog.addBuffRoundId and not FightWorkShowBuffDialog.delBuffRoundId then
		return var_39_2 == var_39_1 - FightWorkShowBuffDialog.addBuffRoundId + 1
	end
end

function var_0_0._checkBuffState(arg_40_0)
	local var_40_0 = FightModel.instance:getCurRoundId()

	if var_0_0._hasBuff(arg_40_0) then
		if not FightWorkShowBuffDialog.addBuffRoundId then
			FightWorkShowBuffDialog.addBuffRoundId = var_40_0
		end
	elseif FightWorkShowBuffDialog.addBuffRoundId and not FightWorkShowBuffDialog.delBuffRoundId then
		FightWorkShowBuffDialog.delBuffRoundId = var_40_0
	end
end

function var_0_0._hasBuff(arg_41_0)
	local var_41_0 = FightHelper.getAllEntitys()

	for iter_41_0, iter_41_1 in ipairs(var_41_0) do
		local var_41_1 = iter_41_1:getMO():getBuffDic()

		for iter_41_2, iter_41_3 in pairs(var_41_1) do
			if iter_41_3.buffId == arg_41_0 then
				return true
			end
		end
	end
end

local var_0_2

function var_0_0._checkHpLessThan(arg_42_0)
	local var_42_0 = arg_42_0.type
	local var_42_1 = arg_42_0.param1
	local var_42_2 = arg_42_0.param2
	local var_42_3 = arg_42_0.param3
	local var_42_4 = arg_42_0.param4

	var_0_2 = nil

	if var_42_2 == 0 then
		local var_42_5 = var_42_1 == 1 and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide

		var_0_2 = FightHelper.getSideEntitys(var_42_5, false)
	else
		local var_42_6 = GameSceneMgr.instance:getCurScene().entityMgr
		local var_42_7 = var_42_1 == 1 and SceneTag.UnitMonster or SceneTag.UnitPlayer
		local var_42_8 = var_42_6:getEntityByPosId(var_42_7, var_42_2)

		var_0_2 = var_0_2 or {}

		tabletool.clear(var_0_2)

		if var_42_8 then
			table.insert(var_0_2, var_42_8)
		end
	end

	for iter_42_0, iter_42_1 in ipairs(var_0_2) do
		local var_42_9 = iter_42_1:getMO()

		if (var_42_9 and var_42_9.currentHp or 0) / (var_42_9.attrMO and var_42_9.attrMO.hp > 0 and var_42_9.attrMO.hp or 1) < var_42_3 / 1000 then
			if var_42_4 then
				if var_42_4 == var_42_9.modelId then
					return true
				end
			else
				return true
			end
		end
	end
end

function var_0_0._checkMonsterWaveEndAndCheckBuffId(arg_43_0)
	if FightModel.instance:getCurWaveId() ~= arg_43_0.param1 then
		return
	end

	local var_43_0 = arg_43_0.param2
	local var_43_1 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)

	for iter_43_0, iter_43_1 in ipairs(var_43_1) do
		local var_43_2 = iter_43_1:getMO()
		local var_43_3 = var_43_2 and var_43_2:getBuffDic()

		if var_43_3 then
			for iter_43_2, iter_43_3 in pairs(var_43_3) do
				if iter_43_3.buffId == var_43_0 then
					return true
				end
			end
		end
	end
end

function var_0_0._detectMonsterDie(arg_44_0)
	local var_44_0 = FightStrUtil.instance:getSplitToNumberCache(arg_44_0.dialogConfig.param, "#")

	for iter_44_0 = 2, #var_44_0 do
		if var_0_1 == var_44_0[iter_44_0] then
			return true
		end
	end
end

return var_0_0
