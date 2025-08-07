module("modules.logic.sp01.odyssey.view.OdysseySuitTipView", package.seeall)

local var_0_0 = class("OdysseySuitTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gosuitTip = gohelper.findChild(arg_1_0.viewGO, "#go_suitTip")
	arg_1_0._goequipSuit = gohelper.findChild(arg_1_0.viewGO, "#go_suitTip/#go_equipSuit")
	arg_1_0._gouneffect = gohelper.findChild(arg_1_0.viewGO, "#go_suitTip/#go_equipSuit/#go_uneffect")
	arg_1_0._txtsuitName = gohelper.findChildText(arg_1_0.viewGO, "#go_suitTip/#go_equipSuit/#go_uneffect/#txt_suitName")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_suitTip/#go_equipSuit/#go_uneffect/#image_icon")
	arg_1_0._goeffect = gohelper.findChild(arg_1_0.viewGO, "#go_suitTip/#go_equipSuit/#go_effect")
	arg_1_0._txtsuitNameEffect = gohelper.findChildText(arg_1_0.viewGO, "#go_suitTip/#go_equipSuit/#go_effect/#txt_suitNameEffect")
	arg_1_0._imageiconEffect = gohelper.findChildImage(arg_1_0.viewGO, "#go_suitTip/#go_equipSuit/#go_effect/#image_iconEffect")
	arg_1_0._goactiveBg = gohelper.findChild(arg_1_0.viewGO, "#go_suitTip/#go_equipSuit/#go_effect/#go_activeBg")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_suitTip/#scroll_desc")
	arg_1_0._txtdesc1 = gohelper.findChildText(arg_1_0.viewGO, "#go_suitTip/#scroll_desc/Viewport/Content/#txt_desc1")
	arg_1_0._txtdesc2 = gohelper.findChildText(arg_1_0.viewGO, "#go_suitTip/#scroll_desc/Viewport/Content/#txt_desc2")

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

var_0_0.TipHalfWidth = 430
var_0_0.TipOffsetY = -100

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._descItem = arg_5_0:getUserDataTb_()

	gohelper.setActive(arg_5_0._txtdesc2.gameObject, false)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam
	local var_7_1 = var_7_0.suitId
	local var_7_2 = var_7_0.level
	local var_7_3 = var_7_0.bagType
	local var_7_4 = OdysseyConfig.instance:getEquipSuitConfig(var_7_1)
	local var_7_5 = OdysseyHeroGroupModel.instance:getCurHeroGroup()

	if var_7_2 == nil then
		local var_7_6 = var_7_5:getOdysseyEquipSuit(var_7_1)

		var_7_2 = var_7_6 and var_7_6.level or 0
	end

	local var_7_7 = var_7_3 == OdysseyEnum.BagType.Bag or var_7_2 > 0
	local var_7_8 = not var_7_7 and arg_7_0._txtsuitName or arg_7_0._txtsuitNameEffect
	local var_7_9 = not var_7_7 and arg_7_0._imageicon or arg_7_0._imageiconEffect

	var_7_8.text = var_7_4.name

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(var_7_9, var_7_4.icon)

	arg_7_0._txtdesc1.text = var_7_4.desc

	gohelper.setActive(arg_7_0._goeffect, var_7_7)
	gohelper.setActive(arg_7_0._gouneffect, not var_7_7)
	gohelper.setActive(arg_7_0._goactiveBg, var_7_3 ~= OdysseyEnum.BagType.Bag)

	local var_7_10 = OdysseyConfig.instance:getEquipSuitAllEffect(var_7_1)
	local var_7_11 = arg_7_0._descItem
	local var_7_12 = #var_7_11
	local var_7_13 = #var_7_10

	for iter_7_0 = 1, var_7_13 do
		local var_7_14 = var_7_10[iter_7_0]
		local var_7_15

		if var_7_12 < iter_7_0 then
			local var_7_16 = gohelper.clone(arg_7_0._txtdesc2.gameObject, arg_7_0._txtdesc2.gameObject.transform.parent.gameObject)

			var_7_15 = gohelper.findChildText(var_7_16, "")

			table.insert(var_7_11, var_7_15)
		else
			var_7_15 = var_7_11[iter_7_0]
		end

		gohelper.setActive(var_7_15, true)

		local var_7_17 = var_7_3 == OdysseyEnum.BagType.Bag or var_7_2 >= var_7_14.level

		var_7_15.text = SkillHelper.buildDesc(var_7_14.effect)

		local var_7_18 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_15.gameObject, FixTmpBreakLine)

		SkillHelper.addHyperLinkClick(var_7_15, arg_7_0._onHyperLinkClick, arg_7_0)
		var_7_18:refreshTmpContent(var_7_15)

		if var_7_17 then
			var_7_15.text = string.format("<color=%s>%s</color>", OdysseyEnum.SuitDescColor.Active, var_7_15.text)
		end
	end

	if var_7_13 < var_7_12 then
		for iter_7_1 = var_7_13 + 1, var_7_12 do
			gohelper.setActive(var_7_11[iter_7_1], false)
		end
	end

	if var_7_0.pos then
		local var_7_19, var_7_20 = recthelper.screenPosToAnchorPos2(var_7_0.pos, arg_7_0.viewGO.transform)
		local var_7_21 = var_7_19 - var_0_0.TipHalfWidth
		local var_7_22 = var_7_20 + var_0_0.TipOffsetY

		arg_7_0:setTipPos(var_7_21, var_7_22)
		gohelper.fitScreenOffset(arg_7_0._gosuitTip.transform)
	end
end

function var_0_0._onHyperLinkClick(arg_8_0, arg_8_1, arg_8_2)
	CommonBuffTipController.instance:openCommonTipView(tonumber(arg_8_1), arg_8_2)
end

function var_0_0.setTipPos(arg_9_0, arg_9_1, arg_9_2)
	transformhelper.setLocalPosXY(arg_9_0._gosuitTip.transform, arg_9_1, arg_9_2)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
