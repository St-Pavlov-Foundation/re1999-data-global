module("modules.logic.character.view.CharacterEquipSettingView", package.seeall)

slot0 = class("CharacterEquipSettingView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebottom = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bottom")
	slot0._simagetop = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_top")
	slot0._goleft = gohelper.findChild(slot0.viewGO, "#go_left")
	slot0._simageheroicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_left/lefttop/#simage_heroicon")
	slot0._imageherocareer = gohelper.findChildImage(slot0.viewGO, "#go_left/lefttop/#image_herocareer")
	slot0._goequipinfo = gohelper.findChild(slot0.viewGO, "#go_left/#go_equipinfo")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "#go_left/#go_equipinfo/#txt_level")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_left/#go_equipinfo/#txt_name")
	slot0._image1 = gohelper.findChildImage(slot0.viewGO, "#go_left/#go_equipinfo/go_insigt/#image_1")
	slot0._image2 = gohelper.findChildImage(slot0.viewGO, "#go_left/#go_equipinfo/go_insigt/#image_2")
	slot0._image3 = gohelper.findChildImage(slot0.viewGO, "#go_left/#go_equipinfo/go_insigt/#image_3")
	slot0._image4 = gohelper.findChildImage(slot0.viewGO, "#go_left/#go_equipinfo/go_insigt/#image_4")
	slot0._image5 = gohelper.findChildImage(slot0.viewGO, "#go_left/#go_equipinfo/go_insigt/#image_5")
	slot0._image6 = gohelper.findChildImage(slot0.viewGO, "#go_left/#go_equipinfo/go_insigt/#image_6")
	slot0._gostrengthenattr = gohelper.findChild(slot0.viewGO, "#go_left/#go_equipinfo/layout/attribute/container/#go_strengthenattr")
	slot0._gosuitattribute = gohelper.findChild(slot0.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute")
	slot0._scrolldesccontainer = gohelper.findChildScrollRect(slot0.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer")
	slot0._gosuiteffect = gohelper.findChild(slot0.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect")
	slot0._goadvanceskill = gohelper.findChild(slot0.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_advanceskill")
	slot0._txtattributelv = gohelper.findChildText(slot0.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_advanceskill/title/#txt_attributelv")
	slot0._txtsuiteffect1 = gohelper.findChildText(slot0.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_advanceskill/#txt_suiteffect1")
	slot0._gobaseskill = gohelper.findChild(slot0.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill")
	slot0._txtbasedestitle = gohelper.findChildText(slot0.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/title/#txt_basedestitle")
	slot0._txtsuiteffect2 = gohelper.findChildText(slot0.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/#txt_suiteffect2")
	slot0._gotip = gohelper.findChild(slot0.viewGO, "#go_left/#go_equipinfo/#go_tip")
	slot0._gosortbtns = gohelper.findChild(slot0.viewGO, "#go_sortbtns")
	slot0._btnrarerank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_sortbtns/#btn_rarerank")
	slot0._btnlvrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_sortbtns/#btn_lvrank")
	slot0._scrollequip = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_equip")
	slot0._btnsetting = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_setting")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_empty")
	slot0._goleftempty = gohelper.findChild(slot0.viewGO, "#go_empty/#go_leftempty")
	slot0._gorightempty = gohelper.findChild(slot0.viewGO, "#go_empty/#go_rightempty")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnrarerank:AddClickListener(slot0._btnrarerankOnClick, slot0)
	slot0._btnlvrank:AddClickListener(slot0._btnlvrankOnClick, slot0)
	slot0._btnsetting:AddClickListener(slot0._btnsettingOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnrarerank:RemoveClickListener()
	slot0._btnlvrank:RemoveClickListener()
	slot0._btnsetting:RemoveClickListener()
end

function slot0._btnrarerankOnClick(slot0)
	CharacterEquipSettingListModel.instance:changeSortByRare()
	slot0:refreshBtnStatus()
end

function slot0._btnlvrankOnClick(slot0)
	CharacterEquipSettingListModel.instance:changeSortByLevel()
	slot0:refreshBtnStatus()
end

function slot0._btnsettingOnClick(slot0)
	if not slot0.selectedEquipMo then
		GameFacade.showToast(ToastEnum.CharacterEquipSetting1)

		return
	end

	HeroRpc.instance:setHeroDefaultEquipRequest(slot0.heroMo.heroId, slot0.selectedEquipMo.uid)
end

function slot0._editableInitView(slot0)
	slot0.goRareBtnNoSelect = gohelper.findChild(slot0.viewGO, "#go_sortbtns/#btn_rarerank/btn1")
	slot0.goRareBtnSelect = gohelper.findChild(slot0.viewGO, "#go_sortbtns/#btn_rarerank/btn2")
	slot0.goLvBtnNoSelect = gohelper.findChild(slot0.viewGO, "#go_sortbtns/#btn_lvrank/btn1")
	slot0.goLvBtnSelect = gohelper.findChild(slot0.viewGO, "#go_sortbtns/#btn_lvrank/btn2")
	slot0.goRareBtnNoSelectArrow = gohelper.findChild(slot0.viewGO, "#go_sortbtns/#btn_rarerank/btn1/arrow")
	slot0.goRareBtnSelectArrow = gohelper.findChild(slot0.viewGO, "#go_sortbtns/#btn_rarerank/btn2/arrow")
	slot0.goLvBtnNoSelectArrow = gohelper.findChild(slot0.viewGO, "#go_sortbtns/#btn_lvrank/btn1/arrow")
	slot0.goLvBtnSelectArrow = gohelper.findChild(slot0.viewGO, "#go_sortbtns/#btn_lvrank/btn2/arrow")

	gohelper.setActive(slot0._gostrengthenattr, false)
	gohelper.setActive(slot0._txtsuiteffect1.gameObject, false)
	gohelper.setActive(slot0._txtsuiteffect2.gameObject, false)
	gohelper.addUIClickAudio(slot0._btnsetting.gameObject, AudioEnum.UI.Play_UI_General_shutdown)

	slot0.strengthenAttrItems = slot0:getUserDataTb_()
	slot0.skillAttributeItems = slot0:getUserDataTb_()
	slot0.skillDescItems = slot0:getUserDataTb_()

	CharacterController.instance:registerCallback(CharacterEvent.DefaultEquipViewEquipSelectChange, slot0.onSelectEquipChange, slot0)
	CharacterController.instance:registerCallback(CharacterEvent.successSetDefaultEquip, slot0.onSuccessSetDefaultEquip, slot0)
	slot0._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function slot0.onSelectEquipChange(slot0)
	slot0.selectedEquipMo = CharacterEquipSettingListModel.instance:getCurrentSelectEquipMo()

	slot0:refreshLeftUI()
	slot0:refreshSetBtn()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.heroMo = slot0.viewParam.heroMo

	CharacterEquipSettingListModel.instance:initEquipList()

	slot0.selectedEquipMo = CharacterEquipSettingListModel.instance:getCurrentSelectEquipMo()

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshHeroInfo()
	slot0:refreshLeftUI()
	slot0:refreshRightUI()
	slot0:refreshBtnStatus()
	slot0:refreshSetBtn()
end

function slot0.refreshLeftUI(slot0)
	gohelper.setActive(slot0._goleftempty, not slot0.selectedEquipMo)
	gohelper.setActive(slot0._goequipinfo, slot0.selectedEquipMo)

	if slot0.selectedEquipMo then
		slot0._txtname.text = slot0.selectedEquipMo.config.name

		slot0:refreshEquipStar()
		slot0:refreshEquipLevel()
		slot0:refreshEquipNormalAttr()
		slot0:refreshEquipSkillAttribute()
		slot0:refreshEquipSkillDesc()
	end
end

function slot0.refreshRightUI(slot0)
	slot1 = CharacterEquipSettingListModel.instance:hasNormalEquip()

	gohelper.setActive(slot0._gorightempty, not slot1)
	gohelper.setActive(slot0._scrollequip.gameObject, slot1)

	if slot1 then
		CharacterEquipSettingListModel.instance:refreshEquipList()
	end
end

function slot0.refreshBtnStatus(slot0)
	gohelper.setActive(slot0.goRareBtnNoSelect, not CharacterEquipSettingListModel.instance:isSortByRare())
	gohelper.setActive(slot0.goRareBtnSelect, CharacterEquipSettingListModel.instance:isSortByRare())
	gohelper.setActive(slot0.goLvBtnNoSelect, not CharacterEquipSettingListModel.instance:isSortByLevel())
	gohelper.setActive(slot0.goLvBtnSelect, CharacterEquipSettingListModel.instance:isSortByLevel())

	slot1, slot2 = CharacterEquipSettingListModel.instance:getSortState()

	transformhelper.setLocalScale(slot0.goRareBtnNoSelectArrow.transform, 1, slot2, 1)
	transformhelper.setLocalScale(slot0.goRareBtnSelectArrow.transform, 1, slot2, 1)
	transformhelper.setLocalScale(slot0.goLvBtnNoSelectArrow.transform, 1, slot1, 1)
	transformhelper.setLocalScale(slot0.goLvBtnSelectArrow.transform, 1, slot1, 1)
end

function slot0.refreshHeroInfo(slot0)
	slot0._simageheroicon:LoadImage(ResUrl.getHandbookheroIcon(slot0.heroMo.config.skinId))
	UISpriteSetMgr.instance:setHandBookCareerSprite(slot0._imageherocareer, "sx_icon_" .. tostring(slot0.heroMo.config.career))
end

function slot0.refreshEquipStar(slot0)
	for slot5 = 1, 6 do
		gohelper.setActive(slot0["_image" .. slot5].gameObject, slot5 <= slot0.selectedEquipMo.config.rare + 1)
	end
end

function slot0.refreshEquipLevel(slot0)
	slot0._txtlevel.text = string.format("Lv.<color=#9a551b>%d</color>/%d", slot0.selectedEquipMo.level, EquipConfig.instance:getCurrentBreakLevelMaxLevel(slot0.selectedEquipMo))
end

function slot0.refreshEquipNormalAttr(slot0)
	slot1, slot2 = EquipConfig.instance:getEquipNormalAttr(slot0.selectedEquipMo.config.id, slot0.selectedEquipMo.level, HeroConfig.sortAttrForEquipView)
	slot3, slot4 = nil

	for slot8, slot9 in ipairs(slot2) do
		if not slot0.strengthenAttrItems[slot8] then
			slot3 = {
				go = gohelper.cloneInPlace(slot0._gostrengthenattr, "item" .. slot8)
			}
			slot3.icon = gohelper.findChildImage(slot3.go, "image_icon")
			slot3.name = gohelper.findChildText(slot3.go, "txt_name")
			slot3.attr_value = gohelper.findChildText(slot3.go, "txt_value")

			table.insert(slot0.strengthenAttrItems, slot3)
		end

		slot4 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(slot9.attrType))

		UISpriteSetMgr.instance:setCommonSprite(slot3.icon, "icon_att_" .. slot4.id)

		slot3.name.text = slot4.name
		slot3.attr_value.text = slot9.value

		gohelper.setActive(slot3.go, true)
	end

	for slot8 = #slot2 + 1, #slot0.strengthenAttrItems do
		gohelper.setActive(slot0.strengthenAttrItems[slot8].go, false)
	end
end

function slot0.refreshEquipSkillAttribute(slot0)
	if EquipHelper.getEquipSkillAdvanceAttrDesTab(slot0.selectedEquipMo.config.id, slot0.selectedEquipMo.refineLv, "#985630") and #slot1 > 0 then
		gohelper.setActive(slot0._goadvanceskill, true)

		slot0._txtattributelv.text = slot0.selectedEquipMo.refineLv
		slot2, slot3 = nil

		for slot7, slot8 in ipairs(slot1) do
			if not slot0.skillAttributeItems[slot7] then
				table.insert(slot0.skillAttributeItems, gohelper.cloneInPlace(slot0._txtsuiteffect1.gameObject, "item" .. slot7):GetComponent(gohelper.Type_TextMesh))
			end

			gohelper.setActive(slot2.gameObject, true)

			slot2.text = slot8
		end

		for slot7 = #slot1 + 1, #slot0.skillAttributeItems do
			gohelper.setActive(slot0.skillAttributeItems[slot7].gameObject, false)
		end
	else
		gohelper.setActive(slot0._goadvanceskill, false)
	end
end

function slot0.refreshEquipSkillDesc(slot0)
	slot1, slot2, slot3 = EquipHelper.getSkillBaseDescAndIcon(slot0.selectedEquipMo.config.id, slot0.selectedEquipMo.refineLv, "#985630")

	if #slot1 == 0 then
		gohelper.setActive(slot0._gobaseskill.gameObject, false)
	else
		gohelper.setActive(slot0._gobaseskill.gameObject, true)

		slot8 = slot0.selectedEquipMo.config.skillName
		slot0._txtbasedestitle.text = string.format("<%s>%s</color>", slot0:getSkillNameColor(EquipHelper.getEquipSkillCareer(slot0.selectedEquipMo.config.id, slot0.selectedEquipMo.refineLv)), slot8)
		slot4 = nil

		for slot8, slot9 in ipairs(slot1) do
			if not slot0.skillDescItems[slot8] then
				slot11 = gohelper.cloneInPlace(slot0._txtsuiteffect2.gameObject, "item_" .. slot8)

				table.insert(slot0.skillDescItems, {
					itemGo = slot11,
					_imagebasedesicon = gohelper.findChildImage(slot11, "#image_basedesicon"),
					txt = slot11:GetComponent(gohelper.Type_TextMesh),
					skillDescCanvasGroup = slot11:GetComponent(typeof(UnityEngine.CanvasGroup))
				})
			end

			slot4.txt.text = slot9
			slot4.skillDescCanvasGroup.alpha = slot0.selectedEquipMo and EquipHelper.detectEquipSkillSuited(slot0.heroMo.heroId, slot0.selectedEquipMo.config.id, slot0.selectedEquipMo.refineLv) and 1 or 0.45

			UISpriteSetMgr.instance:setCommonSprite(slot4._imagebasedesicon, slot2)
			gohelper.setActive(slot4.itemGo, true)
		end

		for slot8 = #slot1 + 1, #slot0.skillDescItems do
			gohelper.setActive(slot0.skillDescItems[slot8].itemGo, false)
		end
	end
end

function slot0.onSuccessSetDefaultEquip(slot0)
	GameFacade.showToast(ToastEnum.CharacterEquipSetting2)
	slot0:refreshSetBtn()
end

function slot0.refreshSetBtn(slot0)
	if not slot0.selectedEquipMo then
		gohelper.setActive(slot0._btnsetting.gameObject, true)
		ZProj.UGUIHelper.SetGrayscale(slot0._btnsetting.gameObject, true)

		return
	end

	gohelper.setActive(slot0._btnsetting.gameObject, not (slot0.heroMo.defaultEquipUid == slot0.selectedEquipMo.uid))
	ZProj.UGUIHelper.SetGrayscale(slot0._btnsetting.gameObject, false)
end

function slot0.getSkillNameColor(slot0, slot1)
	slot2 = {
		["0"] = "#FFFFFF",
		["1"] = "#8b704e",
		["5|6"] = "#6b536e",
		["2"] = "#4e607b",
		["3"] = "#476f4b",
		["4"] = "#9b4f4b"
	}

	return string.nilorempty(slot1) and slot2["0"] or slot2[slot1]
end

function slot0.onClose(slot0)
	slot0._simageheroicon:UnLoadImage()
	CharacterController.instance:unregisterCallback(CharacterEvent.DefaultEquipViewEquipSelectChange, slot0.onSelectEquipChange, slot0)
	CharacterController.instance:unregisterCallback(CharacterEvent.successSetDefaultEquip, slot0.onSuccessSetDefaultEquip, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebottom:UnLoadImage()
	slot0._simagetop:UnLoadImage()
end

return slot0
