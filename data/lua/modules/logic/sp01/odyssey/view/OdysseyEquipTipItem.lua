module("modules.logic.sp01.odyssey.view.OdysseyEquipTipItem", package.seeall)

local var_0_0 = class("OdysseyEquipTipItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
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

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnreplace:AddClickListener(arg_2_0._btnreplaceOnClick, arg_2_0)
	arg_2_0._btnunload:AddClickListener(arg_2_0._btnunloadOnClick, arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._btnequipOnClick, arg_2_0)
	arg_2_0._btnsuit:AddClickListener(arg_2_0._btnsuitOnClick, arg_2_0)
	arg_2_0:addEventCb(OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnreplace:RemoveClickListener()
	arg_3_0._btnunload:RemoveClickListener()
	arg_3_0._btnequip:RemoveClickListener()
	arg_3_0._btnsuit:RemoveClickListener()
	arg_3_0:removeEventCb(OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, arg_3_0.refreshUI, arg_3_0)
end

var_0_0.TipHalfWidth = 419

function var_0_0._btncloseOnClick(arg_4_0)
	OdysseyController.instance:dispatchEvent(OdysseyEvent.OnTipSubViewClose)
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
	arg_9_0._anim = arg_9_0.viewGO:GetComponent(gohelper.Type_Animator)
end

function var_0_0.setData(arg_10_0, arg_10_1)
	arg_10_0.param = arg_10_1
	arg_10_0.itemId = arg_10_0.param.itemId
	arg_10_0.heroPos = arg_10_0.param.heroPos
	arg_10_0.equipUid = arg_10_0.param.equipUid
	arg_10_0.equipIndex = arg_10_0.param.equipIndex

	arg_10_0:refreshUI()
	arg_10_0:showOpenAnim()
end

function var_0_0.refreshUI(arg_11_0)
	arg_11_0:refreshItemInfo()
	arg_11_0:refreshBtnState()
end

function var_0_0.refreshItemInfo(arg_12_0)
	arg_12_0._scrolldesc.verticalNormalizedPosition = 1
	arg_12_0.config = OdysseyConfig.instance:getItemConfig(arg_12_0.itemId)

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_12_0._imagerare, "odyssey_herogroup_quality_" .. tostring(arg_12_0.config.rare))
	gohelper.setActive(arg_12_0._goequipType, arg_12_0.config.type == OdysseyEnum.ItemType.Equip)
	gohelper.setActive(arg_12_0._goequipSuit, arg_12_0.config.type == OdysseyEnum.ItemType.Equip)
	gohelper.setActive(arg_12_0._txtdesc1.gameObject, arg_12_0.config.type == OdysseyEnum.ItemType.Equip)

	arg_12_0._txtitemName.text = arg_12_0.config.name

	if arg_12_0.config.type == OdysseyEnum.ItemType.Item then
		arg_12_0:refreshDesc(arg_12_0._txtdesc, arg_12_0.config.desc)
		arg_12_0._simageicon:LoadImage(ResUrl.getPropItemIcon(arg_12_0.config.icon))
	elseif arg_12_0.config.type == OdysseyEnum.ItemType.Equip then
		arg_12_0._simageicon:LoadImage(ResUrl.getSp01OdysseyItemSingleBg(arg_12_0.config.icon))

		local var_12_0 = arg_12_0.config.suitId
		local var_12_1 = OdysseyConfig.instance:getEquipSuitConfig(var_12_0)

		arg_12_0._txtsuitName.text = var_12_1.name

		arg_12_0:refreshDesc(arg_12_0._txtdesc, arg_12_0.config.skillDesc)
		arg_12_0:refreshDesc(arg_12_0._txtdesc1, arg_12_0.config.desc)

		local var_12_2 = luaLang(OdysseyEnum.EquipTypeLang[arg_12_0.config.rare])
		local var_12_3 = OdysseyEnum.EquipRareColor[arg_12_0.config.rare]

		arg_12_0._txtequipType.text = string.format("<color=%s>%s</color>", var_12_3, var_12_2)

		UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_12_0._imageicon, var_12_1.icon)
	end
end

function var_0_0.refreshDesc(arg_13_0, arg_13_1, arg_13_2)
	arg_13_1.text = SkillHelper.buildDesc(arg_13_2)

	local var_13_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_13_1.gameObject, FixTmpBreakLine)

	SkillHelper.addHyperLinkClick(arg_13_1, arg_13_0._onHyperLinkClick, arg_13_0)
	var_13_0:refreshTmpContent(arg_13_1)
end

function var_0_0._onHyperLinkClick(arg_14_0, arg_14_1, arg_14_2)
	CommonBuffTipController.instance:openCommonTipView(tonumber(arg_14_1), arg_14_2)
end

function var_0_0.refreshBtnState(arg_15_0)
	local var_15_0 = arg_15_0.equipUid == nil or arg_15_0.equipUid == 0

	gohelper.setActive(arg_15_0._goBtn, not var_15_0)

	if var_15_0 then
		return
	end

	local var_15_1 = OdysseyHeroGroupModel.instance:getCurHeroGroup()
	local var_15_2 = arg_15_0.heroPos
	local var_15_3 = arg_15_0.equipIndex
	local var_15_4 = var_15_1:getOdysseyEquips(var_15_2 - 1).equipUid[var_15_3]
	local var_15_5
	local var_15_6 = arg_15_0.equipUid

	if var_15_4 == nil or var_15_4 == 0 then
		var_15_5 = OdysseyEnum.EquipOptionType.Equip
	elseif var_15_4 == var_15_6 then
		var_15_5 = OdysseyEnum.EquipOptionType.Unload
	else
		var_15_5 = OdysseyEnum.EquipOptionType.Replace
	end

	gohelper.setActive(arg_15_0._btnequip, var_15_5 == OdysseyEnum.EquipOptionType.Equip)
	gohelper.setActive(arg_15_0._btnunload, var_15_5 == OdysseyEnum.EquipOptionType.Unload)
	gohelper.setActive(arg_15_0._btnreplace, var_15_5 == OdysseyEnum.EquipOptionType.Replace)
end

function var_0_0.setActive(arg_16_0, arg_16_1)
	gohelper.setActive(arg_16_0.viewGO, arg_16_1)
end

function var_0_0.showOpenAnim(arg_17_0)
	if arg_17_0.curItemUid ~= arg_17_0.equipUid then
		arg_17_0._anim:Play("open", 0, 0)
		arg_17_0._anim:Update(0)

		arg_17_0.curItemUid = arg_17_0.equipUid
	end
end

function var_0_0.onClose(arg_18_0)
	arg_18_0._simageicon:UnLoadImage()
end

function var_0_0.onDestroyView(arg_19_0)
	return
end

return var_0_0
