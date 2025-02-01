module("modules.logic.stresstip.view.StressTipView", package.seeall)

slot0 = class("StressTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._scrollenemystress = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_enemystress")
	slot0._goenemystressitem = gohelper.findChild(slot0.viewGO, "#scroll_enemystress/viewport/content/#go_enemystressitem")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#scroll_enemystress/viewport/content/#go_enemystressitem/layout/#txt_title")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "#scroll_enemystress/viewport/content/#go_enemystressitem/#txt_dec")
	slot0._gorolestressitem = gohelper.findChild(slot0.viewGO, "#scroll_enemystress/viewport/content/#go_rolestressitem")
	slot0._herotiptxt = gohelper.findChildText(slot0.viewGO, "#scroll_enemystress/viewport/content/#go_rolestressitem/#txt_title")
	slot0._goroletip = gohelper.findChild(slot0.viewGO, "#go_rolestresstip")
	slot0._goroletiptxt = gohelper.findChildText(slot0.viewGO, "#go_rolestresstip/#txt_roletip")
	slot0._btnclosedetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closetip")
	slot0._goclosetip = slot0._btnclosedetail.gameObject

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnclosedetail:AddClickListener(slot0._btnclosedetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnclosedetail:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnclosedetailOnClick(slot0)
	gohelper.setActive(slot0._goclosetip, false)
	gohelper.setActive(slot0._goroletip, false)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gorolestressitem, false)
	gohelper.setActive(slot0._goenemystressitem, false)
	gohelper.setActive(slot0._goclosetip, false)
	gohelper.setActive(slot0._goroletip, false)

	slot0.heroTipHyperLinkClick = gohelper.onceAddComponent(slot0._herotiptxt, typeof(ZProj.TMPHyperLinkClick))

	slot0.heroTipHyperLinkClick:SetClickListener(slot0.onClickHeroTip, slot0)

	slot0.enemyStressItemList = {}
	slot0.rectTrEnemy = slot0._scrollenemystress:GetComponent(gohelper.Type_RectTransform)
	slot0.rectTrViewGo = slot0.viewGO:GetComponent(gohelper.Type_RectTransform)
	slot0.rectRoleTip = slot0._goroletip:GetComponent(gohelper.Type_RectTransform)
	slot0.enemyScrollWidth = recthelper.getWidth(slot0.rectTrEnemy)
end

function slot0.onClickHeroTip(slot0, slot1)
	if not lua_stress_identity.configDict[tonumber(slot1)] then
		return
	end

	slot0._goroletiptxt.text = string.format("<color=#d2c197>%s</color>", slot2.name) .. "\n" .. slot2.desc

	gohelper.setActive(slot0._goclosetip, true)
	gohelper.setActive(slot0._goroletip, true)
	ZProj.UGUIHelper.RebuildLayout(slot0.rectRoleTip)
	recthelper.setAnchor(slot0.rectRoleTip, recthelper.getAnchorX(slot0.rectTrEnemy), recthelper.getAnchorY(slot0.rectTrEnemy) + recthelper.getHeight(slot0.rectRoleTip) + 10)
end

slot0.OpenEnum = {
	Monster = 1,
	Hero = 2
}

function slot0.onOpen(slot0)
	slot0.openEnum = slot0.viewParam.openEnum
	slot0.co = slot0.viewParam.co
	slot0.clickPosition = slot0.viewParam.clickPosition

	slot0:refreshHero()
	slot0:refreshEnemy()
end

slot0.StressBehaviourList = {
	FightEnum.StressBehaviour.Positive,
	FightEnum.StressBehaviour.Negative,
	FightEnum.StressBehaviour.Meltdown,
	FightEnum.StressBehaviour.Resolute,
	FightEnum.StressBehaviour.BaseAdd,
	FightEnum.StressBehaviour.BaseReduce,
	FightEnum.StressBehaviour.BaseResolute,
	FightEnum.StressBehaviour.BaseMeltdown
}

function slot0.refreshEnemy(slot0)
	for slot4, slot5 in ipairs(slot0.enemyStressItemList) do
		gohelper.setActive(slot5.go, false)
	end

	if not StressConfig.instance:getStressDict(slot0.openEnum == uv0.OpenEnum.Monster and lua_monster_skill_template.configDict[slot0.co.skillTemplate] and slot2.identity or 1001) then
		logError(string.format("压力表，身份类型 ： %s 不存在", nil))

		return
	end

	for slot7, slot8 in ipairs(slot0.StressBehaviourList) do
		if slot2[FightEnum.StressBehaviourString[slot8]] then
			slot11 = slot0:getEnemyStressItem(0 + 1)

			gohelper.setActive(slot11.go, true)

			slot11.txtTitle.text = StressConfig.instance:getStressBehaviourName(slot8)

			slot0:refreshEnemyDesc(slot11, slot10)
		end
	end

	slot0:setRectTrLayout(slot0.rectTrEnemy)
