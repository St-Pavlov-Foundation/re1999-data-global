local var_0_0 = {
	DungeonView = function(arg_1_0)
		table.insert(arg_1_0, "ui/spriteassets/dungeon.asset")
		table.insert(arg_1_0, "singlebg/dungeon/full/bg1.png")
	end,
	DungeonMapView = function(arg_2_0)
		DungeonModel.instance.jumpEpisodeId = nil
	end,
	VersionActivityDungeonMapView = function(arg_3_0)
		DungeonModel.instance.jumpEpisodeId = nil
	end,
	SeasonMainView = function(arg_4_0)
		return
	end,
	VersionActivity2_8BossStoryEyeView = function(arg_5_0)
		local var_5_0 = FightHelper.getCameraAniPath(VersionActivity2_8BossStoryEyeView.camerControllerPath)

		table.insert(arg_5_0, var_5_0)
	end
}

function var_0_0.DungeonViewPreload(arg_6_0)
	local var_6_0 = {}

	table.insert(var_6_0, "ui/viewres/dungeon/dungeonview.prefab")
	var_0_0._startLoad(var_6_0, arg_6_0)
end

function var_0_0.VersionActivity2_8BossStoryEnterView(arg_7_0)
	local var_7_0 = VersionActivity2_8BossStorySceneView.getMap()

	table.insert(arg_7_0, string.format("scenes/%s.prefab", var_7_0.res))
end

function var_0_0.VersionActivity2_8BossActEnterView(arg_8_0)
	local var_8_0 = VersionActivity2_8BossActSceneView.getMap()

	table.insert(arg_8_0, string.format("scenes/%s.prefab", var_8_0.res))
end

function var_0_0.WeekWalkLayerViewPreload(arg_9_0)
	local var_9_0 = var_0_0._getResPathList(ViewName.WeekWalkLayerView)
	local var_9_1, var_9_2 = WeekWalkModel.instance:getInfo():getNotFinishedMap()

	if var_9_1.id <= 105 then
		table.insert(var_9_0, ResUrl.getWeekWalkLayerIcon("full/bg_choose_shallow_1"))
	elseif var_9_1.id <= 205 then
		table.insert(var_9_0, ResUrl.getWeekWalkLayerIcon("full/bg_choose_shallow_2"))
	else
		table.insert(var_9_0, ResUrl.getWeekWalkLayerIcon("full/bg_choose_deep"))
	end

	var_0_0._startLoad(var_9_0, arg_9_0)
end

function var_0_0.WeekWalk_2HeartLayerViewPreload(arg_10_0)
	local var_10_0 = var_0_0._getResPathList(ViewName.WeekWalk_2HeartLayerView)

	var_0_0._startLoad(var_10_0, arg_10_0)
end

function var_0_0.StoreViewPreload(arg_11_0)
	local var_11_0 = {}

	table.insert(var_11_0, module_views.StoreView.mainRes)
	var_0_0._startLoad(var_11_0, arg_11_0)
end

