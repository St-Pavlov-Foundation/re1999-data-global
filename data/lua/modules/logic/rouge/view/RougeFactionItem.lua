module("modules.logic.rouge.view.RougeFactionItem", package.seeall)

slot0 = class("RougeFactionItem", RougeSimpleItemBase)
slot1 = SLFramework.AnimatorPlayer

function slot0.ctor(slot0, slot1)
	RougeSimpleItemBase.ctor(slot0, slot1)

	slot0._staticData.parentScrollViewGo = slot1.baseViewContainer:getScrollViewGo()
	slot0._staticData.startViewAllInfo = RougeController.instance:getStartViewAllInfo()
	slot0._selected = RougeFactionItemSelected.New(slot0)
	slot0._unSelected = RougeFactionItemUnselected.New(slot0)
	slot0._locked = RougeFactionItemLocked.New(slot0)
end

function slot0._editableInitView(slot0)
	RougeSimpleItemBase._editableInitView(slot0)

	slot0._animatorPlayer = uv0.Get(slot0.viewGO)
	slot0._animSelf = slot0._animatorPlayer.animator

	slot0._selected:init(gohelper.findChild(slot0.viewGO, "Select"))
	slot0._unSelected:init(gohelper.findChild(slot0.viewGO, "Unselect"))
	slot0._locked:init(gohelper.findChild(slot0.viewGO, "Locked"))
	slot0._selected:setActive(false)
	slot0._unSelected:setActive(false)
	slot0._locked:setActive(false)
end

function slot0.onDestroyView(slot0)
	RougeSimpleItemBase.onDestroyView(slot0)
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
		slot0._locked:setActive(false)
	else
		slot0._locked:setActive(true)
	end
end

function slot0.isUnLocked(slot0)
	return slot0._mo.isUnLocked
end

function slot0.style(slot0)
	return slot0._mo.styleCO.id
end

function slot0.difficulty(slot0)
	return slot0:parent():_difficulty()
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
