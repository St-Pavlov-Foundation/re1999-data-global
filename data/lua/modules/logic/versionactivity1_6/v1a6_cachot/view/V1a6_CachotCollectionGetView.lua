module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionGetView", package.seeall)

slot0 = class("V1a6_CachotCollectionGetView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagelevelbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_levelbg")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#simage_title")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_view")
	slot0._gocollectionitem = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/Content/#go_lineitem/#go_collectionitem")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._golineitem = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/Content/#go_lineitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._goScrollContent = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/Content")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshPerLineCollectionList(slot0:buildLineMOList(slot0.viewParam and slot1.getColletions))
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_collection_get)
end

slot1 = 3

function slot0.buildLineMOList(slot0, slot1)
	slot2 = {}

	if slot1 then
		for slot8, slot9 in ipairs(slot1) do
			if uv0 <= 0 then
				table.insert(slot2, {})

				slot4 = {}
				slot3 = 0
			end

			table.insert(slot4, slot9)

			slot3 = slot3 + 1
		end

		if slot4 and #slot4 > 0 then
			table.insert(slot2, slot4)
		end
	end

	return slot2
end

function slot0.refreshPerLineCollectionList(slot0, slot1)
	gohelper.CreateObjList(slot0, slot0._onShowPerLineCollectionItem, slot1, slot0._goScrollContent, slot0._golineitem)
end

function slot0._onShowPerLineCollectionItem(slot0, slot1, slot2, slot3)
	slot0:refreshGetCollectionList(slot2, slot1, slot0._gocollectionitem)
end

function slot0.refreshGetCollectionList(slot0, slot1, slot2, slot3)
	gohelper.CreateObjList(slot0, slot0._onShowGetCollectionItem, slot1, slot2, slot3)
end

function slot0._onShowGetCollectionItem(slot0, slot1, slot2, slot3)
	if V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot2) then
		slot5 = gohelper.findChildSingleImage(slot1, "collection/#simage_collection")
		slot5.curImageUrl = nil

		slot5:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. slot4.icon))

		gohelper.findChildText(slot1, "collection/#txt_name").text = slot4.name

		V1a6_CachotCollectionHelper.refreshSkillDescWithoutEffectDesc(slot4, gohelper.findChild(slot1, "layout"), gohelper.findChild(slot1, "layout/#go_descitem"))
	end
end

function slot0.onClose(slot0)
	V1a6_CachotEventController.instance:setPause(false, V1a6_CachotEnum.EventPauseType.GetCollecttions)
end

function slot0.onDestroyView(slot0)
end

return slot0
