module("modules.logic.rouge.view.RougeFactionItem", package.seeall)

local var_0_0 = class("RougeFactionItem", RougeSimpleItemBase)
local var_0_1 = SLFramework.AnimatorPlayer

function var_0_0.ctor(arg_1_0, arg_1_1)
	RougeSimpleItemBase.ctor(arg_1_0, arg_1_1)

	arg_1_0._staticData.parentScrollViewGo = arg_1_1.baseViewContainer:getScrollViewGo()
	arg_1_0._staticData.startViewAllInfo = RougeController.instance:getStartViewAllInfo()
	arg_1_0._selected = RougeFactionItemSelected.New(arg_1_0)
	arg_1_0._unSelected = RougeFactionItemUnselected.New(arg_1_0)
	arg_1_0._locked = RougeFactionItemLocked.New(arg_1_0)
end

function var_0_0._editableInitView(arg_2_0)
	RougeSimpleItemBase._editableInitView(arg_2_0)

	arg_2_0._animatorPlayer = var_0_1.Get(arg_2_0.viewGO)
	arg_2_0._animSelf = arg_2_0._animatorPlayer.animator

	arg_2_0._selected:init(gohelper.findChild(arg_2_0.viewGO, "Select"))
	arg_2_0._unSelected:init(gohelper.findChild(arg_2_0.viewGO, "Unselect"))
	arg_2_0._locked:init(gohelper.findChild(arg_2_0.viewGO, "Locked"))
	arg_2_0._selected:setActive(false)
	arg_2_0._unSelected:setActive(false)
	arg_2_0._locked:setActive(false)
end

function var_0_0.onDestroyView(arg_3_0)
	RougeSimpleItemBase.onDestroyView(arg_3_0)
	GameUtil.onDestroyViewMember(arg_3_0, "_selected")
	GameUtil.onDestroyViewMember(arg_3_0, "_unSelected")
	GameUtil.onDestroyViewMember(arg_3_0, "_locked")
end

function var_0_0.setSelected(arg_4_0, arg_4_1)
	if not arg_4_0:isUnLocked() then
		return
	end

	RougeSimpleItemBase.setSelected(arg_4_0, arg_4_1)
end

function var_0_0.onSelect(arg_5_0, arg_5_1)
	arg_5_0._staticData.isSelected = arg_5_1

	arg_5_0._selected:setActive(arg_5_1)
	arg_5_0._unSelected:setActive(not arg_5_1)
end

function var_0_0.setData(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1
	arg_6_0._isUnLocked = arg_6_1.isUnLocked

	arg_6_0._selected:setData(arg_6_1)
	arg_6_0._unSelected:setData(arg_6_1)
	arg_6_0._locked:setData(arg_6_1)

	local var_6_0 = arg_6_0:isSelected()

	if arg_6_0:isUnLocked() then
		arg_6_0._selected:setActive(var_6_0)
		arg_6_0._unSelected:setActive(not var_6_0)
		arg_6_0._locked:setActive(false)
	else
		arg_6_0._locked:setActive(true)
	end
end

function var_0_0.isUnLocked(arg_7_0)
	return arg_7_0._mo.isUnLocked
end

function var_0_0.style(arg_8_0)
	return arg_8_0._mo.styleCO.id
end

function var_0_0.difficulty(arg_9_0)
	return arg_9_0:parent():_difficulty()
end

function var_0_0.setIsLocked(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._locked:setActive(arg_10_1)

	if not arg_10_2 then
		arg_10_0:playIdle()
		arg_10_0:onSelect(arg_10_0._staticData.isSelected)
	end
end

function var_0_0.playOpen(arg_11_0, arg_11_1)
	if arg_11_1 == true then
		arg_11_0._isNewUnlockAnim = true

		arg_11_0:setIsLocked(true, true)
	end

	arg_11_0:_playAnim(UIAnimationName.Open, arg_11_0._onOpenEnd, arg_11_0)
end

function var_0_0.playIdle(arg_12_0)
	arg_12_0._animSelf.enabled = true

	arg_12_0._animSelf:Play(UIAnimationName.Open, 0, 1)
end

function var_0_0.playClose(arg_13_0)
	arg_13_0:_playAnim(UIAnimationName.Close, arg_13_0._onCloseEnd, arg_13_0)
end

function var_0_0.setOnOpenEndCb(arg_14_0, arg_14_1)
	arg_14_0._onOpenEndCb = arg_14_1
end

function var_0_0._onOpenEnd(arg_15_0)
	if arg_15_0._onOpenEndCb then
		arg_15_0._onOpenEndCb()

		arg_15_0._onOpenEndCb = nil
	end

	if arg_15_0._isNewUnlockAnim then
		arg_15_0:_playAnim(UIAnimationName.Unlock, arg_15_0._onUnlockEnd, arg_15_0)

		arg_15_0._isNewUnlockAnim = nil
	end
end

function var_0_0.setOnCloseEndCb(arg_16_0, arg_16_1)
	arg_16_0._onCloseEndCb = arg_16_1
end

function var_0_0._onCloseEnd(arg_17_0)
	if arg_17_0._onCloseEndCb then
		arg_17_0._onCloseEndCb()

		arg_17_0._onCloseEndCb = nil
	end
end

function var_0_0.setOnUnlockEndCb(arg_18_0, arg_18_1)
	arg_18_0._onUnlockEndCb = arg_18_1
end

function var_0_0._onUnlockEnd(arg_19_0)
	if arg_19_0._onUnlockEndCb then
		arg_19_0._onUnlockEndCb()

		arg_19_0._onUnlockEndCb = nil
	end

	arg_19_0:setIsLocked(false)
	arg_19_0:onSelect(arg_19_0._staticData.isSelected)
end

function var_0_0._playAnim(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0._animatorPlayer:Play(arg_20_1, arg_20_2, arg_20_3)
end

return var_0_0
