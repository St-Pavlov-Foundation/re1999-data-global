module("modules.common.res.AssetInstanceComp", package.seeall)

local var_0_0 = class("AssetInstanceComp", LuaCompBase)

function var_0_0.setAsset(arg_1_0, arg_1_1)
	arg_1_0._assetMO = arg_1_1
end

function var_0_0.onDestroy(arg_2_0)
	if arg_2_0._assetMO then
		arg_2_0._assetMO:release()
	end

	arg_2_0._assetMO = nil
end

return var_0_0
