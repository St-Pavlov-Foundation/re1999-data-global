module("modules.logic.equip.view.EquipInfoTipsView", package.seeall)

local var_0_0 = class("EquipInfoTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container")
	arg_1_0._simageframe = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_container/#simage_frame")
	arg_1_0._txtlv = gohelper.findChildText(arg_1_0.viewGO, "#go_container/top/name/lv/#txt_lv")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_container/top/name/#txt_name")
	arg_1_0._goequipitem = gohelper.findChild(arg_1_0.viewGO, "#go_container/top/#go_equipitem")
	arg_1_0._simageequipicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_container/top/#go_equipitem/#simage_equipicon")
	arg_1_0._imagelock = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/top/#image_lock")
	arg_1_0._golockicon = gohelper.findChild(arg_1_0.viewGO, "#go_container/top/#image_lock/#go_lockicon")
	arg_1_0._gostrengthenattr = gohelper.findChild(arg_1_0.viewGO, "#go_container/scroll_view/Viewport/center/attribute/#go_strengthenattr")
	arg_1_0._gobreakeffect = gohelper.findChild(arg_1_0.viewGO, "#go_container/scroll_view/Viewport/center/attribute/#go_breakeffect")
	arg_1_0._gosuitattribute = gohelper.findChild(arg_1_0.viewGO, "#go_container/scroll_view/Viewport/center/#go_suitattribute")
	arg_1_0._txtattributelv = gohelper.findChildText(arg_1_0.viewGO, "#go_container/scroll_view/Viewport/center/#go_suitattribute/attributename/#txt_attributelv")
	arg_1_0._gosuiteffect = gohelper.findChild(arg_1_0.viewGO, "#go_container/scroll_view/Viewport/center/#go_suitattribute/#go_suiteffect")
	arg_1_0._gobaseskill = gohelper.findChild(arg_1_0.viewGO, "#go_container/scroll_view/Viewport/center/#go_suitattribute/#go_suiteffect/#go_baseskill")
	arg_1_0._txtsuiteffect2 = gohelper.findChildText(arg_1_0.viewGO, "#go_container/scroll_view/Viewport/center/#go_suitattribute/#go_suiteffect/#go_baseskill/suiteffect2/#txt_suiteffect2")
	arg_1_0._goskillpos = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_skillpos")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onLockClick(arg_5_0)
	arg_5_0.isLock = not arg_5_0.isLock

	if arg_5_0.isLock then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Lock)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Unlock)
	end

	EquipRpc.instance:sendEquipLockRequest(arg_5_0.equipMo.id, arg_5_0.isLock)
end

function var_0_0.onLockChangeReply(arg_6_0)
	arg_6_0:refreshLockUI()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._goSuitEffectItem = gohelper.findChild(arg_7_0.viewGO, "#go_container/scroll_view/Viewport/center/#go_suitattribute/#go_suiteffect/#go_advanceskill/suiteffect")
	arg_7_0._goBaseSkillCanvasGroup = arg_7_0._gobaseskill:GetComponent(gohelper.Type_CanvasGroup)

	gohelper.setActive(arg_7_0._gostrengthenattr, false)
	gohelper.setActive(arg_7_0._txtsuiteffect2.gameObject, false)
	arg_7_0:changeViewGoPosition()

	arg_7_0.lockClick = gohelper.getClick(arg_7_0._golockicon)

	arg_7_0.lockClick:AddClickListener(arg_7_0.onLockClick, arg_7_0)

	arg_7_0.attrGoList = {}
	arg_7_0._txtDescList = {}
	arg_7_0.imageBreakIcon = gohelper.findChildImage(arg_7_0._gobreakeffect, "image_icon")
	arg_7_0.txtBreakAttrName = gohelper.findChildText(arg_7_0._gobreakeffect, "txt_name")
	arg_7_0.txtBreakValue = gohelper.findChildText(arg_7_0._gobreakeffect, "txt_value")

	arg_7_0:addEventCb(EquipController.instance, EquipEvent.onEquipLockChange, arg_7_0.onLockChangeReply, arg_7_0)
	arg_7_0._simageframe:LoadImage(ResUrl.getEquipBg("bg_tips.png"))

	arg_7_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_7_0.viewGO)
end

function var_0_0.onUpdateParam(arg_8_0)
	if arg_8_0.viewParam.equipMo.id == arg_8_0.equipMo.id then
		return
	end

	arg_8_0.animatorPlayer:Play(UIAnimationName.Close, function(arg_9_0)
		arg_9_0:onOpen()
		arg_9_0.animatorPlayer:Play(UIAnimationName.Open)
	end, arg_8_0)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0.equipMo = arg_10_0.viewParam.equipMo
	arg_10_0.isLock = arg_10_0.equipMo.isLock
	arg_10_0.heroCo = arg_10_0.viewParam.heroCo

	arg_10_0:refreshUI()
end

function var_0_0.refreshUI(arg_11_0)
	arg_11_0._txtname.text = arg_11_0.equipMo.config.name
	arg_11_0._txtlv.text = arg_11_0.equipMo.level

	arg_11_0._simageequipicon:LoadImage(ResUrl.getEquipSuit(arg_11_0.equipMo.config.icon))
	arg_11_0:refreshLockUI()
	arg_11_0:refreshAttributeInfo()

	if arg_11_0.equipMo.config.rare > EquipConfig.instance:getNotShowRefineRare() then
		gohelper.setActive(arg_11_0._gosuitattribute, true)
		arg_11_0:refreshSkillInfo()
	else
		gohelper.setActive(arg_11_0._gosuitattribute, false)
	end
