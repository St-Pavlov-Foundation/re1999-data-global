module("modules.logic.fight.system.work.FightWorkRealDamageKill351", package.seeall)

local var_0_0 = class("FightWorkRealDamageKill351", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0:getKillCo()

	if not var_1_0 then
		return arg_1_0:onDone(true)
	end

	local var_1_1 = arg_1_0.actEffectData.targetId
	local var_1_2 = FightHelper.getEntity(var_1_1)

	if not var_1_2 then
		return arg_1_0:onDone(true)
	end

	local var_1_3 = var_1_0.effect
	local var_1_4 = var_1_0.effectHangPoint
	local var_1_5 = var_1_0.duration
	local var_1_6 = var_1_2.effect:addHangEffect(var_1_3, var_1_4, nil, var_1_5)

	FightRenderOrderMgr.instance:onAddEffectWrap(var_1_1, var_1_6)
	var_1_6:setLocalPos(0, 0, 0)

	local var_1_7 = var_1_0.audio

	if var_1_7 ~= 0 then
		AudioMgr.instance:trigger(var_1_7)
	end

	local var_1_8 = var_1_0.waitTime

	if var_1_8 <= 0 then
		return arg_1_0:onDone(true)
	end

	TaskDispatcher.runDelay(arg_1_0.finishWork, arg_1_0, var_1_8)
end

function var_0_0.getKillCo(arg_2_0)
	local var_2_0 = FightDataHelper.entityMgr:getMyNormalList()

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_1 = iter_2_1.originSkin
		local var_2_2 = lua_fight_kill.configDict[var_2_1]

		if var_2_2 then
			return var_2_2
		end
	end
end

function var_0_0.clearWork(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.finishWork, arg_3_0)
end

return var_0_0
