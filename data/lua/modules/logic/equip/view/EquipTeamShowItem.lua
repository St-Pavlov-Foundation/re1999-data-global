module("modules.logic.equip.view.EquipTeamShowItem", package.seeall)

local var_0_0 = class("EquipTeamShowItem", BaseChildView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container")
	arg_1_0._txtlv = gohelper.findChildText(arg_1_0.viewGO, "#go_container/top/#txt_lv")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_container/top/#txt_name")
	arg_1_0._imagelock = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/top/#image_lock")
	arg_1_0._golockicon = gohelper.findChild(arg_1_0.viewGO, "#go_container/top/#image_lock/#go_lockicon")
	arg_1_0._gostrengthenattr = gohelper.findChild(arg_1_0.viewGO, "#go_container/scroll_center/Viewport/center/attribute/#go_strengthenattr")
	arg_1_0._gosuiteffect = gohelper.findChild(arg_1_0.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect")
	arg_1_0._txtsuiteffect1 = gohelper.findChildText(arg_1_0.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect/#go_advanceskill/suiteffect1/#txt_suiteffect1")
	arg_1_0._txtsuiteffect2 = gohelper.findChildText(arg_1_0.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect/#go_baseskill/suiteffect2/#txt_suiteffect2")
	arg_1_0._goskillpos = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_skillpos")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_container/bottom/#go_btns")
	arg_1_0._goreplace = gohelper.findChild(arg_1_0.viewGO, "#go_container/bottom/#go_btns/#go_replace")
	arg_1_0._btnreplace = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/bottom/#go_btns/#go_replace/#btn_replace")
	arg_1_0._txtreplace = gohelper.findChildText(arg_1_0.viewGO, "#go_container/bottom/#go_btns/#go_replace/#txt_replace")
	arg_1_0._txtreplaceen = gohelper.findChildText(arg_1_0.viewGO, "#go_container/bottom/#go_btns/#go_replace/#txt_replaceen")
	arg_1_0._btntrain = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/bottom/#go_btns/train/#btn_train")
	arg_1_0._goremove = gohelper.findChild(arg_1_0.viewGO, "#go_container/bottom/#go_btns/#go_remove")
	arg_1_0._btnremove = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/bottom/#go_btns/#go_remove/#btn_remove")
	arg_1_0._gocurrent = gohelper.findChild(arg_1_0.viewGO, "#go_container/bottom/#go_current")
	arg_1_0._imageskillcarrericon = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect/#go_baseskill/basedestitle/#txt_basedestitle/#image_skillcarrericon")
	arg_1_0._goadvanceskill = gohelper.findChild(arg_1_0.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect/#go_advanceskill")
	arg_1_0._gobaseskill = gohelper.findChild(arg_1_0.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect/#go_baseskill")
	arg_1_0._txtbasedestitle = gohelper.findChildText(arg_1_0.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect/#go_baseskill/basedestitle/#txt_basedestitle")
	arg_1_0._goinsigt = gohelper.findChild(arg_1_0.viewGO, "#go_container/top/#go_insigt")
	arg_1_0._image1 = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/top/#go_insigt/#image_1")
	arg_1_0._image2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/top/#go_insigt/#image_2")
	arg_1_0._image3 = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/top/#go_insigt/#image_3")
	arg_1_0._image4 = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/top/#go_insigt/#image_4")
	arg_1_0._image5 = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/top/#go_insigt/#image_5")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_line")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreplace:AddClickListener(arg_2_0._btnreplaceOnClick, arg_2_0)
	arg_2_0._btntrain:AddClickListener(arg_2_0._btntrainOnClick, arg_2_0)
	arg_2_0._btnremove:AddClickListener(arg_2_0._btnremoveOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreplace:RemoveClickListener()
	arg_3_0._btntrain:RemoveClickListener()
	arg_3_0._btnremove:RemoveClickListener()
end

var_0_0.numColor = "#975129"

function var_0_0._btnreplaceOnClick(arg_4_0)
	local var_4_0 = EquipTeamListModel.instance:getTeamEquip()[1]
	local var_4_1 = false

	if var_4_0 and EquipModel.instance:getEquip(var_4_0) then
		var_4_1 = true
	end

	if HeroSingleGroupModel.instance:isTemp() then
		local var_4_2, var_4_3, var_4_4 = EquipTeamListModel.instance:getRequestData(arg_4_0._uid)
		local var_4_5 = {
			index = var_4_3,
			equipUid = var_4_4
		}

		HeroGroupModel.instance:replaceEquips(var_4_5, EquipTeamListModel.instance:getCurGroupMo())
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, var_4_3)

		if var_4_1 then
			GameFacade.showToast(ToastEnum.EquipTeamReplace)
		else
			GameFacade.showToast(ToastEnum.EquipTeamNoReplace)
		end
	else
		if EquipTeamListModel.instance:getEquipTeamPos(arg_4_0._uid) then
			HeroGroupRpc.instance:sendSetHeroGroupEquipRequest(EquipTeamListModel.instance:getRequestDataByTargetUid(arg_4_0._uid, "0"))
		end

		HeroGroupRpc.instance:showSetHeroGroupEquipTip(function()
			if var_4_1 then
				GameFacade.showToast(ToastEnum.EquipTeamReplace)
			else
				GameFacade.showToast(ToastEnum.EquipTeamNoReplace)
			end
		end)
		HeroGroupRpc.instance:sendSetHeroGroupEquipRequest(EquipTeamListModel.instance:getRequestData(arg_4_0._uid))
	end

	arg_4_0._parentView:closeThis()
end

function var_0_0._btntrainOnClick(arg_6_0)
	local var_6_0 = {
		equipMO = arg_6_0._equipMO,
		defaultTabIds = {
			[2] = 2
		}
	}

	EquipController.instance:openEquipView(var_6_0)
end

function var_0_0._btnremoveOnClick(arg_7_0)
	var_0_0.removeEquip(EquipTeamListModel.instance:getCurPosIndex())
	arg_7_0._parentView:closeThis()
end

function var_0_0.removeEquip(arg_8_0, arg_8_1)
	if HeroSingleGroupModel.instance:isTemp() or arg_8_1 then
		local var_8_0, var_8_1, var_8_2 = EquipTeamListModel.instance:_getRequestData(arg_8_0, "0")
		local var_8_3 = {
			index = var_8_1,
			equipUid = var_8_2
		}

		HeroGroupModel.instance:replaceEquips(var_8_3, EquipTeamListModel.instance:getCurGroupMo())

		if not arg_8_1 then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, var_8_1)
		end
	else
		HeroGroupRpc.instance:sendSetHeroGroupEquipRequest(EquipTeamListModel.instance:_getRequestData(arg_8_0, "0"))
	end
end

function var_0_0.replaceEquip(arg_9_0, arg_9_1, arg_9_2)
	if HeroSingleGroupModel.instance:isTemp() or arg_9_2 then
		local var_9_0, var_9_1, var_9_2 = EquipTeamListModel.instance:_getRequestData(arg_9_0, arg_9_1)
		local var_9_3 = {
			index = var_9_1,
			equipUid = var_9_2
		}

		HeroGroupModel.instance:replaceEquips(var_9_3, EquipTeamListModel.instance:getCurGroupMo())

		if not arg_9_2 then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, var_9_1)
		end
	else
		HeroGroupRpc.instance:sendSetHeroGroupEquipRequest(EquipTeamListModel.instance:_getRequestData(arg_9_0, arg_9_1))
	end
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._lockListener = gohelper.getClickWithAudio(arg_10_0._golockicon)

	arg_10_0._lockListener:AddClickDownListener(arg_10_0._onLockDown, arg_10_0)
	arg_10_0._lockListener:AddClickListener(arg_10_0._onLockClick, arg_10_0)

	arg_10_0._strengthenattrs = arg_10_0:getUserDataTb_()
	arg_10_0._txtDescList = arg_10_0:getUserDataTb_()
	arg_10_0._attrList = arg_10_0:getUserDataTb_()

	gohelper.setActive(arg_10_0._gostrengthenattr, false)
	gohelper.setActive(arg_10_0._txtsuiteffect1.gameObject, false)
	gohelper.setActive(arg_10_0._txtsuiteffect2.gameObject, false)

	arg_10_0._advanceDesItems = arg_10_0._advanceDesItems or arg_10_0:getUserDataTb_()
	arg_10_0._gobaseskillsuiteffect = gohelper.findChild(arg_10_0.viewGO, "#go_container/scroll_center/Viewport/center/#go_suiteffect/#go_baseskill/suiteffect2/")
	arg_10_0.canvasgroup = arg_10_0._gobaseskillsuiteffect:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.addUIClickAudio(arg_10_0._btnreplace.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Remember)
	gohelper.addUIClickAudio(arg_10_0._btnremove.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
end

function var_0_0._onHyperLinkClick(arg_11_0)
	local var_11_0 = recthelper.uiPosToScreenPos(arg_11_0._goskillpos.transform, ViewMgr.instance:getUICanvas())

	EquipController.instance:openEquipSkillTipView({
		arg_11_0._equipMO,
		nil,
		true,
		var_11_0
	})
end

function var_0_0._onLockClick(arg_12_0)
	arg_12_0._lock = not arg_12_0._lock

	UISpriteSetMgr.instance:setEquipSprite(arg_12_0._imagelock, arg_12_0._lock and "xinxiang_suo" or "xinxiang_jiesuo", true)
	EquipRpc.instance:sendEquipLockRequest(arg_12_0._equipMO.id, arg_12_0._lock)

	if arg_12_0._lock then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Lock)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Unlock)
	end
end

function var_0_0.onUpdateParam(arg_13_0)
	arg_13_0:initViewParam()
	arg_13_0:_updateEquip()
	arg_13_0:_setSkillTipPos()
	UISpriteSetMgr.instance:setEquipSprite(arg_13_0._imagelock, arg_13_0._lock and "xinxiang_suo" or "xinxiang_jiesuo", true)
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:initViewParam()
	arg_14_0:_updateEquip()
	arg_14_0:_setSkillTipPos()
	UISpriteSetMgr.instance:setEquipSprite(arg_14_0._imagelock, arg_14_0._lock and "xinxiang_suo" or "xinxiang_jiesuo", true)
	arg_14_0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_14_0._updateEquip, arg_14_0)
end

function var_0_0.initViewParam(arg_15_0)
	arg_15_0._uid = arg_15_0.viewParam[1]
	arg_15_0._inTeam = arg_15_0.viewParam[2]
	arg_15_0._compare = arg_15_0.viewParam[3]
	arg_15_0._parentView = arg_15_0.viewParam[4]
	arg_15_0._heroId = arg_15_0.viewParam[5]
	arg_15_0._posIndex = arg_15_0.viewParam[6]
	arg_15_0._equipMO = EquipModel.instance:getEquip(arg_15_0._uid)
	arg_15_0._curEquipCo = EquipConfig.instance:getEquipSkillCfg(arg_15_0._equipMO.equipId, arg_15_0._equipMO.refineLv)
	arg_15_0._lock = arg_15_0._equipMO.isLock
end

function var_0_0._updateEquip(arg_16_0)
	arg_16_0:showEquip(arg_16_0._equipMO)
	arg_16_0:showAttrList()
	arg_16_0._gobtns:SetActive(false)
	arg_16_0._gocurrent:SetActive(false)
	arg_16_0._goremove:SetActive(false)
	gohelper.setActive(arg_16_0._goline, arg_16_0._posIndex ~= 1)

	if arg_16_0._inTeam then
		if arg_16_0._compare then
			arg_16_0._gocurrent:SetActive(true)
		else
			arg_16_0._gobtns:SetActive(true)
			arg_16_0._goremove:SetActive(true)
		end
	else
		arg_16_0._gobtns:SetActive(true)
		arg_16_0._goreplace:SetActive(true)

		local var_16_0 = EquipTeamListModel.instance:getTeamEquip()[1]

		if var_16_0 and EquipModel.instance:getEquip(var_16_0) then
			arg_16_0._txtreplace.text = luaLang("equip_lang_22")
			arg_16_0._txtreplaceen.text = "OVERWRITE"
		else
			arg_16_0._txtreplace.text = luaLang("equip_lang_23")
			arg_16_0._txtreplaceen.text = "MEMORIZE"
		end
	end
end

function var_0_0._setSkillTipPos(arg_17_0)
	recthelper.setAnchorX(arg_17_0._goskillpos.transform, 0)
end

function var_0_0.showAttrList(arg_18_0)
	arg_18_0._config = arg_18_0._equipMO.config

	local var_18_0, var_18_1 = EquipConfig.instance:getEquipNormalAttr(arg_18_0._config.id, arg_18_0._equipMO.level, HeroConfig.sortAttrForEquipView)

	gohelper.CreateObjList(arg_18_0, arg_18_0._attrItemShow, var_18_1, arg_18_0._gostrengthenattr.transform.parent.gameObject, arg_18_0._gostrengthenattr)
	arg_18_0:showSpDesc()
end

function var_0_0._attrItemShow(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(arg_19_2.attrType))
	local var_19_1 = arg_19_1.transform
	local var_19_2 = var_19_1:Find("image_icon"):GetComponent(gohelper.Type_Image)
	local var_19_3 = var_19_1:Find("txt_name"):GetComponent(gohelper.Type_TextMesh)
	local var_19_4 = var_19_1:Find("txt_value"):GetComponent(gohelper.Type_TextMesh)

	UISpriteSetMgr.instance:setCommonSprite(var_19_2, "icon_att_" .. var_19_0.id)

	var_19_3.text = var_19_0.name
	var_19_4.text = arg_19_2.value
end

function var_0_0.showSpDesc(arg_20_0)
	gohelper.setActive(arg_20_0._gosuiteffect, true)

	if arg_20_0._config.skillType <= 0 then
		gohelper.setActive(arg_20_0._gosuiteffect, false)

		return
	end

	arg_20_0:_showSkillAdvanceDes()
	arg_20_0:_showSkillBaseDes()
end

function var_0_0._showSkillAdvanceDes(arg_21_0)
	local var_21_0 = EquipHelper.getEquipSkillAdvanceAttrDesTab(arg_21_0._config.id, arg_21_0._equipMO.refineLv, var_0_0.numColor)

	if var_21_0 and #var_21_0 > 0 then
		gohelper.setActive(arg_21_0._goadvanceskill, true)

		for iter_21_0, iter_21_1 in ipairs(var_21_0) do
			local var_21_1 = arg_21_0._advanceDesItems[iter_21_0]

			if not var_21_1 then
				local var_21_2 = gohelper.cloneInPlace(arg_21_0._txtsuiteffect1.gameObject, "item_" .. iter_21_0)

				table.insert(arg_21_0._advanceDesItems, var_21_2)

				var_21_1 = var_21_2
			end

			gohelper.setActive(var_21_1.gameObject, true)

			var_21_1:GetComponent(gohelper.Type_TextMesh).text = iter_21_1
		end

		for iter_21_2 = #var_21_0 + 1, #arg_21_0._advanceDesItems do
			gohelper.setActive(arg_21_0._advanceDesItems[iter_21_2], false)
		end
	else
		gohelper.setActive(arg_21_0._goadvanceskill, false)
	end
end

function var_0_0._showSkillBaseDes(arg_22_0)
	local var_22_0, var_22_1, var_22_2 = EquipHelper.getSkillBaseDescAndIcon(arg_22_0._config.id, arg_22_0._equipMO.refineLv, "#C78449")

	if #var_22_0 == 0 then
		gohelper.setActive(arg_22_0._gobaseskill.gameObject, false)
	else
		gohelper.setActive(arg_22_0._gobaseskill.gameObject, true)

		arg_22_0._txtbasedestitle.text = string.format("<%s>%s</color>", var_22_2, arg_22_0._config.skillName)

		UISpriteSetMgr.instance:setCommonSprite(arg_22_0._imageskillcarrericon, var_22_1)

		local var_22_3

		for iter_22_0, iter_22_1 in ipairs(var_22_0) do
			local var_22_4 = arg_22_0._txtDescList[iter_22_0]

			if not var_22_4 then
				var_22_4 = gohelper.cloneInPlace(arg_22_0._txtsuiteffect2.gameObject, "item_" .. iter_22_0):GetComponent(gohelper.Type_TextMesh)

				table.insert(arg_22_0._txtDescList, var_22_4)
			end

			var_22_4.text = iter_22_1

			gohelper.setActive(var_22_4.gameObject, true)
		end

		for iter_22_2 = #var_22_0 + 1, #arg_22_0._txtDescList do
			gohelper.setActive(arg_22_0._txtDescList[iter_22_2].gameObject, false)
		end

		EquipController.instance:dispatchEvent(EquipEvent.equipHasRefine)
	end

	arg_22_0.canvasgroup.alpha = arg_22_0._curEquipCo and EquipHelper.detectEquipSkillSuited(arg_22_0._heroId, arg_22_0._curEquipCo.id, arg_22_0._equipMO.refineLv) and 1 or 0.45
end

function var_0_0.showEquip(arg_23_0, arg_23_1)
	arg_23_0._mo = arg_23_1
	arg_23_0._config = EquipConfig.instance:getEquipCo(arg_23_1.equipId)
	arg_23_0._txtname.text = arg_23_0._config.name

	local var_23_0 = string.format("%s", EquipConfig.instance:getCurrentBreakLevelMaxLevel(arg_23_0._mo))

	arg_23_0._txtlv.text = string.format("<color=#D9A06F>%s</color> /%s", arg_23_0._mo.level, var_23_0)

	for iter_23_0 = 1, 5 do
		UISpriteSetMgr.instance:setEquipSprite(arg_23_0["_image" .. iter_23_0], iter_23_0 <= arg_23_0._mo.refineLv and "bg_xinxiang_dengji" or "bg_xinxiang_dengji_dis")
	end
end

function var_0_0.isOneSuit(arg_24_0)
	return true
end

function var_0_0.onClose(arg_25_0)
	arg_25_0._lockListener:RemoveClickDownListener()
	arg_25_0._lockListener:RemoveClickListener()
end

function var_0_0.onDestroyView(arg_26_0)
	return
end

return var_0_0
