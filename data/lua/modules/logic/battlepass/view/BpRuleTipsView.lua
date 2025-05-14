module("modules.logic.battlepass.view.BpRuleTipsView", package.seeall)

local var_0_0 = class("BpRuleTipsView", BaseView)

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

local var_0_1 = string.split

function var_0_0._btnclose1OnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnclose2OnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._titlecn = gohelper.findChildText(arg_6_0.viewGO, "title/titlecn")
	arg_6_0._titleen = gohelper.findChildText(arg_6_0.viewGO, "title/titlecn/titleen")
end

function var_0_0._ruleDesc(arg_7_0)
	local var_7_0 = arg_7_0.viewParam and arg_7_0.viewParam.ruleDesc

	if var_7_0 then
		return var_7_0
	end

	return arg_7_0.viewName == ViewName.BpSPRuleTipsView and luaLang("bp_sp_rule") or luaLang("bp_rule")
end

function var_0_0._title(arg_8_0)
	return arg_8_0.viewParam and arg_8_0.viewParam.title or luaLang("p_bpruletipsview_title")
end

function var_0_0._titleEn(arg_9_0)
	return arg_9_0.viewParam and arg_9_0.viewParam.titleEn or "JUKEBOX DETAILS"
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._titlecn.text = arg_10_0:_title()
	arg_10_0._titleen.text = arg_10_0:_titleEn()

	local var_10_0 = var_0_1(arg_10_0:_ruleDesc(), "|")

	for iter_10_0 = 1, #var_10_0, 2 do
		local var_10_1 = gohelper.cloneInPlace(arg_10_0._goinfoitem, "infoitem")

		gohelper.setActive(var_10_1, true)

		gohelper.findChildTextMesh(var_10_1, "txt_title").text = var_10_0[iter_10_0]
		gohelper.findChildTextMesh(var_10_1, "txt_desc").text = string.gsub(var_10_0[iter_10_0 + 1] or "", "UTC%+8", ServerTime.GetUTCOffsetStr())
	end
end

return var_0_0
