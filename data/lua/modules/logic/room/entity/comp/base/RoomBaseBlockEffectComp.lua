module("modules.logic.room.entity.comp.base.RoomBaseBlockEffectComp", package.seeall)

local var_0_0 = class("RoomBaseBlockEffectComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0.delayTaskTime = 0.1
	arg_1_0._effectKeyDict = {}
	arg_1_0._allEffectKeyList = {}
	arg_1_0._effectPrefixKey = arg_1_0.__cname
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.onBeforeDestroy(arg_4_0)
	return
end

function var_0_0.onRunDelayTask(arg_5_0)
	return
end

function var_0_0.removeParamsAndPlayAnimator(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0.entity.effect

	if arg_6_3 then
		for iter_6_0 = 1, #arg_6_1 do
			var_6_0:playEffectAnimator(arg_6_1[iter_6_0], arg_6_2)
		end
	end

	var_6_0:removeParams(arg_6_1, arg_6_3)
end

function var_0_0.getEffectKeyById(arg_7_0, arg_7_1)
	if not arg_7_0._effectKeyDict[arg_7_1] then
		local var_7_0 = arg_7_0:formatEffectKey(arg_7_1)

		arg_7_0._effectKeyDict[arg_7_1] = var_7_0

		table.insert(arg_7_0._allEffectKeyList, var_7_0)
	end

	return arg_7_0._effectKeyDict[arg_7_1]
end

function var_0_0.formatEffectKey(arg_8_0, arg_8_1)
	return string.format("%s_%s", arg_8_0._effectPrefixKey, arg_8_1)
end

function var_0_0.startWaitRunDelayTask(arg_9_0)
	if not arg_9_0.__hasWaitRunDelayTask_ then
		arg_9_0.__hasWaitRunDelayTask_ = true

		local var_9_0 = arg_9_0.delayTaskTime or 0.001

		TaskDispatcher.runDelay(arg_9_0.__onWaitRunDelayTask_, arg_9_0, math.max(0.001, tonumber(var_9_0)))
	end
end

function var_0_0.__onWaitRunDelayTask_(arg_10_0)
	arg_10_0.__hasWaitRunDelayTask_ = false

	if not arg_10_0:isWillDestory() then
		arg_10_0:onRunDelayTask()
	end
end

function var_0_0.isWillDestory(arg_11_0)
	return arg_11_0.__willDestroy
end

function var_0_0.beforeDestroy(arg_12_0)
	arg_12_0.__willDestroy = true
	arg_12_0.__hasWaitRunDelayTask_ = false

	TaskDispatcher.cancelTask(arg_12_0.__onWaitRunDelayTask_, arg_12_0)
	arg_12_0:onBeforeDestroy()
end

return var_0_0