function var_0_0.TaskView(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(module_views.TaskView.tabRes[2]) do
		table.insert(arg_12_0, iter_12_1[1])
	end
end

function var_0_0.DungeonViewGold(arg_13_0)
	local var_13_0 = {}

	table.insert(var_13_0, "singlebg/dungeon/full/bg123.png")
	var_0_0._startLoad(var_13_0, arg_13_0)
end

function var_0_0.DungeonViewBreak(arg_14_0)
	local var_14_0 = {}

	table.insert(var_14_0, "singlebg/dungeon/full/bg123.png")
	var_0_0._startLoad(var_14_0, arg_14_0)
end

function var_0_0.DungeonViewWeekWalk(arg_15_0)
	local var_15_0 = {}

	table.insert(var_15_0, "ui/viewres/dungeon/dungeonweekwalkview.prefab")
	var_0_0._startLoad(var_15_0, arg_15_0)
end

function var_0_0.DungeonViewExplore(arg_16_0)
	local var_16_0 = {}

	table.insert(var_16_0, DungeonEnum.dungeonexploreviewPath)
	var_0_0._startLoad(var_16_0, arg_16_0)
end

function var_0_0.ExploreArchivesView(arg_17_0)
	local var_17_0 = 1401
	local var_17_1 = ViewMgr.instance:getContainer(ViewName.ExploreArchivesView)

	if var_17_1 and var_17_1.viewParam then
		var_17_0 = var_17_1.viewParam.id
	end

	table.insert(arg_17_0, string.format("ui/viewres/explore/explorearchivechapter%d.prefab", var_17_0))
end

function var_0_0.preloadMultiView(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_2) do
		local var_18_1 = var_0_0._getResPathList(iter_18_1)

		for iter_18_2, iter_18_3 in ipairs(var_18_1) do
			table.insert(var_18_0, iter_18_3)
		end
	end

	if arg_18_3 then
		for iter_18_4, iter_18_5 in ipairs(arg_18_3) do
			table.insert(var_18_0, iter_18_5)
		end
	end

	var_0_0._startLoad(var_18_0, arg_18_0, arg_18_1)
end

function var_0_0.DungeonChapterAndLevelView(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = {}
	local var_19_1 = var_0_0._getResPathList(ViewName.DungeonMapView)

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		table.insert(var_19_0, iter_19_1)
	end

	if arg_19_2 then
		local var_19_2 = var_0_0._getResPathList(arg_19_2)

		for iter_19_2, iter_19_3 in ipairs(var_19_2) do
			table.insert(var_19_0, iter_19_3)
		end
	end

	var_0_0._startLoad(var_19_0, arg_19_0)
end

function var_0_0.CharacterDataVoiceView(arg_20_0)
	local var_20_0 = {}

	table.insert(var_20_0, ResUrl.getCharacterDataIcon("full/bg_di_004.png"))
	table.insert(var_20_0, "ui/viewres/character/characterdata/characterdatavoiceview.prefab")
	var_0_0._startLoad(var_20_0, arg_20_0)
end

function var_0_0.CharacterDataItemView(arg_21_0)
	local var_21_0 = {}

	table.insert(var_21_0, ResUrl.getCharacterDataIcon("full/bg_tingyongdi_006.png"))
	table.insert(var_21_0, "ui/viewres/character/characterdata/characterdataitemview.prefab")
	var_0_0._startLoad(var_21_0, arg_21_0)
end

function var_0_0.CharacterDataCultureView(arg_22_0)
	local var_22_0 = {}

	table.insert(var_22_0, ResUrl.getCharacterDataIcon("full/bg_di_004.png"))
	table.insert(var_22_0, "ui/viewres/character/characterdata/characterdatacultureview.prefab")
	var_0_0._startLoad(var_22_0, arg_22_0)
end

function var_0_0.CharacterBackpackView(arg_23_0)
	table.insert(arg_23_0, "ui/viewres/common/item/commonheroitemnew.prefab")
end

function var_0_0.FightLoadingView(arg_24_0)
	local var_24_0 = {}

	table.insert(var_24_0, "ui/viewres/fight/fightloadingview.prefab")
	var_0_0._startLoad(var_24_0, arg_24_0)
end

function var_0_0.BpViewPreLoad(arg_25_0)
	local var_25_0 = {}

	if BpModel.instance.firstShow then
		table.insert(var_25_0, "ui/viewres/battlepass/bpvideoview.prefab")
	end

	var_0_0._startLoad(var_25_0, arg_25_0)
end

function var_0_0.BpView(arg_26_0)
	local var_26_0 = BpConfig.instance:getBpCO(BpModel.instance.id)

	if var_26_0 and var_26_0.isSp then
		local var_26_1 = ViewMgr.instance:getSetting(ViewName.BpSPView)

		if var_26_1 then
			if var_26_1.mainRes then
				table.insert(arg_26_0, var_26_1.mainRes)
			end

			if var_26_1.otherRes then
				for iter_26_0, iter_26_1 in pairs(var_26_1.otherRes) do
					table.insert(arg_26_0, iter_26_1)
				end
			end
		end
	end
end

function var_0_0.BpSPView(arg_27_0)
	local var_27_0 = ViewMgr.instance:getSetting(ViewName.BpView)

	if var_27_0 then
		if var_27_0.mainRes then
			table.insert(arg_27_0, var_27_0.mainRes)
		end

		if var_27_0.otherRes then
			for iter_27_0, iter_27_1 in pairs(var_27_0.otherRes) do
				table.insert(arg_27_0, iter_27_1)
			end
		end
	end
end

function var_0_0.SummonADView(arg_28_0)
	local var_28_0 = SummonMainController.instance:getCurPoolPreloadRes()

	if #var_28_0 > 0 then
		for iter_28_0, iter_28_1 in ipairs(var_28_0) do
			table.insert(arg_28_0, iter_28_1)
		end
	end
end

function var_0_0.EliminateLevelView(arg_29_0)
	local var_29_0 = EliminateLevelController.instance:getCurLevelNeedPreloadRes()

	if #var_29_0 > 0 then
		for iter_29_0, iter_29_1 in ipairs(var_29_0) do
			table.insert(arg_29_0, iter_29_1)
		end
	end
end

function var_0_0.V1a4_BossRushLevelDetail(arg_30_0)
	local var_30_0 = ViewMgr.instance:getContainer(ViewName.V1a4_BossRushLevelDetail)
	local var_30_1 = var_30_0 and var_30_0.viewParam

	if not var_30_1 then
		return
	end

	local var_30_2 = var_30_1.stage
	local var_30_3 = BossRushConfig.instance:getMonsterResPathList(var_30_2)

	for iter_30_0, iter_30_1 in ipairs(var_30_3) do
		table.insert(arg_30_0, iter_30_1)
	end

	table.insert(arg_30_0, BossRushConfig.instance:getBossRushLevelDetailFullBgSimage(var_30_2))
end

function var_0_0.VersionActivity2_7DungeonMapView(arg_31_0)
	local var_31_0 = VersionActivity2_7DungeonEnum.SpaceScene

	table.insert(arg_31_0, var_31_0)
end

function var_0_0.OptionalChargeView(arg_32_0)
	local var_32_0 = {
		"ui/viewres/store/optionalgiftview.prefab"
	}

	var_0_0._startLoad(var_32_0, arg_32_0)
end

function var_0_0.CommandStationMapView(arg_33_0)
	return
end

function var_0_0.CommandStationMapViewPreload(arg_34_0)
	CommandStationMapModel.instance:initTimeId()

	local var_34_0 = CommandStationMapModel.instance:getCurTimeIdScene()

	if not var_34_0 then
		return
	end

	local var_34_1 = var_0_0._getResPathList(ViewName.CommandStationMapView)

	table.insert(var_34_1, var_34_0.scene)
	var_0_0._startLoad(var_34_1, arg_34_0)
end

function var_0_0.Season166MainView(arg_35_0)
	local var_35_0 = Season166Model.instance:getCurSeasonId()
	local var_35_1 = Season166Config.instance:getSeasonConstStr(var_35_0, Season166Enum.MainSceneUrl)

	if var_35_1 then
		table.insert(arg_35_0, var_35_1)
	end
end

function var_0_0.V2a3_WarmUp(arg_36_0)
	local var_36_0 = ViewMgr.instance:getContainer(ViewName.V2a3_WarmUp)

	if not var_36_0 then
		return
	end

	local var_36_1 = var_36_0:getEpisodeCount()

	for iter_36_0 = 1, var_36_1 do
		local var_36_2 = var_36_0:getImgResUrl(iter_36_0)

		table.insert(arg_36_0, var_36_2)
	end
end

function var_0_0.MainUISwitchInfoBlurMaskView(arg_37_0)
	local var_37_0 = {}

	table.insert(var_37_0, "ui/viewres/mainsceneswitch/mainuiswitchblurmaskview.prefab")
	var_0_0._startLoad(var_37_0, arg_37_0)
end

function var_0_0.MainUISwitchInfoView(arg_38_0)
	local var_38_0 = {}

	table.insert(var_38_0, "ui/viewres/mainsceneswitch/mainsuiswitchinfoview.prefab")
	table.insert(var_38_0, "ui/viewres/mainsceneswitch/mainuiswitchblurmask.prefab")
	table.insert(var_38_0, "ui/viewres/main/mainview.prefab")
	var_0_0._startLoad(var_38_0, arg_38_0)
end

local var_0_1 = {}

function var_0_0._startLoad(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = MultiAbLoader.New()

	var_0_1[var_39_0] = true

	UIBlockMgr.instance:startBlock("ui_preload")
	var_39_0:setPathList(arg_39_0)
	var_39_0:startLoad(function()
		var_0_1[var_39_0] = nil

		UIBlockMgr.instance:endBlock("ui_preload")
		var_39_0:dispose()
		arg_39_1(arg_39_2)
	end)
end

function var_0_0.stopPreload()
	for iter_41_0, iter_41_1 in pairs(var_0_1) do
		iter_41_0:dispose()
		logNormal("module_views_preloader dispose loader")
	end

	var_0_1 = {}
end

function var_0_0._getResPathList(arg_42_0)
	local var_42_0 = {}
	local var_42_1 = ViewMgr.instance:getSetting(arg_42_0)

	if var_42_1.mainRes then
		table.insert(var_42_0, var_42_1.mainRes)
	end

	if var_42_1.otherRes then
		for iter_42_0, iter_42_1 in pairs(var_42_1.otherRes) do
			table.insert(var_42_0, iter_42_1)
		end
	end

	if var_42_1.tabRes then
		for iter_42_2, iter_42_3 in pairs(var_42_1.tabRes) do
			for iter_42_4, iter_42_5 in pairs(iter_42_3) do
				for iter_42_6, iter_42_7 in pairs(iter_42_5) do
					table.insert(var_42_0, iter_42_7)
				end
			end
		end
	end

	if var_42_1.anim and var_42_1.anim ~= ViewAnim.Default and string.find(var_42_1.anim, ".controller") then
		table.insert(var_42_0, var_42_1.anim)
	end

	return var_42_0
end

function var_0_0.VersionActivityEnterView(arg_43_0)
	local var_43_0 = ViewMgr.instance:getContainer(ViewName.VersionActivityEnterView)

	if not var_43_0 then
		return
	end

	local var_43_1 = var_43_0:getPreLoaderResPathList()

	for iter_43_0, iter_43_1 in ipairs(var_43_1) do
		table.insert(arg_43_0, iter_43_1)
	end
end

return var_0_0
