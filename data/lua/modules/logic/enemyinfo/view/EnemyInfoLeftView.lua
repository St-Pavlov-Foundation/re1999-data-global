module("modules.logic.enemyinfo.view.EnemyInfoLeftView", package.seeall)

slot0 = class("EnemyInfoLeftView", BaseView)

function slot0.onInitView(slot0)
	slot0._gorulecontainer = gohelper.findChild(slot0.viewGO, "#go_left_container/#go_rule_container")
	slot0._goruleitem = gohelper.findChild(slot0.viewGO, "#go_left_container/#go_rule_container/#go_ruleitem")
	slot0._goline1 = gohelper.findChild(slot0.viewGO, "#go_left_container/#go_line1")
	slot0._scrollenemy = gohelper.findChildScrollRect(slot0.viewGO, "#go_left_container/#scroll_enemy")
	slot0._gopoolcontainer = gohelper.findChild(slot0.viewGO, "#go_left_container/#go_pool_container")
	slot0._goenemygrouppool = gohelper.findChild(slot0.viewGO, "#go_left_container/#go_pool_container/#go_enemygroup_pool")
	slot0._goenemygroupitem = gohelper.findChild(slot0.viewGO, "#go_left_container/#go_pool_container/#go_enemygroup_pool/#go_enemygroupitem")
	slot0._goenemyitempool = gohelper.findChild(slot0.viewGO, "#go_left_container/#go_pool_container/#go_enemyitem_pool")
	slot0._goenemyitem = gohelper.findChild(slot0.viewGO, "#go_left_container/#go_pool_container/#go_enemyitem_pool/#go_enemyitem")
	slot0._goruleipitem = gohelper.findChild(slot0.viewGO, "#go_tip_container/#go_ruletip/#go_ruletipitem")
	slot0._gorulelist = gohelper.findChild(slot0.viewGO, "#go_tip_container/#go_ruletip/#go_rulelist")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClickRule(slot0)
	slot1 = math.floor(slot0.layoutMo.scrollEnemyWidth / EnemyInfoEnum.RuleItemWeight)
	slot2 = slot1

	if slot1 > #slot0.ruleItemList then
		slot2 = #slot0.ruleItemList
	end

	slot5, slot6 = recthelper.worldPosToAnchorPos2(slot0.ruleItemList[slot2].go:GetComponent(gohelper.Type_Transform).position, slot0.ruleTipContainerRectTr)

	recthelper.setAnchorX(slot0.ruleTipRectTr, slot5 + EnemyInfoEnum.TipOffsetX)
	EnemyInfoController.instance:dispatchEvent(EnemyInfoEvent.ShowTip, EnemyInfoEnum.Tip.RuleTip)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goruleitem, false)
	gohelper.setActive(slot0._goenemygroupitem, false)
	gohelper.setActive(slot0._goenemyitem, false)
	gohelper.setActive(slot0._gopoolcontainer, false)

	slot0.ruleTipContainerRectTr = gohelper.findChildComponent(slot0.viewGO, "#go_tip_container", gohelper.Type_RectTransform)
	slot0.ruleTipRectTr = gohelper.findChildComponent(slot0.viewGO, "#go_tip_container/#go_ruletip", gohelper.Type_RectTransform)
	slot0.trScrollContent = gohelper.findChildComponent(slot0._scrollenemy.gameObject, "viewport/content", gohelper.Type_Transform)
	slot0.enemyGroupPoolTr = slot0._goenemygrouppool:GetComponent(gohelper.Type_Transform)
	slot0.enemyItemPoolTr = slot0._goenemyitempool:GetComponent(gohelper.Type_Transform)
	slot0.ruleClick = gohelper.getClickWithDefaultAudio(slot0._gorulecontainer, slot0)
	slot4 = slot0

	slot0.ruleClick:AddClickListener(slot0.onClickRule, slot4)

	slot0.ruleLineCount = 0
	slot0.ruleItemPool = {}
	slot0.ruleItemList = {}
	slot0.ruleTipItemPool = {}
	slot0.ruleTipItemList = {}
	slot0.enemyGroupPool = {}
	slot0.enemyGroupList = {}
	slot0.enemyItemList = {}
	slot0.enemyItemPool = {
		[0] = {}
	}

	for slot4, slot5 in pairs(IconMaterialMgr.instance.variantIdToMaterialPath) do
		slot0.enemyItemPool[slot4] = {}
	end

	slot0:addEventCb(EnemyInfoController.instance, EnemyInfoEvent.SelectMonsterChange, slot0.onSelectMonsterChange, slot0)
	slot0:addEventCb(EnemyInfoController.instance, EnemyInfoEvent.UpdateBattleInfo, slot0.onUpdateBattleInfo, slot0)
