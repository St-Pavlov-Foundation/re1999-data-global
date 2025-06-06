﻿module("modules.logic.stresstip.view.StressTipView", package.seeall)

local var_0_0 = class("StressTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._scrollenemystress = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_enemystress")
	arg_1_0._goenemystressitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_enemystress/viewport/content/#go_enemystressitem")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#scroll_enemystress/viewport/content/#go_enemystressitem/layout/#txt_title")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "#scroll_enemystress/viewport/content/#go_enemystressitem/#txt_dec")
	arg_1_0._gorolestressitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_enemystress/viewport/content/#go_rolestressitem")
	arg_1_0._herotiptxt = gohelper.findChildText(arg_1_0.viewGO, "#scroll_enemystress/viewport/content/#go_rolestressitem/#txt_title")
	arg_1_0._goroletip = gohelper.findChild(arg_1_0.viewGO, "#go_rolestresstip")
	arg_1_0._goroletiptxt = gohelper.findChildText(arg_1_0.viewGO, "#go_rolestresstip/#txt_roletip")
	arg_1_0._btnclosedetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closetip")
	arg_1_0._goclosetip = arg_1_0._btnclosedetail.gameObject

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnclosedetail:AddClickListener(arg_2_0._btnclosedetailOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnclosedetail:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnclosedetailOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._goclosetip, false)
	gohelper.setActive(arg_5_0._goroletip, false)
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._gorolestressitem, false)
	gohelper.setActive(arg_6_0._goenemystressitem, false)
	gohelper.setActive(arg_6_0._goclosetip, false)
	gohelper.setActive(arg_6_0._goroletip, false)

	arg_6_0.heroTipHyperLinkClick = gohelper.onceAddComponent(arg_6_0._herotiptxt, typeof(ZProj.TMPHyperLinkClick))

	arg_6_0.heroTipHyperLinkClick:SetClickListener(arg_6_0.onClickHeroTip, arg_6_0)

	arg_6_0.enemyStressItemList = {}
	arg_6_0.rectTrEnemy = arg_6_0._scrollenemystress:GetComponent(gohelper.Type_RectTransform)
	arg_6_0.rectTrViewGo = arg_6_0.viewGO:GetComponent(gohelper.Type_RectTransform)
	arg_6_0.rectRoleTip = arg_6_0._goroletip:GetComponent(gohelper.Type_RectTransform)
	arg_6_0.enemyScrollWidth = recthelper.getWidth(arg_6_0.rectTrEnemy)
end

function var_0_0.onClickHeroTip(arg_7_0, arg_7_1)
	local var_7_0 = lua_stress_identity.configDict[tonumber(arg_7_1)]

	if not var_7_0 then
		return
	end

	local var_7_1 = string.format("<color=#d2c197>%s</color>", var_7_0.name)

	arg_7_0._goroletiptxt.text = var_7_1 .. "\n" .. var_7_0.desc

	gohelper.setActive(arg_7_0._goclosetip, true)
	gohelper.setActive(arg_7_0._goroletip, true)
	ZProj.UGUIHelper.RebuildLayout(arg_7_0.rectRoleTip)

	local var_7_2 = recthelper.getHeight(arg_7_0.rectRoleTip)
	local var_7_3 = recthelper.getAnchorX(arg_7_0.rectTrEnemy)
	local var_7_4 = recthelper.getAnchorY(arg_7_0.rectTrEnemy)
	local var_7_5 = 10
	local var_7_6 = var_7_4 + var_7_2 + var_7_5

	recthelper.setAnchor(arg_7_0.rectRoleTip, var_7_3, var_7_6)
end

var_0_0.OpenEnum = {
	Monster = 1,
	Hero = 2
}

function var_0_0.onOpen(arg_8_0)
	arg_8_0.openEnum = arg_8_0.viewParam.openEnum
	arg_8_0.co = arg_8_0.viewParam.co
	arg_8_0.clickPosition = arg_8_0.viewParam.clickPosition

	arg_8_0:refreshHero()
	arg_8_0:refreshEnemy()
