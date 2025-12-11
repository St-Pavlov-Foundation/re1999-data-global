module("modules.logic.fight.system.work.FightWorkPlay2Operate", package.seeall)

local var_0_0 = class("FightWorkPlay2Operate", FightWorkItem)

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.isStart = arg_1_1
	arg_1_0.isClothSkill = arg_1_2
end

function var_0_0.onStart(arg_2_0)
	FightViewPartVisible.set(true, true, true, false, false)

	local var_2_0 = arg_2_0:com_registFlowSequence()

	var_2_0:registFinishCallback(arg_2_0.exitPlay, arg_2_0)

	var_2_0.CALLBACK_EVEN_IF_UNFINISHED = true

	if not arg_2_0.isClothSkill then
		var_2_0:registWork(FightWorkRefreshEnemyAiUseCard)
	end

	if FightDataHelper.stateMgr.isReplay then
		arg_2_0:playWorkAndDone(var_2_0)

		return
	end

	if FightDataHelper.fieldMgr:isDouQuQu() then
		arg_2_0:playWorkAndDone(var_2_0)

		return
	end

	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		arg_2_0:playWorkAndDone(var_2_0)

		return
	end

	if FightModel.instance:isFinish() then
		arg_2_0:playWorkAndDone(var_2_0)

		return
	end

	if FightMsgMgr.sendMsg(FightMsgId.CheckGuideBeforeOperate) then
		var_2_0:registWork(FightWorkFunction, arg_2_0.isGuiding, arg_2_0)
		arg_2_0:playWorkAndDone(var_2_0)

		return
	end

	local var_2_1 = FightModel.instance:getCurRoundId()

	var_2_0:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.RoundStart, var_2_1))

	if FightDataHelper.stateMgr:getIsAuto() then
		var_2_0:registWork(FightWorkRequestAutoFight)
	else
		var_2_0:registWork(FightWorkCheckUseAiJiAoQte)
		var_2_0:registWork(FightWorkClearAiJiAoQteTempData)
		var_2_0:registWork(FightWorkCheckNewSeasonSubSkill)
		var_2_0:registWork(FightWorkCheckNaNaBindContract)
		var_2_0:registWork(FightWorkCheckLuXiHeroUpgrade)
	end

	arg_2_0:playWorkAndDone(var_2_0)
end

function var_0_0.isGuiding(arg_3_0)
	FightDataHelper.stateMgr:setAutoState(false)
	FightDataHelper.stageMgr:setStage(FightStageMgr.StageType.Operate)
	FightMsgMgr.sendMsg(FightMsgId.ContinueGuideBeforeOperate)
end

function var_0_0.exitPlay(arg_4_0)
	FightDataHelper.stageMgr:setStage(FightStageMgr.StageType.Operate)
end

return var_0_0
