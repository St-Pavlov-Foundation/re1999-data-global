module("modules.logic.season.view1_4.Season1_4FightFailView", package.seeall)

local var_0_0 = class("Season1_4FightFailView", FightFailView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gopower = gohelper.findChild(arg_1_0.viewGO, "#go_power")
	arg_1_0._btndata = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_power/#btn_data")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/#go_tips")
	arg_1_0._gorestrain = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_restrain")
	arg_1_0._goherotipslist = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_restrain/#go_herotipslist")
	arg_1_0._goconditions = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_conditions")
	arg_1_0._goconditionitem = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_conditions/#go_item")
	arg_1_0._txtextratips = gohelper.findChildText(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_conditions/#go_item/#txt_extratips")
	arg_1_0._gonormaltip = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/#go_tips/#go_normaltip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickClose, arg_2_0)
	arg_2_0._btndata:AddClickListener(arg_2_0._onClickData, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._click:RemoveClickListener()
	arg_3_0._btndata:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._click = gohelper.getClick(arg_4_0.viewGO)
	arg_4_0.restrainItem = gohelper.findChild(arg_4_0._goherotipslist, "item")

	gohelper.setActive(arg_4_0.restrainItem, false)
	gohelper.setActive(arg_4_0._goconditionitem, false)
	gohelper.setActive(arg_4_0._gorestrain, false)
end

function var_0_0.onOpen(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)
	FightController.instance:checkFightQuitTipViewClose()

	arg_5_0.fightParam = FightModel.instance:getFightParam()
	arg_5_0._episodeId = arg_5_0.fightParam.episodeId
	arg_5_0._chapterId = arg_5_0.fightParam.chapterId
	arg_5_0.episodeCo = lua_episode.configDict[arg_5_0._episodeId]
	arg_5_0.chapterCo = DungeonConfig.instance:getChapterCO(arg_5_0._chapterId)
	arg_5_0.battleCo = DungeonConfig.instance:getBattleCo(nil, FightModel.instance:getBattleId())

	NavigateMgr.instance:addEscape(ViewName.FightFailView, arg_5_0._onClickClose, arg_5_0)

	if arg_5_0:_hideActiveGo() and arg_5_0.episodeCo then
		gohelper.setActive(arg_5_0._gopower, true)
	end

	arg_5_0:refreshTips()
end

function var_0_0.refreshTips(arg_6_0)
	local var_6_0, var_6_1 = FightHelper.detectAttributeCounter()
	local var_6_2

	if #var_6_1 ~= 0 then
		var_6_2 = arg_6_0:getCounterHeroList(arg_6_0.fightParam:getAllHeroMoList(), var_6_1)
	end

	if var_6_2 and #var_6_2 ~= 0 and arg_6_0.refreshRestrainContainer then
		arg_6_0:refreshRestrainContainer(var_6_2)
	end

	local var_6_3 = arg_6_0:getShowConditionsCoList()
	local var_6_4 = SeasonConfig.instance:filterRule(var_6_3)

	if var_6_4 and #var_6_4 ~= 0 then
		arg_6_0:refreshConditionsContainer(var_6_4)
	else
		gohelper.setActive(arg_6_0._goconditions, false)
		arg_6_0:refreshNormalContainer()
	end

	TaskDispatcher.runDelay(arg_6_0.rebuildLayout, arg_6_0, 0.01)
end

function var_0_0.onClose(arg_7_0)
	var_0_0.super.onClose(arg_7_0)
end

function var_0_0.onDestroyView(arg_8_0)
	var_0_0.super.onDestroyView(arg_8_0)
end

return var_0_0
