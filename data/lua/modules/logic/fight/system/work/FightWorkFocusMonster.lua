module("modules.logic.fight.system.work.FightWorkFocusMonster", package.seeall)

local var_0_0 = class("FightWorkFocusMonster", BaseWork)

var_0_0.EaseTime = 0
var_0_0.Speed = 15
var_0_0.TweenId = 0

function var_0_0.onStart(arg_1_0)
	local var_1_0, var_1_1 = var_0_0.getFocusEntityId()

	if var_1_0 then
		local var_1_2 = FightDataHelper.entityMgr:getById(var_1_0)

		ViewMgr.instance:openView(ViewName.FightTechniqueGuideView, {
			entity = var_1_2,
			config = var_1_1
		})
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0._onCloseViewFinish, arg_1_0)
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._onCloseViewFinish(arg_2_0, arg_2_1)
	if arg_2_1 == ViewName.FightTechniqueGuideView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
		TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, var_0_0.EaseTime)
	end
end

function var_0_0._delayDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_4_0._onCloseViewFinish, arg_4_0)
end

function var_0_0.getPlayerPrefKey()
	local var_5_0 = FightModel.instance:getFightParam().episodeId
	local var_5_1 = PlayerModel.instance:getPlayinfo()
	local var_5_2 = FightModel.instance:getCurWaveId()

	return string.format("%s&%s&%s&%s", PlayerPrefsKey.FightFocusMonster, var_5_1.userId, tostring(var_5_0), tostring(var_5_2))
end

function var_0_0.getFocusEntityId()
	local var_6_0 = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, true)
	local var_6_1 = FightModel.instance:getFightParam()
	local var_6_2 = var_6_1.episodeId

	if not var_6_2 then
		return
	end

	if DungeonModel.instance:hasPassLevel(var_6_2) then
		return
	end

	if not lua_monster_guide_focus.configDict[var_6_1.episodeId] then
		return
	end

	table.sort(var_6_0, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0:getMO()
		local var_7_1 = arg_7_1:getMO()

		if var_7_0 and var_7_1 and var_7_0.position ~= var_7_1.position then
			return var_7_0.position < var_7_1.position
		end

		return tonumber(var_7_0.id) < tonumber(var_7_1.id)
	end)

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_3 = iter_6_1:getMO()
		local var_6_4 = var_6_3 and var_6_3.modelId
		local var_6_5 = FightConfig.instance:getMonsterGuideFocusConfig(var_6_1.episodeId, var_0_0.invokeType.Enter, FightModel.instance:getCurWaveId(), var_6_4)

		if var_6_5 then
			local var_6_6 = FightWorkSkillOrBuffFocusMonster.getPlayerPrefKey(var_6_5)

			if not PlayerPrefsHelper.hasKey(var_6_6) then
				return var_6_3.id, var_6_5
			end
		end
	end
end

var_0_0.invokeType = {
	Skill = 1,
	Enter = 0,
	Buff = 2
}

function var_0_0.getCameraPositionByEntity(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)
	local var_8_1, var_8_2, var_8_3 = transformhelper.getPos(var_8_0.transform)

	var_8_1 = arg_8_1:isMySide() and var_8_1 - 2.7 or var_8_1 + 2.7

	local var_8_4 = var_8_2 - 2
	local var_8_5 = var_8_3 + 5.4

	return var_8_1, var_8_4, var_8_5
end

function var_0_0.focusCamera(arg_9_0)
	local var_9_0 = false
	local var_9_1 = FightHelper.getEntity(arg_9_0)

	if var_9_1 then
		local var_9_2 = var_9_1:getMO()

		if var_9_2 then
			local var_9_3 = FightConfig.instance:getSkinCO(var_9_2.skin)

			if var_9_3 and var_9_3.canHide == 1 then
				var_9_0 = true
			end
		end
	end

	local var_9_4 = FightHelper.getAllEntitys()

	for iter_9_0, iter_9_1 in ipairs(var_9_4) do
		iter_9_1:setVisibleByPos(var_9_0 or arg_9_0 == iter_9_1.id)

		if iter_9_1.buff then
			if arg_9_0 ~= iter_9_1.id then
				iter_9_1.buff:hideBuffEffects()
			else
				iter_9_1.buff:showBuffEffects()
			end
		end

		if iter_9_1.nameUI then
			iter_9_1.nameUI:setActive(arg_9_0 == iter_9_1.id)
		end
	end

	GameSceneMgr.instance:getScene(SceneType.Fight).level:setFrontVisible(false)

	local var_9_5 = FightHelper.getEntity(arg_9_0)

	if var_9_5 then
		local var_9_6, var_9_7, var_9_8 = var_0_0:getCameraPositionByEntity(var_9_5)
		local var_9_9 = FightConfig.instance:getSkinCO(var_9_5:getMO().skin).focusOffset

		if #var_9_9 == 3 then
			var_9_6 = var_9_6 + var_9_9[1]
			var_9_7 = var_9_7 + var_9_9[2]
			var_9_8 = var_9_8 + var_9_9[3]
		end

		local var_9_10 = Vector3.Distance(Vector3.New(var_9_6, var_9_7, var_9_8), Vector3.zero)

		var_0_0.setVirtualCameDamping(1, 1, 1)

		var_0_0.EaseTime = var_9_10 / var_0_0.Speed

		local var_9_11 = CameraMgr.instance:getVirtualCameraTrs()

		var_0_0.killTween()

		var_0_0.TweenId = ZProj.TweenHelper.DOMove(var_9_11, var_9_6, var_9_7, var_9_8, var_0_0.EaseTime)
	end
