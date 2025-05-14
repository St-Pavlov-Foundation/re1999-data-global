module("modules.logic.explore.view.ExploreInteractOptionView", package.seeall)

local var_0_0 = class("ExploreInteractOptionView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gochoicelist = gohelper.findChild(arg_1_0.viewGO, "#go_choicelist")
	arg_1_0._gochoiceitem = gohelper.findChild(arg_1_0.viewGO, "#go_choicelist/#go_choiceitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnclose, arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0._btnclose)
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._gochoiceitem, false)
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = arg_5_0.viewParam

	arg_5_0.optionsBtn = arg_5_0:getUserDataTb_()

	for iter_5_0 = 1, #var_5_0 do
		local var_5_1 = gohelper.cloneInPlace(arg_5_0._gochoiceitem, "choiceitem")

		gohelper.setActive(var_5_1, true)

		gohelper.findChildTextMesh(var_5_1, "info").text = var_5_0[iter_5_0].optionTxt
		arg_5_0.optionsBtn[iter_5_0] = gohelper.findChildButtonWithAudio(var_5_1, "click")

		arg_5_0.optionsBtn[iter_5_0]:AddClickListener(arg_5_0.optionClick, arg_5_0, var_5_0[iter_5_0])
	end
end

function var_0_0.optionClick(arg_6_0, arg_6_1)
	arg_6_0:closeThis()
	arg_6_1.optionCallBack(arg_6_1.optionCallObj, arg_6_1.unit, arg_6_1.isClient)
end

function var_0_0.onDestroyView(arg_7_0)
	for iter_7_0 = 1, #arg_7_0.optionsBtn do
		arg_7_0.optionsBtn[iter_7_0]:RemoveClickListener()
	end

	gohelper.destroyAllChildren(arg_7_0._gochoicelist)
end

return var_0_0
