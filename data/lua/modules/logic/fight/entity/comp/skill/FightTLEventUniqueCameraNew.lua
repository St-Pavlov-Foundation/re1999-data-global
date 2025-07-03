module("modules.logic.fight.entity.comp.skill.FightTLEventUniqueCameraNew", package.seeall)

local var_0_0 = class("FightTLEventUniqueCameraNew", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.paramsArr = arg_1_3
	arg_1_0.fightStepData = arg_1_1
	arg_1_0._attacker = FightHelper.getEntity(arg_1_1.fromId)
	arg_1_0._cameraResName = arg_1_3[1]

	if not string.nilorempty(arg_1_3[2]) and arg_1_3[2] ~= "0" and FightHelper.detectTimelinePlayEffectCondition(arg_1_1, arg_1_3[2]) and not string.nilorempty(arg_1_3[3]) then
		arg_1_0._cameraResName = arg_1_3[3]
	end

	if not string.nilorempty(arg_1_0._cameraResName) then
		arg_1_0._loader = MultiAbLoader.New()

		arg_1_0._loader:addPath(FightHelper.getCameraAniPath(arg_1_0._cameraResName))
		arg_1_0._loader:startLoad(arg_1_0._onLoaded, arg_1_0)
	end

	FightController.instance:registerCallback(FightEvent.ParallelPlayNextSkillDoneThis, arg_1_0._parallelSkillDoneThis, arg_1_0)
end

function var_0_0.onTrackEnd(arg_2_0)
	arg_2_0:_onFinish()
	arg_2_0:dealFinalValue(arg_2_0.paramsArr[4])
end

function var_0_0._onLoaded(arg_3_0, arg_3_1)
	arg_3_0.fightStepData.hasPlayTimelineCamera = true

	local var_3_0 = GameSceneMgr.instance:getCurScene().camera
	local var_3_1 = var_3_0:getCurVirtualCamera(1)
	local var_3_2 = var_3_0:getCurVirtualCamera(2)
	local var_3_3 = ZProj.VirtualCameraWrap.Get(var_3_1.gameObject).body
	local var_3_4 = ZProj.VirtualCameraWrap.Get(var_3_2.gameObject).body
	local var_3_5 = "Follower" .. string.sub(var_3_1.name, string.len(var_3_1.name))
	local var_3_6 = "Follower" .. string.sub(var_3_2.name, string.len(var_3_2.name))
	local var_3_7 = gohelper.findChild(var_3_1.transform.parent.gameObject, var_3_5)
	local var_3_8 = gohelper.findChild(var_3_2.transform.parent.gameObject, var_3_6)
	local var_3_9 = var_3_1.transform.parent.gameObject
	local var_3_10 = var_3_2.transform.parent.gameObject
	local var_3_11
	local var_3_12 = GameSceneMgr.instance:getCurScene().cardCamera

	if arg_3_0.fightStepData.isParallelStep or var_3_12:isPlaying() then
		GameSceneMgr.instance:getCurScene().camera:enablePostProcessSmooth(true)

		var_3_11 = {
			{
				body = var_3_3,
				follower = var_3_7,
				vcam = var_3_9,
				params = arg_3_0:_getVirtualCameraParams(var_3_3, var_3_7, var_3_9)
			},
			{
				body = var_3_4,
				follower = var_3_8,
				vcam = var_3_10,
				params = arg_3_0:_getVirtualCameraParams(var_3_4, var_3_8, var_3_10)
			}
		}

		var_3_0:switchNextVirtualCamera()
	end

	arg_3_0._animatorInst = arg_3_0._loader:getFirstAssetItem():GetResource(ResUrl.getCameraAnim(arg_3_0._cameraResName))
	arg_3_0._animComp = CameraMgr.instance:getCameraRootAnimator()
	arg_3_0._animComp.enabled = true
	arg_3_0._animComp.runtimeAnimatorController = nil
	arg_3_0._animComp.runtimeAnimatorController = arg_3_0._animatorInst
	arg_3_0._animComp.speed = FightModel.instance:getSpeed()

	arg_3_0._animComp:SetBool("isRight", arg_3_0._attacker and arg_3_0._attacker:isMySide() or false)

	local var_3_13 = arg_3_0._attacker and arg_3_0._attacker:getMO() and arg_3_0._attacker:getMO().position

	if var_3_13 then
		arg_3_0._animComp:SetInteger("pos", var_3_13 > 4 and 4 or var_3_13)
	end

	FightController.instance:registerCallback(FightEvent.OnUpdateSpeed, arg_3_0._onUpdateSpeed, arg_3_0)

	arg_3_0._animationIndex = 1

	local var_3_14 = arg_3_0._animComp:GetCurrentAnimatorStateInfo(0)

	arg_3_0._animationName = var_3_14 and var_3_14.shortNameHash

	if arg_3_0.fightStepData.isParallelStep or var_3_12:isPlaying() then
		if var_3_12:isPlaying() then
			var_3_12:stop()
		end

		arg_3_0._defaultVirtualCameraParams = {
			{
				body = var_3_3,
				follower = var_3_7,
				vcam = var_3_9,
				params = arg_3_0:_getDefaultVirtualCameraParams(var_3_3, var_3_7, var_3_9)
			},
			{
				body = var_3_4,
				follower = var_3_8,
				vcam = var_3_10,
				params = arg_3_0:_getDefaultVirtualCameraParams(var_3_4, var_3_8, var_3_10)
			}
		}

		arg_3_0:_setVirtualCameraParam(var_3_11)
		TaskDispatcher.runDelay(arg_3_0._delaySetDefaultVirtualCameraParam, arg_3_0, 1)
	end
end

function var_0_0._getVirtualCameraParams(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_1.m_PathOffset
	local var_4_1 = arg_4_1.m_PathPosition
	local var_4_2 = arg_4_1.m_XDamping
	local var_4_3 = arg_4_1.m_YDamping
	local var_4_4 = arg_4_1.m_ZDamping
	local var_4_5 = arg_4_2.transform.localPosition
	local var_4_6 = arg_4_3.transform.localPosition

	return {
		pathOffset = var_4_0,
		pathPosition = var_4_1,
		xDamping = var_4_2,
		yDamping = var_4_3,
		zDamping = var_4_4,
		followerPos = var_4_5,
		vcamPos = var_4_6
	}
end

function var_0_0._getDefaultVirtualCameraParams(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = Vector3.zero
	local var_5_1 = arg_5_2.transform.localPosition

	return {
		zDamping = 0.5,
		xDamping = 0.5,
		yDamping = 0.5,
		pathPosition = 1,
		pathOffset = var_5_0,
		followerPos = var_5_1,
		vcamPos = var_5_0
	}
end

function var_0_0._delaySetDefaultVirtualCameraParam(arg_6_0)
	arg_6_0:_setVirtualCameraParam(arg_6_0._defaultVirtualCameraParams)
end

function var_0_0._setVirtualCameraParam(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		iter_7_1.body.m_PathOffset = iter_7_1.params.pathOffset
		iter_7_1.body.m_PathPosition = iter_7_1.params.pathPosition
		iter_7_1.body.m_XDamping = iter_7_1.params.xDamping
		iter_7_1.body.m_YDamping = iter_7_1.params.yDamping
		iter_7_1.body.m_ZDamping = iter_7_1.params.zDamping
		iter_7_1.follower.transform.localPosition = iter_7_1.params.followerPos
		iter_7_1.vcam.transform.localPosition = iter_7_1.params.vcamPos
	end
end

function var_0_0._onUpdateSpeed(arg_8_0)
	if arg_8_0._animComp then
		arg_8_0._animComp.speed = FightModel.instance:getSpeed()
	end
end

function var_0_0._parallelSkillDoneThis(arg_9_0, arg_9_1)
	TaskDispatcher.cancelTask(arg_9_0._delaySetDefaultVirtualCameraParam, arg_9_0)

	arg_9_0._animComp = nil
end

function var_0_0._onFinish(arg_10_0)
	arg_10_0:_clear()
end

function var_0_0.onDestructor(arg_11_0)
	arg_11_0:_clear()
end

function var_0_0._clear(arg_12_0)
	if arg_12_0._defaultVirtualCameraParams then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0._defaultVirtualCameraParams) do
			iter_12_1.body = nil
			iter_12_1.params = nil
		end

		arg_12_0._defaultVirtualCameraParams = nil
	end

	TaskDispatcher.cancelTask(arg_12_0._delaySetDefaultVirtualCameraParam, arg_12_0)
	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillDoneThis, arg_12_0._parallelSkillDoneThis, arg_12_0)
	FightController.instance:unregisterCallback(FightEvent.OnUpdateSpeed, arg_12_0._onUpdateSpeed, arg_12_0)

	if arg_12_0._animComp and arg_12_0._animComp.runtimeAnimatorController == arg_12_0._animatorInst then
		arg_12_0._animComp.runtimeAnimatorController = nil
		arg_12_0._animComp.enabled = false
	end

	if arg_12_0._loader then
		arg_12_0._loader:dispose()
	end

	arg_12_0._loader = nil
	arg_12_0._animComp = nil
	arg_12_0._animatorInst = nil
end

function var_0_0.dealFinalValue(arg_13_0, arg_13_1)
	if string.nilorempty(arg_13_1) then
		return
	end

	local var_13_0 = GameUtil.splitString2(arg_13_1, false, ",", "#")

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		if FightHelper.detectTimelinePlayEffectCondition(arg_13_0.fightStepData, string.format("%s#%s", iter_13_1[1], iter_13_1[2])) then
			local var_13_1 = iter_13_1[3]
			local var_13_2 = iter_13_1[4]

			if var_13_1 == "1" then
				local var_13_3 = CameraMgr.instance:getCameraRootGO()
				local var_13_4 = gohelper.findChild(var_13_3, "main/VirtualCameras/light/direct"):GetComponent(typeof(UnityEngine.Light))
				local var_13_5 = var_13_4.color

				var_13_4.color = Color.New(var_13_5.r, var_13_5.g, var_13_5.b, tonumber(var_13_2))
			elseif var_13_1 == "2" then
				local var_13_6 = GameSceneMgr.instance:getCurScene().camera:getCurActiveVirtualCame().transform.parent
				local var_13_7 = var_13_6.localPosition

				transformhelper.setLocalPos(var_13_6, var_13_7.x, var_13_7.y, tonumber(var_13_2))
			end
		end
	end
end

return var_0_0
