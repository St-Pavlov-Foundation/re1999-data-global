module("modules.logic.equip.view.EquipInfoTipsView", package.seeall)

slot0 = class("EquipInfoTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_container")
	slot0._simageframe = gohelper.findChildSingleImage(slot0.viewGO, "#go_container/#simage_frame")
	slot0._txtlv = gohelper.findChildText(slot0.viewGO, "#go_container/top/name/lv/#txt_lv")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_container/top/name/#txt_name")
	slot0._goequipitem = gohelper.findChild(slot0.viewGO, "#go_container/top/#go_equipitem")
	slot0._simageequipicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_container/top/#go_equipitem/#simage_equipicon")
	slot0._imagelock = gohelper.findChildImage(slot0.viewGO, "#go_container/top/#image_lock")
	slot0._golockicon = gohelper.findChild(slot0.viewGO, "#go_container/top/#image_lock/#go_lockicon")
	slot0._gostrengthenattr = gohelper.findChild(slot0.viewGO, "#go_container/scroll_view/Viewport/center/attribute/#go_strengthenattr")
	slot0._gobreakeffect = gohelper.findChild(slot0.viewGO, "#go_container/scroll_view/Viewport/center/attribute/#go_breakeffect")
	slot0._gosuitattribute = gohelper.findChild(slot0.viewGO, "#go_container/scroll_view/Viewport/center/#go_suitattribute")
	slot0._txtattributelv = gohelper.findChildText(slot0.viewGO, "#go_container/scroll_view/Viewport/center/#go_suitattribute/attributename/#txt_attributelv")
	slot0._gosuiteffect = gohelper.findChild(slot0.viewGO, "#go_container/scroll_view/Viewport/center/#go_suitattribute/#go_suiteffect")
	slot0._gobaseskill = gohelper.findChild(slot0.viewGO, "#go_container/scroll_view/Viewport/center/#go_suitattribute/#go_suiteffect/#go_baseskill")
	slot0._txtsuiteffect2 = gohelper.findChildText(slot0.viewGO, "#go_container/scroll_view/Viewport/center/#go_suitattribute/#go_suiteffect/#go_baseskill/suiteffect2/#txt_suiteffect2")
	slot0._goskillpos = gohelper.findChild(slot0.viewGO, "#go_container/#go_skillpos")

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

function slot0.onLockClick(slot0)
	slot0.isLock = not slot0.isLock

	if slot0.isLock then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Lock)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Unlock)
	end

	EquipRpc.instance:sendEquipLockRequest(slot0.equipMo.id, slot0.isLock)
end

function slot0.onLockChangeReply(slot0)
	slot0:refreshLockUI()
end

function slot0._editableInitView(slot0)
	slot0._goSuitEffectItem = gohelper.findChild(slot0.viewGO, "#go_container/scroll_view/Viewport/center/#go_suitattribute/#go_suiteffect/#go_advanceskill/suiteffect")
	slot0._goBaseSkillCanvasGroup = slot0._gobaseskill:GetComponent(gohelper.Type_CanvasGroup)

	gohelper.setActive(slot0._gostrengthenattr, false)
	gohelper.setActive(slot0._txtsuiteffect2.gameObject, false)
	slot0:changeViewGoPosition()

	slot0.lockClick = gohelper.getClick(slot0._golockicon)

	slot0.lockClick:AddClickListener(slot0.onLockClick, slot0)

	slot0.attrGoList = {}
	slot0._txtDescList = {}
	slot0.imageBreakIcon = gohelper.findChildImage(slot0._gobreakeffect, "image_icon")
	slot0.txtBreakAttrName = gohelper.findChildText(slot0._gobreakeffect, "txt_name")
	slot0.txtBreakValue = gohelper.findChildText(slot0._gobreakeffect, "txt_value")

	slot0:addEventCb(EquipController.instance, EquipEvent.onEquipLockChange, slot0.onLockChangeReply, slot0)
	slot0._simageframe:LoadImage(ResUrl.getEquipBg("bg_tips.png"))

	slot0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)
end

function slot0.onUpdateParam(slot0)
	if slot0.viewParam.equipMo.id == slot0.equipMo.id then
		return
	end

	slot0.animatorPlayer:Play(UIAnimationName.Close, function (slot0)
		slot0:onOpen()
		slot0.animatorPlayer:Play(UIAnimationName.Open)
	end, slot0)
end