end

var_0_0.StressBehaviourList = {
	FightEnum.StressBehaviour.Positive,
	FightEnum.StressBehaviour.Negative,
	FightEnum.StressBehaviour.Meltdown,
	FightEnum.StressBehaviour.Resolute,
	FightEnum.StressBehaviour.BaseAdd,
	FightEnum.StressBehaviour.BaseReduce,
	FightEnum.StressBehaviour.BaseResolute,
	FightEnum.StressBehaviour.BaseMeltdown
}

function var_0_0.refreshEnemy(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.enemyStressItemList) do
		gohelper.setActive(iter_9_1.go, false)
	end

	local var_9_0

	if arg_9_0.openEnum == var_0_0.OpenEnum.Monster then
		local var_9_1 = lua_monster_skill_template.configDict[arg_9_0.co.skillTemplate]

		var_9_0 = var_9_1 and var_9_1.identity
	else
		var_9_0 = 1001
	end

	local var_9_2 = StressConfig.instance:getStressDict(var_9_0)

	if not var_9_2 then
		logError(string.format("压力表，身份类型 ： %s 不存在", var_9_0))

		return
	end

	local var_9_3 = 0

	for iter_9_2, iter_9_3 in ipairs(arg_9_0.StressBehaviourList) do
		local var_9_4 = var_9_2[FightEnum.StressBehaviourString[iter_9_3]]

		if var_9_4 then
			var_9_3 = var_9_3 + 1

			local var_9_5 = arg_9_0:getEnemyStressItem(var_9_3)

			gohelper.setActive(var_9_5.go, true)

			var_9_5.txtTitle.text = StressConfig.instance:getStressBehaviourName(iter_9_3)

			arg_9_0:refreshEnemyDesc(var_9_5, var_9_4)
		end
	end

	arg_9_0:setRectTrLayout(arg_9_0.rectTrEnemy)
end

