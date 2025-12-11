module("modules.logic.scene.cachot.comp.CachotSceneLevel", package.seeall)

local var_0_0 = class("CachotSceneLevel", CommonSceneLevelComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._eventTrs = {}

	var_0_0.super.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
end

function var_0_0.switchLevel(arg_2_0, arg_2_1)
	if arg_2_1 == arg_2_0._levelId then
		if not arg_2_0._isLoadingRes then
			arg_2_0:dispatchEvent(CommonSceneLevelComp.OnLevelLoaded, arg_2_0._levelId)
			GameSceneMgr.instance:dispatchEvent(SceneEventName.OnLevelLoaded, arg_2_0._levelId)
		end

		return
	end

	if arg_2_0._isLoadingRes then
		arg_2_0._levelId = nil
		arg_2_0._isLoadingRes = nil

		removeAssetLoadCb(arg_2_0._resPath, arg_2_0._onLoadCallback, arg_2_0)
	end

	arg_2_0._eventTrs = {}

	arg_2_0:loadLevel(arg_2_1)
end

function var_0_0._onLoadCallback(arg_3_0, arg_3_1)
	arg_3_0._isLoadingRes = false

	if arg_3_1.IsLoadSuccess then
		local var_3_0 = arg_3_0._assetItem

		arg_3_0._assetItem = arg_3_1

		arg_3_0._assetItem:Retain()

		if var_3_0 then
			var_3_0:Release()
		end

		local var_3_1 = arg_3_0:getCurScene():getSceneContainerGO()

		arg_3_0._instGO = gohelper.clone(arg_3_0._assetItem:GetResource(arg_3_0._resPath), var_3_1, "CachotLevel")

		local var_3_2 = arg_3_0._instGO

		for iter_3_0 = 1, 3 do
			local var_3_3 = gohelper.findChild(var_3_2, "Obj-Plant/event/" .. iter_3_0)

			if not var_3_3 then
				var_3_3 = gohelper.create3d(gohelper.findChild(var_3_2, "Obj-Plant"), tostring(iter_3_0))

				if iter_3_0 == 1 then
					var_3_3.transform.localPosition = Vector3.New(28, -7, 1)
				elseif iter_3_0 == 2 then
					var_3_3.transform.localPosition = Vector3.New(32, -7, 1)
				elseif iter_3_0 == 3 then
					var_3_3.transform.localPosition = Vector3.New(36, -7, 1)
				end
			end

			arg_3_0._eventTrs[iter_3_0] = var_3_3.transform
		end

		arg_3_0:dispatchEvent(CommonSceneLevelComp.OnLevelLoaded, arg_3_0._levelId)
		GameSceneMgr.instance:dispatchEvent(SceneEventName.OnLevelLoaded, arg_3_0._levelId)

		local var_3_4 = SceneType.NameDict[GameSceneMgr.instance:getCurSceneType()]
		local var_3_5 = arg_3_0._sceneId or -1
		local var_3_6 = arg_3_0._levelId or -1

		logNormal(string.format("load scene level finish: %s %d level_%d", var_3_4, var_3_5, var_3_6))
	else
		logError("load scene level fail, level_" .. (arg_3_0._levelId or "nil"))
	end
end

function var_0_0.getEventTr(arg_4_0, arg_4_1)
	return arg_4_0._eventTrs[arg_4_1]
end

function var_0_0.onSceneClose(arg_5_0)
	arg_5_0._eventTrs = {}

	var_0_0.super.onSceneClose(arg_5_0)
end

return var_0_0
