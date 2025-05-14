module("modules.logic.main.controller.work.MainMailWork", package.seeall)

local var_0_0 = class("MainMailWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	MailController.instance:tryShowMailToast()
	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
