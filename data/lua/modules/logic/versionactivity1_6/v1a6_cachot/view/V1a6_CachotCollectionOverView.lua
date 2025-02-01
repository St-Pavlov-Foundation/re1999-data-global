module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionOverView", package.seeall)

slot0 = class("V1a6_CachotCollectionOverView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagelevelbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_levelbg")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#simage_title")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_view")
	slot0._gounlockeditem = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem")
	slot0._simageframe = gohelper.findChildSingleImage(slot0.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/#simage_frame")
	slot0._simagecollection = gohelper.findChildSingleImage(slot0.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/#simage_collection")
	slot0._gogrid1 = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/layout/#go_grid1")
	slot0._simageget = gohelper.findChildSingleImage(slot0.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/layout/#go_grid1/#simage_get")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/layout/#go_grid1/#simage_get/#simage_icon")
	slot0._gogrid2 = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/layout/#go_grid2")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/#txt_dec")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#scroll_view/Viewport/Content/#go_unlockeditem/#txt_name")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_tips")
	slot0._golayout = gohelper.findChild(slot0.viewGO, "#go_tips/#go_layout")
	slot0._txtcollectionname = gohelper.findChildText(slot0.viewGO, "#go_tips/#go_layout/top/#txt_collectionname")
	slot0._goeffectcontainer = gohelper.findChild(slot0.viewGO, "#go_tips/#go_layout/#go_effectcontainer")
	slot0._goskills = gohelper.findChild(slot0.viewGO, "#go_tips/#go_layout/#go_effectcontainer/#go_skills")
	slot0._goskilldescitem = gohelper.findChild(slot0.viewGO, "#go_tips/#go_layout/#go_effectcontainer/#go_skills/#go_skilldescitem")
	slot0._gospdescs = gohelper.findChild(slot0.viewGO, "#go_tips/#go_layout/#go_effectcontainer/#go_spdescs")
	slot0._gospdescitem = gohelper.findChild(slot0.viewGO, "#go_tips/#go_layout/#go_effectcontainer/#go_spdescs/#go_spdescitem")
	slot0._btncloseTips = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_tips/#btn_closetips")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btncloseTips:AddClickListener(slot0._btnclosetipsOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btncloseTips:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnclosetipsOnClick(slot0)
	gohelper.setActive(slot0._gotips, false)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gotips, false)
	slot0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnClickCachotOverItem, slot0.onClickCachotOverItem, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	V1a6_CachotCollectionOverListModel.instance:onInitData()
	slot0:initScrollInfo()
end

function slot0.onClickCachotOverItem(slot0, slot1)
	if V1a6_CachotCollectionConfig.instance:getCollectionConfig(V1a6_CachotCollectionOverListModel.instance:getById(slot1) and slot2.cfgId) then
		slot0._txtcollectionname.text = slot4.name

		V1a6_CachotCollectionHelper.refreshSkillDesc(slot4, slot0._goskills, slot0._goskilldescitem)
		V1a6_CachotCollectionHelper.refreshEnchantDesc(slot4, slot0._gospdescs, slot0._gospdescitem)
		slot0:setCollectionTipsPos(slot1)
	end
end

function slot0.initScrollInfo(slot0)
	slot0._luaListScrollView = slot0.viewContainer:getScrollView()
	slot0._csScrollView = slot0._luaListScrollView:getCsListScroll()
	slot0._scrollLineCount = slot0._luaListScrollView._param.lineCount
	slot0._scrollCellWidth = slot0._luaListScrollView._param.cellWidth
	slot0._scrollCellHeight = slot0._luaListScrollView._param.cellHeight
	slot0._singleItemHeightAndSpace = slot0._scrollCellHeight + slot0._luaListScrollView._param.cellSpaceV
	slot0._singleItemWidthAndSpace = slot0._scrollCellWidth + slot0._luaListScrollView._param.cellSpaceH
	slot0._scrollStartSpace = slot0._luaListScrollView._param.startSpace
	slot0._scrollHeight = recthelper.getHeight(slot0._scrollview.transform)
	slot0._scrollWidth = recthelper.getWidth(slot0._scrollview.transform)
	slot0._scrollDir = slot0._luaListScrollView._param.scrollDir
end

slot1 = 0.001

function slot0.setCollectionTipsPos(slot0, slot1)
	if V1a6_CachotCollectionOverListModel.instance:getIndex(V1a6_CachotCollectionOverListModel.instance:getById(slot1)) and slot3 > 0 then
		slot0._lineIndex = math.ceil(slot3 / slot0._scrollLineCount)
		slot0._countIndex = slot3 - (slot0._lineIndex - 1) * slot0._scrollLineCount

		if slot0:getCutOutPixelRect(slot0:getCollectionItemRectValue(slot3)).z > 0 or slot5.w > 0 then
			slot0:onMoveScroll2Focus(slot4, slot5)
		else
			slot0:onScrollContentFinishedCallBack()
		end
	end
end

function slot0.onMoveScroll2Focus(slot0, slot1, slot2)
	UIBlockMgr.instance:startBlock("V1a6_CachotCollectionOverView")
	UIBlockMgrExtend.instance.setNeedCircleMv(false)

	slot4, slot5, slot6 = slot0:getTragetScrollPixelAndDuration(slot0:getNeedMoveScrollPixel(slot1, slot2))
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot5, slot6, slot4, slot0.onScrollContentCallBack, slot0.onScrollContentFinishedCallBack, slot0, nil, EaseType.Linear)
end

function slot0.getCutOutPixelRect(slot0, slot1)
	slot2 = slot1.x
	slot6 = slot1.y - slot2
	slot7 = slot1.w - slot1.z
	slot8, slot9, slot10, slot11 = slot0:getScrollViewRect()
	slot12 = slot2 < slot8 and slot8 or slot2
	slot14 = slot4 < slot10 and slot10 or slot4
	slot17 = (slot11 < slot5 and slot11 or slot5) - slot14

	return Vector4(slot12, slot14, (slot9 < slot3 and slot9 or slot3) - slot12 > 0 and slot6 - slot16 or slot6, slot17 > 0 and slot7 - slot17 or slot7)
end

function slot0.getScrollViewRect(slot0)
	slot1 = 0
	slot2 = 0
	slot3 = 0
	slot4 = 0

	if slot0._scrollDir == ScrollEnum.ScrollDirV then
		slot4 = slot0._csScrollView.VerticalScrollPixel + slot0._scrollHeight
	else
		slot2 = slot0._csScrollView.HorizontalScrollPixel + slot0._scrollWidth
	end

	return slot1, slot2, slot3, slot4
end

function slot0.getCollectionItemRectValue(slot0)
	slot2 = (slot0._scrollDir == ScrollEnum.ScrollDirV and slot0._scrollStartSpace or 0) + (slot0._lineIndex - 1) * slot0._singleItemHeightAndSpace
	slot1 = (slot0._scrollDir == ScrollEnum.ScrollDirH and slot0._scrollStartSpace or 0) + slot0._singleItemWidthAndSpace * slot0._countIndex

	return Vector4(slot1, slot1 + slot0._singleItemWidthAndSpace, slot2, slot2 + slot0._singleItemHeightAndSpace)
end

function slot0.getNeedMoveScrollPixel(slot0, slot1, slot2)
	slot3 = 0

	return slot0._scrollDir == ScrollEnum.ScrollDirV and (slot1.z < slot2.y and -slot2.w or slot2.w) or slot1.x < slot2.x and -slot2.z or slot2.z
end

function slot0.getTragetScrollPixelAndDuration(slot0, slot1)
	slot2 = slot0._scrollDir == ScrollEnum.ScrollDirV and slot0._csScrollView.VerticalScrollPixel or slot0._csScrollView.HorizontalScrollPixel

	return math.abs(slot1) * uv0, slot2, slot2 + slot1
end

function slot0.onScrollContentCallBack(slot0, slot1)
	if slot0._scrollDir == ScrollEnum.ScrollDirV then
		slot0._csScrollView.VerticalScrollPixel = slot1
	else
		slot0._csScrollView.HorizontalScrollPixel = slot1
	end
end

function slot0.onScrollContentFinishedCallBack(slot0)
	slot0:showCollectionTips()
	UIBlockMgr.instance:endBlock("V1a6_CachotCollectionOverView")
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
end

slot0.TipPosXOffset = -1144

function slot0.showCollectionTips(slot0)
	slot1, slot2 = recthelper.getAnchor(slot0._scrollview.transform)

	gohelper.setActive(slot0._gotips, true)
	recthelper.setAnchor(slot0._golayout.transform, slot0._singleItemWidthAndSpace * slot0._countIndex + slot1 + (slot0._scrollLineCount <= slot0._countIndex and uv0.TipPosXOffset or 0), slot2 - ((slot0._lineIndex - 1) * slot0._singleItemHeightAndSpace - Mathf.Clamp(slot0._csScrollView.VerticalScrollPixel, 0, slot0._csScrollView.VerticalScrollPixel)))
	gohelper.fitScreenOffset(slot0._golayout.transform)
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock("V1a6_CachotCollectionOverView")
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
end

function slot0.onDestroyView(slot0)
end

return slot0