end

function var_0_0.cancelFocusCamera()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight or GameSceneMgr.instance:isClosing() then
		return
	end

	local var_10_0 = FightHelper.getAllEntitys()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		iter_10_1:setVisibleByPos(true)

		if iter_10_1.buff then
			iter_10_1.buff:showBuffEffects()
		end

		if iter_10_1.nameUI then
			iter_10_1.nameUI:setActive(true)
		end
	end

	local var_10_1, var_10_2, var_10_3 = var_0_0.getCurrentSceneCameraOffset()

	var_0_0.setVirtualCameDamping(0.5, 0.5, 0.5)

	local var_10_4 = CameraMgr.instance:getVirtualCameraTrs()

	var_0_0.killTween()

	var_0_0.TweenId = ZProj.TweenHelper.DOMove(var_10_4, var_10_1, var_10_2, var_10_3, var_0_0.EaseTime, var_0_0.cancelFocusCameraFinished)

	TaskDispatcher.runDelay(var_0_0.showCardPart, var_0_0, var_0_0.EaseTime)

	var_0_0.EaseTime = 0
end

function var_0_0.changeCameraPosition(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if not isDebugBuild then
		return
	end

	local var_11_0 = ViewMgr.instance:getContainer(ViewName.FightSkillSelectView)

	if not var_11_0 then
		return
	end

	local var_11_1 = var_11_0._views[1]:getCurrentFocusEntityId()

	if not var_11_1 then
		return
	end

	local var_11_2 = FightHelper.getEntity(var_11_1)

	if not var_11_2 then
		return
	end

	local var_11_3, var_11_4, var_11_5 = var_0_0:getCameraPositionByEntity(var_11_2)
	local var_11_6 = var_11_3 + arg_11_0
	local var_11_7 = var_11_4 + arg_11_1
	local var_11_8 = var_11_5 + arg_11_2
	local var_11_9 = CameraMgr.instance:getVirtualCameraTrs()

	var_0_0.killTween()

	var_0_0.TweenId = ZProj.TweenHelper.DOMove(var_11_9, var_11_6, var_11_7, var_11_8, 0.1, arg_11_3, arg_11_4)
end

function var_0_0.showCardPart()
	FightMsgMgr.sendMsg(FightMsgId.CameraFocusChanged, false)
	FightController.instance:dispatchEvent(FightEvent.OnCameraFocusChanged, false)
end

function var_0_0.getCurrentSceneCameraOffset()
	local var_13_0 = GameSceneMgr.instance:getCurLevelId()
	local var_13_1 = lua_scene_level.configDict[var_13_0]

	if var_13_1 and not string.nilorempty(var_13_1.cameraOffset) then
		local var_13_2 = Vector3(unpack(cjson.decode(var_13_1.cameraOffset)))

		return var_13_2.x, var_13_2.y, var_13_2.z
	else
		return 0, 0, 0
	end
end

function var_0_0.setVirtualCameDamping(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = GameSceneMgr.instance:getScene(SceneType.Fight).camera:getCurActiveVirtualCame()

	ZProj.GameHelper.SetVirtualCameraTrackedDollyDamping(var_14_0, arg_14_0, arg_14_1, arg_14_2)
end

function var_0_0.cancelFocusCameraFinished()
	var_0_0.setVirtualCameDamping(1, 1, 1)
	GameSceneMgr.instance:getScene(SceneType.Fight).level:setFrontVisible(true)
end

function var_0_0.killTween()
	if var_0_0.TweenId ~= 0 then
		ZProj.TweenHelper.KillById(var_0_0.TweenId)
	end
end

return var_0_0
