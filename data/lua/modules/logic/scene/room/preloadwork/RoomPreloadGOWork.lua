module("modules.logic.scene.room.preloadwork.RoomPreloadGOWork", package.seeall)

local var_0_0 = class("RoomPreloadGOWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:_getUIUrlList()

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
	logError("RoomPreloadGOWork: 加载失败, url: " .. arg_3_2.ResPath)
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._loader then
		arg_4_0._loader:dispose()

		arg_4_0._loader = nil
	end
end

function var_0_0._getUIUrlList(arg_5_0)
	local var_5_0 = {}

	if RoomController.instance:isEditMode() then
		table.insert(var_5_0, RoomScenePreloader.ResEffectB)
		table.insert(var_5_0, RoomScenePreloader.ResVXPlacingHere)
		table.insert(var_5_0, RoomScenePreloader.ResSmoke)
		table.insert(var_5_0, RoomScenePreloader.ResSmokeSnow)
	end

	if RoomController.instance:isObMode() then
		table.insert(var_5_0, RoomScenePreloader.ResEffectE)
		table.insert(var_5_0, RoomScenePreloader.ResEffectD01)
		table.insert(var_5_0, RoomScenePreloader.ResEffectD02)
		table.insert(var_5_0, RoomScenePreloader.ResEffectD05)
		table.insert(var_5_0, RoomScenePreloader.ResVXXuXian)
		table.insert(var_5_0, RoomScenePreloader.ResCharacterClickHelper)
		table.insert(var_5_0, RoomScenePreloader.ResEffectConfirmCharacter)
		table.insert(var_5_0, RoomScenePreloader.ResEffectCharacterShadow)
		table.insert(var_5_0, RoomScenePreloader.ResEffectPressingCharacter)
		table.insert(var_5_0, RoomScenePreloader.ResEffectPlaceCharacter)
		table.insert(var_5_0, RoomScenePreloader.ResCharacterFaithEffect)
	end

	if RoomController.instance:isVisitMode() then
		table.insert(var_5_0, RoomScenePreloader.ResEffectCharacterShadow)
	end

	for iter_5_0, iter_5_1 in ipairs(RoomScenePreloader.ResEffectWaveList) do
		table.insert(var_5_0, iter_5_1)
	end

	for iter_5_2, iter_5_3 in ipairs(RoomScenePreloader.ResEffectWaveWithRiverList) do
		table.insert(var_5_0, iter_5_3)
	end

	table.insert(var_5_0, RoomScenePreloader.ResOcean)

	if RoomController.instance:isDebugPackageMode() then
		for iter_5_4, iter_5_5 in pairs(RoomScenePreloader.ResDebugPackageColorDict) do
			table.insert(var_5_0, iter_5_5)
		end
	end

	for iter_5_6, iter_5_7 in ipairs(RoomScenePreloader.ResCommonList) do
		table.insert(var_5_0, iter_5_7)
	end

	table.insert(var_5_0, RoomScenePreloader.ResFogParticle)

	for iter_5_8, iter_5_9 in ipairs(var_5_0) do
		arg_5_0.context.poolGODict[iter_5_9] = 6
	end

	return var_5_0
end

return var_0_0
