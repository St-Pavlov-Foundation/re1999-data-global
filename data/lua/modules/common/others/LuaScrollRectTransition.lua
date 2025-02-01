module("modules.common.others.LuaScrollRectTransition", package.seeall)

slot0 = class("LuaScrollRectTransition", LuaCompBase)

function slot0.getByListView(slot0)
	slot2 = slot0._param
	slot3 = slot0:getCsListScroll().gameObject
	slot4 = MonoHelper.addNoUpdateLuaComOnceToGo(slot3, uv0)
	slot4.scrollRectGO = slot3
	slot4.dir = slot2.scrollDir
	slot4.lineCount = slot2.lineCount
	slot4.cellWidth = slot2.cellWidth
	slot4.cellHeight = slot2.cellHeight
	slot4.cellSpace = slot2.scrollDir == ScrollEnum.ScrollDirH and slot2.cellSpaceH or slot2.cellSpaceV
	slot4.startSpace = slot2.startSpace

	return slot4
end

function slot0.getByScrollRectGO(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0, uv0)
	slot7.scrollRectGO = slot0
	slot7.dir = slot1
	slot7.lineCount = slot2
	slot7.cellWidth = slot3
	slot7.cellHeight = slot4
	slot7.cellSpace = slot5 or 0
	slot7.startSpace = slot6 or 0

	return slot7
end

function slot0.ctor(slot0)
	slot0.transitionTime = 0.2
end

function slot0.init(slot0, slot1)
	slot0._scrollRect = slot1:GetComponent(gohelper.Type_ScrollRect)
	slot0._transform = slot0._scrollRect.transform
	slot0._contentTr = slot0._scrollRect.content
end

function slot0.onDestroy(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0.focusCellInViewPort(slot0, slot1, slot2, slot3)
	slot0:_checkInitSize()

	slot6 = slot0._contentTr.childCount - (slot3 or 0)
	slot7 = (slot0.dir == ScrollEnum.ScrollDirH and slot0.cellWidth or slot0.cellHeight) + slot0.cellSpace
	slot8 = slot1 % slot0.lineCount == 0 and Mathf.Round(slot1 / slot0.lineCount) or Mathf.Ceil(slot1 / slot0.lineCount)
	slot9 = 0
	slot10 = slot0._scrollRect.normalizedPosition
	slot11 = slot0.dir == ScrollEnum.ScrollDirH and slot10.x or slot10.y

	if SLFramework.UGUI.RectTrHelper.GetSize(slot0._transform, slot0.dir) < SLFramework.UGUI.RectTrHelper.GetSize(slot0._contentTr, slot0.dir) then
		slot13 = Mathf.Clamp01(slot0:_fixNormalize((slot8 * slot7 - slot4) / (slot5 - slot4)))

		if Mathf.Clamp01(slot0:_fixNormalize((slot8 * slot7 - slot7) / (slot5 - slot4))) <= slot11 and slot11 <= slot13 or slot13 <= slot11 and slot11 <= slot12 then
			return
		elseif math.abs(slot11 - slot12) < math.abs(slot11 - slot13) then
			slot9 = slot12
		else
			slot9 = slot13
		end
	else
		slot9 = slot0:_fixNormalize(slot9)
	end

	if slot0.dir == ScrollEnum.ScrollDirH then
		slot10.x = slot9
	else
		slot10.y = slot9
	end

	if slot2 then
		slot0._normalizedPosition = slot10
		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot11, slot9, slot0.transitionTime, slot0._frameCallback, nil, slot0)
	else
		slot0._scrollRect.normalizedPosition = slot10
	end
end

function slot0._fixNormalize(slot0, slot1)
	if slot0.dir == ScrollEnum.ScrollDirV then
		return 1 - slot1
	end

	return slot1
end

function slot0._frameCallback(slot0, slot1)
	if slot0.dir == ScrollEnum.ScrollDirH then
		slot0._normalizedPosition.x = slot1
	else
		slot0._normalizedPosition.y = slot1
	end

	slot0._scrollRect.normalizedPosition = slot0._normalizedPosition
end

function slot0._checkInitSize(slot0)
	if ((not slot0.cellWidth or slot0.cellWidth <= 0) and slot0.dir == ScrollEnum.ScrollDirH or (not slot0.cellHeight or slot0.cellHeight <= 0) and slot0.dir == ScrollEnum.ScrollDirV) and slot0._contentTr:GetChild(0) then
		slot0.cellWidth = recthelper.getWidth(slot3)
		slot0.cellHeight = recthelper.getHeight(slot3)
	end
end

return slot0
