module("modules.logic.fight.model.data.FightDataClass", package.seeall)

local var_0_0 = {}
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}

function var_0_1.ctor()
	return
end

function var_0_1.onConstructor()
	return
end

local function var_0_4(arg_3_0, arg_3_1, ...)
	local var_3_0 = var_0_3[arg_3_0.__cname]

	if var_3_0 then
		var_0_4(var_3_0, arg_3_1, ...)
	end

	local var_3_1 = rawget(arg_3_0, "onConstructor")

	if var_3_1 then
		return var_3_1(arg_3_1, ...)
	end
end

local function var_0_5(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {
		__cname = arg_4_1
	}

	if arg_4_2 then
		setmetatable(var_4_0, {
			__index = arg_4_2
		})
	else
		setmetatable(var_4_0, {
			__index = var_0_1
		})
	end

	var_0_2[arg_4_1] = {
		__index = var_4_0
	}
	var_0_3[arg_4_1] = arg_4_2

	function var_4_0.New(...)
		local var_5_0 = {
			__cname = arg_4_1
		}

		setmetatable(var_5_0, var_0_2[arg_4_1])
		var_5_0:ctor()
		var_0_4(var_4_0, var_5_0, ...)

		return var_5_0
	end

	return var_4_0
end

setmetatable(var_0_0, {
	__call = var_0_5
})

return var_0_0
