module("modules.logic.seasonver.act123.view1_9.Season123_1_9FightFailView", package.seeall)

slot0 = class("Season123_1_9FightFailView", FightFailView)

function slot0.onInitView(slot0)
	slot0._gopower = gohelper.findChild(slot0.viewGO, "#go_power")
	slot0._btndata = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_power/#btn_data")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "scroll/Viewport/#go_tips")
	slot0._gorestrain = gohelper.findChild(slot0.viewGO, "scroll/Viewport/#go_tips/#go_restrain")
	slot0._goherotipslist = gohelper.findChild(slot0.viewGO, "scroll/Viewport/#go_tips/#go_restrain/#go_herotipslist")
	slot0._goconditions = gohelper.findChild(slot0.viewGO, "scroll/Viewport/#go_tips/#go_conditions")
	slot0._goconditionitem = gohelper.findChild(slot0.viewGO, "scroll/Viewport/#go_tips/#go_conditions/#go_item")
	slot0._txtextratips = gohelper.findChildText(slot0.viewGO, "scroll/Viewport/#go_tips/#go_conditions/#go_item/#txt_extratips")
	slot0._gonormaltip = gohelper.findChild(slot0.viewGO, "scroll/Viewport/#go_tips/#go_normaltip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._click:AddClickListener(slot0._onClickClose, slot0)
	slot0._btndata:AddClickListener(slot0._onClickData, slot0)
end

function slot0.removeEvents(slot0)
	slot0._click:RemoveClickListener()
	slot0._btndata:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._click = gohelper.getClick(slot0.viewGO)
	slot0.restrainItem = gohelper.findChild(slot0._goherotipslist, "item")

	gohelper.setActive(slot0.restrainItem, false)
	gohelper.setActive(slot0._goconditionitem, false)
	gohelper.setActive(slot0._gorestrain, false)
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

	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onClickClose, slot0)

	if slot0:_hideActiveGo() and slot0.episodeCo then
		gohelper.setActive(slot0._gopower, true)
	end

	slot0:refreshTips()
end

function slot0.refreshTips(slot0)
	slot1, slot2 = FightHelper.detectAttributeCounter()
	slot3 = nil

	if #slot2 ~= 0 then
		slot3 = slot0:getCounterHeroList(slot0.fightParam:getAllHeroMoList(), slot2)
	end

	if slot3 and #slot3 ~= 0 and slot0.refreshRestrainContainer then
		slot0:refreshRestrainContainer(slot3)
	end

	if Season123Model.instance:getBattleContext() then
		if slot5.stage then
			slot4 = Season123Config.instance:filterRule(Season123HeroGroupModel.filterRule(slot5.actId, slot0:getShowConditionsCoList()), slot5.stage)
		end
	end

	if slot4 and #slot4 ~= 0 then
		slot0:refreshConditionsContainer(slot4)
	else
		gohelper.setActive(slot0._goconditions, false)
		slot0:refreshNormalContainer()
	end

	TaskDispatcher.runDelay(slot0.rebuildLayout, slot0, 0.01)
end

function slot0.onClose(slot0)
	uv0.super.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
end

return slot0
