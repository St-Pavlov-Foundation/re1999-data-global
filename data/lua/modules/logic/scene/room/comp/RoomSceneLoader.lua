module("modules.logic.scene.room.comp.RoomSceneLoader", package.seeall)

local var_0_0 = class("RoomSceneLoader", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._assetItemDict = {}
	arg_1_0._loader = nil
	arg_1_0._needLoadList = {}
	arg_1_0._needLoadDict = {}
	arg_1_0._callbackList = {}
	arg_1_0._loaderList = {}
	arg_1_0._initialized = false
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._initialized = true
end

function var_0_0.isLoaderInProgress(arg_3_0)
	if arg_3_0._loader then
		return true
	end

	if arg_3_0._needLoadList and #arg_3_0._needLoadList > 0 then
		return true
	end

	return false
end

function var_0_0.makeSureLoaded(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_0._initialized then
		return
	end

	local var_4_0
	local var_4_1 = arg_4_0:getCurScene().preloader

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if not var_4_1:exist(iter_4_1) then
			var_4_0 = var_4_0 or {}

			table.insert(var_4_0, iter_4_1)
		end
	end

	if not var_4_0 then
		arg_4_2(arg_4_3)

		return
	end

	local var_4_2 = MultiAbLoader.New()

	table.insert(arg_4_0._loaderList, var_4_2)
	var_4_2:setPathList(var_4_0)
	var_4_2:startLoad(function(...)
		arg_4_0:_onLoadFinish(var_4_2)
		arg_4_2(arg_4_3)
	end, arg_4_0)
end

function var_0_0._delayStartLoad(arg_6_0)
	local var_6_0 = arg_6_0._needLoadList

	arg_6_0._needLoadList = {}
	arg_6_0._needLoadDict = {}
	arg_6_0._loader = MultiAbLoader.New()

	arg_6_0._loader:setPathList(var_6_0)
	arg_6_0._loader:startLoad(arg_6_0._onLoadFinish, arg_6_0)
end

function var_0_0._onLoadFinish(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getAssetItemDict()
	local var_7_1 = arg_7_0:getCurScene().preloader

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		var_7_1:addAssetItem(iter_7_0, iter_7_1)
	end

	tabletool.removeValue(arg_7_0._loaderList, arg_7_1)
	arg_7_1:dispose()
end

function var_0_0.onSceneClose(arg_8_0)
	arg_8_0._initialized = false

	TaskDispatcher.cancelTask(arg_8_0._delayStartLoad, arg_8_0)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._loaderList) do
		iter_8_1:dispose()
	end

	arg_8_0._loaderList = {}

	if arg_8_0._loader then
		arg_8_0._loader:dispose()

		arg_8_0._loader = nil
	end
end

return var_0_0
