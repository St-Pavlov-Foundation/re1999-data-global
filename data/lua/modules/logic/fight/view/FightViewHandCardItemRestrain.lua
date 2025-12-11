module("modules.logic.fight.view.FightViewHandCardItemRestrain", package.seeall)

local var_0_0 = class("FightViewHandCardItemRestrain", LuaCompBase)

var_0_0.RestrainMvStatus = {
	Restrain = 2,
	BeRestrain = 3,
	None = 1
}

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._subViewInst = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.tr = arg_2_1.transform

	gohelper.setActive(gohelper.findChild(arg_2_0.go, "foranim/restrain"), true)

	arg_2_0._restrainGO = gohelper.findChild(arg_2_0.go, "foranim/restrain/restrain")
	arg_2_0._beRestrainGO = gohelper.findChild(arg_2_0.go, "foranim/restrain/beRestrain")
	arg_2_0._restrainAnimator = arg_2_0._restrainGO:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._beRestrainAnimator = arg_2_0._beRestrainGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.SelectSkillTarget, arg_3_0._onSelectSkillTarget, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.StageChanged, arg_3_0._onStageChange, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.GMHideFightView, arg_3_0._updateRestrain, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.SelectSkillTarget, arg_4_0._onSelectSkillTarget, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.StageChanged, arg_4_0._onStageChange, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.GMHideFightView, arg_4_0._updateRestrain, arg_4_0)
end

function var_0_0.updateItem(arg_5_0, arg_5_1)
	arg_5_0.cardInfoMO = arg_5_1 or arg_5_0.cardInfoMO

	if not lua_skill.configDict[arg_5_1.skillId] then
		logError("skill not exist: " .. arg_5_1.skillId)

		return
	end

	arg_5_0:_updateRestrain()
	arg_5_0:_playNonAnimation()
end

function var_0_0._onSelectSkillTarget(arg_6_0, arg_6_1)
	arg_6_0:_updateRestrain()
	arg_6_0:_playAnimation()
end

function var_0_0._onStageChange(arg_7_0, arg_7_1)
	arg_7_0:_updateRestrain()
	arg_7_0:_playAnimation()
end

function var_0_0._updateRestrain(arg_8_0)
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		local var_8_0 = arg_8_0:_getNewRestrainStatus()
		local var_8_1 = GMFightShowState.handCardRestrain

		gohelper.setActive(arg_8_0._restrainGO, var_8_0 == var_0_0.RestrainMvStatus.Restrain and var_8_1)
		gohelper.setActive(arg_8_0._beRestrainGO, var_8_0 == var_0_0.RestrainMvStatus.BeRestrain and var_8_1)
	else
		gohelper.setActive(arg_8_0._restrainGO, false)
		gohelper.setActive(arg_8_0._beRestrainGO, false)
	end
end

function var_0_0._playAnimation(arg_9_0)
	local var_9_0 = arg_9_0:_getNewRestrainStatus()

	if var_9_0 == var_0_0.RestrainMvStatus.Restrain then
		if arg_9_0._restrainAnimator.gameObject.activeInHierarchy then
			arg_9_0._restrainAnimator:Play("fight_restrain_all_in", 0, 0)
			arg_9_0._restrainAnimator:Update(0)
		end
	elseif var_9_0 == var_0_0.RestrainMvStatus.BeRestrain and arg_9_0._beRestrainAnimator.gameObject.activeInHierarchy then
		arg_9_0._beRestrainAnimator:Play("fight_restrain_all_in", 0, 0)
		arg_9_0._beRestrainAnimator:Update(0)
	end
end

function var_0_0._playNonAnimation(arg_10_0)
	local var_10_0 = arg_10_0:_getNewRestrainStatus()

	if var_10_0 == var_0_0.RestrainMvStatus.Restrain then
		if arg_10_0._restrainAnimator.gameObject.activeInHierarchy then
			arg_10_0._restrainAnimator:Play("fight_restrain_all_not", 0, 0)
			arg_10_0._restrainAnimator:Update(0)
		end
	elseif var_10_0 == var_0_0.RestrainMvStatus.BeRestrain and arg_10_0._beRestrainAnimator.gameObject.activeInHierarchy then
		arg_10_0._beRestrainAnimator:Play("fight_restrain_all_not", 0, 0)
		arg_10_0._beRestrainAnimator:Update(0)
	end
end

function var_0_0.getNewRestrainStatus(arg_11_0, arg_11_1)
	local var_11_0 = FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate
	local var_11_1 = FightHelper.getEntity(FightDataHelper.operationDataMgr.curSelectEntityId)
	local var_11_2 = lua_skill.configDict[arg_11_1]
	local var_11_3 = var_11_2 and var_11_2.showTag
	local var_11_4 = var_11_3 and FightEnum.NeedShowRestrainTag[var_11_3]
	local var_11_5 = not FightDataHelper.stateMgr:getIsAuto()
	local var_11_6 = FightDataHelper.operationDataMgr.curSelectEntityId ~= 0
	local var_11_7 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightRestrainTag)
	local var_11_8 = GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidRestrainTag)

	if var_11_0 and var_11_7 and var_11_5 and var_11_6 and var_11_1 and var_11_4 and not var_11_8 then
		if FightBuffHelper.restrainAll(arg_11_0) then
			return var_0_0.RestrainMvStatus.Restrain
		end

		local var_11_9 = FightDataHelper.entityMgr:getById(arg_11_0)
		local var_11_10 = var_11_9 and var_11_9:getCO()
		local var_11_11 = var_11_10 and var_11_10.career or 0
		local var_11_12 = var_11_1:getMO()
		local var_11_13 = var_11_12 and var_11_12:getCO()
		local var_11_14 = var_11_13 and var_11_13.career or 0

		if FightModel.instance:getVersion() >= 2 then
			var_11_11 = var_11_9 and var_11_9.career or var_11_11
			var_11_14 = var_11_12 and var_11_12.career or var_11_14
		end

		local var_11_15 = FightConfig.instance:getRestrain(var_11_11, var_11_14) or 1000

		if var_11_15 > 1000 then
			return var_0_0.RestrainMvStatus.Restrain
		elseif var_11_15 < 1000 then
			return var_0_0.RestrainMvStatus.BeRestrain
		else
			return var_0_0.RestrainMvStatus.None
		end
	else
		return var_0_0.RestrainMvStatus.None
	end
end

function var_0_0._getNewRestrainStatus(arg_12_0)
	return var_0_0.getNewRestrainStatus(arg_12_0.cardInfoMO.uid, arg_12_0.cardInfoMO.skillId)
end

return var_0_0
