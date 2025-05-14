module("modules.logic.herogroup.view.HeroGroupFightViewLevel", package.seeall)

local var_0_0 = class("HeroGroupFightViewLevel", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobalanceEffect = gohelper.findChild(arg_1_0.viewGO, "#go_balance")
	arg_1_0._simageleft = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_balance/#simage_left")
	arg_1_0._simageright = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_balance/#simage_right")
	arg_1_0._gohardEffect = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_hardEffect")
	arg_1_0._gonormalcondition = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition")
	arg_1_0._txtnormalcondition = gohelper.findChildText(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition/#txt_normalcondition")
	arg_1_0._gonormalfinish = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition/#go_normalfinish")
	arg_1_0._gonormalunfinish = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition/#go_normalunfinish")
	arg_1_0._goplatinumcondition = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition")
	arg_1_0._txtplatinumcondition = gohelper.findChildText(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition/#txt_platinumcondition")
	arg_1_0._goplatinumfinish = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition/#go_platinumfinish")
	arg_1_0._goplatinumunfinish = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition/#go_platinumunfinish")
	arg_1_0._goplatinumcondition2 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2")
	arg_1_0._txtplatinumcondition2 = gohelper.findChildText(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2/#txt_platinumcondition")
	arg_1_0._goplatinumfinish2 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2/#go_platinumfinish")
	arg_1_0._goplatinumunfinish2 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2/#go_platinumunfinish")
	arg_1_0._gohardplatinumcondition = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardplatinumcondition")
	arg_1_0._txthardplatinumcondition = gohelper.findChildText(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardplatinumcondition/#txt_hardplatinumcondition")
	arg_1_0._gohardplatinumfinish = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardplatinumcondition/#go_hardplatinumfinish")
	arg_1_0._gohardplatinumunfinish = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardplatinumcondition/#go_hardunfinish")
	arg_1_0._gohardcondition = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardcondition")
	arg_1_0._txthardcondition = gohelper.findChildText(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardcondition/#txt_hardcondition")
	arg_1_0._gohardfinish = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardcondition/#go_hardfinish")
	arg_1_0._gohardunfinish = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardcondition/#go_hardunfinish")
	arg_1_0._gohardconditionlock = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_hardconditionlock")
	arg_1_0._gotargetlist = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList")
	arg_1_0._btnenemy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemytitle/#btn_enemy")
	arg_1_0._enemylist = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemyList/#go_enemyteam/enemyList")
	arg_1_0._txtrecommendlevel = gohelper.findChildText(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/recommendtxt/#txt_recommendLevel")
	arg_1_0._goenemyteam = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/enemyList/#go_enemyteam")
	arg_1_0._gocount = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/#go_cost/#go_count")
	arg_1_0._goReplayBtn = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/btnReplay")
	arg_1_0._gorecommendattr = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr")
	arg_1_0._goattritem = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr/attrlist/#go_attritem")
	arg_1_0._txtrecommonddes = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/enemycontain/#go_recommendAttr/#txt_recommonddes")
	arg_1_0._goadditionrule = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_additionRule")
	arg_1_0._goplace = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_place")
	arg_1_0._gostar3 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer/#go_star3")
	arg_1_0._gostar2 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer/#go_star2")
	arg_1_0._gostar1 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer/#go_star1")
	arg_1_0._btnOffer = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#btn_Offer")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnenemy:AddClickListener(arg_2_0._btnenemyOnClick, arg_2_0)
	arg_2_0._enemylist:AddClickListener(arg_2_0._btnenemyOnClick, arg_2_0)

	if arg_2_0._btnOffer then
		arg_2_0._btnOffer:AddClickListener(arg_2_0._btnOfferOnClick, arg_2_0)
	end

	arg_2_0:addEventCb(arg_2_0.viewContainer, HeroGroupEvent.SwitchBalance, arg_2_0._refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnenemy:RemoveClickListener()
	arg_3_0._enemylist:RemoveClickListener()

	if arg_3_0._btnOffer then
		arg_3_0._btnOffer:RemoveClickListener()
	end

	arg_3_0:removeEventCb(arg_3_0.viewContainer, HeroGroupEvent.SwitchBalance, arg_3_0._refreshUI, arg_3_0)
end

function var_0_0._btnenemyOnClick(arg_4_0)
	local var_4_0 = DungeonConfig.instance:getEpisodeCO(arg_4_0._episodeId)

	if var_4_0.type == DungeonEnum.EpisodeType.WeekWalk then
		local var_4_1 = WeekWalkModel.instance:getCurMapId()

		EnemyInfoController.instance:openWeekWalkEnemyInfoView(var_4_1, arg_4_0._battleId)

		return
	elseif var_4_0.type == DungeonEnum.EpisodeType.Cachot then
		-- block empty
	elseif var_4_0.type == DungeonEnum.EpisodeType.BossRush then
		local var_4_2 = BossRushConfig.instance:getActivityId()
		local var_4_3, var_4_4 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(arg_4_0._episodeId)

		EnemyInfoController.instance:openBossRushEnemyInfoView(var_4_2, var_4_3, var_4_4)

		return
	end

	EnemyInfoController.instance:openEnemyInfoViewByBattleId(arg_4_0._battleId)
end

function var_0_0._btnOfferOnClick(arg_5_0)
	BossRushController.instance:openBossRushOfferRoleView()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._monsterGroupItemList = {}

	gohelper.addUIClickAudio(arg_6_0._btnenemy.gameObject, AudioEnum.UI.play_ui_formation_monstermessage)
	arg_6_0._simageleft:LoadImage(ResUrl.getHeroGroupBg("herogroup_bg_balanceleft"))
	arg_6_0._simageright:LoadImage(ResUrl.getHeroGroupBg("herogroup_bg_balanceright"))
end

function var_0_0._refreshUI(arg_7_0)
	arg_7_0._episodeId = HeroGroupModel.instance.episodeId
	arg_7_0._battleId = HeroGroupModel.instance.battleId

	local var_7_0 = DungeonModel.instance.curSendChapterId

	if var_7_0 then
		local var_7_1 = DungeonConfig.instance:getChapterCO(var_7_0)

		arg_7_0._isSimple = var_7_1 and var_7_1.type == DungeonEnum.ChapterType.Simple
	end

	arg_7_0:_refreshTarget()
	arg_7_0:_showEnemyList()
	arg_7_0:_recommendCareer()
end

function var_0_0._refreshTarget(arg_8_0)
	local var_8_0 = DungeonConfig.instance:getEpisodeCO(arg_8_0._episodeId)
	local var_8_1 = DungeonConfig.instance:getChapterCO(var_8_0.chapterId)

	gohelper.setActive(arg_8_0._gotargetlist, true)

	local var_8_2 = var_8_1.type == DungeonEnum.ChapterType.Hard

	gohelper.setActive(arg_8_0._gohardEffect, var_8_2)
	gohelper.setActive(arg_8_0._gobalanceEffect, HeroGroupBalanceHelper.getIsBalanceMode())

	arg_8_0._isHardMode = var_8_2

	local var_8_3
	local var_8_4

	if var_8_2 then
		var_8_4 = arg_8_0._episodeId
		var_8_3 = var_8_0.preEpisode
	else
		var_8_3 = arg_8_0._episodeId

		local var_8_5 = var_8_3 and DungeonConfig.instance:getHardEpisode(var_8_3)

		var_8_4 = var_8_5 and var_8_5.id
	end

	local var_8_6 = var_8_3 and DungeonModel.instance:getEpisodeInfo(var_8_3)
	local var_8_7 = var_8_4 and DungeonModel.instance:getEpisodeInfo(var_8_4)
	local var_8_8 = var_8_3 and DungeonModel.instance:hasPassLevelAndStory(var_8_3)
	local var_8_9 = var_8_3 and DungeonConfig.instance:getEpisodeAdvancedConditionText(var_8_3)
	local var_8_10 = var_8_4 and DungeonConfig.instance:getEpisodeAdvancedConditionText(var_8_4)
	local var_8_11 = DungeonModel.instance:isOpenHardDungeon(var_8_0.chapterId)
	local var_8_12 = true

	if var_8_2 then
		gohelper.setActive(arg_8_0._gohardcondition, true)

		arg_8_0._txthardcondition.text = DungeonConfig.instance:getFirstEpisodeWinConditionText(var_8_4)

		local var_8_13 = var_8_7.star >= DungeonEnum.StarType.Normal and var_8_8

		gohelper.setActive(arg_8_0._gohardfinish, var_8_13)
		gohelper.setActive(arg_8_0._gohardunfinish, not var_8_13)
		ZProj.UGUIHelper.SetColorAlpha(arg_8_0._txthardcondition, var_8_13 and 1 or 0.63)
		gohelper.setActive(arg_8_0._gohardplatinumcondition, not string.nilorempty(var_8_10))

		local var_8_14 = var_8_7.star >= DungeonEnum.StarType.Advanced and var_8_8

		if not string.nilorempty(var_8_10) then
			arg_8_0._txthardplatinumcondition.text = var_8_10

			gohelper.setActive(arg_8_0._gohardplatinumfinish, var_8_14)
			gohelper.setActive(arg_8_0._gohardplatinumunfinish, not var_8_14)
			ZProj.UGUIHelper.SetColorAlpha(arg_8_0._txthardplatinumcondition, var_8_14 and 1 or 0.63)

			var_8_12 = false
		end

		arg_8_0:_showStar(var_8_7, var_8_10, var_8_13, var_8_14)
	elseif arg_8_0._isSimple then
		local var_8_15 = DungeonModel.instance:getEpisodeInfo(arg_8_0._episodeId)
		local var_8_16 = var_8_15 and var_8_15.star >= DungeonEnum.StarType.Normal and var_8_8

		gohelper.setActive(arg_8_0._gonormalcondition, true)

		local var_8_17 = DungeonConfig.instance:getFirstEpisodeWinConditionText(var_8_3)

		arg_8_0._txtnormalcondition.text = var_8_17

		gohelper.setActive(arg_8_0._gonormalfinish, var_8_16)
		gohelper.setActive(arg_8_0._gonormalunfinish, not var_8_16)
		ZProj.UGUIHelper.SetColorAlpha(arg_8_0._txtnormalcondition, var_8_16 and 1 or 0.63)
		arg_8_0:_showStar(var_8_15, nil, var_8_16)
	else
		gohelper.setActive(arg_8_0._gonormalcondition, true)

		local var_8_18 = DungeonConfig.instance:getFirstEpisodeWinConditionText(var_8_3)

		if BossRushController.instance:isInBossRushInfiniteFight() then
			var_8_18 = luaLang("v1a4_bossrushleveldetail_txt_target")
		end

		arg_8_0._txtnormalcondition.text = var_8_18

		local var_8_19 = var_8_6 and var_8_6.star >= DungeonEnum.StarType.Normal and var_8_8
		local var_8_20 = var_8_6 and var_8_6.star >= DungeonEnum.StarType.Advanced and var_8_8
		local var_8_21 = false

		if var_8_0.type == DungeonEnum.EpisodeType.WeekWalk then
			local var_8_22 = WeekWalkModel.instance:getCurMapInfo():getBattleInfo(arg_8_0._battleId)

			if var_8_22 then
				var_8_19 = var_8_22.star >= DungeonEnum.StarType.Normal
				var_8_20 = var_8_22.star >= DungeonEnum.StarType.Advanced
				var_8_21 = var_8_22.star >= DungeonEnum.StarType.Ultra
			end

			local var_8_23 = var_8_3 and DungeonConfig.instance:getEpisodeAdvancedCondition2Text(var_8_3)

			gohelper.setActive(arg_8_0._goplatinumcondition2, not string.nilorempty(var_8_23))

			if not string.nilorempty(var_8_23) then
				arg_8_0._txtplatinumcondition2.text = var_8_23

				gohelper.setActive(arg_8_0._goplatinumfinish2, var_8_21)
				gohelper.setActive(arg_8_0._goplatinumunfinish2, not var_8_21)
				ZProj.UGUIHelper.SetColorAlpha(arg_8_0._txtplatinumcondition2, var_8_21 and 1 or 0.63)
			end
		end

		if var_8_0.type == DungeonEnum.EpisodeType.Jiexika then
			var_8_19 = false
		end

		gohelper.setActive(arg_8_0._gonormalfinish, var_8_19)
		gohelper.setActive(arg_8_0._gonormalunfinish, not var_8_19)
		ZProj.UGUIHelper.SetColorAlpha(arg_8_0._txtnormalcondition, var_8_19 and 1 or 0.63)
		gohelper.setActive(arg_8_0._goplatinumcondition, not arg_8_0._isSimple and not string.nilorempty(var_8_9))

		if not string.nilorempty(var_8_9) then
			arg_8_0._txtplatinumcondition.text = var_8_9

			gohelper.setActive(arg_8_0._goplatinumfinish, var_8_20)
			gohelper.setActive(arg_8_0._goplatinumunfinish, not var_8_20)
			ZProj.UGUIHelper.SetColorAlpha(arg_8_0._txtplatinumcondition, var_8_20 and 1 or 0.63)

			var_8_12 = false
		end

		gohelper.setActive(arg_8_0._goplace, var_8_12)
		arg_8_0:_showStar(var_8_6, var_8_9, var_8_19, var_8_20, var_8_21)
	end
end

function var_0_0._initStars(arg_9_0)
	if arg_9_0._starList then
		return
	end

	local var_9_0 = 2

	if DungeonConfig.instance:getEpisodeCO(arg_9_0._episodeId).type == DungeonEnum.EpisodeType.WeekWalk then
		var_9_0 = WeekWalkModel.instance:getCurMapInfo():getStarNumConfig()
	end

	if arg_9_0._isSimple then
		var_9_0 = 1
	end

	gohelper.setActive(arg_9_0._gostar1, var_9_0 == 1)
	gohelper.setActive(arg_9_0._gostar2, var_9_0 == 2)
	gohelper.setActive(arg_9_0._gostar3, var_9_0 == 3)

	local var_9_1 = var_9_0 == 1 and arg_9_0._gostar1 or var_9_0 == 2 and arg_9_0._gostar2 or arg_9_0._gostar3

	arg_9_0._starList = arg_9_0:getUserDataTb_()

	for iter_9_0 = 1, var_9_0 do
		local var_9_2 = gohelper.findChildImage(var_9_1, "star" .. iter_9_0)

		table.insert(arg_9_0._starList, var_9_2)
	end
end

function var_0_0._showStar(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	arg_10_0:_initStars()
	gohelper.setActive(arg_10_0._starList[1], true)
	arg_10_0:_setStar(arg_10_0._starList[1], arg_10_3)

	if not arg_10_0._isSimple then
		if string.nilorempty(arg_10_2) then
			gohelper.setActive(arg_10_0._starList[2], false)
		else
			gohelper.setActive(arg_10_0._starList[2], true)
			arg_10_0:_setStar(arg_10_0._starList[2], arg_10_4)

			if arg_10_0._starList[3] then
				gohelper.setActive(arg_10_0._starList[3], true)
				arg_10_0:_setStar(arg_10_0._starList[3], arg_10_5)
			end
		end
	end
end

function var_0_0._setStar(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = ""
	local var_11_1 = "#87898C"
	local var_11_2 = arg_11_0._isHardMode and "zhuxianditu_kn_xingxing_002" or "zhuxianditu_pt_xingxing_001"

	if arg_11_2 then
		var_11_1 = arg_11_0._isHardMode and "#FF4343" or "#F77040"
	end

	UISpriteSetMgr.instance:setCommonSprite(arg_11_1, var_11_2, true)
	SLFramework.UGUI.GuiHelper.SetColor(arg_11_1, var_11_1)
end

function var_0_0._refreshMonster(arg_12_0)
	local var_12_0 = lua_battle.configDict[arg_12_0._battleId].monsterGroupIds
	local var_12_1 = {}

	if not string.nilorempty(var_12_0) then
		var_12_1 = string.splitToNumber(var_12_0, "#")
	end

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_2 = lua_monster_group.configDict[iter_12_1]
		local var_12_3 = arg_12_0._monsterGroupItemList[iter_12_0]

		if not var_12_3 then
			var_12_3 = arg_12_0:getUserDataTb_()
			var_12_3.go = gohelper.cloneInPlace(arg_12_0._goenemyteam, "item" .. iter_12_0)
			var_12_3.goenemyitem = gohelper.findChild(var_12_3.go, "enemyList/go_enemyitem")
			var_12_3.monsterItemList = {}

			gohelper.setActive(var_12_3.goenemyitem, false)
			table.insert(arg_12_0._monsterGroupItemList, var_12_3)
		end

		arg_12_0:_refreshMonsterItem(var_12_3, var_12_2)
		gohelper.setActive(var_12_3.go, true)
	end

	for iter_12_2 = #var_12_1 + 1, #arg_12_0._monsterGroupItemList do
		local var_12_4 = arg_12_0._monsterGroupItemList[iter_12_2]

		gohelper.setActive(var_12_4.go, false)
	end
end

function var_0_0._refreshMonsterItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1.monsterItemList
	local var_13_1 = arg_13_1.goenemyitem
	local var_13_2 = arg_13_2.monster
	local var_13_3 = {}

	if not string.nilorempty(var_13_2) then
		var_13_3 = string.splitToNumber(var_13_2, "#")
	end

	local var_13_4 = string.nilorempty(arg_13_2.spMonster) and {} or string.splitToNumber(arg_13_2.spMonster, "#")

	for iter_13_0, iter_13_1 in ipairs(var_13_4) do
		table.insert(var_13_3, iter_13_1)
	end

	local var_13_5 = 0
	local var_13_6 = {}
	local var_13_7 = {}

	if not string.nilorempty(arg_13_2.bossId) then
		local var_13_8 = string.splitToNumber(arg_13_2.bossId, "#")

		var_13_5 = lua_monster.configDict[var_13_8[1]].career
	end

	for iter_13_2, iter_13_3 in ipairs(var_13_3) do
		local var_13_9 = lua_monster.configDict[iter_13_3]
		local var_13_10 = lua_monster_skill_template.configDict[var_13_9.skillTemplate]

		if not var_13_6[var_13_9.career] then
			var_13_6[var_13_9.career] = true

			table.insert(var_13_7, var_13_9.career)
		end
	end

	for iter_13_4, iter_13_5 in ipairs(var_13_7) do
		local var_13_11 = var_13_0[iter_13_4]

		if not var_13_11 then
			var_13_11 = arg_13_0:getUserDataTb_()
			var_13_11.go = gohelper.cloneInPlace(var_13_1, "item" .. iter_13_4)
			var_13_11.icon = gohelper.findChildImage(var_13_11.go, "icon")
			var_13_11.kingIcon = gohelper.findChild(var_13_11.go, "icon/kingIcon")

			table.insert(var_13_0, var_13_11)
		end

		UISpriteSetMgr.instance:setCommonSprite(var_13_11.icon, "lssx_" .. tostring(iter_13_5))
		gohelper.setActive(var_13_11.kingIcon, iter_13_5 == var_13_5)
		gohelper.setActive(var_13_11.go, true)
	end

	for iter_13_6 = #var_13_7 + 1, #var_13_0 do
		local var_13_12 = var_13_0[iter_13_6]

		gohelper.setActive(var_13_12.go, false)
	end
end

function var_0_0._getSumCE(arg_14_0)
	local var_14_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_14_1 = var_14_0:getMainList()
	local var_14_2 = var_14_0:getSubList()
	local var_14_3 = var_14_0:getAllHeroEquips()
	local var_14_4 = HeroGroupModel.instance.battleId

	return CharacterModel.instance:getSumCE(var_14_1, var_14_2, var_14_3, var_14_4, true)
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:_refreshUI()
	arg_15_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_15_0._recommendCareer, arg_15_0)
	arg_15_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ShowEnemyInfoViewByGuide, arg_15_0._btnenemyOnClick, arg_15_0)

	if BossRushController.instance:isInBossRushFight(true) then
		local var_15_0, var_15_1 = BossRushModel.instance:getBattleStageAndLayer()
		local var_15_2 = BossRushModel.instance:isEnhanceRole(var_15_0, var_15_1)

		if arg_15_0._btnOffer then
			gohelper.setActive(arg_15_0._btnOffer.gameObject, var_15_2)
		end
	end
end

function var_0_0.onOpenFinish(arg_16_0)
	UIBlockMgr.instance:startBlock("HeroGroupFightViewLevel tryShowFirstHelp")
	TaskDispatcher.runDelay(arg_16_0._tryShowFirstHelp, arg_16_0, 0.2)
end

function var_0_0._tryShowFirstHelp(arg_17_0)
	UIBlockMgr.instance:endBlock("HeroGroupFightViewLevel tryShowFirstHelp")
	arg_17_0:_showHelp()
end

function var_0_0._showHelp(arg_18_0)
	local var_18_0 = HeroGroupModel.instance.episodeId
	local var_18_1 = DungeonConfig.instance:getEpisodeCO(var_18_0)
	local var_18_2 = DungeonConfig.instance:getChapterCO(var_18_1.chapterId).type == DungeonEnum.ChapterType.Hard
	local var_18_3 = CommonConfig.instance:getConstNum(ConstEnum.HeroGroupGuideNormal)
	local var_18_4 = CommonConfig.instance:getConstNum(ConstEnum.HeroGroupGuideHard)

	if var_18_2 then
		if GuideModel.instance:isGuideFinish(var_18_4) then
			HelpController.instance:tryShowFirstHelp(HelpEnum.HelpId.HeroGroupHard)
		end
	elseif GuideModel.instance:isGuideFinish(var_18_3) then
		HelpController.instance:tryShowFirstHelp(HelpEnum.HelpId.HeroGroupNormal)
	end
end

function var_0_0._showEnemyList(arg_19_0)
	local var_19_0 = FightModel.instance:getFightParam()
	local var_19_1 = {}
	local var_19_2 = {}
	local var_19_3 = {}
	local var_19_4 = {}

	for iter_19_0, iter_19_1 in ipairs(var_19_0.monsterGroupIds) do
		local var_19_5 = lua_monster_group.configDict[iter_19_1].bossId
		local var_19_6 = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[iter_19_1].monster, "#")

		for iter_19_2, iter_19_3 in ipairs(var_19_6) do
			local var_19_7 = lua_monster.configDict[iter_19_3].career

			if FightHelper.isBossId(var_19_5, iter_19_3) then
				var_19_1[var_19_7] = (var_19_1[var_19_7] or 0) + 1

				table.insert(var_19_4, iter_19_3)
			else
				var_19_2[var_19_7] = (var_19_2[var_19_7] or 0) + 1

				table.insert(var_19_3, iter_19_3)
			end
		end
	end

	local var_19_8 = {}

	for iter_19_4, iter_19_5 in pairs(var_19_1) do
		table.insert(var_19_8, {
			career = iter_19_4,
			count = iter_19_5
		})
	end

	arg_19_0._enemy_boss_end_index = #var_19_8

	for iter_19_6, iter_19_7 in pairs(var_19_2) do
		table.insert(var_19_8, {
			career = iter_19_6,
			count = iter_19_7
		})
	end

	gohelper.CreateObjList(arg_19_0, arg_19_0._onEnemyItemShow, var_19_8, gohelper.findChild(arg_19_0._goenemyteam, "enemyList"), gohelper.findChild(arg_19_0._goenemyteam, "enemyList/go_enemyitem"))

	local var_19_9 = FightHelper.getBattleRecommendLevel(var_19_0.battleId, arg_19_0._isSimple)

	if var_19_9 >= 0 then
		arg_19_0._txtrecommendlevel.text = HeroConfig.instance:getLevelDisplayVariant(var_19_9)
	else
		arg_19_0._txtrecommendlevel.text = ""
	end
end

function var_0_0._onEnemyItemShow(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = gohelper.findChildImage(arg_20_1, "icon")
	local var_20_1 = gohelper.findChild(arg_20_1, "icon/kingIcon")
	local var_20_2 = gohelper.findChildTextMesh(arg_20_1, "enemycount")

	UISpriteSetMgr.instance:setCommonSprite(var_20_0, "lssx_" .. tostring(arg_20_2.career))

	var_20_2.text = arg_20_2.count > 1 and luaLang("multiple") .. arg_20_2.count or ""

	gohelper.setActive(var_20_1, arg_20_3 <= arg_20_0._enemy_boss_end_index)
end

function var_0_0._recommendCareer(arg_21_0)
	local var_21_0, var_21_1 = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(arg_21_0, arg_21_0._onRecommendCareerItemShow, var_21_0, gohelper.findChild(arg_21_0._gorecommendattr.gameObject, "attrlist"), arg_21_0._goattritem)

	if #var_21_0 == 0 then
		arg_21_0._txtrecommonddes.text = luaLang("new_common_none")
	else
		arg_21_0._txtrecommonddes.text = ""
	end
end

function var_0_0._onRecommendCareerItemShow(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = gohelper.findChildImage(arg_22_1, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(var_22_0, "career_" .. arg_22_2)
end

function var_0_0.onClose(arg_23_0)
	UIBlockMgr.instance:endBlock("HeroGroupFightViewLevel tryShowFirstHelp")
	TaskDispatcher.cancelTask(arg_23_0._tryShowFirstHelp, arg_23_0)
end

function var_0_0.onDestroyView(arg_24_0)
	arg_24_0._simageleft:UnLoadImage()
	arg_24_0._simageright:UnLoadImage()
end

return var_0_0
