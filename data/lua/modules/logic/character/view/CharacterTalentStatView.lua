module("modules.logic.character.view.CharacterTalentStatView", package.seeall)

local var_0_0 = class("CharacterTalentStatView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "Scroll View/Viewport/Content/#go_item")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "Scroll View/Viewport/Content/#go_item/slot/#go_normal")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "Scroll View/Viewport/Content/#go_item/slot/#image_icon")
	arg_1_0._imageglow = gohelper.findChildImage(arg_1_0.viewGO, "Scroll View/Viewport/Content/#go_item/slot/#image_glow")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "Scroll View/Viewport/Content/#go_item/#txt_name")
	arg_1_0._gopercent = gohelper.findChild(arg_1_0.viewGO, "Scroll View/Viewport/Content/#go_item/#go_percent")
	arg_1_0._txtpercent = gohelper.findChildText(arg_1_0.viewGO, "Scroll View/Viewport/Content/#go_item/#txt_percent")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	gohelper.setActive(arg_7_0._goitem, false)

	arg_7_0.heroId = arg_7_0.viewParam.heroId

	arg_7_0:showStylePercentList()
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

function var_0_0.showStylePercentList(arg_10_0)
	local var_10_0 = TalentStyleModel.instance:getStyleCoList(arg_10_0.heroId)

	if not var_10_0 then
		return
	end

	if not arg_10_0._itemList then
		arg_10_0._itemList = arg_10_0:getUserDataTb_()
	end

	local var_10_1 = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		table.insert(var_10_1, iter_10_1)
	end

	table.sort(var_10_1, TalentStyleModel.sortUnlockPercent)

	for iter_10_2, iter_10_3 in ipairs(var_10_1) do
		arg_10_0:getItem(iter_10_2):onRefreshMo(iter_10_3)
	end

	for iter_10_4 = 1, #arg_10_0._itemList do
		local var_10_2 = arg_10_0._itemList[iter_10_4]

		gohelper.setActive(var_10_2.viewGO, iter_10_4 <= #var_10_0)
	end
end

function var_0_0.getItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._itemList[arg_11_1]

	if not var_11_0 then
		local var_11_1 = gohelper.cloneInPlace(arg_11_0._goitem, "item_" .. arg_11_1)

		var_11_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_1, CharacterTalentStatItem)
		arg_11_0._itemList[arg_11_1] = var_11_0
	end

	return var_11_0
end

return var_0_0
