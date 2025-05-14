module("modules.logic.versionactivity2_1.aergusi.model.AergusiClueMo", package.seeall)

local var_0_0 = class("AergusiClueMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.clueId = 0
	arg_1_0.status = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.clueId = arg_2_1.clueId
	arg_2_0.status = arg_2_1.status
end

return var_0_0
