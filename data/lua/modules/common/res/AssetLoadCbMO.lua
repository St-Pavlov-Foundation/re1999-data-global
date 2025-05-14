module("modules.common.res.AssetLoadCbMO", package.seeall)

local var_0_0 = class("AssetLoadCbMO")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._loadedCb = arg_1_1
	arg_1_0._loadedObj = arg_1_2
end

function var_0_0.call(arg_2_0, ...)
	arg_2_0._loadedCb(arg_2_0._loadedObj, ...)
end

return var_0_0
