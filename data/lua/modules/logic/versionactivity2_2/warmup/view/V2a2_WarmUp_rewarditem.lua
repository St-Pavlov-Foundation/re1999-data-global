module("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUp_rewarditem", package.seeall)

local var_0_0 = class("V2a2_WarmUp_rewarditem", RougeSimpleItemBase)

function var_0_0.onInitView(arg_1_0)
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

function var_0_0.ctor(arg_4_0, arg_4_1)
	var_0_0.super.ctor(arg_4_0, arg_4_1)
end

function var_0_0.onDestroyView(arg_5_0)
	var_0_0.super.onDestroyView(arg_5_0)
end

function var_0_0._editableInitView(arg_6_0)
	var_0_0.super._editableInitView(arg_6_0)

	arg_6_0._go_hasget = gohelper.findChild(arg_6_0.viewGO, "go_receive/go_hasget")
	arg_6_0._goreceive = gohelper.findChild(arg_6_0.viewGO, "go_receive")
	arg_6_0._gocanget = gohelper.findChild(arg_6_0.viewGO, "go_canget")
	arg_6_0._icon = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(arg_6_0.viewGO, "go_icon"))
	arg_6_0._hasgetAnim = arg_6_0._go_hasget:GetComponent(gohelper.Type_Animator)

	gohelper.setActive(arg_6_0._goreceive, true)
end

function var_0_0.onSelect(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0._goDateSelected, arg_7_1)
	gohelper.setActive(arg_7_0._txtDateUnSelectedGo, not arg_7_1)
end

function var_0_0._getRLOC(arg_8_0, arg_8_1)
	return arg_8_0:_assetGetViewContainer():getRLOC(arg_8_1)
end

function var_0_0._getCurSelectedEpisode(arg_9_0)
	return arg_9_0:_assetGetViewContainer():getCurSelectedEpisode()
end

function var_0_0._isWaitingPlayHasGetAnim(arg_10_0)
	return arg_10_0:_assetGetViewContainer():isWaitingPlayHasGetAnim()
end

function var_0_0.setData(arg_11_0, arg_11_1)
	arg_11_0._mo = arg_11_1

	local var_11_0 = arg_11_1
	local var_11_1 = arg_11_0:_getCurSelectedEpisode()
	local var_11_2, var_11_3, var_11_4, var_11_5 = arg_11_0:_getRLOC(var_11_1)
	local var_11_6 = var_11_2 and not arg_11_0:_isWaitingPlayHasGetAnim()

	arg_11_0._icon:setMOValue(var_11_0[1], var_11_0[2], var_11_0[3])
	arg_11_0._icon:setCountFontSize(42)
	arg_11_0._icon:setScale(0.5)
	arg_11_0:_setActive_canget(var_11_5)
	arg_11_0:_setActive_hasget(var_11_6)

	if var_11_6 then
		arg_11_0:_set_Received()
	end
end

local var_0_1 = "go_hasget_in"
local var_0_2 = "go_hasget_idle"

function var_0_0.playAnim_hasget(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1 and var_0_2 or var_0_1

	arg_12_0:_setActive_canget(false)
	arg_12_0:_setActive_hasget(not arg_12_1)
	arg_12_0._hasgetAnim:Play(var_12_0, 0, 0)
end

function var_0_0._set_Received(arg_13_0)
	arg_13_0._hasgetAnim:Play(var_0_1, 0, 1)
end

function var_0_0._setActive_canget(arg_14_0, arg_14_1)
	gohelper.setActive(arg_14_0._gocanget, arg_14_1)
end

function var_0_0._setActive_hasget(arg_15_0, arg_15_1)
	gohelper.setActive(arg_15_0._go_hasget, arg_15_1)
end

return var_0_0
