module("modules.logic.scene.room.preloadwork.RoomPreloadMapBlockWork", package.seeall)

local var_0_0 = class("RoomPreloadMapBlockWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:_getMapBlockUrlList()

	arg_1_0._loader = MultiAbLoader.New()

	if GameResMgr.IsFromEditorDir then
		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			arg_1_0._loader:addPath(iter_1_1)
		end
	else
		for iter_1_2, iter_1_3 in pairs(var_1_0) do
			arg_1_0._loader:addPath(iter_1_2)
		end
	end

	local var_1_1 = tabletool.len(var_1_0)

	arg_1_0._timestamp = Time.GetTimestamp()

	arg_1_0._loader:setLoadFailCallback(arg_1_0._onPreloadOneFail)
	arg_1_0._loader:startLoad(arg_1_0._onPreloadFinish, arg_1_0)
end

function var_0_0._onPreloadFinish(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:getAssetItemDict()

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		arg_2_0.context.callback(arg_2_0.context.callbackObj, iter_2_0, iter_2_1)
	end

	arg_2_0:onDone(true)
end

function var_0_0._onPreloadOneFail(arg_3_0, arg_3_1, arg_3_2)
	logError("RoomPreloadMapBlockWork: 加载失败, url: " .. arg_3_2.ResPath)
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._loader then
		arg_4_0._loader:dispose()

		arg_4_0._loader = nil
	end
end

function var_0_0._getMapBlockUrlList(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = {}

	table.insert(var_5_0, ResUrl.getRoomRes("ground/water/water"))
	table.insert(var_5_0, RoomScenePreloader.InitLand)

	local var_5_2, var_5_3 = arg_5_0:_findDefineBlockAndWaterTypes()

	for iter_5_0 = 1, #var_5_2 do
		local var_5_4 = var_5_2[iter_5_0]

		arg_5_0:_addRiverFloorUrlByBlockType(var_5_0, RoomRiverEnum.LakeFloorType, var_5_4)
		arg_5_0:_addRiverFloorUrlByBlockType(var_5_0, RoomRiverEnum.LakeFloorBType, var_5_4)
		arg_5_0:_addRiverFloorUrlByBlockType(var_5_0, RoomRiverEnum.RiverBlockType, var_5_4)
		table.insert(var_5_0, RoomResHelper.getBlockLandPath(var_5_4, false)[1])
		table.insert(var_5_0, RoomResHelper.getBlockLandPath(var_5_4, true)[1])
	end

	for iter_5_1 = 1, #var_5_3 do
		local var_5_5 = var_5_3[iter_5_1]

		arg_5_0:_addWaterBlockUrlByWaterType(var_5_0, RoomRiverEnum.RiverBlockType, var_5_5)
		arg_5_0:_addWaterBlockUrlByWaterType(var_5_0, RoomRiverEnum.LakeBlockType, var_5_5)
	end

	local var_5_6 = RoomMapBuildingModel.instance:getBuildingMOList()

	for iter_5_2, iter_5_3 in ipairs(var_5_6) do
		table.insert(var_5_0, RoomResHelper.getBuildingPath(iter_5_3.buildingId, iter_5_3.level))
	end

	for iter_5_4, iter_5_5 in ipairs(var_5_0) do
		arg_5_0.context.poolGODict[iter_5_5] = 1
		var_5_1[iter_5_5] = 1
	end

	if GameResMgr.IsFromEditorDir then
		return var_5_0
	else
		return var_5_1
	end
end

function var_0_0._addRiverFloorUrlByBlockType(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	for iter_6_0, iter_6_1 in pairs(arg_6_2) do
		local var_6_0, var_6_1 = RoomResHelper.getMapRiverFloorResPath(iter_6_1, arg_6_3)

		table.insert(arg_6_1, var_6_1)
	end
end

function var_0_0._addWaterBlockUrlByWaterType(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	for iter_7_0, iter_7_1 in pairs(arg_7_2) do
		local var_7_0, var_7_1 = RoomResHelper.getMapBlockResPath(RoomResourceEnum.ResourceId.River, iter_7_1, arg_7_3)

		table.insert(arg_7_1, var_7_1)
	end
end

function var_0_0._findDefineBlockAndWaterTypes(arg_8_0)
	local var_8_0 = RoomMapBlockModel.instance:getFullBlockMOList()
	local var_8_1 = {}
	local var_8_2 = {}

	for iter_8_0 = 1, #var_8_0 do
		local var_8_3 = var_8_0[iter_8_0]
		local var_8_4 = var_8_3:getDefineBlockType()
		local var_8_5 = var_8_3:getDefineWaterType()

		if not tabletool.indexOf(var_8_1, var_8_4) then
			table.insert(var_8_1, var_8_4)
		end

		if not tabletool.indexOf(var_8_2, var_8_5) then
			table.insert(var_8_2, var_8_5)
		end
	end

	return var_8_1, var_8_2
end

return var_0_0
