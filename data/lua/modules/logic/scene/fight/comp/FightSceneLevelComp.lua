module("modules.logic.scene.fight.comp.FightSceneLevelComp", package.seeall)

slot0 = class("FightSceneLevelComp", CommonSceneLevelComp)
slot1 = "scenes/common/vx_prefabs/vx_sceneswitch.prefab"
slot2 = 2.5

function slot0.onSceneStart(slot0, slot1, slot2)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, slot0._onLevelLoaded, slot0)
	FightController.instance:registerCallback(FightEvent.OnRestartFightDisposeDone, slot0._onRestartFightDisposeDone, slot0)
	uv0.super.onSceneStart(slot0, slot1, slot2, slot0._onLoadFailed)
end

function slot0._onLoadFailed(slot0)
	logError(string.format("战斗场景加载失败,sceneId:%s, levelId:%s, 加载策划指定的场景10801", slot0._sceneId, slot0._levelId))
	uv0.super.onSceneStart(slot0, 10801, 10801)
end

function slot0.onSceneClose(slot0)
	uv0.super.onSceneClose(slot0)
	TaskDispatcher.cancelTask(slot0._tick, slot0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, slot0._onLevelLoaded, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartFightDisposeDone, slot0._onRestartFightDisposeDone, slot0)

	slot0._frontRendererList = nil
	slot0._sceneFrontGO = nil

	slot0:_releaseTween()
	TaskDispatcher.cancelTask(slot0._onSwitchSceneFinish, slot0)

	if slot0._switchAssetItem then
		slot0._switchAssetItem:Release()

		slot0._switchAssetItem = nil

		gohelper.destroy(slot0._switchGO)

		slot0._switchGO = nil
	end

	if slot0._oldAssetItem then
		slot0._oldAssetItem:Release()

		slot0._oldAssetItem = nil
	end

	if slot0._oldInstGO then
		gohelper.destroy(slot0._oldInstGO)

		slot0._oldInstGO = nil
	end

	slot0:_disposeLoader()
end

function slot0._disposeLoader(slot0)
	if slot0._multiLoader then
		slot0._multiLoader:dispose()

		slot0._multiLoader = nil
	end
end

function slot0.loadLevelNoEffect(slot0, slot1)
	if slot0._isLoadingRes then
		logError("is loading scene level res, cur id = " .. (slot0._levelId or "nil") .. ", try to load id = " .. (slot1 or "nil"))

		return
	end

	if FightReplayModel.instance:isReplay() then
		TaskDispatcher.runRepeat(slot0._tick, slot0, 1, 10)
	end

	if slot0._assetItem then
		slot0._assetItem:Release()

		slot0._assetItem = nil
	end

	slot0._oldInstGO = slot0._instGO
	slot0._isLoadingRes = true
	slot0._levelId = slot1

	slot0:getCurScene():setCurLevelId(slot0._levelId)

	slot0._resPath = ResUrl.getSceneLevelUrl(slot1)

	slot0:_disposeLoader()

	slot0._multiLoader = MultiAbLoader.New()

	slot0._multiLoader:addPath(slot0._resPath)
	slot0._multiLoader:startLoad(slot0._onLoadNoEffectFinish, slot0)
end

function slot0._onLoadNoEffectFinish(slot0, slot1)
	slot0:_onLoadCallback(slot0._multiLoader:getAssetItem(slot0._resPath))
	gohelper.destroy(slot0._oldInstGO)

	slot0._oldInstGO = nil
end

function slot0.loadLevelWithSwitchEffect(slot0, slot1)
	if slot0._isLoadingRes then
		logError("is loading scene level res, cur id = " .. (slot0._levelId or "nil") .. ", try to load id = " .. (slot1 or "nil"))

		return
	end

	if FightReplayModel.instance:isReplay() then
		TaskDispatcher.runRepeat(slot0._tick, slot0, 1, 10)
	end

	slot0._oldInstGO = slot0._instGO
	slot0._oldAssetItem = slot0._assetItem
	slot0._isLoadingRes = true
	slot0._levelId = slot1

	slot0:getCurScene():setCurLevelId(slot0._levelId)

	slot0._resPath = ResUrl.getSceneLevelUrl(slot1)

	slot0:_disposeLoader()

	slot0._multiLoader = MultiAbLoader.New()

	slot0._multiLoader:addPath(uv0)
	slot0._multiLoader:addPath(slot0._resPath)
	slot0._multiLoader:startLoad(slot0._onSwitchResLoadCallback, slot0)
