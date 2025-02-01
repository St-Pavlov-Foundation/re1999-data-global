module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionOverItem", package.seeall)

slot0 = class("V1a6_CachotCollectionOverItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._simagecollection = gohelper.findChildSingleImage(slot0.viewGO, "#simage_collection")
	slot0._imageframe = gohelper.findChildImage(slot0.viewGO, "#image_frame")
	slot0._gogrid1 = gohelper.findChild(slot0.viewGO, "layout/#go_grid1")
	slot0._gonone1 = gohelper.findChild(slot0.viewGO, "layout/#go_grid1/#go_none1")
	slot0._goget1 = gohelper.findChildSingleImage(slot0.viewGO, "layout/#go_grid1/#go_get1")
	slot0._simageicon1 = gohelper.findChildSingleImage(slot0.viewGO, "layout/#go_grid1/#go_get1/#simage_icon1")
	slot0._gonone2 = gohelper.findChild(slot0.viewGO, "layout/#go_grid2/#go_none2")
	slot0._gogrid2 = gohelper.findChild(slot0.viewGO, "layout/#go_grid2")
	slot0._goget2 = gohelper.findChild(slot0.viewGO, "layout/#go_grid2/#go_get2")
	slot0._simageicon2 = gohelper.findChildSingleImage(slot0.viewGO, "layout/#go_grid2/#go_get2/#simage_icon2")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "#txt_dec")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")

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
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnClickCachotOverItem, slot0._mo.id)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	if V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot0._mo.cfgId) then
		slot0:refreshEnchants(slot1)
		slot0:refreshEffectDesc(slot1)
		UISpriteSetMgr.instance:setV1a6CachotSprite(slot0._imageframe, string.format("v1a6_cachot_img_collectionframe%s", slot1.showRare))
		slot0._simagecollection:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. slot1.icon))

		slot0._txtname.text = tostring(slot1.name)
	end
end

slot0.SkillEffectDescColor = "#CAC8C5"
slot0.CollectionSpDescColor = "#5A8F5C"

function slot0.refreshEffectDesc(slot0, slot1)
	slot2 = ""

	if not string.nilorempty(slot1 and slot1.spdesc) then
		slot2 = string.format("%s\n%s", string.format("<%s>%s</color>", uv0.SkillEffectDescColor, V1a6_CachotCollectionConfig.instance:getCollectionSkillsContent(slot1)), string.format("<%s>%s</color>", uv0.CollectionSpDescColor, HeroSkillModel.instance:skillDesToSpot(slot4)))
	end

	slot0._txtdec.text = slot2
end

function slot0.refreshEnchants(slot0, slot1)
	gohelper.setActive(slot0._gogrid1, slot1 and slot1.holeNum >= 1)
	gohelper.setActive(slot0._gogrid2, slot1 and slot1.holeNum >= 2)

	if not slot1 or slot1.holeNum <= 0 then
		return
	end

	slot0:refreshSingleHole(V1a6_CachotEnum.CollectionHole.Left)
	slot0:refreshSingleHole(V1a6_CachotEnum.CollectionHole.Right)
end

function slot0.refreshSingleHole(slot0, slot1)
	if slot0._mo and slot0._mo:getEnchantId(slot1) and slot2 ~= 0 then
		gohelper.setActive(slot0["_gonone" .. slot1], false)
		gohelper.setActive(slot0["_goget" .. slot1], true)

		slot4 = V1a6_CachotModel.instance:getRogueInfo() and slot3:getCollectionByUid(slot2)

		if V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot4 and slot4.cfgId) then
			slot0["_simageicon" .. slot1]:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. slot6.icon))
		end
	else
		gohelper.setActive(slot0["_gonone" .. slot1], true)
		gohelper.setActive(slot0["_goget" .. slot1], false)
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

function slot0.onDestroyView(slot0)
	slot0._simagecollection:UnLoadImage()
	slot0:releaseSingleImage()
end

return slot0
