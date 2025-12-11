module("modules.logic.enemyinfo.view.EnemyInfoLeftView", package.seeall)

local var_0_0 = class("EnemyInfoLeftView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorulecontainer = gohelper.findChild(arg_1_0.viewGO, "#go_left_container/#go_rule_container")
	arg_1_0._goruleitem = gohelper.findChild(arg_1_0.viewGO, "#go_left_container/#go_rule_container/#go_ruleitem")
	arg_1_0._goline1 = gohelper.findChild(arg_1_0.viewGO, "#go_left_container/#go_line1")
	arg_1_0._scrollenemy = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_left_container/#scroll_enemy")
	arg_1_0._gopoolcontainer = gohelper.findChild(arg_1_0.viewGO, "#go_left_container/#go_pool_container")
	arg_1_0._goenemygrouppool = gohelper.findChild(arg_1_0.viewGO, "#go_left_container/#go_pool_container/#go_enemygroup_pool")
	arg_1_0._goenemygroupitem = gohelper.findChild(arg_1_0.viewGO, "#go_left_container/#go_pool_container/#go_enemygroup_pool/#go_enemygroupitem")
	arg_1_0._goenemyitempool = gohelper.findChild(arg_1_0.viewGO, "#go_left_container/#go_pool_container/#go_enemyitem_pool")
	arg_1_0._goenemyitem = gohelper.findChild(arg_1_0.viewGO, "#go_left_container/#go_pool_container/#go_enemyitem_pool/#go_enemyitem")

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

function var_0_0.onClickRule(arg_4_0)
	local var_4_0 = math.floor(arg_4_0.layoutMo.scrollEnemyWidth / EnemyInfoEnum.RuleItemWeight)
	local var_4_1 = var_4_0

	if var_4_0 > #arg_4_0.ruleItemList then
		var_4_1 = #arg_4_0.ruleItemList
	end

	local var_4_2 = arg_4_0.ruleItemList[var_4_1].go:GetComponent(gohelper.Type_Transform)
	local var_4_3, var_4_4 = recthelper.worldPosToAnchorPos2(var_4_2.position, arg_4_0.ruleTipContainerRectTr)

	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = arg_4_0._ruleList
	})
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._goruleitem, false)
	gohelper.setActive(arg_5_0._goenemygroupitem, false)
	gohelper.setActive(arg_5_0._goenemyitem, false)
	gohelper.setActive(arg_5_0._gopoolcontainer, false)

	arg_5_0.ruleTipContainerRectTr = gohelper.findChildComponent(arg_5_0.viewGO, "#go_tip_container", gohelper.Type_RectTransform)
	arg_5_0.ruleTipRectTr = gohelper.findChildComponent(arg_5_0.viewGO, "#go_tip_container/#go_ruletip", gohelper.Type_RectTransform)
	arg_5_0.trScrollContent = gohelper.findChildComponent(arg_5_0._scrollenemy.gameObject, "viewport/content", gohelper.Type_Transform)
	arg_5_0.enemyGroupPoolTr = arg_5_0._goenemygrouppool:GetComponent(gohelper.Type_Transform)
	arg_5_0.enemyItemPoolTr = arg_5_0._goenemyitempool:GetComponent(gohelper.Type_Transform)
	arg_5_0.ruleClick = gohelper.getClickWithDefaultAudio(arg_5_0._gorulecontainer, arg_5_0)

	arg_5_0.ruleClick:AddClickListener(arg_5_0.onClickRule, arg_5_0)

	arg_5_0.ruleLineCount = 0
	arg_5_0.ruleItemPool = {}
	arg_5_0.ruleItemList = {}
	arg_5_0.ruleTipItemPool = {}
	arg_5_0.ruleTipItemList = {}
	arg_5_0.enemyGroupPool = {}
	arg_5_0.enemyGroupList = {}
	arg_5_0.enemyItemList = {}
	arg_5_0.enemyItemPool = {
		[0] = {}
	}

	for iter_5_0, iter_5_1 in pairs(IconMaterialMgr.instance.variantIdToMaterialPath) do
		arg_5_0.enemyItemPool[iter_5_0] = {}
	end

	arg_5_0:addEventCb(EnemyInfoController.instance, EnemyInfoEvent.SelectMonsterChange, arg_5_0.onSelectMonsterChange, arg_5_0)
	arg_5_0:addEventCb(EnemyInfoController.instance, EnemyInfoEvent.UpdateBattleInfo, arg_5_0.onUpdateBattleInfo, arg_5_0)
end

