module("modules.logic.scene.shelter.comp.SurvivalShelterSceneLevel", package.seeall)

local var_0_0 = class("SurvivalShelterSceneLevel", CommonSceneLevelComp)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:loadLevel(arg_1_2)
end

function var_0_0.onSceneStart(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._sceneId = arg_2_1
	arg_2_0._levelId = arg_2_2
end

function var_0_0.loadLevel(arg_3_0, arg_3_1)
	if arg_3_0._isLoadingRes then
		logError("is loading scene level res, cur id = " .. (arg_3_0._levelId or "nil") .. ", try to load id = " .. (arg_3_1 or "nil"))

		return
	end

	if arg_3_0._assetItem then
		gohelper.destroy(arg_3_0._instGO)
		arg_3_0._assetItem:Release()

		arg_3_0._assetItem = nil
		arg_3_0._instGO = nil
	end

	arg_3_0._isLoadingRes = true
	arg_3_0._levelId = arg_3_1

	arg_3_0:getCurScene():setCurLevelId(arg_3_0._levelId)

	arg_3_0._resPath = ResUrl.getSurvivalSceneLevelUrl(arg_3_1)

	loadAbAsset(arg_3_0._resPath, false, arg_3_0._onLoadCallback, arg_3_0)
end

function var_0_0._onLoadCallback(arg_4_0, arg_4_1)
	var_0_0.super._onLoadCallback(arg_4_0, arg_4_1)

	if not arg_4_0._instGO then
		return
	end

	arg_4_0:loadLightGo()
end

function var_0_0.getLightName(arg_5_0)
	return "light3"
end

function var_0_0.loadLightGo(arg_6_0)
	local var_6_0 = arg_6_0:getLightName()

	if not var_6_0 then
		return
	end

	local var_6_1 = "survival/common/light/" .. var_6_0 .. ".prefab"

	if not arg_6_0._lightLoader then
		local var_6_2 = gohelper.create3d(arg_6_0._instGO, "Light")

		arg_6_0._lightLoader = PrefabInstantiate.Create(var_6_2)
	end

	arg_6_0._lightLoader:dispose()
	arg_6_0._lightLoader:startLoad(var_6_1)
end

function var_0_0.onSceneClose(arg_7_0)
	if arg_7_0._lightLoader then
		arg_7_0._lightLoader:dispose()

		arg_7_0._lightLoader = nil
	end

	var_0_0.super.onSceneClose(arg_7_0)
end

return var_0_0
