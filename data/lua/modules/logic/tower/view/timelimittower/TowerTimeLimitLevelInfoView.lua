module("modules.logic.tower.view.timelimittower.TowerTimeLimitLevelInfoView", package.seeall)

local var_0_0 = class("TowerTimeLimitLevelInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._godetailInfo = gohelper.findChild(arg_1_0.viewGO, "root/#go_detailInfo")
	arg_1_0._txtIndex = gohelper.findChildText(arg_1_0.viewGO, "root/#go_detailInfo/#txt_Index")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "root/#go_detailInfo/#txt_Title")
	arg_1_0._txten = gohelper.findChildText(arg_1_0.viewGO, "root/#go_detailInfo/#txt_en")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_detailInfo/#btn_detail")
	arg_1_0._gorecommendAttr = gohelper.findChild(arg_1_0.viewGO, "root/#go_detailInfo/#go_recommendAttr")
	arg_1_0._goattritem = gohelper.findChild(arg_1_0.viewGO, "root/#go_detailInfo/#go_recommendAttr/attrlist/#go_attritem")
	arg_1_0._txtrecommonddes = gohelper.findChildText(arg_1_0.viewGO, "root/#go_detailInfo/#go_recommendAttr/#txt_recommonddes")
	arg_1_0._txtrecommendLevel = gohelper.findChildText(arg_1_0.viewGO, "root/#go_detailInfo/recommendtxt/#txt_recommendLevel")
	arg_1_0._goadditionRule = gohelper.findChild(arg_1_0.viewGO, "root/#go_detailInfo/#go_additionRule")
	arg_1_0._scrollrules = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#go_detailInfo/#go_additionRule/#scroll_rules")
	arg_1_0._gorules = gohelper.findChild(arg_1_0.viewGO, "root/#go_detailInfo/#go_additionRule/#scroll_rules/Viewport/#go_rules")
	arg_1_0._goruletemp = gohelper.findChild(arg_1_0.viewGO, "root/#go_detailInfo/#go_additionRule/#scroll_rules/Viewport/#go_rules/#go_ruletemp")
	arg_1_0._godifficulty = gohelper.findChild(arg_1_0.viewGO, "root/#go_detailInfo/#go_difficulty")
	arg_1_0._goeasy = gohelper.findChild(arg_1_0.viewGO, "root/#go_detailInfo/#go_difficulty/#go_easy")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "root/#go_detailInfo/#go_difficulty/#go_normal")
	arg_1_0._gohard = gohelper.findChild(arg_1_0.viewGO, "root/#go_detailInfo/#go_difficulty/#go_hard")
	arg_1_0._btnswitchleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_detailInfo/#go_difficulty/#btn_switchleft")
	arg_1_0._btnswitchright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_detailInfo/#go_difficulty/#btn_switchright")
	arg_1_0._txtmultiIndex = gohelper.findChildText(arg_1_0.viewGO, "root/#go_detailInfo/#go_difficulty/index/#txt_multiIndex")
	arg_1_0._btnStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_detailInfo/#btn_Start")
	arg_1_0._btnStartAgain = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_detailInfo/#btn_StartAgain")
	arg_1_0._btnrefresh = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_detailInfo/#btn_StartAgain/go_group/#btn_refresh")
	arg_1_0._goruleWindow = gohelper.findChild(arg_1_0.viewGO, "root/#go_detailInfo/#go_rulewindow")
	arg_1_0._btncloseRule = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_detailInfo/#go_rulewindow/#go_ruledesc/#btn_closerule")
	arg_1_0._goruleItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_detailInfo/#go_rulewindow/#go_ruledesc/bg/#go_ruleDescList/#go_ruleitem")
	arg_1_0._goruleDescList = gohelper.findChild(arg_1_0.viewGO, "root/#go_detailInfo/#go_rulewindow/#go_ruledesc/bg/#go_ruleDescList")
	arg_1_0._goenemy = gohelper.findChild(arg_1_0.viewGO, "root/#go_detailInfo/#btn_StartAgain/go_group/#go_enemy")
	arg_1_0._simageenemy = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#go_detailInfo/#btn_StartAgain/go_group/#go_enemy/#simage_enemy")
	arg_1_0._gohero = gohelper.findChild(arg_1_0.viewGO, "root/#go_detailInfo/#btn_StartAgain/go_group/hero")
	arg_1_0._goheroitem = gohelper.findChild(arg_1_0.viewGO, "root/#go_detailInfo/#btn_StartAgain/go_group/hero/heroItem")
	arg_1_0._goSwitchEfeect = gohelper.findChild(arg_1_0.viewGO, "root/#go_detailInfo/#go_difficulty/index/vx_refresh")
	arg_1_0._goScore = gohelper.findChild(arg_1_0.viewGO, "root/#go_detailInfo/#go_score")
	arg_1_0._txtScore = gohelper.findChildText(arg_1_0.viewGO, "root/#go_detailInfo/#go_score/txt_score")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
	arg_2_0._btnswitchleft:AddClickListener(arg_2_0._btnswitchleftOnClick, arg_2_0)
	arg_2_0._btnswitchright:AddClickListener(arg_2_0._btnswitchrightOnClick, arg_2_0)
	arg_2_0._btnStart:AddClickListener(arg_2_0._btnStartOnClick, arg_2_0)
	arg_2_0._btnStartAgain:AddClickListener(arg_2_0._btnStartAgainOnClick, arg_2_0)
	arg_2_0._btnrefresh:AddClickListener(arg_2_0._btnrefreshOnClick, arg_2_0)
	arg_2_0._btncloseRule:AddClickListener(arg_2_0._btnCloseRuleOnClick, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndetail:RemoveClickListener()
	arg_3_0._btnswitchleft:RemoveClickListener()
	arg_3_0._btnswitchright:RemoveClickListener()
	arg_3_0._btnStart:RemoveClickListener()
	arg_3_0._btnStartAgain:RemoveClickListener()
	arg_3_0._btnrefresh:RemoveClickListener()
	arg_3_0._btncloseRule:RemoveClickListener()
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, arg_3_0.refreshUI, arg_3_0)
end

