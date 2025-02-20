module("modules.logic.equip.view.EquipInfoView", package.seeall)

slot0 = class("EquipInfoView", BaseView)

function slot0.onInitView(slot0)
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "#go_progress")
	slot0._txtcurlevel = gohelper.findChildText(slot0.viewGO, "#go_progress/#txt_curlevel")
	slot0._txttotallevel = gohelper.findChildText(slot0.viewGO, "#go_progress/#txt_curlevel/#txt_totallevel")
	slot0._goinsigt = gohelper.findChild(slot0.viewGO, "#go_progress/#txt_curlevel/go_insigt")
	slot0._image1 = gohelper.findChildImage(slot0.viewGO, "#go_progress/#txt_curlevel/go_insigt/#image_1")
	slot0._image2 = gohelper.findChildImage(slot0.viewGO, "#go_progress/#txt_curlevel/go_insigt/#image_2")
	slot0._image3 = gohelper.findChildImage(slot0.viewGO, "#go_progress/#txt_curlevel/go_insigt/#image_3")
	slot0._image4 = gohelper.findChildImage(slot0.viewGO, "#go_progress/#txt_curlevel/go_insigt/#image_4")
	slot0._image5 = gohelper.findChildImage(slot0.viewGO, "#go_progress/#txt_curlevel/go_insigt/#image_5")
	slot0._imagelock = gohelper.findChildImage(slot0.viewGO, "#go_progress/#image_lock")
	slot0._goType = gohelper.findChild(slot0.viewGO, "layout/type")
	slot0._goTypeItem = gohelper.findChild(slot0.viewGO, "layout/type/#go_typeItem")
	slot0._goattribute = gohelper.findChild(slot0.viewGO, "layout/attribute")
	slot0._gostrengthenattr = gohelper.findChild(slot0.viewGO, "layout/attribute/container/#go_strengthenattr")
	slot0._gobreakeffect = gohelper.findChild(slot0.viewGO, "layout/attribute/container/#go_breakeffect")
	slot0._goSkill = gohelper.findChild(slot0.viewGO, "layout/#go_skill")
	slot0._txtattributelv = gohelper.findChildText(slot0.viewGO, "layout/#go_skill/attributename/#txt_attributelv")
	slot0._goSkillContainer = gohelper.findChild(slot0.viewGO, "layout/#go_skill")
	slot0._goSkillItem = gohelper.findChild(slot0.viewGO, "layout/#go_skill/#scroll_desccontainer/Viewport/#go_skillContainer/#go_SkillItem")
	slot0._gotip = gohelper.findChild(slot0.viewGO, "#go_tip")
	slot0._btnmaxlevel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_maxlevel")
	slot0._imagemaxleveltip = gohelper.findChildImage(slot0.viewGO, "#btn_maxlevel")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnmaxlevel:AddClickListener(slot0._onClickMaxLevelBtn, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnmaxlevel:RemoveClickListener()
end

function slot0._onClickMaxLevelBtn(slot0)
	slot0._showMax = not slot0._showMax

	slot0._animator:Play("switch", 0, 0)
	slot0:refreshMaxLevelImage(0)

	if slot0._hadEquip then
		if slot0._showMax then
			slot0._equipMO = EquipHelper.createMaxLevelEquipMo(slot0._equipId, slot0._equipMO.id)
		else
			slot0._equipMO = slot0.viewContainer.viewParam.equipMO
		end
	elseif slot0._showMax then
		slot0._equipMO = EquipHelper.createMaxLevelEquipMo(slot0._equipId)
	else
		slot0._equipMO = EquipHelper.createMinLevelEquipMo(slot0._equipId)
	end

	slot0:refreshUI()
end

function slot0._editableInitView(slot0)
	slot0.strengthenAttrItemList = {}
	slot0.tagItemList = {}
	slot0.skillItemList = {}

	gohelper.setActive(slot0._gostrengthenattr, false)
	gohelper.setActive(slot0._goSkillItem, false)
	gohelper.setActive(slot0._goTypeItem, false)

	slot0._click = gohelper.getClickWithAudio(slot0._imagelock.gameObject)

	slot0._click:AddClickListener(slot0._onClick, slot0)
	gohelper.addUIClickAudio(slot0._btnmaxlevel.gameObject, AudioEnum.UI.play_ui_admission_open)

	slot0.imageBreakIcon = gohelper.findChildImage(slot0._gobreakeffect, "image_icon")
	slot0.txtBreakAttrName = gohelper.findChildText(slot0._gobreakeffect, "txt_name")
	slot0.txtBreakValue = gohelper.findChildText(slot0._gobreakeffect, "txt_value")
	slot0._animator = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.Animator))
	slot0.txtTitle = gohelper.findChildText(slot0.viewGO, "layout/#go_skill/attributename/txttitle")
	slot0._btnMaxLevelAnim = gohelper.onceAddComponent(slot0._btnmaxlevel.gameObject, typeof(UnityEngine.Animator))
