module("modules.logic.test.view.TestUIView", package.seeall)

local var_0_0 = class("TestUIView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(gohelper.getClick(gohelper.findChild(arg_2_0.viewGO, "#btn_decompose")), arg_2_0._onClick, arg_2_0)
	arg_2_0:addClickCb(gohelper.getClick(gohelper.findChild(arg_2_0.viewGO, "#btn_1")), arg_2_0._on1Click, arg_2_0)
	arg_2_0:addClickCb(gohelper.getClick(gohelper.findChild(arg_2_0.viewGO, "#btn_2")), arg_2_0._on2Click, arg_2_0)
	arg_2_0:addClickCb(gohelper.getClick(gohelper.findChild(arg_2_0.viewGO, "#btn_3")), arg_2_0._on3Click, arg_2_0)
	arg_2_0:addClickCb(gohelper.getClick(gohelper.findChild(arg_2_0.viewGO, "#btn_close_exclusive")), arg_2_0._onCloseExclusive, arg_2_0)
end

function var_0_0._onClick(arg_3_0)
	if arg_3_0.sub_view then
		arg_3_0.sub_view:setViewVisible(true)
	else
		arg_3_0.sub_view = arg_3_0:openSubView(TestUISubView, "ui/viewres/test/testuisubview.prefab")
	end
end

function var_0_0._on1Click(arg_4_0)
	arg_4_0:openSubView(TestHeroBagView)
end

function var_0_0._on2Click(arg_5_0)
	arg_5_0:openExclusiveView(nil, 2, TestUIExclusive, "ui/viewres/test/testuiexclusiveview.prefab", nil, 2)
end

function var_0_0._on3Click(arg_6_0)
	arg_6_0:openExclusiveView(nil, 3, TestUIExclusive, "ui/viewres/test/testuiexclusiveview.prefab", nil, 3)
end

function var_0_0._onCloseExclusive(arg_7_0)
	arg_7_0:hideExclusiveGroup(1)
end

function var_0_0.onOpen(arg_8_0)
	return
end

function var_0_0.onClose(arg_9_0)
	return
end

return var_0_0
