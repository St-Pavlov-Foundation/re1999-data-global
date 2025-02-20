module("modules.logic.equip.view.EquipTeamShowItem", package.seeall)

slot0 = class("EquipTeamShowItem", BaseChildView)

function slot0.onInitView(slot0)
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_container")
	slot0._txtlv = gohelper.findChildText(slot0.viewGO, "#go_container/top/#txt_lv")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_container/top/#txt_name")
	slot0._imagelock = gohelper.findChildImage(slot0.viewGO, "#go_container/top/#image_lock")
	slot0._golockicon = gohelper.findChild(slot0.viewGO, "#go_container/top/#image_lock/#go_lockicon")
	slot0._gostrengthenattr = gohelper.findChild(slot0.viewGO, "#go_container/scroll_center/Viewport/center/attribute/#go_strengthenattr")
	slot0._gosuiteffect = gohelper.findChild(slot0.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect")
	slot0._txtsuiteffect1 = gohelper.findChildText(slot0.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect/#go_advanceskill/suiteffect1/#txt_suiteffect1")
	slot0._txtsuiteffect2 = gohelper.findChildText(slot0.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect/#go_baseskill/suiteffect2/#txt_suiteffect2")
	slot0._goskillpos = gohelper.findChild(slot0.viewGO, "#go_container/#go_skillpos")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_container/bottom/#go_btns")
	slot0._goreplace = gohelper.findChild(slot0.viewGO, "#go_container/bottom/#go_btns/#go_replace")
	slot0._btnreplace = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/bottom/#go_btns/#go_replace/#btn_replace")
	slot0._txtreplace = gohelper.findChildText(slot0.viewGO, "#go_container/bottom/#go_btns/#go_replace/#txt_replace")
	slot0._txtreplaceen = gohelper.findChildText(slot0.viewGO, "#go_container/bottom/#go_btns/#go_replace/#txt_replaceen")
	slot0._btntrain = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/bottom/#go_btns/train/#btn_train")
	slot0._goremove = gohelper.findChild(slot0.viewGO, "#go_container/bottom/#go_btns/#go_remove")
	slot0._btnremove = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/bottom/#go_btns/#go_remove/#btn_remove")
	slot0._gocurrent = gohelper.findChild(slot0.viewGO, "#go_container/bottom/#go_current")
	slot0._imageskillcarrericon = gohelper.findChildImage(slot0.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect/#go_baseskill/basedestitle/#txt_basedestitle/#image_skillcarrericon")
	slot0._goadvanceskill = gohelper.findChild(slot0.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect/#go_advanceskill")
	slot0._gobaseskill = gohelper.findChild(slot0.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect/#go_baseskill")
	slot0._txtbasedestitle = gohelper.findChildText(slot0.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect/#go_baseskill/basedestitle/#txt_basedestitle")
	slot0._goinsigt = gohelper.findChild(slot0.viewGO, "#go_container/top/#go_insigt")
	slot0._image1 = gohelper.findChildImage(slot0.viewGO, "#go_container/top/#go_insigt/#image_1")
	slot0._image2 = gohelper.findChildImage(slot0.viewGO, "#go_container/top/#go_insigt/#image_2")
	slot0._image3 = gohelper.findChildImage(slot0.viewGO, "#go_container/top/#go_insigt/#image_3")
	slot0._image4 = gohelper.findChildImage(slot0.viewGO, "#go_container/top/#go_insigt/#image_4")
	slot0._image5 = gohelper.findChildImage(slot0.viewGO, "#go_container/top/#go_insigt/#image_5")
	slot0._goline = gohelper.findChild(slot0.viewGO, "#go_container/#go_line")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreplace:AddClickListener(slot0._btnreplaceOnClick, slot0)
	slot0._btntrain:AddClickListener(slot0._btntrainOnClick, slot0)
	slot0._btnremove:AddClickListener(slot0._btnremoveOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreplace:RemoveClickListener()
	slot0._btntrain:RemoveClickListener()
	slot0._btnremove:RemoveClickListener()
end

slot0.numColor = "#975129"

function slot0._btnreplaceOnClick(slot0)
	slot3 = false

	if EquipTeamListModel.instance:getTeamEquip()[1] and EquipModel.instance:getEquip(slot2) then
		slot3 = true
	end

	if HeroSingleGroupModel.instance:isTemp() then
		slot4, slot5, slot6 = EquipTeamListModel.instance:getRequestData(slot0._uid)

		HeroGroupModel.instance:replaceEquips({
			index = slot5,
			equipUid = slot6
		}, EquipTeamListModel.instance:getCurGroupMo())
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, slot5)

		if slot3 then
			GameFacade.showToast(ToastEnum.EquipTeamReplace)
		else
			GameFacade.showToast(ToastEnum.EquipTeamNoReplace)
		end
	else
		if EquipTeamListModel.instance:getEquipTeamPos(slot0._uid) then
			HeroGroupRpc.instance:sendSetHeroGroupEquipRequest(EquipTeamListModel.instance:getRequestDataByTargetUid(slot0._uid, "0"))
		end

		HeroGroupRpc.instance:showSetHeroGroupEquipTip(function ()
			if uv0 then
				GameFacade.showToast(ToastEnum.EquipTeamReplace)
			else
				GameFacade.showToast(ToastEnum.EquipTeamNoReplace)
			end
		end)
		HeroGroupRpc.instance:sendSetHeroGroupEquipRequest(EquipTeamListModel.instance:getRequestData(slot0._uid))
	end

	slot0._parentView:closeThis()
end

function slot0._btntrainOnClick(slot0)
	EquipController.instance:openEquipView({
		equipMO = slot0._equipMO,
		defaultTabIds = {
			[2.0] = 2
		}
	})
end

function slot0._btnremoveOnClick(slot0)
	uv0.removeEquip(EquipTeamListModel.instance:getCurPosIndex())
	slot0._parentView:closeThis()
end

function slot0.removeEquip(slot0, slot1)
	if HeroSingleGroupModel.instance:isTemp() or slot1 then
		slot2, slot3, slot4 = EquipTeamListModel.instance:_getRequestData(slot0, "0")

		HeroGroupModel.instance:replaceEquips({
			index = slot3,
			equipUid = slot4
		}, EquipTeamListModel.instance:getCurGroupMo())

		if not slot1 then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, slot3)
		end
	else
		HeroGroupRpc.instance:sendSetHeroGroupEquipRequest(EquipTeamListModel.instance:_getRequestData(slot0, "0"))
	end
end

function slot0.replaceEquip(slot0, slot1, slot2)
	if HeroSingleGroupModel.instance:isTemp() or slot2 then
		slot3, slot4, slot5 = EquipTeamListModel.instance:_getRequestData(slot0, slot1)

		HeroGroupModel.instance:replaceEquips({
			index = slot4,
			equipUid = slot5
		}, EquipTeamListModel.instance:getCurGroupMo())

		if not slot2 then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, slot4)
		end
	else
		HeroGroupRpc.instance:sendSetHeroGroupEquipRequest(EquipTeamListModel.instance:_getRequestData(slot0, slot1))
	end
end

function slot0._editableInitView(slot0)
	slot0._lockListener = gohelper.getClickWithAudio(slot0._golockicon)

	slot0._lockListener:AddClickDownListener(slot0._onLockDown, slot0)
	slot0._lockListener:AddClickListener(slot0._onLockClick, slot0)

	slot0._strengthenattrs = slot0:getUserDataTb_()
	slot0._txtDescList = slot0:getUserDataTb_()
	slot0._attrList = slot0:getUserDataTb_()

	gohelper.setActive(slot0._gostrengthenattr, false)
	gohelper.setActive(slot0._txtsuiteffect1.gameObject, false)
	gohelper.setActive(slot0._txtsuiteffect2.gameObject, false)

	slot0._advanceDesItems = slot0._advanceDesItems or slot0:getUserDataTb_()
	slot0._gobaseskillsuiteffect = gohelper.findChild(slot0.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect/#go_baseskill/suiteffect2/")
	slot0.canvasgroup = slot0._gobaseskillsuiteffect:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.addUIClickAudio(slot0._btnreplace.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Remember)
	gohelper.addUIClickAudio(slot0._btnremove.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
end

function slot0._onHyperLinkClick(slot0)
	EquipController.instance:openEquipSkillTipView({
		slot0._equipMO,
		nil,
		true,
		recthelper.uiPosToScreenPos(slot0._goskillpos.transform, ViewMgr.instance:getUICanvas())
	})
end

function slot0._onLockClick(slot0)
	slot0._lock = not slot0._lock

	UISpriteSetMgr.instance:setEquipSprite(slot0._imagelock, slot0._lock and "xinxiang_suo" or "xinxiang_jiesuo", true)
	EquipRpc.instance:sendEquipLockRequest(slot0._equipMO.id, slot0._lock)

	if slot0._lock then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Lock)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Unlock)
	end
end

function slot0.onUpdateParam(slot0)
	slot0:initViewParam()
	slot0:_updateEquip()
	slot0:_setSkillTipPos()
	UISpriteSetMgr.instance:setEquipSprite(slot0._imagelock, slot0._lock and "xinxiang_suo" or "xinxiang_jiesuo", true)
end

function slot0.onOpen(slot0)
	slot0:initViewParam()
	slot0:_updateEquip()
	slot0:_setSkillTipPos()
	UISpriteSetMgr.instance:setEquipSprite(slot0._imagelock, slot0._lock and "xinxiang_suo" or "xinxiang_jiesuo", true)
	slot0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, slot0._updateEquip, slot0)
end

function slot0.initViewParam(slot0)
	slot0._uid = slot0.viewParam[1]
	slot0._inTeam = slot0.viewParam[2]
	slot0._compare = slot0.viewParam[3]
	slot0._parentView = slot0.viewParam[4]
	slot0._heroId = slot0.viewParam[5]
	slot0._posIndex = slot0.viewParam[6]
	slot0._equipMO = EquipModel.instance:getEquip(slot0._uid)
	slot0._curEquipCo = EquipConfig.instance:getEquipSkillCfg(slot0._equipMO.equipId, slot0._equipMO.refineLv)
	slot0._lock = slot0._equipMO.isLock
end

function slot0._updateEquip(slot0)
	slot0:showEquip(slot0._equipMO)
	slot0:showAttrList()
	slot0._gobtns:SetActive(false)
	slot0._gocurrent:SetActive(false)
	slot0._goremove:SetActive(false)
	gohelper.setActive(slot0._goline, slot0._posIndex ~= 1)

	if slot0._inTeam then
		if slot0._compare then
			slot0._gocurrent:SetActive(true)
		else
			slot0._gobtns:SetActive(true)
			slot0._goremove:SetActive(true)
		end
	else
		slot0._gobtns:SetActive(true)
		slot0._goreplace:SetActive(true)

		if EquipTeamListModel.instance:getTeamEquip()[1] and EquipModel.instance:getEquip(slot2) then
			slot0._txtreplace.text = luaLang("equip_lang_22")
			slot0._txtreplaceen.text = "OVERWRITE"
		else
			slot0._txtreplace.text = luaLang("equip_lang_23")
			slot0._txtreplaceen.text = "MEMORIZE"
		end
	end
end

function slot0._setSkillTipPos(slot0)
	recthelper.setAnchorX(slot0._goskillpos.transform, 0)
end

function slot0.showAttrList(slot0)
	slot0._config = slot0._equipMO.config
	slot1, slot2 = EquipConfig.instance:getEquipNormalAttr(slot0._config.id, slot0._equipMO.level, HeroConfig.sortAttrForEquipView)

	gohelper.CreateObjList(slot0, slot0._attrItemShow, slot2, slot0._gostrengthenattr.transform.parent.gameObject, slot0._gostrengthenattr)
	slot0:showSpDesc()
end

function slot0._attrItemShow(slot0, slot1, slot2, slot3)
	slot4 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(slot2.attrType))
	slot5 = slot1.transform

	UISpriteSetMgr.instance:setCommonSprite(slot5:Find("image_icon"):GetComponent(gohelper.Type_Image), "icon_att_" .. slot4.id)

	slot5:Find("txt_name"):GetComponent(gohelper.Type_TextMesh).text = slot4.name
	slot5:Find("txt_value"):GetComponent(gohelper.Type_TextMesh).text = slot2.value
end

function slot0.showSpDesc(slot0)
	gohelper.setActive(slot0._gosuiteffect, true)

	if slot0._config.skillType <= 0 then
		gohelper.setActive(slot0._gosuiteffect, false)

		return
	end

	slot0:_showSkillAdvanceDes()
	slot0:_showSkillBaseDes()
end

function slot0._showSkillAdvanceDes(slot0)
	if EquipHelper.getEquipSkillAdvanceAttrDesTab(slot0._config.id, slot0._equipMO.refineLv, uv0.numColor) and #slot1 > 0 then
		slot5 = true

		gohelper.setActive(slot0._goadvanceskill, slot5)

		for slot5, slot6 in ipairs(slot1) do
			if not slot0._advanceDesItems[slot5] then
				slot8 = gohelper.cloneInPlace(slot0._txtsuiteffect1.gameObject, "item_" .. slot5)

				table.insert(slot0._advanceDesItems, slot8)

				slot7 = slot8
			end

			gohelper.setActive(slot7.gameObject, true)

			slot7:GetComponent(gohelper.Type_TextMesh).text = slot6
		end

		for slot5 = #slot1 + 1, #slot0._advanceDesItems do
			gohelper.setActive(slot0._advanceDesItems[slot5], false)
		end
	else
		gohelper.setActive(slot0._goadvanceskill, false)
	end
end

function slot0._showSkillBaseDes(slot0)
	slot1, slot2, slot3 = EquipHelper.getSkillBaseDescAndIcon(slot0._config.id, slot0._equipMO.refineLv, "#C78449")

	if #slot1 == 0 then
		gohelper.setActive(slot0._gobaseskill.gameObject, false)
	else
		gohelper.setActive(slot0._gobaseskill.gameObject, true)

		slot9 = slot0._config.skillName
		slot0._txtbasedestitle.text = string.format("<%s>%s</color>", slot3, slot9)
		slot8 = slot2

		UISpriteSetMgr.instance:setCommonSprite(slot0._imageskillcarrericon, slot8)

		slot4 = nil

		for slot8, slot9 in ipairs(slot1) do
			if not slot0._txtDescList[slot8] then
				table.insert(slot0._txtDescList, gohelper.cloneInPlace(slot0._txtsuiteffect2.gameObject, "item_" .. slot8):GetComponent(gohelper.Type_TextMesh))
			end

			slot4.text = slot9

			gohelper.setActive(slot4.gameObject, true)
		end

		for slot8 = #slot1 + 1, #slot0._txtDescList do
			gohelper.setActive(slot0._txtDescList[slot8].gameObject, false)
		end

		EquipController.instance:dispatchEvent(EquipEvent.equipHasRefine)
	end

	slot0.canvasgroup.alpha = slot0._curEquipCo and EquipHelper.detectEquipSkillSuited(slot0._heroId, slot0._curEquipCo.id, slot0._equipMO.refineLv) and 1 or 0.45
end

function slot0.showEquip(slot0, slot1)
	slot0._mo = slot1
	slot0._config = EquipConfig.instance:getEquipCo(slot1.equipId)
	slot0._txtname.text = slot0._config.name
	slot6 = "<color=#D9A06F>%s</color> /%s"
	slot0._txtlv.text = string.format(slot6, slot0._mo.level, string.format("%s", EquipConfig.instance:getCurrentBreakLevelMaxLevel(slot0._mo)))

	for slot6 = 1, 5 do
		UISpriteSetMgr.instance:setEquipSprite(slot0["_image" .. slot6], slot6 <= slot0._mo.refineLv and "bg_xinxiang_dengji" or "bg_xinxiang_dengji_dis")
	end
end

function slot0.isOneSuit(slot0)
	return true
end

function slot0.onClose(slot0)
	slot0._lockListener:RemoveClickDownListener()
	slot0._lockListener:RemoveClickListener()
end

function slot0.onDestroyView(slot0)
end

return slot0
