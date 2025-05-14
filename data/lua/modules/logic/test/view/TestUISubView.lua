module("modules.logic.test.view.TestUISubView", package.seeall)

local var_0_0 = class("TestUISubView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	return
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(gohelper.getClick(gohelper.findChild(arg_2_0.viewGO, "#simage_bg")), arg_2_0._onClick, arg_2_0)
	arg_2_0:addClickCb(gohelper.getClick(gohelper.findChild(arg_2_0.viewGO, "#btn_decompose")), arg_2_0._onOpenSubView, arg_2_0)
end

function var_0_0._onOpenSubView(arg_3_0)
	if arg_3_0.sub_view then
		arg_3_0.sub_view:setViewVisible(true)
	else
		arg_3_0.sub_view = arg_3_0:openSubView(var_0_0, "ui/viewres/test/testuisubview.prefab")
	end
end

function var_0_0._onClick(arg_4_0)
	arg_4_0:setViewVisible(false)
end

function var_0_0.onOpen(arg_5_0)
	return
end

function var_0_0.onClose(arg_6_0)
	return
end

return var_0_0
