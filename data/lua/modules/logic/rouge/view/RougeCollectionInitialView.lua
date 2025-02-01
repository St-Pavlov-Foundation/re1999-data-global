module("modules.logic.rouge.view.RougeCollectionInitialView", package.seeall)

slot0 = class("RougeCollectionInitialView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagemaskbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_maskbg")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "scroll_view/Viewport/#go_content")
	slot0._gocollectionitem = gohelper.findChild(slot0.viewGO, "scroll_view/Viewport/#go_content/#go_collectionitem")
	slot0._btnemptyBlock = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyBlock")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnemptyBlock:AddClickListener(slot0._btnemptyBlockOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnemptyBlock:RemoveClickListener()
end

function slot0._btnemptyBlockOnClick(slot0)
	slot0:setActiveBlock(false)
end

function slot0._editableInitView(slot0)
	slot0._btnemptyBlockGo = slot0._btnemptyBlock.gameObject
	slot0._collectionObjList = {}
	slot0._scrollView = gohelper.findChildScrollRect(slot0.viewGO, "scroll_view")
	slot0._scrollViewGo = slot0._scrollView.gameObject

	slot0._simagemaskbg:LoadImage("singlebg/rouge/rouge_talent_bg.png")
	gohelper.setActive(slot0._gocollectionitem, false)
	slot0:setActiveBlock(false)
end

function slot0.setActiveBlock(slot0, slot1)
	if slot0._isBlocked == slot1 then
		return
	end

	slot0._isBlocked = slot1

	gohelper.setActive(slot0._btnemptyBlockGo, slot1)

	if not slot1 then
		for slot5, slot6 in ipairs(slot0._collectionObjList) do
			slot6:onCloseBlock()
		end
	end
end

function slot0.getScrollViewGo(slot0)
	return slot0._scrollViewGo
end

function slot0.onUpdateParam(slot0)
	slot0:_refresh()
end

function slot0.onOpen(slot0)
	slot0._isBlocked = nil

	slot0:onUpdateParam()

	slot0._scrollView.horizontalNormalizedPosition = 0
end

function slot0.onOpenFinish(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_open_20190323)
end

function slot0._refresh(slot0)
	slot0:_refreshList()
end

function slot0._refreshList(slot0)
	for slot5, slot6 in ipairs(slot0:_collectionCfgIdList()) do
		slot7 = nil

		if slot5 > #slot0._collectionObjList then
			table.insert(slot0._collectionObjList, slot0:_create_RougeCollectionInitialCollectionItem(slot5))
		else
			slot7 = slot0._collectionObjList[slot5]
		end

		slot7:onUpdateMO(slot6)
		slot7:setActive(true)
	end

	for slot5 = #slot1 + 1, #slot0._collectionObjList do
		slot0._collectionObjList[slot5]:setActive(false)
	end
end

function slot0._collectionCfgIdList(slot0)
	return slot0.viewParam and slot0.viewParam.collectionCfgIds or {}
end

function slot0.onClose(slot0)
	GameUtil.onDestroyViewMember_SImage(slot0, "_simagemaskbg")
	GameUtil.onDestroyViewMemberList(slot0, "_collectionObjList")
end

function slot0.onDestroyView(slot0)
end

function slot0._create_RougeCollectionInitialCollectionItem(slot0, slot1)
	slot3 = RougeCollectionInitialCollectionItem.New({
		parent = slot0,
		baseViewContainer = slot0.viewContainer
	})

	slot3:setIndex(slot1)
	slot3:init(gohelper.cloneInPlace(slot0._gocollectionitem))

	return slot3
end

return slot0
