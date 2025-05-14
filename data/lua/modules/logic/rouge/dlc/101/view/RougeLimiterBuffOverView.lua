module("modules.logic.rouge.dlc.101.view.RougeLimiterBuffOverView", package.seeall)

local var_0_0 = class("RougeLimiterBuffOverView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollviews = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_views")
	arg_1_0._gobuffitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_views/Viewport/Content/#go_buffitem")

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
	arg_4_0._gobuffcontainer = gohelper.findChild(arg_4_0.viewGO, "#scroll_views/Viewport/Content")
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:initBuffList()
end

function var_0_0.initBuffList(arg_7_0)
	local var_7_0 = arg_7_0.viewParam and arg_7_0.viewParam.buffIds or {}

	table.sort(var_7_0, arg_7_0._buffMoSortFunc)
	gohelper.CreateObjList(arg_7_0, arg_7_0._refreshBuffItem, var_7_0, arg_7_0._gobuffcontainer, arg_7_0._gobuffitem)
end

function var_0_0._buffMoSortFunc(arg_8_0, arg_8_1)
	local var_8_0 = RougeDLCConfig101.instance:getLimiterBuffCo(arg_8_0)
	local var_8_1 = RougeDLCConfig101.instance:getLimiterBuffCo(arg_8_1)
	local var_8_2 = var_8_0 and var_8_0.buffType or 0
	local var_8_3 = var_8_1 and var_8_1.buffType or 0

	if var_8_2 ~= var_8_3 then
		return var_8_2 < var_8_3
	end

	return arg_8_0 < arg_8_1
end

function var_0_0._refreshBuffItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = RougeDLCConfig101.instance:getLimiterBuffCo(arg_9_2)
	local var_9_1 = gohelper.findChildImage(arg_9_1, "#image_bufficon")
	local var_9_2 = gohelper.findChildText(arg_9_1, "#txt_dec")
	local var_9_3 = gohelper.findChildText(arg_9_1, "#txt_name")

	var_9_2.text = var_9_0 and var_9_0.desc
	var_9_3.text = var_9_0 and var_9_0.title

	UISpriteSetMgr.instance:setRouge4Sprite(var_9_1, var_9_0.icon)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
