module("modules.logic.test.view.TestUIExclusive", package.seeall)

local var_0_0 = class("TestUIExclusive", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.text = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_des")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(gohelper.getClick(gohelper.findChild(arg_2_0.viewGO, "#btn_close_exclusive")), arg_2_0._onClick, arg_2_0)
end

function var_0_0._onOpenSubView(arg_3_0)
	return
end

function var_0_0.onSetExclusiveViewVisible(arg_4_0, arg_4_1)
	if not arg_4_1 then
		GameFacade.showToast(ToastEnum.ClassShow)
	end

	arg_4_0:setViewVisibleInternal(arg_4_1)
end

function var_0_0._onClick(arg_5_0)
	arg_5_0:getParentView():hideExclusiveView(arg_5_0)
end

function var_0_0.onRefreshViewParam(arg_6_0, arg_6_1)
	arg_6_0.str = arg_6_1
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.text.text = arg_7_0.str
end

function var_0_0.onClose(arg_8_0)
	return
end

return var_0_0
