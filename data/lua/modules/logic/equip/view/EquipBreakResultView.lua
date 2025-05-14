module("modules.logic.equip.view.EquipBreakResultView", package.seeall)

local var_0_0 = class("EquipBreakResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._simageequip = gohelper.findChildSingleImage(arg_1_0.viewGO, "center/#simage_equip")
	arg_1_0._imagelock = gohelper.findChildImage(arg_1_0.viewGO, "center/#image_lock")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "center/#txt_name")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "center/#txt_num")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_righttop")
	arg_1_0._image1 = gohelper.findChildImage(arg_1_0.viewGO, "right/container/go_insigt/#image_1")
	arg_1_0._image2 = gohelper.findChildImage(arg_1_0.viewGO, "right/container/go_insigt/#image_2")
	arg_1_0._image3 = gohelper.findChildImage(arg_1_0.viewGO, "right/container/go_insigt/#image_3")
	arg_1_0._image4 = gohelper.findChildImage(arg_1_0.viewGO, "right/container/go_insigt/#image_4")
	arg_1_0._image5 = gohelper.findChildImage(arg_1_0.viewGO, "right/container/go_insigt/#image_5")
	arg_1_0._gostrengthenattr = gohelper.findChild(arg_1_0.viewGO, "right/container/#go_strengthenattr")
	arg_1_0._gobreakattr = gohelper.findChild(arg_1_0.viewGO, "right/container/#go_breakattr")
	arg_1_0._txtmeshsuiteffect = gohelper.findChildTextMesh(arg_1_0.viewGO, "right/suiteffect/#txtmesh_suiteffect")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

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

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getCommonViewBg("full/zhuangbei_006"))

	arg_5_0._strengthenattrs = arg_5_0:getUserDataTb_()
	arg_5_0._attrIndex = 1
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._equipMO = arg_7_0.viewParam[1]
	arg_7_0._prevLv = arg_7_0.viewParam[2]
	arg_7_0._prevBreakLv = arg_7_0.viewParam[3]
	arg_7_0._config = arg_7_0._equipMO.config
	arg_7_0._lock = arg_7_0._equipMO.isLock

	if arg_7_0._config.isExpEquip == 1 then
		arg_7_0._imagelock.gameObject:SetActive(false)
	else
		UISpriteSetMgr.instance:setEquipSprite(arg_7_0._imagelock, arg_7_0._lock and "bg_tips_suo" or "bg_tips_jiesuo", true)
	end

	for iter_7_0 = 1, 5 do
		UISpriteSetMgr.instance:setEquipSprite(arg_7_0["_image" .. iter_7_0], iter_7_0 <= arg_7_0._equipMO.breakLv and "xx_11" or "xx_10")
	end

	arg_7_0._simageequip:LoadImage(ResUrl.getEquipSuit(arg_7_0._config.icon))

	arg_7_0._txtname.text = arg_7_0._config.name

	local var_7_0, var_7_1, var_7_2, var_7_3, var_7_4 = EquipConfig.instance:getEquipStrengthenAttr(arg_7_0._equipMO, nil, arg_7_0._prevLv, arg_7_0._prevBreakLv)
	local var_7_5, var_7_6, var_7_7, var_7_8, var_7_9 = EquipConfig.instance:getEquipStrengthenAttr(arg_7_0._equipMO, nil, arg_7_0._equipMO.level, arg_7_0._equipMO.breakLv)

	for iter_7_1, iter_7_2 in pairs(lua_character_attribute.configDict) do
		if iter_7_2.type == 2 or iter_7_2.type == 3 then
			EquipController.instance.showAttr(arg_7_0, iter_7_1, iter_7_2.showType, var_7_9[iter_7_2.attrType], var_7_4[iter_7_2.attrType])
		end
	end

	arg_7_0:showLevelInfo()
end

function var_0_0.showLevelInfo(arg_8_0)
	gohelper.setActive(arg_8_0._gobreakattr, true)

	local var_8_0 = gohelper.findChildText(arg_8_0._gobreakattr, "txt_value")
	local var_8_1 = gohelper.findChildText(arg_8_0._gobreakattr, "txt_prevvalue")

	var_8_0.text = EquipConfig.instance:getMaxLevel(arg_8_0._equipMO.breakLv)
	var_8_1.text = EquipConfig.instance:getMaxLevel(arg_8_0._prevBreakLv)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simagebg:UnLoadImage()
	arg_10_0._simageequip:UnLoadImage()
end

return var_0_0
