local var_0_0 = table.insert

module("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoBattleMapMO", package.seeall)

local var_0_1 = class("GaoSiNiaoBattleMapMO")

local function var_0_2(arg_1_0, arg_1_1)
	if arg_1_1 ~= arg_1_0._p[arg_1_1] then
		arg_1_0._p[arg_1_1] = var_0_2(arg_1_0, arg_1_0._p[arg_1_1])
	end

	return arg_1_0._p[arg_1_1]
end

local function var_0_3(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._p[var_0_2(arg_2_0, arg_2_2)] = var_0_2(arg_2_0, arg_2_1)
end

local function var_0_4(arg_3_0, arg_3_1, arg_3_2)
	return var_0_2(arg_3_0, arg_3_1) == var_0_2(arg_3_0, arg_3_2)
end

local function var_0_5(arg_4_0, arg_4_1)
	arg_4_0._p[arg_4_1] = arg_4_1
end

local function var_0_6()
	return GaoSiNiaoController.instance:config()
end

function var_0_1._dragContext(arg_6_0)
	return GaoSiNiaoBattleModel.instance:dragContext()
end

function var_0_1.isPlacedBagItem(arg_7_0, arg_7_1)
	return arg_7_0:_dragContext():isPlacedBagItem(arg_7_1)
end

function var_0_1.getPlacedBagItem(arg_8_0, arg_8_1)
	return arg_8_0:_dragContext():getPlacedBagItem(arg_8_1)
end

function var_0_1.ctor(arg_9_0)
	arg_9_0._gridList = {}
	arg_9_0._pt2BagDict = {}
	arg_9_0._p = {}
	arg_9_0._startGridList = {}
	arg_9_0._endGridList = {}
	arg_9_0._portalGridList = {}
	arg_9_0._whoActivedPortalGrid = false
	arg_9_0.__last_whoActivedPortalGrid = false
end

function var_0_1.default_ctor(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = var_0_1.New()

	var_10_0.__info = GaoSiNiaoMapInfo.New(arg_10_2 or GaoSiNiaoEnum.Version.V1_0_0)
	arg_10_0[arg_10_1] = var_10_0
end

function var_0_1.createMapByEpisodeId(arg_11_0, arg_11_1)
	local var_11_0 = var_0_6():getEpisodeCO(arg_11_1)

	arg_11_0:createMapById(var_11_0.gameId)
end

function var_0_1.createMapById(arg_12_0, arg_12_1)
	arg_12_1 = arg_12_1 or 0

	local var_12_0 = arg_12_0.__info:reset(arg_12_1)

	arg_12_0:_createMap(var_12_0)
end

function var_0_1._createMap(arg_13_0, arg_13_1)
	arg_13_0:_createGrids(arg_13_1)
	arg_13_0:_createBags(arg_13_1)
end

function var_0_1._createGrids(arg_14_0, arg_14_1)
	arg_14_0._gridList = {}
	arg_14_0._startGridList = {}
	arg_14_0._endGridList = {}
	arg_14_0._portalGridList = {}
	arg_14_0._p = {}
	arg_14_0._whoActivedPortalGrid = false
	arg_14_0.__last_whoActivedPortalGrid = false

	if not arg_14_1.gridList then
		return
	end

	var_0_1.s_foreachGrid(arg_14_1.width, arg_14_1.height, function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = arg_14_1.gridList[arg_15_0]
		local var_15_1 = {
			arg_15_1,
			arg_15_2
		}
		local var_15_2 = GaoSiNiaoMapGrid.New(arg_14_0, var_15_1, var_15_0)

		var_15_2:setId(arg_15_0)

		arg_14_0._gridList[arg_15_0] = var_15_2
		arg_14_0._p[arg_15_0] = arg_15_0

		if var_15_2:isStart() then
			var_0_0(arg_14_0._startGridList, var_15_2)
		elseif var_15_2:isEnd() then
			var_0_0(arg_14_0._endGridList, var_15_2)
		elseif var_15_2:isPortal() then
			var_0_0(arg_14_0._portalGridList, var_15_2)
		end
	end)
	arg_14_0:foreachGrid(function(arg_16_0)
		arg_16_0:setDistanceToStartByStartGrid(arg_14_0._startGridList[1])
	end)
	arg_14_0:tryMergeAll()
end

function var_0_1._createBags(arg_17_0, arg_17_1)
	arg_17_0._pt2BagDict = {}

	if not arg_17_1.bagList then
		return
	end

	for iter_17_0, iter_17_1 in ipairs(arg_17_1.bagList) do
		local var_17_0 = iter_17_1.ptype
		local var_17_1 = iter_17_1.count

		if not arg_17_0._pt2BagDict[var_17_0] then
			arg_17_0._pt2BagDict[var_17_0] = GaoSiNiaoMapBag.New(arg_17_0, var_17_0, var_17_1)
		else
			arg_17_0._pt2BagDict[var_17_0]:addCnt(var_17_1)
		end
	end
end

function var_0_1.tryMergeAll(arg_18_0, arg_18_1)
	arg_18_0._tmpPortalConnedInfoList = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._startGridList) do
		arg_18_0:_refreshUnionFind_Impl(iter_18_1)
	end

	arg_18_1 = arg_18_1 or arg_18_0:gridDataList()

	arg_18_0:_tryMergeAll_AppendPortal(arg_18_1)
	table.sort(arg_18_1, function(arg_19_0, arg_19_1)
		local var_19_0 = arg_19_0:isPortal() and 1 or 0
		local var_19_1 = arg_19_1:isPortal() and 1 or 0

		if var_19_0 ~= var_19_1 then
			return var_19_0 < var_19_1
		end

		local var_19_2 = arg_19_0:distanceToStart()
		local var_19_3 = arg_19_1:distanceToStart()

		if var_19_2 ~= var_19_3 then
			return var_19_2 < var_19_3
		end

		return arg_19_0:id() < arg_19_1:id()
	end)

	local var_18_0 = {}

	for iter_18_2, iter_18_3 in ipairs(arg_18_1) do
		if not var_18_0[iter_18_3] then
			var_18_0[iter_18_3] = true

			arg_18_0:_refreshUnionFind_Impl(iter_18_3)
		end
	end

	arg_18_0:_onPostTryMergeAll()
end

function var_0_1._tryMergeAll_AppendPortal(arg_20_0, arg_20_1)
	if arg_20_0:isActivedPortal() then
		return
	end

	local var_20_0 = arg_20_0.__last_whoActivedPortalGrid

	arg_20_0.__last_whoActivedPortalGrid = false

	for iter_20_0, iter_20_1 in ipairs(arg_20_0._portalGridList) do
		if not iter_20_1:isRoot() then
			var_0_5(arg_20_0, iter_20_1:id())
		end

		if arg_20_0:isConnedStart(iter_20_1) then
			if var_20_0 and arg_20_0:isConned(iter_20_1, var_20_0) then
				local var_20_1 = var_20_0:getRelativeZoneMask(iter_20_1)

				if var_20_1 ~= GaoSiNiaoEnum.ZoneMask.None then
					var_0_0(arg_20_0._tmpPortalConnedInfoList, {
						owner = var_20_0,
						portalGrid = iter_20_1,
						relativeZoneMask = var_20_1
					})

					var_20_0 = false
				end
			end

			local var_20_2 = iter_20_1:getNeighborGridList()

			for iter_20_2 = 1, 4 do
				local var_20_3 = var_20_2[iter_20_2]
				local var_20_4 = GaoSiNiaoEnum.bitPos2Dir(iter_20_2 - 1)

				if var_20_3 and arg_20_0:isConned(iter_20_1, var_20_3) then
					var_0_0(arg_20_0._tmpPortalConnedInfoList, {
						owner = var_20_3,
						portalGrid = iter_20_1,
						relativeZoneMask = GaoSiNiaoEnum.flipDir(var_20_4)
					})
				end
			end
		end

		var_0_0(arg_20_1, iter_20_1)
	end
end

function var_0_1._onPostTryMergeAll(arg_21_0)
	if next(arg_21_0._tmpPortalConnedInfoList) then
		if not arg_21_0:isActivedPortal() then
			for iter_21_0, iter_21_1 in ipairs(arg_21_0._tmpPortalConnedInfoList) do
				if arg_21_0:isConnedStart(iter_21_1.owner) then
					arg_21_0:onActivePortals(iter_21_1.owner, iter_21_1.portalGrid, iter_21_1.relativeZoneMask)

					break
				end
			end
		end

		arg_21_0._tmpPortalConnedInfoList = nil
	end

	if arg_21_0:isActivedPortal() then
		for iter_21_2, iter_21_3 in ipairs(arg_21_0._portalGridList) do
			arg_21_0:_refreshUnionFind_Impl(iter_21_3, true)
		end
	end
end

function var_0_1._mergeNeighborIfNotConned_Impl(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	if not arg_22_2 then
		return
	end

	if arg_22_0:isConned(arg_22_1, arg_22_2) then
		return
	end

	if not arg_22_1:_internal_tryConnNeighbor(arg_22_2, arg_22_3) then
		return
	end

	if not arg_22_0:isActivedPortal() and (arg_22_1:isPortal() or arg_22_2:isPortal()) then
		arg_22_0:_mergeNeighborPortalIfNotConned_Impl(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	else
		arg_22_0:merge(arg_22_1, arg_22_2)
	end
end

function var_0_1._mergeNeighborPortalIfNotConned_Impl(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if arg_23_0:isActivedPortal() then
		return
	end

	if arg_23_2:isPortal() then
		arg_23_0:_savePortalConnIfNotConned(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	elseif arg_23_1:isPortal() then
		arg_23_0:_savePortalConnIfNotConned(arg_23_2, arg_23_1, GaoSiNiaoEnum.flipDir(arg_23_3), arg_23_4)
	end
end

function var_0_1._savePortalConnIfNotConned(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	if arg_24_0:isConnedStart(arg_24_1) then
		arg_24_0:onActivePortals(arg_24_1, arg_24_2, arg_24_3)
	elseif not arg_24_4 then
		var_0_0(arg_24_0._tmpPortalConnedInfoList, {
			owner = arg_24_1,
			portalGrid = arg_24_2,
			relativeZoneMask = arg_24_3
		})
	end
end

function var_0_1.whoActivedPortalGrid(arg_25_0)
	return arg_25_0._whoActivedPortalGrid
end

function var_0_1.isActivedPortal(arg_26_0)
	return arg_26_0._whoActivedPortalGrid and true or false
end

function var_0_1.onActivePortals(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	assert(arg_27_2:isPortal())

	arg_27_0._whoActivedPortalGrid = arg_27_1

	arg_27_0:merge(arg_27_1, arg_27_2)
	arg_27_2:set_forceInZoneMask(arg_27_3)
	arg_27_2:set_forceOutZoneMask(GaoSiNiaoEnum.ZoneMask.None)

	for iter_27_0, iter_27_1 in ipairs(arg_27_0._portalGridList) do
		if iter_27_1 ~= arg_27_2 then
			iter_27_1:set_forceInZoneMask(GaoSiNiaoEnum.flipDir(arg_27_3))
			iter_27_1:set_forceOutZoneMask(arg_27_3)
			arg_27_0:merge(arg_27_1, iter_27_1)

			break
		end
	end
end

function var_0_1.onDisactivePortals(arg_28_0)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0._portalGridList) do
		iter_28_1:set_forceInZoneMask(false)
		iter_28_1:set_forceOutZoneMask(false)
	end

	if arg_28_0.__last_whoActivedPortalGrid == false then
		arg_28_0.__last_whoActivedPortalGrid = arg_28_0._whoActivedPortalGrid
	end

	arg_28_0._whoActivedPortalGrid = false
end

function var_0_1._refreshUnionFind_Impl(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_1:getNeighborGridList()

	for iter_29_0, iter_29_1 in ipairs(var_29_0) do
		local var_29_1 = GaoSiNiaoEnum.bitPos2Dir(iter_29_0 - 1)

		arg_29_0:_mergeNeighborIfNotConned_Impl(arg_29_1, iter_29_1, var_29_1, arg_29_2)
	end
end

function var_0_1.bagList(arg_30_0)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in pairs(arg_30_0._pt2BagDict or {}) do
		var_0_0(var_30_0, iter_30_1)
	end

	table.sort(var_30_0, function(arg_31_0, arg_31_1)
		return arg_31_0.type < arg_31_1.type
	end)

	return var_30_0
end

function var_0_1.gridDataList(arg_32_0)
	local var_32_0 = {}

	arg_32_0:foreachGrid(function(arg_33_0)
		var_0_0(var_32_0, arg_33_0)
	end)

	return var_32_0
end

function var_0_1.mapId(arg_34_0)
	return arg_34_0.__info.mapId
end

function var_0_1.mapSize(arg_35_0)
	return arg_35_0.__info:mapSize()
end

function var_0_1.rowCol(arg_36_0)
	local var_36_0, var_36_1 = arg_36_0:mapSize()

	return var_36_1, var_36_0
end

function var_0_1.getGrid(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0, var_37_1 = arg_37_0:mapSize()

	if arg_37_1 < 0 or arg_37_2 < 0 or var_37_0 <= arg_37_1 or var_37_1 <= arg_37_2 then
		return nil
	end

	return arg_37_0._gridList[arg_37_2 * var_37_0 + arg_37_1]
end

function var_0_1.foreachGrid(arg_38_0, arg_38_1)
	local var_38_0, var_38_1 = arg_38_0:mapSize()

	var_0_1.s_foreachGrid(var_38_0, var_38_1, function(arg_39_0, arg_39_1, arg_39_2)
		arg_38_1(arg_38_0._gridList[arg_39_0], arg_39_0, arg_39_1, arg_39_2)
	end)
end

function var_0_1.isConnedStart(arg_40_0, arg_40_1)
	if #arg_40_0._startGridList == 0 then
		return false
	end

	for iter_40_0, iter_40_1 in ipairs(arg_40_0._startGridList) do
		if arg_40_0:isConned(arg_40_1, iter_40_1) then
			return true
		end
	end

	return false
end

function var_0_1.isCompleted(arg_41_0)
	local var_41_0 = #arg_41_0._endGridList

	if var_41_0 == 0 then
		logError("Invalid Map")

		return false
	end

	for iter_41_0, iter_41_1 in ipairs(arg_41_0._endGridList) do
		if arg_41_0:isConnedStart(iter_41_1) then
			var_41_0 = var_41_0 - 1
		end
	end

	return var_41_0 == 0
end

function var_0_1.merge(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_1:id()
	local var_42_1 = arg_42_2:id()

	if arg_42_0:rootIsStart(arg_42_2) then
		var_0_3(arg_42_0, var_42_1, var_42_0)
	elseif arg_42_0:rootIsEnd(arg_42_1) then
		var_0_3(arg_42_0, var_42_1, var_42_0)
	else
		var_0_3(arg_42_0, var_42_0, var_42_1)
	end
end

function var_0_1.isConned(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_1:id()
	local var_43_1 = arg_43_2:id()

	return var_0_4(arg_43_0, var_43_0, var_43_1)
end

function var_0_1.rootId(arg_44_0, arg_44_1)
	return var_0_2(arg_44_0, arg_44_1:id())
end

function var_0_1.rootIsStart(arg_45_0, arg_45_1)
	for iter_45_0, iter_45_1 in ipairs(arg_45_0._startGridList) do
		if arg_45_0:rootId(arg_45_1) == iter_45_1:id() then
			return true
		end
	end

	return false
end

function var_0_1.rootIsEnd(arg_46_0, arg_46_1)
	for iter_46_0, iter_46_1 in ipairs(arg_46_0._endGridList) do
		if arg_46_0:rootId(arg_46_1) == iter_46_1:id() then
			return true
		end
	end

	return false
end

function var_0_1.single(arg_47_0, arg_47_1, arg_47_2)
	if type(arg_47_1) ~= "table" then
		return {}
	end

	if #arg_47_1 == 0 then
		return {}
	end

	local var_47_0 = 1
	local var_47_1 = 0
	local var_47_2 = {}

	local function var_47_3()
		local var_48_0 = var_47_2[var_47_0]

		var_47_0 = var_47_0 + 1

		return var_48_0
	end

	local function var_47_4(arg_49_0)
		var_47_1 = var_47_1 + 1
		var_47_2[var_47_1] = arg_49_0
	end

	local var_47_5 = {}
	local var_47_6 = false
	local var_47_7 = {}

	for iter_47_0, iter_47_1 in ipairs(arg_47_1) do
		local var_47_8 = iter_47_1:id()
		local var_47_9 = arg_47_0:rootId(iter_47_1)

		var_47_5[var_47_9] = true
		var_47_5[var_47_8] = true

		if arg_47_0:isConnedStart(iter_47_1) then
			var_47_6 = true
		end

		var_47_4(iter_47_1)

		var_47_7[var_47_9] = true
		var_47_7[iter_47_1:id()] = true
	end

	arg_47_0:foreachGrid(function(arg_50_0)
		if not var_47_7[arg_50_0:id()] and var_47_5[arg_47_0:rootId(arg_50_0)] then
			var_47_4(arg_50_0)

			var_47_7[arg_50_0:id()] = true
		end
	end)

	local var_47_10 = {}

	for iter_47_2, iter_47_3 in ipairs(arg_47_0._startGridList) do
		var_47_10[iter_47_3] = true

		if var_47_6 then
			var_47_5[arg_47_0:rootId(iter_47_3)] = true

			var_0_5(arg_47_0, iter_47_3:id())
		end
	end

	if arg_47_0:isActivedPortal() then
		arg_47_0:onDisactivePortals()

		for iter_47_4, iter_47_5 in ipairs(arg_47_0._portalGridList) do
			if not var_47_7[iter_47_5:id()] then
				var_47_4(iter_47_5)

				var_47_7[iter_47_5:id()] = true
			end
		end
	end

	local var_47_11 = {}

	while var_47_0 <= var_47_1 do
		local var_47_12 = var_47_3()

		var_47_10[var_47_12] = true

		for iter_47_6 = 1, 4 do
			local var_47_13 = var_47_12:x() + GaoSiNiaoEnum.dX[iter_47_6]
			local var_47_14 = var_47_12:y() + GaoSiNiaoEnum.dY[iter_47_6]
			local var_47_15 = arg_47_0:getGrid(var_47_13, var_47_14)

			if var_47_15 and not var_47_10[var_47_15] and var_47_5[arg_47_0:rootId(var_47_15)] then
				var_47_4(var_47_15)
			end
		end

		var_0_5(arg_47_0, var_47_12:id())
		var_0_0(var_47_11, var_47_12)
	end

	if not arg_47_2 then
		arg_47_0:tryMergeAll(var_47_11)
	end

	return var_47_11
end

function var_0_1.s_foreachGrid(arg_51_0, arg_51_1, arg_51_2)
	assert(type(arg_51_2) == "function")

	if arg_51_0 <= 0 or arg_51_1 <= 0 then
		return
	end

	local var_51_0 = 0
	local var_51_1 = 0

	while var_51_0 < arg_51_1 do
		local var_51_2 = 0

		while var_51_2 < arg_51_0 do
			arg_51_2(var_51_1, var_51_2, var_51_0)

			var_51_1 = var_51_1 + 1
			var_51_2 = var_51_2 + 1
		end

		var_51_0 = var_51_0 + 1
	end
end

return var_0_1
