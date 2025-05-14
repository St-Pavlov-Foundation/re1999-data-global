module("modules.logic.rouge.dlc.101.view.RougeLimiterViewEmblemComp", package.seeall)

local var_0_0 = class("RougeLimiterViewEmblemComp", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0.rootPath = arg_1_1
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._goroot = gohelper.findChild(arg_2_0.viewGO, arg_2_0.rootPath)
	arg_2_0._txtpoint = gohelper.findChildText(arg_2_0._goroot, "point/#txt_point")
	arg_2_0._btnclick = gohelper.findChildButtonWithAudio(arg_2_0._goroot, "point/#btn_click")
	arg_2_0._gotips = gohelper.findChild(arg_2_0._goroot, "tips")
	arg_2_0._txttips = gohelper.findChildText(arg_2_0._goroot, "tips/#txt_tips")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnclick:AddClickListener(arg_3_0._btnclickOnClick, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_5_0)
	arg_5_0._isTipVisible = not arg_5_0._isTipVisible

	gohelper.setActive(arg_5_0._gotips, arg_5_0._isTipVisible)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.UpdateEmblem, arg_6_0._onUpdateEmblem, arg_6_0)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._emblemCount = RougeDLCModel101.instance:getTotalEmblemCount()

	arg_8_0:initEmblemCount()
	arg_8_0:refreshEmblemTips()
end

function var_0_0.initEmblemCount(arg_9_0)
	arg_9_0._txtpoint.text = arg_9_0._emblemCount
end

function var_0_0.refreshEmblemTips(arg_10_0)
	local var_10_0 = lua_rouge_dlc_const.configDict[RougeDLCEnum101.Const.MaxEmblemCount]
	local var_10_1 = var_10_0 and var_10_0.value or 0
	local var_10_2 = {
		arg_10_0._emblemCount,
		var_10_1
	}

	arg_10_0._txttips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_dlc_101_emblemTips"), var_10_2)
end

function var_0_0._onUpdateEmblem(arg_11_0)
	arg_11_0._emblemCount = RougeDLCModel101.instance:getTotalEmblemCount()

	arg_11_0:initEmblemCount()
	arg_11_0:refreshEmblemTips()
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
