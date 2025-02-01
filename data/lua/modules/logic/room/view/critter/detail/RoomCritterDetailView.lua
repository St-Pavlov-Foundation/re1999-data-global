module("modules.logic.room.view.critter.detail.RoomCritterDetailView", package.seeall)

slot0 = class("RoomCritterDetailView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._goyoung = gohelper.findChild(slot0.viewGO, "#go_young")
	slot0._gocritteritem = gohelper.findChild(slot0.viewGO, "#go_young/#scroll_critter/viewport/content/#go_critteritem")
	slot0._gocrittericon = gohelper.findChild(slot0.viewGO, "#go_young/#scroll_critter/viewport/content/#go_critteritem/#go_crittericon")
	slot0._godetail = gohelper.findChild(slot0.viewGO, "#go_young/Left/#go_detail")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_young/Left/#go_detail/#txt_name")
	slot0._imagelock = gohelper.findChildImage(slot0.viewGO, "#go_young/Left/#go_detail/#txt_name/#image_lock")
	slot0._imagesort = gohelper.findChildImage(slot0.viewGO, "#go_young/Left/#go_detail/#image_sort")
	slot0._txtsort = gohelper.findChildText(slot0.viewGO, "#go_young/Left/#go_detail/#image_sort/#txt_sort")
	slot0._txttag1 = gohelper.findChildText(slot0.viewGO, "#go_young/Left/#go_detail/tag/#txt_tag1")
	slot0._txttag2 = gohelper.findChildText(slot0.viewGO, "#go_young/Left/#go_detail/tag/#txt_tag2")
	slot0._scrolldes = gohelper.findChildScrollRect(slot0.viewGO, "#go_young/Left/#go_detail/#scroll_des")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "#go_young/Left/#go_detail/#scroll_des/viewport/content/#txt_Desc")
	slot0._scrollbase = gohelper.findChildScrollRect(slot0.viewGO, "#go_young/Left/base/#scroll_base")
	slot0._gobaseitem = gohelper.findChild(slot0.viewGO, "#go_young/Left/base/#scroll_base/viewport/content/#go_baseitem")
	slot0._scrolltipbase = gohelper.findChildScrollRect(slot0.viewGO, "#go_young/Left/base/basetips/#scroll_base")
	slot0._gobasetipsitem = gohelper.findChild(slot0.viewGO, "#go_young/Left/base/basetips/#scroll_base/viewport/content/#go_basetipsitem")
	slot0._scrollskill = gohelper.findChildScrollRect(slot0.viewGO, "#go_young/Left/skill/#scroll_skill")
	slot0._goskillItem = gohelper.findChild(slot0.viewGO, "#go_young/Left/skill/#scroll_skill/viewport/content/#go_skillItem")
	slot0._gocritterlive2d = gohelper.findChild(slot0.viewGO, "#go_young/Right/#go_critterlive2d")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._gostar = gohelper.findChild(slot0.viewGO, "#go_young/Left/#go_detail/starList")
	slot0._gotipbase = gohelper.findChild(slot0.viewGO, "#go_young/Left/base/basetips")
	slot0._goLock = gohelper.findChild(slot0.viewGO, "#go_young/Left/#go_detail/#txt_name/#image_lock")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
	if slot0._lockbtn then
		slot0._lockbtn:RemoveClickListener()
	end
end

function slot0._btnLockOnClick(slot0)
	CritterRpc.instance:sendLockCritterRequest(slot0._critterMo.uid, not slot0._critterMo.lock, slot0.refreshLock, slot0)
end

function slot0._editableInitView(slot0)
	if slot0._goLock then
		slot0._lockbtn = SLFramework.UGUI.UIClickListener.Get(gohelper.findChild(slot0._goLock, "clickarea"))

		slot0._lockbtn:AddClickListener(slot0._btnLockOnClick, slot0)
	end

	slot0._starItem = slot0:getUserDataTb_()

	if slot0._gostar then
		for slot4 = 1, slot0._gostar.transform.childCount do
			slot0._starItem[slot4] = gohelper.findChild(slot0._gostar, "star" .. slot4)
		end
	end
end

function slot0.onOpen(slot0)
	slot0._critterMo = slot0.viewParam.critterMo

	if not slot0._critterMo then
		return
	end

	gohelper.setActive(slot0._gobaseitem.gameObject, false)
	gohelper.setActive(slot0._goskillItem.gameObject, false)

	if slot0._goLock then
		gohelper.setActive(slot0._goLock.gameObject, not slot0.viewParam.isPreview)
	end

	slot0:onRefresh()
	slot0:initAttrInfo()
end

function slot0.onRefresh(slot0)
	if not slot0._critterMo then
		return
	end

	slot0:refreshLock()
	slot0:showInfo()
	slot0:refrshCritterSpine()
	slot0:refreshAttrInfo()
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.showInfo(slot0)
	if not slot0._critterMo then
		return
	end

	slot0._txtname.text = slot0._critterMo:getName()
	slot0._txtsort.text = slot0._critterMo:getCatalogueName()
	slot0._txtDesc.text = slot0._critterMo:getDesc()
	slot0._txttag1.text = luaLang(slot0._critterMo:isMaturity() and "room_critter_adult" or "room_critter_child")

	gohelper.setActive(slot0._txttag2.gameObject, slot0._critterMo:isMutate())

	for slot8, slot9 in ipairs(slot0._starItem) do
		gohelper.setActive(slot9, slot8 <= slot0._critterMo:getDefineCfg().rare + 1)
	end

	slot0:showAttr()
	slot0:showSkill()
