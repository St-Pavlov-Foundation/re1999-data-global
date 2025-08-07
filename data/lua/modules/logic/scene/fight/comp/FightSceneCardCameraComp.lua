module("modules.logic.scene.fight.comp.FightSceneCardCameraComp", package.seeall)

local var_0_0 = class("FightSceneCardCameraComp", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, arg_1_0._onLevelLoaded, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnStageChange, arg_1_0._onStageChange, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, arg_1_0._stopCameraAnim, arg_1_0)
	FightController.instance:registerCallback(FightEvent.ChangeWaveEnd, arg_1_0._onChangeWaveEnd, arg_1_0)
	FightController.instance:registerCallback(FightEvent.SkillEditorPlayCardCameraAni, arg_1_0._onSkillEditorPlayCardCameraAni, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_1_0._onOpenView, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_1_0._onCloseView, arg_1_0)
	FightController.instance:registerCallback(FightEvent.StopCardCameraAnimator, arg_1_0._stopCameraAnim, arg_1_0)
end

function var_0_0.onSceneClose(arg_2_0, arg_2_1, arg_2_2)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, arg_2_0._onLevelLoaded, arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.OnStageChange, arg_2_0._onStageChange, arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, arg_2_0._stopCameraAnim, arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.ChangeWaveEnd, arg_2_0._onChangeWaveEnd, arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.SkillEditorPlayCardCameraAni, arg_2_0._onSkillEditorPlayCardCameraAni, arg_2_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.StopCardCameraAnimator, arg_2_0._stopCameraAnim, arg_2_0)

	if arg_2_0._multiLoader then
		arg_2_0._multiLoader:dispose()

		arg_2_0._multiLoader = nil
	end

	if arg_2_0._editorLoader then
		arg_2_0._editorLoader:dispose()

		arg_2_0._editorLoader = nil
	end

	arg_2_0._cardCameraName = nil
	arg_2_0._path = nil
	arg_2_0._waveId = nil
	arg_2_0._animatorInst = nil

	if arg_2_0._isPlaying then
		arg_2_0._isPlaying = false

		local var_2_0 = CameraMgr.instance:getCameraRootAnimator()

		var_2_0.enabled = false
		var_2_0.runtimeAnimatorController = nil
	end
end

function var_0_0._onLevelLoaded(arg_3_0, arg_3_1)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, arg_3_0._onLevelLoaded, arg_3_0)

	local var_3_0 = FightModel.instance:getCurWaveId()
	local var_3_1 = arg_3_0:_getCameraName(arg_3_1, var_3_0)

	if var_3_1 ~= arg_3_0._cardCameraName then
		arg_3_0._cardCameraName = var_3_1

		if var_3_1 ~= "" and var_3_1 ~= "1" then
			arg_3_0:_loadAnimRes()
		else
			arg_3_0:_stopCameraAnim()
			arg_3_0:_clearAnimRes()
		end
	end
end

function var_0_0._onChangeWaveEnd(arg_4_0)
	local var_4_0 = GameSceneMgr.instance:getCurLevelId()

	arg_4_0._waveId = FightModel.instance:getCurWaveId()

	local var_4_1 = arg_4_0:_getCameraName(var_4_0, arg_4_0._waveId)

	if var_4_1 ~= arg_4_0._cardCameraName then
		arg_4_0._cardCameraName = var_4_1

		if var_4_1 ~= "" and var_4_1 ~= "1" then
			arg_4_0:_loadAnimRes()
		else
			arg_4_0:_stopCameraAnim()
			arg_4_0:_clearAnimRes()
		end
	end
end

