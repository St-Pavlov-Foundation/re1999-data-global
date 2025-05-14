module("modules.logic.versionactivity2_4.pinball.view.PinballBagItem", package.seeall)

local var_0_0 = class("PinballBagItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._click = gohelper.findChildClickWithDefaultAudio(arg_1_1, "")
	arg_1_0._txtNum = gohelper.findChildTextMesh(arg_1_1, "#txt_num")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_1, "#image_icon")
	arg_1_0._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(arg_1_1)

	arg_1_0._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClick, arg_2_0)
	arg_2_0._btnLongPress:AddLongPressListener(arg_2_0._onLongClickItem, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._click:RemoveClickListener()
	arg_3_0._btnLongPress:RemoveLongPressListener()
end

function var_0_0._onClick(arg_4_0)
	if arg_4_0._curNum <= 0 then
		return
	end

	if arg_4_0._canPlaceNum <= 0 then
		return
	end

	PinballController.instance:dispatchEvent(PinballEvent.ClickBagItem, arg_4_0._resType)
end

function var_0_0._onLongClickItem(arg_5_0)
	local var_5_0 = arg_5_0._imageicon.transform
	local var_5_1 = var_5_0.lossyScale
	local var_5_2 = var_5_0.position
	local var_5_3 = recthelper.getWidth(var_5_0)

	var_5_2.x = var_5_2.x + var_5_3 / 2 * var_5_1.x

	ViewMgr.instance:openView(ViewName.PinballCurrencyTipView, {
		isMarbals = true,
		arrow = "TR",
		type = arg_5_0._resType,
		pos = var_5_2
	})
end

function var_0_0.setInfo(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._resType = arg_6_1 or arg_6_0._resType
	arg_6_0._curNum = arg_6_2 or arg_6_0._curNum
	arg_6_0._canPlaceNum = arg_6_3

	if arg_6_0._resType > 0 then
		local var_6_0 = lua_activity178_marbles.configDict[VersionActivity2_4Enum.ActivityId.Pinball][arg_6_0._resType]
		local var_6_1 = arg_6_2 > 0 and arg_6_3 > 0 and 1 or 0.5

		UISpriteSetMgr.instance:setAct178Sprite(arg_6_0._imageicon, var_6_0.icon, true, var_6_1)
		ZProj.UGUIHelper.SetColorAlpha(arg_6_0._imageicon, var_6_1)
	end

	arg_6_0._txtNum.text = arg_6_0._curNum
end

return var_0_0