function var_0_0._btndetailOnClick(arg_4_0)
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(arg_4_0.episodeConfig.battleId)
end

function var_0_0._btnadditionRuleclickOnClick(arg_5_0)
	if arg_5_0._ruleDataList and #arg_5_0._ruleDataList > 0 then
		ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
			ruleList = arg_5_0._ruleDataList
		})
	end
end

function var_0_0._btnswitchleftOnClick(arg_6_0)
	if arg_6_0.difficulty == TowerEnum.Difficulty.Easy then
		return
	end

	arg_6_0.difficulty = Mathf.Max(arg_6_0.difficulty - 1, TowerEnum.Difficulty.Easy)

	gohelper.setActive(arg_6_0._goSwitchEfeect, false)
	gohelper.setActive(arg_6_0._goSwitchEfeect, true)
	TowerTimeLimitLevelModel.instance:setEntranceDifficulty(arg_6_0.entranceId, arg_6_0.difficulty)
	arg_6_0:refreshUI()
end

function var_0_0._btnswitchrightOnClick(arg_7_0)
	if arg_7_0.difficulty == TowerEnum.Difficulty.Hard then
		return
	end

	arg_7_0.difficulty = Mathf.Min(arg_7_0.difficulty + 1, TowerEnum.Difficulty.Hard)

	gohelper.setActive(arg_7_0._goSwitchEfeect, false)
	gohelper.setActive(arg_7_0._goSwitchEfeect, true)
	TowerTimeLimitLevelModel.instance:setEntranceDifficulty(arg_7_0.entranceId, arg_7_0.difficulty)
	arg_7_0:refreshUI()
end

function var_0_0._btnStartOnClick(arg_8_0)
	TowerTimeLimitLevelModel.instance:saveLastEntranceDifficulty(arg_8_0.curOpenMo)

	local var_8_0 = {
		towerType = TowerEnum.TowerType.Limited,
		towerId = arg_8_0.seasonId,
		layerId = arg_8_0.layerId,
		difficulty = arg_8_0.difficulty,
		episodeId = arg_8_0.episodeConfig.id
	}

	TowerController.instance:enterFight(var_8_0)