function var_0_0.onSelectMonsterChange(arg_6_0, arg_6_1)
	arg_6_0.selectEnemyIndex = arg_6_1.enemyIndex

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.enemyItemList) do
		gohelper.setActive(iter_6_1.selectframe, arg_6_0.selectEnemyIndex == iter_6_0)
	end
end

function var_0_0.onUpdateBattleInfo(arg_7_0, arg_7_1)
	if arg_7_0.battleId == arg_7_1 then
		return
	end

	arg_7_0.battleId = arg_7_1
	arg_7_0.battleCo = lua_battle.configDict[arg_7_0.battleId]

	arg_7_0:refreshUI()
	arg_7_0:selectFirstMonster()
end

function var_0_0.selectFirstMonster(arg_8_0)
	local var_8_0 = arg_8_0.enemyItemList[1]

	arg_8_0.eventData = arg_8_0.eventData or {}
	arg_8_0.eventData.monsterId = var_8_0.monsterId
	arg_8_0.eventData.isBoss = var_8_0.isBoss
	arg_8_0.eventData.enemyIndex = 1

	EnemyInfoController.instance:dispatchEvent(EnemyInfoEvent.SelectMonsterChange, arg_8_0.eventData)
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0:refreshRule()
	arg_9_0:refreshScrollEnemy()
end

