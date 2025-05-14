module("modules.logic.versionactivity2_5.goldenmilletpresent.view.V2a5_GoldenMilletPresentView", package.seeall)

local var_0_0 = class("V2a5_GoldenMilletPresentView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goReceiveView = gohelper.findChild(arg_1_0.viewGO, "#go_ReceiveView")
	arg_1_0._goDisplayView = gohelper.findChild(arg_1_0.viewGO, "#go_DisplayView")

	gohelper.setActive(arg_1_0._goReceiveView, false)
	gohelper.setActive(arg_1_0._goDisplayView, false)
end

function var_0_0.onOpen(arg_2_0)
	local var_2_0 = arg_2_0.viewParam and arg_2_0.viewParam.isDisplayView or false

	arg_2_0:switchExclusiveView(var_2_0)
end

function var_0_0.switchExclusiveView(arg_3_0, arg_3_1)
	arg_3_0._showingReceiveView = true

	local var_3_0 = arg_3_0.viewContainer.ExclusiveView.ReceiveView
	local var_3_1 = V2a5_GoldenMilletPresentReceiveView
	local var_3_2 = arg_3_0._goReceiveView

	if arg_3_1 then
		var_3_0 = arg_3_0.viewContainer.ExclusiveView.DisplayView
		var_3_1 = V2a5_GoldenMilletPresentDisplayView
		var_3_2 = arg_3_0._goDisplayView
		arg_3_0._showingReceiveView = false
	end

	arg_3_0:openExclusiveView(nil, var_3_0, var_3_1, var_3_2)
end

function var_0_0.onClickModalMask(arg_4_0)
	if arg_4_0._showingReceiveView then
		arg_4_0:switchExclusiveView(true)
	else
		arg_4_0:closeThis()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

return var_0_0
