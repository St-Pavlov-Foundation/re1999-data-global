module("modules.logic.voyage.controller.VoyageController", package.seeall)

local var_0_0 = class("VoyageController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._model = VoyageModel.instance
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0._onReceiveAct1001GetInfoReply(arg_4_0, arg_4_1)
	arg_4_0._model:onReceiveAct1001GetInfoReply(arg_4_1)
	arg_4_0:dispatchEvent(VoyageEvent.OnReceiveAct1001GetInfoReply)
end

function var_0_0._onReceiveAct1001UpdatePush(arg_5_0, arg_5_1)
	arg_5_0._model:onReceiveAct1001UpdatePush(arg_5_1)
	arg_5_0:dispatchEvent(VoyageEvent.OnReceiveAct1001UpdatePush)
end

function var_0_0.jump(arg_6_0)
	if arg_6_0._model:hasAnyRewardAvailable() then
		MailController.instance:open()
	else
		local var_6_0 = {
			chapterId = 101
		}

		DungeonController.instance:enterDungeonView(true)
		DungeonController.instance:openDungeonChapterView(var_6_0)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
