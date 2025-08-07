module("modules.logic.sp01.odyssey.view.OdysseyItemTipView", package.seeall)

local var_0_0 = class("OdysseyItemTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goitemTip = gohelper.findChild(arg_1_0.viewGO, "#go_itemTip")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "#go_itemTip/title/#image_rare")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_itemTip/title/#simage_icon")
	arg_1_0._txtitemName = gohelper.findChildText(arg_1_0.viewGO, "#go_itemTip/title/name/#txt_itemName")
	arg_1_0._goequipType = gohelper.findChild(arg_1_0.viewGO, "#go_itemTip/title/name/#go_equipType")
	arg_1_0._txtequipType = gohelper.findChildText(arg_1_0.viewGO, "#go_itemTip/title/name/#go_equipType/#txt_equipType")
	arg_1_0._goequipSuit = gohelper.findChild(arg_1_0.viewGO, "#go_itemTip/#scroll_desc/Viewport/Content/#go_equipSuit")
	arg_1_0._txtsuitName = gohelper.findChildText(arg_1_0.viewGO, "#go_itemTip/#scroll_desc/Viewport/Content/#go_equipSuit/suit/#txt_suitName")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_itemTip/#scroll_desc")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_itemTip/#scroll_desc/Viewport/Content/#txt_desc")
	arg_1_0._txtdesc1 = gohelper.findChildText(arg_1_0.viewGO, "#go_itemTip/#scroll_desc/Viewport/Content/#txt_desc1")
	arg_1_0._btnreplace = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_itemTip/Btn/#btn_replace")
	arg_1_0._btnunload = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_itemTip/Btn/#btn_unload")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_itemTip/Btn/#btn_equip")
	arg_1_0._btnsuit = gohelper.findChildButton(arg_1_0.viewGO, "#go_itemTip/#scroll_desc/Viewport/Content/#go_equipSuit/#btn_suit")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnreplace:AddClickListener(arg_2_0._btnreplaceOnClick, arg_2_0)
	arg_2_0._btnunload:AddClickListener(arg_2_0._btnunloadOnClick, arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._btnequipOnClick, arg_2_0)
	arg_2_0._btnsuit:AddClickListener(arg_2_0._btnsuitOnClick, arg_2_0)
	arg_2_0:addEventCb(OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnreplace:RemoveClickListener()
	arg_3_0._btnunload:RemoveClickListener()
	arg_3_0._btnequip:RemoveClickListener()
	arg_3_0._btnsuit:RemoveClickListener()
	arg_3_0:removeEventCb(OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, arg_3_0.refreshUI, arg_3_0)
end

var_0_0.TipHalfWidth = 419

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnsuitOnClick(arg_5_0)
	local var_5_0 = {
		suitId = arg_5_0.config.suitId,
		bagType = OdysseyEnum.BagType.Bag,
		pos = recthelper.uiPosToScreenPos(arg_5_0._btnsuit.transform)
	}

	OdysseyController.instance:openSuitTipsView(var_5_0)
end

function var_0_0._btnreplaceOnClick(arg_6_0)
	OdysseyHeroGroupController.instance:replaceOdysseyEquip(arg_6_0.heroPos, arg_6_0.equipIndex, arg_6_0.equipUid)
end

function var_0_0._btnunloadOnClick(arg_7_0)
	OdysseyHeroGroupController.instance:unloadOdysseyEquip(arg_7_0.heroPos, arg_7_0.equipIndex)
end

function var_0_0._btnequipOnClick(arg_8_0)
	OdysseyHeroGroupController.instance:setOdysseyEquip(arg_8_0.heroPos, arg_8_0.equipIndex, arg_8_0.equipUid)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._goBtn = gohelper.findChild(arg_9_0.viewGO, "#go_itemTip/Btn")
	arg_9_0._imageicon = gohelper.findChildImage(arg_9_0.viewGO, "#go_itemTip/#scroll_desc/Viewport/Content/#go_equipSuit/suit/icon")
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	if arg_11_0.viewParam and arg_11_0.viewParam.itemId then
		arg_11_0:refreshData(arg_11_0.viewParam)
		arg_11_0:refreshPos()
		arg_11_0:refreshUI()
	end
end

function var_0_0.refreshData(arg_12_0, arg_12_1)
	arg_12_0.viewParam = arg_12_1
	arg_12_0.itemId = arg_12_0.viewParam.itemId
	arg_12_0.clickPos = arg_12_0.viewParam.clickPos
	arg_12_0.constPos = arg_12_0.viewParam.constPos
	arg_12_0.heroPos = arg_12_0.viewParam.heroPos
	arg_12_0.equipUid = arg_12_0.viewParam.equipUid
	arg_12_0.equipIndex = arg_12_0.viewParam.equipIndex
end

function var_0_0.refreshPos(arg_13_0)
	if arg_13_0.clickPos then
		local var_13_0 = GameUtil.checkClickPositionInRight(arg_13_0.clickPos)
		local var_13_1, var_13_2 = recthelper.screenPosToAnchorPos2(arg_13_0.clickPos, arg_13_0.viewGO.transform)
		local var_13_3 = var_13_0 and var_13_1 - var_0_0.TipHalfWidth or var_13_1 + var_0_0.TipHalfWidth

		arg_13_0:setTipPos(var_13_3, var_13_2)
		gohelper.fitScreenOffset(arg_13_0._goitemTip.transform)
	elseif arg_13_0.constPos then
		local var_13_4, var_13_5 = recthelper.screenPosToAnchorPos2(arg_13_0.constPos, arg_13_0.viewGO.transform)

		arg_13_0:setTipPos(var_13_4, var_13_5)
		gohelper.fitScreenOffset(arg_13_0._goitemTip.transform)
	end
end

function var_0_0.refreshUI(arg_14_0)
	arg_14_0:refreshItemInfo()
	arg_14_0:refreshBtnState()
end

function var_0_0.refreshItemInfo(arg_15_0)
	arg_15_0._scrolldesc.verticalNormalizedPosition = 1
	arg_15_0.config = OdysseyConfig.instance:getItemConfig(arg_15_0.itemId)

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_15_0._imagerare, "odyssey_herogroup_quality_" .. tostring(arg_15_0.config.rare))
	gohelper.setActive(arg_15_0._goequipType, arg_15_0.config.type == OdysseyEnum.ItemType.Equip)
	gohelper.setActive(arg_15_0._goequipSuit, arg_15_0.config.type == OdysseyEnum.ItemType.Equip)
	gohelper.setActive(arg_15_0._txtdesc1.gameObject, arg_15_0.config.type == OdysseyEnum.ItemType.Equip)

	arg_15_0._txtitemName.text = arg_15_0.config.name

	if arg_15_0.config.type == OdysseyEnum.ItemType.Item then
		arg_15_0:refreshDesc(arg_15_0._txtdesc, arg_15_0.config.desc)
		arg_15_0._simageicon:LoadImage(ResUrl.getSp01OdysseyItemSingleBg(arg_15_0.config.icon))
	elseif arg_15_0.config.type == OdysseyEnum.ItemType.Equip then
		arg_15_0._simageicon:LoadImage(ResUrl.getSp01OdysseyItemSingleBg(arg_15_0.config.icon))

		local var_15_0 = arg_15_0.config.suitId
		local var_15_1 = OdysseyConfig.instance:getEquipSuitConfig(var_15_0)

		arg_15_0._txtsuitName.text = var_15_1.name

		arg_15_0:refreshDesc(arg_15_0._txtdesc, arg_15_0.config.skillDesc)
		arg_15_0:refreshDesc(arg_15_0._txtdesc1, arg_15_0.config.desc)

		local var_15_2 = luaLang(OdysseyEnum.EquipTypeLang[arg_15_0.config.rare])
		local var_15_3 = OdysseyEnum.EquipRareColor[arg_15_0.config.rare]

		arg_15_0._txtequipType.text = string.format("<color=%s>%s</color>", var_15_3, var_15_2)

		UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_15_0._imageicon, var_15_1.icon)
	end
