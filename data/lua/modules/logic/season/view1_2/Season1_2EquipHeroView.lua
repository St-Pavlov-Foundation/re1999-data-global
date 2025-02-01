module("modules.logic.season.view1_2.Season1_2EquipHeroView", package.seeall)

slot0 = class("Season1_2EquipHeroView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg1")
	slot0._btnequip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/right/#btn_equip")
	slot0._btnopenhandbook = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/right/#btn_openhandbook")
	slot0._btnopenhandbook2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_empty/#btn_openhandbook2")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_empty")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnequip:AddClickListener(slot0._btnequipOnClick, slot0)
	slot0._btnopenhandbook:AddClickListener(slot0._btnhandbookOnClick, slot0)
	slot0._btnopenhandbook2:AddClickListener(slot0._btnhandbookOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnequip:RemoveClickListener()
	slot0._btnopenhandbook:RemoveClickListener()
	slot0._btnopenhandbook2:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._simagebg1:LoadImage(ResUrl.getSeasonIcon("full/hechengye_bj.jpg"))

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animEventWrap = slot0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	slot0._animEventWrap:AddEventListener("switch", slot0.handleSwitchAnimFrame, slot0)

	slot0._goNormalRight = gohelper.findChild(slot0._gonormal, "right")
	slot0._slotItems = {}
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._animEventWrap:RemoveAllEventListener()

	for slot4, slot5 in pairs(slot0._slotItems) do
		gohelper.setActive(slot5.goPos, true)

		if slot5.icon then
			slot5.icon:disposeUI()
			gohelper.destroy(slot5.icon.viewGO)
		end
	end

	if slot0._descItem and slot0._descItem.simageBlackMask then
		slot0._descItem.simageBlackMask:UnLoadImage()
	end

	Activity104EquipController.instance:onCloseView()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Activity104EquipController.instance, Activity104EquipEvent.EquipUpdate, slot0.handleEquipUpdate, slot0)
	slot0:addEventCb(Activity104EquipController.instance, Activity104EquipEvent.EquipChangeCard, slot0.handleEquipCardChanged, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, slot0.handleSaveSucc, slot0)
	Activity104EquipController.instance:onOpenView(slot0.viewParam.actId, slot0.viewParam.group or 1, Activity104EquipItemListModel.MainCharPos, slot0.viewParam.slot or 1)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.refreshUI(slot0)
	slot1 = Activity104EquipItemListModel.instance:getCount() == 0

	gohelper.setActive(slot0._goempty, slot1)
	gohelper.setActive(slot0._goNormalRight, not slot1)
	slot0:refreshDescGroup()
	slot0:refreshSlots()
end

function slot0.handleEquipUpdate(slot0)
	slot0:refreshDescGroup()
	slot0:refreshSlots()
end

function slot0.refreshSlots(slot0)
	for slot4 = 1, Activity104EquipItemListModel.HeroMaxPos do
		slot0:refreshSlot(slot4)
	end
end

function slot0.refreshSlot(slot0, slot1)
	gohelper.setActive(slot0:getOrCreateSlot(slot1).goSelect, false)

	if Activity104EquipItemListModel.instance.curEquipMap[slot1] == Activity104EquipItemListModel.EmptyUid then
		gohelper.setActive(slot2.goPos, false)
		gohelper.setActive(slot2.goEmpty, true)
		gohelper.setActive(slot2.goRareEffect, false)
	else
		gohelper.setActive(slot2.goPos, true)
		gohelper.setActive(slot2.goRareEffect, true)
		gohelper.setActive(slot2.goEmpty, false)

		if Activity104EquipItemListModel.instance:getEquipMO(slot3) then
			slot0:getOrCreateSlotIcon(slot2):updateData(slot5.itemId)
		end
	end
end

function slot0.refreshDescGroup(slot0)
	slot1 = Activity104EquipItemListModel.instance.curPos

	slot0:refreshDesc(slot0:getOrCreateDesc(), Activity104EquipItemListModel.instance.curEquipMap[Activity104EquipItemListModel.instance.curSelectSlot])
end

function slot0.refreshDesc(slot0, slot1, slot2)
	if slot2 == Activity104EquipItemListModel.EmptyUid then
		gohelper.setActive(slot1.go, false)
	else
		gohelper.setActive(slot1.go, true)
		slot1.simageBlackMask:LoadImage(ResUrl.getSeasonIcon("black4.png"))

		if Activity104EquipItemListModel.instance:getEquipMO(slot2) then
			if SeasonConfig.instance:getSeasonEquipCo(slot3.itemId) then
				slot1.txtName.text = string.format("[%s]", slot4.name)
				slot5 = SeasonEquipMetaUtils.getCareerColorDarkBg(slot3.itemId)

				slot0:refreshProps(slot4, slot1, slot5)
				slot0:refreshSkills(slot4, slot1, slot5)
			else
				logError(string.format("can't find season equip config, id = [%s]", slot3.itemId))
			end
		else
			logError(string.format("can't find season equip MO, itemUid = [%s]", slot2))
		end
	end
end

