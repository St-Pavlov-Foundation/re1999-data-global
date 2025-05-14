module("modules.logic.rouge.view.RougeDifficultyItem", package.seeall)

local var_0_0 = class("RougeDifficultyItem", RougeSimpleItemBase)
local var_0_1 = ZProj.TweenHelper
local var_0_2 = SLFramework.AnimatorPlayer

var_0_0.ScalerSelected = 1
var_0_0.ScalerSelectedAdjacent = 0.9
var_0_0.ScalerNormal = 0.85

function var_0_0.ctor(arg_1_0, arg_1_1)
	RougeSimpleItemBase.ctor(arg_1_0, arg_1_1)

	arg_1_0._staticData.parentScrollViewGo = arg_1_1.baseViewContainer:getScrollViewGo()
	arg_1_0._staticData.geniusBranchStartViewInfo = RougeOutsideModel.instance:getGeniusBranchStartViewAllInfo()
	arg_1_0._selected = RougeDifficultyItemSelected.New(arg_1_0)
	arg_1_0._unSelected = RougeDifficultyItemUnselected.New(arg_1_0)
	arg_1_0._locked = RougeDifficultyItemLocked.New(arg_1_0)
end

function var_0_0._editableInitView(arg_2_0)
	RougeSimpleItemBase._editableInitView(arg_2_0)

	arg_2_0._animatorPlayer = var_0_2.Get(arg_2_0.viewGO)
	arg_2_0._animSelf = arg_2_0._animatorPlayer.animator
	arg_2_0._root = gohelper.findChild(arg_2_0.viewGO, "Root")
	arg_2_0._rootTrans = arg_2_0._root.transform

	arg_2_0._selected:init(gohelper.findChild(arg_2_0._root, "Select"))
	arg_2_0._unSelected:init(gohelper.findChild(arg_2_0._root, "Unselect"))
	arg_2_0._locked:init(gohelper.findChild(arg_2_0._root, "Locked"))

	arg_2_0._itemClick = gohelper.getClickWithAudio(arg_2_0._gobg)

	arg_2_0:setScale(var_0_0.ScalerSelectedAdjacent)
	arg_2_0._selected:setActive(false)
	arg_2_0._unSelected:setActive(false)
	arg_2_0._locked:setActive(false)
end

function var_0_0.onDestroyView(arg_3_0)
	RougeSimpleItemBase.onDestroyView(arg_3_0)
	arg_3_0:_killTween()
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
	else
		arg_6_0._locked:setActive(true)
	end
end

function var_0_0.isUnLocked(arg_7_0)
	return arg_7_0._mo.isUnLocked
end

function var_0_0.setScale(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 then
		arg_8_0:tweenScale(arg_8_1)
	else
		transformhelper.setLocalScale(arg_8_0._rootTrans, arg_8_1, arg_8_1, arg_8_1)
	end
end

function var_0_0.setScale01(arg_9_0, arg_9_1)
	arg_9_1 = arg_9_1 or 1
	arg_9_1 = GameUtil.remap(arg_9_1, 0, 1, var_0_0.ScalerSelectedAdjacent, var_0_0.ScalerSelected)

	arg_9_0:setScale(arg_9_1)
end

function var_0_0.tweenScale(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2 = arg_10_2 or 0.4

	arg_10_0:_killTween()

	arg_10_0._tweenRotationId = var_0_1.DOScale(arg_10_0._rootTrans, arg_10_1, arg_10_1, arg_10_1, arg_10_2, nil, nil, nil, EaseType.OutQuad)
end

function var_0_0._killTween(arg_11_0)
	GameUtil.onDestroyViewMember_TweenId(arg_11_0, "_tweenRotationId")
end

function var_0_0.setIsLocked(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._locked:setActive(arg_12_1)

	if not arg_12_2 then
		arg_12_0:playIdle()
		arg_12_0:onSelect(arg_12_0._staticData.isSelected)
	end
end

function var_0_0.playOpen(arg_13_0, arg_13_1)
	if arg_13_1 == true then
		arg_13_0._isNewUnlockAnim = true

		arg_13_0:setIsLocked(true, true)
	end

	arg_13_0:_playAnim(UIAnimationName.Open, arg_13_0._onOpenEnd, arg_13_0)
end

function var_0_0.playIdle(arg_14_0)
	arg_14_0._animSelf.enabled = true

	arg_14_0._animSelf:Play(UIAnimationName.Open, 0, 1)
end

function var_0_0.playClose(arg_15_0)
	arg_15_0:_playAnim(UIAnimationName.Close, arg_15_0._onCloseEnd, arg_15_0)
end

function var_0_0.setOnOpenEndCb(arg_16_0, arg_16_1)
	arg_16_0._onOpenEndCb = arg_16_1
end

function var_0_0._onOpenEnd(arg_17_0)
	if arg_17_0._onOpenEndCb then
		arg_17_0._onOpenEndCb()

		arg_17_0._onOpenEndCb = nil
	end

	if arg_17_0._isNewUnlockAnim then
		arg_17_0:_playAnim(UIAnimationName.Unlock, arg_17_0._onUnlockEnd, arg_17_0)

		arg_17_0._isNewUnlockAnim = nil
	end
end

function var_0_0.setOnCloseEndCb(arg_18_0, arg_18_1)
	arg_18_0._onCloseEndCb = arg_18_1
end

function var_0_0._onCloseEnd(arg_19_0)
	if arg_19_0._onCloseEndCb then
		arg_19_0._onCloseEndCb()

		arg_19_0._onCloseEndCb = nil
	end
end

function var_0_0.setOnUnlockEndCb(arg_20_0, arg_20_1)
	arg_20_0._onUnlockEndCb = arg_20_1
end

function var_0_0._onUnlockEnd(arg_21_0)
	if arg_21_0._onUnlockEndCb then
		arg_21_0._onUnlockEndCb()

		arg_21_0._onUnlockEndCb = nil
	end

	arg_21_0:setIsLocked(false)
	arg_21_0:onSelect(arg_21_0._staticData.isSelected)
end

function var_0_0._playAnim(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	arg_22_0._animatorPlayer:Play(arg_22_1, arg_22_2, arg_22_3)
end

return var_0_0