function var_0_0.refreshRule(arg_10_0)
	arg_10_0:recycleAllRuleItem()
	arg_10_0:recycleAllRuleTipItem()

	local var_10_0 = arg_10_0.battleCo.additionRule

	if string.nilorempty(var_10_0) then
		gohelper.setActive(arg_10_0._goline1, false)
		gohelper.setActive(arg_10_0._gorulecontainer, false)

		return
	end

	gohelper.setActive(arg_10_0._gorulecontainer, true)

	local var_10_1 = GameUtil.splitString2(var_10_0, true, "|", "#")

	arg_10_0._ruleList = var_10_1

	arg_10_0:filterRule(var_10_1)

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		local var_10_2 = iter_10_1[1]
		local var_10_3 = iter_10_1[2]
		local var_10_4 = lua_rule.configDict[var_10_3]

		if var_10_4 then
			arg_10_0:addRuleItem(var_10_4, var_10_2)
		end
	end

	gohelper.setActive(arg_10_0._goline1, #var_10_1 > 0)

	local var_10_5 = arg_10_0.ruleTipItemList[#arg_10_0.ruleTipItemList]

	if var_10_5 then
		gohelper.setActive(var_10_5.goLine, false)
	end
end

function var_0_0.filterRule(arg_11_0, arg_11_1)
	if arg_11_0.viewParam.tabEnum == EnemyInfoEnum.TabEnum.Season123 then
		local var_11_0 = Season123Config.instance:getSeasonConstStr(arg_11_0.viewParam.activityId, Activity123Enum.Const.HideRule)
		local var_11_1 = string.splitToNumber(var_11_0, "#")

		for iter_11_0 = #arg_11_1, 1, -1 do
			if tabletool.indexOf(var_11_1, arg_11_1[iter_11_0][2]) then
				table.remove(arg_11_1, iter_11_0)
			end
		end
	end
end

function var_0_0.refreshScrollEnemy(arg_12_0)
	local var_12_0 = arg_12_0.battleCo.monsterGroupIds

	if string.nilorempty(var_12_0) then
		return
	end

	arg_12_0:recycleAllEnemyGroupList()
	arg_12_0:recycleAllEnemyItemList()

	if arg_12_0.viewParam.tabEnum == EnemyInfoEnum.TabEnum.TowerDeep then
		arg_12_0:addTowerDeepGroupItem()

		return
	end

	local var_12_1 = string.splitToNumber(var_12_0, "#")

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		arg_12_0:addGroupItem(iter_12_1, iter_12_0)
	end
end

function var_0_0.recycleAllRuleItem(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.ruleItemList) do
		gohelper.setActive(iter_13_1.go, false)
		table.insert(arg_13_0.ruleItemPool, iter_13_1)
	end

	tabletool.clear(arg_13_0.ruleItemList)
end

function var_0_0.recycleAllRuleTipItem(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.ruleTipItemList) do
		gohelper.setActive(iter_14_1.go, false)
		table.insert(arg_14_0.ruleTipItemPool, iter_14_1)
	end

	tabletool.clear(arg_14_0.ruleTipItemList)
end

function var_0_0.addRuleItem(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_1 then
		logError("rule co nil")

		return
	end

	local var_15_0 = arg_15_0:getRuleItem()

	UISpriteSetMgr.instance:setCommonSprite(var_15_0.tagIcon, "wz_" .. arg_15_2)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_15_0.ruleIcon, arg_15_1.icon)
end

function var_0_0.getRuleItem(arg_16_0)
	if #arg_16_0.ruleItemPool > 0 then
		local var_16_0 = table.remove(arg_16_0.ruleItemPool)

		table.insert(arg_16_0.ruleItemList, var_16_0)
		gohelper.setActive(var_16_0.go, true)
		gohelper.setAsLastSibling(var_16_0.go)

		return var_16_0
	end

	local var_16_1 = arg_16_0:getUserDataTb_()

	var_16_1.go = gohelper.cloneInPlace(arg_16_0._goruleitem)
	var_16_1.ruleIcon = gohelper.findChildImage(var_16_1.go, "#image_ruleicon")
	var_16_1.tagIcon = gohelper.findChildImage(var_16_1.go, "#image_ruleicon/#image_tagicon")

	gohelper.setActive(var_16_1.go, true)
	table.insert(arg_16_0.ruleItemList, var_16_1)

	return var_16_1
end

function var_0_0.recycleAllEnemyGroupList(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.enemyGroupList) do
		gohelper.setActive(iter_17_1.go, false)
		iter_17_1.tr:SetParent(arg_17_0.enemyGroupPoolTr)
		table.insert(arg_17_0.enemyGroupPool, iter_17_1)
	end

	tabletool.clear(arg_17_0.enemyGroupList)
end

function var_0_0.recycleAllEnemyItemList(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.enemyItemList) do
		gohelper.setActive(iter_18_1.go, false)
		iter_18_1.tr:SetParent(arg_18_0.enemyItemPoolTr)

		iter_18_1.monsterId = nil

		table.insert(arg_18_0.enemyItemPool[iter_18_1.variantId], iter_18_1)
	end

	tabletool.clear(arg_18_0.enemyItemList)
end

function var_0_0.getEnemyGroupItem(arg_19_0)
	if #arg_19_0.enemyGroupPool > 0 then
		local var_19_0 = table.remove(arg_19_0.enemyGroupPool)

		table.insert(arg_19_0.enemyGroupList, var_19_0)
		recthelper.setWidth(var_19_0.tr, arg_19_0.layoutMo.scrollEnemyWidth)
		recthelper.setWidth(var_19_0.trContent, arg_19_0.layoutMo.scrollEnemyWidth - EnemyInfoEnum.EnemyGroupLeftMargin)
		gohelper.setActive(var_19_0.go, true)
		gohelper.setAsLastSibling(var_19_0.go)

		return var_19_0
	end

	local var_19_1 = arg_19_0:getUserDataTb_()

	var_19_1.go = gohelper.cloneInPlace(arg_19_0._goenemygroupitem)
	var_19_1.tr = var_19_1.go:GetComponent(gohelper.Type_Transform)
	var_19_1.txtTitleNum = gohelper.findChildText(var_19_1.go, "title/#txt_titlenum")
	var_19_1.trContent = gohelper.findChildComponent(var_19_1.go, "content", gohelper.Type_RectTransform)

	recthelper.setWidth(var_19_1.tr, arg_19_0.layoutMo.scrollEnemyWidth)
	recthelper.setWidth(var_19_1.trContent, arg_19_0.layoutMo.scrollEnemyWidth - EnemyInfoEnum.EnemyGroupLeftMargin)
	gohelper.setActive(var_19_1.go, true)
	table.insert(arg_19_0.enemyGroupList, var_19_1)

	return var_19_1
end

function var_0_0.getEnemyItem(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.enemyItemPool[arg_20_1]

	if not var_20_0 then
		logError("not variantId : " .. tostring(arg_20_1) .. " pool")

		return nil
	end

	if #var_20_0 > 0 then
		local var_20_1 = table.remove(var_20_0)

		table.insert(arg_20_0.enemyItemList, var_20_1)
		gohelper.setActive(var_20_1.go, true)
		gohelper.setAsLastSibling(var_20_1.go)

		return var_20_1
	end

	local var_20_2 = arg_20_0:getUserDataTb_()

	var_20_2.go = gohelper.cloneInPlace(arg_20_0._goenemyitem)
	var_20_2.tr = var_20_2.go:GetComponent(gohelper.Type_Transform)
	var_20_2.icon = gohelper.findChildImage(var_20_2.go, "icon")
	var_20_2.career = gohelper.findChildImage(var_20_2.go, "career")
	var_20_2.selectframe = gohelper.findChild(var_20_2.go, "selectframe")
	var_20_2.bosstag = gohelper.findChild(var_20_2.go, "bosstag")

	gohelper.setActive(var_20_2.selectframe, false)

	var_20_2.btn = gohelper.findChildButtonWithAudio(var_20_2.go, "btn_click", AudioEnum.UI.Play_UI_Tags)

	var_20_2.btn:AddClickListener(arg_20_0.onClickEnemyItem, arg_20_0, var_20_2)

	var_20_2.variantId = arg_20_1

	if arg_20_1 ~= 0 then
		IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPathWithRound(arg_20_1), var_20_2.icon)
	end

	gohelper.setActive(var_20_2.go, true)
	table.insert(arg_20_0.enemyItemList, var_20_2)

	return var_20_2
end

function var_0_0.addGroupItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = lua_monster_group.configDict[arg_21_1]
	local var_21_1 = arg_21_0.tempMonsterIdList or {}
	local var_21_2 = string.splitToNumber(var_21_0.bossId, "#")

	tabletool.clear(var_21_1)

	if not string.nilorempty(var_21_0.monster) then
		tabletool.addValues(var_21_1, string.splitToNumber(var_21_0.monster, "#"))
	end

	if not string.nilorempty(var_21_0.spMonster) then
		tabletool.addValues(var_21_1, string.splitToNumber(var_21_0.spMonster, "#"))
	end

	if #var_21_1 <= 0 then
		return
	end

	local var_21_3 = arg_21_0:getEnemyGroupItem()

	var_21_3.tr:SetParent(arg_21_0.trScrollContent)

	var_21_3.txtTitleNum.text = arg_21_2

	for iter_21_0, iter_21_1 in ipairs(var_21_1) do
		arg_21_0:addMonsterItem(iter_21_1, var_21_3.trContent, var_21_2)
	end
end

function var_0_0.addMonsterItem(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = lua_monster.configDict[arg_22_1]
	local var_22_1 = arg_22_0:getEnemyItem(var_22_0.heartVariantId)

	var_22_1.tr:SetParent(arg_22_2)

	var_22_1.monsterId = arg_22_1
	var_22_1.isBoss = arg_22_0:checkIsBoss(arg_22_3, arg_22_1)
	var_22_1.enemyIndex = #arg_22_0.enemyItemList

	local var_22_2 = FightConfig.instance:getSkinCO(var_22_0.skinId)

	gohelper.getSingleImage(var_22_1.icon.gameObject):LoadImage(ResUrl.monsterHeadIcon(var_22_2.headIcon))
	UISpriteSetMgr.instance:setEnemyInfoSprite(var_22_1.career, "sxy_" .. var_22_0.career)
	gohelper.setActive(var_22_1.bosstag, var_22_1.isBoss)
end

function var_0_0.checkIsBoss(arg_23_0, arg_23_1, arg_23_2)
	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		if arg_23_2 == iter_23_1 then
			return true
		end
	end

	return false
end

function var_0_0.onClickEnemyItem(arg_24_0, arg_24_1)
	arg_24_0.eventData = arg_24_0.eventData or {}
	arg_24_0.eventData.monsterId = arg_24_1.monsterId
	arg_24_0.eventData.isBoss = arg_24_1.isBoss
	arg_24_0.eventData.enemyIndex = arg_24_1.enemyIndex

	EnemyInfoController.instance:dispatchEvent(EnemyInfoEvent.SelectMonsterChange, arg_24_0.eventData)
end

function var_0_0.addTowerDeepGroupItem(arg_25_0)
	local var_25_0 = arg_25_0:getEnemyGroupItem()

	var_25_0.tr:SetParent(arg_25_0.trScrollContent)

	var_25_0.txtTitleNum.text = 1

	local var_25_1 = TowerPermanentDeepModel.instance:getCurDeepMonsterId()

	arg_25_0:addMonsterItem(var_25_1, var_25_0.trContent, {
		var_25_1
	})
end

function var_0_0.onClose(arg_26_0)
	return
end

function var_0_0.onDestroyView(arg_27_0)
	arg_27_0.ruleClick:RemoveClickListener()

	for iter_27_0, iter_27_1 in ipairs(arg_27_0.enemyItemList) do
		iter_27_1.btn:RemoveClickListener()
	end

	for iter_27_2, iter_27_3 in pairs(arg_27_0.enemyItemPool) do
		for iter_27_4, iter_27_5 in ipairs(iter_27_3) do
			iter_27_5.btn:RemoveClickListener()
		end
	end
end

return var_0_0
