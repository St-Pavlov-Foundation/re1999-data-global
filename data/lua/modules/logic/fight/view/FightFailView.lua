module("modules.logic.fight.view.FightFailView", package.seeall)

slot0 = class("FightFailView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocost = gohelper.findChild(slot0.viewGO, "#go_cost")
	slot0._txtaddActive = gohelper.findChildText(slot0.viewGO, "#go_cost/#txt_addActive")
	slot0._gofirstfailtxt = gohelper.findChild(slot0.viewGO, "#go_cost/#txt_addActive/#go_firstfailtxt")
	slot0._goAddActive = gohelper.findChild(slot0.viewGO, "#go_cost/#txt_addActive")
	slot0._btnData = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cost/#btn_data")
	slot0._gocosticon = gohelper.findChild(slot0.viewGO, "#go_cost/#go_costicon")
	slot0._costitemIcon = gohelper.findChildSingleImage(slot0._gocosticon, "itemIcon")
	slot0._costcurrencyIcon = gohelper.findChildImage(slot0._gocosticon, "currencyIcon")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "scroll/Viewport/#go_tips")
	slot0._golevel = gohelper.findChild(slot0.viewGO, "scroll/Viewport/#go_tips/#go_level")
	slot0._goinfos = gohelper.findChild(slot0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos")
	slot0._golevelsubcontainer = gohelper.findChild(slot0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_levelsubcontainer")
	slot0._goequipsubcontainer = gohelper.findChild(slot0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_equipsubcontainer")
	slot0._gotalentsubcontainer = gohelper.findChild(slot0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_talentsubcontainer")
	slot0._imagelevelcareer = gohelper.findChildImage(slot0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_levelsubcontainer/#image_levelcareer")
	slot0._txtleveltitle = gohelper.findChildText(slot0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_levelsubcontainer/#txt_leveltitle")
	slot0._txtlevelnum = gohelper.findChildText(slot0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_levelsubcontainer/#txt_levelnum")
	slot0._imageequipcareer = gohelper.findChildImage(slot0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_equipsubcontainer/#image_equipcareer")
	slot0._txtequiptitle = gohelper.findChildText(slot0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_equipsubcontainer/#txt_equiptitle")
	slot0._txtequipnum = gohelper.findChildText(slot0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_equipsubcontainer/#txt_equipnum")
	slot0._imagetalentcareer = gohelper.findChildImage(slot0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_talentsubcontainer/#image_talentcareer")
	slot0._txttalenttitle = gohelper.findChildText(slot0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_talentsubcontainer/#txt_talenttitle")
	slot0._txttalentnum = gohelper.findChildText(slot0.viewGO, "scroll/Viewport/#go_tips/#go_level/#go_infos/#go_talentsubcontainer/#txt_talentnum")
	slot0._gorestrain = gohelper.findChild(slot0.viewGO, "scroll/Viewport/#go_tips/#go_restrain")
	slot0._goherotipslist = gohelper.findChild(slot0.viewGO, "scroll/Viewport/#go_tips/#go_restrain/#go_herotipslist")
	slot0._goconditions = gohelper.findChild(slot0.viewGO, "scroll/Viewport/#go_tips/#go_conditions")
	slot0._goconditionitem = gohelper.findChild(slot0.viewGO, "scroll/Viewport/#go_tips/#go_conditions/#go_item")
	slot0._gonormaltip = gohelper.findChild(slot0.viewGO, "scroll/Viewport/#go_tips/#go_normaltip")
	slot0._goteachnote = gohelper.findChild(slot0.viewGO, "scroll/Viewport/#go_tips/#go_teachnote")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._click:AddClickListener(slot0._onClickClose, slot0)
	slot0._btnData:AddClickListener(slot0._onClickData, slot0)
end

function slot0.removeEvents(slot0)
	slot0._click:RemoveClickListener()
	slot0._btnData:RemoveClickListener()
end

slot0.CareerToImageName = {
	"zhandou_icon_yan",
	"zhandou_icon_xing",
	"zhandou_icon_mu",
	"zhandou_icon_shou",
	"zhandou_icon_ling",
	"zhandou_icon_zhi"
}
slot0.ShowLevelContainerValue = 0.8
slot0.OffsetValue = 1.6
slot0.PercentRedColor = "#b26161"
slot0.PercentWhiteColor = "#e2e2e2"
slot0.TxtRedColor = "#b26161"
slot0.TxtWhiteColor = "#adadad"
slot0.RedImageName = "zhandou_tuoyuan_hong"
slot0.WhiteImageName = "zhandou_tuoyuan_bai"

function slot0._editableInitView(slot0)
	slot0._click = gohelper.getClick(slot0.viewGO)

	gohelper.setActive(slot0._golevel, false)
	gohelper.setActive(slot0._gorestrain, false)
	gohelper.setActive(slot0._goconditions, false)
	gohelper.setActive(slot0._gonormaltip, false)
	gohelper.setActive(slot0._goteachnote, false)

	slot0.restrainItem = gohelper.findChild(slot0._goherotipslist, "item")

	gohelper.setActive(slot0.restrainItem, false)
	gohelper.setActive(slot0._goconditionitem, false)

	if DungeonModel.instance.curSendChapterId then
		slot0.isSimple = DungeonConfig.instance:getChapterCO(slot1) and slot2.type == DungeonEnum.ChapterType.Simple
	end

	slot0.constEffectiveness = string.splitToNumber(lua_const.configDict[ConstEnum.SimpleEpisodeEffectiveness].value, "#")
end

function slot0._onClickClose(slot0)
	slot0:_exitFight()
end

function slot0._onClickData(slot0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)
	FightController.instance:checkFightQuitTipViewClose()

	slot0.fightParam = FightModel.instance:getFightParam()
	slot0._episodeId = slot0.fightParam.episodeId
	slot0._chapterId = slot0.fightParam.chapterId
	slot0.episodeCo = lua_episode.configDict[slot0._episodeId]
	slot0.chapterCo = DungeonConfig.instance:getChapterCO(slot0._chapterId)
	slot0.battleCo = DungeonConfig.instance:getBattleCo(nil, FightModel.instance:getBattleId())

	NavigateMgr.instance:addEscape(ViewName.FightFailView, slot0._onClickClose, slot0)

	if slot0:_hideActiveGo() then
		if slot0.episodeCo then
			gohelper.setActive(slot0._gocost, true)

			slot0._txtaddActive.text = ""
		end

		gohelper.setActive(slot0._gofirstfailtxt, false)
	else
		slot3 = FightModel.instance.cacheUserDungeonMO or DungeonModel.instance:getEpisodeInfo(slot0._episodeId)

		gohelper.setActive(slot0._gofirstfailtxt, true)

		if slot0.episodeCo then
			slot5 = string.splitToNumber(slot0.episodeCo.cost, "#")

			if slot5[1] == MaterialEnum.MaterialType.Currency then
				gohelper.setActive(slot0._costcurrencyIcon.gameObject, true)
				UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._costcurrencyIcon, CurrencyConfig.instance:getCurrencyCo(slot5[2]).icon .. "_1")

				slot0._txtaddActive.text = string.format(luaLang("fightfail_returncost"), DungeonConfig.instance:getEpisodeFailedReturnCost(slot0._episodeId, FightModel.instance:getFightParam() and slot1.multiplication or 1))
			else
				gohelper.setActive(slot0._costitemIcon.gameObject, true)
				slot0._costitemIcon:LoadImage(ItemModel.instance:getItemSmallIcon(slot7))

				slot0._txtaddActive.text = GameUtil.getSubPlaceholderLuaLang(luaLang("fightfail_returncost2"), {
					ItemModel.instance:getItemConfig(slot6, slot7).name,
					slot4
				})
			end
		end
	end

	slot0:refreshTips()
end

function slot0._hideActiveGo(slot0)
	if slot0.episodeCo and slot0.episodeCo.type == DungeonEnum.EpisodeType.Equip then
		return FightModel.instance:isEnterUseFreeLimit()
	end

	if slot0.episodeCo and (slot0.episodeCo.type == DungeonEnum.EpisodeType.WeekWalk or slot0.episodeCo.type == DungeonEnum.EpisodeType.Season) then
		return true
	end

	if (tonumber(DungeonConfig.instance:getEndBattleCost(slot0._episodeId, false)) or 0) <= 0 then
		return true
	end

	return false
end

function slot0.refreshTips(slot0)
	if not slot0.chapterCo or slot0.chapterCo.type == DungeonEnum.ChapterType.TeachNote then
		slot0:refreshTeachNoteContainer()

		return
	end

	slot1, slot2 = FightHelper.detectAttributeCounter()
	slot3 = nil

	if #slot2 ~= 0 then
		slot3 = slot0:getCounterHeroList(slot0.fightParam:getAllHeroMoList(), slot2)
	end

	slot5 = slot0:getEquipPercent()
	slot6 = slot0:getTalentPercent()

	if slot0:getHeroPercent() < uv0.ShowLevelContainerValue or slot5 < uv0.ShowLevelContainerValue or slot6 < uv0.ShowLevelContainerValue then
		slot0:refreshLevelContainer(slot4, slot5, slot6)
	elseif slot3 and #slot3 ~= 0 then
		slot0:refreshRestrainContainer(slot3)
	end

	if slot0.episodeCo.type == DungeonEnum.EpisodeType.Meilanni then
		slot7 = HeroGroupFightViewRule.meilanniExcludeRules(slot0:getShowConditionsCoList())
	end

	if slot7 and #slot7 ~= 0 then
		slot0:refreshConditionsContainer(slot7)
	else
		slot0:refreshNormalContainer()
	end

	TaskDispatcher.runDelay(slot0.rebuildLayout, slot0, 0.01)
end

function slot0.refreshLevelContainer(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot0._golevel, true)

	slot0._txtlevelnum.text = tostring(Mathf.Min(Mathf.Floor(Mathf.Pow(slot1, uv0.OffsetValue) * 100), 100)) .. "%"
	slot0._txtequipnum.text = tostring(Mathf.Min(Mathf.Floor(Mathf.Pow(slot2, uv0.OffsetValue) * 100), 100)) .. "%"
	slot0._txttalentnum.text = tostring(Mathf.Min(Mathf.Floor(Mathf.Pow(slot3, uv0.OffsetValue) * 100), 100)) .. "%"

	if uv0.ShowLevelContainerValue < slot1 then
		UISpriteSetMgr.instance:setFightSprite(slot0._imagelevelcareer, uv0.WhiteImageName)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtlevelnum, uv0.PercentWhiteColor)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtleveltitle, uv0.TxtWhiteColor)
	else
		UISpriteSetMgr.instance:setFightSprite(slot0._imagelevelcareer, uv0.RedImageName)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtlevelnum, uv0.PercentRedColor)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtleveltitle, uv0.TxtRedColor)
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		gohelper.setActive(slot0._goequipsubcontainer, true)

		if uv0.ShowLevelContainerValue < slot2 then
			UISpriteSetMgr.instance:setFightSprite(slot0._imageequipcareer, uv0.WhiteImageName)
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtequipnum, uv0.PercentWhiteColor)
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtequiptitle, uv0.TxtWhiteColor)
		else
			UISpriteSetMgr.instance:setFightSprite(slot0._imageequipcareer, uv0.RedImageName)
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtequipnum, uv0.PercentRedColor)
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtequiptitle, uv0.TxtRedColor)
		end
	else
		gohelper.setActive(slot0._goequipsubcontainer, false)
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
		gohelper.setActive(slot0._gotalentsubcontainer, true)

		if uv0.ShowLevelContainerValue < slot3 then
			UISpriteSetMgr.instance:setFightSprite(slot0._imagetalentcareer, uv0.WhiteImageName)
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txttalentnum, uv0.PercentWhiteColor)
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txttalenttitle, uv0.TxtWhiteColor)
		else
			UISpriteSetMgr.instance:setFightSprite(slot0._imagetalentcareer, uv0.RedImageName)
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txttalentnum, uv0.PercentRedColor)
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txttalenttitle, uv0.TxtRedColor)
		end
	else
		gohelper.setActive(slot0._gotalentsubcontainer, false)
	end
