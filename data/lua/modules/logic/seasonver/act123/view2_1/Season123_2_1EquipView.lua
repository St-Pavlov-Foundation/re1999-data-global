module("modules.logic.seasonver.act123.view2_1.Season123_2_1EquipView", package.seeall)

slot0 = class("Season123_2_1EquipView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg1")
	slot0._simagehero = gohelper.findChildSingleImage(slot0.viewGO, "left/hero/mask/#simage_hero")
	slot0._golackcards = gohelper.findChild(slot0.viewGO, "right/#go_lackcards")
	slot0._btnequip = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/btncontain/#btn_equip")
	slot0._btnopenhandbook = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/btncontain/#btn_openhandbook")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "left/equipDesc/#go_empty")
	slot0._gotipPos = gohelper.findChild(slot0.viewGO, "#go_tippos")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnequip:AddClickListener(slot0._btnequipOnClick, slot0)
	slot0._btnopenhandbook:AddClickListener(slot0._btnhandbookOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnequip:RemoveClickListener()
	slot0._btnopenhandbook:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._simagebg1:LoadImage(ResUrl.getSeasonIcon("full/hechengye_bj.jpg"))

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animEventWrap = slot0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	slot0._animEventWrap:AddEventListener("switch", slot0.handleSwitchAnimFrame, slot0)

	slot0._slotItems = {}
	slot0._descItems = {}
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simagehero:UnLoadImage()
	slot0._animEventWrap:RemoveAllEventListener()

	for slot4, slot5 in pairs(slot0._slotItems) do
		slot5.btnClick:RemoveClickListener()
		gohelper.setActive(slot5.goPos, true)

		if slot5.icon then
			slot5.icon:disposeUI()
			gohelper.destroy(slot5.icon.viewGO)
		end

		if slot5.animEventWrap then
			slot5.animEventWrap:RemoveAllEventListener()
		end
	end

	Season123EquipController.instance:onCloseView()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Season123EquipController.instance, Season123EquipEvent.EquipUpdate, slot0.handleEquipUpdate, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, slot0.handleSaveSucc, slot0)
	slot0:addEventCb(Season123EquipController.instance, Season123EquipEvent.EquipChangeCard, slot0.handleEquipCardChanged, slot0)
	slot0:addEventCb(Season123EquipController.instance, Season123EquipEvent.EquipChangeSlot, slot0.handleEquipSlotChanged, slot0)
	Season123EquipController.instance:onOpenView(slot0.viewParam.actId, slot0.viewParam.group or 1, slot0.viewParam.stage, slot0.viewParam.layer, slot0.viewParam.pos or 1, slot0.viewParam.slot or 1)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._golackcards, not Season123EquipItemListModel.instance:getList() or #slot1 == 0)
	slot0:refreshSlots()
	slot0:refreshDescGroup()
end

function slot0.handleEquipUpdate(slot0)
	slot0:refreshSlots()
	slot0:refreshDescGroup()
end

function slot0.refreshSlots(slot0)
	slot1 = true

	for slot5 = 1, Season123EquipItemListModel.MaxPos do
		if Season123EquipItemListModel.instance.curEquipMap[slot5] ~= Season123EquipItemListModel.EmptyUid then
			slot1 = false
		end

		slot0:refreshSlot(slot5)
	end

	gohelper.setActive(slot0._goempty, slot1)
end