function slot0.refreshProps(slot0, slot1, slot2, slot3)
	slot4 = {}
	slot5 = false

	if slot1 and slot1.attrId ~= 0 then
		for slot10, slot11 in ipairs(SeasonEquipMetaUtils.getEquipPropsStrList(slot1.attrId)) do
			slot12 = slot0:getOrCreatePropText(slot10, slot2)

			gohelper.setActive(slot12.go, true)

			slot12.txtDesc.text = slot11

			SLFramework.UGUI.GuiHelper.SetColor(slot12.txtDesc, slot3)

			slot4[slot12] = true
			slot5 = true
		end
	end

	for slot9, slot10 in pairs(slot2.propItems) do
		if not slot4[slot10] then
			gohelper.setActive(slot10.go, false)
		end
	end

	gohelper.setActive(slot2.goAttrParent, slot5)
end

function slot0.refreshSkills(slot0, slot1, slot2, slot3)
	slot5 = {
		[slot11] = true
	}

	for slot9, slot10 in ipairs(SeasonEquipMetaUtils.getSkillEffectStrList(slot1)) do
		slot11 = slot0:getOrCreateSkillText(slot9, slot2)

		gohelper.setActive(slot11.go, true)

		slot11.txtDesc.text = slot10

		SLFramework.UGUI.GuiHelper.SetColor(slot11.txtDesc, slot3)
	end

	for slot9, slot10 in pairs(slot2.skillItems) do
		if not slot5[slot10] then
			gohelper.setActive(slot10.go, false)
		end
	end
end

function slot0.getOrCreatePropText(slot0, slot1, slot2)
	if not slot2.propItems[slot1] then
		slot3 = slot0:getUserDataTb_()
		slot3.go = gohelper.cloneInPlace(slot2.goAttrDesc, "propname_" .. tostring(slot1))
		slot3.txtDesc = gohelper.findChildText(slot3.go, "txt_attributedesc")
		slot2.propItems[slot1] = slot3
	end

	return slot3
end

function slot0.getOrCreateSkillText(slot0, slot1, slot2)
	if not slot2.skillItems[slot1] then
		slot3 = slot0:getUserDataTb_()
		slot3.go = gohelper.cloneInPlace(slot2.goSkillDesc, "skill_" .. tostring(slot1))
		slot3.txtDesc = gohelper.findChildText(slot3.go, "txt_skilldesc")
		slot2.skillItems[slot1] = slot3
	end

	return slot3
end

function slot0.getOrCreateSlot(slot0, slot1)
	if not slot0._slotItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.findChild(slot0.viewGO, "#go_normal/left/equipSlot/slot" .. tostring(slot1))
		slot2.goEmpty = gohelper.findChild(slot2.go, "go_empty")
		slot2.goPos = gohelper.findChild(slot2.go, "go_equip/go_pos")
		slot2.goSelect = gohelper.findChild(slot2.go, "go_equip/go_select")
		slot2.goRareEffect = gohelper.findChild(slot2.go, "go_rareeffect")
		slot0._slotItems[slot1] = slot2
	end

	return slot2
end

function slot0.getOrCreateSlotIcon(slot0, slot1)
	if not slot1.icon then
		slot1.icon = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot1.goPos, "icon"), Season1_2CelebrityCardEquip)
	end

	return slot2
end

function slot0.getOrCreateDesc(slot0)
	if not slot0._descItem then
		slot1 = slot0:getUserDataTb_()
		slot1.go = gohelper.findChild(slot0.viewGO, "#go_normal/left/equipDesc/#go_equipDesc")
		slot1.goEffect = gohelper.findChild(slot1.go, "#go_effect")
		slot1.txtName = gohelper.findChildText(slot1.go, "#go_effect/txt_name")
		slot1.txtDesc = gohelper.findChildText(slot1.go, "#go_effect/scroll_desc/Viewport/#txt_desc")
		slot1.goAttrDesc = gohelper.findChild(slot1.go, "#go_effect/scroll_desc/Viewport/Content/attrlist/#go_attributeitem")
		slot1.goSkillDesc = gohelper.findChild(slot1.go, "#go_effect/scroll_desc/Viewport/Content/skilldesc/#go_skilldescitem")
		slot1.goAttrParent = gohelper.findChild(slot1.go, "#go_effect/scroll_desc/Viewport/Content/attrlist")
		slot1.simageBlackMask = gohelper.findChildSingleImage(slot1.go, "#go_effect/simage_blackmask")
		slot1.propItems = {}
		slot1.skillItems = {}
		slot0._descItem = slot1
	end

	return slot1
end

function slot0.handleSaveSucc(slot0, slot1)
	if slot1 == ModuleEnum.HeroGroupType.Season and slot0._isManualSave then
		GameFacade.showToast(Activity104EquipController.Toast_Save_Succ)
		slot0:closeThis()
	end
end

function slot0.handleSwitchAnimFrame(slot0)
	logNormal("refresh by switch anim frame")
	slot0:refreshSlots()
	slot0:refreshDescGroup()
end

function slot0.handleEquipCardChanged(slot0, slot1)
	slot0._animator:Play("switch", 0, 0)
end

function slot0._btnequipOnClick(slot0)
	slot0._isManualSave = Activity104EquipController.instance:saveShowSlot()
end

function slot0._btnhandbookOnClick(slot0)
	ViewMgr.instance:openView(ViewName.Season1_2EquipBookView, {
		actId = slot0.viewParam.actId
	})
end

return slot0
