module("modules.logic.login.model.ServerListModel", package.seeall)

local var_0_0 = class("ServerListModel", ListScrollModel)

function var_0_0.setServerList(arg_1_0, arg_1_1)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		local var_1_1 = ServerMO.New()

		var_1_1:init(iter_1_1)
		table.insert(var_1_0, var_1_1)
	end

	arg_1_0:setList(var_1_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