end

function slot0._tick(slot0)
	FightController.instance:dispatchEvent(FightEvent.ReplayTick)
end

function slot0._onSwitchResLoadCallback(slot0, slot1)
	slot0._switchAssetItem = slot0._multiLoader:getAssetItem(uv0)

	slot0._switchAssetItem:Retain()

	slot0._switchGO = gohelper.clone(slot0._switchAssetItem:GetResource(uv0), slot0:getCurScene():getSceneContainerGO())
	slot0._assetItem = slot0._multiLoader:getAssetItem(slot0._resPath)

	slot0._assetItem:Retain()

	slot0._instGO = gohelper.clone(slot0._assetItem:GetResource(slot0._resPath), gohelper.findChild(slot0._switchGO, "scene_former"))

	gohelper.addChild(gohelper.findChild(slot0._switchGO, "scene_latter"), slot0._oldInstGO)
	TaskDispatcher.runDelay(slot0._onSwitchSceneFinish, slot0, uv1)
	slot0._multiLoader:dispose()

	slot0._multiLoader = nil
	slot0._isLoadingRes = false

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_scene_switching)
end

function slot0._onSwitchSceneFinish(slot0)
	TaskDispatcher.cancelTask(slot0._tick, slot0)
	gohelper.addChild(slot0:getCurScene():getSceneContainerGO(), slot0._instGO)

	if slot0._switchAssetItem then
		slot0._switchAssetItem:Release()

		slot0._switchAssetItem = nil

		gohelper.destroy(slot0._switchGO)

		slot0._switchGO = nil
	end

	if slot0._oldAssetItem then
		slot0._oldAssetItem:Release()

		slot0._oldAssetItem = nil

		gohelper.destroy(slot0._oldInstGO)

		slot0._oldInstGO = nil
	end

	slot0:dispatchEvent(CommonSceneLevelComp.OnLevelLoaded, slot0._levelId)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.OnLevelLoaded, slot0._levelId)
	logNormal(string.format("load scene level finish: %s %d level_%d", SceneType.NameDict[GameSceneMgr.instance:getCurSceneType()], slot0._sceneId or -1, slot0._levelId or -1))
	slot0:getCurScene().camera:setSceneCameraOffset()
end

function slot0._onLevelLoaded(slot0, slot1)
	slot0._frontRendererList = nil
	slot0._sceneFrontGO = nil

	slot0:_releaseTween()

	slot2 = CameraMgr.instance:getSceneRoot()

	gohelper.addChild(gohelper.findChild(slot0:getCurScene():getSceneContainerGO(), "Scene"), slot0:getSceneGo())
end

function slot0.setFrontVisible(slot0, slot1)
	if slot0._frontRendererList and slot0._visible == slot1 then
		return
	end

	slot0:_releaseTween()

	slot0._visible = slot1

	if not slot0._frontRendererList then
		slot0._frontRendererList = {}

		slot0:_gatherFrontRenderers()
	end

	if slot0._frontRendererList then
		slot2 = slot1 and 1 or 0
		slot3 = slot1 and 0 or 1
		slot4 = slot1 and 0.4 or 0.25

		if slot0._visible then
			gohelper.setActive(slot0._sceneFrontGO, slot0._visible)
		end

		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot2, slot3, slot4, slot0._frameCallback, slot0._finishCallback, slot0)
	end
end

function slot0._frameCallback(slot0, slot1)
	if not slot0._frontRendererList then
		return
	end

	for slot5, slot6 in ipairs(slot0._frontRendererList) do
		slot6.material:SetFloat(ShaderPropertyId.FrontSceneAlpha, slot1)
	end
