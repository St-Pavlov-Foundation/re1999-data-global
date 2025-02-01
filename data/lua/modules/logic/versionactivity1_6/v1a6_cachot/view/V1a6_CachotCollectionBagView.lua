module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionBagView", package.seeall)

slot0 = class("V1a6_CachotCollectionBagView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagelevelbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_levelbg")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#simage_title")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#simage_title/#txt_title")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "left/#scroll_view")
	slot0._gocollectionbagitem = gohelper.findChild(slot0.viewGO, "left/#scroll_view/Viewport/Content/#go_collectionbagitem")
	slot0._btntotalpreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#btn_totalpreview")
	slot0._goright = gohelper.findChild(slot0.viewGO, "#go_right")
	slot0._simagecollection = gohelper.findChildSingleImage(slot0.viewGO, "#go_right/#simage_collection")
	slot0._gogrid1 = gohelper.findChild(slot0.viewGO, "#go_right/grids/#go_grid1")
	slot0._gonone1 = gohelper.findChild(slot0.viewGO, "#go_right/grids/#go_grid1/#go_none1")
	slot0._goget1 = gohelper.findChild(slot0.viewGO, "#go_right/grids/#go_grid1/#go_get1")
	slot0._simageicon1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_right/grids/#go_grid1/#go_get1/#simage_icon1")
	slot0._gogrid2 = gohelper.findChild(slot0.viewGO, "#go_right/grids/#go_grid2")
	slot0._gonone2 = gohelper.findChild(slot0.viewGO, "#go_right/grids/#go_grid2/#go_none2")
	slot0._goget2 = gohelper.findChild(slot0.viewGO, "#go_right/grids/#go_grid2/#go_get2")
	slot0._simageicon2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_right/grids/#go_grid2/#go_get2/#simage_icon2")
	slot0._gounique = gohelper.findChild(slot0.viewGO, "#go_right/#go_container/#go_unique")
	slot0._txtuniquetips = gohelper.findChildText(slot0.viewGO, "#go_right/#go_container/#go_unique/#txt_uniquetips")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_right/#txt_name")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_right/#go_container")
	slot0._scrolleffectcontainer = gohelper.findChildScrollRect(slot0.viewGO, "#go_right/#go_container/#scroll_effectcontainer")
	slot0._goskills = gohelper.findChild(slot0.viewGO, "#go_right/#go_container/#scroll_effectcontainer/Viewport/Content/#go_skills")
	slot0._goskillitem = gohelper.findChild(slot0.viewGO, "#go_right/#go_container/#scroll_effectcontainer/Viewport/Content/#go_skills/#go_skillitem")
	slot0._gospdescs = gohelper.findChild(slot0.viewGO, "#go_right/#go_container/#scroll_effectcontainer/Viewport/Content/#go_spdescs")
	slot0._gospdescitem = gohelper.findChild(slot0.viewGO, "#go_right/#go_container/#scroll_effectcontainer/Viewport/Content/#go_spdescs/#go_spdescitem")
	slot0._goadd = gohelper.findChild(slot0.viewGO, "#go_right/#go_add")
	slot0._btnadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_right/#go_add/#btn_add")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_empty")
	slot0._goline = gohelper.findChild(slot0.viewGO, "left/#scroll_view/Viewport/Content/#go_line")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntotalpreview:AddClickListener(slot0._btntotalpreviewOnClick, slot0)
	slot0._btnadd:AddClickListener(slot0._btnaddOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(V1a6_CachotCollectionBagController.instance, V1a6_CachotEvent.OnSelectBagCollection, slot0.onSelectBagItem, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntotalpreview:RemoveClickListener()
	slot0._btnadd:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0:removeEventCb(V1a6_CachotCollectionBagController.instance, V1a6_CachotEvent.OnSelectBagCollection, slot0.onSelectBagItem, slot0)
end

function slot0._btntotalpreviewOnClick(slot0)
	V1a6_CachotController.instance:openV1a6_CachotCollectionOverView()
end

function slot0._btnaddOnClick(slot0)
	V1a6_CachotController.instance:openV1a6_CachotCollectionEnchantView({
		collectionId = slot0._curSelectCollectionId
	})
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._goEffectScrollContent = gohelper.findChild(slot0.viewGO, "#go_right/#go_container/#scroll_effectcontainer/Viewport/Content")
	slot0._imageCollectionIcon = gohelper.findChildImage(slot0.viewGO, "#go_right/#simage_collection")
	slot0._anim = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.Animator))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam and slot0.viewParam.isCanEnchant
	slot0._isCanEnchant = slot1 == nil and true or slot1

	slot0:initScrollInfo()
	V1a6_CachotCollectionBagController.instance:onOpenView()
	slot0:refreshCollectionSplitLine()

	if V1a6_CachotCollectionBagController.instance.guideMoveCollection then
		V1a6_CachotCollectionBagController.instance.guideMoveCollection = nil

		V1a6_CachotCollectionBagController.instance:moveCollectionWithHole2TopAndSelect()
	end
end

slot1 = 0.2