end

function slot0.showAttr(slot0)
	slot1 = slot0._critterMo:getAttributeInfos()

	if not slot0._attrItems then
		slot0._attrItems = slot0:getUserDataTb_()
	end

	slot2 = 1

	if slot1 then
		for slot6, slot7 in pairs(slot1) do
			slot8 = slot0:getAttrItem(slot2)
			slot9, slot10 = slot0:getAttrRatioColor()

			slot8:setRatioColor(slot9, slot10)
			slot8:onRefreshMo(slot7, slot2, slot0:getAttrNum(slot6, slot7), slot0:getAttrRatio(slot6, slot7), slot0:getAttrName(slot6, slot7), slot0.attrOnClick, slot0)

			slot2 = slot2 + 1
		end
	end

	for slot6 = 1, #slot0._attrItems do
		gohelper.setActive(slot0._attrItems[slot6].viewGO, slot6 < slot2)
	end
end

function slot0.getAttrNum(slot0, slot1, slot2)
	return slot2:getValueNum()
end

function slot0.getAttrRatio(slot0, slot1, slot2)
	return slot2:getRateStr()
end

function slot0.getAttrName(slot0, slot1, slot2)
	return slot2:getName()
end

function slot0.getAttrItem(slot0, slot1)
	if not slot0._attrItems[slot1] then
		slot0._attrItems[slot1] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._gobaseitem), RoomCritterDetailAttrItem)
	end

	return slot2
end

function slot0.showSkill(slot0)
	slot1 = slot0._critterMo:getSkillInfo()

	if not slot0._skillItems then
		slot0._skillItems = slot0:getUserDataTb_()
	end

	slot2 = 1

	if slot1 then
		for slot6, slot7 in pairs(slot1) do
			if CritterConfig.instance:getCritterTagCfg(slot7) and slot8.type == uv0._exclusiveSkill then
				slot0:getSkillItem(slot2):onRefreshMo(slot8, slot2)

				slot2 = slot2 + 1
			end
		end
	end

	if slot0._skillItems then
		for slot6 = 1, #slot0._skillItems do
			gohelper.setActive(slot0._skillItems[slot6].viewGO, slot6 < slot2)
		end
	end
end

function slot0.getSkillItem(slot0, slot1)
	if not slot0._skillItems[slot1] then
		slot0._skillItems[slot1] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._goskillItem), RoomCritterDetailSkillItem)
	end

	return slot2
end

function slot0.refreshLock(slot0)
	if not slot0.viewParam.isPreview then
		UISpriteSetMgr.instance:setEquipSprite(slot0._imagelock, slot0._critterMo:isLock() and "xinxiang_suo" or "xinxiang_jiesuo", false)
	end
end

function slot0.getAttrRatioColor(slot0)
	return "#CAC8C5", "#FFAE46"
end

function slot0.initAttrInfo(slot0)
	gohelper.setActive(slot0._gotipbase.gameObject, false)
	slot0:refreshAttrInfo()
end

function slot0.refreshAttrInfo(slot0)
	slot1 = slot0._critterMo:getAttributeInfos()

	if not slot0._tipAttrItems then
		slot0._tipAttrItems = slot0:getUserDataTb_()
	end

	slot2 = 1

	if slot1 then
		for slot6, slot7 in pairs(slot1) do
			if slot7:getIsAddition() then
				if slot0:getTipAttrItem(slot2) then
					slot0:setAttrTipText(slot8, slot7)

					if slot8.icon and not string.nilorempty(slot7:getIcon()) then
						UISpriteSetMgr.instance:setCritterSprite(slot8.icon, slot7:getIcon())
					end
				end

				slot2 = slot2 + 1
			end
		end
	end

	for slot6 = 1, #slot0._tipAttrItems do
		gohelper.setActive(slot0._tipAttrItems[slot6].go, slot6 < slot2)
	end
end

function slot0.setAttrTipText(slot0, slot1, slot2)
	if slot1.nametxt then
		slot1.nametxt.text = slot2:getName()
	end

	if slot1.uptxt then
		slot1.uptxt.text = slot2:getaddRateStr()
	end

	if slot1.numtxt then
		slot1.numtxt.text = slot2:getValueNum()
	end

	if slot1.ratiotxt then
		slot1.ratiotxt.text = slot2:getRateStr()
	end
end

function slot0.attrOnClick(slot0)
	gohelper.setActive(slot0._gotipbase.gameObject, true)
end

function slot0.getTipAttrItem(slot0, slot1)
	if not slot0._tipAttrItems[slot1] then
		slot3 = gohelper.cloneInPlace(slot0._gobasetipsitem)
		slot0._tipAttrItems[slot1] = {
			nametxt = gohelper.findChildText(slot3, "#txt_name"),
			uptxt = gohelper.findChildText(slot3, "#txt_up"),
			icon = gohelper.findChildImage(slot3, "#txt_name/#image_icon"),
			ratiotxt = gohelper.findChildText(slot3, "#txt_ratio"),
			numtxt = gohelper.findChildText(slot3, "#txt_num"),
			go = slot3
		}
	end

	return slot2
end

function slot0.refrshCritterSpine(slot0)
	if not slot0.bigSpine then
		slot0.bigSpine = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gocritterlive2d, RoomCritterUISpine)
	end

	slot0.bigSpine:setResPath(slot0._critterMo)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

slot0._exclusiveSkill = CritterEnum.SkilTagType.Race

return slot0
