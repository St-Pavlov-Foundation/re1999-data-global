module("modules.logic.herogroup.view.HeroGroupFightLayoutView", package.seeall)

slot0 = class("HeroGroupFightLayoutView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot0.DefaultOffsetX = -130

function slot0.checkNeedSetOffset(slot0)
	return false
end

function slot0._editableInitView(slot0)
	slot0.goHeroGroupContain = gohelper.findChild(slot0.viewGO, "herogroupcontain")
	slot0.heroGroupContainRectTr = slot0.goHeroGroupContain:GetComponent(gohelper.Type_RectTransform)
	slot4 = UnityEngine.Animator
	slot0.containerAnimator = slot0.goHeroGroupContain:GetComponent(typeof(slot4))
	slot0.heroItemList = {}

	for slot4 = 1, 4 do
		slot5 = slot0:getUserDataTb_()
		slot5.bgRectTr = gohelper.findChildComponent(slot0.viewGO, "herogroupcontain/hero/bg" .. slot4, gohelper.Type_RectTransform)
		slot5.posGoTr = gohelper.findChildComponent(slot0.viewGO, "herogroupcontain/area/pos" .. slot4, gohelper.Type_RectTransform)
		slot5.bgX = recthelper.getAnchorX(slot5.bgRectTr)
		slot5.posX = recthelper.getAnchorX(slot5.posGoTr)

		table.insert(slot0.heroItemList, slot5)
	end

	slot0.replayFrameRectTr = gohelper.findChildComponent(slot0.viewGO, "#go_container/#go_replayready/#simage_replayframe", gohelper.Type_RectTransform)
	slot0.replayFrameWidth = recthelper.getWidth(slot0.replayFrameRectTr)
	slot0.replayFrameX = recthelper.getAnchorX(slot0.replayFrameRectTr)
	slot0.tipRectTr = gohelper.findChildComponent(slot0.viewGO, "#go_container/#go_replayready/tip", gohelper.Type_RectTransform)
	slot0.tipX = recthelper.getAnchorX(slot0.tipRectTr)

	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnCreateHeroItemDone, slot0.onCreateHeroItemDone, slot0)
end

function slot0.onCreateHeroItemDone(slot0)
	for slot4 = 1, 4 do
		slot0.heroItemList[slot4].heroItemRectTr = gohelper.findChildComponent(slot0.goHeroGroupContain, "hero/item" .. slot4, gohelper.Type_RectTransform)
	end

	slot0:setUIPos()
end

function slot0.setUIPos(slot0)
	if not slot0:checkNeedSetOffset() then
		return
	end

	slot0.containerAnimator.enabled = false

	for slot4 = 1, 4 do
		slot5 = slot0.heroItemList[slot4]

		recthelper.setAnchorX(slot5.bgRectTr, slot5.bgX + uv0.DefaultOffsetX)
		recthelper.setAnchorX(slot5.posGoTr, slot5.posX + uv0.DefaultOffsetX)

		if not gohelper.isNil(slot5.heroItemRectTr) then
			slot7 = recthelper.rectToRelativeAnchorPos(slot5.posGoTr.position, slot0.heroGroupContainRectTr)

			recthelper.setAnchor(slot6, slot7.x, slot7.y)
		end
	end

	recthelper.setWidth(slot0.replayFrameRectTr, 1340)
	recthelper.setAnchorX(slot0.replayFrameRectTr, -60)
	recthelper.setAnchorX(slot0.tipRectTr, -630)
end

function slot0.resetUIPos(slot0)
	for slot4 = 1, 4 do
		slot5 = slot0.heroItemList[slot4]

		recthelper.setAnchorX(slot5.bgRectTr, slot5.bgX)
		recthelper.setAnchorX(slot5.posGoTr, slot5.posX)

		if not gohelper.isNil(slot5.heroItemRectTr) then
			slot7 = recthelper.rectToRelativeAnchorPos(slot5.posGoTr.position, slot0.heroGroupContainRectTr)

			recthelper.setAnchor(slot6, slot7.x, slot7.y)
		end
	end

	recthelper.setWidth(slot0.replayFrameRectTr, slot0.replayFrameWidth)
	recthelper.setAnchorX(slot0.replayFrameRectTr, slot0.replayFrameX)
	recthelper.setAnchorX(slot0.tipRectTr, slot0.tipX)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
