module("modules.logic.help.view.HelpShowView", package.seeall)

local var_0_0 = class("HelpShowView", BaseView)

function var_0_0.setHelpId(arg_1_0, arg_1_1)
	arg_1_0._helpId = arg_1_1
end

function var_0_0.setDelayTime(arg_2_0, arg_2_1)
	arg_2_0._time = arg_2_1
end

function var_0_0.setDelayTimeFromConst(arg_3_0, arg_3_1)
	arg_3_0._time = CommonConfig.instance:getConstNum(arg_3_1)
end

function var_0_0.onOpenFinish(arg_4_0)
	arg_4_0:tryShowHelp()
end

function var_0_0.tryShowHelp(arg_5_0)
	if HelpController.instance:canShowFirstHelp(arg_5_0._helpId) then
		arg_5_0:_showHelp()
	end
end

function var_0_0._showHelp(arg_6_0)
	if not arg_6_0._helpId then
		return
	end

	UIBlockMgr.instance:startBlock("HelpShowView tryShowFirstHelp")
	TaskDispatcher.runDelay(arg_6_0._tryShowFirstHelp, arg_6_0, arg_6_0._time or 0)
end

function var_0_0._tryShowFirstHelp(arg_7_0)
	UIBlockMgr.instance:endBlock("HelpShowView tryShowFirstHelp")
	HelpController.instance:tryShowFirstHelp(arg_7_0._helpId)
end

function var_0_0.onClose(arg_8_0)
	UIBlockMgr.instance:endBlock("HelpShowView tryShowFirstHelp")
	TaskDispatcher.cancelTask(arg_8_0._tryShowFirstHelp, arg_8_0)
end

return var_0_0
