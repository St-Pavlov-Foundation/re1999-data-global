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
	end
}

function var_0_0.DungeonViewPreload(arg_5_0)
	local var_5_0 = {}

	table.insert(var_5_0, "ui/viewres/dungeon/dungeonview.prefab")
	var_0_0._startLoad(var_5_0, arg_5_0)
end

function var_0_0.WeekWalkLayerViewPreload(arg_6_0)
	local var_6_0 = var_0_0._getResPathList(ViewName.WeekWalkLayerView)
	local var_6_1, var_6_2 = WeekWalkModel.instance:getInfo():getNotFinishedMap()

	if var_6_1.id <= 105 then
		table.insert(var_6_0, ResUrl.getWeekWalkLayerIcon("full/bg_choose_shallow_1"))
	elseif var_6_1.id <= 205 then
		table.insert(var_6_0, ResUrl.getWeekWalkLayerIcon("full/bg_choose_shallow_2"))
	else
		table.insert(var_6_0, ResUrl.getWeekWalkLayerIcon("full/bg_choose_deep"))
	end

	var_0_0._startLoad(var_6_0, arg_6_0)
end

function var_0_0.WeekWalk_2HeartLayerViewPreload(arg_7_0)
	local var_7_0 = var_0_0._getResPathList(ViewName.WeekWalk_2HeartLayerView)

	var_0_0._startLoad(var_7_0, arg_7_0)
end

function var_0_0.StoreViewPreload(arg_8_0)
	local var_8_0 = {}

	table.insert(var_8_0, module_views.StoreView.mainRes)
	var_0_0._startLoad(var_8_0, arg_8_0)
end