function slot0.refreshSlot(slot0, slot1)
	slot2 = slot0:getOrCreateSlot(slot1)

	if Season123EquipItemListModel.instance:getShowUnlockSlotCount() < slot1 then
		gohelper.setActive(slot2.go, false)

		return
	end

	gohelper.setActive(slot2.go, true)
	gohelper.setActive(slot2.goSelect, Season123EquipItemListModel.instance.curSelectSlot == slot1)

	slot5 = not Season123EquipItemListModel.instance:isEquipCardPosUnlock(slot1, Season123EquipItemListModel.instance.curPos)

	gohelper.setActive(slot2.goBtnAdd, not slot5)
	gohelper.setActive(slot2.goLock, slot5)

	if Season123EquipItemListModel.instance.curEquipMap[slot1] == Season123EquipItemListModel.EmptyUid then
		gohelper.setActive(slot2.goPos, false)
		gohelper.setActive(slot2.goEmpty, true)

		if Season123EquipItemListModel.instance:curMapIsTrialEquipMap() then
			gohelper.setActive(slot2.go, false)
		end
	else
		gohelper.setActive(slot2.goPos, true)
		gohelper.setActive(slot2.goEmpty, false)

		if Season123EquipItemListModel.instance:getEquipMO(slot4) then
			slot0:getOrCreateSlotIcon(slot2):updateData(slot7.itemId)
		elseif Season123EquipItemListModel.isTrialEquip(slot4) then
			slot6:updateData(string.splitToNumber(slot4, "#")[1])
		end

		slot6:setIndexLimitShowState(true)
	end
end

slot0.MaxUISlot = 2

function slot0.refreshDescGroup(slot0)
	for slot4 = 1, uv0.MaxUISlot do
		if not string.nilorempty(Season123EquipItemListModel.instance.curEquipMap[slot4]) then
			slot0:refreshDesc(slot0:getOrCreateDesc(slot4), slot5, slot4)
		end
	end
end

function slot0.refreshDesc(slot0, slot1, slot2, slot3)
	if gohelper.isNil(slot1.go) then
		return
	end

	if slot2 == Season123EquipItemListModel.EmptyUid then
		gohelper.setActive(slot1.go, false)
	else
		gohelper.setActive(slot1.go, true)

		if not (Season123EquipItemListModel.instance:getEquipMO(slot2) and slot4.itemId) and Season123EquipItemListModel.isTrialEquip(slot2) then
			slot5 = string.splitToNumber(slot2, "#")[1]
		end

		if slot5 then
			if Season123Config.instance:getSeasonEquipCo(slot5) then
				slot1.txtName.text = string.format("[%s]", slot6.name)
				slot7 = nil

				if Season123EquipItemListModel.instance.curSelectSlot ~= slot3 then
					slot8 = Season123EquipMetaUtils.getCareerColorDarkBg(slot5) .. Season123EquipMetaUtils.No_Effect_Alpha
					slot7 = "#cac8c5" .. Season123EquipMetaUtils.No_Effect_Alpha
				else
					slot7 = "#ec7731"
				end

				SLFramework.UGUI.GuiHelper.SetColor(slot1.txtName, slot7)
				slot0:refreshProps(slot6, slot1, slot8)
				slot0:refreshSkills(slot6, slot1, slot8)
			else
				logError(string.format("can't find season equip config, id = [%s]", slot5))
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
		for slot10, slot11 in ipairs(Season123EquipMetaUtils.getEquipPropsStrList(slot1.attrId)) do
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

	for slot9, slot10 in ipairs(Season123EquipMetaUtils.getSkillEffectStrList(slot1)) do
		slot11 = slot0:getOrCreateSkillText(slot9, slot2)

		gohelper.setActive(slot11.go, true)

		slot11.txtDesc.text = SkillHelper.addLink(HeroSkillModel.instance:skillDesToSpot(slot10))

		SkillHelper.addHyperLinkClick(slot11.txtDesc, slot0.setSkillClickCallBack, slot0)
	end

	for slot9, slot10 in pairs(slot2.skillItems) do
		if not slot5[slot10] then
			gohelper.setActive(slot10.go, false)
		end
	end
end

function slot0.setSkillClickCallBack(slot0, slot1, slot2)
	slot3, slot4 = recthelper.getAnchor(slot0._gotipPos.transform)

	CommonBuffTipController:openCommonTipViewWithCustomPos(slot1, Vector2.New(slot3, slot4), CommonBuffTipEnum.Pivot.Left)
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

		SkillHelper.addHyperLinkClick(slot3.txtDesc)

		slot2.skillItems[slot1] = slot3
	end

	return slot3
end