end

function var_0_0._btnStartAgainOnClick(arg_9_0)
	arg_9_0:_btnStartOnClick()
end

function var_0_0._btnrefreshOnClick(arg_10_0)
	local var_10_0 = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Limited, arg_10_0.seasonId):getLayerScore(arg_10_0.layerId)

	GameFacade.showMessageBox(MessageBoxIdDefine.TowerResetSubEpisode, MsgBoxEnum.BoxType.Yes_No, arg_10_0.sendDecomposeEquipRequest, nil, nil, arg_10_0, nil, nil, var_10_0)
end

function var_0_0.sendDecomposeEquipRequest(arg_11_0)
	TowerRpc.instance:sendTowerResetSubEpisodeRequest(TowerEnum.TowerType.Limited, arg_11_0.seasonId, arg_11_0.layerId, 0, arg_11_0.refreshUI, arg_11_0)
end

function var_0_0._btnCloseRuleOnClick(arg_12_0)
	gohelper.setActive(arg_12_0._goruleWindow, false)
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0.goRoot = gohelper.findChild(arg_13_0.viewGO, "root")
	arg_13_0._animEventWrap = arg_13_0.goRoot:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_13_0._animEventWrap:AddEventListener("switch", arg_13_0.refreshUI, arg_13_0)

	arg_13_0.ruleItemTab = arg_13_0:getUserDataTb_()

	gohelper.setActive(arg_13_0._goruleWindow, false)

	arg_13_0.difficultyItemTab = {
		arg_13_0._goeasy,
		arg_13_0._gonormal,
		arg_13_0._gohard
	}
	arg_13_0.heroItemTab = arg_13_0:getUserDataTb_()
	arg_13_0.goLightLeftArrow = gohelper.findChild(arg_13_0._btnswitchleft.gameObject, "light")
	arg_13_0.goDarkLeftArrow = gohelper.findChild(arg_13_0._btnswitchleft.gameObject, "dark")
	arg_13_0.goLightRightArrow = gohelper.findChild(arg_13_0._btnswitchright.gameObject, "light")
	arg_13_0.goDarkRightArrow = gohelper.findChild(arg_13_0._btnswitchright.gameObject, "dark")
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0.curOpenMo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

	if arg_15_0.curOpenMo then
		arg_15_0.seasonId = arg_15_0.curOpenMo.towerId

		TowerTimeLimitLevelModel.instance:initEntranceDifficulty(arg_15_0.curOpenMo)
	else
		logError("数据异常，当前没有开启的限时塔")

		return
	end
end

function var_0_0.refreshUI(arg_16_0)
	arg_16_0.entranceId = TowerTimeLimitLevelModel.instance.curSelectEntrance

	if arg_16_0.entranceId == 0 or arg_16_0.seasonId == 0 then
		return
	end

	arg_16_0.difficulty = TowerTimeLimitLevelModel.instance:getEntranceDifficulty(arg_16_0.entranceId)

	local var_16_0 = TowerConfig.instance:getTowerLimitedTimeCoByDifficulty(arg_16_0.seasonId, arg_16_0.entranceId, arg_16_0.difficulty).episodeId

	arg_16_0.episodeConfig = DungeonConfig.instance:getEpisodeCO(var_16_0)
	arg_16_0._txtIndex.text = string.format("SP%s", arg_16_0.entranceId)
	arg_16_0._txtTitle.text = arg_16_0.episodeConfig.name
	arg_16_0._txten.text = arg_16_0.episodeConfig.name_En

	local var_16_1 = TowerTimeLimitLevelModel.instance:getDifficultyMulti(arg_16_0.difficulty)

	arg_16_0._txtmultiIndex.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_multiindex"), {
		var_16_1
	})

	arg_16_0:refreshDifficulty()
	arg_16_0:refreshRecommend()
	arg_16_0:refreshAdditionRule()
	arg_16_0:refreshHeroList()
	arg_16_0:refreshScore()
end

