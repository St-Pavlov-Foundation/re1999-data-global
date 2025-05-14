module("modules.logic.scene.fight.comp.FightSceneLevelComp", package.seeall)

local var_0_0 = class("FightSceneLevelComp", CommonSceneLevelComp)
local var_0_1 = "scenes/common/vx_prefabs/vx_sceneswitch.prefab"
local var_0_2 = 2.5

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, arg_1_0._onLevelLoaded, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnRestartFightDisposeDone, arg_1_0._onRestartFightDisposeDone, arg_1_0)
	var_0_0.super.onSceneStart(arg_1_0, arg_1_1, arg_1_2, arg_1_0._onLoadFailed)
end

function var_0_0._onLoadFailed(arg_2_0)
	logError(string.format("战斗场景加载失败,sceneId:%s, levelId:%s, 加载策划指定的场景10801", arg_2_0._sceneId, arg_2_0._levelId))
	var_0_0.super.onSceneStart(arg_2_0, 10801, 10801)
end

function var_0_0.onSceneClose(arg_3_0)
	var_0_0.super.onSceneClose(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._tick, arg_3_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, arg_3_0._onLevelLoaded, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartFightDisposeDone, arg_3_0._onRestartFightDisposeDone, arg_3_0)

	arg_3_0._frontRendererList = nil
	arg_3_0._sceneFrontGO = nil

	arg_3_0:_releaseTween()
	TaskDispatcher.cancelTask(arg_3_0._onSwitchSceneFinish, arg_3_0)

	if arg_3_0._switchAssetItem then
		arg_3_0._switchAssetItem:Release()

		arg_3_0._switchAssetItem = nil

		gohelper.destroy(arg_3_0._switchGO)

		arg_3_0._switchGO = nil
	end

	if arg_3_0._oldAssetItem then
		arg_3_0._oldAssetItem:Release()

		arg_3_0._oldAssetItem = nil
	end

	if arg_3_0._oldInstGO then
		gohelper.destroy(arg_3_0._oldInstGO)

		arg_3_0._oldInstGO = nil
	end

	arg_3_0:_disposeLoader()
end

function var_0_0._disposeLoader(arg_4_0)
	if arg_4_0._multiLoader then
		arg_4_0._multiLoader:dispose()

		arg_4_0._multiLoader = nil
	end
end

function var_0_0.loadLevelNoEffect(arg_5_0, arg_5_1)
	if arg_5_0._isLoadingRes then
		logError("is loading scene level res, cur id = " .. (arg_5_0._levelId or "nil") .. ", try to load id = " .. (arg_5_1 or "nil"))

		return
	end

	if FightReplayModel.instance:isReplay() then
		TaskDispatcher.runRepeat(arg_5_0._tick, arg_5_0, 1, 10)
	end

	if arg_5_0._assetItem then
		arg_5_0._assetItem:Release()

		arg_5_0._assetItem = nil
	end

	arg_5_0._oldInstGO = arg_5_0._instGO
	arg_5_0._isLoadingRes = true
	arg_5_0._levelId = arg_5_1

	arg_5_0:getCurScene():setCurLevelId(arg_5_0._levelId)

	arg_5_0._resPath = ResUrl.getSceneLevelUrl(arg_5_1)

	arg_5_0:_disposeLoader()

	arg_5_0._multiLoader = MultiAbLoader.New()

	arg_5_0._multiLoader:addPath(arg_5_0._resPath)
	arg_5_0._multiLoader:startLoad(arg_5_0._onLoadNoEffectFinish, arg_5_0)
end

