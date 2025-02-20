module("modules.logic.seasonver.act123.view2_3.Season123_2_3EquipFloatTouch", package.seeall)

slot0 = class("Season123_2_3EquipFloatTouch", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._goctrlPath = slot1
	slot0._gotouchPath = slot2
end

function slot0._editableInitView(slot0)
	slot0._goctrl = gohelper.findChild(slot0.viewGO, slot0._goctrlPath)
	slot0._gotouch = gohelper.findChild(slot0.viewGO, slot0._gotouchPath)
	slot0._tfTouch = slot0._gotouch.transform
	slot0._tfCtrl = slot0._goctrl.transform
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._gotouch)

	slot0._drag:AddDragBeginListener(slot0.onDragBegin, slot0)
	slot0._drag:AddDragListener(slot0.onDrag, slot0)
	slot0._drag:AddDragEndListener(slot0.onDragEnd, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:killTween()

	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragListener()
		slot0._drag:RemoveDragEndListener()

		slot0._drag = nil
	end
end

function slot0.onDragBegin(slot0, slot1, slot2)
end

function slot0.onDragEnd(slot0, slot1, slot2)
	slot0:killTween()

	slot0._tweenRotationId = ZProj.TweenHelper.DOLocalRotate(slot0._tfCtrl, 0, 0, 0, 0.7, nil, , , EaseType.OutCirc)
end

slot0.Range_Rotaion_Min_X = -25
slot0.Range_Rotaion_Max_X = 25
slot0.Range_Rotaion_Min_Y = -25
slot0.Range_Rotaion_Max_Y = 25

function slot0.onDrag(slot0, slot1, slot2)
	slot4 = 250
	slot5 = recthelper.screenPosToAnchorPos(slot2.position, slot0._tfTouch)

	slot0:killTween()

	slot0._tweenRotationId = ZProj.TweenHelper.DOLocalRotate(slot0._tfCtrl, Mathf.Lerp(uv0.Range_Rotaion_Min_Y, uv0.Range_Rotaion_Max_Y, Mathf.Clamp(-slot5.y / slot4, -1, 1) * 0.5 + 0.5), Mathf.Lerp(uv0.Range_Rotaion_Min_X, uv0.Range_Rotaion_Max_X, Mathf.Clamp(slot5.x / slot4, -1, 1) * 0.5 + 0.5), 0, 0.3, nil, , , EaseType.Linear)
end

function slot0.killTween(slot0)
	if slot0._tweenRotationId then
		ZProj.TweenHelper.KillById(slot0._tweenRotationId)

		slot0._tweenRotationId = nil
	end
end

return slot0
