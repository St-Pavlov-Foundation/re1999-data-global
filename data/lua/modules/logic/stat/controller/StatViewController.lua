module("modules.logic.stat.controller.StatViewController", package.seeall)

local var_0_0 = class("StatViewController")

function var_0_0.init(arg_1_0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, arg_1_0.onTouchScreenDown, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_1_0.onOpenView, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, arg_1_0.onOpenView, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.BeforeOpenTabView, arg_1_0.onBeforeOpenTabView, arg_1_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnChangeChapterList, arg_1_0.onChangeChapterType, arg_1_0)
	ExploreController.instance:registerCallback(ExploreEvent.OnChapterClick, arg_1_0.onExploreChapterClick, arg_1_0)
	SummonController.instance:registerCallback(SummonEvent.onSummonTabSet, arg_1_0.onSwitchPool, arg_1_0)
	CharacterController.instance:registerCallback(CharacterEvent.OnSwitchSkin, arg_1_0.onSwitchSkin, arg_1_0)

	arg_1_0.viewHandleDict = {
		[ViewName.SummonADView] = arg_1_0.handleSummonTabView,
		[ViewName.StoreView] = arg_1_0.handleStoreTabView,
		[ViewName.DungeonView] = arg_1_0.handleDungeonView,
		[ViewName.DungeonMapView] = arg_1_0.handleDungeonMapView,
		[ViewName.V1a4_BossRushLevelDetail] = arg_1_0.handleV1a4_BossRushLevelDetail,
		[ViewName.OptionalChargeView] = arg_1_0.handleOptionalChargeView,
		[ViewName.VersionActivity2_0EnterView] = arg_1_0.handleVersionActivityEnterView
	}
end

function var_0_0.onChangeChapterType(arg_2_0, arg_2_1)
	arg_2_0:_handleDungeonView(arg_2_1)
end

function var_0_0.onSwitchPool(arg_3_0)
	local var_3_0 = ViewName.SummonADView
	local var_3_1 = SummonMainModel.instance:getCurPool()
	local var_3_2 = string.format("%s-%s", StatViewNameEnum.ChineseViewName[var_3_0] or var_3_0, var_3_1.nameCn)

	arg_3_0:track(var_3_2, StatViewNameEnum.ChineseViewName[arg_3_0.startView] or arg_3_0.startView, arg_3_0.materialName)
end

function var_0_0.onTouchScreenDown(arg_4_0)
	if UIBlockMgr.instance:isBlock() then
		return
	end

	local var_4_0 = arg_4_0:getLastOpenView()

	if var_4_0 then
		arg_4_0.startView = var_4_0
	end
end

function var_0_0.getLastOpenView(arg_5_0)
	arg_5_0.materialName = nil

	local var_5_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_5_0 = #var_5_0, 1, -1 do
		local var_5_1 = var_5_0[iter_5_0]

		if not arg_5_0:isIgnoreView(var_5_1) then
			if arg_5_0:isTipView(var_5_1) then
				arg_5_0.materialName = arg_5_0:getMaterialName()
			else
				return var_5_1
			end
		end
	end
end

function var_0_0.onOpenView(arg_6_0, arg_6_1, arg_6_2)
	if not StatViewNameEnum.NeedTrackViewDict[arg_6_1] then
		return
	end

	if tabletool.indexOf(StatViewNameEnum.NeedListenTabSwitchList, arg_6_1) then
		return
	end

	;(arg_6_0.viewHandleDict[arg_6_1] or arg_6_0.defaultViewHandle)(arg_6_0, arg_6_1, arg_6_2)
end

