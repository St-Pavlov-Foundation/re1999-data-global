module("modules.logic.survival.view.map.SurvivalInitTeamView", package.seeall)

local var_0_0 = class("SurvivalInitTeamView", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._path = arg_1_1
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._root = gohelper.findChild(arg_2_0.viewGO, arg_2_0._path)
	arg_2_0._btnstart = gohelper.findChildButtonWithAudio(arg_2_0._root, "#btn_Start")
	arg_2_0._btnreturn = gohelper.findChildButtonWithAudio(arg_2_0._root, "#btn_Return")
end

function var_0_0.addEvents(arg_3_0)
	if arg_3_0._btnstart then
		arg_3_0._btnstart:AddClickListener(arg_3_0._btnstartOnClick, arg_3_0)
	end

	if arg_3_0._btnreturn then
		arg_3_0._btnreturn:AddClickListener(arg_3_0._btnreturnOnClick, arg_3_0)
	end
end

function var_0_0.removeEvents(arg_4_0)
	if arg_4_0._btnstart then
		arg_4_0._btnstart:RemoveClickListener()
	end

	if arg_4_0._btnreturn then
		arg_4_0._btnreturn:RemoveClickListener()
	end
end

function var_0_0.setIsShow(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._root, arg_5_1)

	if arg_5_1 then
		arg_5_0:onViewShow()
	end
end

function var_0_0.onViewShow(arg_6_0)
	return
end

function var_0_0._btnstartOnClick(arg_7_0)
	arg_7_0._isNext = true

	arg_7_0:playSwitchAnim()
end

function var_0_0._btnreturnOnClick(arg_8_0)
	arg_8_0._isNext = false

	arg_8_0:playSwitchAnim()
end

function var_0_0.playSwitchAnim(arg_9_0)
	arg_9_0.viewContainer:playAnim("panel_out")
	TaskDispatcher.runDelay(arg_9_0._delayPanelIn, arg_9_0, 0.2)
	UIBlockHelper.instance:startBlock("SurvivalInitTeamView.playSwitchAnim", 0.2)
end

function var_0_0._delayPanelIn(arg_10_0)
	arg_10_0.viewContainer:playAnim("panel_in")

	if arg_10_0._isNext then
		arg_10_0.viewContainer:nextStep()
	else
		arg_10_0.viewContainer:preStep()
	end
end

function var_0_0.onClose(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._delayPanelIn, arg_11_0)
end

return var_0_0
