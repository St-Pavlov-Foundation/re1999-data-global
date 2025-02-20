module("modules.logic.character.view.destiny.CharacterDestinySlotAttrItem", package.seeall)

slot0 = class("CharacterDestinySlotAttrItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._gospecialbg = gohelper.findChild(slot0.viewGO, "#go_specialbg")
	slot0._golock = gohelper.findChild(slot0.viewGO, "#go_lock")
	slot0._txtunlocktips = gohelper.findChildText(slot0.viewGO, "#go_lock/#txt_unlocktips")
	slot0._txtlockname = gohelper.findChildText(slot0.viewGO, "#go_lock/layout/#txt_lockname")
	slot0._imagelockicon = gohelper.findChildImage(slot0.viewGO, "#go_lock/layout/#txt_lockname/#image_lockicon")
	slot0._txtlockcur = gohelper.findChildText(slot0.viewGO, "#go_lock/layout/num/#txt_lockcur")
	slot0._golockarrow = gohelper.findChild(slot0.viewGO, "#go_lock/layout/num/#go_lockarrow")
	slot0._txtlocknext = gohelper.findChildText(slot0.viewGO, "#go_lock/layout/num/#txt_locknext")
	slot0._gounlock = gohelper.findChild(slot0.viewGO, "#go_unlock")
	slot0._txtunlockname = gohelper.findChildText(slot0.viewGO, "#go_unlock/#txt_unlockname")
	slot0._imageunlockicon = gohelper.findChildImage(slot0.viewGO, "#go_unlock/#txt_unlockname/#image_unlockicon")
	slot0._txtunlockcur = gohelper.findChildText(slot0.viewGO, "#go_unlock/num/#txt_unlockcur")
	slot0._gounlockarrow = gohelper.findChild(slot0.viewGO, "#go_unlock/num/#go_unlockarrow")
	slot0._txtunlocknext = gohelper.findChildText(slot0.viewGO, "#go_unlock/num/#txt_unlocknext")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._lockItem = slot0:getUserDataTb_()
	slot0._golockItem = gohelper.findChild(slot0.viewGO, "#go_lock/layout")
	slot0._levelup = gohelper.findChild(slot0.viewGO, "#leveup")
	slot0._lockItem[1] = slot0:__getLockItem(slot0._golockItem)

	slot0:onInitView()
	gohelper.setActive(slot1, true)
	gohelper.setActive(slot0._levelup, false)
end

function slot0.addEventListeners(slot0)
	slot0:addEvents()
end

function slot0.removeEventListeners(slot0)
	slot0:removeEvents()
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._levelupAnimCallback, slot0)
end

function slot0.onUpdateBaseAttrMO(slot0, slot1, slot2, slot3, slot4)
	slot7 = slot2.curNum or 0
	slot0._txtunlockname.text = HeroConfig.instance:getHeroAttributeCO(slot2.attrId).name
	slot0._txtunlockcur.text = slot0:_showAttrValue(slot7, slot5.showType)
	slot0._txtunlocknext.text = slot0:_showAttrValue(slot7 + (slot2.nextNum or 0), slot5.showType)
	slot9 = slot2.attrId
	slot0.attrId = slot9

	if CharacterDestinyEnum.DestinyUpBaseParseOffAttr[slot9] then
		slot9 = CharacterDestinyEnum.DestinyUpBaseParseOffAttr[slot9]
	end

	CharacterController.instance:SetAttriIcon(slot0._imageunlockicon, slot9)
	gohelper.setActive(slot0._gounlockarrow, slot8 > 0)
	gohelper.setActive(slot0._txtunlocknext.gameObject, slot8 > 0)
	gohelper.setActive(slot0._gounlock, true)
	gohelper.setActive(slot0._golock, false)
	recthelper.setAnchorY(slot0._gospecialbg.transform, 0)

	if slot3 then
		recthelper.setHeight(slot0._gospecialbg.transform, slot0:_getSpecialBgHeight(slot4))
	end

	gohelper.setActive(slot0._gospecialbg, slot3)
end

function slot0.onUpdateSpecailAttrMO(slot0, slot1, slot2, slot3, slot4)
	slot0:onUpdateBaseAttrMO(slot1, slot2, slot3, slot4)
end

function slot0.onUpdateLockSpecialAttrMO(slot0, slot1, slot2, slot3)
	if slot3 then
		slot4 = 1
		slot5 = 0

		for slot9, slot10 in pairs(slot3) do
			if slot0:_getLockItem(slot4) then
				slot14.nameTxt.text = HeroConfig.instance:getHeroAttributeCO(slot10.attrId).name
				slot14.curNumTxt.text = slot0:_showAttrValue(slot10.curNum or 0, slot11.showType)

				if (LuaUtil.tableContains(CharacterDestinyEnum.DestinyUpSpecialAttr, slot10.attrId) or LuaUtil.tableContains(CharacterEnum.UpAttrIdList, slot15)) and not slot0._gospecialbg.activeSelf then
					recthelper.setAnchorY(slot0._gospecialbg.transform, -50 - (slot4 - 1) * 53)
					gohelper.setActive(slot0._gospecialbg, true)

					slot5 = slot4
				end

				if CharacterDestinyEnum.DestinyUpBaseParseOffAttr[slot15] then
					slot15 = CharacterDestinyEnum.DestinyUpBaseParseOffAttr[slot15]
				end

				CharacterController.instance:SetAttriIcon(slot14.iconImage, slot15)
			end

			slot4 = slot4 + 1
		end

		if slot5 > 0 and slot0._gospecialbg.activeSelf then
			recthelper.setHeight(slot0._gospecialbg.transform, slot0:_getSpecialBgHeight(slot4 - slot5))
		end

		slot0._txtunlocktips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("character_destinyslot_unlockrank"), CharacterDestinyEnum.RomanNum[slot2])
	end

	gohelper.setActive(slot0._gounlock, false)
	gohelper.setActive(slot0._golock, true)
end

function slot0._getSpecialBgHeight(slot0, slot1)
	return 50 + slot1 * 70
end

function slot0._showAttrValue(slot0, slot1, slot2)
	return slot2 == 1 and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("percent"), slot1) or slot1
end

function slot0._getLockItem(slot0, slot1)
	if not slot0._lockItem[slot1] then
		slot0._lockItem[slot1] = slot0:__getLockItem(gohelper.cloneInPlace(slot0._golockItem))
	end

	return slot2
end

function slot0.__getLockItem(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = slot0:getUserDataTb_()
	slot2.go = slot1
	slot2.nameTxt = gohelper.findChildText(slot1, "#txt_lockname")
	slot2.iconImage = gohelper.findChildImage(slot1, "#txt_lockname/#image_lockicon")
	slot2.curNumTxt = gohelper.findChildText(slot1, "num/#txt_lockcur")
	slot2.arrowGo = gohelper.findChild(slot1, "num/#go_lockarrow")
	slot2.nextNumTxt = gohelper.findChildText(slot1, "num/#txt_locknext")

	return slot2
end

function slot0.playLevelUpAnim(slot0)
	gohelper.setActive(slot0._levelup, true)
	TaskDispatcher.runDelay(slot0._levelupAnimCallback, slot0, 1)
end

function slot0._levelupAnimCallback(slot0)
	gohelper.setActive(slot0._levelup, false)
end

return slot0
