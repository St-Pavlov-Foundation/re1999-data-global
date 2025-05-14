module("modules.logic.scene.room.preloadwork.RoomPreloadAnimWork", package.seeall)

local var_0_0 = class("RoomPreloadAnimWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:_getAnimUrlList()

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
	logError("RoomPreloadAnimWork: 加载失败, url: " .. arg_3_2.ResPath)
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._loader then
		arg_4_0._loader:dispose()

		arg_4_0._loader = nil
	end
end

function var_0_0._getAnimUrlList(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(RoomScenePreloader.ResAnim) do
		table.insert(var_5_0, iter_5_1)
	end

	return var_5_0
end

return var_0_0
