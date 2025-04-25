module("modules.logic.seasonver.act166.view.Season166HeroGroupFightViewRule", package.seeall)

slot0 = class("Season166HeroGroupFightViewRule", BaseView)

function slot0.onInitView(slot0)
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_container")
	slot0._scrollinfo = gohelper.findChildScrollRect(slot0.viewGO, "#go_container/#scroll_info")
	slot0._btntargetShow = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/txt_target/#btn_targetShow")
	slot0._gotargetconditionContent = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList")
	slot0._gotargetcondition = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_targetcondition")
	slot0._txttargetcondition = gohelper.findChildText(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_targetcondition/#txt_targetcondition")
	slot0._gonormalfinish = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_targetcondition/#go_normalfinish")
	slot0._gonormalunfinish = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_targetcondition/#go_normalunfinish")
	slot0._gobasespotfinish = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_targetcondition/#go_basespotfinish")
	slot0._gobasespotunfinish = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_targetcondition/#go_basespotunfinish")
	slot0._gostrategy = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/strategy")
	slot0._txtstrategydesc = gohelper.findChildText(slot0.viewGO, "#go_container/#scroll_info/infocontain/strategy/strategydesc/#txt_strategydesc")
	slot0._goadditionRule = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule")
	slot0._gorulelist = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_rulelist")
	slot0._btnadditionRuleclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_rulelist/#btn_additionRuleclick")
	slot0._goruletemp = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_ruletemp")
	slot0._imagetagicon = gohelper.findChildImage(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule/#go_ruletemp/#image_tagicon")
	slot0._btnenemy = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemytitle/#btn_enemy")
	slot0._enemylist = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemyList/#go_enemyteam/enemyList")
	slot0._txtrecommendlevel = gohelper.findChildText(slot0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/recommendtxt/#txt_recommendLevel")
	slot0._goenemyteam = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemyList/#go_enemyteam")
	slot0._gorecommendattr = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr")
	slot0._goattritem = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr/attrlist/#go_attritem")
	slot0._txtrecommonddes = gohelper.findChildTextMesh(slot0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr/#txt_recommonddes")
	slot0._gorulewindow = gohelper.findChild(slot0.viewGO, "#go_rulewindow")
	slot0._goruledesc = gohelper.findChild(slot0.viewGO, "#go_rulewindow/#go_ruledesc")

	gohelper.setActive(slot0._goruledesc, false)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntargetShow:AddClickListener(slot0._btntargetShowOnClick, slot0)
	slot0._btnadditionRuleclick:AddClickListener(slot0._btnadditionRuleOnClick, slot0)
	slot0._btnenemy:AddClickListener(slot0._btnenemyOnClick, slot0)
	slot0._enemylist:AddClickListener(slot0._btnenemyOnClick, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._recommendCareer, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntargetShow:RemoveClickListener()
	slot0._btnadditionRuleclick:RemoveClickListener()
	slot0._btnenemy:RemoveClickListener()
	slot0._enemylist:RemoveClickListener()
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._recommendCareer, slot0)
end

function slot0._btntargetShowOnClick(slot0)
	slot0:checkAndOpenTargetView(true)
end

function slot0._btnadditionRuleOnClick(slot0)
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = slot0._ruleList
	})
end

function slot0._btnenemyOnClick(slot0)
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(slot0.battleId)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gorulewindow, false)
	gohelper.setActive(slot0._gotargetcondition, true)
	gohelper.setActive(slot0._goruletemp, false)
	gohelper.setActive(slot0._goruleitem, false)

	slot0._rulesimagelineList = slot0:getUserDataTb_()
end

function slot0.onOpen(slot0)
	slot0:initData()
	slot0:checkAndOpenTargetView()
	slot0:refreshTargetCondition()
	slot0:refreshStrategy()
	slot0:refreshRuleUI()
	slot0:_showEnemyList()
	slot0:_recommendCareer()
end

function slot0.initData(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.context = Season166Model.instance:getBattleContext()
	slot0.episodeId = slot0.viewParam.episodeId or Season166HeroGroupModel.instance.episodeId
	slot0.episodeConfig = DungeonConfig.instance:getEpisodeCO(slot0.episodeId)
	slot0.battleId = slot0.viewParam.battleId or slot0.episodeConfig.battleId
	slot0.battleConfig = slot0.battleId and lua_battle.configDict[slot0.episodeConfig.battleId]
	slot0.isTrainEpisode = Season166HeroGroupModel.instance:isSeason166TrainEpisode(slot0.episodeId)
end

function slot0.checkAndOpenTargetView(slot0, slot1)
	if slot0.context and slot0.context.baseId and slot0.context.baseId > 0 then
		gohelper.setActive(slot0._btntargetShow.gameObject, true)

		if Season166Model.instance:getLocalPrefsTab(Season166Enum.EnterSpotKey)[slot0.context.baseId] ~= 1 or slot1 then
			ViewMgr.instance:openView(ViewName.Season166HeroGroupTargetView, {
				actId = slot0.actId,
				baseId = slot0.context.baseId
			})
		end

		if not slot3 then
			Season166Model.instance:setLocalPrefsTab(Season166Enum.EnterSpotKey, slot0.context.baseId, 1)
		end
	else
		gohelper.setActive(slot0._btntargetShow.gameObject, false)
	end
end

function slot0.refreshTargetCondition(slot0)
	if slot0.context and slot0.context.baseId and slot0.context.baseId > 0 then
		slot1 = {}

		for slot5 = 1, 3 do
			table.insert(slot1, Season166Config.instance:getSeasonScoreCo(slot0.actId, slot5))
		end

		gohelper.CreateObjList(slot0, slot0.targetConditionDescShow, slot1, slot0._gotargetconditionContent, slot0._gotargetcondition)
	else
		slot0._txttargetcondition.text = DungeonConfig.instance:getFirstEpisodeWinConditionText(nil, slot0.battleId) or luaLang("season166_herogroup_normalTarget")

		gohelper.setActive(slot0._gonormalfinish, true)
		gohelper.setActive(slot0._gonormalunfinish, false)
		gohelper.setActive(slot0._gobasespotfinish, false)
		gohelper.setActive(slot0._gobasespotunfinish, false)
	end
end

function slot0.targetConditionDescShow(slot0, slot1, slot2, slot3)
	gohelper.findChildText(slot1, "#txt_targetcondition").text = GameUtil.getSubPlaceholderLuaLang(luaLang("season166_herogroup_fightScoreTarget"), {
		slot2.needScore
	})

	gohelper.setActive(gohelper.findChild(slot1, "#go_basespotfinish"), slot2.needScore <= Season166BaseSpotModel.instance:getBaseSpotMaxScore(slot0.actId, slot0.context.baseId))
	gohelper.setActive(gohelper.findChild(slot1, "#go_basespotunfinish"), slot10 < slot2.needScore)
	gohelper.setActive(gohelper.findChild(slot1, "#go_normalfinish"), false)
	gohelper.setActive(gohelper.findChild(slot1, "#go_normalunfinish"), false)
end

function slot0.refreshStrategy(slot0)
	if slot0.context and slot0.context.baseId and slot0.context.baseId > 0 then
		slot1 = Season166Config.instance:getSeasonBaseSpotCo(slot0.actId, slot0.context.baseId)
		slot0._txtstrategydesc.text = slot1.strategy

		gohelper.setActive(slot0._gostrategy, not string.nilorempty(slot1.strategy))
	elseif slot0.isTrainEpisode and slot0.context and slot0.context.trainId and slot0.context.trainId > 0 then
		slot1 = Season166Config.instance:getSeasonTrainCo(slot0.actId, slot0.context.trainId)
		slot0._txtstrategydesc.text = slot1.strategy

		gohelper.setActive(slot0._gostrategy, not string.nilorempty(slot1.strategy))
	elseif slot0.context and slot0.context.teachId and slot0.context.teachId > 0 then
		slot1 = Season166Config.instance:getSeasonTeachCos(slot0.context.teachId)
		slot0._txtstrategydesc.text = slot1.strategy

		gohelper.setActive(slot0._gostrategy, not string.nilorempty(slot1.strategy))
	else
		gohelper.setActive(slot0._gostrategy, false)
	end
end

function slot0.refreshRuleUI(slot0)
	if not FightStrUtil.instance:getSplitString2Cache(lua_battle.configDict[slot0.battleId] and slot1.additionRule or "", true, "|", "#") or #slot3 == 0 then
		gohelper.setActive(slot0._goadditionRule, false)

		return
	end

	slot0._cloneRuleGos = slot0._cloneRuleGos or slot0:getUserDataTb_()

	slot0:_clearRules()
	gohelper.setActive(slot0._goadditionRule, true)

	slot0._ruleList = slot3

	for slot7, slot8 in ipairs(slot3) do
		if lua_rule.configDict[slot8[2]] then
			slot0:_addRuleItem(slot11, slot8[1])
		end

		if slot7 == #slot3 then
			gohelper.setActive(slot0._rulesimagelineList[slot7], false)
		end
	end
end

function slot0._addRuleItem(slot0, slot1, slot2)
	slot3 = gohelper.clone(slot0._goruletemp, slot0._gorulelist, slot1.id)

	gohelper.setActive(slot3, true)
	table.insert(slot0._cloneRuleGos, slot3)
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot3, "#image_tagicon"), "wz_" .. slot2)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(gohelper.findChildImage(slot3, ""), slot1.icon)
end