function slot0.onOpen(slot0)
	slot0.equipMo = slot0.viewParam.equipMo
	slot0.isLock = slot0.equipMo.isLock
	slot0.heroCo = slot0.viewParam.heroCo

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0._txtname.text = slot0.equipMo.config.name
	slot0._txtlv.text = slot0.equipMo.level

	slot0._simageequipicon:LoadImage(ResUrl.getEquipSuit(slot0.equipMo.config.icon))
	slot0:refreshLockUI()
	slot0:refreshAttributeInfo()

	if EquipConfig.instance:getNotShowRefineRare() < slot0.equipMo.config.rare then
		gohelper.setActive(slot0._gosuitattribute, true)
		slot0:refreshSkillInfo()
	else
		gohelper.setActive(slot0._gosuitattribute, false)
	end
end

function slot0.refreshLockUI(slot0)
	if slot0.viewParam.notShowLockIcon or EquipHelper.isSpRefineEquip(slot0.equipMo.config) then
		gohelper.setActive(slot0._imagelock.gameObject, false)

		return
	end

	UISpriteSetMgr.instance:setEquipSprite(slot0._imagelock, slot0.isLock and "bg_tips_suo" or "bg_tips_jiesuo", false)
end

function slot0.refreshAttributeInfo(slot0)
	slot1, slot2 = EquipConfig.instance:getEquipNormalAttr(slot0.equipMo.config.id, slot0.equipMo.level, HeroConfig.sortAttrForEquipView)
	slot3 = nil

	for slot7, slot8 in ipairs(slot2) do
		if not slot0.attrGoList[slot7] then
			slot3 = slot0:getUserDataTb_()
			slot9 = gohelper.cloneInPlace(slot0._gostrengthenattr, "attr" .. slot7)
			slot3.go = slot9
			slot3.bg = gohelper.findChild(slot9, "bg")
			slot3.icon = gohelper.findChildImage(slot9, "image_icon")
			slot3.name = gohelper.findChildText(slot9, "txt_name")
			slot3.attr_value = gohelper.findChildText(slot9, "txt_value")

			table.insert(slot0.attrGoList, slot3)
		end

		UISpriteSetMgr.instance:setCommonSprite(slot3.icon, "icon_att_" .. HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(slot8.attrType)).id)
		gohelper.setActive(slot3.bg, slot7 % 2 == 0)

		slot3.name.text = slot9.name
		slot3.attr_value.text = slot8.value

		gohelper.setActive(slot3.go, true)
	end

	for slot7 = #slot2 + 1, #slot0.attrGoList do
		gohelper.setActive(slot0.attrGoList[slot7].go, false)
	end

	slot4, slot5 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(slot0.equipMo.config, slot0.equipMo.breakLv)

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

function slot0.refreshSkillInfo(slot0)
	if #EquipHelper.getEquipSkillDescList(slot0.equipMo.config.id, slot0.equipMo.refineLv, "#975129") == 0 then
		gohelper.setActive(slot0._gobaseskill, false)
	else
		slot0._txtattributelv.text = slot0.equipMo.refineLv

		gohelper.setActive(slot0._gobaseskill, true)

		slot2, slot3, slot4 = nil

		for slot8, slot9 in ipairs(slot1) do
			if not slot0._txtDescList[slot8] then
				slot3 = slot0:getUserDataTb_()
				slot4 = gohelper.cloneInPlace(slot0._txtsuiteffect2.gameObject, "item_" .. slot8)
				slot3.itemGo = slot4
				slot3.txt = slot4:GetComponent(gohelper.Type_TextMesh)
				slot3.imagepoint = gohelper.findChildImage(slot4, "#image_point")

				table.insert(slot0._txtDescList, slot3)
			end

			slot2.txt.text = slot9

			gohelper.setActive(slot2.itemGo, true)
		end

		for slot8 = #slot1 + 1, #slot0._txtDescList do
			gohelper.setActive(slot0._txtDescList[slot8].itemGo, false)
		end
	end
end

function slot0.changeViewGoPosition(slot0)
	recthelper.setWidth(slot0.viewGO.transform, recthelper.getWidth(slot0.viewGO.transform.parent) / 2 - 100)

	slot0.viewGO.transform.anchorMin = Vector2(1, 0.5)
	slot0.viewGO.transform.anchorMax = Vector2(1, 0.5)

	recthelper.setAnchor(slot0.viewGO.transform, 0, 0)
end

function slot0.onClose(slot0)
	slot0.lockClick:RemoveClickListener()
end

function slot0.onDestroyView(slot0)
	slot0._simageframe:UnLoadImage()
	slot0._simageequipicon:UnLoadImage()
end

return slot0