function var_0_0.refreshEnemyDesc(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(arg_10_2) do
		local var_10_1 = lua_stress_rule.configDict[tonumber(iter_10_1.rule)]

		if var_10_1 and var_10_1.isNoShow ~= 1 then
			var_10_0 = var_10_0 + 1

			local var_10_2 = arg_10_0:getEnemyStressDescItem(arg_10_1, var_10_0)

			gohelper.setActive(var_10_2.goDesc, true)

			var_10_2.txtDesc.text = "<nobr>" .. SkillHelper.buildDesc(var_10_1.desc)
		end
	end

	if var_10_0 < 1 then
		gohelper.setActive(arg_10_1.go, false)
	else
		local var_10_3 = arg_10_1.descItemList

		for iter_10_2 = var_10_0 + 1, #var_10_3 do
			gohelper.setActive(var_10_3[iter_10_2].goDesc, false)
		end
	end
end

function var_0_0.refreshHero(arg_11_0)
	gohelper.setActive(arg_11_0._gorolestressitem, arg_11_0.openEnum == var_0_0.OpenEnum.Hero)

	if arg_11_0.openEnum ~= var_0_0.OpenEnum.Hero then
		return
	end

	local var_11_0 = StressConfig.instance:getHeroTip()
	local var_11_1 = StressConfig.instance:getHeroIdentityText(arg_11_0.co)
	local var_11_2 = GameUtil.getSubPlaceholderLuaLangOneParam(var_11_0, var_11_1)

	arg_11_0._herotiptxt.text = var_11_2
end

function var_0_0.getEnemyStressItem(arg_12_0, arg_12_1)
	if arg_12_1 <= #arg_12_0.enemyStressItemList then
		return arg_12_0.enemyStressItemList[arg_12_1]
	end

	local var_12_0 = arg_12_0:getUserDataTb_()

	var_12_0.go = gohelper.cloneInPlace(arg_12_0._goenemystressitem)
	var_12_0.txtTitle = gohelper.findChildText(var_12_0.go, "layout/#txt_title")
	var_12_0.descItemList = {}

	table.insert(arg_12_0.enemyStressItemList, var_12_0)

	local var_12_1 = arg_12_0:getUserDataTb_()

	var_12_1.txtDesc = gohelper.findChildText(var_12_0.go, "#txt_dec")
	var_12_1.goDesc = var_12_1.txtDesc.gameObject

	SkillHelper.addHyperLinkClick(var_12_1.txtDesc, arg_12_0.onClickDescHyperLink, arg_12_0)
	table.insert(var_12_0.descItemList, var_12_1)

	return var_12_0
end

function var_0_0.getEnemyStressDescItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1.descItemList

	if arg_13_2 <= #var_13_0 then
		return var_13_0[arg_13_2]
	end

	local var_13_1 = arg_13_1.descItemList[1].goDesc
	local var_13_2 = arg_13_0:getUserDataTb_()

	var_13_2.goDesc = gohelper.cloneInPlace(var_13_1)
	var_13_2.txtDesc = var_13_2.goDesc:GetComponent(gohelper.Type_TextMesh)

	SkillHelper.addHyperLinkClick(var_13_2.txtDesc, arg_13_0.onClickDescHyperLink, arg_13_0)
	table.insert(var_13_0, var_13_2)

	return var_13_2
end

var_0_0.DefaultIntervalX = 10
var_0_0.MaxScrollHeight = 535

function var_0_0.setRectTrLayout(arg_14_0, arg_14_1)
	local var_14_0, var_14_1 = GameUtil.getViewSize()
	local var_14_2 = GameUtil.checkClickPositionInRight(arg_14_0.clickPosition)
	local var_14_3, var_14_4 = recthelper.screenPosToAnchorPos2(arg_14_0.clickPosition, arg_14_0.rectTrViewGo)

	if var_14_2 then
		var_14_3 = var_14_3 - var_0_0.DefaultIntervalX
	else
		var_14_3 = var_14_3 + recthelper.getWidth(arg_14_1) + var_0_0.DefaultIntervalX
	end

	recthelper.setAnchor(arg_14_1, var_14_3, var_14_4)

	local var_14_5 = var_14_1 - math.abs(var_14_4)
	local var_14_6 = math.min(var_0_0.MaxScrollHeight, var_14_5)

	recthelper.setHeight(arg_14_1, var_14_6)
end

function var_0_0.onClickDescHyperLink(arg_15_0, arg_15_1, arg_15_2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(arg_15_1, arg_15_0.setScrollPosCallback, arg_15_0)
end

var_0_0.ScrollTipIntervalX = 10

function var_0_0.setScrollPosCallback(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0, var_16_1 = GameUtil.getViewSize()
	local var_16_2 = var_16_0 / 2
	local var_16_3 = var_16_1 / 2
	local var_16_4 = recthelper.getAnchorX(arg_16_0.rectTrEnemy)
	local var_16_5 = recthelper.getAnchorY(arg_16_0.rectTrEnemy)
	local var_16_6 = var_16_0 - math.abs(var_16_4) - arg_16_0.enemyScrollWidth - arg_16_0.ScrollTipIntervalX
	local var_16_7 = var_16_6 >= recthelper.getWidth(arg_16_2)

	arg_16_2.pivot = CommonBuffTipEnum.Pivot.Right

	if var_16_7 then
		var_16_4 = var_16_6 - var_16_2
	else
		var_16_4 = var_16_2 - math.abs(var_16_4) + arg_16_0.enemyScrollWidth + arg_16_0.ScrollTipIntervalX
	end

	local var_16_8 = var_16_5 + var_16_3

	recthelper.setAnchor(arg_16_2, var_16_4, var_16_8)
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

return var_0_0
