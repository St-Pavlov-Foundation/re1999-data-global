module("modules.logic.versionactivity1_4.act132.controller.Activity132Controller", package.seeall)

local var_0_0 = class("Activity132Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.initAct(arg_3_0, arg_3_1)
	Activity132Rpc.instance:sendGet132InfosRequest(arg_3_1)
end

function var_0_0.openCollectView(arg_4_0, arg_4_1)
	Activity132Rpc.instance:sendGet132InfosRequest(arg_4_1, function()
		ViewMgr.instance:openView(ViewName.Activity132CollectView, {
			actId = arg_4_1
		})
	end)
end

var_0_0.instance = var_0_0.New()

return var_0_0
