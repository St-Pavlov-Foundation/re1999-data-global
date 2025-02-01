module("modules.logic.equip.view.EquipBreakResultView", package.seeall)

slot0 = class("EquipBreakResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._simageequip = gohelper.findChildSingleImage(slot0.viewGO, "center/#simage_equip")
	slot0._imagelock = gohelper.findChildImage(slot0.viewGO, "center/#image_lock")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "center/#txt_name")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "center/#txt_num")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "#go_righttop")
	slot0._image1 = gohelper.findChildImage(slot0.viewGO, "right/container/go_insigt/#image_1")
	slot0._image2 = gohelper.findChildImage(slot0.viewGO, "right/container/go_insigt/#image_2")
	slot0._image3 = gohelper.findChildImage(slot0.viewGO, "right/container/go_insigt/#image_3")
	slot0._image4 = gohelper.findChildImage(slot0.viewGO, "right/container/go_insigt/#image_4")
	slot0._image5 = gohelper.findChildImage(slot0.viewGO, "right/container/go_insigt/#image_5")
	slot0._gostrengthenattr = gohelper.findChild(slot0.viewGO, "right/container/#go_strengthenattr")
	slot0._gobreakattr = gohelper.findChild(slot0.viewGO, "right/container/#go_breakattr")
	slot0._txtmeshsuiteffect = gohelper.findChildTextMesh(slot0.viewGO, "right/suiteffect/#txtmesh_suiteffect")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

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
	slot0._simagebg:LoadImage(ResUrl.getCommonViewBg("full/zhuangbei_006"))

	slot0._strengthenattrs = slot0:getUserDataTb_()
	slot0._attrIndex = 1
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._equipMO = slot0.viewParam[1]
	slot0._prevLv = slot0.viewParam[2]
	slot0._prevBreakLv = slot0.viewParam[3]
	slot0._config = slot0._equipMO.config
	slot0._lock = slot0._equipMO.isLock

	if slot0._config.isExpEquip == 1 then
		slot0._imagelock.gameObject:SetActive(false)
	else
		UISpriteSetMgr.instance:setEquipSprite(slot0._imagelock, slot0._lock and "bg_tips_suo" or "bg_tips_jiesuo", true)
	end

	for slot5 = 1, 5 do
		UISpriteSetMgr.instance:setEquipSprite(slot0["_image" .. slot5], slot5 <= slot0._equipMO.breakLv and "xx_11" or "xx_10")
	end

	slot0._simageequip:LoadImage(ResUrl.getEquipSuit(slot0._config.icon))

	slot0._txtname.text = slot0._config.name
	slot2, slot3, slot4, slot5, slot6 = EquipConfig.instance:getEquipStrengthenAttr(slot0._equipMO, nil, slot0._prevLv, slot0._prevBreakLv)
	slot7, slot8, slot9, slot10, slot11 = EquipConfig.instance:getEquipStrengthenAttr(slot0._equipMO, nil, slot0._equipMO.level, slot0._equipMO.breakLv)

	for slot15, slot16 in pairs(lua_character_attribute.configDict) do
		if slot16.type == 2 or slot16.type == 3 then
			EquipController.instance.showAttr(slot0, slot15, slot16.showType, slot11[slot16.attrType], slot6[slot16.attrType])
		end
	end

	slot0:showLevelInfo()
end

function slot0.showLevelInfo(slot0)
	gohelper.setActive(slot0._gobreakattr, true)

	gohelper.findChildText(slot0._gobreakattr, "txt_value").text = EquipConfig.instance:getMaxLevel(slot0._equipMO.breakLv)
	gohelper.findChildText(slot0._gobreakattr, "txt_prevvalue").text = EquipConfig.instance:getMaxLevel(slot0._prevBreakLv)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageequip:UnLoadImage()
end

return slot0
