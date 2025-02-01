module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionView", package.seeall)

slot0 = class("V1a6_CachotCollectionView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagelevelbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_levelbg")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "left/#simage_title")
	slot0._simagetitleicon = gohelper.findChildSingleImage(slot0.viewGO, "left/#simage_titleicon")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "left/#scroll_view")
	slot0._gocollectionitem = gohelper.findChild(slot0.viewGO, "left/#scroll_view/Viewport/Content/#go_collectionitem")
	slot0._gocollectionsort = gohelper.findChild(slot0.viewGO, "left/#go_collectionsort")
	slot0._btnall = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#go_collectionsort/#btn_all")
	slot0._btnhasget = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#go_collectionsort/#btn_hasget")
	slot0._btnunget = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#go_collectionsort/#btn_unget")
	slot0._simagecollection = gohelper.findChildSingleImage(slot0.viewGO, "right/#go_collectioninfo/#simage_collection")
	slot0._golock = gohelper.findChild(slot0.viewGO, "right/#go_collectioninfo/#go_lock")
	slot0._gounget = gohelper.findChild(slot0.viewGO, "right/#go_collectioninfo/#go_unget")
	slot0._gohasget = gohelper.findChild(slot0.viewGO, "right/#go_collectioninfo/#go_hasget")
	slot0._gogrid1 = gohelper.findChild(slot0.viewGO, "right/#go_collectioninfo/#go_hasget/layout/#go_grid1")
	slot0._simageget1 = gohelper.findChildSingleImage(slot0.viewGO, "right/#go_collectioninfo/#go_hasget/layout/#go_grid1/#simage_get1")
	slot0._simageicon1 = gohelper.findChildSingleImage(slot0.viewGO, "right/#go_collectioninfo/#go_hasget/layout/#go_grid1/#simage_get1/#simage_icon1")
	slot0._gogrid2 = gohelper.findChild(slot0.viewGO, "right/#go_collectioninfo/#go_hasget/layout/#go_grid2")
	slot0._simageget2 = gohelper.findChildSingleImage(slot0.viewGO, "right/#go_collectioninfo/#go_hasget/layout/#go_grid2/#simage_get2")
	slot0._simageicon2 = gohelper.findChildSingleImage(slot0.viewGO, "right/#go_collectioninfo/#go_hasget/layout/#go_grid2/#simage_get2/#simage_icon2")
	slot0._gounique = gohelper.findChild(slot0.viewGO, "right/#go_collectioninfo/#go_hasget/#go_unique")
	slot0._txtuniquetips = gohelper.findChildText(slot0.viewGO, "right/#go_collectioninfo/#go_hasget/#go_unique/#txt_uniquetips")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "right/#go_collectioninfo/#go_hasget/#scroll_effectcontainer/Viewport/Content/descontainer/#txt_desc")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "right/#go_collectioninfo/#txt_name")
	slot0._scrolleffectcontainer = gohelper.findChildScrollRect(slot0.viewGO, "right/#go_collectioninfo/#go_hasget/#scroll_effectcontainer")
	slot0._goskillcontainer = gohelper.findChild(slot0.viewGO, "right/#go_collectioninfo/#go_hasget/#scroll_effectcontainer/Viewport/Content/#go_skillcontainer")
	slot0._godescitem = gohelper.findChild(slot0.viewGO, "right/#go_collectioninfo/#go_hasget/#scroll_effectcontainer/Viewport/Content/#go_skillcontainer/#go_descitem")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._txtunlocktask = gohelper.findChildText(slot0.viewGO, "right/#go_collectioninfo/#go_lock/#txt_unlocktask")
	slot0._gocollectioninfo = gohelper.findChild(slot0.viewGO, "right/#go_collectioninfo")
	slot0._goscrollempty = gohelper.findChild(slot0.viewGO, "left/#go_scrollempty")
	slot0._gocollectionempty = gohelper.findChild(slot0.viewGO, "right/#go_collectionempty")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnall:AddClickListener(slot0._btnallOnClick, slot0)
	slot0._btnhasget:AddClickListener(slot0._btnhasgetOnClick, slot0)
	slot0._btnunget:AddClickListener(slot0._btnungetOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnall:RemoveClickListener()
	slot0._btnhasget:RemoveClickListener()
	slot0._btnunget:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btnallOnClick(slot0)
	V1a6_CachotCollectionController.instance:onSwitchCategory(V1a6_CachotEnum.CollectionCategoryType.All)
end

function slot0._btnhasgetOnClick(slot0)
	V1a6_CachotCollectionController.instance:onSwitchCategory(V1a6_CachotEnum.CollectionCategoryType.HasGet)
end

function slot0._btnungetOnClick(slot0)
	V1a6_CachotCollectionController.instance:onSwitchCategory(V1a6_CachotEnum.CollectionCategoryType.UnGet)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(V1a6_CachotCollectionController.instance, V1a6_CachotEvent.OnSelectCollectionItem, slot0.refreshCollectionInfo, slot0)
	slot0:addEventCb(V1a6_CachotCollectionController.instance, V1a6_CachotEvent.OnSwitchCategory, slot0.switchCategory, slot0)

	slot0._imagecollectionicon = gohelper.findChildImage(slot0.viewGO, "right/#go_collectioninfo/#simage_collection")
end

function slot0.onUpdateParam(slot0)
end

slot1 = 4

function slot0.onOpen(slot0)
	V1a6_CachotCollectionController.instance:onOpenView(V1a6_CachotEnum.CollectionCategoryType.All, uv0)
end

slot0.IconUnLockColor = "#FFFFFF"
slot0.IconLockColor = "#060606"
slot0.IconUnLockAlpha = 1
slot0.IconLockAlpha = 0.7

function slot0.refreshCollectionInfo(slot0)
	gohelper.setActive(slot0._gocollectioninfo, V1a6_CachotCollectionListModel.instance:getCurSelectCollectionId() ~= nil)
	gohelper.setActive(slot0._gocollectionempty, slot1 == nil)
	gohelper.setActive(slot0._goscrollempty, slot1 == nil)

	if slot1 then
		gohelper.setActive(slot0._gohasget, V1a6_CachotCollectionListModel.instance:getCollectionState(slot1) == V1a6_CachotEnum.CollectionState.HasGet or slot2 == V1a6_CachotEnum.CollectionState.New)
		gohelper.setActive(slot0._golock, slot2 == V1a6_CachotEnum.CollectionState.Locked)
		gohelper.setActive(slot0._gounget, slot2 == V1a6_CachotEnum.CollectionState.UnLocked)
		gohelper.setActive(slot0._txtname, slot2 ~= V1a6_CachotEnum.CollectionState.Locked)

		if V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot1) and slot2 then
			slot4 = uv0.IconUnLockColor
			slot5 = uv0.IconUnLockAlpha

			if slot2 == V1a6_CachotEnum.CollectionState.Locked then
				slot0:onCollectionLockedState(slot3)

				slot4 = uv0.IconLockColor
				slot5 = uv0.IconLockAlpha
			elseif slot2 == V1a6_CachotEnum.CollectionState.UnLocked then
				slot0:onCollectionUnLockedState(slot3)
			else
				slot0:onCollectionHasGetState(slot3)
			end

			slot0._simagecollection:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. slot3.icon))
			SLFramework.UGUI.GuiHelper.SetColor(slot0._imagecollectionicon, slot4)
			ZProj.UGUIHelper.SetColorAlpha(slot0._imagecollectionicon, slot5)
		end
	end
