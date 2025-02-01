module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionEnchantView", package.seeall)

slot0 = class("V1a6_CachotCollectionEnchantView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagelevelbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_levelbg")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#simage_title")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#simage_title/#txt_title")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "left/#scroll_view")
	slot0._gocollectionbagitem = gohelper.findChild(slot0.viewGO, "left/#scroll_view/Viewport/Content/#go_collectionbagitem")
	slot0._dropcollectionclassify = gohelper.findChildDropdown(slot0.viewGO, "left/#drop_collectionclassify")
	slot0._gomiddle = gohelper.findChild(slot0.viewGO, "#go_middle")
	slot0._simagecollection = gohelper.findChildSingleImage(slot0.viewGO, "#go_middle/#simage_collection")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_middle/#txt_name")
	slot0._gogrid1 = gohelper.findChild(slot0.viewGO, "#go_middle/grids/#go_grid1")
	slot0._gogridselect1 = gohelper.findChild(slot0.viewGO, "#go_middle/grids/#go_grid1/#go_gridselect1")
	slot0._gogridadd1 = gohelper.findChild(slot0.viewGO, "#go_middle/grids/#go_grid1/#go_gridadd1")
	slot0._gogridget1 = gohelper.findChild(slot0.viewGO, "#go_middle/grids/#go_grid1/#go_gridget1")
	slot0._simageicon1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_middle/grids/#go_grid1/#go_gridget1/#simage_icon1")
	slot0._btngridclick1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_middle/grids/#go_grid1/#btn_gridclick1")
	slot0._gogrid2 = gohelper.findChild(slot0.viewGO, "#go_middle/grids/#go_grid2")
	slot0._gogridselect2 = gohelper.findChild(slot0.viewGO, "#go_middle/grids/#go_grid2/#go_gridselect2")
	slot0._gogridadd2 = gohelper.findChild(slot0.viewGO, "#go_middle/grids/#go_grid2/#go_gridadd2")
	slot0._gogridget2 = gohelper.findChild(slot0.viewGO, "#go_middle/grids/#go_grid2/#go_gridget2")
	slot0._simageicon2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_middle/grids/#go_grid2/#go_gridget2/#simage_icon2")
	slot0._btngridclick2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_middle/grids/#go_grid2/#btn_gridclick2")
	slot0._gounique = gohelper.findChild(slot0.viewGO, "#go_middle/#go_unique")
	slot0._txtuniquetips = gohelper.findChildText(slot0.viewGO, "#go_middle/#go_unique/#txt_uniquetips")
	slot0._gocollectionenchantitem = gohelper.findChild(slot0.viewGO, "right/#scroll_view/Viewport/Content/#go_collectionenchantitem")
	slot0._simageframe = gohelper.findChildSingleImage(slot0.viewGO, "right/#scroll_view/Viewport/Content/#go_collectionenchantitem/#simage_frame")
	slot0._goenchant = gohelper.findChild(slot0.viewGO, "right/#scroll_view/Viewport/Content/#go_collectionenchantitem/#go_enchant")
	slot0._txtdes = gohelper.findChildText(slot0.viewGO, "right/#scroll_view/Viewport/Content/#go_collectionenchantitem/#txt_des")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._goencahntempty = gohelper.findChild(slot0.viewGO, "right/#go_enchantempty")
	slot0._scrolleffectcontainer = gohelper.findChildScrollRect(slot0.viewGO, "#go_middle/#scroll_effectcontainer")
	slot0._goskills = gohelper.findChild(slot0.viewGO, "#go_middle/#scroll_effectcontainer/Viewport/Content/#go_skills")
	slot0._goskillitem = gohelper.findChild(slot0.viewGO, "#go_middle/#scroll_effectcontainer/Viewport/Content/#go_skills/#go_skillitem")
	slot0._gospdescs = gohelper.findChild(slot0.viewGO, "#go_middle/#scroll_effectcontainer/Viewport/Content/#go_spdescs")
	slot0._gospdescitem = gohelper.findChild(slot0.viewGO, "#go_middle/#scroll_effectcontainer/Viewport/Content/#go_spdescs/#go_spdescitem")
	slot0._gocollectionempty = gohelper.findChild(slot0.viewGO, "left/#go_collectionempty")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btngridclick1:AddClickListener(slot0._btngridclick1OnClick, slot0)
	slot0._btngridclick2:AddClickListener(slot0._btngridclick2OnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._dropcollectionclassify:AddOnValueChanged(slot0._onSwitchCategory, slot0)
	slot0:addEventCb(V1a6_CachotCollectionEnchantController.instance, V1a6_CachotEvent.OnSelectEnchantCollection, slot0.onSelectBagItem, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btngridclick1:RemoveClickListener()
	slot0._btngridclick2:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._dropcollectionclassify:RemoveOnValueChanged()
	slot0:removeEventCb(V1a6_CachotCollectionEnchantController.instance, V1a6_CachotEvent.OnSelectEnchantCollection, slot0.onSelectBagItem, slot0)
end

function slot0._btngridclick1OnClick(slot0)
	slot0:refreshAllHoleSelectState(V1a6_CachotEnum.CollectionHole.Left)
	V1a6_CachotCollectionEnchantController.instance:onSelectHoleGrid(V1a6_CachotEnum.CollectionHole.Left, slot0:checkIsCouldRemoveEnchant(V1a6_CachotEnum.CollectionHole.Left))
end

function slot0._btngridclick2OnClick(slot0)
	slot0:refreshAllHoleSelectState(V1a6_CachotEnum.CollectionHole.Right)
	V1a6_CachotCollectionEnchantController.instance:onSelectHoleGrid(V1a6_CachotEnum.CollectionHole.Right, slot0:checkIsCouldRemoveEnchant(V1a6_CachotEnum.CollectionHole.Right))
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._categoryList = {
		uv0.AllFilterType,
		V1a6_CachotEnum.CollectionType.Weapon,
		V1a6_CachotEnum.CollectionType.Protect,
		V1a6_CachotEnum.CollectionType.Decorate
	}
	slot0._anim = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.Animator))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshUI(slot0.viewParam and slot0.viewParam.collectionId)