end

function slot0.refreshEnemyDesc(slot0, slot1, slot2)
	slot3 = 0

	for slot7, slot8 in ipairs(slot2) do
		if lua_stress_rule.configDict[tonumber(slot8.rule)] and slot9.isNoShow ~= 1 then
			slot10 = slot0:getEnemyStressDescItem(slot1, slot3 + 1)

			gohelper.setActive(slot10.goDesc, true)

			slot10.txtDesc.text = "<nobr>" .. SkillHelper.buildDesc(slot9.desc)
		end
	end

	if slot3 < 1 then
		gohelper.setActive(slot1.go, false)
	else
		for slot8 = slot3 + 1, #slot1.descItemList do
			gohelper.setActive(slot4[slot8].goDesc, false)
		end
	end
end

function slot0.refreshHero(slot0)
	gohelper.setActive(slot0._gorolestressitem, slot0.openEnum == uv0.OpenEnum.Hero)

	if slot0.openEnum ~= uv0.OpenEnum.Hero then
		return
	end

	slot0._herotiptxt.text = GameUtil.getSubPlaceholderLuaLangOneParam(StressConfig.instance:getHeroTip(), StressConfig.instance:getHeroIdentityText(slot0.co))
end

function slot0.getEnemyStressItem(slot0, slot1)
	if slot1 <= #slot0.enemyStressItemList then
		return slot0.enemyStressItemList[slot1]
	end

	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.cloneInPlace(slot0._goenemystressitem)
	slot2.txtTitle = gohelper.findChildText(slot2.go, "layout/#txt_title")
	slot2.descItemList = {}

	table.insert(slot0.enemyStressItemList, slot2)

	slot3 = slot0:getUserDataTb_()
	slot3.txtDesc = gohelper.findChildText(slot2.go, "#txt_dec")
	slot3.goDesc = slot3.txtDesc.gameObject

	SkillHelper.addHyperLinkClick(slot3.txtDesc, slot0.onClickDescHyperLink, slot0)
	table.insert(slot2.descItemList, slot3)

	return slot2
end

function slot0.getEnemyStressDescItem(slot0, slot1, slot2)
	if slot2 <= #slot1.descItemList then
		return slot3[slot2]
	end

	slot5 = slot0:getUserDataTb_()
	slot5.goDesc = gohelper.cloneInPlace(slot1.descItemList[1].goDesc)
	slot5.txtDesc = slot5.goDesc:GetComponent(gohelper.Type_TextMesh)

	SkillHelper.addHyperLinkClick(slot5.txtDesc, slot0.onClickDescHyperLink, slot0)
	table.insert(slot3, slot5)

	return slot5
end

slot0.DefaultIntervalX = 10
slot0.MaxScrollHeight = 535

function slot0.setRectTrLayout(slot0, slot1)
	slot2, slot3 = GameUtil.getViewSize()
	slot5, slot6 = recthelper.screenPosToAnchorPos2(slot0.clickPosition, slot0.rectTrViewGo)

	recthelper.setAnchor(slot1, GameUtil.checkClickPositionInRight(slot0.clickPosition) and slot5 - uv0.DefaultIntervalX or slot5 + recthelper.getWidth(slot1) + uv0.DefaultIntervalX, slot6)
	recthelper.setHeight(slot1, math.min(uv0.MaxScrollHeight, slot3 - math.abs(slot6)))
end

function slot0.onClickDescHyperLink(slot0, slot1, slot2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(slot1, slot0.setScrollPosCallback, slot0)
end

slot0.ScrollTipIntervalX = 10

function slot0.setScrollPosCallback(slot0, slot1, slot2)
	slot3, slot4 = GameUtil.getViewSize()
	slot5 = slot3 / 2
	slot2.pivot = CommonBuffTipEnum.Pivot.Right

	recthelper.setAnchor(slot2, recthelper.getWidth(slot2) <= slot3 - math.abs(recthelper.getAnchorX(slot0.rectTrEnemy)) - slot0.enemyScrollWidth - slot0.ScrollTipIntervalX and slot9 - slot5 or slot5 - math.abs(slot7) + slot0.enemyScrollWidth + slot0.ScrollTipIntervalX, recthelper.getAnchorY(slot0.rectTrEnemy) + slot4 / 2)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
