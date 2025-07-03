module("modules.logic.versionactivity2_5.challenge.view.result.Act183ReportView", package.seeall)

local var_0_0 = class("Act183ReportView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")
	arg_1_0._scrollreview = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#scroll_review")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "root/#go_empty")

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
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = Act183ReportListModel.instance:getCount()

	gohelper.setActive(arg_6_0._goempty, var_6_0 <= 0)
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

return var_0_0
