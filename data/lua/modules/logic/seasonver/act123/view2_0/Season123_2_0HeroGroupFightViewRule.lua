module("modules.logic.seasonver.act123.view2_0.Season123_2_0HeroGroupFightViewRule", package.seeall)

local var_0_0 = class("Season123_2_0HeroGroupFightViewRule", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorules = gohelper.findChild(arg_1_0.viewGO, "#go_container/infocontain/#go_rules")
	arg_1_0._goimagenormal = gohelper.findChild(arg_1_0.viewGO, "#go_container/infocontain/#go_rules/title/text/#image_normalicondition")
	arg_1_0._goimagerare = gohelper.findChild(arg_1_0.viewGO, "#go_container/infocontain/#go_rules/title/text/#image_rarecondition")
	arg_1_0._goruleitem = gohelper.findChild(arg_1_0.viewGO, "#go_container/infocontain/#go_rules/rulelist/#go_ruleitem")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_container/infocontain/#go_rules/rulelist/#go_ruleitem/image_normal")
	arg_1_0._gorare = gohelper.findChild(arg_1_0.viewGO, "#go_container/infocontain/#go_rules/rulelist/#go_ruleitem/image_rare")
	arg_1_0._txtruleinfo = gohelper.findChildText(arg_1_0.viewGO, "#go_container/infocontain/#go_rules/rulelist/#go_ruleitem/txt_ruleinfo")
	arg_1_0._goadditionRule = gohelper.findChild(arg_1_0.viewGO, "#go_container/infocontain/#go_additionRule")
	arg_1_0._goruletemp = gohelper.findChild(arg_1_0.viewGO, "#go_container/infocontain/#go_additionRule/#go_ruletemp")
	arg_1_0._imagetagicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/infocontain/#go_additionRule/#go_ruletemp/#image_tagicon")
	arg_1_0._gorulelist = gohelper.findChild(arg_1_0.viewGO, "#go_container/infocontain/#go_additionRule/#go_rulelist")
	arg_1_0._btnadditionRuleclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/infocontain/#go_additionRule/#go_rulelist/#btn_additionRuleclick")
	arg_1_0._gocontainer2 = gohelper.findChild(arg_1_0.viewGO, "#go_container2")
	arg_1_0._goruledesc = gohelper.findChild(arg_1_0.viewGO, "#go_container2/#go_ruledesc")
	arg_1_0._btncloserule = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container2/#go_ruledesc/#btn_closerule")
	arg_1_0._goruleitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_container2/#go_ruledesc/bg/#go_ruleitem")
	arg_1_0._goruleDescList = gohelper.findChild(arg_1_0.viewGO, "#go_container2/#go_ruledesc/bg/#go_ruleDescList")
	arg_1_0._btnenemy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/infocontain/enemycontain/enemytitle/#btn_enemy")
	arg_1_0._enemylist = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/infocontain/enemycontain/enemyList/#go_enemyteam/enemyList")
	arg_1_0._txtrecommendlevel = gohelper.findChildText(arg_1_0.viewGO, "#go_container/infocontain/enemycontain/recommendtxt/#txt_recommendLevel")
	arg_1_0._goenemyteam = gohelper.findChild(arg_1_0.viewGO, "#go_container/infocontain/enemycontain/enemyList/#go_enemyteam")
	arg_1_0._gorecommendattr = gohelper.findChild(arg_1_0.viewGO, "#go_container/infocontain/enemycontain/#go_recommendAttr")
	arg_1_0._goattritem = gohelper.findChild(arg_1_0.viewGO, "#go_container/infocontain/enemycontain/#go_recommendAttr/attrlist/#go_attritem")
	arg_1_0._txtrecommonddes = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_container/infocontain/enemycontain/#go_recommendAttr/#txt_recommonddes")
	arg_1_0._btnadditionruledetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/infocontain/#go_additionRule/#go_additionruletips/tips/#btn_additionruledetail")

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
	if not arg_5_0._hasRuleList then
		return
	end

	arg_5_0._ruleItemClick = arg_5_0._goruledesc.activeSelf

	gohelper.setActive(arg_5_0._gocontainer2, true)
	gohelper.setActive(arg_5_0._goruledesc, true)
end

function var_0_0._btnenemyOnClick(arg_6_0)
	EnemyInfoController.instance:openSeason123EnemyInfoViewWithNoTab(Season123HeroGroupModel.instance.activityId, HeroGroupModel.instance.battleId)
end

function var_0_0._btnAdditionRuleDetailOnClick(arg_7_0)
	local var_7_0 = Season123HeroGroupModel.instance.activityId
	local var_7_1 = Season123HeroGroupModel.instance.stage
	local var_7_2 = {
		actId = var_7_0,
		stage = var_7_1
	}

	Season123Controller.instance:openSeasonAdditionRuleTipView(var_7_2)
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
end

function var_0_0._refreshRules(arg_11_0)
	local var_11_0 = HeroGroupModel.instance.episodeId
	local var_11_1 = DungeonConfig.instance:getEpisodeCO(var_11_0).type == DungeonEnum.EpisodeType.Season123Retail
	local var_11_2 = Season123Model.instance:getEpisodeRetail(var_11_0)

	gohelper.setActive(arg_11_0._goruleitem, true)

	if var_11_1 and var_11_2 then
		gohelper.setActive(arg_11_0._gorules, var_11_1 and var_11_2.advancedId ~= 0)
		gohelper.setActive(arg_11_0._goimagenormal, var_11_2.advancedRare == 1)
		gohelper.setActive(arg_11_0._goimagerare, var_11_2.advancedRare == 2)
		gohelper.setActive(arg_11_0._gonormal, var_11_2.advancedRare == 1)
		gohelper.setActive(arg_11_0._gorare, var_11_2.advancedRare == 2)

		if var_11_2.advancedId and var_11_2.advancedId ~= 0 then
			arg_11_0._txtruleinfo.text = lua_condition.configDict[var_11_2.advancedId].desc
		else
			arg_11_0._txtruleinfo.text = ""
		end
	else
		gohelper.setActive(arg_11_0._gorules, false)
	end
end

function var_0_0._refreshAddition(arg_12_0)
	local var_12_0 = HeroGroupModel.instance.episodeId
	local var_12_1 = DungeonConfig.instance:getEpisodeAdditionRule(var_12_0)
	local var_12_2 = GameUtil.splitString2(var_12_1, true, "|", "#")

	if not var_12_2 or #var_12_2 == 0 then
		gohelper.setActive(arg_12_0._goadditionRule, false)

		return
	end

	local var_12_3 = Season123HeroGroupModel.filterRule(Season123HeroGroupModel.instance.activityId, var_12_2)

	if Season123HeroGroupModel.instance.stage then
		var_12_3 = Season123Config.instance:filterRule(var_12_3, Season123HeroGroupModel.instance.stage)
	end

	arg_12_0._hasRuleList = #var_12_3 > 0

	gohelper.setActive(arg_12_0._goadditionRule, true)

	for iter_12_0, iter_12_1 in ipairs(var_12_3) do
		local var_12_4 = iter_12_1[1]
		local var_12_5 = iter_12_1[2]
		local var_12_6 = lua_rule.configDict[var_12_5]

		if var_12_6 then
			arg_12_0:_addRuleItem(var_12_6, var_12_4)
			arg_12_0:_setRuleDescItem(var_12_6, var_12_4)
		end

		if iter_12_0 == #var_12_3 then
			gohelper.setActive(arg_12_0._rulesimagelineList[iter_12_0], false)
		end
	end
end

function var_0_0._addRuleItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = gohelper.clone(arg_13_0._goruletemp, arg_13_0._gorulelist, arg_13_1.id)

	gohelper.setActive(var_13_0, true)

	local var_13_1 = gohelper.findChildImage(var_13_0, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(var_13_1, "wz_" .. arg_13_2)

	local var_13_2 = gohelper.findChildImage(var_13_0, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_13_2, arg_13_1.icon)
end

function var_0_0._setRuleDescItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local var_14_1 = gohelper.clone(arg_14_0._goruleitem2, arg_14_0._goruleDescList, arg_14_1.id)

	gohelper.setActive(var_14_1, true)

	local var_14_2 = gohelper.findChildImage(var_14_1, "icon")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_14_2, arg_14_1.icon)

	local var_14_3 = gohelper.findChild(var_14_1, "line")

	table.insert(arg_14_0._rulesimagelineList, var_14_3)

	local var_14_4 = gohelper.findChildImage(var_14_1, "tag")

	UISpriteSetMgr.instance:setCommonSprite(var_14_4, "wz_" .. arg_14_2)

	local var_14_5 = gohelper.findChildText(var_14_1, "desc")

	SkillHelper.addHyperLinkClick(var_14_5)

	local var_14_6 = arg_14_1.desc
	local var_14_7 = SkillHelper.buildDesc(var_14_6, nil, "#6680bd")
	local var_14_8 = "\n" .. SkillHelper.getTagDescRecursion(var_14_6, "#6680bd")
	local var_14_9 = luaLang("dungeon_add_rule_target_" .. arg_14_2)
	local var_14_10 = var_14_0[arg_14_2]

	var_14_5.text = SkillConfig.instance:fmtTagDescColor(var_14_9, var_14_7 .. var_14_8, var_14_10)
end

function var_0_0._refreshEnemy(arg_15_0)
	local var_15_0 = FightModel.instance:getFightParam()
	local var_15_1 = {}
	local var_15_2 = {}
	local var_15_3 = {}
	local var_15_4 = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0.monsterGroupIds) do
		local var_15_5 = lua_monster_group.configDict[iter_15_1].bossId
		local var_15_6 = string.splitToNumber(lua_monster_group.configDict[iter_15_1].monster, "#")

		for iter_15_2, iter_15_3 in ipairs(var_15_6) do
			local var_15_7 = lua_monster.configDict[iter_15_3].career

			if iter_15_3 == var_15_5 then
				var_15_1[var_15_7] = (var_15_1[var_15_7] or 0) + 1

				table.insert(var_15_4, iter_15_3)
			else
				var_15_2[var_15_7] = (var_15_2[var_15_7] or 0) + 1

				table.insert(var_15_3, iter_15_3)
			end
		end
	end

	local var_15_8 = {}

	for iter_15_4, iter_15_5 in pairs(var_15_1) do
		table.insert(var_15_8, {
			career = iter_15_4,
			count = iter_15_5
		})
	end

	arg_15_0._enemyBossEndIndex = #var_15_8

	for iter_15_6, iter_15_7 in pairs(var_15_2) do
		table.insert(var_15_8, {
			career = iter_15_6,
			count = iter_15_7
		})
	end

	gohelper.CreateObjList(arg_15_0, arg_15_0._onEnemyItemShow, var_15_8, gohelper.findChild(arg_15_0._goenemyteam, "enemyList"), gohelper.findChild(arg_15_0._goenemyteam, "enemyList/go_enemyitem"))

	local var_15_9 = DungeonModel.instance.curSendEpisodeId
	local var_15_10 = DungeonConfig.instance:getEpisodeCO(var_15_9)
	local var_15_11 = 0

	if var_15_10.type == DungeonEnum.EpisodeType.Season123 then
		local var_15_12 = Season123Config.instance:getSeasonEpisodeCo(Season123HeroGroupModel.instance.activityId, Season123HeroGroupModel.instance.stage, Season123HeroGroupModel.instance.layer)

		if var_15_12 then
			var_15_11 = var_15_12.level
		end
	else
		var_15_11 = FightHelper.getBattleRecommendLevel(var_15_10.battleId)
	end

	if #var_15_4 > 0 then
		arg_15_0._txtrecommendlevel.text = HeroConfig.instance:getCommonLevelDisplay(var_15_11)
	elseif #var_15_3 > 0 then
		arg_15_0._txtrecommendlevel.text = HeroConfig.instance:getCommonLevelDisplay(var_15_11)
	else
		arg_15_0._txtrecommendlevel.text = ""
	end
