module("modules.logic.act189.view.ShortenAct_FullView", package.seeall)

local var_0_0 = class("ShortenAct_FullView", ShortenActView_impl)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "root/right/limittimebg/#txt_time")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/right/#simage_title")
	arg_1_0._scrolltasklist = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/right/#scroll_tasklist")
	arg_1_0._go28days = gohelper.findChild(arg_1_0.viewGO, "root/#go_28days")
	arg_1_0._go35days = gohelper.findChild(arg_1_0.viewGO, "root/#go_35days")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	var_0_0.super._editableInitView(arg_4_0)
	Activity189Controller.instance:sendGetAct189InfoRequest(arg_4_0:actId())
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = arg_5_0.viewParam.parent

	gohelper.addChild(var_5_0, arg_5_0.viewGO)
	var_0_0.super.onOpen(arg_5_0)
end

return var_0_0
