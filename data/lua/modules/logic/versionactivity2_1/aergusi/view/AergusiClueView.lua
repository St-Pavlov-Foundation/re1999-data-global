module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueView", package.seeall)

local var_0_0 = class("AergusiClueView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._simagenotebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#simage_notebg")

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
	arg_4_0:_addEvents()
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	return
end

function var_0_0._addEvents(arg_7_0)
	return
end

function var_0_0._removeEvents(arg_8_0)
	return
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0:_removeEvents()
end

return var_0_0
