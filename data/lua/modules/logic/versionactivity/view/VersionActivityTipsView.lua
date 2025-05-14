module("modules.logic.versionactivity.view.VersionActivityTipsView", package.seeall)

local var_0_0 = class("VersionActivityTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close1", AudioEnum.UI.play_ui_help_close)
	arg_1_0._scrollinfo = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_info")
	arg_1_0._goinfoitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_info/Viewport/Content/#go_infoitem")
	arg_1_0._btnclose2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close2", AudioEnum.UI.play_ui_help_close)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose1:AddClickListener(arg_2_0._btnclose1OnClick, arg_2_0)
	arg_2_0._btnclose2:AddClickListener(arg_2_0._btnclose2OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose1:RemoveClickListener()
	arg_3_0._btnclose2:RemoveClickListener()
end

function var_0_0._btnclose1OnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnclose2OnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	local var_8_0 = luaLang("versionactivityexchange_rule")
	local var_8_1 = string.split(var_8_0, "|")

	for iter_8_0 = 1, #var_8_1, 2 do
		local var_8_2 = gohelper.cloneInPlace(arg_8_0._goinfoitem, "infoitem")

		gohelper.setActive(var_8_2, true)

		gohelper.findChildTextMesh(var_8_2, "txt_title").text = var_8_1[iter_8_0]
		gohelper.findChildTextMesh(var_8_2, "txt_desc").text = var_8_1[iter_8_0 + 1]
	end
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