end

function var_0_0.refreshDesc(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1.text = SkillHelper.buildDesc(arg_16_2)

	local var_16_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_16_1.gameObject, FixTmpBreakLine)

	SkillHelper.addHyperLinkClick(arg_16_1, arg_16_0._onHyperLinkClick, arg_16_0)
	var_16_0:refreshTmpContent(arg_16_1)
end

function var_0_0._onHyperLinkClick(arg_17_0, arg_17_1, arg_17_2)
	CommonBuffTipController.instance:openCommonTipView(tonumber(arg_17_1), arg_17_2)
end

function var_0_0.refreshBtnState(arg_18_0)
	local var_18_0 = arg_18_0.equipUid == nil or arg_18_0.equipUid == 0

	gohelper.setActive(arg_18_0._goBtn, not var_18_0)

	if var_18_0 then
		return
	end

	local var_18_1 = OdysseyHeroGroupModel.instance:getCurHeroGroup()
	local var_18_2 = arg_18_0.heroPos
	local var_18_3 = arg_18_0.equipIndex
	local var_18_4 = var_18_1:getOdysseyEquips(var_18_2 - 1).equipUid[var_18_3]
	local var_18_5
	local var_18_6 = arg_18_0.equipUid

	if var_18_4 == nil or var_18_4 == 0 then
		var_18_5 = OdysseyEnum.EquipOptionType.Equip
	elseif var_18_4 == var_18_6 then
		var_18_5 = OdysseyEnum.EquipOptionType.Unload
	else
		var_18_5 = OdysseyEnum.EquipOptionType.Replace
	end

	gohelper.setActive(arg_18_0._btnequip, var_18_5 == OdysseyEnum.EquipOptionType.Equip)
	gohelper.setActive(arg_18_0._btnunload, var_18_5 == OdysseyEnum.EquipOptionType.Unload)
	gohelper.setActive(arg_18_0._btnreplace, var_18_5 == OdysseyEnum.EquipOptionType.Replace)
end

function var_0_0.setTipPos(arg_19_0, arg_19_1, arg_19_2)
	transformhelper.setLocalPosXY(arg_19_0._goitemTip.transform, arg_19_1, arg_19_2)
end

function var_0_0.onClose(arg_20_0)
	arg_20_0._simageicon:UnLoadImage()
end

function var_0_0.onDestroyView(arg_21_0)
	return
end

return var_0_0
