module("modules.logic.versionactivity2_4.pinball.view.PinballCurrencyItem", package.seeall)

local var_0_0 = class("PinballCurrencyItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._txtNum = gohelper.findChildTextMesh(arg_1_1, "content/#txt")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_1, "#image")
	arg_1_0._btn = gohelper.findButtonWithAudio(arg_1_1)
	arg_1_0._anim = gohelper.findChildAnim(arg_1_1, "")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btn:AddClickListener(arg_2_0._openTips, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, arg_2_0._refreshUI, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.EndRound, arg_2_0._refreshUI, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btn:RemoveClickListener()
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, arg_3_0._refreshUI, arg_3_0)
	PinballController.instance:unregisterCallback(PinballEvent.EndRound, arg_3_0._refreshUI, arg_3_0)
end

function var_0_0.setCurrencyType(arg_4_0, arg_4_1)
	arg_4_0._currencyType = arg_4_1

	arg_4_0:_refreshUI()
end

function var_0_0._refreshUI(arg_5_0)
	local var_5_0 = PinballModel.instance:getResNum(arg_5_0._currencyType)

	if arg_5_0._cacheNum and var_5_0 > arg_5_0._cacheNum then
		arg_5_0._anim:Play("refresh", 0, 0)
	end

	arg_5_0._cacheNum = var_5_0
	arg_5_0._txtNum.text = GameUtil.numberDisplay(var_5_0)

	local var_5_1 = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][arg_5_0._currencyType]

	if not var_5_1 then
		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(arg_5_0._imageicon, var_5_1.icon)
end

function var_0_0._openTips(arg_6_0)
	local var_6_0 = arg_6_0._imageicon.transform
	local var_6_1 = var_6_0.lossyScale
	local var_6_2 = var_6_0.position
	local var_6_3 = recthelper.getWidth(var_6_0)
	local var_6_4 = recthelper.getHeight(var_6_0)

	var_6_2.x = var_6_2.x + var_6_3 / 2 * var_6_1.x
	var_6_2.y = var_6_2.y - var_6_4 / 2 * var_6_1.y

	ViewMgr.instance:openView(ViewName.PinballCurrencyTipView, {
		arrow = "BL",
		type = arg_6_0._currencyType,
		pos = var_6_2
	})
end

return var_0_0
