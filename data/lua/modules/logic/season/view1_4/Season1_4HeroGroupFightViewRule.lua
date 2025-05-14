module("modules.logic.season.view1_4.Season1_4HeroGroupFightViewRule", package.seeall)

local var_0_0 = class("Season1_4HeroGroupFightViewRule", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorules = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_rules")
	arg_1_0._goimagenormal = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_rules/title/text/#image_normalicondition")
	arg_1_0._goimagerare = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_rules/title/text/#image_rarecondition")
	arg_1_0._goruleitem = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_rules/rulelist/#go_ruleitem")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_rules/rulelist/#go_ruleitem/image_normal")
	arg_1_0._gorare = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_rules/rulelist/#go_ruleitem/image_rare")
	arg_1_0._txtruleinfo = gohelper.findChildText(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_rules/rulelist/#go_ruleitem/txt_ruleinfo")
	arg_1_0._goadditionRule = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule")
	arg_1_0._goruletemp = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_ruletemp")
	arg_1_0._imagetagicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_ruletemp/#image_tagicon")
	arg_1_0._gorulelist = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_rulelist")
	arg_1_0._btnadditionRuleclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_rulelist/#btn_additionRuleclick")
	arg_1_0._gocontainer2 = gohelper.findChild(arg_1_0.viewGO, "#go_container2")
	arg_1_0._goruledesc = gohelper.findChild(arg_1_0.viewGO, "#go_container2/#go_ruledesc")
	arg_1_0._btncloserule = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container2/#go_ruledesc/#btn_closerule")
	arg_1_0._goruleitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_container2/#go_ruledesc/bg/#go_ruleitem")
	arg_1_0._goruleDescList = gohelper.findChild(arg_1_0.viewGO, "#go_container2/#go_ruledesc/bg/#go_ruleDescList")
	arg_1_0._btnenemy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemyList/#btn_enemy")
	arg_1_0._enemylist = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemyList/#go_enemyteam/enemyList")
	arg_1_0._txtrecommendlevel = gohelper.findChildText(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/recommendtxt/#txt_recommendLevel")
	arg_1_0._goenemyteam = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemyList/#go_enemyteam")
	arg_1_0._gorecommendattr = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr")
	arg_1_0._goattritem = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr/attrlist/#go_attritem")
	arg_1_0._txtrecommonddes = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr/#txt_recommonddes")
	arg_1_0._btnadditionruledetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_additionruletips/tips/#btn_additionruledetail")
	arg_1_0._goTask = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_task")
	arg_1_0._txtTask = gohelper.findChildText(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_task/#go_taskitem/#txt_task")

	gohelper.setActive(arg_1_0._goTask, false)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnadditionRuleclick:AddClickListener(arg_2_0._btnadditionRuleOnClick, arg_2_0)
	arg_2_0._btncloserule:AddClickListener(arg_2_0._btncloseruleOnClick, arg_2_0)
	arg_2_0._btnenemy:AddClickListener(arg_2_0._btnenemyOnClick, arg_2_0)
	arg_2_0._enemylist:AddClickListener(arg_2_0._btnenemyOnClick, arg_2_0)
	arg_2_0._btnadditionruledetail:AddClickListener(arg_2_0._btnAdditionRuleDetailOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnadditionRuleclick:RemoveClickListener()
	arg_3_0._btncloserule:RemoveClickListener()
	arg_3_0._btnenemy:RemoveClickListener()
	arg_3_0._enemylist:RemoveClickListener()
	arg_3_0._btnadditionruledetail:RemoveClickListener()
end

function var_0_0._btncloseruleOnClick(arg_4_0)
	if arg_4_0._ruleItemClick then
		arg_4_0._ruleItemClick = false

		return
	end

	gohelper.setActive(arg_4_0._goruledesc, false)
end

function var_0_0._btnadditionRuleOnClick(arg_5_0)
	arg_5_0._ruleItemClick = arg_5_0._goruledesc.activeSelf

	gohelper.setActive(arg_5_0._goruledesc, true)
end

function var_0_0._btnenemyOnClick(arg_6_0)
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(HeroGroupModel.instance.battleId)
end

function var_0_0._btnAdditionRuleDetailOnClick(arg_7_0)
	local var_7_0 = Activity104Model.instance:getCurSeasonId()
	local var_7_1 = {
		actId = var_7_0
	}

	Activity104Controller.instance:openSeasonAdditionRuleTipView(var_7_1)
end

function var_0_0._editableInitView(arg_8_0)
	gohelper.addUIClickAudio(arg_8_0._btnenemy.gameObject, AudioEnum.UI.play_ui_formation_monstermessage)
	gohelper.setActive(arg_8_0._goruleitem2, false)
	gohelper.setActive(arg_8_0._goruletemp, false)
	gohelper.setActive(arg_8_0._goruledesc, false)

	arg_8_0._monsterGroupItemList = {}
	arg_8_0._rulesimageList = arg_8_0:getUserDataTb_()
	arg_8_0._rulesimagelineList = arg_8_0:getUserDataTb_()
	arg_8_0._simageList = arg_8_0:getUserDataTb_()
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_9_0._recommendCareer, arg_9_0)
	arg_9_0:_refreshUI()
end

function var_0_0._refreshUI(arg_10_0)
	arg_10_0:_refreshRules()
	arg_10_0:_refreshAddition()
	arg_10_0:_refreshEnemy()
	arg_10_0:_recommendCareer()
	arg_10_0:_refreshTask()
end

function var_0_0._refreshTask(arg_11_0)
	local var_11_0 = Activity126Config.instance:getDramlandTask(HeroGroupModel.instance.battleId)

	if var_11_0 then
		gohelper.setActive(arg_11_0._goTask, true)

		arg_11_0._txtTask.text = var_11_0.desc
	else
		gohelper.setActive(arg_11_0._goTask, false)
	end
end

function var_0_0._refreshRules(arg_12_0)
	local var_12_0 = HeroGroupModel.instance.episodeId
	local var_12_1 = DungeonConfig.instance:getEpisodeCO(var_12_0).type == DungeonEnum.EpisodeType.SeasonRetail
	local var_12_2 = Activity104Model.instance:getEpisodeRetail(var_12_0)

	gohelper.setActive(arg_12_0._gorules, var_12_1 and var_12_2.advancedId ~= 0)
	gohelper.setActive(arg_12_0._goruleitem, true)

	if var_12_1 then
		gohelper.setActive(arg_12_0._goimagenormal, var_12_2.advancedRare == 1)
		gohelper.setActive(arg_12_0._goimagerare, var_12_2.advancedRare == 2)
		gohelper.setActive(arg_12_0._gonormal, var_12_2.advancedRare == 1)
		gohelper.setActive(arg_12_0._gorare, var_12_2.advancedRare == 2)

		if var_12_2.advancedId and var_12_2.advancedId ~= 0 then
			arg_12_0._txtruleinfo.text = lua_condition.configDict[var_12_2.advancedId].desc
		else
			arg_12_0._txtruleinfo.text = ""
		end
	end
end

function var_0_0._refreshAddition(arg_13_0)
	local var_13_0 = HeroGroupModel.instance.episodeId
	local var_13_1 = DungeonConfig.instance:getEpisodeAdditionRule(var_13_0)
	local var_13_2 = GameUtil.splitString2(var_13_1, true, "|", "#")

	if not var_13_2 or #var_13_2 == 0 then
		gohelper.setActive(arg_13_0._goadditionRule, false)

		return
	end

	gohelper.setActive(arg_13_0._goadditionRule, true)

	local var_13_3 = SeasonConfig.instance:filterRule(var_13_2)

	for iter_13_0, iter_13_1 in ipairs(var_13_3) do
		local var_13_4 = iter_13_1[1]
		local var_13_5 = iter_13_1[2]
		local var_13_6 = lua_rule.configDict[var_13_5]

		if var_13_6 then
			arg_13_0:_addRuleItem(var_13_6, var_13_4)
			arg_13_0:_setRuleDescItem(var_13_6, var_13_4)
		end

		if iter_13_0 == #var_13_3 then
			gohelper.setActive(arg_13_0._rulesimagelineList[iter_13_0], false)
		end
	end
end

function var_0_0._addRuleItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = gohelper.clone(arg_14_0._goruletemp, arg_14_0._gorulelist, arg_14_1.id)

	gohelper.setActive(var_14_0, true)

	local var_14_1 = gohelper.findChildImage(var_14_0, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(var_14_1, "wz_" .. arg_14_2)

	local var_14_2 = gohelper.findChildImage(var_14_0, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_14_2, arg_14_1.icon)
end

function var_0_0._setRuleDescItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local var_15_1 = gohelper.clone(arg_15_0._goruleitem2, arg_15_0._goruleDescList, arg_15_1.id)

	gohelper.setActive(var_15_1, true)

	local var_15_2 = gohelper.findChildImage(var_15_1, "icon")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_15_2, arg_15_1.icon)

	local var_15_3 = gohelper.findChild(var_15_1, "line")

	table.insert(arg_15_0._rulesimagelineList, var_15_3)

	local var_15_4 = gohelper.findChildImage(var_15_1, "tag")

	UISpriteSetMgr.instance:setCommonSprite(var_15_4, "wz_" .. arg_15_2)

	local var_15_5 = gohelper.findChildText(var_15_1, "desc")

	SkillHelper.addHyperLinkClick(var_15_5)

	local var_15_6 = arg_15_1.desc
	local var_15_7 = SkillHelper.buildDesc(var_15_6, nil, "#6680bd")
	local var_15_8 = "\n" .. SkillHelper.getTagDescRecursion(var_15_6, "#6680bd")
	local var_15_9 = luaLang("dungeon_add_rule_target_" .. arg_15_2)
	local var_15_10 = var_15_0[arg_15_2]

	var_15_5.text = string.format("<color=%s>[%s]</color>%s%s", var_15_10, var_15_9, var_15_7, var_15_8)
end

function var_0_0._refreshEnemy(arg_16_0)
	local var_16_0 = FightModel.instance:getFightParam()
	local var_16_1 = {}
	local var_16_2 = {}
	local var_16_3 = {}
	local var_16_4 = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0.monsterGroupIds) do
		local var_16_5 = lua_monster_group.configDict[iter_16_1].bossId
		local var_16_6 = string.splitToNumber(lua_monster_group.configDict[iter_16_1].monster, "#")

		for iter_16_2, iter_16_3 in ipairs(var_16_6) do
			local var_16_7 = lua_monster.configDict[iter_16_3].career

			if FightHelper.isBossId(var_16_5, iter_16_3) then
				var_16_1[var_16_7] = (var_16_1[var_16_7] or 0) + 1

				table.insert(var_16_4, iter_16_3)
			else
				var_16_2[var_16_7] = (var_16_2[var_16_7] or 0) + 1

				table.insert(var_16_3, iter_16_3)
			end
		end
	end

	local var_16_8 = {}

	for iter_16_4, iter_16_5 in pairs(var_16_1) do
		table.insert(var_16_8, {
			career = iter_16_4,
			count = iter_16_5
		})
	end

	arg_16_0._enemyBossEndIndex = #var_16_8

	for iter_16_6, iter_16_7 in pairs(var_16_2) do
		table.insert(var_16_8, {
			career = iter_16_6,
			count = iter_16_7
		})
	end

	gohelper.CreateObjList(arg_16_0, arg_16_0._onEnemyItemShow, var_16_8, gohelper.findChild(arg_16_0._goenemyteam, "enemyList"), gohelper.findChild(arg_16_0._goenemyteam, "enemyList/go_enemyitem"))

	local var_16_9 = DungeonModel.instance.curSendEpisodeId
	local var_16_10 = DungeonConfig.instance:getEpisodeCO(var_16_9)
	local var_16_11 = 0

	if var_16_10.type == DungeonEnum.EpisodeType.Season then
		local var_16_12 = Activity104Model.instance:getBattleFinishLayer()

		var_16_11 = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), var_16_12).level
	elseif var_16_10.type == DungeonEnum.EpisodeType.SeasonRetail then
		local var_16_13 = Activity104Model.instance:getRetailStage()

		var_16_11 = SeasonConfig.instance:getSeasonRetailCo(Activity104Model.instance:getCurSeasonId(), var_16_13).level
	elseif var_16_10.type == DungeonEnum.EpisodeType.SeasonSpecial then
		local var_16_14 = Activity104Model.instance:getBattleFinishLayer()

		var_16_11 = SeasonConfig.instance:getSeasonSpecialCo(Activity104Model.instance:getCurSeasonId(), var_16_14).level
	else
		var_16_11 = FightHelper.getBattleRecommendLevel(var_16_0.battleId)
	end

	if #var_16_4 > 0 then
		arg_16_0._txtrecommendlevel.text = HeroConfig.instance:getCommonLevelDisplay(var_16_11)
	elseif #var_16_3 > 0 then
		arg_16_0._txtrecommendlevel.text = HeroConfig.instance:getCommonLevelDisplay(var_16_11)
	else
		arg_16_0._txtrecommendlevel.text = ""
	end
end

function var_0_0._recommendCareer(arg_17_0)
	local var_17_0, var_17_1 = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(arg_17_0, arg_17_0._onRecommendCareerItemShow, var_17_0, gohelper.findChild(arg_17_0._gorecommendattr.gameObject, "attrlist"), arg_17_0._goattritem)

	if #var_17_0 == 0 then
		arg_17_0._txtrecommonddes.text = luaLang("new_common_none")
	else
		arg_17_0._txtrecommonddes.text = ""
	end
end

function var_0_0._onRecommendCareerItemShow(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = gohelper.findChildImage(arg_18_1, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(var_18_0, "career_" .. arg_18_2)
end

function var_0_0._onEnemyItemShow(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = gohelper.findChildImage(arg_19_1, "icon")
	local var_19_1 = gohelper.findChild(arg_19_1, "icon/kingIcon")
	local var_19_2 = gohelper.findChildTextMesh(arg_19_1, "enemycount")

	UISpriteSetMgr.instance:setCommonSprite(var_19_0, "lssx_" .. tostring(arg_19_2.career))

	var_19_2.text = arg_19_2.count > 1 and luaLang("multiple") .. arg_19_2.count or ""

	gohelper.setActive(var_19_1, arg_19_3 <= arg_19_0._enemyBossEndIndex)
end

function var_0_0.onClose(arg_20_0)
	arg_20_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_20_0._recommendCareer, arg_20_0)
end

function var_0_0.onDestroyView(arg_21_0)
	return
end

return var_0_0
