module("modules.logic.scene.room.preloadwork.RoomPreloadBlockPackageWork", package.seeall)

local var_0_0 = class("RoomPreloadBlockPackageWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:_getMapBlockUrlList()

	arg_1_0._loader = MultiAbLoader.New()

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		arg_1_0._loader:addPath(iter_1_1)
	end

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
	logError("RoomPreloadBlockPackageWork: 加载失败, url: " .. arg_3_2.ResPath)
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
	local var_5_2 = {}
	local var_5_3 = {}
	local var_5_4 = RoomMapBlockModel.instance:getFullBlockMOList()

	for iter_5_0, iter_5_1 in ipairs(var_5_4) do
		local var_5_5 = iter_5_1.defineId
		local var_5_6 = RoomResHelper.getBlockPath(var_5_5)
		local var_5_7 = RoomResHelper.getBlockABPath(var_5_5)

		var_5_2[var_5_6] = true
		var_5_3[var_5_7] = true
		arg_5_0.context.resABDict[var_5_6] = var_5_7
	end

	for iter_5_2, iter_5_3 in pairs(var_5_2) do
		table.insert(var_5_0, iter_5_2)
	end

	for iter_5_4, iter_5_5 in pairs(var_5_3) do
		table.insert(var_5_1, iter_5_4)
	end

	for iter_5_6, iter_5_7 in ipairs(var_5_0) do
		arg_5_0.context.poolGODict[iter_5_7] = 0
	end

	return var_5_1
end

return var_0_0
