module("modules.logic.scene.main.comp.MainSceneLevelComp", package.seeall)

local var_0_0 = class("MainSceneLevelComp", CommonSceneLevelComp)

function var_0_0.loadLevel(arg_1_0, arg_1_1)
	if arg_1_0._isLoadingRes then
		logError("is loading scene level res, cur id = " .. (arg_1_0._levelId or "nil") .. ", try to load id = " .. (arg_1_1 or "nil"))

		return
	end

	if arg_1_0._assetItem then
		gohelper.destroy(arg_1_0._instGO)
		arg_1_0._assetItem:Release()

		arg_1_0._assetItem = nil
		arg_1_0._instGO = nil

		arg_1_0:releaseSceneEffectsLoader()
	end

	arg_1_0._isLoadingRes = true
	arg_1_0._levelId = arg_1_1

	arg_1_0:getCurScene():setCurLevelId(arg_1_0._levelId)
	MainSceneSwitchModel.instance:initSceneId()

	local var_1_0 = MainSceneSwitchModel.instance:getCurSceneResName()

	arg_1_0._resPath = ResUrl.getSceneRes(var_1_0)

	loadAbAsset(arg_1_0._resPath, false, arg_1_0._onLoadCallback, arg_1_0)
end

function var_0_0.switchLevel(arg_2_0)
	arg_2_0:loadLevel(arg_2_0._levelId)
end

return var_0_0