function var_0_0._onLoadNoEffectFinish(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._multiLoader:getAssetItem(arg_6_0._resPath)

	arg_6_0:_onLoadCallback(var_6_0)
	gohelper.destroy(arg_6_0._oldInstGO)

	arg_6_0._oldInstGO = nil
end

function var_0_0.loadLevelWithSwitchEffect(arg_7_0, arg_7_1)
	if arg_7_0._isLoadingRes then
		logError("is loading scene level res, cur id = " .. (arg_7_0._levelId or "nil") .. ", try to load id = " .. (arg_7_1 or "nil"))

		return
	end

	if FightReplayModel.instance:isReplay() then
		TaskDispatcher.runRepeat(arg_7_0._tick, arg_7_0, 1, 10)
	end

	arg_7_0._oldInstGO = arg_7_0._instGO
	arg_7_0._oldAssetItem = arg_7_0._assetItem
	arg_7_0._isLoadingRes = true
	arg_7_0._levelId = arg_7_1

	arg_7_0:getCurScene():setCurLevelId(arg_7_0._levelId)

	arg_7_0._resPath = ResUrl.getSceneLevelUrl(arg_7_1)

	arg_7_0:_disposeLoader()

	arg_7_0._multiLoader = MultiAbLoader.New()

	arg_7_0._multiLoader:addPath(var_0_1)
	arg_7_0._multiLoader:addPath(arg_7_0._resPath)
	arg_7_0._multiLoader:startLoad(arg_7_0._onSwitchResLoadCallback, arg_7_0)
end

function var_0_0._tick(arg_8_0)
	FightController.instance:dispatchEvent(FightEvent.ReplayTick)
end

function var_0_0._onSwitchResLoadCallback(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getCurScene():getSceneContainerGO()

	arg_9_0._switchAssetItem = arg_9_0._multiLoader:getAssetItem(var_0_1)

	arg_9_0._switchAssetItem:Retain()

	arg_9_0._switchGO = gohelper.clone(arg_9_0._switchAssetItem:GetResource(var_0_1), var_9_0)

	local var_9_1 = gohelper.findChild(arg_9_0._switchGO, "scene_former")
	local var_9_2 = gohelper.findChild(arg_9_0._switchGO, "scene_latter")

	arg_9_0._assetItem = arg_9_0._multiLoader:getAssetItem(arg_9_0._resPath)

	arg_9_0._assetItem:Retain()

	arg_9_0._instGO = gohelper.clone(arg_9_0._assetItem:GetResource(arg_9_0._resPath), var_9_1)

	gohelper.addChild(var_9_2, arg_9_0._oldInstGO)
	TaskDispatcher.runDelay(arg_9_0._onSwitchSceneFinish, arg_9_0, var_0_2)
	arg_9_0._multiLoader:dispose()

	arg_9_0._multiLoader = nil
	arg_9_0._isLoadingRes = false

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_scene_switching)
end

function var_0_0._onSwitchSceneFinish(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._tick, arg_10_0)

	local var_10_0 = arg_10_0:getCurScene():getSceneContainerGO()

	gohelper.addChild(var_10_0, arg_10_0._instGO)

	if arg_10_0._switchAssetItem then
		arg_10_0._switchAssetItem:Release()

		arg_10_0._switchAssetItem = nil

		gohelper.destroy(arg_10_0._switchGO)

		arg_10_0._switchGO = nil
	end

	if arg_10_0._oldAssetItem then
		arg_10_0._oldAssetItem:Release()

		arg_10_0._oldAssetItem = nil

		gohelper.destroy(arg_10_0._oldInstGO)

		arg_10_0._oldInstGO = nil
	end

	arg_10_0:dispatchEvent(CommonSceneLevelComp.OnLevelLoaded, arg_10_0._levelId)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.OnLevelLoaded, arg_10_0._levelId)

	local var_10_1 = SceneType.NameDict[GameSceneMgr.instance:getCurSceneType()]
	local var_10_2 = arg_10_0._sceneId or -1
	local var_10_3 = arg_10_0._levelId or -1

	logNormal(string.format("load scene level finish: %s %d level_%d", var_10_1, var_10_2, var_10_3))
	arg_10_0:getCurScene().camera:setSceneCameraOffset()
end

function var_0_0._onLevelLoaded(arg_11_0, arg_11_1)
	arg_11_0._frontRendererList = nil
	arg_11_0._sceneFrontGO = nil

	arg_11_0:_releaseTween()

	local var_11_0 = CameraMgr.instance:getSceneRoot()
	local var_11_1 = gohelper.findChild(arg_11_0:getCurScene():getSceneContainerGO(), "Scene")

	gohelper.addChild(var_11_1, arg_11_0:getSceneGo())
end

function var_0_0.setFrontVisible(arg_12_0, arg_12_1)
	if arg_12_0._frontRendererList and arg_12_0._visible == arg_12_1 then
		return
	end

	arg_12_0:_releaseTween()

	arg_12_0._visible = arg_12_1

	if not arg_12_0._frontRendererList then
		arg_12_0._frontRendererList = {}

		arg_12_0:_gatherFrontRenderers()
	end

	if arg_12_0._frontRendererList then
		local var_12_0 = arg_12_1 and 1 or 0
		local var_12_1 = arg_12_1 and 0 or 1
		local var_12_2 = arg_12_1 and 0.4 or 0.25

		if arg_12_0._visible then
			gohelper.setActive(arg_12_0._sceneFrontGO, arg_12_0._visible)
		end

		arg_12_0._tweenId = ZProj.TweenHelper.DOTweenFloat(var_12_0, var_12_1, var_12_2, arg_12_0._frameCallback, arg_12_0._finishCallback, arg_12_0)
	end
end

function var_0_0._frameCallback(arg_13_0, arg_13_1)
	if not arg_13_0._frontRendererList then
		return
	end

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._frontRendererList) do
		iter_13_1.material:SetFloat(ShaderPropertyId.FrontSceneAlpha, arg_13_1)
	end
end

