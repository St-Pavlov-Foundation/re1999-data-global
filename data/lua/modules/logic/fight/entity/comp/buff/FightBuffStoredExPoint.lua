module("modules.logic.fight.entity.comp.buff.FightBuffStoredExPoint", package.seeall)

local var_0_0 = class("FightBuffStoredExPoint")

function var_0_0.ctor(arg_1_0)
	arg_1_0.type = nil
end

function var_0_0.onBuffStart(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.entity = arg_2_1

	local var_2_0 = arg_2_2.actCommonParams

	if not var_2_0 then
		return
	end

	local var_2_1 = FightStrUtil.instance:getSplitToNumberCache(var_2_0, "#")
	local var_2_2 = var_2_1[1]
	local var_2_3 = lua_buff_act.configDict[var_2_2]

	if var_2_3 and var_2_3.type == FightEnum.BuffType_ExPointOverflowBank then
		local var_2_4 = arg_2_1:getMO()

		if var_2_4 then
			local var_2_5 = var_2_4:getStoredExPoint()

			var_2_4:setStoredExPoint(var_2_1[2])
			FightController.instance:dispatchEvent(FightEvent.OnStoreExPointChange, var_2_4.id, var_2_5)
		end
	end
end

function var_0_0.onBuffEnd(arg_3_0)
	if not arg_3_0.entity then
		return
	end

	local var_3_0 = arg_3_0.entity:getMO()

	if var_3_0 then
		local var_3_1 = var_3_0:getStoredExPoint()

		var_3_0:setStoredExPoint(0)
		FightController.instance:dispatchEvent(FightEvent.OnStoreExPointChange, var_3_0.id, var_3_1)

		local var_3_2 = FightLocalDataMgr.instance.entityMgr:getById(arg_3_0.entity.id)

		if var_3_2 then
			var_3_2:setStoredExPoint(0)
		end
	end
end

function var_0_0.reset(arg_4_0)
	arg_4_0.entity = nil
end

function var_0_0.dispose(arg_5_0)
	arg_5_0.entity = nil
end

return var_0_0
