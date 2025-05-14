module("modules.logic.room.view.critter.summon.RoomCritterSummonRuleTipsView", package.seeall)

local var_0_0 = class("RoomCritterSummonRuleTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close1")
	arg_1_0._scrollinfo = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_info")
	arg_1_0._goinfoitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_info/Viewport/Content/#go_infoitem")
	arg_1_0._btnclose2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close2")

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
	arg_6_0._txttilte = gohelper.findChildText(arg_6_0.viewGO, "title/titlecn")
	arg_6_0._txttilteEn = gohelper.findChildText(arg_6_0.viewGO, "title/titlecn/titleen")
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	local var_8_0 = arg_8_0.viewParam.type
	local var_8_1 = RoomSummonEnum.SummonMode[var_8_0].RuleTipDesc
	local var_8_2 = luaLang(var_8_1.desc)
	local var_8_3 = string.split(var_8_2, "|")

	for iter_8_0 = 1, #var_8_3, 2 do
		local var_8_4 = gohelper.cloneInPlace(arg_8_0._goinfoitem, "infoitem")

		gohelper.setActive(var_8_4, true)

		gohelper.findChildTextMesh(var_8_4, "txt_title").text = var_8_3[iter_8_0]
		gohelper.findChildTextMesh(var_8_4, "txt_desc").text = var_8_3[iter_8_0 + 1]
	end

	arg_8_0._txttilte.text = luaLang(var_8_1.titlecn)
	arg_8_0._txttilteEn.text = luaLang(var_8_1.titleen)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
