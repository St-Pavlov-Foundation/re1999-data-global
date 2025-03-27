module("modules.logic.versionactivity2_4.pinball.view.PinballGameBallItem", package.seeall)

slot0 = class("PinballGameBallItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._root = gohelper.findChild(slot1, "drag_root")
	slot0._imageicon = gohelper.findChildImage(slot1, "drag_root/#image_icon")
	slot0.trans = slot0._root.transform
	slot0._click = gohelper.findChildClickWithDefaultAudio(slot0._root, "")
	slot0._outParent = slot1.transform.parent.parent
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickListener(slot0._onClickThis, slot0)
	CommonDragHelper.instance:registerDragObj(slot0._root, slot0._onBeginDrag, nil, slot0._onEndDrag, slot0._check, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
	CommonDragHelper.instance:unregisterDragObj(slot0._root)
end

function slot0._onBeginDrag(slot0)
	slot0.trans:SetParent(slot0._outParent)
	CommonDragHelper.instance:refreshParent(slot0._root)

	slot0._isDrag = true
end

function slot0._onEndDrag(slot0, slot1, slot2)
	slot0.trans:SetParent(slot0.go.transform)
	CommonDragHelper.instance:refreshParent(slot0._root)

	slot0._isDrag = false

	PinballController.instance:dispatchEvent(PinballEvent.DragMarblesEnd, slot0._index)
end

function slot0._onClickThis(slot0)
	if slot0._isDrag then
		return
	end

	if slot0._curResType == 0 then
		return
	end

	PinballController.instance:dispatchEvent(PinballEvent.ClickMarbles, slot0._index)
end

function slot0._check(slot0)
	return slot0._curResType == 0 or not slot0._canDrag or PinballHelper.isBanOper()
end

function slot0.setInfo(slot0, slot1, slot2, slot3)
	slot0._index = slot2
	slot0._curResType = slot1
	slot0._canDrag = slot3

	if slot1 > 0 then
		UISpriteSetMgr.instance:setAct178Sprite(slot0._imageicon, lua_activity178_marbles.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot1].icon, true)
		ZProj.UGUIHelper.SetColorAlpha(slot0._imageicon, slot3 and 1 or 0.5)
	end

	gohelper.setActive(slot0._root, slot1 > 0)
	ZProj.TweenHelper.KillByObj(slot0.trans)
	transformhelper.setLocalPos(slot0.trans, 0, 0, 0)
end

function slot0.getIndex(slot0)
	return slot0._index
end

function slot0.isMouseOver(slot0)
	if slot0._curResType == 0 then
		return false
	end

	if not slot0._canDrag then
		return false
	end

	return gohelper.isMouseOverGo(slot0.go)
end

function slot0.getRootPos(slot0)
	return Vector3(transformhelper.getPos(slot0.go.transform))
end

function slot0.moveBack(slot0)
	UIBlockMgr.instance:startBlock("PinballGameBallItem_moveBack")
	ZProj.TweenHelper.DOLocalMove(slot0.trans, 0, 0, 0, 0.2, slot0.onMoveBackEnd, slot0)
end

function slot0.onMoveBackEnd(slot0)
	UIBlockMgr.instance:endBlock("PinballGameBallItem_moveBack")
end

function slot0.moveTo(slot0, slot1, slot2, slot3)
	ZProj.TweenHelper.DOMove(slot0.trans, slot1.x, slot1.y, slot1.z, 0.2, slot2, slot3)
end

function slot0.onDestroy(slot0)
	ZProj.TweenHelper.KillByObj(slot0.trans)
	UIBlockMgr.instance:endBlock("PinballGameBallItem_moveBack")
end

return slot0
