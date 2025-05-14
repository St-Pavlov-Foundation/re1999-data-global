module("modules.logic.fight.entity.pool.FightTLEventPool", package.seeall)

local var_0_0 = class("FightTLEventPool")
local var_0_1 = {}

function var_0_0.getHandlerInst(arg_1_0, arg_1_1)
	local var_1_0 = var_0_1[arg_1_0]

	if not var_1_0 then
		var_1_0 = LuaObjPool.New(32, function()
			if arg_1_1 then
				if arg_1_1.New then
					return arg_1_1.New()
				else
					logError("FightTLEvent class.ctor is nil: " .. arg_1_0)
				end
			else
				logError("FightTLEvent class is nil: " .. arg_1_0)
			end

			return FightTLEvent.New()
		end, var_0_0._releaseFunc, var_0_0._resetFunc)
		var_0_1[arg_1_0] = var_1_0
	end

	local var_1_1 = var_1_0:getObject()

	var_1_1.type = arg_1_0

	return var_1_1
end

function var_0_0.dispose()
	for iter_3_0, iter_3_1 in pairs(var_0_1) do
		iter_3_1:dispose()
	end

	var_0_1 = {}
end

function var_0_0.putHandlerInst(arg_4_0)
	local var_4_0 = var_0_1[arg_4_0.type]

	if var_4_0 then
		var_4_0:putObject(arg_4_0)
	else
		if arg_4_0.reset then
			arg_4_0:reset()
		end

		if arg_4_0.dispose then
			arg_4_0:dispose()
		end
	end
end

function var_0_0._releaseFunc(arg_5_0)
	if arg_5_0.dispose then
		arg_5_0:dispose()
	end
end

function var_0_0._resetFunc(arg_6_0)
	if arg_6_0.reset then
		arg_6_0:reset()
	end
end

return var_0_0