end

function slot0._finishCallback(slot0)
	if not slot0._visible then
		gohelper.setActive(slot0._sceneFrontGO, slot0._visible)
	end

	slot0:_releaseTween()
end

function slot0._releaseTween(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0._gatherFrontRenderers(slot0)
	slot0._sceneFrontGO = gohelper.findChild(slot0:getSceneGo(), "StandStill/Obj-Plant/front")

	if slot0._sceneFrontGO and slot0._sceneFrontGO.activeSelf and slot0._sceneFrontGO:GetComponentsInChildren(typeof(UnityEngine.Renderer), true) then
		slot3 = slot2:GetEnumerator()

		while slot3:MoveNext() do
			table.insert(slot0._frontRendererList, slot3.Current)
		end
	end
end

function slot0._onRestartFightDisposeDone(slot0)
	if slot0._sceneId == 17501 and slot0:getSceneGo() then
		if gohelper.findChildComponent(slot1, "StandStill/Obj-Plant/near/v1a3_scene_kme_blue01/scene_kme_blue01_1", typeof(UnityEngine.Animator)) then
			slot2.speed = FightModel.instance:getSpeed()

			slot2:Play("v1a3_scene_kme_blue01_chuxian", 0, 0)
		end

		if gohelper.findChildComponent(slot1, "StandStill/Obj-Plant/near/v1a3_scene_kme_green_04/scene_kme_green_04_1", typeof(UnityEngine.Animator)) then
			slot2.speed = FightModel.instance:getSpeed()

			slot2:Play("v1a3_scene_kme_green_04_chuxian", 0, 0)
		end

		if gohelper.findChildComponent(slot1, "StandStill/Obj-Plant/near/v1a3_scene_kme_orange_02/scene_kme_orange_02", typeof(UnityEngine.Animator)) then
			slot2.speed = FightModel.instance:getSpeed()

			slot2:Play("v1a3_scene_kme_orange_02_chuxian", 0, 0)
		end

		if gohelper.findChildComponent(slot1, "StandStill/Obj-Plant/near/v1a3_scene_kme_red_03/scene_kme_red_03_1", typeof(UnityEngine.Animator)) then
			slot2.speed = FightModel.instance:getSpeed()

			slot2:Play("v1a3_scene_kme_red_03_chuxian", 0, 0)
		end

		if gohelper.findChildComponent(slot1, "StandStill/Obj-Plant/near/v1a3_scene_kme_yellow_05/scene_kme_yellow_05_1", typeof(UnityEngine.Animator)) then
			slot2.speed = FightModel.instance:getSpeed()

			slot2:Play("v1a3_scene_kme_yellow_05_chuxian", 0, 0)
		end

		if gohelper.findChildComponent(slot1, "SceneEffect/ScreenBroken", typeof(UnityEngine.Animator)) then
			slot2.speed = FightModel.instance:getSpeed()

			slot2:Play("New State", 0, 0)
		end
	end
end

function slot0._onSkillPlayStart(slot0, slot1, slot2)
	if slot2 == 0 then
		return
	end

	slot0._skillCounter = slot0._skillCounter or 0
	slot0._skillCounter = slot0._skillCounter + 1

	if slot0._sceneEffectsObj then
		for slot6, slot7 in ipairs(slot0._sceneEffectsObj) do
			gohelper.setActive(slot7, false)
		end
	end
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2)
	if slot2 == 0 then
		return
	end

	slot0._skillCounter = (slot0._skillCounter or 1) - 1

	if slot0._skillCounter < 0 then
		slot0._skillCounter = 0
	end

	if slot0._skillCounter > 0 then
		return
	end

	if slot0._sceneEffectsObj then
		for slot6, slot7 in ipairs(slot0._sceneEffectsObj) do
			gohelper.setActive(slot7, true)
		end
	end
end

function slot0._onRestartStageBefore(slot0)
	slot0._skillCounter = 0
end

return slot0