function slot0.getOrCreateSlot(slot0, slot1)
	if not slot0._slotItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.index = slot1
		slot2.mainView = slot0
		slot2.go = gohelper.findChild(slot0.viewGO, "left/equipSlot/slot" .. tostring(slot1))
		slot2.goPos = gohelper.findChild(slot2.go, "go_equip/go_pos")
		slot2.goSelect = gohelper.findChild(slot2.go, "go_equip/go_select")
		slot2.goBtnAdd = gohelper.findChild(slot2.go, "go_empty/btn_add")
		slot2.goEmpty = gohelper.findChild(slot2.go, "go_empty")
		slot2.goLock = gohelper.findChild(slot2.go, "go_lock")
		slot2.btnClick = gohelper.findChildButtonWithAudio(slot2.go, "btn_click")

		slot2.btnClick:AddClickListener(slot0.onClickSlot, slot0, slot1)

		slot2.animator = slot2.go:GetComponent(typeof(UnityEngine.Animator))
		slot2.animEventWrap = slot2.go:GetComponent(typeof(ZProj.AnimationEventWrap))

		slot2.animEventWrap:AddEventListener("switch", slot0.handleSlotSwitchAnimFrame, slot2)

		slot0._slotItems[slot1] = slot2
	end

	return slot2
end

function slot0.getOrCreateSlotIcon(slot0, slot1)
	if not slot1.icon then
		slot1.icon = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot1.goPos, "icon"), Season123_2_1CelebrityCardEquip)
	end

	return slot2
end

function slot0.getOrCreateDesc(slot0, slot1)
	if not slot0._descItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.findChild(slot0.viewGO, "left/equipDesc/#go_equipDesc/#go_effect" .. tostring(slot1))
		slot2.txtName = gohelper.findChildText(slot2.go, "txt_name")
		slot2.goAttrDesc = gohelper.findChild(slot2.go, "desc/scroll_desc/Viewport/Content/attrlist/#go_attributeitem" .. tostring(slot1))
		slot2.goSkillDesc = gohelper.findChild(slot2.go, "desc/scroll_desc/Viewport/Content/skilldesc/#go_skilldescitem" .. tostring(slot1))
		slot2.goAttrParent = gohelper.findChild(slot2.go, "desc/scroll_desc/Viewport/Content/attrlist")
		slot2.propItems = {}
		slot2.skillItems = {}
		slot0._descItems[slot1] = slot2
	end

	return slot2
end

function slot0.onClickSlot(slot0, slot1)
	if Season123EquipItemListModel.instance.curSelectSlot ~= slot1 then
		if not Season123EquipItemListModel.instance:slotIsLock(slot1) then
			Season123EquipController.instance:setSlot(slot1)
		else
			GameFacade.showToast(ToastEnum.SeasonEquipUnlock)
		end
	end
end

function slot0.handleSaveSucc(slot0)
	if slot0._isManualSave then
		GameFacade.showToast(Season123EquipController.Toast_Save_Succ)
		slot0:closeThis()
	end
end

function slot0.handleSwitchAnimFrame(slot0)
	slot0:refreshSlots()
	slot0:refreshDescGroup()
end

function slot0.handleSlotSwitchAnimFrame(slot0)
	slot0.mainView:refreshDescGroup()
end

function slot0.handleEquipCardChanged(slot0, slot1)
	slot0:getOrCreateSlot(Season123EquipItemListModel.instance.curSelectSlot).animator:Play(slot1.isNew and "open" or "switch", 0, 0)

	if slot1.unloadSlot then
		slot0:getOrCreateSlot(slot1.unloadSlot).animator:Play("close", 0, 0)
	end

	slot0._animator:Play("switch", 0, 0)
end

function slot0.handleEquipSlotChanged(slot0)
	slot0._animator:Play("switch", 0, 0)
	slot0:refreshSlots()
end

function slot0._btnequipOnClick(slot0)
	slot0._isManualSave = Season123EquipController.instance:checkCanSaveSlot()

	if slot0._isManualSave then
		Season123EquipController.instance:saveShowSlot()
	end
end

function slot0._btnhandbookOnClick(slot0)
	Season123Controller.instance:openSeasonEquipBookView(slot0.viewParam.actId)
end

return slot0
