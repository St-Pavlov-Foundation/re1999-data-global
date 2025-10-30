module("modules.logic.fight.entity.comp.skinCustomComp.FightSkinSM_630305CustomComp", package.seeall)

local var_0_0 = class("FightSkinSM_630305CustomComp", FightSkinCustomCompBase)
local var_0_1 = {
	Add = 1,
	Remove = 2
}

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0.skinId = arg_1_1:getMO().skin
	arg_1_0.entityId = arg_1_1.id
	arg_1_0.spine = arg_1_0.entity.spine
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1

	for iter_2_0, iter_2_1 in ipairs(lua_fight_sp_sm.configList) do
		if iter_2_1.skinId == arg_2_0.skinId then
			arg_2_0.handleBuffId = iter_2_1.buffId

			break
		end
	end

	arg_2_0:switchToIdle()
	arg_2_0.entity.spine:addAnimEventCallback(arg_2_0.onAnimEvent, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, arg_2_0.onUpdateBuff, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0.entity.spine:removeAnimEventCallback(arg_3_0.onAnimEvent, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, arg_3_0.onUpdateBuff, arg_3_0)
end

function var_0_0.onUpdateBuff(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	if arg_4_1 ~= arg_4_0.entityId then
		return
	end

	if arg_4_3 ~= arg_4_0.handleBuffId then
		return
	end

	if arg_4_2 == FightEnum.EffectType.BUFFADD then
		arg_4_0:onAddBuff(arg_4_3)
	elseif arg_4_2 == FightEnum.EffectType.BUFFDEL or arg_4_2 == FightEnum.EffectType.BUFFDELNOEFFECT then
		arg_4_0:onRemoveBuff(arg_4_3)
	end
end

function var_0_0.onAddBuff(arg_5_0, arg_5_1)
	local var_5_0 = lua_fight_sp_sm.configDict[arg_5_0.skinId]

	var_5_0 = var_5_0 and var_5_0[arg_5_1]
	var_5_0 = var_5_0 and var_5_0[var_0_1.Add]

	if not var_5_0 then
		return
	end

	local var_5_1 = var_5_0.actionName

	arg_5_0.spine:play(var_5_1, false, true)

	local var_5_2 = arg_5_0:getCurAnimDuration()
	local var_5_3 = var_5_0.duration

	if var_5_3 > 0 then
		var_5_3 = math.min(var_5_3, var_5_2)
	else
		var_5_3 = var_5_2
	end

	TaskDispatcher.runDelay(arg_5_0.switchToIdle, arg_5_0, var_5_3)

	FightWorkStepBuff.updateWaitTime = var_5_3

	local var_5_4 = var_5_0.audioId

	if var_5_4 > 0 then
		AudioMgr.instance:trigger(var_5_4)
	end
end

function var_0_0.onRemoveBuff(arg_6_0, arg_6_1)
	local var_6_0 = lua_fight_sp_sm.configDict[arg_6_0.skinId]

	var_6_0 = var_6_0 and var_6_0[arg_6_1]
	var_6_0 = var_6_0 and var_6_0[var_0_1.Remove]

	if not var_6_0 then
		return
	end

	local var_6_1 = var_6_0.actionName

	arg_6_0.spine:play(var_6_1, false, true)

	local var_6_2 = arg_6_0:getCurAnimDuration()
	local var_6_3 = var_6_0.duration

	if var_6_3 > 0 then
		var_6_3 = math.min(var_6_3, var_6_2)
	else
		var_6_3 = var_6_2
	end

	TaskDispatcher.runDelay(arg_6_0.switchToIdle, arg_6_0, var_6_3)

	FightWorkStepBuff.updateWaitTime = var_6_3

	local var_6_4 = var_6_0.audioId

	if var_6_4 > 0 then
		AudioMgr.instance:trigger(var_6_4)
	end
end

function var_0_0.onAnimEvent(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2 == SpineAnimEvent.ActionComplete then
		TaskDispatcher.cancelTask(arg_7_0.switchToIdle, arg_7_0)
		arg_7_0:switchToIdle()
	end
end

function var_0_0.hasSpecialBuff(arg_8_0)
	local var_8_0 = arg_8_0.entity:getMO():getBuffDic()

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		if iter_8_1.buffId == arg_8_0.handleBuffId then
			return true
		end
	end

	return false
end

function var_0_0.switchToIdle(arg_9_0)
	local var_9_0 = lua_fight_sp_sm.configDict[arg_9_0.skinId]

	var_9_0 = var_9_0 and var_9_0[arg_9_0.handleBuffId]

	if not var_9_0 then
		return
	end

	if arg_9_0:hasSpecialBuff() then
		var_9_0 = var_9_0[var_0_1.Add]
	else
		var_9_0 = var_9_0[var_0_1.Remove]
	end

	if not var_9_0 then
		return
	end

	arg_9_0.spine:play(var_9_0.nextActionName, true, true)
end

local var_0_2 = {
	"hit",
	"freeze",
	"sleep"
}

function var_0_0.canPlayAnimState(arg_10_0, arg_10_1)
	if not arg_10_0:hasSpecialBuff() then
		return true
	end

	for iter_10_0, iter_10_1 in ipairs(var_0_2) do
		if arg_10_1 == iter_10_1 then
			return false
		end
	end

	return true
end

function var_0_0.replaceAnimState(arg_11_0, arg_11_1)
	if arg_11_1 == SpineAnimState.idle1 or arg_11_1 == SpineAnimState.idle2 then
		if arg_11_0:hasSpecialBuff() then
			return SpineAnimState.idle2
		else
			return SpineAnimState.idle1
		end
	end

	return arg_11_1
end

function var_0_0.getCurAnimDuration(arg_12_0)
	return arg_12_0.spine:getSkeletonAnim():GetCurAnimDuration() or 0
end

function var_0_0.onDestroy(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0.switchToIdle, arg_13_0)
end

return var_0_0