end

function var_0_0._recommendCareer(arg_16_0)
	local var_16_0, var_16_1 = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(arg_16_0, arg_16_0._onRecommendCareerItemShow, var_16_0, gohelper.findChild(arg_16_0._gorecommendattr.gameObject, "attrlist"), arg_16_0._goattritem)

	if #var_16_0 == 0 then
		arg_16_0._txtrecommonddes.text = luaLang("new_common_none")
	else
		arg_16_0._txtrecommonddes.text = ""
	end
end

function var_0_0._onRecommendCareerItemShow(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = gohelper.findChildImage(arg_17_1, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(var_17_0, "career_" .. arg_17_2)
end

function var_0_0._onEnemyItemShow(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = gohelper.findChildImage(arg_18_1, "icon")
	local var_18_1 = gohelper.findChild(arg_18_1, "icon/kingIcon")
	local var_18_2 = gohelper.findChildTextMesh(arg_18_1, "enemycount")

	UISpriteSetMgr.instance:setCommonSprite(var_18_0, "lssx_" .. tostring(arg_18_2.career))

	var_18_2.text = arg_18_2.count > 1 and luaLang("multiple") .. arg_18_2.count or ""

	gohelper.setActive(var_18_1, arg_18_3 <= arg_18_0._enemyBossEndIndex)
end

function var_0_0.onClose(arg_19_0)
	arg_19_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_19_0._recommendCareer, arg_19_0)
end

function var_0_0.onDestroyView(arg_20_0)
	return
end

return var_0_0