end

function var_0_0.refreshLockUI(arg_12_0)
	if arg_12_0.viewParam.notShowLockIcon or EquipHelper.isSpRefineEquip(arg_12_0.equipMo.config) then
		gohelper.setActive(arg_12_0._imagelock.gameObject, false)

		return
	end

	UISpriteSetMgr.instance:setEquipSprite(arg_12_0._imagelock, arg_12_0.isLock and "bg_tips_suo" or "bg_tips_jiesuo", false)
end

function var_0_0.refreshAttributeInfo(arg_13_0)
	local var_13_0, var_13_1 = EquipConfig.instance:getEquipNormalAttr(arg_13_0.equipMo.config.id, arg_13_0.equipMo.level, HeroConfig.sortAttrForEquipView)
	local var_13_2

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		local var_13_3 = arg_13_0.attrGoList[iter_13_0]

		if not var_13_3 then
			var_13_3 = arg_13_0:getUserDataTb_()

			local var_13_4 = gohelper.cloneInPlace(arg_13_0._gostrengthenattr, "attr" .. iter_13_0)
			local var_13_5 = gohelper.findChild(var_13_4, "bg")
			local var_13_6 = gohelper.findChildImage(var_13_4, "image_icon")
			local var_13_7 = gohelper.findChildText(var_13_4, "txt_name")
			local var_13_8 = gohelper.findChildText(var_13_4, "txt_value")

			var_13_3.go = var_13_4
			var_13_3.bg = var_13_5
			var_13_3.icon = var_13_6
			var_13_3.name = var_13_7
			var_13_3.attr_value = var_13_8

			table.insert(arg_13_0.attrGoList, var_13_3)
		end

		local var_13_9 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(iter_13_1.attrType))

		UISpriteSetMgr.instance:setCommonSprite(var_13_3.icon, "icon_att_" .. var_13_9.id)
		gohelper.setActive(var_13_3.bg, iter_13_0 % 2 == 0)

		var_13_3.name.text = var_13_9.name
		var_13_3.attr_value.text = iter_13_1.value

		gohelper.setActive(var_13_3.go, true)
	end

	for iter_13_2 = #var_13_1 + 1, #arg_13_0.attrGoList do
		gohelper.setActive(arg_13_0.attrGoList[iter_13_2].go, false)
	end

	local var_13_10, var_13_11 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(arg_13_0.equipMo.config, arg_13_0.equipMo.breakLv)

	if var_13_10 then
		gohelper.setActive(arg_13_0._gobreakeffect, true)
		UISpriteSetMgr.instance:setCommonSprite(arg_13_0.imageBreakIcon, "icon_att_" .. var_13_10)

		arg_13_0.txtBreakAttrName.text = EquipHelper.getAttrBreakText(var_13_10)
		arg_13_0.txtBreakValue.text = EquipHelper.getAttrPercentValueStr(var_13_11)

		gohelper.setAsLastSibling(arg_13_0._gobreakeffect)
	else
		gohelper.setActive(arg_13_0._gobreakeffect, false)
	end
end

function var_0_0.refreshSkillInfo(arg_14_0)
	local var_14_0 = EquipHelper.getEquipSkillDescList(arg_14_0.equipMo.config.id, arg_14_0.equipMo.refineLv, "#975129")

	if #var_14_0 == 0 then
		gohelper.setActive(arg_14_0._gobaseskill, false)
	else
		arg_14_0._txtattributelv.text = arg_14_0.equipMo.refineLv

		gohelper.setActive(arg_14_0._gobaseskill, true)

		local var_14_1
		local var_14_2
		local var_14_3

		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			local var_14_4 = arg_14_0._txtDescList[iter_14_0]

			if not var_14_4 then
				local var_14_5 = arg_14_0:getUserDataTb_()
				local var_14_6 = gohelper.cloneInPlace(arg_14_0._txtsuiteffect2.gameObject, "item_" .. iter_14_0)

				var_14_5.itemGo = var_14_6
				var_14_5.txt = var_14_6:GetComponent(gohelper.Type_TextMesh)
				var_14_5.imagepoint = gohelper.findChildImage(var_14_6, "#image_point")
				var_14_4 = var_14_5

				table.insert(arg_14_0._txtDescList, var_14_4)
			end

			var_14_4.txt.text = iter_14_1

			gohelper.setActive(var_14_4.itemGo, true)
		end

		for iter_14_2 = #var_14_0 + 1, #arg_14_0._txtDescList do
			gohelper.setActive(arg_14_0._txtDescList[iter_14_2].itemGo, false)
		end
	end
end

function var_0_0.changeViewGoPosition(arg_15_0)
	local var_15_0 = recthelper.getWidth(arg_15_0.viewGO.transform.parent)

	recthelper.setWidth(arg_15_0.viewGO.transform, var_15_0 / 2 - 100)

	arg_15_0.viewGO.transform.anchorMin = Vector2(1, 0.5)
	arg_15_0.viewGO.transform.anchorMax = Vector2(1, 0.5)

	recthelper.setAnchor(arg_15_0.viewGO.transform, 0, 0)
end

function var_0_0.onClose(arg_16_0)
	arg_16_0.lockClick:RemoveClickListener()
end

function var_0_0.onDestroyView(arg_17_0)
	arg_17_0._simageframe:UnLoadImage()
	arg_17_0._simageequipicon:UnLoadImage()
end

return var_0_0
