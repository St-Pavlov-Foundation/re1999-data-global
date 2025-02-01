module("modules.logic.enemyinfo.view.EnemyInfoLayoutView", package.seeall)

slot0 = class("EnemyInfoLayoutView", BaseViewExtended)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.goTabContainer = gohelper.findChild(slot0.viewGO, "#go_tab_container")
	slot0.rectTrLeftContainer = gohelper.findChildComponent(slot0.viewGO, "#go_left_container", gohelper.Type_RectTransform)
	slot0.rectTrLine = gohelper.findChildComponent(slot0.viewGO, "#go_line", gohelper.Type_RectTransform)
	slot0.rectTrRightContainer = gohelper.findChildComponent(slot0.viewGO, "#go_right_container", gohelper.Type_RectTransform)
	slot0.rectTrRuleContainer = gohelper.findChildComponent(slot0.viewGO, "#go_left_container/#go_rule_container", gohelper.Type_RectTransform)
	slot0.rectTrLeftLine1 = gohelper.findChildComponent(slot0.viewGO, "#go_left_container/#go_line1", gohelper.Type_RectTransform)
	slot0.rectTrScrollEnemy = gohelper.findChildComponent(slot0.viewGO, "#go_left_container/#scroll_enemy", gohelper.Type_RectTransform)
	slot0.rectTrLeftLine2 = gohelper.findChildComponent(slot0.viewGO, "#go_left_container/#go_line2", gohelper.Type_RectTransform)
	slot0.rectTrCareerContainer = gohelper.findChildComponent(slot0.viewGO, "#go_left_container/#go_career_container", gohelper.Type_RectTransform)
	slot0.rectTrHeader = gohelper.findChildComponent(slot0.viewGO, "#go_right_container/#go_header", gohelper.Type_RectTransform)
	slot0.rectTrRightLine1 = gohelper.findChildComponent(slot0.viewGO, "#go_right_container/#go_line1", gohelper.Type_RectTransform)
	slot0.rectTrEnemyInfo = gohelper.findChildComponent(slot0.viewGO, "#go_right_container/#scroll_enemyinfo", gohelper.Type_RectTransform)
	slot0.rectTrRightLine2 = gohelper.findChildComponent(slot0.viewGO, "#go_right_container/#go_line2", gohelper.Type_RectTransform)
	slot0.rectTrSkillContainer = gohelper.findChildComponent(slot0.viewGO, "#go_right_container/#go_skill_container", gohelper.Type_RectTransform)
	slot0.rectTrEnemyInfoContent = gohelper.findChildComponent(slot0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent", gohelper.Type_RectTransform)
	slot0.rectTrDesc = gohelper.findChildComponent(slot0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#txt_desc", gohelper.Type_RectTransform)
	slot0.rectTrBossSpecialSkill = gohelper.findChildComponent(slot0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_bossspecialskill", gohelper.Type_RectTransform)
	slot0.rectTrResistance = gohelper.findChildComponent(slot0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_resistance", gohelper.Type_RectTransform)
	slot0.rectTrPassiveSkill = gohelper.findChildComponent(slot0.viewGO, "#go_right_container/#scroll_enemyinfo/Viewport/#go_enemyinfoconent/#go_passiveskill", gohelper.Type_RectTransform)
	slot0.viewRectTr = slot0.viewGO:GetComponent(gohelper.Type_RectTransform)

	slot0:addEventCb(EnemyInfoController.instance, EnemyInfoEvent.UpdateBattleInfo, slot0.onUpdateBattleInfo, slot0)
end

function slot0.onUpdateBattleInfo(slot0, slot1)
	if slot0.battleId == slot1 then
		return
	end

	slot0.battleId = slot1

	slot0.layoutMo:updateLayout(recthelper.getWidth(slot0.viewRectTr), slot0.enemyInfoMo.showLeftTab)
	slot0:updateRuleCount()

	if slot0.layouted then
		slot0:refreshScrollEnemyUpMargin()
	else
		slot0.layouted = true

		slot0:refreshLayout()
		slot0:refreshLeftContainerLayout()
		slot0:refreshRightContainerLayout()
	end
end

function slot0.updateRuleCount(slot0)
	slot0.ruleCount = 0

	if not string.nilorempty(lua_battle.configDict[slot0.battleId].additionRule) then
		slot0.ruleCount = #string.split(slot2, "|")
	end
end

function slot0.refreshScrollEnemyUpMargin(slot0)
	if slot0.ruleCount < 1 then
		slot3 = math.ceil(slot0.ruleCount / math.floor(slot0.layoutMo.scrollEnemyWidth / EnemyInfoEnum.RuleItemWeight)) * EnemyInfoEnum.RuleItemHeight + EnemyInfoEnum.RuleTopMargin + EnemyInfoEnum.WithTabOffset.ScrollEnemyUpMargin
	end

	slot4 = slot0.layoutMo:getScrollEnemyLeftMargin()
	slot0.rectTrLeftLine1.offsetMin = Vector2(slot4, -slot3 - EnemyInfoEnum.LineHeight)
	slot0.rectTrLeftLine1.offsetMax = Vector2(-EnemyInfoEnum.ScrollEnemyMargin.Right, -slot3)
	slot0.rectTrScrollEnemy.offsetMin = Vector2(slot4, EnemyInfoEnum.ScrollEnemyMargin.Bottom)
	slot0.rectTrScrollEnemy.offsetMax = Vector2(-EnemyInfoEnum.ScrollEnemyMargin.Right, -slot3)
end

function slot0.refreshLayout(slot0)
	slot1 = slot0.layoutMo

	gohelper.setActive(slot0.goTabContainer, slot0.enemyInfoMo.showLeftTab)
	recthelper.setWidth(slot0.rectTrLeftContainer, slot1.leftTabWidth)
	recthelper.setWidth(slot0.rectTrRightContainer, slot1.rightTabWidth)
	recthelper.setAnchorX(slot0.rectTrLeftContainer, slot1.tabWidth)
	recthelper.setAnchorX(slot0.rectTrLine, slot1.tabWidth + slot1.leftTabWidth)
	recthelper.setAnchorX(slot0.rectTrRightContainer, slot1.tabWidth + slot1.leftTabWidth)
end

function slot0.refreshLeftContainerLayout(slot0)
	slot3 = slot0.layoutMo:getScrollEnemyLeftMargin()
	slot0.rectTrRuleContainer.offsetMin = Vector2(slot3, slot0.rectTrRuleContainer.offsetMin.y)
	slot0.rectTrRuleContainer.offsetMax = Vector2(-EnemyInfoEnum.ScrollEnemyMargin.Right, slot0.rectTrRuleContainer.offsetMax.y)
	slot4 = slot0.layoutMo.leftTabWidth - slot3 - EnemyInfoEnum.ScrollEnemyMargin.Right

	slot0.layoutMo:setScrollEnemyWidth(slot4)

	if slot0.ruleCount < 1 then
		slot7 = math.ceil(slot0.ruleCount / math.floor(slot4 / EnemyInfoEnum.RuleItemWeight)) * EnemyInfoEnum.RuleItemHeight + EnemyInfoEnum.RuleTopMargin + EnemyInfoEnum.WithTabOffset.ScrollEnemyUpMargin
	end

	slot0.rectTrLeftLine1.offsetMin = Vector2(slot3, -slot7 - EnemyInfoEnum.LineHeight)
	slot0.rectTrLeftLine1.offsetMax = Vector2(-EnemyInfoEnum.ScrollEnemyMargin.Right, -slot7)
	slot0.rectTrScrollEnemy.offsetMin = Vector2(slot3, EnemyInfoEnum.ScrollEnemyMargin.Bottom)
	slot0.rectTrScrollEnemy.offsetMax = Vector2(-EnemyInfoEnum.ScrollEnemyMargin.Right, -slot7)
	slot0.rectTrLeftLine2.offsetMin = Vector2(slot3, slot0.rectTrLeftLine2.offsetMin.y)
	slot0.rectTrLeftLine2.offsetMax = Vector2(-EnemyInfoEnum.ScrollEnemyMargin.Right, slot0.rectTrLeftLine2.offsetMax.y)
	slot0.rectTrCareerContainer.offsetMin = Vector2(slot3, slot0.rectTrCareerContainer.offsetMin.y)
	slot0.rectTrCareerContainer.offsetMax = Vector2(-EnemyInfoEnum.ScrollEnemyMargin.Right, slot0.rectTrCareerContainer.offsetMax.y)
end

function slot0.refreshRightContainerLayout(slot0)
	slot1 = slot0.layoutMo
	slot5 = slot0.layoutMo:getEnemyInfoLeftMargin()
	slot0.rectTrHeader.offsetMin = Vector2(slot5, slot0.rectTrHeader.offsetMin.y)
	slot0.rectTrHeader.offsetMax = Vector2(-EnemyInfoEnum.EnemyInfoMargin.Right, slot0.rectTrHeader.offsetMax.y)
	slot0.rectTrRightLine1.offsetMin = Vector2(slot5, slot0.rectTrRightLine1.offsetMin.y)
	slot0.rectTrRightLine1.offsetMax = Vector2(-EnemyInfoEnum.EnemyInfoMargin.Right, slot0.rectTrRightLine1.offsetMax.y)
	slot0.rectTrEnemyInfo.offsetMin = Vector2(slot5, slot0.rectTrEnemyInfo.offsetMin.y)
	slot0.rectTrEnemyInfo.offsetMax = Vector2(-EnemyInfoEnum.EnemyInfoMargin.Right, slot0.rectTrEnemyInfo.offsetMax.y)
	slot0.rectTrRightLine2.offsetMin = Vector2(slot5, slot0.rectTrRightLine2.offsetMin.y)
	slot0.rectTrRightLine2.offsetMax = Vector2(-EnemyInfoEnum.EnemyInfoMargin.Right, slot0.rectTrRightLine2.offsetMax.y)
	slot0.rectTrSkillContainer.offsetMin = Vector2(slot5, slot0.rectTrSkillContainer.offsetMin.y)
	slot0.rectTrSkillContainer.offsetMax = Vector2(-EnemyInfoEnum.EnemyInfoMargin.Right, slot0.rectTrSkillContainer.offsetMax.y)
	slot6 = slot1.rightTabWidth - slot5 - EnemyInfoEnum.EnemyInfoMargin.Right

	slot1:setEnemyInfoWidth(slot6)
	recthelper.setWidth(slot0.rectTrEnemyInfoContent, slot6)
	recthelper.setWidth(slot0.rectTrDesc, slot6)
	recthelper.setWidth(slot0.rectTrBossSpecialSkill, slot6)
	recthelper.setWidth(slot0.rectTrResistance, slot6)
	recthelper.setWidth(slot0.rectTrPassiveSkill, slot6)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