end

function slot0.refreshUI(slot0, slot1)
	V1a6_CachotCollectionEnchantController.instance:onOpenView(slot1)
	slot0:initCategory()
	slot0:initEnchantsListUI()
	slot0:initCollectionsListUI()
end

slot1 = 0.2

function slot0.onSelectBagItem(slot0, slot1)
	if V1a6_CachotEnchantBagListModel.instance:getById(slot1) then
		if V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot2.cfgId) then
			slot0._txtname.text = tostring(slot3.name)
			slot0._collectionIconUrl = ResUrl.getV1a6CachotIcon("collection/" .. slot3.icon)

			gohelper.setActive(slot0._goadd, slot3.holeNum > 0)
			slot0:refreshHoleUI(slot2, slot3)
			slot0:refreshCollectionDesc(slot2, slot3)
			V1a6_CachotCollectionHelper.refreshCollectionUniqueTip(slot3, slot0._txtuniquetips, slot0._gounique)

			slot4 = false

			if slot0._curSelectCollectionId and slot0._curSelectCollectionId ~= slot1 then
				slot0._anim:Play("swicth", 0, 0)

				slot4 = true
			end

			TaskDispatcher.cancelTask(slot0._switchCollectionIcon, slot0)
			TaskDispatcher.runDelay(slot0._switchCollectionIcon, slot0, slot4 and uv0 or 0)

			slot0._curSelectCollectionId = slot1
		end
	else
		slot0._curSelectCollectionId = nil
	end

	gohelper.setActive(slot0._gomiddle, slot2 ~= nil)
	slot0:resetHoleClickCount()
end

function slot0._switchCollectionIcon(slot0)
	slot0._simagecollection:LoadImage(slot0._collectionIconUrl)
end

function slot0.refreshHoleUI(slot0, slot1, slot2)
	if slot1 and slot2 then
		slot3 = slot2.holeNum or 0

		gohelper.setActive(slot0._gogrid1, slot3 >= 1)
		gohelper.setActive(slot0._gogrid2, slot3 >= 2)
		slot0:refreshSingleHoleUI(V1a6_CachotEnum.CollectionHole.Left, slot1:getEnchantId(V1a6_CachotEnum.CollectionHole.Left))
		slot0:refreshSingleHoleUI(V1a6_CachotEnum.CollectionHole.Right, slot1:getEnchantId(V1a6_CachotEnum.CollectionHole.Right))
	end
end

