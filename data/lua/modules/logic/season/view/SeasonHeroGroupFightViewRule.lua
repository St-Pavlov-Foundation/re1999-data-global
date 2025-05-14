module("modules.logic.season.view.SeasonHeroGroupFightViewRule", package.seeall)

local var_0_0 = class("SeasonHeroGroupFightViewRule", BaseView)

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
	arg_1_0._btnenemy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/infocontain/enemycontain/enemyList/#btn_enemy")
	arg_1_0._enemylist = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/infocontain/enemycontain/enemyList/#go_enemyteam/enemyList")
	arg_1_0._txtrecommendlevel = gohelper.findChildText(arg_1_0.viewGO, "#go_container/infocontain/enemycontain/recommendtxt/#txt_recommendLevel")
	arg_1_0._goenemyteam = gohelper.findChild(arg_1_0.viewGO, "#go_container/infocontain/enemycontain/enemyList/#go_enemyteam")
	arg_1_0._gorecommendattr = gohelper.findChild(arg_1_0.viewGO, "#go_container/infocontain/enemycontain/#go_recommendAttr")
	arg_1_0._goattritem = gohelper.findChild(arg_1_0.viewGO, "#go_container/infocontain/enemycontain/#go_recommendAttr/attrlist/#go_attritem")
	arg_1_0._txtrecommonddes = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_container/infocontain/enemycontain/#go_recommendAttr/#txt_recommonddes")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnadditionRuleclick:AddClickListener(arg_2_0._btnadditionRuleOnClick, arg_2_0)
	arg_2_0._btncloserule:AddClickListener(arg_2_0._btncloseruleOnClick, arg_2_0)
	arg_2_0._btnenemy:AddClickListener(arg_2_0._btnenemyOnClick, arg_2_0)
	arg_2_0._enemylist:AddClickListener(arg_2_0._btnenemyOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnadditionRuleclick:RemoveClickListener()
	arg_3_0._btncloserule:RemoveClickListener()
	arg_3_0._btnenemy:RemoveClickListener()
	arg_3_0._enemylist:RemoveClickListener()
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

	gohelper.setActive(arg_5_0._gocontainer2, true)
	gohelper.setActive(arg_5_0._goruledesc, true)
end

function var_0_0._btnenemyOnClick(arg_6_0)
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(HeroGroupModel.instance.battleId)
end

function var_0_0._editableInitView(arg_7_0)
	gohelper.addUIClickAudio(arg_7_0._btnenemy.gameObject, AudioEnum.UI.play_ui_formation_monstermessage)
	gohelper.setActive(arg_7_0._goruleitem2, false)
	gohelper.setActive(arg_7_0._goruletemp, false)
	gohelper.setActive(arg_7_0._goruledesc, false)

	arg_7_0._monsterGroupItemList = {}
	arg_7_0._rulesimageList = arg_7_0:getUserDataTb_()
	arg_7_0._rulesimagelineList = arg_7_0:getUserDataTb_()
	arg_7_0._simageList = arg_7_0:getUserDataTb_()
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_8_0._recommendCareer, arg_8_0)
	arg_8_0:_refreshUI()
end

function var_0_0._refreshUI(arg_9_0)
	arg_9_0:_refreshRules()
	arg_9_0:_refreshAddition()
	arg_9_0:_refreshEnemy()
	arg_9_0:_recommendCareer()
end

function var_0_0._refreshRules(arg_10_0)
	local var_10_0 = HeroGroupModel.instance.episodeId
	local var_10_1 = DungeonConfig.instance:getEpisodeCO(var_10_0).type == DungeonEnum.EpisodeType.SeasonRetail
	local var_10_2 = Activity104Model.instance:getEpisodeRetail(var_10_0)

	gohelper.setActive(arg_10_0._gorules, var_10_1 and var_10_2.advancedId ~= 0)
	gohelper.setActive(arg_10_0._goruleitem, true)

	if var_10_1 then
		gohelper.setActive(arg_10_0._goimagenormal, var_10_2.advancedRare == 1)
		gohelper.setActive(arg_10_0._goimagerare, var_10_2.advancedRare == 2)
		gohelper.setActive(arg_10_0._gonormal, var_10_2.advancedRare == 1)
		gohelper.setActive(arg_10_0._gorare, var_10_2.advancedRare == 2)

		if var_10_2.advancedId and var_10_2.advancedId ~= 0 then
			arg_10_0._txtruleinfo.text = lua_condition.configDict[var_10_2.advancedId].desc
		else
			arg_10_0._txtruleinfo.text = ""
		end
	end
