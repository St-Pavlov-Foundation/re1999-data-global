module("modules.logic.fight.view.FightViewBuffId2Behaviour", package.seeall)

local var_0_0 = class("FightViewBuffId2Behaviour", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.existBuffBehaviourDict = {}
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_2_0.onBuffUpdate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

var_0_0.BehaviourId2Behaviour = {
	FightBuffBehaviour_ForceAuto,
	FightBuffBehaviour_HideCard,
	FightBuffBehaviour_500M_RemoveActPoint,
	FightBuffBehaviour_500M_BGMask,
	FightBuffBehaviour_500M_DeepScore
}

function var_0_0.onOpen(arg_4_0)
	arg_4_0:checkRunBuffBehaviour()
end

function var_0_0.checkRunBuffBehaviour(arg_5_0)
	local var_5_0 = FightDataHelper.entityMgr:getAllEntityMO()

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		local var_5_1 = iter_5_1:getBuffDic()

		for iter_5_2, iter_5_3 in pairs(var_5_1) do
			local var_5_2 = lua_fight_buff2special_behaviour.configDict[iter_5_3.buffId]

			if var_5_2 then
				arg_5_0:addBuffBehaviour(var_5_2, iter_5_1.uid, iter_5_3.buffId, iter_5_3)
			end
		end
	end
end

function var_0_0.onDestroyView(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.existBuffBehaviourDict) do
		arg_6_0:destroyBehaviour(iter_6_0, iter_6_1)
	end
end

function var_0_0.onBuffUpdate(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)
	local var_7_0 = lua_fight_buff2special_behaviour.configDict[arg_7_3]

	if not var_7_0 then
		return
	end

	if arg_7_2 == FightEnum.EffectType.BUFFADD then
		arg_7_0:addBuffBehaviour(var_7_0, arg_7_1, arg_7_3, arg_7_6)
	elseif arg_7_2 == FightEnum.EffectType.BUFFUPDATE then
		arg_7_0:updateBehaviour(var_7_0, arg_7_1, arg_7_3, arg_7_6)
	elseif arg_7_2 == FightEnum.EffectType.BUFFDEL or arg_7_2 == FightEnum.EffectType.BUFFDELNOEFFECT then
		arg_7_0:removeBuffBehaviour(var_7_0, arg_7_1, arg_7_3, arg_7_6)
	else
		logError("not handle effectType : " .. tostring(arg_7_2))
	end
end

function var_0_0.addBuffBehaviour(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_0.existBuffBehaviourDict[arg_8_3] then
		return
	end

	local var_8_0 = var_0_0.BehaviourId2Behaviour[arg_8_1.behaviour]

	if not var_8_0 then
		logError(string.format("不支持的behaviour : %s, buffId : %s", arg_8_1.behaviour, arg_8_3))

		return
	end

	local var_8_1 = var_8_0.New()

	var_8_1:init(arg_8_0.viewGO, arg_8_0.viewContainer, arg_8_1)
	var_8_1:onAddBuff(arg_8_2, arg_8_3, arg_8_4)

	arg_8_0.existBuffBehaviourDict[arg_8_3] = var_8_1
end

function var_0_0.updateBehaviour(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = arg_9_0.existBuffBehaviourDict[arg_9_3]

	if var_9_0 then
		var_9_0:onUpdateBuff(arg_9_2, arg_9_3, arg_9_4)
	end
end

function var_0_0.removeBuffBehaviour(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = arg_10_0.existBuffBehaviourDict[arg_10_3]

	if var_10_0 then
		var_10_0:onRemoveBuff(arg_10_2, arg_10_3, arg_10_4)
		arg_10_0:destroyBehaviour(arg_10_3, var_10_0)
	end
end

function var_0_0.destroyBehaviour(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:onDestroy()

	arg_11_0.existBuffBehaviourDict[arg_11_1] = nil
end

return var_0_0
