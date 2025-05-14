module("modules.logic.versionactivity2_4.pinball.view.PinballCurrencyItem2", package.seeall)

local var_0_0 = class("PinballCurrencyItem2", PinballCurrencyItem)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._txtNum = gohelper.findChildTextMesh(arg_1_1, "#txt_num")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_1, "#image_icon")
	arg_1_0._btn = gohelper.findButtonWithAudio(arg_1_1)
	arg_1_0._anim = gohelper.findChildAnim(arg_1_1, "")
end

function var_0_0.addEventListeners(arg_2_0)
	var_0_0.super.addEventListeners(arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.OperBuilding, arg_2_0._refreshUI, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.LearnTalent, arg_2_0._refreshUI, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	var_0_0.super.removeEventListeners(arg_3_0)
	PinballController.instance:unregisterCallback(PinballEvent.OperBuilding, arg_3_0._refreshUI, arg_3_0)
	PinballController.instance:unregisterCallback(PinballEvent.LearnTalent, arg_3_0._refreshUI, arg_3_0)
end

function var_0_0._refreshUI(arg_4_0)
	local var_4_0 = PinballModel.instance:getResNum(arg_4_0._currencyType)
	local var_4_1 = arg_4_0._currencyType == PinballEnum.ResType.Food and PinballModel.instance:getTotalFoodCost() or arg_4_0._currencyType == PinballEnum.ResType.Play and PinballModel.instance:getTotalPlayDemand() or 0
	local var_4_2 = math.max(var_4_1, 0)

	if arg_4_0._cacheNum and (arg_4_0._cacheNum ~= var_4_0 or arg_4_0._cacheMaxNum ~= var_4_2) then
		arg_4_0._anim:Play("refresh", 0, 0)
	end

	arg_4_0._cacheNum = var_4_0
	arg_4_0._cacheMaxNum = var_4_2

	if var_4_2 <= var_4_0 then
		arg_4_0._txtNum.text = GameUtil.numberDisplay(var_4_0) .. "/" .. GameUtil.numberDisplay(var_4_2)
	else
		arg_4_0._txtNum.text = "<color=#9F342C>" .. GameUtil.numberDisplay(var_4_0) .. "</color>/" .. GameUtil.numberDisplay(var_4_2)
	end

	local var_4_3 = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][arg_4_0._currencyType]

	if not var_4_3 then
		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(arg_4_0._imageicon, var_4_3.icon)
end

function var_0_0._openTips(arg_5_0)
	local var_5_0 = arg_5_0._imageicon.transform
	local var_5_1 = var_5_0.lossyScale
	local var_5_2 = var_5_0.position
	local var_5_3 = recthelper.getWidth(var_5_0)
	local var_5_4 = recthelper.getHeight(var_5_0)

	var_5_2.x = var_5_2.x - var_5_3 / 2 * var_5_1.x
	var_5_2.y = var_5_2.y + var_5_4 / 2 * var_5_1.y

	ViewMgr.instance:openView(ViewName.PinballCurrencyTipView, {
		arrow = "TR",
		type = arg_5_0._currencyType,
		pos = var_5_2
	})
end

return var_0_0
