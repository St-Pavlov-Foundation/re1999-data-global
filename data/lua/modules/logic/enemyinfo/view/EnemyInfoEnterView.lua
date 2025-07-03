module("modules.logic.enemyinfo.view.EnemyInfoEnterView", package.seeall)

local var_0_0 = class("EnemyInfoEnterView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.simageRightBg = gohelper.findChildSingleImage(arg_4_0.viewGO, "bg_container/#simage_rightbg")

	arg_4_0.simageRightBg:LoadImage("singlebg/dungeon/bg_battledetail.png")

	arg_4_0.trTabContainer = gohelper.findChildComponent(arg_4_0.viewGO, "#go_tab_container", gohelper.Type_Transform)

	for iter_4_0 = 0, arg_4_0.trTabContainer.childCount - 1 do
		local var_4_0 = arg_4_0.trTabContainer:GetChild(iter_4_0)

		gohelper.setActive(var_4_0.gameObject, false)
	end
end

function var_0_0.initHandleDict(arg_5_0)
	if arg_5_0.tabEnum2HandleFunc then
		return
	end

	arg_5_0.tabEnum2HandleFunc = {
		[EnemyInfoEnum.TabEnum.Normal] = arg_5_0.refreshNormal,
		[EnemyInfoEnum.TabEnum.WeekWalk] = arg_5_0.refreshWeekWalk,
		[EnemyInfoEnum.TabEnum.WeekWalk_2] = arg_5_0.refreshWeekWalk_2,
		[EnemyInfoEnum.TabEnum.Season123] = arg_5_0.refreshSeason,
		[EnemyInfoEnum.TabEnum.BossRush] = arg_5_0.refreshBossRush,
		[EnemyInfoEnum.TabEnum.Act191] = arg_5_0.refreshNormal
	}
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.enemyInfoMo

	var_6_0:setTabEnum(arg_6_0.viewParam.tabEnum)
	arg_6_0:initHandleDict()
	;(arg_6_0.tabEnum2HandleFunc[var_6_0.tabEnum] or arg_6_0.refreshNormal)(arg_6_0)
end

function var_0_0.refreshNormal(arg_7_0)
	local var_7_0 = arg_7_0.enemyInfoMo

	var_7_0:setShowLeftTab(false)
	var_7_0:updateBattleId(arg_7_0.viewParam.battleId)
end

function var_0_0.refreshWeekWalk(arg_8_0)
	arg_8_0.tabView = arg_8_0:createTabView(EnemyInfoWeekWalkTabView)

	arg_8_0.tabView:onOpen()
end

function var_0_0.refreshWeekWalk_2(arg_9_0)
	arg_9_0.tabView = arg_9_0:createTabView(EnemyInfoWeekWalk_2TabView)

	arg_9_0.tabView:onOpen()
end

function var_0_0.refreshSeason(arg_10_0)
	local var_10_0 = arg_10_0.enemyInfoMo

	if arg_10_0.viewParam.showLeftTab then
		var_10_0:setShowLeftTab(true)

		arg_10_0.tabView = arg_10_0:createTabView(EnemyInfoSeason123TabView)

		arg_10_0.tabView:onOpen()
	else
		var_10_0:setShowLeftTab(false)
		var_10_0:updateBattleId(arg_10_0.viewParam.battleId)
	end
end

function var_0_0.refreshBossRush(arg_11_0)
	local var_11_0 = arg_11_0.enemyInfoMo

	var_11_0:setShowLeftTab(false)

	local var_11_1 = arg_11_0.viewParam.activityId
	local var_11_2 = arg_11_0.viewParam.stage
	local var_11_3 = arg_11_0.viewParam.layer
	local var_11_4 = lua_activity128_episode.configDict[var_11_1][var_11_2][var_11_3]
	local var_11_5 = DungeonConfig.instance:getEpisodeCO(var_11_4.episodeId)

	var_11_0:updateBattleId(var_11_5.battleId)
end

function var_0_0.createTabView(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.New()

	var_12_0:__onInit()

	var_12_0.viewGO = arg_12_0.viewGO
	var_12_0.viewContainer = arg_12_0.viewContainer
	var_12_0.tabParentView = arg_12_0
	var_12_0.viewName = arg_12_0.viewName

	var_12_0:onInitView()
	var_12_0:addEvents()

	var_12_0.layoutMo = arg_12_0.layoutMo
	var_12_0.enemyInfoMo = arg_12_0.enemyInfoMo
	var_12_0.viewParam = arg_12_0.viewParam

	return var_12_0
end

function var_0_0.onClose(arg_13_0)
	if arg_13_0.tabView then
		arg_13_0.tabView:onClose()
	end
end

function var_0_0.onDestroyView(arg_14_0)
	if arg_14_0.tabView then
		arg_14_0.tabView:removeEvents()
		arg_14_0.tabView:onDestroyView()
		arg_14_0.tabView:__onDispose()
	end

	arg_14_0.simageRightBg:UnLoadImage()
end

return var_0_0
