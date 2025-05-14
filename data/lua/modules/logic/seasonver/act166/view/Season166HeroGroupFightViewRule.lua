module("modules.logic.seasonver.act166.view.Season166HeroGroupFightViewRule", package.seeall)

local var_0_0 = class("Season166HeroGroupFightViewRule", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container")
	arg_1_0._scrollinfo = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_container/#scroll_info")
	arg_1_0._btntargetShow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/txt_target/#btn_targetShow")
	arg_1_0._gotargetconditionContent = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList")
	arg_1_0._gotargetcondition = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_targetcondition")
	arg_1_0._txttargetcondition = gohelper.findChildText(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_targetcondition/#txt_targetcondition")
	arg_1_0._gonormalfinish = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_targetcondition/#go_normalfinish")
	arg_1_0._gonormalunfinish = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_targetcondition/#go_normalunfinish")
	arg_1_0._gobasespotfinish = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_targetcondition/#go_basespotfinish")
	arg_1_0._gobasespotunfinish = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_targetcondition/#go_basespotunfinish")
	arg_1_0._gostrategy = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/strategy")
	arg_1_0._txtstrategydesc = gohelper.findChildText(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/strategy/strategydesc/#txt_strategydesc")
	arg_1_0._goadditionRule = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule")
	arg_1_0._gorulelist = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_rulelist")
	arg_1_0._btnadditionRuleclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_rulelist/#btn_additionRuleclick")
	arg_1_0._goruletemp = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_ruletemp")
	arg_1_0._imagetagicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_ruletemp/#image_tagicon")
	arg_1_0._btnenemy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemytitle/#btn_enemy")
	arg_1_0._enemylist = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemyList/#go_enemyteam/enemyList")
	arg_1_0._txtrecommendlevel = gohelper.findChildText(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/recommendtxt/#txt_recommendLevel")
	arg_1_0._goenemyteam = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemyList/#go_enemyteam")
	arg_1_0._gorecommendattr = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr")
	arg_1_0._goattritem = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr/attrlist/#go_attritem")
	arg_1_0._txtrecommonddes = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr/#txt_recommonddes")
	arg_1_0._gorulewindow = gohelper.findChild(arg_1_0.viewGO, "#go_rulewindow")
	arg_1_0._goruledesc = gohelper.findChild(arg_1_0.viewGO, "#go_rulewindow/#go_ruledesc")

	gohelper.setActive(arg_1_0._goruledesc, false)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntargetShow:AddClickListener(arg_2_0._btntargetShowOnClick, arg_2_0)
	arg_2_0._btnadditionRuleclick:AddClickListener(arg_2_0._btnadditionRuleOnClick, arg_2_0)
	arg_2_0._btnenemy:AddClickListener(arg_2_0._btnenemyOnClick, arg_2_0)
	arg_2_0._enemylist:AddClickListener(arg_2_0._btnenemyOnClick, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_2_0._recommendCareer, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntargetShow:RemoveClickListener()
	arg_3_0._btnadditionRuleclick:RemoveClickListener()
	arg_3_0._btnenemy:RemoveClickListener()
	arg_3_0._enemylist:RemoveClickListener()
	arg_3_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_3_0._recommendCareer, arg_3_0)
end

function var_0_0._btntargetShowOnClick(arg_4_0)
	arg_4_0:checkAndOpenTargetView(true)
end

function var_0_0._btnadditionRuleOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = arg_5_0._ruleList
	})
end

function var_0_0._btnenemyOnClick(arg_6_0)
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(arg_6_0.battleId)
end

function var_0_0._editableInitView(arg_7_0)
	gohelper.setActive(arg_7_0._gorulewindow, false)
	gohelper.setActive(arg_7_0._gotargetcondition, true)
	gohelper.setActive(arg_7_0._goruletemp, false)
	gohelper.setActive(arg_7_0._goruleitem, false)

	arg_7_0._rulesimagelineList = arg_7_0:getUserDataTb_()
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:initData()
	arg_8_0:checkAndOpenTargetView()
	arg_8_0:refreshTargetCondition()
	arg_8_0:refreshStrategy()
	arg_8_0:refreshRuleUI()
	arg_8_0:_showEnemyList()
	arg_8_0:_recommendCareer()
end

function var_0_0.initData(arg_9_0)
	arg_9_0.actId = arg_9_0.viewParam.actId
	arg_9_0.context = Season166Model.instance:getBattleContext()
	arg_9_0.episodeId = arg_9_0.viewParam.episodeId or Season166HeroGroupModel.instance.episodeId
	arg_9_0.episodeConfig = DungeonConfig.instance:getEpisodeCO(arg_9_0.episodeId)
	arg_9_0.battleId = arg_9_0.viewParam.battleId or arg_9_0.episodeConfig.battleId
	arg_9_0.battleConfig = arg_9_0.battleId and lua_battle.configDict[arg_9_0.episodeConfig.battleId]
	arg_9_0.isTrainEpisode = Season166HeroGroupModel.instance:isSeason166TrainEpisode(arg_9_0.episodeId)
end

function var_0_0.checkAndOpenTargetView(arg_10_0, arg_10_1)
	if arg_10_0.context and arg_10_0.context.baseId and arg_10_0.context.baseId > 0 then
		gohelper.setActive(arg_10_0._btntargetShow.gameObject, true)

		local var_10_0 = Season166Model.instance:getLocalPrefsTab(Season166Enum.EnterSpotKey)[arg_10_0.context.baseId] == 1

		if not var_10_0 or arg_10_1 then
			ViewMgr.instance:openView(ViewName.Season166HeroGroupTargetView, {
				actId = arg_10_0.actId,
				baseId = arg_10_0.context.baseId
			})
		end

		if not var_10_0 then
			Season166Model.instance:setLocalPrefsTab(Season166Enum.EnterSpotKey, arg_10_0.context.baseId, 1)
		end
	else
		gohelper.setActive(arg_10_0._btntargetShow.gameObject, false)
	end
end

function var_0_0.refreshTargetCondition(arg_11_0)
	if arg_11_0.context and arg_11_0.context.baseId and arg_11_0.context.baseId > 0 then
		local var_11_0 = {}

		for iter_11_0 = 1, 3 do
			local var_11_1 = Season166Config.instance:getSeasonScoreCo(arg_11_0.actId, iter_11_0)

			table.insert(var_11_0, var_11_1)
		end

		gohelper.CreateObjList(arg_11_0, arg_11_0.targetConditionDescShow, var_11_0, arg_11_0._gotargetconditionContent, arg_11_0._gotargetcondition)
	else
		local var_11_2 = DungeonConfig.instance:getFirstEpisodeWinConditionText(nil, arg_11_0.battleId)

		arg_11_0._txttargetcondition.text = var_11_2 or luaLang("season166_herogroup_normalTarget")

		gohelper.setActive(arg_11_0._gonormalfinish, true)
		gohelper.setActive(arg_11_0._gonormalunfinish, false)
		gohelper.setActive(arg_11_0._gobasespotfinish, false)
		gohelper.setActive(arg_11_0._gobasespotunfinish, false)
	end
end

function var_0_0.targetConditionDescShow(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = gohelper.findChildText(arg_12_1, "#txt_targetcondition")
	local var_12_1 = gohelper.findChild(arg_12_1, "#go_normalfinish")
	local var_12_2 = gohelper.findChild(arg_12_1, "#go_normalunfinish")
	local var_12_3 = gohelper.findChild(arg_12_1, "#go_basespotfinish")
	local var_12_4 = gohelper.findChild(arg_12_1, "#go_basespotunfinish")
	local var_12_5 = luaLang("season166_herogroup_fightScoreTarget")

	var_12_0.text = GameUtil.getSubPlaceholderLuaLang(var_12_5, {
		arg_12_2.needScore
	})

	local var_12_6 = Season166BaseSpotModel.instance:getBaseSpotMaxScore(arg_12_0.actId, arg_12_0.context.baseId)

	gohelper.setActive(var_12_3, var_12_6 >= arg_12_2.needScore)
	gohelper.setActive(var_12_4, var_12_6 < arg_12_2.needScore)
	gohelper.setActive(var_12_1, false)
	gohelper.setActive(var_12_2, false)
end

function var_0_0.refreshStrategy(arg_13_0)
	if arg_13_0.context and arg_13_0.context.baseId and arg_13_0.context.baseId > 0 then
		local var_13_0 = Season166Config.instance:getSeasonBaseSpotCo(arg_13_0.actId, arg_13_0.context.baseId)

		arg_13_0._txtstrategydesc.text = var_13_0.strategy

		gohelper.setActive(arg_13_0._gostrategy, not string.nilorempty(var_13_0.strategy))
	elseif arg_13_0.isTrainEpisode and arg_13_0.context and arg_13_0.context.trainId and arg_13_0.context.trainId > 0 then
		local var_13_1 = Season166Config.instance:getSeasonTrainCo(arg_13_0.actId, arg_13_0.context.trainId)

		arg_13_0._txtstrategydesc.text = var_13_1.strategy

		gohelper.setActive(arg_13_0._gostrategy, not string.nilorempty(var_13_1.strategy))
	elseif arg_13_0.context and arg_13_0.context.teachId and arg_13_0.context.teachId > 0 then
		local var_13_2 = Season166Config.instance:getSeasonTeachCos(arg_13_0.context.teachId)

		arg_13_0._txtstrategydesc.text = var_13_2.strategy

		gohelper.setActive(arg_13_0._gostrategy, not string.nilorempty(var_13_2.strategy))
	else
		gohelper.setActive(arg_13_0._gostrategy, false)
	end
end

function var_0_0.refreshRuleUI(arg_14_0)
	local var_14_0 = lua_battle.configDict[arg_14_0.battleId]
	local var_14_1 = var_14_0 and var_14_0.additionRule or ""
	local var_14_2 = FightStrUtil.instance:getSplitString2Cache(var_14_1, true, "|", "#")

	if not var_14_2 or #var_14_2 == 0 then
		gohelper.setActive(arg_14_0._goadditionRule, false)

		return
	end

	arg_14_0._cloneRuleGos = arg_14_0._cloneRuleGos or arg_14_0:getUserDataTb_()

	arg_14_0:_clearRules()
	gohelper.setActive(arg_14_0._goadditionRule, true)

	arg_14_0._ruleList = var_14_2

	for iter_14_0, iter_14_1 in ipairs(var_14_2) do
		local var_14_3 = iter_14_1[1]
		local var_14_4 = iter_14_1[2]
		local var_14_5 = lua_rule.configDict[var_14_4]

		if var_14_5 then
			arg_14_0:_addRuleItem(var_14_5, var_14_3)
		end

		if iter_14_0 == #var_14_2 then
			gohelper.setActive(arg_14_0._rulesimagelineList[iter_14_0], false)
		end
	end
end

function var_0_0._addRuleItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = gohelper.clone(arg_15_0._goruletemp, arg_15_0._gorulelist, arg_15_1.id)

	gohelper.setActive(var_15_0, true)
	table.insert(arg_15_0._cloneRuleGos, var_15_0)

	local var_15_1 = gohelper.findChildImage(var_15_0, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(var_15_1, "wz_" .. arg_15_2)

	local var_15_2 = gohelper.findChildImage(var_15_0, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_15_2, arg_15_1.icon)
end

function var_0_0._clearRules(arg_16_0)
	for iter_16_0 = #arg_16_0._cloneRuleGos, 1, -1 do
		gohelper.destroy(arg_16_0._cloneRuleGos[iter_16_0])

		arg_16_0._cloneRuleGos[iter_16_0] = nil
	end
end

function var_0_0._showEnemyList(arg_17_0)
	local var_17_0 = FightModel.instance:getFightParam()
	local var_17_1 = {}
	local var_17_2 = {}
	local var_17_3 = {}
	local var_17_4 = {}

	for iter_17_0, iter_17_1 in ipairs(var_17_0.monsterGroupIds) do
		local var_17_5 = lua_monster_group.configDict[iter_17_1].bossId
		local var_17_6 = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[iter_17_1].monster, "#")

		for iter_17_2, iter_17_3 in ipairs(var_17_6) do
			local var_17_7 = lua_monster.configDict[iter_17_3].career

			if FightHelper.isBossId(var_17_5, iter_17_3) then
				var_17_1[var_17_7] = (var_17_1[var_17_7] or 0) + 1

				table.insert(var_17_4, iter_17_3)
			else
				var_17_2[var_17_7] = (var_17_2[var_17_7] or 0) + 1

				table.insert(var_17_3, iter_17_3)
			end
		end
	end

	local var_17_8 = {}

	for iter_17_4, iter_17_5 in pairs(var_17_1) do
		table.insert(var_17_8, {
			career = iter_17_4,
			count = iter_17_5
		})
	end

	arg_17_0._enemy_boss_end_index = #var_17_8

	for iter_17_6, iter_17_7 in pairs(var_17_2) do
		table.insert(var_17_8, {
			career = iter_17_6,
			count = iter_17_7
		})
	end

	gohelper.CreateObjList(arg_17_0, arg_17_0._onEnemyItemShow, var_17_8, gohelper.findChild(arg_17_0._goenemyteam, "enemyList"), gohelper.findChild(arg_17_0._goenemyteam, "enemyList/go_enemyitem"))

	local var_17_9 = FightHelper.getBattleRecommendLevel(var_17_0.battleId, arg_17_0._isSimple)

	if var_17_9 >= 0 then
		arg_17_0._txtrecommendlevel.text = HeroConfig.instance:getLevelDisplayVariant(var_17_9)
	else
		arg_17_0._txtrecommendlevel.text = ""
	end
end

function var_0_0._onEnemyItemShow(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = gohelper.findChildImage(arg_18_1, "icon")
	local var_18_1 = gohelper.findChild(arg_18_1, "icon/kingIcon")
	local var_18_2 = gohelper.findChildTextMesh(arg_18_1, "enemycount")

	UISpriteSetMgr.instance:setCommonSprite(var_18_0, "lssx_" .. tostring(arg_18_2.career))

	var_18_2.text = arg_18_2.count > 1 and luaLang("multiple") .. arg_18_2.count or ""

	gohelper.setActive(var_18_1, arg_18_3 <= arg_18_0._enemy_boss_end_index)
end

function var_0_0._recommendCareer(arg_19_0)
	local var_19_0, var_19_1 = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(arg_19_0, arg_19_0._onRecommendCareerItemShow, var_19_0, gohelper.findChild(arg_19_0._gorecommendattr.gameObject, "attrlist"), arg_19_0._goattritem)

	if #var_19_0 == 0 then
		arg_19_0._txtrecommonddes.text = luaLang("new_common_none")
	else
		arg_19_0._txtrecommonddes.text = ""
	end
end

function var_0_0._onRecommendCareerItemShow(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = gohelper.findChildImage(arg_20_1, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(var_20_0, "career_" .. arg_20_2)
end

function var_0_0.onClose(arg_21_0)
	return
end

function var_0_0.onDestroyView(arg_22_0)
	return
end

return var_0_0