function slot0._clearRules(slot0)
	for slot4 = #slot0._cloneRuleGos, 1, -1 do
		gohelper.destroy(slot0._cloneRuleGos[slot4])

		slot0._cloneRuleGos[slot4] = nil
	end
end

function slot0._showEnemyList(slot0)
	slot2 = {}
	slot3 = {}
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in ipairs(FightModel.instance:getFightParam().monsterGroupIds) do
		for slot16, slot17 in ipairs(FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[slot10].monster, "#")) do
			slot18 = lua_monster.configDict[slot17].career

			if FightHelper.isBossId(lua_monster_group.configDict[slot10].bossId, slot17) then
				slot2[slot18] = (slot2[slot18] or 0) + 1

				table.insert(slot5, slot17)
			else
				slot3[slot18] = (slot3[slot18] or 0) + 1

				table.insert(slot4, slot17)
			end
		end
	end

	slot6 = {}

	for slot10, slot11 in pairs(slot2) do
		table.insert(slot6, {
			career = slot10,
			count = slot11
		})
	end

	slot0._enemy_boss_end_index = #slot6

	for slot10, slot11 in pairs(slot3) do
		table.insert(slot6, {
			career = slot10,
			count = slot11
		})
	end

	gohelper.CreateObjList(slot0, slot0._onEnemyItemShow, slot6, gohelper.findChild(slot0._goenemyteam, "enemyList"), gohelper.findChild(slot0._goenemyteam, "enemyList/go_enemyitem"))

	if FightHelper.getBattleRecommendLevel(slot1.battleId, slot0._isSimple) >= 0 then
		slot0._txtrecommendlevel.text = HeroConfig.instance:getLevelDisplayVariant(slot7)
	else
		slot0._txtrecommendlevel.text = ""
	end
end

function slot0._onEnemyItemShow(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot1, "icon"), "lssx_" .. tostring(slot2.career))

	gohelper.findChildTextMesh(slot1, "enemycount").text = slot2.count > 1 and luaLang("multiple") .. slot2.count or ""

	gohelper.setActive(gohelper.findChild(slot1, "icon/kingIcon"), slot3 <= slot0._enemy_boss_end_index)
end

function slot0._recommendCareer(slot0)
	slot1, slot2 = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(slot0, slot0._onRecommendCareerItemShow, slot1, gohelper.findChild(slot0._gorecommendattr.gameObject, "attrlist"), slot0._goattritem)

	if #slot1 == 0 then
		slot0._txtrecommonddes.text = luaLang("new_common_none")
	else
		slot0._txtrecommonddes.text = ""
	end
end

function slot0._onRecommendCareerItemShow(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setHeroGroupSprite(gohelper.findChildImage(slot1, "icon"), "career_" .. slot2)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