function var_0_0._getCameraName(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = FightModel.instance:getFightParam()
	local var_5_1 = var_5_0 and var_5_0.monsterGroupIds and var_5_0.monsterGroupIds[arg_5_2]
	local var_5_2 = var_5_1 and lua_monster_group.configDict[var_5_1]
	local var_5_3 = var_5_2 and var_5_2.stanceId
	local var_5_4 = var_5_3 and lua_stance.configDict[var_5_3]
	local var_5_5 = var_5_4 and var_5_4.cardCamera

	if not string.nilorempty(var_5_5) then
		return var_5_5
	end

	local var_5_6 = var_5_0 and lua_battle.configDict[var_5_0.battleId]
	local var_5_7 = var_5_6 and FightStrUtil.instance:getSplitToNumberCache(var_5_6.myStance, "#")
	local var_5_8 = var_5_7 and (var_5_7[arg_5_2] or var_5_7[#var_5_7])
	local var_5_9 = var_5_8 and lua_stance.configDict[var_5_8]
	local var_5_10 = var_5_9 and var_5_9.cardCamera

	if not string.nilorempty(var_5_10) then
		return var_5_10
	end

	local var_5_11 = lua_scene_level.configDict[arg_5_1]

	return var_5_11 and var_5_11.cardCamera
end

function var_0_0._loadAnimRes(arg_6_0)
	if not string.nilorempty(arg_6_0._cardCameraName) then
		local var_6_0 = "scenes/dynamic/scene_anim/" .. arg_6_0._cardCameraName .. ".controller"

		if var_6_0 == arg_6_0._path then
			return
		end

		if arg_6_0._multiLoader then
			arg_6_0._multiLoader:dispose()
		end

		arg_6_0._path = var_6_0
		arg_6_0._multiLoader = MultiAbLoader.New()

		arg_6_0._multiLoader:addPath(arg_6_0._path)
		arg_6_0._multiLoader:startLoad(arg_6_0._onResLoadCallback, arg_6_0)
	end
end

function var_0_0._onResLoadCallback(arg_7_0, arg_7_1)
	arg_7_0._animatorInst = arg_7_0._multiLoader:getFirstAssetItem():GetResource(arg_7_0._path)

	arg_7_0:_onStageChange(FightModel.instance:getCurStage())
end

function var_0_0._onStageChange(arg_8_0, arg_8_1)
	if arg_8_0._isPlaying then
		return
	end

	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	if arg_8_0._animatorInst and arg_8_1 == FightEnum.Stage.Card or arg_8_1 == FightEnum.Stage.AutoCard then
		GameSceneMgr.instance:getCurScene().camera:switchNextVirtualCamera()
		arg_8_0:_playCameraAnim()
	end
end

function var_0_0._playCameraAnim(arg_9_0)
	arg_9_0._isPlaying = true

	local var_9_0 = CameraMgr.instance:getCameraRootAnimator()

	var_9_0.enabled = true
	var_9_0.runtimeAnimatorController = nil
	var_9_0.runtimeAnimatorController = arg_9_0._animatorInst
	var_9_0.speed = 1 / Time.timeScale
end

function var_0_0.isPlaying(arg_10_0)
	return arg_10_0._isPlaying
end

function var_0_0.stop(arg_11_0)
	arg_11_0._isPlaying = false
end

function var_0_0._clearAnimRes(arg_12_0)
	arg_12_0._animatorInst = nil

	if arg_12_0._multiLoader then
		arg_12_0._multiLoader:dispose()

		arg_12_0._multiLoader = nil
	end
end

function var_0_0._stopCameraAnim(arg_13_0)
	if not arg_13_0._animatorInst then
		return
	end

	arg_13_0._isPlaying = false

	local var_13_0 = GameSceneMgr.instance:getCurScene().camera
	local var_13_1 = var_13_0:getCurVirtualCamera(1)
	local var_13_2 = var_13_0:getCurVirtualCamera(2)
	local var_13_3 = "Follower" .. string.sub(var_13_1.name, string.len(var_13_1.name))
	local var_13_4 = "Follower" .. string.sub(var_13_2.name, string.len(var_13_2.name))
	local var_13_5 = gohelper.findChild(var_13_1.transform.parent.gameObject, var_13_3)
	local var_13_6 = gohelper.findChild(var_13_2.transform.parent.gameObject, var_13_4)
	local var_13_7, var_13_8, var_13_9 = transformhelper.getPos(var_13_5.transform)
	local var_13_10, var_13_11, var_13_12 = transformhelper.getPos(var_13_6.transform)
	local var_13_13 = CameraMgr.instance:getCameraRootAnimator()

	var_13_13.enabled = false
	var_13_13.runtimeAnimatorController = nil

	transformhelper.setPos(var_13_5.transform, 0, var_13_8, var_13_9)
	transformhelper.setPos(var_13_6.transform, 0, var_13_11, var_13_12)
end

function var_0_0._onOpenView(arg_14_0, arg_14_1)
	if arg_14_1 == ViewName.FightFocusView then
		arg_14_0:_stopCameraAnim()
	end
end

function var_0_0._onCloseView(arg_15_0, arg_15_1)
	if arg_15_1 == ViewName.FightFocusView then
		if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
			return
		end

		arg_15_0:_playCameraAnim()
	end
end

function var_0_0._onSkillEditorPlayCardCameraAni(arg_16_0, arg_16_1)
	if arg_16_1 then
		local var_16_0 = GameSceneMgr.instance:getCurLevelId()
		local var_16_1 = FightModel.instance:getCurWaveId()
		local var_16_2 = arg_16_0:_getCameraName(var_16_0, var_16_1)

		if var_16_2 ~= arg_16_0._cardCameraName and var_16_2 ~= "" and var_16_2 ~= "1" then
			if arg_16_0._editorLoader then
				arg_16_0._editorLoader:dispose()

				arg_16_0._editorLoader = nil
			end

			local var_16_3 = "scenes/dynamic/scene_anim/" .. var_16_2 .. ".controller"

			arg_16_0._editorLoader = MultiAbLoader.New()

			arg_16_0._editorLoader:addPath(var_16_3)
			arg_16_0._editorLoader:startLoad(arg_16_0._onEditorLoaderFinish, arg_16_0)
		else
			arg_16_0:_playCameraAnim()
		end
	else
		arg_16_0:_stopCameraAnim()
	end
end

function var_0_0._onEditorLoaderFinish(arg_17_0)
	arg_17_0._animatorInst = arg_17_0._editorLoader:getFirstAssetItem():GetResource(arg_17_0._path)

	GameSceneMgr.instance:getCurScene().camera:switchNextVirtualCamera()
	arg_17_0:_playCameraAnim()
end

return var_0_0