end

function slot0._onHyperLinkClick(slot0)
	EquipController.instance:openEquipSkillTipView({
		slot0._equipMO,
		slot0._equipId,
		true
	})
end

function slot0._onClick(slot0)
	slot0._lock = not slot0._lock

	UISpriteSetMgr.instance:setEquipSprite(slot0._imagelock, slot0._lock and "xinxiang_suo" or "xinxiang_jiesuo", false)
	EquipRpc.instance:sendEquipLockRequest(slot0._equipMO.id, slot0._lock)

	if slot0._lock then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Lock)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Unlock)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._equipMO = slot0.viewContainer.viewParam.equipMO
	slot0._equipId = slot0._equipMO and slot0._equipMO.config.id or slot0.viewContainer.viewParam.equipId
	slot0._hadEquip = true

	if not slot0._equipMO and slot0._equipId then
		slot0._hadEquip = false
		slot0._equipMO = EquipHelper.createMinLevelEquipMo(slot0._equipId)
	end

	slot0._config = slot0._equipMO.config
	slot0._heroId = EquipTeamListModel.instance:getHero() and slot1.heroId
	slot0._isNormalEquip = EquipHelper.isNormalEquip(slot0._config)

	gohelper.setActive(slot0._btnmaxlevel.gameObject, slot0._isNormalEquip)

	slot0._showMax = false
	slot0._lock = slot0._equipMO.isLock

	gohelper.setActive(slot0._imagelock.gameObject, slot0._hadEquip and slot0._isNormalEquip)

	if slot0._hadEquip and slot0._isNormalEquip then
		UISpriteSetMgr.instance:setEquipSprite(slot0._imagelock, slot0._lock and "xinxiang_suo" or "xinxiang_jiesuo", false)
	end

	gohelper.setActive(slot0._goprogress, slot0._isNormalEquip)
	gohelper.setActive(slot0._goattribute, slot0._isNormalEquip)
	gohelper.setActive(slot0._txtattributelv.gameObject, slot0._isNormalEquip)
	slot0:refreshMaxLevelImage(1)
	slot0:refreshTxtTitle()
	slot0:refreshUI()

	if slot0.viewContainer:getIsOpenLeftBackpack() then
		slot0.viewContainer.equipView:showTitleAndCenter()
	end

	slot0._animator:Play(UIAnimationName.Open)
end

function slot0.refreshMaxLevelImage(slot0, slot1)
	slot0._btnMaxLevelAnim:Play(slot0._showMax and "open" or "close", 0, slot1)
end

function slot0.refreshTxtTitle(slot0)
	if EquipHelper.isExpEquip(slot0._config) then
		slot0.txtTitle.text = luaLang("p_equipinfo_exp_title")
	elseif EquipHelper.isRefineUniversalMaterials(slot0._config.id) or EquipHelper.isSpRefineEquip(slot0._config) then
		slot0.txtTitle.text = luaLang("p_equipinfo_refine_title")
	else
		slot0.txtTitle.text = luaLang("p_equipinfo_normal_title")
	end
end

function slot0.refreshUI(slot0)
	slot0:refreshTag()
	slot0:refreshBaseAttr()

	if not slot0._isNormalEquip or slot0._isNormalEquip and EquipConfig.instance:getNotShowRefineRare() < slot0._equipMO.config.rare then
		gohelper.setActive(slot0._goSkillContainer, true)

		slot0._txtattributelv.text = slot0._equipMO.refineLv

		slot0:refreshSkillDesc()
	else
		gohelper.setActive(slot0._goSkillContainer, false)
	end

	slot0:showProgress()
end

function slot0.refreshTag(slot0)
	if string.nilorempty(slot0._config.tag) then
		gohelper.setActive(slot0._goType, false)

		return
	end

	gohelper.setActive(slot0._goType, true)

	slot3 = nil

	for slot7, slot8 in ipairs(EquipConfig.instance:getTagList(slot0._config)) do
		if not slot0.tagItemList[slot7] then
			slot3 = slot0:getUserDataTb_()
			slot3.go = gohelper.cloneInPlace(slot0._goTypeItem)
			slot3.txt = slot3.go:GetComponent(gohelper.Type_TextMesh)

			table.insert(slot0.tagItemList, slot3)
		end

		gohelper.setActive(slot3.go, true)

		slot3.txt.text = EquipConfig.instance:getTagName(slot8)
	end

	for slot7 = #slot2 + 1, #slot0.tagItemList do
		gohelper.setActive(slot0.tagItemList[slot7].go, false)
	end
end

