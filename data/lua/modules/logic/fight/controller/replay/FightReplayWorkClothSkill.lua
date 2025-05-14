module("modules.logic.fight.controller.replay.FightReplayWorkClothSkill", package.seeall)

local var_0_0 = class("FightReplayWorkClothSkill", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.clothSkillOp = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 10)

	if arg_2_0.clothSkillOp.type == FightEnum.ClothSkillType.HeroUpgrade then
		FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, arg_2_0._failDone, arg_2_0)
		FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, arg_2_0._onClothSkillDone, arg_2_0)
		FightRpc.instance:sendUseClothSkillRequest(arg_2_0.clothSkillOp.skillId, arg_2_0.clothSkillOp.fromId, arg_2_0.clothSkillOp.toId, FightEnum.ClothSkillType.HeroUpgrade)

		return
	elseif arg_2_0.clothSkillOp.type == FightEnum.ClothSkillType.Contract then
		FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, arg_2_0._failDone, arg_2_0)
		FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, arg_2_0._onClothSkillDone, arg_2_0)
		FightRpc.instance:sendUseClothSkillRequest(arg_2_0.clothSkillOp.skillId, arg_2_0.clothSkillOp.fromId, arg_2_0.clothSkillOp.toId, FightEnum.ClothSkillType.Contract)

		return
	end

	local var_2_0 = lua_skill.configDict[arg_2_0.clothSkillOp.skillId]

	if var_2_0 then
		local var_2_1 = var_2_0.behavior1

		if not string.nilorempty(var_2_1) then
			local var_2_2 = string.splitToNumber(var_2_1, "#")[1]
			local var_2_3 = var_2_2 and lua_skill_behavior.configDict[var_2_2]
			local var_2_4 = var_2_3 and var_2_3.type

			if var_2_4 then
				arg_2_0:_playBehavior(var_2_4)
			else
				logError("主角技能行为类型不存在：" .. arg_2_0.clothSkillOp.skillId .. " behavior=" .. var_2_1)
				arg_2_0:onDone(true)
			end
		else
			logError("主角技能行为不存在：" .. arg_2_0.clothSkillOp.skillId)
			arg_2_0:onDone(true)
		end
	else
		logError("主角技能不存在：" .. arg_2_0.clothSkillOp.skillId)
		arg_2_0:onDone(true)
	end
end

function var_0_0._playBehavior(arg_3_0, arg_3_1)
	if arg_3_1 == "AddUniversalCard" then
		FightController.instance:registerCallback(FightEvent.OnUniversalAppear, arg_3_0._onUniversalAppear, arg_3_0)
	elseif arg_3_1 == "RedealCardKeepStar" then
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, arg_3_0._onRedealCardDone, arg_3_0)
	elseif arg_3_1 == "SubHeroChange" then
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, arg_3_0._onChangeSubDone, arg_3_0)
	elseif arg_3_1 == "ExtraMoveCard" then
		FightController.instance:registerCallback(FightEvent.OnEffectExtraMoveAct, arg_3_0._onEffectExtraMoveAct, arg_3_0)
	else
		FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, arg_3_0._onClothSkillDone, arg_3_0)
	end

	FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, arg_3_0._failDone, arg_3_0)
	FightController.instance:dispatchEvent(FightEvent.SimulateClickClothSkillIcon, arg_3_0.clothSkillOp)
end

function var_0_0._delayDone(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0._onChangeSubDone(arg_5_0)
	TaskDispatcher.runDelay(arg_5_0._done, arg_5_0, 0.1)
end

function var_0_0._onRedealCardDone(arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._done, arg_6_0, 0.1)
end

function var_0_0._onUniversalAppear(arg_7_0)
	TaskDispatcher.runDelay(arg_7_0._done, arg_7_0, 0.1)
end

function var_0_0._onEffectExtraMoveAct(arg_8_0)
	TaskDispatcher.runDelay(arg_8_0._done, arg_8_0, 0.1)
end

function var_0_0._onClothSkillDone(arg_9_0)
	TaskDispatcher.runDelay(arg_9_0._done, arg_9_0, 0.1)
end

function var_0_0._done(arg_10_0)
	arg_10_0:onDone(true)
end

function var_0_0._failDone(arg_11_0)
	arg_11_0:onDone(true)
end

function var_0_0.clearWork(arg_12_0)
	FightController.instance:unregisterCallback(FightEvent.OnUniversalAppear, arg_12_0._onUniversalAppear, arg_12_0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, arg_12_0._done, arg_12_0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, arg_12_0._onChangeSubDone, arg_12_0)
	FightController.instance:unregisterCallback(FightEvent.OnEffectExtraMoveAct, arg_12_0._onEffectExtraMoveAct, arg_12_0)
	FightController.instance:unregisterCallback(FightEvent.OnClothSkillRoundSequenceFinish, arg_12_0._onClothSkillDone, arg_12_0)
	FightController.instance:unregisterCallback(FightEvent.RespUseClothSkillFail, arg_12_0._failDone, arg_12_0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, arg_12_0._onRedealCardDone, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._delayDone, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._done, arg_12_0)
end

return var_0_0
