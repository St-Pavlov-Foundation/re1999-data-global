module("modules.logic.scene.fight.comp.FightSceneCardCameraComp", package.seeall)

slot0 = class("FightSceneCardCameraComp", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, slot0._onLevelLoaded, slot0)
	FightController.instance:registerCallback(FightEvent.OnStageChange, slot0._onStageChange, slot0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, slot0._stopCameraAnim, slot0)
	FightController.instance:registerCallback(FightEvent.ChangeWaveEnd, slot0._onChangeWaveEnd, slot0)
	FightController.instance:registerCallback(FightEvent.SkillEditorPlayCardCameraAni, slot0._onSkillEditorPlayCardCameraAni, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0.onSceneClose(slot0, slot1, slot2)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, slot0._onLevelLoaded, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnStageChange, slot0._onStageChange, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, slot0._stopCameraAnim, slot0)
	FightController.instance:unregisterCallback(FightEvent.ChangeWaveEnd, slot0._onChangeWaveEnd, slot0)
	FightController.instance:unregisterCallback(FightEvent.SkillEditorPlayCardCameraAni, slot0._onSkillEditorPlayCardCameraAni, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onCloseView, slot0)

	if slot0._multiLoader then
		slot0._multiLoader:dispose()

		slot0._multiLoader = nil
	end

	if slot0._editorLoader then
		slot0._editorLoader:dispose()

		slot0._editorLoader = nil
	end

	slot0._cardCameraName = nil
	slot0._path = nil
	slot0._waveId = nil
	slot0._animatorInst = nil

	if slot0._isPlaying then
		slot0._isPlaying = false
		slot3 = CameraMgr.instance:getCameraRootAnimator()
		slot3.enabled = false
		slot3.runtimeAnimatorController = nil
	end
end

function slot0._onLevelLoaded(slot0, slot1)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, slot0._onLevelLoaded, slot0)

	if slot0:_getCameraName(slot1, FightModel.instance:getCurWaveId()) ~= slot0._cardCameraName then
		slot0._cardCameraName = slot3

		if slot3 ~= "" and slot3 ~= "1" then
			slot0:_loadAnimRes()
		else
			slot0:_stopCameraAnim()
			slot0:_clearAnimRes()
		end
	end
end

function slot0._onChangeWaveEnd(slot0)
	slot0._waveId = FightModel.instance:getCurWaveId()

	if slot0:_getCameraName(GameSceneMgr.instance:getCurLevelId(), slot0._waveId) ~= slot0._cardCameraName then
		slot0._cardCameraName = slot2

		if slot2 ~= "" and slot2 ~= "1" then
			slot0:_loadAnimRes()
		else
			slot0:_stopCameraAnim()
			slot0:_clearAnimRes()
		end
	end
end

