module("modules.logic.versionactivity2_4.pinball.view.PinballTalentItem", package.seeall)

local var_0_0 = class("PinballTalentItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_1, "#image_icon")
	arg_1_0._imageiconbg_select = gohelper.findChildImage(arg_1_1, "#image_iconbg_select")
	arg_1_0._imageiconbg_unselect = gohelper.findChildImage(arg_1_1, "#image_iconbg_unselect")
	arg_1_0._effect = gohelper.findChild(arg_1_1, "vx_upgrade")
	arg_1_0._red = gohelper.findChild(arg_1_1, "go_reddot")
end

function var_0_0.addEventListeners(arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, arg_2_0._refreshUI, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, arg_3_0._refreshUI, arg_3_0)
end

function var_0_0.setData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._data = arg_4_1
	arg_4_0._buildingCo = arg_4_2
end

function var_0_0.onLearn(arg_5_0)
	gohelper.setActive(arg_5_0._effect, false)
	gohelper.setActive(arg_5_0._effect, true)
end

function var_0_0._refreshUI(arg_6_0)
	arg_6_0:setSelect(false)
end

function var_0_0.setSelect(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:isActive()
	local var_7_1 = arg_7_0:canActive2()
	local var_7_2 = arg_7_0._data.isBig
	local var_7_3 = ""

	if arg_7_1 and var_7_0 and var_7_2 then
		var_7_3 = "v2a4_tutushizi_talenbg1_1"
	elseif arg_7_1 and not var_7_0 and var_7_1 and var_7_2 then
		var_7_3 = "v2a4_tutushizi_talenbg1_2"
	elseif arg_7_1 and not var_7_0 and not var_7_1 and var_7_2 then
		var_7_3 = "v2a4_tutushizi_talenbg1_0"
	elseif not arg_7_1 and var_7_0 and var_7_2 then
		var_7_3 = "v2a4_tutushizi_talenbg1_3"
	elseif not arg_7_1 and not var_7_0 and var_7_1 and var_7_2 then
		var_7_3 = "v2a4_tutushizi_talenbg1_4"
	elseif not arg_7_1 and not var_7_0 and not var_7_1 and var_7_2 then
		var_7_3 = "v2a4_tutushizi_talenbg1_5"
	elseif arg_7_1 and var_7_0 and not var_7_2 then
		var_7_3 = "v2a4_tutushizi_talenbg2_1"
	elseif arg_7_1 and not var_7_0 and var_7_1 and not var_7_2 then
		var_7_3 = "v2a4_tutushizi_talenbg2_2"
	elseif arg_7_1 and not var_7_0 and not var_7_1 and not var_7_2 then
		var_7_3 = "v2a4_tutushizi_talenbg2_0"
	elseif not arg_7_1 and var_7_0 and not var_7_2 then
		var_7_3 = "v2a4_tutushizi_talenbg2_3"
	elseif not arg_7_1 and not var_7_0 and var_7_1 and not var_7_2 then
		var_7_3 = "v2a4_tutushizi_talenbg2_4"
	elseif not arg_7_1 and not var_7_0 and not var_7_1 and not var_7_2 then
		var_7_3 = "v2a4_tutushizi_talenbg2_5"
	end

	UISpriteSetMgr.instance:setAct178Sprite(arg_7_0._imageicon, arg_7_0._data.icon)
	UISpriteSetMgr.instance:setAct178Sprite(arg_7_0._imageiconbg_select, var_7_3)
	UISpriteSetMgr.instance:setAct178Sprite(arg_7_0._imageiconbg_unselect, var_7_3)
	gohelper.setActive(arg_7_0._imageiconbg_select, arg_7_1)
	gohelper.setActive(arg_7_0._imageiconbg_unselect, not arg_7_1)
	gohelper.setActive(arg_7_0._red, var_7_1)
end

function var_0_0.isActive(arg_8_0)
	if not arg_8_0._data then
		return false
	end

	return PinballModel.instance:getTalentMo(arg_8_0._data.id) and true or false
end

function var_0_0.canActive(arg_9_0)
	local var_9_0 = string.splitToNumber(arg_9_0._data.condition, "#") or {}

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		if not PinballModel.instance:getTalentMo(iter_9_1) then
			return false
		end
	end

	local var_9_1 = arg_9_0._buildingCo
	local var_9_2 = arg_9_0._data.needLv
	local var_9_3 = PinballModel.instance:getBuildingInfoById(var_9_1.id)

	if var_9_3 and var_9_2 > var_9_3.level then
		return false
	end

	return true
end

function var_0_0.canActive2(arg_10_0)
	if arg_10_0:isActive() then
		return false
	end

	if not arg_10_0:canActive() then
		return false
	end

	local var_10_0 = arg_10_0._data.cost

	if not string.nilorempty(var_10_0) then
		local var_10_1 = GameUtil.splitString2(var_10_0, true)

		for iter_10_0, iter_10_1 in pairs(var_10_1) do
			if iter_10_1[2] > PinballModel.instance:getResNum(iter_10_1[1]) then
				return false
			end
		end
	end

	return true
end

return var_0_0
