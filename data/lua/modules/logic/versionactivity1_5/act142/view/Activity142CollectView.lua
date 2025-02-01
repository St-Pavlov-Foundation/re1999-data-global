module("modules.logic.versionactivity1_5.act142.view.Activity142CollectView", package.seeall)

slot0 = class("Activity142CollectView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#simage_blackbg/#btn_close")
	slot0._goScroll = gohelper.findChild(slot0.viewGO, "#simage_blackbg/#scroll_reward")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#simage_blackbg/#scroll_reward/Viewport/#go_content")
	slot0._scrollRect = gohelper.findChildScrollRect(slot0.viewGO, "#simage_blackbg/#scroll_reward")

	if not gohelper.isNil(slot0._goContent) then
		slot0._gridLayout = slot0._goContent:GetComponentInChildren(gohelper.Type_GridLayoutGroup)
	end

	slot0._gonodeitem = gohelper.findChild(slot0.viewGO, "#simage_blackbg/#scroll_reward/Viewport/#go_content/#go_nodeitem")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#simage_blackbg/bottom/cn/#txt_num")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gonodeitem, false)

	slot0.collectionItemList = {}
end

function slot0.onOpen(slot0)
	slot0:refresh()
end

function slot0.refresh(slot0)
	slot2 = Activity142Config.instance:getCollectionList(Activity142Model.instance:getActivityId())
	slot0._txtnum.text = Activity142Model.instance:getHadCollectionCount() .. "/" .. #slot2
	slot4 = nil

	for slot8, slot9 in ipairs(slot2) do
		slot0:createCollectionItem():setData(slot8, slot9, slot8 ~= slot3, slot0._goScroll)

		if Activity142Model.instance:isHasCollection(slot9) and not Activity142Controller.instance:havePlayedUnlockAni(string.format("%s_%s", Activity142Enum.COLLECTION_CACHE_KEY, slot9)) then
			slot4 = slot8
		end
	end

	ZProj.UGUIHelper.RebuildLayout(slot0._goContent.transform)

	slot5 = 0

	if slot4 and not gohelper.isNil(slot0._goContent) and not gohelper.isNil(slot0._gridLayout) then
		slot9 = recthelper.getWidth(slot0._goContent.transform) - recthelper.getWidth(slot0._goScroll.transform)
		slot5 = Mathf.Clamp((slot9 - (slot3 - slot4) * slot0._gridLayout.cellSize.x) / slot9 + Activity142Enum.COLLECTION_VIEW_OFFSET, 0, 1)
	end

	slot0._scrollRect.horizontalNormalizedPosition = slot5
end

function slot0.createCollectionItem(slot0)
	slot2 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._gonodeitem), Activity142CollectionItem)

	table.insert(slot0.collectionItemList, slot2)

	return slot2
end

function slot0.onDestroyView(slot0)
	slot0.collectionItemList = {}

	Activity142StatController.instance:statCollectionViewEnd()
end

return slot0