function slot0.refreshSingleHoleUI(slot0, slot1, slot2)
	slot4 = slot2 and slot2 ~= 0

	gohelper.setActive(slot0["_gogridadd" .. slot1], not slot4)
	gohelper.setActive(slot0["_gogridget" .. slot1], slot4)
	gohelper.setActive(slot0["_gogridselect" .. slot1], V1a6_CachotEnchantBagListModel.instance:getCurSelectHoleIndex() == slot1)

	if slot4 then
		slot6 = V1a6_CachotModel.instance:getRogueInfo() and slot5:getCollectionByUid(slot2)

		if V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot6 and slot6.cfgId) and slot0["_simageicon" .. slot1] then
			slot0["_simageicon" .. slot1]:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. slot8.icon))
		end
	end
end

function slot0.refreshAllHoleSelectState(slot0, slot1)
	for slot5, slot6 in pairs(V1a6_CachotEnum.CollectionHole) do
		gohelper.setActive(slot0["_gogridselect" .. slot6], slot1 == slot6)
	end
end

function slot0.refreshCollectionDesc(slot0, slot1, slot2)
	if slot2 then
		V1a6_CachotCollectionHelper.refreshSkillDesc(slot2, slot0._goskills, slot0._goskillitem)
		V1a6_CachotCollectionHelper.refreshEnchantDesc(slot2, slot0._gospdescs, slot0._gospdescitem)
	end

	slot0._scrolleffectcontainer.verticalNormalizedPosition = 1
end

slot0.AllFilterType = 6

function slot0.initCategory(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0._categoryList) do
		slot7 = nil

		table.insert(slot1, (slot6 ~= uv0.AllFilterType or luaLang("cachot_CollectionTypeName_All")) and luaLang(V1a6_CachotEnum.CollectionTypeName[slot6]))
	end

	slot0._dropcollectionclassify:AddOptions(slot1)
end

function slot0.initEnchantsListUI(slot0)
	gohelper.setActive(slot0._goencahntempty, V1a6_CachotCollectionEnchantListModel.instance:isEnchantEmpty())
end

function slot0.initCollectionsListUI(slot0)
	slot1 = V1a6_CachotEnchantBagListModel.instance:isBagEmpty()

	gohelper.setActive(slot0._gocollectionempty, slot1)
	gohelper.setActive(slot0._gomiddle, not slot1)
end

function slot0._onSwitchCategory(slot0, slot1)
	if slot0._categoryList[slot1 + 1] then
		slot0._scrollview.verticalNormalizedPosition = 1

		V1a6_CachotCollectionEnchantController.instance:switchCategory(slot2)
		slot0:initCollectionsListUI()
	end
end

slot0.RemoveEnchantMinClickCount = 2

function slot0.checkIsCouldRemoveEnchant(slot0, slot1)
	if slot1 ~= slot0._checkHoleIndex then
		slot0:resetHoleClickCount()
	end

	slot0._checkHoleIndex = slot1
	slot0._holeClickCount = slot0._holeClickCount + 1

	if uv0.RemoveEnchantMinClickCount <= slot0._holeClickCount then
		slot0:checkHoleClickToast(slot1)
		slot0:resetHoleClickCount()

		return true
	end
end

function slot0.resetHoleClickCount(slot0)
	slot0._holeClickCount = 0
end

slot2 = 2

function slot0.checkHoleClickToast(slot0, slot1)
	if V1a6_CachotCollectionEnchantListModel.instance:isEnchantEmpty() then
		ToastController.instance:showToast(ToastEnum.V1a6Cachot_EnchantListEmpty)
	else
		slot4 = V1a6_CachotEnchantBagListModel.instance:getById(slot0._curSelectCollectionId) and slot3:getEnchantId(slot1)

		if slot3 and not (slot4 and slot4 ~= V1a6_CachotEnum.EmptyEnchantId) and slot0._holeClickCount and uv0 <= slot0._holeClickCount then
			ToastController.instance:showToast(ToastEnum.V1a6Cachot_SelectCollectionEnchant)
		end
	end
end

function slot0.releaseSingleImage(slot0)
	if V1a6_CachotEnum.CollectionHole then
		for slot4, slot5 in pairs(V1a6_CachotEnum.CollectionHole) do
			if slot0["_simageicon" .. slot5] then
				slot6:UnLoadImage()
			end
		end
	end
end

function slot0.onClose(slot0)
	V1a6_CachotCollectionEnchantController.instance:onCloseView()
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._switchCollectionIcon, slot0)
	slot0:releaseSingleImage()
end

return slot0