end

function var_0_0._refreshAddition(arg_11_0)
	local var_11_0 = HeroGroupModel.instance.episodeId
	local var_11_1 = DungeonConfig.instance:getEpisodeAdditionRule(var_11_0)
	local var_11_2 = GameUtil.splitString2(var_11_1, true, "|", "#")

	if not var_11_2 or #var_11_2 == 0 then
		gohelper.setActive(arg_11_0._goadditionRule, false)

		return
	end

	gohelper.setActive(arg_11_0._goadditionRule, true)

	for iter_11_0, iter_11_1 in ipairs(var_11_2) do
		local var_11_3 = iter_11_1[1]
		local var_11_4 = iter_11_1[2]
		local var_11_5 = lua_rule.configDict[var_11_4]

		if var_11_5 then
			arg_11_0:_addRuleItem(var_11_5, var_11_3)
			arg_11_0:_setRuleDescItem(var_11_5, var_11_3)
		end

		if iter_11_0 == #var_11_2 then
			gohelper.setActive(arg_11_0._rulesimagelineList[iter_11_0], false)
		end
	end
end

function var_0_0._addRuleItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = gohelper.clone(arg_12_0._goruletemp, arg_12_0._gorulelist, arg_12_1.id)

	gohelper.setActive(var_12_0, true)

	local var_12_1 = gohelper.findChildImage(var_12_0, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(var_12_1, "wz_" .. arg_12_2)

	local var_12_2 = gohelper.findChildImage(var_12_0, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_12_2, arg_12_1.icon)
end

function var_0_0._setRuleDescItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local var_13_1 = gohelper.clone(arg_13_0._goruleitem2, arg_13_0._goruleDescList, arg_13_1.id)

	gohelper.setActive(var_13_1, true)

	local var_13_2 = gohelper.findChildImage(var_13_1, "icon")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_13_2, arg_13_1.icon)

	local var_13_3 = gohelper.findChild(var_13_1, "line")

	table.insert(arg_13_0._rulesimagelineList, var_13_3)

	local var_13_4 = gohelper.findChildImage(var_13_1, "tag")

	UISpriteSetMgr.instance:setCommonSprite(var_13_4, "wz_" .. arg_13_2)

	local var_13_5 = gohelper.findChildText(var_13_1, "desc")

	SkillHelper.addHyperLinkClick(var_13_5)

	local var_13_6 = arg_13_1.desc
	local var_13_7 = SkillHelper.buildDesc(var_13_6, nil, "#6680bd")
	local var_13_8 = "\n" .. SkillHelper.getTagDescRecursion(var_13_6, "#6680bd")
	local var_13_9 = luaLang("dungeon_add_rule_target_" .. arg_13_2)
	local var_13_10 = var_13_0[arg_13_2]

	var_13_5.text = SkillConfig.instance:fmtTagDescColor(var_13_9, var_13_7 .. var_13_8, var_13_10)
end

