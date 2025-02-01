module("modules.logic.seasonver.act123.view1_8.component.Season123_1_8EntryDrag", package.seeall)

slot0 = class("Season123_1_8EntryDrag", UserDataDispose)

function slot0.init(slot0, slot1, slot2)
	slot0:__onInit()

	slot0._goFullScreen = slot1
	slot0._sceneGo = slot2.gameObject
	slot0._tfScene = slot2
	slot0._tempVector = Vector3.New()
	slot0._dragDeltaPos = Vector3.New()
	slot0._tweenId = nil
	slot0._dragEnabled = true
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._goFullScreen)

	slot0._drag:AddDragBeginListener(slot0.onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0.onDragEnd, slot0)
	slot0._drag:AddDragListener(slot0.onDrag, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0.handleScreenResize, slot0)
end

function slot0.dispose(slot0)
	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragListener()
		slot0._drag:RemoveDragEndListener()
	end

	slot0:killTween()
	slot0:__onDispose()
end

function slot0.initBound(slot0)
	slot0._mapSize = gohelper.findChild(slot0._sceneGo, "root/m_s15_size"):GetComponentInChildren(typeof(UnityEngine.BoxCollider)).size
	slot3 = nil
	slot5 = ((GameUtil.getAdapterScale() == 1 or ViewMgr.instance:getUILayer(UILayerName.Hud)) and ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
	slot6 = slot5[1] * slot4
	slot7 = slot5[3] * slot4
	slot0._viewWidth = math.abs(slot7.x - slot6.x)
	slot0._viewHeight = math.abs(slot7.y - slot6.y)
	slot0._mapMinX = slot6.x - (slot0._mapSize.x - slot0._viewWidth)
	slot0._mapMaxX = slot6.x
	slot0._mapMinY = slot6.y
	slot0._mapMaxY = slot6.y + slot0._mapSize.y - slot0._viewHeight
end

function slot0.onDragBegin(slot0, slot1, slot2)
	if not slot0._dragEnabled then
		return
	end

	slot0:killTween()

	slot0._dragBeginPos = slot0:getDragWorldPos(slot2)

	if slot0._tfScene then
		slot0._beginDragPos = slot0._tfScene.localPosition
	end
end

function slot0.onDragEnd(slot0, slot1, slot2)
	slot0._dragBeginPos = nil
	slot0._beginDragPos = nil
end

function slot0.onDrag(slot0, slot1, slot2)
	if not slot0._dragBeginPos then
		return
	end

	slot0:drag(slot0:getDragWorldPos(slot2) - slot0._dragBeginPos)
end

function slot0.drag(slot0, slot1)
	if not slot0._tfScene or not slot0._beginDragPos then
		return
	end

	slot0._dragDeltaPos.x = slot1.x
	slot0._dragDeltaPos.y = slot1.y

	slot0:setScenePosDrag(slot0:vectorAdd(slot0._beginDragPos, slot0._dragDeltaPos))
end

function slot0.setScenePosDrag(slot0, slot1)
	slot1.x, slot1.y = slot0:fixTargetPos(slot1)
	slot0._targetPos = slot1

	transformhelper.setLocalPos(slot0._tfScene, slot1.x, slot1.y, 0)
end

function slot0.setScenePosTween(slot0, slot1, slot2, slot3, slot4)
	if not slot0._tfScene then
		return
	end

	slot0._targetPos = slot1

	slot0:killTween()

	slot0._tweenId = ZProj.TweenHelper.DOLocalMove(slot0._tfScene, slot1.x, slot1.y, 0, slot2 or 0.46, slot0.localMoveDone, slot0, nil, EaseType.OutQuad)
end

function slot0.fixTargetPos(slot0, slot1)
	slot2 = slot1.x
	slot3 = slot1.y

	if slot0._mapMinX and slot0._mapMaxX then
		if slot1.x < slot0._mapMinX then
			slot2 = slot0._mapMinX
		elseif slot0._mapMaxX < slot1.x then
			slot2 = slot0._mapMaxX
		end
	end

	if slot0._mapMinY and slot0._mapMaxY then
		if slot1.y < slot0._mapMinY then
			slot3 = slot0._mapMinY
		elseif slot0._mapMaxY < slot1.y then
			slot3 = slot0._mapMaxY
		end
	end

	return slot2, slot3
end

function slot0.localMoveDone(slot0)
	slot0._tweenId = nil
end

function slot0.vectorAdd(slot0, slot1, slot2)
	slot3 = slot0._tempVector
	slot3.x = slot1.x + slot2.x
	slot3.y = slot1.y + slot2.y

	return slot3
end

function slot0.getTempPos(slot0)
	return slot0._tempVector
end

function slot0.killTween(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0.setDragEnabled(slot0, slot1)
	slot0._dragEnabled = slot1
end

function slot0.getDragWorldPos(slot0, slot1)
	return SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(slot1.position, CameraMgr.instance:getMainCamera(), slot0._goFullScreen.transform.position)
end

function slot0.handleScreenResize(slot0)
	slot0:initBound()

	if slot0._dragEnabled then
		slot1 = slot0:getTempPos()
		slot1.y = SeasonEntryEnum.DefaultScenePosY
		slot1.x = SeasonEntryEnum.DefaultScenePosX

		slot0:setScenePosDrag(slot1)
	end
end

return slot0