function slot0.onSelectBagItem(slot0, slot1)
	slot1 = slot1 or slot0._curSelectCollectionId
	slot2 = false

	if slot0._curSelectCollectionId and slot1 then
		slot0._anim:Play("switch", 0, 0)

		slot2 = true
	end

	slot0:refreshCollectionSplitLine()

	slot5 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(V1a6_CachotCollectionBagListModel.instance:getById(slot1) and slot3.cfgId)

	gohelper.setActive(slot0._goempty, slot3 == nil)
	gohelper.setActive(slot0._goright, slot3 ~= nil)
	gohelper.setActive(slot0._btntotalpreview.gameObject, slot3 ~= nil)

	if slot3 and slot5 then
		slot0:scrollFocusOnSelectCell(V1a6_CachotCollectionBagListModel.instance:getIndex(slot3))

		slot0._curSelectCollectionId = slot3.id
		slot0._txtname.text = tostring(slot5.name)
		slot0._collectionIconUrl = ResUrl.getV1a6CachotIcon("collection/" .. slot5.icon)

		slot0:_setCollectionIconVisible()
		TaskDispatcher.cancelTask(slot0._switchCollectionIcon, slot0)
		TaskDispatcher.runDelay(slot0._switchCollectionIcon, slot0, slot2 and uv0 or 0)

		slot7 = slot5.type ~= V1a6_CachotEnum.CollectionType.Enchant and slot5.holeNum > 0 and slot0._isCanEnchant

		gohelper.setActive(slot0._goadd, slot7)
		slot0:updateCollectionDescScrollSize(slot7)
		slot0:refreshHoleUI(slot3, slot5)
		V1a6_CachotCollectionHelper.refreshCollectionUniqueTip(slot5, slot0._txtuniquetips, slot0._gounique)
		V1a6_CachotCollectionHelper.refreshSkillDesc(slot5, slot0._goskills, slot0._goskillitem)
		V1a6_CachotCollectionHelper.refreshEnchantDesc(slot5, slot0._gospdescs, slot0._gospdescitem)
	end
end

slot2 = 219
slot3 = 338

function slot0.updateCollectionDescScrollSize(slot0, slot1)
	recthelper.setHeight(slot0._scrolleffectcontainer.transform, slot1 and uv0 or uv1)
end

function slot0._setCollectionIconVisible(slot0)
	slot0._imageCollectionIcon.enabled = not string.nilorempty(slot0._simagecollection.curImageUrl)
end

function slot0._switchCollectionIcon(slot0)
	slot0._simagecollection:LoadImage(slot0._collectionIconUrl)
end

function slot0.refreshHoleUI(slot0, slot1, slot2)
	if slot2 and slot1 then
		slot3 = slot2.holeNum or 0

		gohelper.setActive(slot0._gogrid1, slot3 >= 1)
		gohelper.setActive(slot0._gogrid2, slot3 >= 2)
		slot0:refreshSingleHole(V1a6_CachotEnum.CollectionHole.Left, slot1:getEnchantId(V1a6_CachotEnum.CollectionHole.Left))
		slot0:refreshSingleHole(V1a6_CachotEnum.CollectionHole.Right, slot1:getEnchantId(V1a6_CachotEnum.CollectionHole.Right))
	end
end

function slot0.refreshSingleHole(slot0, slot1, slot2)
	slot3 = slot2 and slot2 ~= 0

	gohelper.setActive(slot0["_gonone" .. slot1], not slot3)
	gohelper.setActive(slot0["_goget" .. slot1], slot3)

	slot4 = V1a6_CachotModel.instance:getRogueInfo()

	if slot3 and slot4 and V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot4:getCollectionByUid(slot2) and slot5.cfgId) and slot0["_simageicon" .. slot1] then
		slot0["_simageicon" .. slot1]:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. slot7.icon))
	end
end

function slot0.scrollFocusOnSelectCell(slot0, slot1)
	if slot0._scrollHeight < (math.ceil(slot1 / slot0._scrollLineCount) - 1) * slot0._singleItemHeightAndSpace + slot0._scrollStartSpace - slot0._csScrollView.VerticalScrollPixel or slot5 < 0 then
		slot0._csScrollView.VerticalScrollPixel = slot3
	end
end

function slot0.initScrollInfo(slot0)
	slot0._luaListScrollView = slot0.viewContainer:getScrollView()
	slot0._csScrollView = slot0._luaListScrollView:getCsListScroll()
	slot0._scrollLineCount = slot0._luaListScrollView._param.lineCount
	slot0._singleItemHeightAndSpace = slot0._luaListScrollView._param.cellHeight + slot0._luaListScrollView._param.cellSpaceV
	slot0._scrollStartSpace = slot0._luaListScrollView._param.startSpace
	slot0._scrollHeight = recthelper.getHeight(slot0._scrollview.transform)
end

function slot0.releaseSingleImage(slot0)
	if V1a6_CachotEnum.CollectionHole then
		for slot4, slot5 in pairs(V1a6_CachotEnum.CollectionHole) do
			if slot0["_simageicon" .. slot5] then
				slot6:UnLoadImage()
			end
		end
	end

	slot0._simagecollection:UnLoadImage()
end

slot4 = 48

function slot0.refreshCollectionSplitLine(slot0)
	slot3 = V1a6_CachotCollectionBagListModel.instance:getUnEnchantCollectionLineNum() > 0 and V1a6_CachotCollectionBagListModel.instance:getEnchantCollectionNum() > 0

	gohelper.setActive(slot0._goline, slot3)

	if slot3 then
		recthelper.setAnchorY(slot0._goline.transform, -(((slot0.viewContainer:getScrollParam() and slot4.cellHeight or 0) + (slot4 and slot4.cellSpaceV or 0)) * slot1 + (slot4 and slot4.startSpace or 0)) + uv0)
	end
end

function slot0.onClose(slot0)
	V1a6_CachotCollectionBagController.instance:onCloseView()
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._switchCollectionIcon, slot0)
	slot0:releaseSingleImage()
end

return slot0
