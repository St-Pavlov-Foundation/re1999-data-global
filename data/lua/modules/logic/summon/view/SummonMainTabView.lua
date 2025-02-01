module("modules.logic.summon.view.SummonMainTabView", package.seeall)

slot0 = class("SummonMainTabView", BaseView)

function slot0.onInitView(slot0)
	slot0._goui = gohelper.findChild(slot0.viewGO, "#go_ui")
	slot0._godrag = gohelper.findChild(slot0.viewGO, "#go_ui/#go_drag")
	slot0._gocategory = gohelper.findChild(slot0.viewGO, "#go_ui/#go_category")
	slot0._scrollcategory = gohelper.findChildScrollRect(slot0.viewGO, "#go_ui/#go_category/#scroll_category")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_ui/#go_lefttop")
	slot0._gosummonmaincategoryitem = gohelper.findChild(slot0.viewGO, "#go_ui/#go_category/#scroll_category/Viewport/Content/#go_summonmaincategoryitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._tabItems = {}
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._tabItems) do
		gohelper.setActive(slot5.go, true)
		slot5.component:onDestroyView()
		gohelper.destroy(slot5.go)
	end

	slot0._tabItems = nil
end

function slot0.onOpen(slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonTabSet, slot0._handleTabSet, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.guideScrollShowEquipPool, slot0._guideScrollShowEquipPool, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, slot0.refreshUI, slot0)
	slot0:refreshUI()
	slot0:setOpenFlag()
	SummonController.instance:dispatchEvent(SummonEvent.onSummonTabSet)
end

function slot0._guideScrollShowEquipPool(slot0)
	slot0._scrollcategory.verticalNormalizedPosition = 0
end

function slot0.onClose(slot0)
	slot0:killTween()
	SummonMainModel.instance:releaseViewData()
end

function slot0.refreshUI(slot0)
	slot1 = SummonMainCategoryListModel.instance:getList()
	slot2 = {}
	slot7 = SummonEnum.ResultType.Equip
	slot8 = slot0:refreshTabGroupByType(slot1, SummonEnum.ResultType.Char, 1, slot2)
	slot3 = slot0:refreshTabGroupByType(slot1, slot7, slot8, slot2)

	ZProj.UGUIHelper.RebuildLayout(slot0._scrollcategory.content.transform)

	for slot7, slot8 in pairs(slot0._tabItems) do
		if not slot2[slot8] then
			gohelper.setActive(slot8.go, false)
			slot8.component:cleanData()
		end
	end
end

function slot0.refreshTabGroupByType(slot0, slot1, slot2, slot3, slot4)
	slot5 = 0
	slot6 = slot3

	for slot10, slot11 in ipairs(slot1) do
		if SummonMainModel.getResultType(slot11.originConf) == slot2 then
			slot12 = slot0:getOrCreateItem(slot6)

			gohelper.setActive(slot12.go, true)
			gohelper.setAsLastSibling(slot12.go)
			slot12.component:onUpdateMO(slot11)

			slot4[slot12] = true
			slot6 = slot6 + 1
		end
	end

	return slot6
end

function slot0.setOpenFlag(slot0)
	if SummonMainModel.instance:getCurId() and SummonMainModel.instance.flagModel then
		SummonMainModel.instance.flagModel:cleanFlag(slot1)
	end
end

function slot0.getOrCreateItem(slot0, slot1)
	if not slot0._tabItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._gosummonmaincategoryitem, "tabitem_" .. tostring(slot1))
		slot2.rect = slot2.go.transform
		slot2.component = MonoHelper.addNoUpdateLuaComOnceToGo(slot2.go, SummonMainCategoryItem)
		slot2.component.viewGO = slot2.go

		slot2.component:onInitView()
		slot2.component:addEvents()
		slot2.component:customAddEvent()

		slot0._tabItems[slot1] = slot2
	end

	return slot2
end

slot0.TweenTimeCategory = 0.1

function slot0._handleTabSet(slot0, slot1)
	if SummonMainModel.instance:getCurADPageIndex() then
		slot0._tabIndex = slot2

		slot0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 3, slot2)
		slot0:refreshUI()
		slot0:scrollToCurTab(slot0._tabIndex == nil, slot1)
		logNormal(string.format("set summon pool to [%s]", SummonMainModel.instance:getCurId()))
	end
end

function slot0.scrollToCurTab(slot0, slot1, slot2)
	slot4 = nil
	slot5 = 0

	for slot9, slot10 in pairs(slot0._tabItems) do
		if slot10.component:getData() and slot11.originConf.id == SummonMainModel.instance:getCurPool().id then
			slot4 = slot10
			slot5 = slot9 - 1

			break
		end
	end

	if not slot4 then
		return
	end

	slot7 = recthelper.getAnchorY(slot4.rect)

	if recthelper.getHeight(slot0._scrollcategory.content.transform) <= 0 then
		return
	end

	slot8 = slot0._scrollcategory.verticalNormalizedPosition

	if slot1 or slot2 then
		slot0._scrollcategory.verticalNormalizedPosition = 1 - slot5 / (#slot0._tabItems - 1)
	else
		slot0:killTween()

		slot0._tweenIdCategory = ZProj.TweenHelper.DOTweenFloat(slot8, slot9, uv0.TweenTimeCategory, slot0.onTweenCategory, slot0.onTweenFinishCategory, slot0)
	end
end

function slot0.onTweenCategory(slot0, slot1)
	if not gohelper.isNil(slot0._scrollcategory) then
		slot0._scrollcategory.verticalNormalizedPosition = slot1
	end
end

function slot0.onTweenFinishCategory(slot0)
	slot0:killTween()
end

function slot0.killTween(slot0)
	if slot0._tweenIdCategory then
		ZProj.TweenHelper.KillById(slot0._tweenIdCategory)

		slot0._tweenIdCategory = nil
	end
end

return slot0