function var_0_0.TaskView(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(module_views.TaskView.tabRes[2]) do
		table.insert(arg_9_0, iter_9_1[1])
	end
end

function var_0_0.DungeonViewGold(arg_10_0)
	local var_10_0 = {}

	table.insert(var_10_0, "singlebg/dungeon/full/bg123.png")
	var_0_0._startLoad(var_10_0, arg_10_0)
end

function var_0_0.DungeonViewBreak(arg_11_0)
	local var_11_0 = {}

	table.insert(var_11_0, "singlebg/dungeon/full/bg123.png")
	var_0_0._startLoad(var_11_0, arg_11_0)
end

function var_0_0.DungeonViewWeekWalk(arg_12_0)
	local var_12_0 = {}

	table.insert(var_12_0, "ui/viewres/dungeon/dungeonweekwalkview.prefab")
	var_0_0._startLoad(var_12_0, arg_12_0)
end

function var_0_0.DungeonViewExplore(arg_13_0)
	local var_13_0 = {}

	table.insert(var_13_0, DungeonEnum.dungeonexploreviewPath)
	var_0_0._startLoad(var_13_0, arg_13_0)
end

function var_0_0.ExploreArchivesView(arg_14_0)
	local var_14_0 = 1401
	local var_14_1 = ViewMgr.instance:getContainer(ViewName.ExploreArchivesView)

	if var_14_1 and var_14_1.viewParam then
		var_14_0 = var_14_1.viewParam.id
	end

	table.insert(arg_14_0, string.format("ui/viewres/explore/explorearchivechapter%d.prefab", var_14_0))
end

function var_0_0.preloadMultiView(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_2) do
		local var_15_1 = var_0_0._getResPathList(iter_15_1)

		for iter_15_2, iter_15_3 in ipairs(var_15_1) do
			table.insert(var_15_0, iter_15_3)
		end
	end

	if arg_15_3 then
		for iter_15_4, iter_15_5 in ipairs(arg_15_3) do
			table.insert(var_15_0, iter_15_5)
		end
	end

	var_0_0._startLoad(var_15_0, arg_15_0, arg_15_1)
end

function var_0_0.DungeonChapterAndLevelView(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = {}
	local var_16_1 = var_0_0._getResPathList(ViewName.DungeonMapView)

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		table.insert(var_16_0, iter_16_1)
	end

	if arg_16_2 then
		local var_16_2 = var_0_0._getResPathList(arg_16_2)

		for iter_16_2, iter_16_3 in ipairs(var_16_2) do
			table.insert(var_16_0, iter_16_3)
		end
	end

	var_0_0._startLoad(var_16_0, arg_16_0)
end

function var_0_0.CharacterDataVoiceView(arg_17_0)
	local var_17_0 = {}

	table.insert(var_17_0, ResUrl.getCharacterDataIcon("full/bg_di_004.png"))
	table.insert(var_17_0, "ui/viewres/character/characterdata/characterdatavoiceview.prefab")
	var_0_0._startLoad(var_17_0, arg_17_0)
end

function var_0_0.CharacterDataItemView(arg_18_0)
	local var_18_0 = {}

	table.insert(var_18_0, ResUrl.getCharacterDataIcon("full/bg_tingyongdi_006.png"))
	table.insert(var_18_0, "ui/viewres/character/characterdata/characterdataitemview.prefab")
	var_0_0._startLoad(var_18_0, arg_18_0)
end

function var_0_0.CharacterDataCultureView(arg_19_0)
	local var_19_0 = {}

	table.insert(var_19_0, ResUrl.getCharacterDataIcon("full/bg_di_004.png"))
	table.insert(var_19_0, "ui/viewres/character/characterdata/characterdatacultureview.prefab")
	var_0_0._startLoad(var_19_0, arg_19_0)
end

function var_0_0.CharacterBackpackView(arg_20_0)
	table.insert(arg_20_0, "ui/viewres/common/item/commonheroitemnew.prefab")
end

function var_0_0.FightLoadingView(arg_21_0)
	local var_21_0 = {}

	table.insert(var_21_0, "ui/viewres/fight/fightloadingview.prefab")
	var_0_0._startLoad(var_21_0, arg_21_0)
end

function var_0_0.BpViewPreLoad(arg_22_0)
	local var_22_0 = {}

	if BpModel.instance.firstShow then
		table.insert(var_22_0, "ui/viewres/battlepass/bpvideoview.prefab")
	end

	var_0_0._startLoad(var_22_0, arg_22_0)
end

function var_0_0.BpView(arg_23_0)
	local var_23_0 = BpConfig.instance:getBpCO(BpModel.instance.id)

	if var_23_0 and var_23_0.isSp then
		local var_23_1 = ViewMgr.instance:getSetting(ViewName.BpSPView)

		if var_23_1 then
			if var_23_1.mainRes then
				table.insert(arg_23_0, var_23_1.mainRes)
			end

			if var_23_1.otherRes then
				for iter_23_0, iter_23_1 in pairs(var_23_1.otherRes) do
					table.insert(arg_23_0, iter_23_1)
				end
			end
		end
	end
end

function var_0_0.BpSPView(arg_24_0)
	local var_24_0 = ViewMgr.instance:getSetting(ViewName.BpView)

	if var_24_0 then
		if var_24_0.mainRes then
			table.insert(arg_24_0, var_24_0.mainRes)
		end

		if var_24_0.otherRes then
			for iter_24_0, iter_24_1 in pairs(var_24_0.otherRes) do
				table.insert(arg_24_0, iter_24_1)
			end
		end
	end
end

function var_0_0.SummonADView(arg_25_0)
	local var_25_0 = SummonMainController.instance:getCurPoolPreloadRes()

	if #var_25_0 > 0 then
		for iter_25_0, iter_25_1 in ipairs(var_25_0) do
			table.insert(arg_25_0, iter_25_1)
		end
	end
end

function var_0_0.EliminateLevelView(arg_26_0)
	local var_26_0 = EliminateLevelController.instance:getCurLevelNeedPreloadRes()

	if #var_26_0 > 0 then
		for iter_26_0, iter_26_1 in ipairs(var_26_0) do
			table.insert(arg_26_0, iter_26_1)
		end
	end
end

function var_0_0.V1a4_BossRushLevelDetail(arg_27_0)
	local var_27_0 = ViewMgr.instance:getContainer(ViewName.V1a4_BossRushLevelDetail)
	local var_27_1 = var_27_0 and var_27_0.viewParam

	if not var_27_1 then
		return
	end

	local var_27_2 = var_27_1.stage
	local var_27_3 = BossRushConfig.instance:getMonsterResPathList(var_27_2)

	for iter_27_0, iter_27_1 in ipairs(var_27_3) do
		table.insert(arg_27_0, iter_27_1)
	end

	table.insert(arg_27_0, BossRushConfig.instance:getBossRushLevelDetailFullBgSimage(var_27_2))
end

function var_0_0.OptionalChargeView(arg_28_0)
	local var_28_0 = {
		"ui/viewres/store/optionalgiftview.prefab"
	}

	var_0_0._startLoad(var_28_0, arg_28_0)
end

function var_0_0.Season166MainView(arg_29_0)
	local var_29_0 = Season166Model.instance:getCurSeasonId()
	local var_29_1 = Season166Config.instance:getSeasonConstStr(var_29_0, Season166Enum.MainSceneUrl)

	if var_29_1 then
		table.insert(arg_29_0, var_29_1)
	end
end

function var_0_0.V2a3_WarmUp(arg_30_0)
	local var_30_0 = ViewMgr.instance:getContainer(ViewName.V2a3_WarmUp)

	if not var_30_0 then
		return
	end

	local var_30_1 = var_30_0:getEpisodeCount()

	for iter_30_0 = 1, var_30_1 do
		local var_30_2 = var_30_0:getImgResUrl(iter_30_0)

		table.insert(arg_30_0, var_30_2)
	end
end

local var_0_1 = {}

function var_0_0._startLoad(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = MultiAbLoader.New()

	var_0_1[var_31_0] = true

	UIBlockMgr.instance:startBlock("ui_preload")
	var_31_0:setPathList(arg_31_0)
	var_31_0:startLoad(function()
		var_0_1[var_31_0] = nil

		UIBlockMgr.instance:endBlock("ui_preload")
		var_31_0:dispose()
		arg_31_1(arg_31_2)
	end)
end

function var_0_0.stopPreload()
	for iter_33_0, iter_33_1 in pairs(var_0_1) do
		iter_33_0:dispose()
		logNormal("module_views_preloader dispose loader")
	end

	var_0_1 = {}
end

function var_0_0._getResPathList(arg_34_0)
	local var_34_0 = {}
	local var_34_1 = ViewMgr.instance:getSetting(arg_34_0)

	if var_34_1.mainRes then
		table.insert(var_34_0, var_34_1.mainRes)
	end

	if var_34_1.otherRes then
		for iter_34_0, iter_34_1 in pairs(var_34_1.otherRes) do
			table.insert(var_34_0, iter_34_1)
		end
	end

	if var_34_1.tabRes then
		for iter_34_2, iter_34_3 in pairs(var_34_1.tabRes) do
			for iter_34_4, iter_34_5 in pairs(iter_34_3) do
				for iter_34_6, iter_34_7 in pairs(iter_34_5) do
					table.insert(var_34_0, iter_34_7)
				end
			end
		end
	end

	if var_34_1.anim and var_34_1.anim ~= ViewAnim.Default and string.find(var_34_1.anim, ".controller") then
		table.insert(var_34_0, var_34_1.anim)
	end

	return var_34_0
end

function var_0_0.VersionActivityEnterView(arg_35_0)
	local var_35_0 = ViewMgr.instance:getContainer(ViewName.VersionActivityEnterView)

	if not var_35_0 then
		return
	end

	local var_35_1 = var_35_0:getPreLoaderResPathList()

	for iter_35_0, iter_35_1 in ipairs(var_35_1) do
		table.insert(arg_35_0, iter_35_1)
	end
end

return var_0_0
