module("modules.logic.playercard.view.comp.PlayerCardLayoutItem", package.seeall)

slot0 = class("PlayerCardLayoutItem", LuaCompBase)
slot0.TweenDuration = 0.16

function slot0.ctor(slot0, slot1)
	slot0._param = slot1
	slot0.viewRoot = slot1.viewRoot.transform
	slot0.layout = slot1.layout
	slot0.cardComp = slot1.cardComp
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.transform = slot1.transform
	slot0.goPut = gohelper.findChild(slot1, "card/put")
	slot0.frame = gohelper.findChild(slot1, "frame")
	slot0.goCard = gohelper.findChild(slot1, "card")
	slot0.animCard = slot0.goCard:GetComponent(typeof(UnityEngine.Animator))
	slot0.trsCard = slot0.goCard.transform
	slot0.goSelect = gohelper.findChild(slot1, "card/select")
	slot0.goTop = gohelper.findChild(slot1, "card/top")
	slot0.trsTop = slot0.goTop.transform
	slot0.goDown = gohelper.findChild(slot1, "card/down")
	slot0.trsDown = slot0.goDown.transform
	slot0.canvasGroup = gohelper.onceAddComponent(slot0.goCard, gohelper.Type_CanvasGroup)
	slot0.goBlack = gohelper.findChild(slot1, "card/blackmask")
	slot0.goDrag = gohelper.findChild(slot1, "card/drag")

	slot0:AddDrag(slot0.goDrag)
	gohelper.setActive(slot0.frame, false)
	gohelper.setActive(slot0.goSelect, false)
end

function slot0.getCenterScreenPosY(slot0)
	slot1, slot2 = recthelper.uiPosToScreenPos2(slot0.trsCard)

	return slot2
end

function slot0.isInArea(slot0, slot1)
	slot2, slot3 = recthelper.uiPosToScreenPos2(slot0.trsTop)
	slot4, slot5 = recthelper.uiPosToScreenPos2(slot0.trsDown)

	return slot1 <= slot3 and slot5 <= slot1
end

function slot0.getLayoutGO(slot0)
	return slot0.go
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.getLayoutKey(slot0)
	return slot0._param.layoutKey
end

function slot0.setLayoutIndex(slot0, slot1)
	slot0.index = slot1
end

function slot0.exchangeIndex(slot0, slot1)
	slot1.index = slot0.index
	slot0.index = slot1.index
end

function slot0.setEditMode(slot0, slot1)
	gohelper.setActive(slot0.frame, slot1)
	gohelper.setActive(slot0.goSelect, slot1)

	if slot1 then
		slot0.animCard:Play("wiggle")
	end
end

function slot0.AddDrag(slot0, slot1)
	if slot0._drag or gohelper.isNil(slot1) then
		return
	end

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot1)

	slot0._drag:AddDragBeginListener(slot0._onBeginDrag, slot0)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
	slot0._drag:AddDragEndListener(slot0._onEndDrag, slot0)
end

function slot0.canDrag(slot0)
	return true
end

function slot0._onBeginDrag(slot0, slot1, slot2)
	if not slot0:canDrag() then
		slot0.inDrag = false

		return
	end

	if slot0.inDrag then
		return
	end

	gohelper.addChildPosStay(slot0.viewRoot, slot0.goCard)
	gohelper.setAsLastSibling(slot0.goCard)
	gohelper.setAsLastSibling(slot0.go)
	slot0:killTweenId()
	slot0:_tweenToPos(slot0.trsCard, recthelper.screenPosToAnchorPos(slot2.position, slot0.viewRoot))

	slot0.inDrag = true

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)

	if slot0.layout then
		slot0.layout:startUpdate(slot0)
	end
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0:canDrag() then
		slot0.inDrag = false

		return
	end

	if not slot0.inDrag then
		return
	end

	slot0:_tweenToPos(slot0.trsCard, recthelper.screenPosToAnchorPos(slot2.position, slot0.viewRoot))

	slot0.inDrag = true
end

function slot0._onEndDrag(slot0, slot1, slot2)
	if not slot0.inDrag then
		return
	end

	slot0.inDrag = false

	UIBlockMgr.instance:startBlock("PlayerCardLayoutItem")
	slot0:_tweenToPos(slot0.trsCard, recthelper.rectToRelativeAnchorPos(slot0.frame.transform.position, slot0.viewRoot), slot0.onEndDragTweenCallback, slot0)

	if slot0.layout then
		slot0.layout:closeUpdate()
	end
end

function slot0.onEndDragTweenCallback(slot0)
	UIBlockMgr.instance:endBlock("PlayerCardLayoutItem")
	gohelper.addChildPosStay(slot0.go, slot0.goCard)
	gohelper.setAsLastSibling(slot0.goCard)
	gohelper.setActive(slot0.goPut, false)
	gohelper.setActive(slot0.goPut, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
end

function slot0._tweenToPos(slot0, slot1, slot2, slot3, slot4)
	slot0:killTweenId()

	slot5, slot6 = recthelper.getAnchor(slot1)

	if math.abs(slot5 - slot2.x) > 10 or math.abs(slot6 - slot2.y) > 10 then
		slot0.posTweenId = ZProj.TweenHelper.DOAnchorPos(slot1, slot2.x, slot2.y, uv0.TweenDuration, slot3, slot4)
	else
		recthelper.setAnchor(slot1, slot2.x, slot2.y)

		if slot3 then
			slot3(slot4)
		end
	end
end

function slot0.killTweenId(slot0)
	if slot0.posTweenId then
		ZProj.TweenHelper.KillById(slot0.posTweenId)

		slot0.posTweenId = nil
	end
end

function slot0.updateAlpha(slot0, slot1)
	slot0.canvasGroup.alpha = slot1
end

function slot0.getHeight(slot0)
	if slot0.cardComp and slot0.cardComp.getLayoutHeight then
		return slot0.cardComp:getLayoutHeight()
	else
		return recthelper.getHeight(slot0.go.transform)
	end
end

function slot0.onStartDrag(slot0)
	slot0:updateAlpha(slot0.inDrag and 1 or 0.6)

	if slot0.inDrag then
		slot0.animCard:Play("idle")
	end

	gohelper.setActive(slot0.goBlack, not slot0.inDrag)
end

function slot0.onEndDrag(slot0)
	slot0:updateAlpha(1)
	slot0.animCard:Play("wiggle")
	gohelper.setActive(slot0.goBlack, false)
end

function slot0.onDestroy(slot0)
	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragListener()
		slot0._drag:RemoveDragEndListener()
	end

	slot0:killTweenId()
	UIBlockMgr.instance:endBlock("PlayerCardLayoutItem")
end

return slot0