end

function slot0.onSelectMonsterChange(slot0, slot1)
	slot0.selectEnemyIndex = slot1.enemyIndex

	for slot5, slot6 in ipairs(slot0.enemyItemList) do
		gohelper.setActive(slot6.selectframe, slot0.selectEnemyIndex == slot5)
	end
end

function slot0.onUpdateBattleInfo(slot0, slot1)
	if slot0.battleId == slot1 then
		return
	end

	slot0.battleId = slot1
	slot0.battleCo = lua_battle.configDict[slot0.battleId]

	slot0:refreshUI()
	slot0:selectFirstMonster()
end

function slot0.selectFirstMonster(slot0)
	slot1 = slot0.enemyItemList[1]
	slot0.eventData = slot0.eventData or {}
	slot0.eventData.monsterId = slot1.monsterId
	slot0.eventData.isBoss = slot1.isBoss
	slot0.eventData.enemyIndex = 1

	EnemyInfoController.instance:dispatchEvent(EnemyInfoEvent.SelectMonsterChange, slot0.eventData)
end

function slot0.refreshUI(slot0)
	slot0:refreshRule()
	slot0:refreshScrollEnemy()
end

function slot0.refreshRule(slot0)
	slot0:recycleAllRuleItem()
	slot0:recycleAllRuleTipItem()

	if string.nilorempty(slot0.battleCo.additionRule) then
		gohelper.setActive(slot0._goline1, false)
		gohelper.setActive(slot0._gorulecontainer, false)

		return
	end

	gohelper.setActive(slot0._gorulecontainer, true)

	slot6 = "#"
	slot2 = GameUtil.splitString2(slot1, true, "|", slot6)

	slot0:filterRule(slot2)

	for slot6, slot7 in ipairs(slot2) do
		if lua_rule.configDict[slot7[2]] then
			slot0:addRuleItem(slot10, slot7[1])
		end
	end

	gohelper.setActive(slot0._goline1, #slot2 > 0)

	if slot0.ruleTipItemList[#slot0.ruleTipItemList] then
		gohelper.setActive(slot3.goLine, false)
	end
end

function slot0.filterRule(slot0, slot1)
	if slot0.viewParam.tabEnum == EnemyInfoEnum.TabEnum.Season123 then
		for slot7 = #slot1, 1, -1 do
			if tabletool.indexOf(string.splitToNumber(Season123Config.instance:getSeasonConstStr(slot0.viewParam.activityId, Activity123Enum.Const.HideRule), "#"), slot1[slot7][2]) then
				table.remove(slot1, slot7)
			end
		end
	end
end

function slot0.refreshScrollEnemy(slot0)
	if string.nilorempty(slot0.battleCo.monsterGroupIds) then
		return
	end

	slot0:recycleAllEnemyGroupList()
	slot0:recycleAllEnemyItemList()

	for slot6, slot7 in ipairs(string.splitToNumber(slot1, "#")) do
		slot0:addGroupItem(slot7, slot6)
	end
end

function slot0.recycleAllRuleItem(slot0)
	for slot4, slot5 in ipairs(slot0.ruleItemList) do
		gohelper.setActive(slot5.go, false)
		table.insert(slot0.ruleItemPool, slot5)
	end

	tabletool.clear(slot0.ruleItemList)
end

function slot0.recycleAllRuleTipItem(slot0)
	for slot4, slot5 in ipairs(slot0.ruleTipItemList) do
		gohelper.setActive(slot5.go, false)
		table.insert(slot0.ruleTipItemPool, slot5)
	end

	tabletool.clear(slot0.ruleTipItemList)
end

function slot0.addRuleItem(slot0, slot1, slot2)
	if not slot1 then
		logError("rule co nil")

		return
	end

	slot3 = slot0:getRuleItem()

	UISpriteSetMgr.instance:setCommonSprite(slot3.tagIcon, "wz_" .. slot2)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(slot3.ruleIcon, slot1.icon)

	slot4 = slot0:getRuleTipItem()

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(slot4.icon, slot1.icon)
	UISpriteSetMgr.instance:setCommonSprite(slot4.tag, "wz_" .. slot2)

	slot4.txtDesc.text = SkillConfig.instance:fmtTagDescColor(luaLang("dungeon_add_rule_target_" .. slot2), SkillHelper.buildDesc(slot1.desc, nil, "#6680bd"), EnemyInfoEnum.TagColor[slot2])
end

function slot0.getRuleItem(slot0)
	if #slot0.ruleItemPool > 0 then
		slot1 = table.remove(slot0.ruleItemPool)

		table.insert(slot0.ruleItemList, slot1)
		gohelper.setActive(slot1.go, true)
		gohelper.setAsLastSibling(slot1.go)

		return slot1
	end

	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0._goruleitem)
	slot1.ruleIcon = gohelper.findChildImage(slot1.go, "#image_ruleicon")
	slot1.tagIcon = gohelper.findChildImage(slot1.go, "#image_ruleicon/#image_tagicon")

	gohelper.setActive(slot1.go, true)
	table.insert(slot0.ruleItemList, slot1)

	return slot1
end

function slot0.getRuleTipItem(slot0)
	if #slot0.ruleTipItemPool > 0 then
		slot1 = table.remove(slot0.ruleTipItemPool)

		table.insert(slot0.ruleTipItemList, slot1)
		gohelper.setActive(slot1.go, true)
		gohelper.setActive(slot1.goLine, true)
		gohelper.setAsLastSibling(slot1.go)

		return slot1
	end

	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.clone(slot0._goruleipitem, slot0._gorulelist)
	slot1.icon = gohelper.findChildImage(slot1.go, "icon")
	slot1.goLine = gohelper.findChild(slot1.go, "line")
	slot1.tag = gohelper.findChildImage(slot1.go, "tag")
	slot1.txtDesc = gohelper.findChildText(slot1.go, "desc")

	SkillHelper.addHyperLinkClick(slot1.txtDesc)
	gohelper.setActive(slot1.go, true)
	gohelper.setActive(slot1.goLine, true)
	table.insert(slot0.ruleTipItemList, slot1)

	return slot1
end

function slot0.recycleAllEnemyGroupList(slot0)
	for slot4, slot5 in ipairs(slot0.enemyGroupList) do
		gohelper.setActive(slot5.go, false)
		slot5.tr:SetParent(slot0.enemyGroupPoolTr)
		table.insert(slot0.enemyGroupPool, slot5)
	end

	tabletool.clear(slot0.enemyGroupList)
end

function slot0.recycleAllEnemyItemList(slot0)
	for slot4, slot5 in ipairs(slot0.enemyItemList) do
		gohelper.setActive(slot5.go, false)
		slot5.tr:SetParent(slot0.enemyItemPoolTr)

		slot5.monsterId = nil

		table.insert(slot0.enemyItemPool[slot5.variantId], slot5)
	end

	tabletool.clear(slot0.enemyItemList)
end

function slot0.getEnemyGroupItem(slot0)
	if #slot0.enemyGroupPool > 0 then
		slot1 = table.remove(slot0.enemyGroupPool)

		table.insert(slot0.enemyGroupList, slot1)
		recthelper.setWidth(slot1.tr, slot0.layoutMo.scrollEnemyWidth)
		recthelper.setWidth(slot1.trContent, slot0.layoutMo.scrollEnemyWidth - EnemyInfoEnum.EnemyGroupLeftMargin)
		gohelper.setActive(slot1.go, true)
		gohelper.setAsLastSibling(slot1.go)

		return slot1
	end

	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0._goenemygroupitem)
	slot1.tr = slot1.go:GetComponent(gohelper.Type_Transform)
	slot1.txtTitleNum = gohelper.findChildText(slot1.go, "title/#txt_titlenum")
	slot1.trContent = gohelper.findChildComponent(slot1.go, "content", gohelper.Type_RectTransform)

	recthelper.setWidth(slot1.tr, slot0.layoutMo.scrollEnemyWidth)
	recthelper.setWidth(slot1.trContent, slot0.layoutMo.scrollEnemyWidth - EnemyInfoEnum.EnemyGroupLeftMargin)
	gohelper.setActive(slot1.go, true)
	table.insert(slot0.enemyGroupList, slot1)

	return slot1
