module("modules.logic.character.view.CharacterEquipSettingView", package.seeall)

local var_0_0 = class("CharacterEquipSettingView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebottom = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bottom")
	arg_1_0._simagetop = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_top")
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "#go_left")
	arg_1_0._simageheroicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_left/lefttop/#simage_heroicon")
	arg_1_0._imageherocareer = gohelper.findChildImage(arg_1_0.viewGO, "#go_left/lefttop/#image_herocareer")
	arg_1_0._goequipinfo = gohelper.findChild(arg_1_0.viewGO, "#go_left/#go_equipinfo")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "#go_left/#go_equipinfo/#txt_level")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_left/#go_equipinfo/#txt_name")
	arg_1_0._image1 = gohelper.findChildImage(arg_1_0.viewGO, "#go_left/#go_equipinfo/go_insigt/#image_1")
	arg_1_0._image2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_left/#go_equipinfo/go_insigt/#image_2")
	arg_1_0._image3 = gohelper.findChildImage(arg_1_0.viewGO, "#go_left/#go_equipinfo/go_insigt/#image_3")
	arg_1_0._image4 = gohelper.findChildImage(arg_1_0.viewGO, "#go_left/#go_equipinfo/go_insigt/#image_4")
	arg_1_0._image5 = gohelper.findChildImage(arg_1_0.viewGO, "#go_left/#go_equipinfo/go_insigt/#image_5")
	arg_1_0._image6 = gohelper.findChildImage(arg_1_0.viewGO, "#go_left/#go_equipinfo/go_insigt/#image_6")
	arg_1_0._gostrengthenattr = gohelper.findChild(arg_1_0.viewGO, "#go_left/#go_equipinfo/layout/attribute/container/#go_strengthenattr")
	arg_1_0._gosuitattribute = gohelper.findChild(arg_1_0.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute")
	arg_1_0._scrolldesccontainer = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer")
	arg_1_0._gosuiteffect = gohelper.findChild(arg_1_0.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect")
	arg_1_0._goadvanceskill = gohelper.findChild(arg_1_0.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_advanceskill")
	arg_1_0._txtattributelv = gohelper.findChildText(arg_1_0.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_advanceskill/title/#txt_attributelv")
	arg_1_0._txtsuiteffect1 = gohelper.findChildText(arg_1_0.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_advanceskill/#txt_suiteffect1")
	arg_1_0._gobaseskill = gohelper.findChild(arg_1_0.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill")
	arg_1_0._txtbasedestitle = gohelper.findChildText(arg_1_0.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/title/#txt_basedestitle")
	arg_1_0._txtsuiteffect2 = gohelper.findChildText(arg_1_0.viewGO, "#go_left/#go_equipinfo/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/#txt_suiteffect2")
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "#go_left/#go_equipinfo/#go_tip")
	arg_1_0._gosortbtns = gohelper.findChild(arg_1_0.viewGO, "#go_sortbtns")
	arg_1_0._btnrarerank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_sortbtns/#btn_rarerank")
	arg_1_0._btnlvrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_sortbtns/#btn_lvrank")
	arg_1_0._scrollequip = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_equip")
	arg_1_0._btnsetting = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_setting")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_empty")
	arg_1_0._goleftempty = gohelper.findChild(arg_1_0.viewGO, "#go_empty/#go_leftempty")
	arg_1_0._gorightempty = gohelper.findChild(arg_1_0.viewGO, "#go_empty/#go_rightempty")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnrarerank:AddClickListener(arg_2_0._btnrarerankOnClick, arg_2_0)
	arg_2_0._btnlvrank:AddClickListener(arg_2_0._btnlvrankOnClick, arg_2_0)
	arg_2_0._btnsetting:AddClickListener(arg_2_0._btnsettingOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnrarerank:RemoveClickListener()
	arg_3_0._btnlvrank:RemoveClickListener()
	arg_3_0._btnsetting:RemoveClickListener()
end

function var_0_0._btnrarerankOnClick(arg_4_0)
	CharacterEquipSettingListModel.instance:changeSortByRare()
	arg_4_0:refreshBtnStatus()
end

function var_0_0._btnlvrankOnClick(arg_5_0)
	CharacterEquipSettingListModel.instance:changeSortByLevel()
	arg_5_0:refreshBtnStatus()
end

function var_0_0._btnsettingOnClick(arg_6_0)
	if not arg_6_0.selectedEquipMo then
		GameFacade.showToast(ToastEnum.CharacterEquipSetting1)

		return
	end

	HeroRpc.instance:setHeroDefaultEquipRequest(arg_6_0.heroMo.heroId, arg_6_0.selectedEquipMo.uid)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0.goRareBtnNoSelect = gohelper.findChild(arg_7_0.viewGO, "#go_sortbtns/#btn_rarerank/btn1")
	arg_7_0.goRareBtnSelect = gohelper.findChild(arg_7_0.viewGO, "#go_sortbtns/#btn_rarerank/btn2")
	arg_7_0.goLvBtnNoSelect = gohelper.findChild(arg_7_0.viewGO, "#go_sortbtns/#btn_lvrank/btn1")
	arg_7_0.goLvBtnSelect = gohelper.findChild(arg_7_0.viewGO, "#go_sortbtns/#btn_lvrank/btn2")
	arg_7_0.goRareBtnNoSelectArrow = gohelper.findChild(arg_7_0.viewGO, "#go_sortbtns/#btn_rarerank/btn1/arrow")
	arg_7_0.goRareBtnSelectArrow = gohelper.findChild(arg_7_0.viewGO, "#go_sortbtns/#btn_rarerank/btn2/arrow")
	arg_7_0.goLvBtnNoSelectArrow = gohelper.findChild(arg_7_0.viewGO, "#go_sortbtns/#btn_lvrank/btn1/arrow")
	arg_7_0.goLvBtnSelectArrow = gohelper.findChild(arg_7_0.viewGO, "#go_sortbtns/#btn_lvrank/btn2/arrow")

	gohelper.setActive(arg_7_0._gostrengthenattr, false)
	gohelper.setActive(arg_7_0._txtsuiteffect1.gameObject, false)
	gohelper.setActive(arg_7_0._txtsuiteffect2.gameObject, false)
	gohelper.addUIClickAudio(arg_7_0._btnsetting.gameObject, AudioEnum.UI.Play_UI_General_shutdown)

	arg_7_0.strengthenAttrItems = arg_7_0:getUserDataTb_()
	arg_7_0.skillAttributeItems = arg_7_0:getUserDataTb_()
	arg_7_0.skillDescItems = arg_7_0:getUserDataTb_()

	CharacterController.instance:registerCallback(CharacterEvent.DefaultEquipViewEquipSelectChange, arg_7_0.onSelectEquipChange, arg_7_0)
	CharacterController.instance:registerCallback(CharacterEvent.successSetDefaultEquip, arg_7_0.onSuccessSetDefaultEquip, arg_7_0)
	arg_7_0._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_7_0._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function var_0_0.onSelectEquipChange(arg_8_0)
	arg_8_0.selectedEquipMo = CharacterEquipSettingListModel.instance:getCurrentSelectEquipMo()

	arg_8_0:refreshLeftUI()
	arg_8_0:refreshSetBtn()
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0.heroMo = arg_10_0.viewParam.heroMo

	CharacterEquipSettingListModel.instance:initEquipList()

	arg_10_0.selectedEquipMo = CharacterEquipSettingListModel.instance:getCurrentSelectEquipMo()

	arg_10_0:refreshUI()
end

function var_0_0.refreshUI(arg_11_0)
	arg_11_0:refreshHeroInfo()
	arg_11_0:refreshLeftUI()
	arg_11_0:refreshRightUI()
	arg_11_0:refreshBtnStatus()
	arg_11_0:refreshSetBtn()
end

function var_0_0.refreshLeftUI(arg_12_0)
	gohelper.setActive(arg_12_0._goleftempty, not arg_12_0.selectedEquipMo)
	gohelper.setActive(arg_12_0._goequipinfo, arg_12_0.selectedEquipMo)

	if arg_12_0.selectedEquipMo then
		arg_12_0._txtname.text = arg_12_0.selectedEquipMo.config.name

		arg_12_0:refreshEquipStar()
		arg_12_0:refreshEquipLevel()
		arg_12_0:refreshEquipNormalAttr()
		arg_12_0:refreshEquipSkillAttribute()
		arg_12_0:refreshEquipSkillDesc()
	end
end

function var_0_0.refreshRightUI(arg_13_0)
	local var_13_0 = CharacterEquipSettingListModel.instance:hasNormalEquip()

	gohelper.setActive(arg_13_0._gorightempty, not var_13_0)
	gohelper.setActive(arg_13_0._scrollequip.gameObject, var_13_0)

	if var_13_0 then
		CharacterEquipSettingListModel.instance:refreshEquipList()
	end
end

function var_0_0.refreshBtnStatus(arg_14_0)
	gohelper.setActive(arg_14_0.goRareBtnNoSelect, not CharacterEquipSettingListModel.instance:isSortByRare())
	gohelper.setActive(arg_14_0.goRareBtnSelect, CharacterEquipSettingListModel.instance:isSortByRare())
	gohelper.setActive(arg_14_0.goLvBtnNoSelect, not CharacterEquipSettingListModel.instance:isSortByLevel())
	gohelper.setActive(arg_14_0.goLvBtnSelect, CharacterEquipSettingListModel.instance:isSortByLevel())

	local var_14_0, var_14_1 = CharacterEquipSettingListModel.instance:getSortState()

	transformhelper.setLocalScale(arg_14_0.goRareBtnNoSelectArrow.transform, 1, var_14_1, 1)
	transformhelper.setLocalScale(arg_14_0.goRareBtnSelectArrow.transform, 1, var_14_1, 1)
	transformhelper.setLocalScale(arg_14_0.goLvBtnNoSelectArrow.transform, 1, var_14_0, 1)
	transformhelper.setLocalScale(arg_14_0.goLvBtnSelectArrow.transform, 1, var_14_0, 1)
end

function var_0_0.refreshHeroInfo(arg_15_0)
	arg_15_0._simageheroicon:LoadImage(ResUrl.getHandbookheroIcon(arg_15_0.heroMo.config.skinId))
	UISpriteSetMgr.instance:setHandBookCareerSprite(arg_15_0._imageherocareer, "sx_icon_" .. tostring(arg_15_0.heroMo.config.career))
end

function var_0_0.refreshEquipStar(arg_16_0)
	local var_16_0 = arg_16_0.selectedEquipMo.config.rare

	for iter_16_0 = 1, 6 do
		gohelper.setActive(arg_16_0["_image" .. iter_16_0].gameObject, iter_16_0 <= var_16_0 + 1)
	end
end

function var_0_0.refreshEquipLevel(arg_17_0)
	local var_17_0 = arg_17_0.selectedEquipMo.level
	local var_17_1 = EquipConfig.instance:getCurrentBreakLevelMaxLevel(arg_17_0.selectedEquipMo)

	arg_17_0._txtlevel.text = string.format("Lv.<color=#9a551b>%d</color>/%d", var_17_0, var_17_1)
end

function var_0_0.refreshEquipNormalAttr(arg_18_0)
	local var_18_0, var_18_1 = EquipConfig.instance:getEquipNormalAttr(arg_18_0.selectedEquipMo.config.id, arg_18_0.selectedEquipMo.level, HeroConfig.sortAttrForEquipView)
	local var_18_2
	local var_18_3

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		local var_18_4 = arg_18_0.strengthenAttrItems[iter_18_0]

		if not var_18_4 then
			var_18_4 = {
				go = gohelper.cloneInPlace(arg_18_0._gostrengthenattr, "item" .. iter_18_0)
			}
			var_18_4.icon = gohelper.findChildImage(var_18_4.go, "image_icon")
			var_18_4.name = gohelper.findChildText(var_18_4.go, "txt_name")
			var_18_4.attr_value = gohelper.findChildText(var_18_4.go, "txt_value")

			table.insert(arg_18_0.strengthenAttrItems, var_18_4)
		end

		local var_18_5 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(iter_18_1.attrType))

		UISpriteSetMgr.instance:setCommonSprite(var_18_4.icon, "icon_att_" .. var_18_5.id)

		var_18_4.name.text = var_18_5.name
		var_18_4.attr_value.text = iter_18_1.value

		gohelper.setActive(var_18_4.go, true)
	end

	for iter_18_2 = #var_18_1 + 1, #arg_18_0.strengthenAttrItems do
		gohelper.setActive(arg_18_0.strengthenAttrItems[iter_18_2].go, false)
	end
end

function var_0_0.refreshEquipSkillAttribute(arg_19_0)
	local var_19_0 = EquipHelper.getEquipSkillAdvanceAttrDesTab(arg_19_0.selectedEquipMo.config.id, arg_19_0.selectedEquipMo.refineLv, "#985630")

	if var_19_0 and #var_19_0 > 0 then
		gohelper.setActive(arg_19_0._goadvanceskill, true)

		arg_19_0._txtattributelv.text = arg_19_0.selectedEquipMo.refineLv

		local var_19_1
		local var_19_2

		for iter_19_0, iter_19_1 in ipairs(var_19_0) do
			local var_19_3 = arg_19_0.skillAttributeItems[iter_19_0]

			if not var_19_3 then
				var_19_3 = gohelper.cloneInPlace(arg_19_0._txtsuiteffect1.gameObject, "item" .. iter_19_0):GetComponent(gohelper.Type_TextMesh)

				table.insert(arg_19_0.skillAttributeItems, var_19_3)
			end

			gohelper.setActive(var_19_3.gameObject, true)

			var_19_3.text = iter_19_1
		end

		for iter_19_2 = #var_19_0 + 1, #arg_19_0.skillAttributeItems do
			gohelper.setActive(arg_19_0.skillAttributeItems[iter_19_2].gameObject, false)
		end
	else
		gohelper.setActive(arg_19_0._goadvanceskill, false)
	end
end

function var_0_0.refreshEquipSkillDesc(arg_20_0)
	local var_20_0, var_20_1, var_20_2 = EquipHelper.getSkillBaseDescAndIcon(arg_20_0.selectedEquipMo.config.id, arg_20_0.selectedEquipMo.refineLv, "#985630")

	if #var_20_0 == 0 then
		gohelper.setActive(arg_20_0._gobaseskill.gameObject, false)
	else
		gohelper.setActive(arg_20_0._gobaseskill.gameObject, true)

		local var_20_3 = arg_20_0:getSkillNameColor(EquipHelper.getEquipSkillCareer(arg_20_0.selectedEquipMo.config.id, arg_20_0.selectedEquipMo.refineLv))

		arg_20_0._txtbasedestitle.text = string.format("<%s>%s</color>", var_20_3, arg_20_0.selectedEquipMo.config.skillName)

		local var_20_4

		for iter_20_0, iter_20_1 in ipairs(var_20_0) do
			local var_20_5 = arg_20_0.skillDescItems[iter_20_0]

			if not var_20_5 then
				local var_20_6 = {}
				local var_20_7 = gohelper.cloneInPlace(arg_20_0._txtsuiteffect2.gameObject, "item_" .. iter_20_0)

				var_20_6.itemGo = var_20_7
				var_20_6._imagebasedesicon = gohelper.findChildImage(var_20_7, "#image_basedesicon")
				var_20_6.txt = var_20_7:GetComponent(gohelper.Type_TextMesh)
				var_20_6.skillDescCanvasGroup = var_20_7:GetComponent(typeof(UnityEngine.CanvasGroup))
				var_20_5 = var_20_6

				table.insert(arg_20_0.skillDescItems, var_20_5)
			end

			var_20_5.txt.text = iter_20_1
			var_20_5.skillDescCanvasGroup.alpha = arg_20_0.selectedEquipMo and EquipHelper.detectEquipSkillSuited(arg_20_0.heroMo.heroId, arg_20_0.selectedEquipMo.config.id, arg_20_0.selectedEquipMo.refineLv) and 1 or 0.45

			UISpriteSetMgr.instance:setCommonSprite(var_20_5._imagebasedesicon, var_20_1)
			gohelper.setActive(var_20_5.itemGo, true)
		end

		for iter_20_2 = #var_20_0 + 1, #arg_20_0.skillDescItems do
			gohelper.setActive(arg_20_0.skillDescItems[iter_20_2].itemGo, false)
		end
	end
end

function var_0_0.onSuccessSetDefaultEquip(arg_21_0)
	GameFacade.showToast(ToastEnum.CharacterEquipSetting2)
	arg_21_0:refreshSetBtn()
end

function var_0_0.refreshSetBtn(arg_22_0)
	if not arg_22_0.selectedEquipMo then
		gohelper.setActive(arg_22_0._btnsetting.gameObject, true)
		ZProj.UGUIHelper.SetGrayscale(arg_22_0._btnsetting.gameObject, true)

		return
	end

	local var_22_0 = arg_22_0.heroMo.defaultEquipUid == arg_22_0.selectedEquipMo.uid

	gohelper.setActive(arg_22_0._btnsetting.gameObject, not var_22_0)
	ZProj.UGUIHelper.SetGrayscale(arg_22_0._btnsetting.gameObject, false)
end

function var_0_0.getSkillNameColor(arg_23_0, arg_23_1)
	local var_23_0 = {
		["0"] = "#FFFFFF",
		["1"] = "#8b704e",
		["5|6"] = "#6b536e",
		["2"] = "#4e607b",
		["3"] = "#476f4b",
		["4"] = "#9b4f4b"
	}

	return string.nilorempty(arg_23_1) and var_23_0["0"] or var_23_0[arg_23_1]
end

function var_0_0.onClose(arg_24_0)
	arg_24_0._simageheroicon:UnLoadImage()
	CharacterController.instance:unregisterCallback(CharacterEvent.DefaultEquipViewEquipSelectChange, arg_24_0.onSelectEquipChange, arg_24_0)
	CharacterController.instance:unregisterCallback(CharacterEvent.successSetDefaultEquip, arg_24_0.onSuccessSetDefaultEquip, arg_24_0)
end

function var_0_0.onDestroyView(arg_25_0)
	arg_25_0._simagebottom:UnLoadImage()
	arg_25_0._simagetop:UnLoadImage()
end

return var_0_0
