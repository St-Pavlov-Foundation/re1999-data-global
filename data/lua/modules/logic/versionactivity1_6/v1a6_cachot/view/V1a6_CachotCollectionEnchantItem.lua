module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionEnchantItem", package.seeall)

slot0 = class("V1a6_CachotCollectionEnchantItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imageframe = gohelper.findChildImage(slot0.viewGO, "#image_frame")
	slot0._simagecollection = gohelper.findChildSingleImage(slot0.viewGO, "#simage_collection")
	slot0._goenchant = gohelper.findChild(slot0.viewGO, "#go_enchant")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_enchant/#simage_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._godescitem = gohelper.findChild(slot0.viewGO, "scroll_effect/Viewport/Content/#go_descitem")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "select")
	slot0._btnclick = gohelper.getClickWithDefaultAudio(slot0.viewGO)
	slot0._scrolleffect = gohelper.findChildScrollRect(slot0.viewGO, "scroll_effect")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	V1a6_CachotCollectionEnchantController.instance:onSelectEnchantItem(slot0._mo.id, true)
end

function slot0._editableInitView(slot0)
	slot0._goScrollContent = gohelper.findChild(slot0.viewGO, "scroll_effect/Viewport/Content")
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	if V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot0._mo.cfgId) then
		slot0._txtname.text = tostring(slot1.name)

		slot0._simagecollection:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. slot1.icon))
		UISpriteSetMgr.instance:setV1a6CachotSprite(slot0._imageframe, string.format("v1a6_cachot_img_collectionframe%s", slot1.showRare))
		slot0:refreshCollectionUI()
		V1a6_CachotCollectionHelper.refreshSkillDesc(slot1, slot0._goScrollContent, slot0._godescitem, slot0._refreshSingleSkillDesc)

		slot0._scrolleffect.verticalNormalizedPosition = 1
	end
end

function slot0.refreshCollectionUI(slot0)
	slot2 = V1a6_CachotModel.instance:getRogueInfo() and slot1:getCollectionByUid(slot0._mo.enchantUid)

	gohelper.setActive(slot0._goenchant, slot2 ~= nil)

	if slot2 and V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot2.cfgId) then
		slot0._simageicon:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. slot3.icon))
	end
end

slot1 = "#C66030"
slot2 = "#C66030"

function slot0._refreshSingleSkillDesc(slot0, slot1, slot2, slot3)
	if lua_rule.configDict[slot2] then
		gohelper.findChildText(slot1, "txt_desc").text = HeroSkillModel.instance:skillDesToSpot(slot4.desc, uv0, uv1)
	end
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)
end

function slot0.onDestroyView(slot0)
	slot0._simagecollection:UnLoadImage()
end

return slot0