function var_0_0.refreshDifficulty(arg_17_0)
	for iter_17_0 = 1, 3 do
		gohelper.setActive(arg_17_0.difficultyItemTab[iter_17_0], iter_17_0 == arg_17_0.difficulty)
	end

	gohelper.setActive(arg_17_0.goLightLeftArrow, arg_17_0.difficulty > TowerEnum.Difficulty.Easy)
	gohelper.setActive(arg_17_0.goDarkLeftArrow, arg_17_0.difficulty == TowerEnum.Difficulty.Easy)
	gohelper.setActive(arg_17_0.goLightRightArrow, arg_17_0.difficulty < TowerEnum.Difficulty.Hard)
	gohelper.setActive(arg_17_0.goDarkRightArrow, arg_17_0.difficulty == TowerEnum.Difficulty.Hard)
end

function var_0_0.refreshRecommend(arg_18_0)
	local var_18_0 = FightHelper.getBattleRecommendLevel(arg_18_0.episodeConfig.battleId)

	arg_18_0._txtrecommendLevel.text = var_18_0 >= 0 and HeroConfig.instance:getLevelDisplayVariant(var_18_0) or ""

	local var_18_1, var_18_2 = TowerController.instance:getRecommendList(arg_18_0.episodeConfig.battleId)

	gohelper.CreateObjList(arg_18_0, arg_18_0._onRecommendCareerItemShow, var_18_1, gohelper.findChild(arg_18_0._gorecommendAttr.gameObject, "attrlist"), arg_18_0._goattritem)

	arg_18_0._txtrecommonddes.text = #var_18_1 == 0 and luaLang("new_common_none") or ""

	gohelper.setActive(arg_18_0._txtrecommonddes, #var_18_1 == 0)
end

function var_0_0._onRecommendCareerItemShow(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = gohelper.findChildImage(arg_19_1, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(var_19_0, "career_" .. arg_19_2)
end

function var_0_0.refreshAdditionRule(arg_20_0)
	local var_20_0 = lua_battle.configDict[arg_20_0.episodeConfig.battleId]
	local var_20_1 = var_20_0 and var_20_0.additionRule or ""
	local var_20_2 = FightStrUtil.instance:getSplitString2Cache(var_20_1, true, "|", "#")

	arg_20_0._ruleDataList = var_20_2

	if not var_20_2 or #var_20_2 == 0 then
		gohelper.setActive(arg_20_0._goadditionRule, false)

		return
	end

	gohelper.setActive(arg_20_0._goadditionRule, true)
	gohelper.CreateObjList(arg_20_0, arg_20_0.ruleItemShow, var_20_2, arg_20_0._gorules, arg_20_0._goruletemp)
end

function var_0_0.ruleItemShow(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_0.ruleItemTab[arg_21_3]

	if not var_21_0 then
		var_21_0 = {}
		arg_21_0.ruleItemTab[arg_21_3] = var_21_0
	end

	var_21_0.go = arg_21_1
	var_21_0.tagicon = gohelper.findChildImage(var_21_0.go, "image_tagicon")
	var_21_0.simage = gohelper.findChildImage(var_21_0.go, "")
	var_21_0.btnClick = gohelper.findChildButtonWithAudio(var_21_0.go, "btn_additionRuleclick")

	local var_21_1 = arg_21_2[1]
	local var_21_2 = arg_21_2[2]
	local var_21_3 = lua_rule.configDict[var_21_2]

	UISpriteSetMgr.instance:setCommonSprite(var_21_0.tagicon, "wz_" .. var_21_1)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_21_0.simage, var_21_3.icon)
	var_21_0.btnClick:AddClickListener(arg_21_0._btnadditionRuleclickOnClick, arg_21_0)
end

function var_0_0.ruleDescWindowShow(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = gohelper.findChildImage(arg_22_1, "icon")
	local var_22_1 = gohelper.findChildImage(arg_22_1, "tag")
	local var_22_2 = gohelper.findChildText(arg_22_1, "desc")
	local var_22_3 = arg_22_2[1]
	local var_22_4 = arg_22_2[2]
	local var_22_5 = lua_rule.configDict[var_22_4]

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_22_0, var_22_5.icon)
	UISpriteSetMgr.instance:setCommonSprite(var_22_1, "wz_" .. var_22_3)
	SkillHelper.addHyperLinkClick(var_22_2)

	local var_22_6 = var_22_5.desc
	local var_22_7 = SkillHelper.buildDesc(var_22_6, nil, "#6680bd")
	local var_22_8 = luaLang("dungeon_add_rule_target_" .. var_22_3)
	local var_22_9 = ({
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	})[var_22_3]

	var_22_2.text = SkillConfig.instance:fmtTagDescColor(var_22_8, var_22_7, var_22_9)
end

function var_0_0.refreshHeroList(arg_23_0)
	local var_23_0 = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Limited, arg_23_0.seasonId)

	arg_23_0.layerId = TowerConfig.instance:getTowerLimitedTimeCoList(arg_23_0.seasonId, arg_23_0.entranceId)[1].layerId

	local var_23_1 = var_23_0:getLayerSubEpisodeList(arg_23_0.layerId)
	local var_23_2 = var_23_1 and var_23_1[1].assistBossId or 0
	local var_23_3 = var_23_1 and var_23_1[1].heroIds or {}

	arg_23_0._simageenemy = gohelper.findChildSingleImage(arg_23_0.viewGO, "root/#go_detailInfo/#btn_StartAgain/go_group/#go_enemy/#simage_enemy")

	gohelper.setActive(arg_23_0._goenemy, var_23_2 > 0)

	if var_23_2 > 0 then
		local var_23_4 = TowerConfig.instance:getAssistBossConfig(var_23_2)
		local var_23_5 = FightConfig.instance:getSkinCO(var_23_4.skinId)

		arg_23_0._simageenemy:LoadImage(ResUrl.monsterHeadIcon(var_23_5.headIcon))
	end

	gohelper.setActive(arg_23_0._btnStartAgain, var_23_3 and #var_23_3 > 0)
	gohelper.setActive(arg_23_0._btnStart, not var_23_3 or #var_23_3 == 0)

	if var_23_3 and #var_23_3 > 0 then
		gohelper.CreateObjList(arg_23_0, arg_23_0._onHeroItemShow, var_23_3, arg_23_0._gohero, arg_23_0._goheroitem)
	end
end

function var_0_0._onHeroItemShow(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_0.heroItemTab[arg_24_3]

	if not var_24_0 then
		var_24_0 = {
			simagehero = gohelper.findChildSingleImage(arg_24_1, "simage_hero")
		}
		arg_24_0.heroItemTab[arg_24_3] = var_24_0
	end

	local var_24_1 = {}
	local var_24_2 = HeroModel.instance:getByHeroId(arg_24_2)

	if not var_24_2 then
		local var_24_3 = HeroConfig.instance:getHeroCO(arg_24_2)

		var_24_1 = SkinConfig.instance:getSkinCo(var_24_3.skinId)
	else
		var_24_1 = FightConfig.instance:getSkinCO(var_24_2.skin)
	end

	var_24_0.simagehero:LoadImage(ResUrl.getHeadIconSmall(var_24_1.retangleIcon))
end

function var_0_0.refreshScore(arg_25_0)
	local var_25_0 = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Limited, arg_25_0.seasonId)
	local var_25_1 = var_25_0:getLayerScore(arg_25_0.layerId)
	local var_25_2 = var_25_0:getLayerSubEpisodeList(arg_25_0.layerId)
	local var_25_3 = var_25_2 and var_25_2[1].heroIds or {}

	gohelper.setActive(arg_25_0._goScore, var_25_3 and #var_25_3 > 0)

	arg_25_0._txtScore.text = var_25_1
end

function var_0_0.onClose(arg_26_0)
	TowerTimeLimitLevelModel.instance:saveLastEntranceDifficulty(arg_26_0.curOpenMo)
end

function var_0_0.onDestroyView(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(arg_27_0.ruleItemTab) do
		iter_27_1.btnClick:RemoveClickListener()
	end

	for iter_27_2, iter_27_3 in pairs(arg_27_0.heroItemTab) do
		iter_27_3.simagehero:UnLoadImage()
	end

	arg_27_0._simageenemy:UnLoadImage()
	arg_27_0._animEventWrap:RemoveAllEventListener()
end

return var_0_0
