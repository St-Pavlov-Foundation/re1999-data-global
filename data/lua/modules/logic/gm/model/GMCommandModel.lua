module("modules.logic.gm.model.GMCommandModel", package.seeall)

local var_0_0 = class("GMCommandModel", ListScrollModel)

function var_0_0.reInit(arg_1_0)
	arg_1_0._hasInit = nil
end

function var_0_0.checkInitList(arg_2_0)
	if arg_2_0._hasInit then
		return
	end

	arg_2_0._hasInit = true

	arg_2_0:setList(lua_gm_command.configList)
end

var_0_0.instance = var_0_0.New()

return var_0_0