end

function slot0.onCollectionLockedState(slot0, slot1)
	slot0._txtunlocktask.text = lua_rogue_collecion_unlock_task.configDict[slot1.unlockTask] and slot3.desc or ""
end

function slot0.onCollectionUnLockedState(slot0, slot1)
	slot0._txtname.text = tostring(slot1.name)
end

function slot0.onCollectionHasGetState(slot0, slot1)
	gohelper.setActive(slot0._gohasget, true)

	slot0._txtname.text = tostring(slot1.name)
	slot0._txtdesc.text = tostring(slot1.desc)

	gohelper.setActive(slot0._gogrid1, slot1.holeNum >= 1)
	gohelper.setActive(slot0._gogrid2, slot1.holeNum >= 2)
	V1a6_CachotCollectionHelper.refreshCollectionUniqueTip(slot1, slot0._txtuniquetips, slot0._gounique)
	V1a6_CachotCollectionHelper.refreshSkillDesc(slot1, slot0._goskillcontainer, slot0._godescitem, slot0._refreshSingleSkillDesc, slot0._refreshSingleEffectDesc, slot0)
end

slot2 = "#6F3C0F"
slot3 = "#2B4E6C"

function slot0._refreshSingleSkillDesc(slot0, slot1, slot2, slot3)
	if lua_rule.configDict[slot2] then
		gohelper.findChildText(slot1, "txt_desc").text = HeroSkillModel.instance:skillDesToSpot(slot4.desc, uv0, uv1)
	end
end

function slot0._refreshSingleEffectDesc(slot0, slot1, slot2, slot3)
	if SkillConfig.instance:getSkillEffectDescCo(slot2) then
		gohelper.findChildText(slot1, "txt_desc").text = HeroSkillModel.instance:skillDesToSpot(string.format("[%s]:%s", slot4.name, slot4.desc), uv0, uv1)
	end
end

function slot0.switchCategory(slot0)
	slot0:refreshCategoryUI(slot0._btnall.gameObject, V1a6_CachotCollectionListModel.instance:getCurCategory() == V1a6_CachotEnum.CollectionCategoryType.All)
	slot0:refreshCategoryUI(slot0._btnhasget.gameObject, slot1 == V1a6_CachotEnum.CollectionCategoryType.HasGet)
	slot0:refreshCategoryUI(slot0._btnunget.gameObject, slot1 == V1a6_CachotEnum.CollectionCategoryType.UnGet)

	slot0._scrollview.verticalNormalizedPosition = 1
end

function slot0.refreshCategoryUI(slot0, slot1, slot2)
	if slot1 then
		gohelper.setActive(gohelper.findChild(slot1, "btn2"), slot2)
		gohelper.setActive(gohelper.findChild(slot1, "btn1"), not slot2)
	end
end

function slot0.onClose(slot0)
	slot0:removeEventCb(V1a6_CachotCollectionController.instance, V1a6_CachotEvent.OnSelectCollectionItem, slot0.refreshCollectionInfo, slot0)
	slot0:removeEventCb(V1a6_CachotCollectionController.instance, V1a6_CachotEvent.OnSwitchCategory, slot0.switchCategory, slot0)
	V1a6_CachotCollectionController.instance:onCloseView()
end

function slot0.onDestroyView(slot0)
	slot0._simagecollection:UnLoadImage()
end

return slot0