function var_0_0.onBeforeOpenTabView(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.viewName
	local var_7_1 = arg_7_1.tabGroupView
	local var_7_2 = arg_7_1.tabView

	if var_7_1:getTabContainerId() ~= StatViewNameEnum.TabViewContainerID[var_7_0] then
		return
	end

	;(arg_7_0.viewHandleDict[var_7_0] or arg_7_0.defaultTabViewHandle)(arg_7_0, var_7_0, var_7_2)
end

function var_0_0.defaultViewHandle(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:track(StatViewNameEnum.ChineseViewName[arg_8_1] or arg_8_1, StatViewNameEnum.ChineseViewName[arg_8_0.startView] or arg_8_0.startView, arg_8_0.materialName)
end

function var_0_0.defaultTabViewHandle(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = StatViewNameEnum.TabViewName[arg_9_2.__cname] or StatViewNameEnum.TabViewName[arg_9_2.class]

	var_9_0 = var_9_0 or arg_9_0:_findTabViewChildCnName(arg_9_2)

	local var_9_1 = string.format("%s-%s", StatViewNameEnum.ChineseViewName[arg_9_1] or arg_9_1, var_9_0 or arg_9_2.__cname)

	arg_9_0:track(var_9_1, StatViewNameEnum.ChineseViewName[arg_9_0.startView] or arg_9_0.startView, arg_9_0.materialName)
end

function var_0_0._findTabViewChildCnName(arg_10_0, arg_10_1)
	if arg_10_1 and arg_10_1._views and #arg_10_1._views > 0 then
		for iter_10_0, iter_10_1 in ipairs(arg_10_1._views) do
			if StatViewNameEnum.TabViewName[iter_10_1.__cname] then
				return StatViewNameEnum.TabViewName[iter_10_1.__cname]
			end
		end
	end

	return nil
end

function var_0_0.handleVersionActivityEnterView(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = ViewMgr.instance:getContainer(arg_11_1)

	if not var_11_0 then
		logError("not open " .. tostring(arg_11_1))

		return
	end

	local var_11_1 = var_11_0.activityId
	local var_11_2 = ActivityConfig.instance:getActivityCo(var_11_1)
	local var_11_3 = string.format("%s-%s", StatViewNameEnum.ChineseViewName[arg_11_1] or arg_11_1, var_11_2 and var_11_2.name or arg_11_2.__cname)

	arg_11_0:track(var_11_3, StatViewNameEnum.ChineseViewName[arg_11_0.startView] or arg_11_0.startView, arg_11_0.materialName)
end

function var_0_0.handleStoreTabView(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = ViewMgr.instance:getContainer(arg_12_1)

	if not var_12_0 then
		logError("not open store view ?")

		return
	end

	local var_12_1 = var_12_0:getSelectFirstTabId()

	if string.nilorempty(var_12_1) then
		return
	end

	local var_12_2 = StoreConfig.instance:getTabConfig(var_12_1)

	arg_12_0:track(var_12_2.name, StatViewNameEnum.ChineseViewName[arg_12_0.startView] or arg_12_0.startView, arg_12_0.materialName)
end

function var_0_0.handleSummonTabView(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = SummonMainModel.instance:getCurPool()
	local var_13_1 = string.format("%s-%s", StatViewNameEnum.ChineseViewName[arg_13_1] or arg_13_1, var_13_0.nameCn)

	arg_13_0:track(var_13_1, StatViewNameEnum.ChineseViewName[arg_13_0.startView] or arg_13_0.startView, arg_13_0.materialName)
end

function var_0_0.handleDungeonView(arg_14_0, arg_14_1)
	arg_14_0:_handleDungeonView(DungeonModel.instance.curChapterType)
end

function var_0_0._handleDungeonView(arg_15_0, arg_15_1)
	local var_15_0 = StatViewNameEnum.ChineseViewName[ViewName.DungeonView] .. "-"

	if DungeonModel.instance:chapterListIsNormalType(arg_15_1) then
		arg_15_0:track(var_15_0 .. StatViewNameEnum.DungeonViewName.Story, StatViewNameEnum.ChineseViewName[arg_15_0.startView] or arg_15_0.startView, arg_15_0.materialName)

		return
	end

	if DungeonModel.instance:chapterListIsRoleStory(arg_15_1) then
		arg_15_0:track(var_15_0 .. StatViewNameEnum.DungeonViewName.RoleStory, StatViewNameEnum.ChineseViewName[arg_15_0.startView] or arg_15_0.startView, arg_15_0.materialName)

		return
	end

	if DungeonModel.instance:chapterListIsResType(arg_15_1) then
		arg_15_0:track(var_15_0 .. StatViewNameEnum.DungeonViewName.Res, StatViewNameEnum.ChineseViewName[arg_15_0.startView] or arg_15_0.startView, arg_15_0.materialName)

		return
	end

	if DungeonModel.instance:chapterListIsBreakType(arg_15_1) then
		arg_15_0:track(var_15_0 .. StatViewNameEnum.DungeonViewName.Break, StatViewNameEnum.ChineseViewName[arg_15_0.startView] or arg_15_0.startView, arg_15_0.materialName)

		return
	end

	if DungeonModel.instance:chapterListIsWeekWalkType(arg_15_1) then
		arg_15_0:track(var_15_0 .. StatViewNameEnum.DungeonViewName.WeekWalkName, StatViewNameEnum.ChineseViewName[arg_15_0.startView] or arg_15_0.startView, arg_15_0.materialName)

		return
	end

	if DungeonModel.instance:chapterListIsPermanent(arg_15_1) then
		arg_15_0:track(var_15_0 .. StatViewNameEnum.DungeonViewName.Permanent, StatViewNameEnum.ChineseViewName[arg_15_0.startView] or arg_15_0.startView, arg_15_0.materialName)

		return
	end
end

function var_0_0.onExploreChapterClick(arg_16_0, arg_16_1)
	local var_16_0 = DungeonConfig.instance:getExploreChapterList()[arg_16_1]

	arg_16_0:track(string.format("%s-%s-%s", StatViewNameEnum.ChineseViewName[ViewName.DungeonView], StatViewNameEnum.DungeonViewName.ExploreName, var_16_0.name), StatViewNameEnum.ChineseViewName[arg_16_0.startView] or arg_16_0.startView, arg_16_0.materialName)
end

function var_0_0.handleDungeonMapView(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_2.chapterId
	local var_17_1 = DungeonConfig.instance:getChapterCO(var_17_0)

	arg_17_0:track(string.format("%s-%s", StatViewNameEnum.ChineseViewName[arg_17_1], var_17_1.name), StatViewNameEnum.ChineseViewName[arg_17_0.startView] or arg_17_0.startView, arg_17_0.materialName)
end

function var_0_0.handleV1a4_BossRushLevelDetail(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2.stageCO
	local var_18_1 = (StatViewNameEnum.ChineseViewName[arg_18_1] or arg_18_1) .. " - " .. var_18_0.name

	arg_18_0:track(var_18_1, StatViewNameEnum.ChineseViewName[arg_18_0.startView] or arg_18_0.startView, arg_18_0.materialName)
end

function var_0_0.handleOptionalChargeView(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_2 and arg_19_2.config
	local var_19_1 = var_19_0 and var_19_0.name

	arg_19_0:track(var_19_1, StatViewNameEnum.ChineseViewName[arg_19_0.startView] or arg_19_0.startView, arg_19_0.materialName)
end

function var_0_0.onSwitchSkin(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0:track((StatViewNameEnum.ChineseViewName[arg_20_2] or arg_20_2) .. "-" .. (arg_20_1 and arg_20_1.name or ""), StatViewNameEnum.ChineseViewName[arg_20_0.startView] or arg_20_0.startView, arg_20_0.materialName)
end

function var_0_0.isIgnoreView(arg_21_0, arg_21_1)
	return tabletool.indexOf(StatViewNameEnum.IgnoreViewList, arg_21_1) ~= nil
end

function var_0_0.isTipView(arg_22_0, arg_22_1)
	return arg_22_1 == StatViewNameEnum.MaterialTipView
end

function var_0_0.getMaterialName(arg_23_0)
	local var_23_0 = ViewMgr.instance:getContainer(StatViewNameEnum.MaterialTipView).viewParam

	return ItemConfig.instance:getItemConfig(var_23_0.type, var_23_0.id).name
end

function var_0_0.track(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	StatController.instance:track(StatEnum.EventName.EnterView, {
		[StatEnum.EventProperties.ViewName] = arg_24_1,
		[StatEnum.EventProperties.StartViewName] = arg_24_2,
		[StatEnum.EventProperties.MaterialViewName] = arg_24_3 or ""
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
