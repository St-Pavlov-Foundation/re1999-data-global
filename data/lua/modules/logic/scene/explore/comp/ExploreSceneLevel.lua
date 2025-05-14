module("modules.logic.scene.explore.comp.ExploreSceneLevel", package.seeall)

local var_0_0 = class("ExploreSceneLevel", CommonSceneLevelComp)

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

	arg_3_0._resPath = ResUrl.getExploreSceneLevelUrl(arg_3_1)

	loadAbAsset(arg_3_0._resPath, false, arg_3_0._onLoadCallback, arg_3_0)
end

return var_0_0
