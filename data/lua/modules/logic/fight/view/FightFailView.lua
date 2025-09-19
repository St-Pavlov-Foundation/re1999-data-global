module("modules.logic.fight.view.FightFailView", package.seeall)

local var_0_0 = class("FightFailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocost = gohelper.findChild(arg_1_0.viewGO, "#go_cost")
	arg_1_0._txtaddActive = gohelper.findChildText(arg_1_0.viewGO, "#go_cost/#txt_addActive")
	arg_1_0._gofirstfailtxt = gohelper.findChild(arg_1_0.viewGO, "#go_cost/#txt_addActive/#go_firstfailtxt")
	arg_1_0._goAddActive = gohelper.findChild(arg_1_0.viewGO, "#go_cost/#txt_addActive")
	arg_1_0._btnData = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cost/#btn_data")
	arg_1_0._gocosticon = gohelper.findChild(arg_1_0.viewGO, "#go_cost/#go_costicon")
	arg_1_0._costitemIcon = gohelper.findChildSingleImage(arg_1_0._gocosticon, "itemIcon")
	arg_1_0._costcurrencyIcon = gohelper.findChildImage(arg_1_0._gocosticon, "currencyIcon")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/#go_tips")
	arg_1_0._golevel = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_level")
	arg_1_0._goinfos = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos")
	arg_1_0._golevelsubcontainer = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_levelsubcontainer")
	arg_1_0._goequipsubcontainer = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_equipsubcontainer")
	arg_1_0._gotalentsubcontainer = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_talentsubcontainer")
	arg_1_0._imagelevelcareer = gohelper.findChildImage(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_levelsubcontainer/#image_levelcareer")
	arg_1_0._txtleveltitle = gohelper.findChildText(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_levelsubcontainer/#txt_leveltitle")
	arg_1_0._txtlevelnum = gohelper.findChildText(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_levelsubcontainer/#txt_levelnum")
	arg_1_0._imageequipcareer = gohelper.findChildImage(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_equipsubcontainer/#image_equipcareer")
	arg_1_0._txtequiptitle = gohelper.findChildText(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_equipsubcontainer/#txt_equiptitle")
	arg_1_0._txtequipnum = gohelper.findChildText(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_equipsubcontainer/#txt_equipnum")
	arg_1_0._imagetalentcareer = gohelper.findChildImage(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_talentsubcontainer/#image_talentcareer")
	arg_1_0._txttalenttitle = gohelper.findChildText(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_talentsubcontainer/#txt_talenttitle")
	arg_1_0._txttalentnum = gohelper.findChildText(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_talentsubcontainer/#txt_talentnum")
	arg_1_0._gorestrain = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_restrain")
	arg_1_0._goherotipslist = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_restrain/#go_herotipslist")
	arg_1_0._goconditions = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_conditions")
	arg_1_0._goconditionitem = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_conditions/#go_item")
	arg_1_0._gonormaltip = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_normaltip")
	arg_1_0._goteachnote = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_teachnote")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickClose, arg_2_0)
	arg_2_0._btnData:AddClickListener(arg_2_0._onClickData, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._click:RemoveClickListener()
	arg_3_0._btnData:RemoveClickListener()
end

var_0_0.CareerToImageName = {
	"zhandou_icon_yan",
	"zhandou_icon_xing",
	"zhandou_icon_mu",
	"zhandou_icon_shou",
	"zhandou_icon_ling",
	"zhandou_icon_zhi"
}
var_0_0.ShowLevelContainerValue = 0.8
var_0_0.OffsetValue = 1.6
var_0_0.PercentRedColor = "#b26161"
var_0_0.PercentWhiteColor = "#e2e2e2"
var_0_0.TxtRedColor = "#b26161"
var_0_0.TxtWhiteColor = "#adadad"
var_0_0.RedImageName = "zhandou_tuoyuan_hong"
var_0_0.WhiteImageName = "zhandou_tuoyuan_bai"

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._click = gohelper.getClick(arg_4_0.viewGO)

	gohelper.setActive(arg_4_0._golevel, false)
	gohelper.setActive(arg_4_0._gorestrain, false)
	gohelper.setActive(arg_4_0._goconditions, false)
	gohelper.setActive(arg_4_0._gonormaltip, false)
	gohelper.setActive(arg_4_0._goteachnote, false)

	arg_4_0.restrainItem = gohelper.findChild(arg_4_0._goherotipslist, "item")

	gohelper.setActive(arg_4_0.restrainItem, false)
	gohelper.setActive(arg_4_0._goconditionitem, false)

	local var_4_0 = DungeonModel.instance.curSendChapterId

	if var_4_0 then
		local var_4_1 = DungeonConfig.instance:getChapterCO(var_4_0)

		arg_4_0.isSimple = var_4_1 and var_4_1.type == DungeonEnum.ChapterType.Simple
	end

	local var_4_2 = lua_const.configDict[ConstEnum.SimpleEpisodeEffectiveness]

	arg_4_0.constEffectiveness = string.splitToNumber(var_4_2.value, "#")
end

function var_0_0._onClickClose(arg_5_0)
	arg_5_0:_exitFight()
end

function var_0_0._onClickData(arg_6_0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)
	FightController.instance:checkFightQuitTipViewClose()

	arg_7_0.fightParam = FightModel.instance:getFightParam()
	arg_7_0._episodeId = arg_7_0.fightParam.episodeId
	arg_7_0._chapterId = arg_7_0.fightParam.chapterId
	arg_7_0.episodeCo = lua_episode.configDict[arg_7_0._episodeId]
	arg_7_0.chapterCo = DungeonConfig.instance:getChapterCO(arg_7_0._chapterId)
	arg_7_0.battleCo = DungeonConfig.instance:getBattleCo(nil, FightModel.instance:getBattleId())

	NavigateMgr.instance:addEscape(ViewName.FightFailView, arg_7_0._onClickClose, arg_7_0)

	if arg_7_0:_hideActiveGo() then
		if arg_7_0.episodeCo then
			gohelper.setActive(arg_7_0._gocost, true)

			arg_7_0._txtaddActive.text = ""
		end

		gohelper.setActive(arg_7_0._gofirstfailtxt, false)
	else
		local var_7_0 = FightModel.instance:getFightParam()
		local var_7_1 = var_7_0 and var_7_0.multiplication or 1

		if not FightModel.instance.cacheUserDungeonMO then
			local var_7_2 = DungeonModel.instance:getEpisodeInfo(arg_7_0._episodeId)
		end

		local var_7_3 = DungeonConfig.instance:getEpisodeFailedReturnCost(arg_7_0._episodeId, var_7_1)

		gohelper.setActive(arg_7_0._gofirstfailtxt, true)

		if arg_7_0.episodeCo then
			local var_7_4 = string.splitToNumber(arg_7_0.episodeCo.cost, "#")
			local var_7_5 = var_7_4[1]
			local var_7_6 = var_7_4[2]

			if var_7_5 == MaterialEnum.MaterialType.Currency then
				gohelper.setActive(arg_7_0._costcurrencyIcon.gameObject, true)

				local var_7_7 = CurrencyConfig.instance:getCurrencyCo(var_7_6)

				UISpriteSetMgr.instance:setCurrencyItemSprite(arg_7_0._costcurrencyIcon, var_7_7.icon .. "_1")

				arg_7_0._txtaddActive.text = string.format(luaLang("fightfail_returncost"), var_7_3)
			else
				gohelper.setActive(arg_7_0._costitemIcon.gameObject, true)

				local var_7_8 = ItemModel.instance:getItemSmallIcon(var_7_6)
				local var_7_9 = ItemModel.instance:getItemConfig(var_7_5, var_7_6)

				arg_7_0._costitemIcon:LoadImage(var_7_8)

				local var_7_10 = {
					var_7_9.name,
					var_7_3
				}

				arg_7_0._txtaddActive.text = GameUtil.getSubPlaceholderLuaLang(luaLang("fightfail_returncost2"), var_7_10)
			end
		end
	end

	arg_7_0:refreshTips()
end

function var_0_0._hideActiveGo(arg_8_0)
	if arg_8_0.episodeCo and arg_8_0.episodeCo.type == DungeonEnum.EpisodeType.Equip then
		return FightModel.instance:isEnterUseFreeLimit()
	end

	if arg_8_0.episodeCo and (arg_8_0.episodeCo.type == DungeonEnum.EpisodeType.WeekWalk or arg_8_0.episodeCo.type == DungeonEnum.EpisodeType.Season) then
		return true
	end

	if (tonumber(DungeonConfig.instance:getEndBattleCost(arg_8_0._episodeId, false)) or 0) <= 0 then
		return true
	end

	return false
end

function var_0_0.refreshTips(arg_9_0)
	if not arg_9_0.chapterCo or arg_9_0.chapterCo.type == DungeonEnum.ChapterType.TeachNote then
		arg_9_0:refreshTeachNoteContainer()

		return
	end

	local var_9_0, var_9_1 = FightHelper.detectAttributeCounter()
	local var_9_2

	if #var_9_1 ~= 0 then
		var_9_2 = arg_9_0:getCounterHeroList(arg_9_0.fightParam:getAllHeroMoList(), var_9_1)
	end

	local var_9_3 = arg_9_0:getHeroPercent()
	local var_9_4 = arg_9_0:getEquipPercent()
	local var_9_5 = arg_9_0:getTalentPercent()

	if var_9_3 < var_0_0.ShowLevelContainerValue or var_9_4 < var_0_0.ShowLevelContainerValue or var_9_5 < var_0_0.ShowLevelContainerValue then
		arg_9_0:refreshLevelContainer(var_9_3, var_9_4, var_9_5)
	elseif var_9_2 and #var_9_2 ~= 0 then
		arg_9_0:refreshRestrainContainer(var_9_2)
	end

	local var_9_6 = arg_9_0:getShowConditionsCoList()

	if arg_9_0.episodeCo.type == DungeonEnum.EpisodeType.Meilanni then
		var_9_6 = HeroGroupFightViewRule.meilanniExcludeRules(var_9_6)
	end

	if arg_9_0.episodeCo.type == DungeonEnum.EpisodeType.Survival then
		var_9_6 = SurvivalShelterModel.instance:addExRule(var_9_6)
	end

	if var_9_6 and #var_9_6 ~= 0 then
		arg_9_0:refreshConditionsContainer(var_9_6)
	else
		arg_9_0:refreshNormalContainer()
	end

	TaskDispatcher.runDelay(arg_9_0.rebuildLayout, arg_9_0, 0.01)
end

function var_0_0.refreshLevelContainer(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	gohelper.setActive(arg_10_0._golevel, true)

	arg_10_0._txtlevelnum.text = tostring(Mathf.Min(Mathf.Floor(Mathf.Pow(arg_10_1, var_0_0.OffsetValue) * 100), 100)) .. "%"
	arg_10_0._txtequipnum.text = tostring(Mathf.Min(Mathf.Floor(Mathf.Pow(arg_10_2, var_0_0.OffsetValue) * 100), 100)) .. "%"
	arg_10_0._txttalentnum.text = tostring(Mathf.Min(Mathf.Floor(Mathf.Pow(arg_10_3, var_0_0.OffsetValue) * 100), 100)) .. "%"

	if arg_10_1 > var_0_0.ShowLevelContainerValue then
		UISpriteSetMgr.instance:setFightSprite(arg_10_0._imagelevelcareer, var_0_0.WhiteImageName)
		SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._txtlevelnum, var_0_0.PercentWhiteColor)
		SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._txtleveltitle, var_0_0.TxtWhiteColor)
	else
		UISpriteSetMgr.instance:setFightSprite(arg_10_0._imagelevelcareer, var_0_0.RedImageName)
		SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._txtlevelnum, var_0_0.PercentRedColor)
		SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._txtleveltitle, var_0_0.TxtRedColor)
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		gohelper.setActive(arg_10_0._goequipsubcontainer, true)

		if arg_10_2 > var_0_0.ShowLevelContainerValue then
			UISpriteSetMgr.instance:setFightSprite(arg_10_0._imageequipcareer, var_0_0.WhiteImageName)
			SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._txtequipnum, var_0_0.PercentWhiteColor)
			SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._txtequiptitle, var_0_0.TxtWhiteColor)
		else
			UISpriteSetMgr.instance:setFightSprite(arg_10_0._imageequipcareer, var_0_0.RedImageName)
			SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._txtequipnum, var_0_0.PercentRedColor)
			SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._txtequiptitle, var_0_0.TxtRedColor)
		end
	else
		gohelper.setActive(arg_10_0._goequipsubcontainer, false)
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
		gohelper.setActive(arg_10_0._gotalentsubcontainer, true)

		if arg_10_3 > var_0_0.ShowLevelContainerValue then
			UISpriteSetMgr.instance:setFightSprite(arg_10_0._imagetalentcareer, var_0_0.WhiteImageName)
			SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._txttalentnum, var_0_0.PercentWhiteColor)
			SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._txttalenttitle, var_0_0.TxtWhiteColor)
		else
			UISpriteSetMgr.instance:setFightSprite(arg_10_0._imagetalentcareer, var_0_0.RedImageName)
			SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._txttalentnum, var_0_0.PercentRedColor)
			SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._txttalenttitle, var_0_0.TxtRedColor)
		end
	else
		gohelper.setActive(arg_10_0._gotalentsubcontainer, false)
	end