end

function slot0.refreshRestrainContainer(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = gohelper.clone(slot0.restrainItem, slot0._goherotipslist, "item" .. slot5)

		UISpriteSetMgr.instance:setFightSprite(gohelper.findChildImage(slot7, "image_career"), uv0.CareerToImageName[slot6.career])

		gohelper.findChildText(slot7, "txt_herotips").text = string.format(luaLang("restrain_text"), slot6.name)

		gohelper.setActive(slot7, true)
	end

	gohelper.setActive(slot0._gorestrain, true)
end

function slot0.refreshConditionsContainer(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if lua_rule.configDict[slot6[2]] then
			slot10 = gohelper.clone(slot0._goconditionitem, slot0._goconditions, "item" .. slot5)
			gohelper.findChildText(slot10, "#txt_extratips").text = string.format("[%s] %s", luaLang("dungeon_add_rule_target_" .. slot6[1]), slot9.desc)

			gohelper.setActive(slot10, true)
		end
	end

	gohelper.setActive(slot0._goconditions, true)
end

function slot0.refreshNormalContainer(slot0)
	gohelper.setActive(slot0._gonormaltip, true)
end

function slot0.refreshTeachNoteContainer(slot0)
	gohelper.setActive(slot0._goteachnote, true)
end

function slot0.getCounterHeroList(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		for slot12, slot13 in ipairs(slot2) do
			if slot8.config and slot14.career == slot13 then
				table.insert(slot3, slot14)

				break
			end
		end
	end

	return slot3
end

function slot0.getHeroPercent(slot0)
	return slot0:calculatePercent(EffectivenessConfig.instance:calculateHeroAverageEffectiveness(slot0.fightParam:getMainHeroMoList(), slot0.fightParam:getSubHeroMoList()), slot0.isSimple and slot0.constEffectiveness[1] or slot0.battleCo.heroEffectiveness)
end

function slot0.getEquipPercent(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		return uv0.ShowLevelContainerValue + 1
	end

	return slot0:calculatePercent(EffectivenessConfig.instance:calculateEquipAverageEffectiveness(slot0.fightParam:getEquipMoList()), slot0.isSimple and slot0.constEffectiveness[2] or slot0.battleCo.equipEffectiveness)
end

function slot0.getTalentPercent(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
		return uv0.ShowLevelContainerValue + 1
	end

	return slot0:calculatePercent(EffectivenessConfig.instance:calculateTalentAverageEffectiveness(slot0.fightParam:getMainHeroMoList(), slot0.fightParam:getSubHeroMoList()), slot0.isSimple and slot0.constEffectiveness[3] or slot0.battleCo.talentEffectiveness)
end

function slot0.calculatePercent(slot0, slot1, slot2)
	if slot2 <= slot1 then
		return 1
	else
		return slot1 / slot2
	end
end

function slot0.getShowConditionsCoList(slot0)
	slot1 = {}

	if not string.nilorempty(slot0.battleCo.additionRule) then
		slot7 = slot2

		for slot6, slot7 in ipairs(GameUtil.splitString2(slot7, true, "|", "#")) do
			table.insert(slot1, slot7)
		end
	end

	return slot1
end

function slot0.rebuildLayout(slot0)
	ZProj.UGUIHelper.RebuildLayout(slot0._gotips.transform)
end

function slot0._exitFight(slot0)
	slot0:closeThis()
	FightController.onResultViewClose()
end

function slot0.onClose(slot0)
end

function slot0.onCloseFinish(slot0)
	FightStatModel.instance:clear()
end

function slot0.onDestroy(slot0)
	if slot0._costitemIcon then
		slot0._costitemIcon:UnLoadImage()
	end
end

return slot0
