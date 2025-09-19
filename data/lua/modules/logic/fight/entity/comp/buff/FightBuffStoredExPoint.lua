module("modules.logic.fight.entity.comp.buff.FightBuffStoredExPoint", package.seeall)

local var_0_0 = class("FightBuffStoredExPoint")

function var_0_0.ctor(arg_1_0)
	arg_1_0.type = nil
end

function var_0_0.onBuffStart(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.entity = arg_2_1

	local var_2_0 = arg_2_1:getMO()

	if var_2_0 then
		local var_2_1 = var_2_0:getStoredExPoint()

		var_2_0:updateStoredExPoint()
		FightController.instance:dispatchEvent(FightEvent.OnStoreExPointChange, var_2_0.id, var_2_1)
	end
end

function var_0_0.onBuffEnd(arg_3_0)
	if not arg_3_0.entity then
		return
	end

	local var_3_0 = arg_3_0.entity:getMO()

	if var_3_0 then
		local var_3_1 = var_3_0:getStoredExPoint()

		var_3_0:updateStoredExPoint()
		FightController.instance:dispatchEvent(FightEvent.OnStoreExPointChange, var_3_0.id, var_3_1)

		local var_3_2 = FightLocalDataMgr.instance.entityMgr:getById(arg_3_0.entity.id)

		if var_3_2 then
			var_3_2:updateStoredExPoint()
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
