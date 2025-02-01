module("modules.logic.rouge.view.RougeDifficultyItem", package.seeall)

slot0 = class("RougeDifficultyItem", RougeSimpleItemBase)
slot1 = ZProj.TweenHelper
slot2 = SLFramework.AnimatorPlayer
slot0.ScalerSelected = 1
slot0.ScalerSelectedAdjacent = 0.9
slot0.ScalerNormal = 0.85

function slot0.ctor(slot0, slot1)
	RougeSimpleItemBase.ctor(slot0, slot1)

	slot0._staticData.parentScrollViewGo = slot1.baseViewContainer:getScrollViewGo()
	slot0._staticData.geniusBranchStartViewInfo = RougeOutsideModel.instance:getGeniusBranchStartViewAllInfo()
	slot0._selected = RougeDifficultyItemSelected.New(slot0)
	slot0._unSelected = RougeDifficultyItemUnselected.New(slot0)
	slot0._locked = RougeDifficultyItemLocked.New(slot0)
end

function slot0._editableInitView(slot0)
	RougeSimpleItemBase._editableInitView(slot0)

	slot0._animatorPlayer = uv0.Get(slot0.viewGO)
	slot0._animSelf = slot0._animatorPlayer.animator
	slot0._root = gohelper.findChild(slot0.viewGO, "Root")
	slot0._rootTrans = slot0._root.transform

	slot0._selected:init(gohelper.findChild(slot0._root, "Select"))
	slot0._unSelected:init(gohelper.findChild(slot0._root, "Unselect"))
	slot0._locked:init(gohelper.findChild(slot0._root, "Locked"))

	slot0._itemClick = gohelper.getClickWithAudio(slot0._gobg)

	slot0:setScale(uv1.ScalerSelectedAdjacent)
	slot0._selected:setActive(false)
	slot0._unSelected:setActive(false)
	slot0._locked:setActive(false)
end

function slot0.onDestroyView(slot0)
	RougeSimpleItemBase.onDestroyView(slot0)
	slot0:_killTween()
	GameUtil.onDestroyViewMember(slot0, "_selected")
	GameUtil.onDestroyViewMember(slot0, "_unSelected")
	GameUtil.onDestroyViewMember(slot0, "_locked")
end

function slot0.setSelected(slot0, slot1)
	if not slot0:isUnLocked() then
		return
	end

	RougeSimpleItemBase.setSelected(slot0, slot1)
end

function slot0.onSelect(slot0, slot1)
	slot0._staticData.isSelected = slot1

	slot0._selected:setActive(slot1)
	slot0._unSelected:setActive(not slot1)
end

function slot0.setData(slot0, slot1)
	slot0._mo = slot1
	slot0._isUnLocked = slot1.isUnLocked

	slot0._selected:setData(slot1)
	slot0._unSelected:setData(slot1)
	slot0._locked:setData(slot1)

	slot2 = slot0:isSelected()

	if slot0:isUnLocked() then
		slot0._selected:setActive(slot2)
		slot0._unSelected:setActive(not slot2)
	else
		slot0._locked:setActive(true)
	end
end

function slot0.isUnLocked(slot0)
	return slot0._mo.isUnLocked
end

function slot0.setScale(slot0, slot1, slot2)
	if slot2 then
		slot0:tweenScale(slot1)
	else
		transformhelper.setLocalScale(slot0._rootTrans, slot1, slot1, slot1)
	end
end

function slot0.setScale01(slot0, slot1)
	slot0:setScale(GameUtil.remap(slot1 or 1, 0, 1, uv0.ScalerSelectedAdjacent, uv0.ScalerSelected))
end

function slot0.tweenScale(slot0, slot1, slot2)
	slot0:_killTween()

	slot0._tweenRotationId = uv0.DOScale(slot0._rootTrans, slot1, slot1, slot1, slot2 or 0.4, nil, , , EaseType.OutQuad)
end

function slot0._killTween(slot0)
	GameUtil.onDestroyViewMember_TweenId(slot0, "_tweenRotationId")
end

function slot0.setIsLocked(slot0, slot1, slot2)
	slot0._locked:setActive(slot1)

	if not slot2 then
		slot0:playIdle()
		slot0:onSelect(slot0._staticData.isSelected)
	end
end

function slot0.playOpen(slot0, slot1)
	if slot1 == true then
		slot0._isNewUnlockAnim = true

		slot0:setIsLocked(true, true)
	end

	slot0:_playAnim(UIAnimationName.Open, slot0._onOpenEnd, slot0)
end

function slot0.playIdle(slot0)
	slot0._animSelf.enabled = true

	slot0._animSelf:Play(UIAnimationName.Open, 0, 1)
end

function slot0.playClose(slot0)
	slot0:_playAnim(UIAnimationName.Close, slot0._onCloseEnd, slot0)
end

function slot0.setOnOpenEndCb(slot0, slot1)
	slot0._onOpenEndCb = slot1
end

function slot0._onOpenEnd(slot0)
	if slot0._onOpenEndCb then
		slot0._onOpenEndCb()

		slot0._onOpenEndCb = nil
	end

	if slot0._isNewUnlockAnim then
		slot0:_playAnim(UIAnimationName.Unlock, slot0._onUnlockEnd, slot0)

		slot0._isNewUnlockAnim = nil
	end
end

function slot0.setOnCloseEndCb(slot0, slot1)
	slot0._onCloseEndCb = slot1
end

function slot0._onCloseEnd(slot0)
	if slot0._onCloseEndCb then
		slot0._onCloseEndCb()

		slot0._onCloseEndCb = nil
	end
end

function slot0.setOnUnlockEndCb(slot0, slot1)
	slot0._onUnlockEndCb = slot1
end

function slot0._onUnlockEnd(slot0)
	if slot0._onUnlockEndCb then
		slot0._onUnlockEndCb()

		slot0._onUnlockEndCb = nil
	end

	slot0:setIsLocked(false)
	slot0:onSelect(slot0._staticData.isSelected)
end

function slot0._playAnim(slot0, slot1, slot2, slot3)
	slot0._animatorPlayer:Play(slot1, slot2, slot3)
end

return slot0