function slot0.refreshBaseAttr(slot0)
	slot1, slot2 = nil

	if slot0._equipMO then
		slot1, slot2 = EquipConfig.instance:getEquipNormalAttr(slot0._equipId, slot0._equipMO.level, HeroConfig.sortAttrForEquipView)
	else
		slot1, slot2 = EquipConfig.instance:getMaxEquipNormalAttr(slot0._equipId, HeroConfig.sortAttrForEquipView)
	end

	slot3 = nil

	for slot7, slot8 in ipairs(slot2) do
		if not slot0.strengthenAttrItemList[slot7] then
			slot3 = slot0:getUserDataTb_()
			slot3.go = gohelper.cloneInPlace(slot0._gostrengthenattr)
			slot3.icon = gohelper.findChildImage(slot3.go, "image_icon")
			slot3.name = gohelper.findChildText(slot3.go, "txt_name")
			slot3.value = gohelper.findChildText(slot3.go, "txt_value")
			slot3.goBg = gohelper.findChild(slot3.go, "go_bg")

			table.insert(slot0.strengthenAttrItemList, slot3)
		end

		gohelper.setActive(slot3.go, true)
		gohelper.setActive(slot3.goBg, slot7 % 2 == 0)

		slot9 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(slot8.attrType))

		UISpriteSetMgr.instance:setCommonSprite(slot3.icon, "icon_att_" .. slot9.id)

		slot3.name.text = slot9.name
		slot3.value.text = slot8.value
	end

	for slot7 = #slot2 + 1, #slot0.strengthenAttrItemList do
		gohelper.setActive(slot0.strengthenAttrItemList[slot7].go, false)
	end

	slot4, slot5 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(slot0._config, slot0._equipMO.breakLv)

	if slot4 then
		gohelper.setActive(slot0._gobreakeffect, true)
		UISpriteSetMgr.instance:setCommonSprite(slot0.imageBreakIcon, "icon_att_" .. slot4)

		slot0.txtBreakAttrName.text = EquipHelper.getAttrBreakText(slot4)
		slot0.txtBreakValue.text = EquipHelper.getAttrPercentValueStr(slot5)

		gohelper.setAsLastSibling(slot0._gobreakeffect)
	else
		gohelper.setActive(slot0._gobreakeffect, false)
	end
end

function slot0.refreshSkillDesc(slot0)
	if not next(EquipHelper.getEquipSkillDescList(slot0._config.id, slot0._equipMO.refineLv, "#D9A06F")) then
		gohelper.setActive(slot0._goSkill, false)
	else
		gohelper.setActive(slot0._goSkill, true)

		slot2 = nil

		for slot6, slot7 in ipairs(slot1) do
			if not slot0.skillItemList[slot6] then
				slot2 = slot0:getUserDataTb_()
				slot2.itemGo = gohelper.cloneInPlace(slot0._goSkillItem)
				slot2.txt = gohelper.findChildText(slot2.itemGo, "skill_desc")

				SkillHelper.addHyperLinkClick(slot2.txt)

				slot2.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(slot2.txt.gameObject, FixTmpBreakLine)

				table.insert(slot0.skillItemList, slot2)
			end

			slot2.txt.text = EquipHelper.getEquipSkillDesc(slot7)

			slot2.fixTmpBreakLine:refreshTmpContent(slot2.txt)
			gohelper.setActive(slot2.itemGo, true)
		end

		for slot6 = #slot1 + 1, #slot0.skillItemList do
			gohelper.setActive(slot0.skillItemList[slot6].itemGo, false)
		end
	end
end

function slot0.showProgress(slot0)
	if slot0._showMax then
		for slot4 = 1, 5 do
			UISpriteSetMgr.instance:setEquipSprite(slot0["_image" .. slot4], "bg_xinxiang_dengji")
		end

		gohelper.setActive(slot0._txttotallevel.gameObject, false)
	elseif slot0._isNormalEquip then
		slot0._txttotallevel.text = string.format("/%s", EquipConfig.instance:getCurrentBreakLevelMaxLevel(slot0._equipMO))
		slot4 = true

		gohelper.setActive(slot0._txttotallevel.gameObject, slot4)

		for slot4 = 1, 5 do
			UISpriteSetMgr.instance:setEquipSprite(slot0["_image" .. slot4], slot4 <= slot0._equipMO.refineLv and "bg_xinxiang_dengji" or "bg_xinxiang_dengji_dis")
		end
	else
		gohelper.setActive(slot0._txttotallevel.gameObject, false)
	end

	slot0._txtcurlevel.text = slot0._equipMO.level

	gohelper.setActive(slot0._gotip, slot0._showMax and not EquipHelper.isConsumableEquip(slot0._equipMO.equipId))
end

function slot0.onOpenFinish(slot0)
end

function slot0.onClose(slot0)
	slot0:playCloseAnimation()
end

function slot0.playCloseAnimation(slot0)
	slot0._animator:Play(UIAnimationName.Close)
end

function slot0.onDestroyView(slot0)
	if slot0._itemList then
		for slot4, slot5 in ipairs(slot0._itemList) do
			slot5:destroyView()
		end
	end

	slot0._click:RemoveClickListener()

	slot0.strengthenAttrItemList = nil
	slot0.tagItemList = nil
	slot0.skillItemList = nil
end

return slot0