function slot0._getCameraName(slot0, slot1, slot2)
	slot4 = FightModel.instance:getFightParam() and slot3.monsterGroupIds and slot3.monsterGroupIds[slot2]
	slot5 = slot4 and lua_monster_group.configDict[slot4]
	slot6 = slot5 and slot5.stanceId
	slot7 = slot6 and lua_stance.configDict[slot6]

	if not string.nilorempty(slot7 and slot7.cardCamera) then
		return slot8
	end

	slot9 = slot3 and lua_battle.configDict[slot3.battleId]
	slot10 = slot9 and FightStrUtil.instance:getSplitToNumberCache(slot9.myStance, "#")
	slot11 = slot10 and (slot10[slot2] or slot10[#slot10])
	slot12 = slot11 and lua_stance.configDict[slot11]

	if not string.nilorempty(slot12 and slot12.cardCamera) then
		return slot13
	end

	return lua_scene_level.configDict[slot1] and slot14.cardCamera
end

function slot0._loadAnimRes(slot0)
	if not string.nilorempty(slot0._cardCameraName) then
		if "scenes/dynamic/scene_anim/" .. slot0._cardCameraName .. ".controller" == slot0._path then
			return
		end

		if slot0._multiLoader then
			slot0._multiLoader:dispose()
		end

		slot0._path = slot1
		slot0._multiLoader = MultiAbLoader.New()

		slot0._multiLoader:addPath(slot0._path)
		slot0._multiLoader:startLoad(slot0._onResLoadCallback, slot0)
	end
end

function slot0._onResLoadCallback(slot0, slot1)
	slot0._animatorInst = slot0._multiLoader:getFirstAssetItem():GetResource(slot0._path)

	slot0:_onStageChange(FightModel.instance:getCurStage())
end

function slot0._onStageChange(slot0, slot1)
	if slot0._isPlaying then
		return
	end

	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	if slot0._animatorInst and slot1 == FightEnum.Stage.Card or slot1 == FightEnum.Stage.AutoCard then
		GameSceneMgr.instance:getCurScene().camera:switchNextVirtualCamera()
		slot0:_playCameraAnim()
	end
end

function slot0._playCameraAnim(slot0)
	slot0._isPlaying = true
	slot1 = CameraMgr.instance:getCameraRootAnimator()
	slot1.enabled = true
	slot1.runtimeAnimatorController = nil
	slot1.runtimeAnimatorController = slot0._animatorInst
	slot1.speed = 1 / Time.timeScale
end

function slot0.isPlaying(slot0)
	return slot0._isPlaying
end

function slot0.stop(slot0)
	slot0._isPlaying = false
end

function slot0._clearAnimRes(slot0)
	slot0._animatorInst = nil

	if slot0._multiLoader then
		slot0._multiLoader:dispose()

		slot0._multiLoader = nil
	end
end

function slot0._stopCameraAnim(slot0)
	if not slot0._animatorInst then
		return
	end

	slot0._isPlaying = false
	slot1 = GameSceneMgr.instance:getCurScene().camera
	slot2 = slot1:getCurVirtualCamera(1)
	slot3 = slot1:getCurVirtualCamera(2)
	slot6 = gohelper.findChild(slot2.transform.parent.gameObject, "Follower" .. string.sub(slot2.name, string.len(slot2.name)))
	slot7 = gohelper.findChild(slot3.transform.parent.gameObject, "Follower" .. string.sub(slot3.name, string.len(slot3.name)))
	slot8, slot9, slot10 = transformhelper.getPos(slot6.transform)
	slot11, slot12, slot13 = transformhelper.getPos(slot7.transform)
	slot14 = CameraMgr.instance:getCameraRootAnimator()
	slot14.enabled = false
	slot14.runtimeAnimatorController = nil

	transformhelper.setPos(slot6.transform, 0, slot9, slot10)
	transformhelper.setPos(slot7.transform, 0, slot12, slot13)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.FightFocusView then
		slot0:_stopCameraAnim()
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.FightFocusView then
		if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
			return
		end

		slot0:_playCameraAnim()
	end
end

function slot0._onSkillEditorPlayCardCameraAni(slot0, slot1)
	if slot1 then
		if slot0:_getCameraName(GameSceneMgr.instance:getCurLevelId(), FightModel.instance:getCurWaveId()) ~= slot0._cardCameraName and slot4 ~= "" and slot4 ~= "1" then
			if slot0._editorLoader then
				slot0._editorLoader:dispose()

				slot0._editorLoader = nil
			end

			slot0._editorLoader = MultiAbLoader.New()

			slot0._editorLoader:addPath("scenes/dynamic/scene_anim/" .. slot4 .. ".controller")
			slot0._editorLoader:startLoad(slot0._onEditorLoaderFinish, slot0)
		else
			slot0:_playCameraAnim()
		end
	else
		slot0:_stopCameraAnim()
	end
end

function slot0._onEditorLoaderFinish(slot0)
	slot0._animatorInst = slot0._editorLoader:getFirstAssetItem():GetResource(slot0._path)

	GameSceneMgr.instance:getCurScene().camera:switchNextVirtualCamera()
	slot0:_playCameraAnim()
end

return slot0
