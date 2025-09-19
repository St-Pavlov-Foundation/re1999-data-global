module("modules.logic.survival.view.map.SurvivalLogView", package.seeall)

local var_0_0 = class("SurvivalLogView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._item = gohelper.findChild(arg_1_0.viewGO, "root/#go_info/scroll_log/Viewport/Content/#txt_logitem")
	arg_1_0._btncose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncose:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncose:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	gohelper.CreateObjList(arg_4_0, arg_4_0._createLogItem, arg_4_0.viewParam, nil, arg_4_0._item)
end

function var_0_0._createLogItem(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	gohelper.findChildTextMesh(arg_5_1, "").text = arg_5_2:getLogStr()
end

function var_0_0.onClickModalMask(arg_6_0)
	arg_6_0:closeThis()
end

return var_0_0
