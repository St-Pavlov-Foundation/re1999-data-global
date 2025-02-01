module("modules.logic.herogroup.view.HeroGroupFightViewLevel", package.seeall)

slot0 = class("HeroGroupFightViewLevel", BaseView)

function slot0.onInitView(slot0)
	slot0._gobalanceEffect = gohelper.findChild(slot0.viewGO, "#go_balance")
	slot0._simageleft = gohelper.findChildSingleImage(slot0.viewGO, "#go_balance/#simage_left")
	slot0._simageright = gohelper.findChildSingleImage(slot0.viewGO, "#go_balance/#simage_right")
	slot0._gohardEffect = gohelper.findChild(slot0.viewGO, "#go_container/#go_hardEffect")
	slot0._gonormalcondition = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition")
	slot0._txtnormalcondition = gohelper.findChildText(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition/#txt_normalcondition")
	slot0._gonormalfinish = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition/#go_normalfinish")
	slot0._gonormalunfinish = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition/#go_normalunfinish")
	slot0._goplatinumcondition = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition")
	slot0._txtplatinumcondition = gohelper.findChildText(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition/#txt_platinumcondition")
	slot0._goplatinumfinish = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition/#go_platinumfinish")
	slot0._goplatinumunfinish = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition/#go_platinumunfinish")
	slot0._goplatinumcondition2 = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2")
	slot0._txtplatinumcondition2 = gohelper.findChildText(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2/#txt_platinumcondition")
	slot0._goplatinumfinish2 = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2/#go_platinumfinish")
	slot0._goplatinumunfinish2 = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2/#go_platinumunfinish")
	slot0._gohardplatinumcondition = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardplatinumcondition")
	slot0._txthardplatinumcondition = gohelper.findChildText(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardplatinumcondition/#txt_hardplatinumcondition")
	slot0._gohardplatinumfinish = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardplatinumcondition/#go_hardplatinumfinish")
	slot0._gohardplatinumunfinish = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardplatinumcondition/#go_hardunfinish")
	slot0._gohardcondition = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardcondition")
	slot0._txthardcondition = gohelper.findChildText(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardcondition/#txt_hardcondition")
	slot0._gohardfinish = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardcondition/#go_hardfinish")
	slot0._gohardunfinish = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardcondition/#go_hardunfinish")
	slot0._gohardconditionlock = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardconditionlock")
	slot0._gotargetlist = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList")
	slot0._btnenemy = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemytitle/#btn_enemy")
	slot0._enemylist = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemyList/#go_enemyteam/enemyList")
	slot0._txtrecommendlevel = gohelper.findChildText(slot0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/recommendtxt/#txt_recommendLevel")
	slot0._goenemyteam = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemyList/#go_enemyteam")
	slot0._gocount = gohelper.findChild(slot0.viewGO, "#go_container/btnContain/#go_cost/#go_count")
	slot0._goReplayBtn = gohelper.findChild(slot0.viewGO, "#go_container/btnContain/btnReplay")
	slot0._gorecommendattr = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr")
	slot0._goattritem = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr/attrlist/#go_attritem")
	slot0._txtrecommonddes = gohelper.findChildTextMesh(slot0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr/#txt_recommonddes")
	slot0._goadditionrule = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule")
	slot0._goplace = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_place")
	slot0._gostar3 = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer/#go_star3")
	slot0._gostar2 = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer/#go_star2")
	slot0._gostar1 = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer/#go_star1")
	slot0._btnOffer = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/#btn_Offer")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnenemy:AddClickListener(slot0._btnenemyOnClick, slot0)
	slot0._enemylist:AddClickListener(slot0._btnenemyOnClick, slot0)

	if slot0._btnOffer then
		slot0._btnOffer:AddClickListener(slot0._btnOfferOnClick, slot0)
	end

	slot0:addEventCb(slot0.viewContainer, HeroGroupEvent.SwitchBalance, slot0._refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnenemy:RemoveClickListener()
	slot0._enemylist:RemoveClickListener()

	if slot0._btnOffer then
		slot0._btnOffer:RemoveClickListener()
	end

	slot0:removeEventCb(slot0.viewContainer, HeroGroupEvent.SwitchBalance, slot0._refreshUI, slot0)
end

function slot0._btnenemyOnClick(slot0)
	if DungeonConfig.instance:getEpisodeCO(slot0._episodeId).type == DungeonEnum.EpisodeType.WeekWalk then
		EnemyInfoController.instance:openWeekWalkEnemyInfoView(WeekWalkModel.instance:getCurMapId(), slot0._battleId)

		return
	elseif slot1.type == DungeonEnum.EpisodeType.Cachot then
		-- Nothing
	elseif slot1.type == DungeonEnum.EpisodeType.BossRush then
		slot3, slot4 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(slot0._episodeId)

		EnemyInfoController.instance:openBossRushEnemyInfoView(BossRushConfig.instance:getActivityId(), slot3, slot4)

		return
	end

	EnemyInfoController.instance:openEnemyInfoViewByBattleId(slot0._battleId)
end

function slot0._btnOfferOnClick(slot0)
	BossRushController.instance:openBossRushOfferRoleView()
end

function slot0._editableInitView(slot0)
	slot0._monsterGroupItemList = {}

	gohelper.addUIClickAudio(slot0._btnenemy.gameObject, AudioEnum.UI.play_ui_formation_monstermessage)
	slot0._simageleft:LoadImage(ResUrl.getHeroGroupBg("herogroup_bg_balanceleft"))
	slot0._simageright:LoadImage(ResUrl.getHeroGroupBg("herogroup_bg_balanceright"))
end

function slot0._refreshUI(slot0)
	slot0._episodeId = HeroGroupModel.instance.episodeId
	slot0._battleId = HeroGroupModel.instance.battleId

	if DungeonModel.instance.curSendChapterId then
		slot0._isSimple = DungeonConfig.instance:getChapterCO(slot1) and slot2.type == DungeonEnum.ChapterType.Simple
	end

	slot0:_refreshTarget()
	slot0:_showEnemyList()
	slot0:_recommendCareer()
end

function slot0._refreshTarget(slot0)
	gohelper.setActive(slot0._gotargetlist, true)

	slot3 = DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot0._episodeId).chapterId).type == DungeonEnum.ChapterType.Hard

	gohelper.setActive(slot0._gohardEffect, slot3)
	gohelper.setActive(slot0._gobalanceEffect, HeroGroupBalanceHelper.getIsBalanceMode())

	slot0._isHardMode = slot3
	slot4, slot5 = nil

	if slot3 then
		slot5 = slot0._episodeId
		slot4 = slot1.preEpisode
	else
		slot6 = slot0._episodeId and DungeonConfig.instance:getHardEpisode(slot4)
		slot5 = slot6 and slot6.id
	end

	slot6 = slot4 and DungeonModel.instance:getEpisodeInfo(slot4)
	slot7 = slot5 and DungeonModel.instance:getEpisodeInfo(slot5)
	slot8 = slot4 and DungeonModel.instance:hasPassLevelAndStory(slot4)
	slot9 = slot4 and DungeonConfig.instance:getEpisodeAdvancedConditionText(slot4)
	slot10 = slot5 and DungeonConfig.instance:getEpisodeAdvancedConditionText(slot5)
	slot11 = DungeonModel.instance:isOpenHardDungeon(slot1.chapterId)
	slot12 = true

	if slot3 then
		gohelper.setActive(slot0._gohardcondition, true)

		slot0._txthardcondition.text = DungeonConfig.instance:getFirstEpisodeWinConditionText(slot5)
		slot13 = DungeonEnum.StarType.Normal <= slot7.star and slot8

		gohelper.setActive(slot0._gohardfinish, slot13)
		gohelper.setActive(slot0._gohardunfinish, not slot13)
		ZProj.UGUIHelper.SetColorAlpha(slot0._txthardcondition, slot13 and 1 or 0.63)
		gohelper.setActive(slot0._gohardplatinumcondition, not string.nilorempty(slot10))

		slot14 = DungeonEnum.StarType.Advanced <= slot7.star and slot8

		if not string.nilorempty(slot10) then
			slot0._txthardplatinumcondition.text = slot10

			gohelper.setActive(slot0._gohardplatinumfinish, slot14)
			gohelper.setActive(slot0._gohardplatinumunfinish, not slot14)
			ZProj.UGUIHelper.SetColorAlpha(slot0._txthardplatinumcondition, slot14 and 1 or 0.63)

			slot12 = false
		end

		slot0:_showStar(slot7, slot10, slot13, slot14)
	elseif slot0._isSimple then
		slot14 = DungeonModel.instance:getEpisodeInfo(slot0._episodeId) and DungeonEnum.StarType.Normal <= slot13.star and slot8

		gohelper.setActive(slot0._gonormalcondition, true)

		slot0._txtnormalcondition.text = DungeonConfig.instance:getFirstEpisodeWinConditionText(slot4)

		gohelper.setActive(slot0._gonormalfinish, slot14)
		gohelper.setActive(slot0._gonormalunfinish, not slot14)
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtnormalcondition, slot14 and 1 or 0.63)
		slot0:_showStar(slot13, nil, slot14)
	else
		gohelper.setActive(slot0._gonormalcondition, true)

		slot13 = DungeonConfig.instance:getFirstEpisodeWinConditionText(slot4)

		if BossRushController.instance:isInBossRushInfiniteFight() then
			slot13 = luaLang("v1a4_bossrushleveldetail_txt_target")
		end

		slot0._txtnormalcondition.text = slot13
		slot14 = slot6 and DungeonEnum.StarType.Normal <= slot6.star and slot8
		slot15 = slot6 and DungeonEnum.StarType.Advanced <= slot6.star and slot8
		slot16 = false

		if slot1.type == DungeonEnum.EpisodeType.WeekWalk then
			if WeekWalkModel.instance:getCurMapInfo():getBattleInfo(slot0._battleId) then
				slot14 = DungeonEnum.StarType.Normal <= slot18.star
				slot15 = DungeonEnum.StarType.Advanced <= slot18.star
				slot16 = DungeonEnum.StarType.Ultra <= slot18.star
			end

			slot19 = slot4 and DungeonConfig.instance:getEpisodeAdvancedCondition2Text(slot4)

			gohelper.setActive(slot0._goplatinumcondition2, not string.nilorempty(slot19))

			if not string.nilorempty(slot19) then
				slot0._txtplatinumcondition2.text = slot19

				gohelper.setActive(slot0._goplatinumfinish2, slot16)
				gohelper.setActive(slot0._goplatinumunfinish2, not slot16)
				ZProj.UGUIHelper.SetColorAlpha(slot0._txtplatinumcondition2, slot16 and 1 or 0.63)
			end
		end

		if slot1.type == DungeonEnum.EpisodeType.Jiexika then
			slot14 = false
		end

		gohelper.setActive(slot0._gonormalfinish, slot14)
		gohelper.setActive(slot0._gonormalunfinish, not slot14)
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtnormalcondition, slot14 and 1 or 0.63)
		gohelper.setActive(slot0._goplatinumcondition, not slot0._isSimple and not string.nilorempty(slot9))

		if not string.nilorempty(slot9) then
			slot0._txtplatinumcondition.text = slot9

			gohelper.setActive(slot0._goplatinumfinish, slot15)
			gohelper.setActive(slot0._goplatinumunfinish, not slot15)
			ZProj.UGUIHelper.SetColorAlpha(slot0._txtplatinumcondition, slot15 and 1 or 0.63)

			slot12 = false
		end

		gohelper.setActive(slot0._goplace, slot12)
		slot0:_showStar(slot6, slot9, slot14, slot15, slot16)
	end
end

function slot0._initStars(slot0)
	if slot0._starList then
		return
	end

	slot1 = 2

	if DungeonConfig.instance:getEpisodeCO(slot0._episodeId).type == DungeonEnum.EpisodeType.WeekWalk then
		slot1 = WeekWalkModel.instance:getCurMapInfo():getStarNumConfig()
	end

	if slot0._isSimple then
		slot1 = 1
	end

	gohelper.setActive(slot0._gostar1, slot1 == 1)
	gohelper.setActive(slot0._gostar2, slot1 == 2)
	gohelper.setActive(slot0._gostar3, slot1 == 3)

	slot0._starList = slot0:getUserDataTb_()

	for slot7 = 1, slot1 do
		table.insert(slot0._starList, gohelper.findChildImage(slot1 == 1 and slot0._gostar1 or slot1 == 2 and slot0._gostar2 or slot0._gostar3, "star" .. slot7))
	end
end

function slot0._showStar(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:_initStars()
	gohelper.setActive(slot0._starList[1], true)
	slot0:_setStar(slot0._starList[1], slot3)

	if not slot0._isSimple then
		if string.nilorempty(slot2) then
			gohelper.setActive(slot0._starList[2], false)
		else
			gohelper.setActive(slot0._starList[2], true)
			slot0:_setStar(slot0._starList[2], slot4)

			if slot0._starList[3] then
				gohelper.setActive(slot0._starList[3], true)
				slot0:_setStar(slot0._starList[3], slot5)
			end
		end
	end
end

function slot0._setStar(slot0, slot1, slot2, slot3)
	slot4 = ""
	slot5 = "#87898C"
	slot4 = slot0._isHardMode and "zhuxianditu_kn_xingxing_002" or "zhuxianditu_pt_xingxing_001"

	if slot2 then
		slot5 = slot0._isHardMode and "#FF4343" or "#F77040"
	end

	UISpriteSetMgr.instance:setCommonSprite(slot1, slot4, true)
	SLFramework.UGUI.GuiHelper.SetColor(slot1, slot5)
end

function slot0._refreshMonster(slot0)
	slot3 = {}

	if not string.nilorempty(lua_battle.configDict[slot0._battleId].monsterGroupIds) then
		slot3 = string.splitToNumber(slot2, "#")
	end

	for slot7, slot8 in ipairs(slot3) do
		slot9 = lua_monster_group.configDict[slot8]

		if not slot0._monsterGroupItemList[slot7] then
			slot10 = slot0:getUserDataTb_()
			slot10.go = gohelper.cloneInPlace(slot0._goenemyteam, "item" .. slot7)
			slot10.goenemyitem = gohelper.findChild(slot10.go, "enemyList/go_enemyitem")
			slot10.monsterItemList = {}

			gohelper.setActive(slot10.goenemyitem, false)
			table.insert(slot0._monsterGroupItemList, slot10)
		end

		slot0:_refreshMonsterItem(slot10, slot9)
		gohelper.setActive(slot10.go, true)
	end

	for slot7 = #slot3 + 1, #slot0._monsterGroupItemList do
		gohelper.setActive(slot0._monsterGroupItemList[slot7].go, false)
	end
end

function slot0._refreshMonsterItem(slot0, slot1, slot2)
	slot3 = slot1.monsterItemList
	slot4 = slot1.goenemyitem
	slot6 = {}

	if not string.nilorempty(slot2.monster) then
		slot6 = string.splitToNumber(slot5, "#")
	end

	for slot11, slot12 in ipairs(string.nilorempty(slot2.spMonster) and {} or string.splitToNumber(slot2.spMonster, "#")) do
		table.insert(slot6, slot12)
	end

	slot8 = 0
	slot9 = {}
	slot10 = {}

	if not string.nilorempty(slot2.bossId) then
		slot8 = lua_monster.configDict[string.splitToNumber(slot2.bossId, "#")[1]].career
	end

	for slot14, slot15 in ipairs(slot6) do
		slot16 = lua_monster.configDict[slot15]
		slot17 = lua_monster_skill_template.configDict[slot16.skillTemplate]

		if not slot9[slot16.career] then
			slot9[slot16.career] = true

			table.insert(slot10, slot16.career)
		end
	end

	for slot14, slot15 in ipairs(slot10) do
		if not slot3[slot14] then
			slot16 = slot0:getUserDataTb_()
			slot16.go = gohelper.cloneInPlace(slot4, "item" .. slot14)
			slot16.icon = gohelper.findChildImage(slot16.go, "icon")
			slot16.kingIcon = gohelper.findChild(slot16.go, "icon/kingIcon")

			table.insert(slot3, slot16)
		end

		UISpriteSetMgr.instance:setCommonSprite(slot16.icon, "lssx_" .. tostring(slot15))
		gohelper.setActive(slot16.kingIcon, slot15 == slot8)
		gohelper.setActive(slot16.go, true)
	end

	for slot14 = #slot10 + 1, #slot3 do
		gohelper.setActive(slot3[slot14].go, false)
	end
end

function slot0._getSumCE(slot0)
	slot1 = HeroGroupModel.instance:getCurGroupMO()

	return CharacterModel.instance:getSumCE(slot1:getMainList(), slot1:getSubList(), slot1:getAllHeroEquips(), HeroGroupModel.instance.battleId, true)
end

function slot0.onOpen(slot0)
	slot0:_refreshUI()
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._recommendCareer, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ShowEnemyInfoViewByGuide, slot0._btnenemyOnClick, slot0)

	if BossRushController.instance:isInBossRushFight(true) then
		slot1, slot2 = BossRushModel.instance:getBattleStageAndLayer()

		if slot0._btnOffer then
			gohelper.setActive(slot0._btnOffer.gameObject, BossRushModel.instance:isEnhanceRole(slot1, slot2))
		end
	end
end

function slot0.onOpenFinish(slot0)
	UIBlockMgr.instance:startBlock("HeroGroupFightViewLevel tryShowFirstHelp")
	TaskDispatcher.runDelay(slot0._tryShowFirstHelp, slot0, 0.2)
end

function slot0._tryShowFirstHelp(slot0)
	UIBlockMgr.instance:endBlock("HeroGroupFightViewLevel tryShowFirstHelp")
	slot0:_showHelp()
end

function slot0._showHelp(slot0)
	slot5 = CommonConfig.instance:getConstNum(ConstEnum.HeroGroupGuideNormal)

	if DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId).chapterId).type == DungeonEnum.ChapterType.Hard then
		if GuideModel.instance:isGuideFinish(CommonConfig.instance:getConstNum(ConstEnum.HeroGroupGuideHard)) then
			HelpController.instance:tryShowFirstHelp(HelpEnum.HelpId.HeroGroupHard)
		end
	elseif GuideModel.instance:isGuideFinish(slot5) then
		HelpController.instance:tryShowFirstHelp(HelpEnum.HelpId.HeroGroupNormal)
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
	UIBlockMgr.instance:endBlock("HeroGroupFightViewLevel tryShowFirstHelp")
	TaskDispatcher.cancelTask(slot0._tryShowFirstHelp, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageleft:UnLoadImage()
	slot0._simageright:UnLoadImage()
end

return slot0