end

function var_0_0.refreshRestrainContainer(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		local var_11_0 = gohelper.clone(arg_11_0.restrainItem, arg_11_0._goherotipslist, "item" .. iter_11_0)
		local var_11_1 = gohelper.findChildImage(var_11_0, "image_career")
		local var_11_2 = gohelper.findChildText(var_11_0, "txt_herotips")

		UISpriteSetMgr.instance:setFightSprite(var_11_1, var_0_0.CareerToImageName[iter_11_1.career])

		var_11_2.text = string.format(luaLang("restrain_text"), iter_11_1.name)

		gohelper.setActive(var_11_0, true)
	end

	gohelper.setActive(arg_11_0._gorestrain, true)
end

function var_0_0.refreshConditionsContainer(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		local var_12_0 = iter_12_1[1]
		local var_12_1 = iter_12_1[2]
		local var_12_2 = lua_rule.configDict[var_12_1]

		if var_12_2 then
			local var_12_3 = gohelper.clone(arg_12_0._goconditionitem, arg_12_0._goconditions, "item" .. iter_12_0)
			local var_12_4 = gohelper.findChildText(var_12_3, "#txt_extratips")
			local var_12_5 = var_12_2.desc
			local var_12_6 = SkillHelper.buildDesc(var_12_5, "#FFFFFF", "#FFFFFF")

			var_12_4.text = string.format("[%s] %s", luaLang("dungeon_add_rule_target_" .. var_12_0), var_12_6)

			gohelper.setActive(var_12_3, true)
		end
	end

	gohelper.setActive(arg_12_0._goconditions, true)
end

function var_0_0.refreshNormalContainer(arg_13_0)
	gohelper.setActive(arg_13_0._gonormaltip, true)
end

function var_0_0.refreshTeachNoteContainer(arg_14_0)
	gohelper.setActive(arg_14_0._goteachnote, true)
end

function var_0_0.getCounterHeroList(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		for iter_15_2, iter_15_3 in ipairs(arg_15_2) do
			local var_15_1 = iter_15_1.config

			if var_15_1 and var_15_1.career == iter_15_3 then
				table.insert(var_15_0, var_15_1)

				break
			end
		end
	end

	return var_15_0
end

function var_0_0.getHeroPercent(arg_16_0)
	local var_16_0 = EffectivenessConfig.instance:calculateHeroAverageEffectiveness(arg_16_0.fightParam:getMainHeroMoList(), arg_16_0.fightParam:getSubHeroMoList())
	local var_16_1 = arg_16_0.isSimple and arg_16_0.constEffectiveness[1] or arg_16_0.battleCo.heroEffectiveness

	return arg_16_0:calculatePercent(var_16_0, var_16_1)
end

function var_0_0.getEquipPercent(arg_17_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		return var_0_0.ShowLevelContainerValue + 1
	end

	local var_17_0 = EffectivenessConfig.instance:calculateEquipAverageEffectiveness(arg_17_0.fightParam:getEquipMoList())
	local var_17_1 = arg_17_0.isSimple and arg_17_0.constEffectiveness[2] or arg_17_0.battleCo.equipEffectiveness

	return arg_17_0:calculatePercent(var_17_0, var_17_1)
end

function var_0_0.getTalentPercent(arg_18_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
		return var_0_0.ShowLevelContainerValue + 1
	end

	local var_18_0 = EffectivenessConfig.instance:calculateTalentAverageEffectiveness(arg_18_0.fightParam:getMainHeroMoList(), arg_18_0.fightParam:getSubHeroMoList())
	local var_18_1 = arg_18_0.isSimple and arg_18_0.constEffectiveness[3] or arg_18_0.battleCo.talentEffectiveness

	return arg_18_0:calculatePercent(var_18_0, var_18_1)
end

function var_0_0.calculatePercent(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_2 <= arg_19_1 then
		return 1
	else
		return arg_19_1 / arg_19_2
	end
end

function var_0_0.getShowConditionsCoList(arg_20_0)
	local var_20_0 = {}
	local var_20_1 = arg_20_0.battleCo.additionRule

	if not string.nilorempty(var_20_1) then
		for iter_20_0, iter_20_1 in ipairs(GameUtil.splitString2(var_20_1, true, "|", "#")) do
			table.insert(var_20_0, iter_20_1)
		end
	end

	return var_20_0
end

function var_0_0.rebuildLayout(arg_21_0)
	ZProj.UGUIHelper.RebuildLayout(arg_21_0._gotips.transform)
end

function var_0_0._exitFight(arg_22_0)
	arg_22_0:closeThis()
	FightController.onResultViewClose()
end

function var_0_0.onClose(arg_23_0)
	return
end

function var_0_0.onCloseFinish(arg_24_0)
	FightStatModel.instance:clear()
end

function var_0_0.onDestroy(arg_25_0)
	if arg_25_0._costitemIcon then
		arg_25_0._costitemIcon:UnLoadImage()
	end
end

return var_0_0
