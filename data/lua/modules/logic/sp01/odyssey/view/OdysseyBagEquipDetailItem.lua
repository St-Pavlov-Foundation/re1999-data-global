module("modules.logic.sp01.odyssey.view.OdysseyBagEquipDetailItem", package.seeall)

local var_0_0 = class("OdysseyBagEquipDetailItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "#image_rare")
	arg_1_0._txtitemName = gohelper.findChildText(arg_1_0.viewGO, "#txt_itemName")
	arg_1_0._imageSuitIcon = gohelper.findChildImage(arg_1_0.viewGO, "#go_equipSuit/suit/icon")
	arg_1_0._txtequipType = gohelper.findChildText(arg_1_0.viewGO, "equipType/#txt_equipType")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_icon")
	arg_1_0._goequipSuit = gohelper.findChild(arg_1_0.viewGO, "#go_equipSuit")
	arg_1_0._txtsuitName = gohelper.findChildText(arg_1_0.viewGO, "#go_equipSuit/suit/#txt_suitName")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_desc")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#scroll_desc/Viewport/Content/#txt_desc")
	arg_1_0._txtdesc1 = gohelper.findChildText(arg_1_0.viewGO, "#scroll_desc/Viewport/Content/#txt_desc1")
	arg_1_0._btnSuit = gohelper.findChildButton(arg_1_0.viewGO, "#btn_suit")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	return
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnSuit:AddClickListener(arg_3_0.onClickSuit, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnSuit:RemoveClickListener()
end

function var_0_0.onClickSuit(arg_5_0)
	local var_5_0 = {
		suitId = arg_5_0.mo.config.suitId,
		bagType = OdysseyEnum.BagType.Bag,
		pos = recthelper.uiPosToScreenPos(arg_5_0._btnSuit.transform)
	}

	OdysseyController.instance:openSuitTipsView(var_5_0)
end

function var_0_0.setInfo(arg_6_0, arg_6_1)
	arg_6_0.mo = arg_6_1

	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	local var_7_0 = arg_7_0.mo.config

	if var_7_0.type == OdysseyEnum.ItemType.Item then
		arg_7_0._simageicon:LoadImage(ResUrl.getPropItemIcon(var_7_0.icon))
	elseif var_7_0.type == OdysseyEnum.ItemType.Equip then
		arg_7_0._simageicon:LoadImage(ResUrl.getSp01OdysseyItemSingleBg(var_7_0.icon))
	end

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_7_0._imagerare, "odyssey_herogroup_quality_" .. var_7_0.rare)

	arg_7_0._txtdesc.text = var_7_0.skillDesc
	arg_7_0._txtitemName.text = var_7_0.name
	arg_7_0._txtdesc1.text = var_7_0.desc

	local var_7_1 = luaLang(OdysseyEnum.EquipTypeLang[var_7_0.rare])
	local var_7_2 = OdysseyEnum.EquipRareColor[var_7_0.rare]

	arg_7_0._txtequipType.text = string.format("<color=%s>%s</color>", var_7_2, var_7_1)

	local var_7_3 = OdysseyConfig.instance:getEquipSuitConfig(var_7_0.suitId)

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_7_0._imageSuitIcon, var_7_3.icon)

	if var_7_3 then
		arg_7_0._txtsuitName.text = var_7_3.name
	end
end

function var_0_0.onDestroy(arg_8_0)
	return
end

return var_0_0
