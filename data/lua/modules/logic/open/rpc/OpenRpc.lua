module("modules.logic.open.rpc.OpenRpc", package.seeall)

local var_0_0 = class("OpenRpc", BaseRpc)

function var_0_0.onReceiveUpdateOpenPush(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_1 == 0 then
		OpenModel.instance:updateOpenInfo(arg_1_2.openInfos)
		MainController.instance:dispatchEvent(MainEvent.OnFuncUnlockRefresh)

		local var_1_0 = {}

		for iter_1_0, iter_1_1 in ipairs(arg_1_2.openInfos) do
			if iter_1_1.isOpen then
				table.insert(var_1_0, iter_1_1.id)
			end
		end

		if #var_1_0 > 0 then
			OpenController.instance:dispatchEvent(OpenEvent.NewFuncUnlock, var_1_0)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