function var_0_0._refreshEnemy(arg_14_0)
	local var_14_0 = FightModel.instance:getFightParam()
	local var_14_1 = {}
	local var_14_2 = {}
	local var_14_3 = {}
	local var_14_4 = {}

	for iter_14_0, iter_14_1 in ipairs(var_14_0.monsterGroupIds) do
		local var_14_5 = lua_monster_group.configDict[iter_14_1].bossId
		local var_14_6 = string.splitToNumber(lua_monster_group.configDict[iter_14_1].monster, "#")

		for iter_14_2, iter_14_3 in ipairs(var_14_6) do
			local var_14_7 = lua_monster.configDict[iter_14_3].career

			if FightHelper.isBossId(var_14_5, iter_14_3) then
				var_14_1[var_14_7] = (var_14_1[var_14_7] or 0) + 1

				table.insert(var_14_4, iter_14_3)
			else
				var_14_2[var_14_7] = (var_14_2[var_14_7] or 0) + 1

				table.insert(var_14_3, iter_14_3)
			end
		end
	end

	local var_14_8 = {}

	for iter_14_4, iter_14_5 in pairs(var_14_1) do
		table.insert(var_14_8, {
			career = iter_14_4,
			count = iter_14_5
		})
	end

	arg_14_0._enemyBossEndIndex = #var_14_8

	for iter_14_6, iter_14_7 in pairs(var_14_2) do
		table.insert(var_14_8, {
			career = iter_14_6,
			count = iter_14_7
		})
	end

	gohelper.CreateObjList(arg_14_0, arg_14_0._onEnemyItemShow, var_14_8, gohelper.findChild(arg_14_0._goenemyteam, "enemyList"), gohelper.findChild(arg_14_0._goenemyteam, "enemyList/go_enemyitem"))

	local var_14_9 = DungeonModel.instance.curSendEpisodeId
	local var_14_10 = DungeonConfig.instance:getEpisodeCO(var_14_9)
	local var_14_11 = 0

	if var_14_10.type == DungeonEnum.EpisodeType.Season then
		local var_14_12 = Activity104Model.instance:getBattleFinishLayer()

		var_14_11 = SeasonConfig.instance:getSeasonEpisodeCo(ActivityEnum.Activity.Season, var_14_12).level
	elseif var_14_10.type == DungeonEnum.EpisodeType.SeasonRetail then
		local var_14_13 = Activity104Model.instance:getRetailStage()

		var_14_11 = SeasonConfig.instance:getSeasonRetailCo(ActivityEnum.Activity.Season, var_14_13).level
	elseif var_14_10.type == DungeonEnum.EpisodeType.SeasonSpecial then
		local var_14_14 = Activity104Model.instance:getBattleFinishLayer()

		var_14_11 = SeasonConfig.instance:getSeasonSpecialCo(ActivityEnum.Activity.Season, var_14_14).level
	end

	if #var_14_4 > 0 then
		arg_14_0._txtrecommendlevel.text = HeroConfig.instance:getCommonLevelDisplay(var_14_11)
	elseif #var_14_3 > 0 then
		arg_14_0._txtrecommendlevel.text = HeroConfig.instance:getCommonLevelDisplay(var_14_11)
	else
		arg_14_0._txtrecommendlevel.text = ""
	end
end

function var_0_0._recommendCareer(arg_15_0)
	local var_15_0, var_15_1 = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(arg_15_0, arg_15_0._onRecommendCareerItemShow, var_15_0, gohelper.findChild(arg_15_0._gorecommendattr.gameObject, "attrlist"), arg_15_0._goattritem)

	if #var_15_0 == 0 then
		arg_15_0._txtrecommonddes.text = luaLang("new_common_none")
	else
		arg_15_0._txtrecommonddes.text = ""
	end
end

function var_0_0._onRecommendCareerItemShow(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = gohelper.findChildImage(arg_16_1, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(var_16_0, "career_" .. arg_16_2)
end

function var_0_0._onEnemyItemShow(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = gohelper.findChildImage(arg_17_1, "icon")
	local var_17_1 = gohelper.findChild(arg_17_1, "icon/kingIcon")
	local var_17_2 = gohelper.findChildTextMesh(arg_17_1, "enemycount")

	UISpriteSetMgr.instance:setCommonSprite(var_17_0, "lssx_" .. tostring(arg_17_2.career))

	var_17_2.text = arg_17_2.count > 1 and luaLang("multiple") .. arg_17_2.count or ""

	gohelper.setActive(var_17_1, arg_17_3 <= arg_17_0._enemyBossEndIndex)
end

function var_0_0.onClose(arg_18_0)
	arg_18_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_18_0._recommendCareer, arg_18_0)
end

function var_0_0.onDestroyView(arg_19_0)
	return
end

return var_0_0