end

function slot0.getEnemyItem(slot0, slot1)
	if not slot0.enemyItemPool[slot1] then
		logError("not variantId : " .. tostring(slot1) .. " pool")

		return nil
	end

	if #slot2 > 0 then
		slot3 = table.remove(slot2)

		table.insert(slot0.enemyItemList, slot3)
		gohelper.setActive(slot3.go, true)
		gohelper.setAsLastSibling(slot3.go)

		return slot3
	end

	slot3 = slot0:getUserDataTb_()
	slot3.go = gohelper.cloneInPlace(slot0._goenemyitem)
	slot3.tr = slot3.go:GetComponent(gohelper.Type_Transform)
	slot3.icon = gohelper.findChildImage(slot3.go, "icon")
	slot3.career = gohelper.findChildImage(slot3.go, "career")
	slot3.selectframe = gohelper.findChild(slot3.go, "selectframe")
	slot3.bosstag = gohelper.findChild(slot3.go, "bosstag")

	gohelper.setActive(slot3.selectframe, false)

	slot3.btn = gohelper.findChildButtonWithAudio(slot3.go, "btn_click", AudioEnum.UI.Play_UI_Tags)

	slot3.btn:AddClickListener(slot0.onClickEnemyItem, slot0, slot3)

	slot3.variantId = slot1

	if slot1 ~= 0 then
		IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPathWithRound(slot1), slot3.icon)
	end

	gohelper.setActive(slot3.go, true)
	table.insert(slot0.enemyItemList, slot3)

	return slot3
