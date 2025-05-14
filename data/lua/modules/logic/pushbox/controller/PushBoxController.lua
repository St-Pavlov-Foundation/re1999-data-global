module("modules.logic.pushbox.controller.PushBoxController", package.seeall)

local var_0_0 = class("PushBoxController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.enterPushBoxGame(arg_5_0)
	PushBoxRpc.instance:sendGet111InfosRequest(function()
		GameSceneMgr.instance:startScene(SceneType.PushBox, 1, 1)
	end, arg_5_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