function var_0_0._finishCallback(arg_14_0)
	if not arg_14_0._visible then
		gohelper.setActive(arg_14_0._sceneFrontGO, arg_14_0._visible)
	end

	arg_14_0:_releaseTween()
end

function var_0_0._releaseTween(arg_15_0)
	if arg_15_0._tweenId then
		ZProj.TweenHelper.KillById(arg_15_0._tweenId)

		arg_15_0._tweenId = nil
	end
end

function var_0_0._gatherFrontRenderers(arg_16_0)
	local var_16_0 = arg_16_0:getSceneGo()

	arg_16_0._sceneFrontGO = gohelper.findChild(var_16_0, "StandStill/Obj-Plant/front")

	if arg_16_0._sceneFrontGO and arg_16_0._sceneFrontGO.activeSelf then
		local var_16_1 = arg_16_0._sceneFrontGO:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

		if var_16_1 then
			local var_16_2 = var_16_1:GetEnumerator()

			while var_16_2:MoveNext() do
				local var_16_3 = var_16_2.Current

				table.insert(arg_16_0._frontRendererList, var_16_3)
			end
		end
	end
end

function var_0_0._onRestartFightDisposeDone(arg_17_0)
	if arg_17_0._sceneId == 17501 then
		local var_17_0 = arg_17_0:getSceneGo()

		if var_17_0 then
			local var_17_1 = gohelper.findChildComponent(var_17_0, "StandStill/Obj-Plant/near/v1a3_scene_kme_blue01/scene_kme_blue01_1", typeof(UnityEngine.Animator))

			if var_17_1 then
				var_17_1.speed = FightModel.instance:getSpeed()

				var_17_1:Play("v1a3_scene_kme_blue01_chuxian", 0, 0)
			end

			local var_17_2 = gohelper.findChildComponent(var_17_0, "StandStill/Obj-Plant/near/v1a3_scene_kme_green_04/scene_kme_green_04_1", typeof(UnityEngine.Animator))

			if var_17_2 then
				var_17_2.speed = FightModel.instance:getSpeed()

				var_17_2:Play("v1a3_scene_kme_green_04_chuxian", 0, 0)
			end

			local var_17_3 = gohelper.findChildComponent(var_17_0, "StandStill/Obj-Plant/near/v1a3_scene_kme_orange_02/scene_kme_orange_02", typeof(UnityEngine.Animator))

			if var_17_3 then
				var_17_3.speed = FightModel.instance:getSpeed()

				var_17_3:Play("v1a3_scene_kme_orange_02_chuxian", 0, 0)
			end

			local var_17_4 = gohelper.findChildComponent(var_17_0, "StandStill/Obj-Plant/near/v1a3_scene_kme_red_03/scene_kme_red_03_1", typeof(UnityEngine.Animator))

			if var_17_4 then
				var_17_4.speed = FightModel.instance:getSpeed()

				var_17_4:Play("v1a3_scene_kme_red_03_chuxian", 0, 0)
			end

			local var_17_5 = gohelper.findChildComponent(var_17_0, "StandStill/Obj-Plant/near/v1a3_scene_kme_yellow_05/scene_kme_yellow_05_1", typeof(UnityEngine.Animator))

			if var_17_5 then
				var_17_5.speed = FightModel.instance:getSpeed()

				var_17_5:Play("v1a3_scene_kme_yellow_05_chuxian", 0, 0)
			end

			local var_17_6 = gohelper.findChildComponent(var_17_0, "SceneEffect/ScreenBroken", typeof(UnityEngine.Animator))

			if var_17_6 then
				var_17_6.speed = FightModel.instance:getSpeed()

				var_17_6:Play("New State", 0, 0)
			end
		end
	end
end

function var_0_0._onSkillPlayStart(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_2 == 0 then
		return
	end

	arg_18_0._skillCounter = arg_18_0._skillCounter or 0
	arg_18_0._skillCounter = arg_18_0._skillCounter + 1

	if arg_18_0._sceneEffectsObj then
		for iter_18_0, iter_18_1 in ipairs(arg_18_0._sceneEffectsObj) do
			gohelper.setActive(iter_18_1, false)
		end
	end
end

function var_0_0._onSkillPlayFinish(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_2 == 0 then
		return
	end

	arg_19_0._skillCounter = (arg_19_0._skillCounter or 1) - 1

	if arg_19_0._skillCounter < 0 then
		arg_19_0._skillCounter = 0
	end

	if arg_19_0._skillCounter > 0 then
		return
	end

	if arg_19_0._sceneEffectsObj then
		for iter_19_0, iter_19_1 in ipairs(arg_19_0._sceneEffectsObj) do
			gohelper.setActive(iter_19_1, true)
		end
	end
end

function var_0_0._onRestartStageBefore(arg_20_0)
	arg_20_0._skillCounter = 0
end

return var_0_0