end

function slot0.addGroupItem(slot0, slot1, slot2)
	slot3 = lua_monster_group.configDict[slot1]
	slot5 = string.splitToNumber(slot3.bossId, "#")

	tabletool.clear(slot0.tempMonsterIdList or {})

	if not string.nilorempty(slot3.monster) then
		tabletool.addValues(slot4, string.splitToNumber(slot3.monster, "#"))
	end

	if not string.nilorempty(slot3.spMonster) then
		tabletool.addValues(slot4, string.splitToNumber(slot3.spMonster, "#"))
	end

	if #slot4 <= 0 then
		return
	end

	slot6 = slot0:getEnemyGroupItem()

	slot6.tr:SetParent(slot0.trScrollContent)

	slot6.txtTitleNum.text = slot2

	for slot10, slot11 in ipairs(slot4) do
		slot0:addMonsterItem(slot11, slot6.trContent, slot5)
	end
end

function slot0.addMonsterItem(slot0, slot1, slot2, slot3)
	slot4 = lua_monster.configDict[slot1]
	slot5 = slot0:getEnemyItem(slot4.heartVariantId)

	slot5.tr:SetParent(slot2)

	slot5.monsterId = slot1
	slot5.isBoss = slot0:checkIsBoss(slot3, slot1)
	slot5.enemyIndex = #slot0.enemyItemList

	gohelper.getSingleImage(slot5.icon.gameObject):LoadImage(ResUrl.monsterHeadIcon(FightConfig.instance:getSkinCO(slot4.skinId).headIcon))
	UISpriteSetMgr.instance:setEnemyInfoSprite(slot5.career, "sxy_" .. slot4.career)
	gohelper.setActive(slot5.bosstag, slot5.isBoss)
end

function slot0.checkIsBoss(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		if slot2 == slot7 then
			return true
		end
	end

	return false
end

function slot0.onClickEnemyItem(slot0, slot1)
	slot0.eventData = slot0.eventData or {}
	slot0.eventData.monsterId = slot1.monsterId
	slot0.eventData.isBoss = slot1.isBoss
	slot0.eventData.enemyIndex = slot1.enemyIndex

	EnemyInfoController.instance:dispatchEvent(EnemyInfoEvent.SelectMonsterChange, slot0.eventData)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0.ruleClick:RemoveClickListener()

	for slot4, slot5 in ipairs(slot0.enemyItemList) do
		slot5.btn:RemoveClickListener()
	end

	for slot4, slot5 in pairs(slot0.enemyItemPool) do
		for slot9, slot10 in ipairs(slot5) do
			slot10.btn:RemoveClickListener()
		end
	end
end

return slot0
