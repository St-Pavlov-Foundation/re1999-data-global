module("modules.logic.enemyinfo.view.EnemyInfoLayoutView", package.seeall)

local var_0_0 = class("EnemyInfoLayoutView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.goTabContainer = gohelper.findChild(arg_4_0.viewGO, "#go_tab_container")
	arg_4_0.rectTrLeftContainer = gohelper.findChildComponent(arg_4_0.viewGO, "#go_left_container", gohelper.Type_RectTransform)
	arg_4_0.rectTrLine = gohelper.findChildComponent(arg_4_0.viewGO, "#go_line", gohelper.Type_RectTransform)
	arg_4_0.rectTrRightContainer = gohelper.findChildComponent(arg_4_0.viewGO, "#go_right_container", gohelper.Type_RectTransform)
	arg_4_0.rectTrRuleContainer = gohelper.findChildComponent(arg_4_0.viewGO, "#go_left_container/#go_rule_container", gohelper.Type_RectTransform)
	arg_4_0.rectTrLeftLine1 = gohelper.findChildComponent(arg_4_0.viewGO, "#go_left_container/#go_line1", gohelper.Type_RectTransform)
	arg_4_0.rectTrScrollEnemy = gohelper.findChildComponent(arg_4_0.viewGO, "#go_left_container/#scroll_enemy", gohelper.Type_RectTransform)
	arg_4_0.rectTrLeftLine2 = gohelper.findChildComponent(arg_4_0.viewGO, "#go_left_container/#go_line2", gohelper.Type_RectTransform)
	arg_4_0.rectTrCareerContainer = gohelper.findChildComponent(arg_4_0.viewGO, "#go_left_container/#go_career_container", gohelper.Type_RectTransform)
	arg_4_0.rectTrHeader = gohelper.findChildComponent(arg_4_0.viewGO, "#go_right_container/#go_header", gohelper.Type_RectTransform)
	arg_4_0.rectTrRightLine1 = gohelper.findChildComponent(arg_4_0.viewGO, "#go_right_container/#go_line1", gohelper.Type_RectTransform)
	arg_4_0.rectTrEnemyInfo = gohelper.findChildComponent(arg_4_0.viewGO, "#go_right_container/#scroll_enemyinfo", gohelper.Type_RectTransform)
	arg_4_0.rectTrRightLine2 = gohelper.findChildComponent(arg_4_0.viewGO, "#go_right_container/#go_line2", gohelper.Type_RectTransform)
	arg_4_0.rectTrSkillContainer = gohelper.findChildComponent(arg_4_0.viewGO, "#go_right_container/#go_skill_container", gohelper.Type_RectTransform)
	arg_4_0.rectTrEnemyInfoContent = gohelper.findChildComponent(arg_4_0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent", gohelper.Type_RectTransform)
	arg_4_0.rectTrDesc = gohelper.findChildComponent(arg_4_0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#txt_desc", gohelper.Type_RectTransform)
	arg_4_0.rectTrBossSpecialSkill = gohelper.findChildComponent(arg_4_0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_bossspecialskill", gohelper.Type_RectTransform)
	arg_4_0.rectTrResistance = gohelper.findChildComponent(arg_4_0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_resistance", gohelper.Type_RectTransform)
	arg_4_0.rectTrPassiveSkill = gohelper.findChildComponent(arg_4_0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_passiveskill", gohelper.Type_RectTransform)
	arg_4_0.viewRectTr = arg_4_0.viewGO:GetComponent(gohelper.Type_RectTransform)

	arg_4_0:addEventCb(EnemyInfoController.instance, EnemyInfoEvent.UpdateBattleInfo, arg_4_0.onUpdateBattleInfo, arg_4_0)
end

function var_0_0.onUpdateBattleInfo(arg_5_0, arg_5_1)
	if arg_5_0.battleId == arg_5_1 then
		return
	end

	arg_5_0.battleId = arg_5_1

	arg_5_0.layoutMo:updateLayout(recthelper.getWidth(arg_5_0.viewRectTr), arg_5_0.enemyInfoMo.showLeftTab)
	arg_5_0:updateRuleCount()

	if arg_5_0.layouted then
		arg_5_0:refreshScrollEnemyUpMargin()
	else
		arg_5_0.layouted = true

		arg_5_0:refreshLayout()
		arg_5_0:refreshLeftContainerLayout()
		arg_5_0:refreshRightContainerLayout()
	end
end

function var_0_0.updateRuleCount(arg_6_0)
	local var_6_0 = lua_battle.configDict[arg_6_0.battleId].additionRule

	arg_6_0.ruleCount = 0

	if not string.nilorempty(var_6_0) then
		arg_6_0.ruleCount = #string.split(var_6_0, "|")
	end
end

function var_0_0.refreshScrollEnemyUpMargin(arg_7_0)
	local var_7_0 = math.floor(arg_7_0.layoutMo.scrollEnemyWidth / EnemyInfoEnum.RuleItemWeight)
	local var_7_1 = math.ceil(arg_7_0.ruleCount / var_7_0) * EnemyInfoEnum.RuleItemHeight + EnemyInfoEnum.RuleTopMargin

	if arg_7_0.ruleCount < 1 then
		var_7_1 = var_7_1 + EnemyInfoEnum.WithTabOffset.ScrollEnemyUpMargin
	end

	local var_7_2 = arg_7_0.layoutMo:getScrollEnemyLeftMargin()

	arg_7_0.rectTrLeftLine1.offsetMin = Vector2(var_7_2, -var_7_1 - EnemyInfoEnum.LineHeight)
	arg_7_0.rectTrLeftLine1.offsetMax = Vector2(-EnemyInfoEnum.ScrollEnemyMargin.Right, -var_7_1)
	arg_7_0.rectTrScrollEnemy.offsetMin = Vector2(var_7_2, EnemyInfoEnum.ScrollEnemyMargin.Bottom)
	arg_7_0.rectTrScrollEnemy.offsetMax = Vector2(-EnemyInfoEnum.ScrollEnemyMargin.Right, -var_7_1)
end

function var_0_0.refreshLayout(arg_8_0)
	local var_8_0 = arg_8_0.layoutMo

	gohelper.setActive(arg_8_0.goTabContainer, arg_8_0.enemyInfoMo.showLeftTab)
	recthelper.setWidth(arg_8_0.rectTrLeftContainer, var_8_0.leftTabWidth)
	recthelper.setWidth(arg_8_0.rectTrRightContainer, var_8_0.rightTabWidth)
	recthelper.setAnchorX(arg_8_0.rectTrLeftContainer, var_8_0.tabWidth)
	recthelper.setAnchorX(arg_8_0.rectTrLine, var_8_0.tabWidth + var_8_0.leftTabWidth)
	recthelper.setAnchorX(arg_8_0.rectTrRightContainer, var_8_0.tabWidth + var_8_0.leftTabWidth)
end

function var_0_0.refreshLeftContainerLayout(arg_9_0)
	local var_9_0 = arg_9_0.rectTrRuleContainer.offsetMin
	local var_9_1 = arg_9_0.rectTrRuleContainer.offsetMax
	local var_9_2 = arg_9_0.layoutMo:getScrollEnemyLeftMargin()

	arg_9_0.rectTrRuleContainer.offsetMin = Vector2(var_9_2, var_9_0.y)
	arg_9_0.rectTrRuleContainer.offsetMax = Vector2(-EnemyInfoEnum.ScrollEnemyMargin.Right, var_9_1.y)

	local var_9_3 = arg_9_0.layoutMo.leftTabWidth - var_9_2 - EnemyInfoEnum.ScrollEnemyMargin.Right

	arg_9_0.layoutMo:setScrollEnemyWidth(var_9_3)

	local var_9_4 = math.floor(var_9_3 / EnemyInfoEnum.RuleItemWeight)
	local var_9_5 = math.ceil(arg_9_0.ruleCount / var_9_4) * EnemyInfoEnum.RuleItemHeight + EnemyInfoEnum.RuleTopMargin

	if arg_9_0.ruleCount < 1 then
		var_9_5 = var_9_5 + EnemyInfoEnum.WithTabOffset.ScrollEnemyUpMargin
	end

	arg_9_0.rectTrLeftLine1.offsetMin = Vector2(var_9_2, -var_9_5 - EnemyInfoEnum.LineHeight)
	arg_9_0.rectTrLeftLine1.offsetMax = Vector2(-EnemyInfoEnum.ScrollEnemyMargin.Right, -var_9_5)
	arg_9_0.rectTrScrollEnemy.offsetMin = Vector2(var_9_2, EnemyInfoEnum.ScrollEnemyMargin.Bottom)
	arg_9_0.rectTrScrollEnemy.offsetMax = Vector2(-EnemyInfoEnum.ScrollEnemyMargin.Right, -var_9_5)

	local var_9_6 = arg_9_0.rectTrLeftLine2.offsetMin
	local var_9_7 = arg_9_0.rectTrLeftLine2.offsetMax

	arg_9_0.rectTrLeftLine2.offsetMin = Vector2(var_9_2, var_9_6.y)
	arg_9_0.rectTrLeftLine2.offsetMax = Vector2(-EnemyInfoEnum.ScrollEnemyMargin.Right, var_9_7.y)

	local var_9_8 = arg_9_0.rectTrCareerContainer.offsetMin
	local var_9_9 = arg_9_0.rectTrCareerContainer.offsetMax

	arg_9_0.rectTrCareerContainer.offsetMin = Vector2(var_9_2, var_9_8.y)
	arg_9_0.rectTrCareerContainer.offsetMax = Vector2(-EnemyInfoEnum.ScrollEnemyMargin.Right, var_9_9.y)
end

function var_0_0.refreshRightContainerLayout(arg_10_0)
	local var_10_0 = arg_10_0.layoutMo
	local var_10_1 = var_10_0.rightTabWidth
	local var_10_2 = arg_10_0.rectTrHeader.offsetMin
	local var_10_3 = arg_10_0.rectTrHeader.offsetMax
	local var_10_4 = arg_10_0.layoutMo:getEnemyInfoLeftMargin()

	arg_10_0.rectTrHeader.offsetMin = Vector2(var_10_4, var_10_2.y)
	arg_10_0.rectTrHeader.offsetMax = Vector2(-EnemyInfoEnum.EnemyInfoMargin.Right, var_10_3.y)

	local var_10_5 = arg_10_0.rectTrRightLine1.offsetMin
	local var_10_6 = arg_10_0.rectTrRightLine1.offsetMax

	arg_10_0.rectTrRightLine1.offsetMin = Vector2(var_10_4, var_10_5.y)
	arg_10_0.rectTrRightLine1.offsetMax = Vector2(-EnemyInfoEnum.EnemyInfoMargin.Right, var_10_6.y)

	local var_10_7 = arg_10_0.rectTrEnemyInfo.offsetMin
	local var_10_8 = arg_10_0.rectTrEnemyInfo.offsetMax

	arg_10_0.rectTrEnemyInfo.offsetMin = Vector2(var_10_4, var_10_7.y)
	arg_10_0.rectTrEnemyInfo.offsetMax = Vector2(-EnemyInfoEnum.EnemyInfoMargin.Right, var_10_8.y)

	local var_10_9 = arg_10_0.rectTrRightLine2.offsetMin
	local var_10_10 = arg_10_0.rectTrRightLine2.offsetMax

	arg_10_0.rectTrRightLine2.offsetMin = Vector2(var_10_4, var_10_9.y)
	arg_10_0.rectTrRightLine2.offsetMax = Vector2(-EnemyInfoEnum.EnemyInfoMargin.Right, var_10_10.y)

	local var_10_11 = arg_10_0.rectTrSkillContainer.offsetMin
	local var_10_12 = arg_10_0.rectTrSkillContainer.offsetMax

	arg_10_0.rectTrSkillContainer.offsetMin = Vector2(var_10_4, var_10_11.y)
	arg_10_0.rectTrSkillContainer.offsetMax = Vector2(-EnemyInfoEnum.EnemyInfoMargin.Right, var_10_12.y)

	local var_10_13 = var_10_1 - var_10_4 - EnemyInfoEnum.EnemyInfoMargin.Right

	var_10_0:setEnemyInfoWidth(var_10_13)
	recthelper.setWidth(arg_10_0.rectTrEnemyInfoContent, var_10_13)
	recthelper.setWidth(arg_10_0.rectTrDesc, var_10_13)
	recthelper.setWidth(arg_10_0.rectTrBossSpecialSkill, var_10_13)
	recthelper.setWidth(arg_10_0.rectTrResistance, var_10_13)
	recthelper.setWidth(arg_10_0.rectTrPassiveSkill, var_10_13)
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
