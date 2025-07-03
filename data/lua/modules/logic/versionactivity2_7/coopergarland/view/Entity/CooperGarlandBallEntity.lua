module("modules.logic.versionactivity2_7.coopergarland.view.Entity.CooperGarlandBallEntity", package.seeall)

local var_0_0 = class("CooperGarlandBallEntity", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.mapId = arg_1_1.mapId
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.trans = arg_2_1.transform
	arg_2_0.ballRoot = arg_2_0.trans.parent
	arg_2_0._rigidBody = arg_2_0.go:GetComponent(typeof(UnityEngine.Rigidbody))
	arg_2_0._goFireVx = gohelper.findChild(arg_2_0.ballRoot.gameObject, "vx/#go_fire")
	arg_2_0._goBornVx = gohelper.findChild(arg_2_0.ballRoot.gameObject, "vx/#go_born")
	arg_2_0._goDieVx = gohelper.findChild(arg_2_0.ballRoot.gameObject, "vx/#go_die")

	arg_2_0:onInit()
end

function var_0_0.onInit(arg_3_0)
	local var_3_0 = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.BallDrag, true)

	arg_3_0._rigidBody.drag = var_3_0

	local var_3_1 = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.BallAngularDrag, true)

	arg_3_0._rigidBody.angularDrag = var_3_1

	arg_3_0:setVisible()
	AudioMgr.instance:setRTPCValue(AudioEnum2_7.CooperGarlandBallRTPC, 0)
	arg_3_0:playLoopAudio(AudioEnum2_7.CooperGarland.play_ui_yuzhou_ball_loop)
end

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnBallKeyChange, arg_4_0._onBallKeyChange, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	arg_5_0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnBallKeyChange, arg_5_0._onBallKeyChange, arg_5_0)
end

function var_0_0._onBallKeyChange(arg_6_0)
	if not arg_6_0._isVisible then
		return
	end

	arg_6_0:refreshKeyStatus()
end

function var_0_0.refreshKeyStatus(arg_7_0)
	local var_7_0 = CooperGarlandGameModel.instance:getBallHasKey()

	if var_7_0 then
		AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_ball_fire)
	end

	gohelper.setActive(arg_7_0._goFireVx, var_7_0)
	arg_7_0:playLoopAudio(var_7_0 and AudioEnum2_7.CooperGarland.play_ui_yuzhou_ball_fire_loop or AudioEnum2_7.CooperGarland.play_ui_yuzhou_ball_loop)
end

function var_0_0.setVisible(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {
		z = 0,
		x = 0,
		y = 0
	}

	if arg_8_1 then
		var_8_0 = arg_8_0.ballRoot.parent:InverseTransformPoint(arg_8_1)
		arg_8_0._showWorldPos = arg_8_1
	end

	var_8_0.z = CooperGarlandGameEntityMgr.instance:getBallPosZ()

	transformhelper.setLocalPos(arg_8_0.ballRoot, var_8_0.x, var_8_0.y, var_8_0.z)
	transformhelper.setLocalPos(arg_8_0.trans, 0, 0, 0)

	local var_8_1 = CooperGarlandGameModel.instance:getSceneOpenAnimShowBall()

	arg_8_0._isVisible = arg_8_1 and var_8_1 and true or false

	gohelper.setActive(arg_8_0.ballRoot, arg_8_0._isVisible)
	arg_8_0:checkFreeze()

	if arg_8_0._isVisible then
		arg_8_0:playBornVx(arg_8_2)
		arg_8_0:refreshKeyStatus()
	end
end

function var_0_0.checkFreeze(arg_9_0, arg_9_1)
	local var_9_0 = CooperGarlandGameModel.instance:getIsStopGame() or not arg_9_0._isVisible

	if arg_9_0._isFreeze == var_9_0 then
		return
	end

	arg_9_0._isFreeze = var_9_0

	local var_9_1 = Vector3.zero
	local var_9_2 = Vector3.zero

	if arg_9_0._isFreeze then
		local var_9_3 = arg_9_0._rigidBody.velocity
		local var_9_4 = arg_9_0._rigidBody.angularVelocity

		arg_9_0._recordSpeed = {
			vX = var_9_3.x,
			vY = var_9_3.y,
			vZ = var_9_3.z,
			angularVX = var_9_4.x,
			angularVY = var_9_4.y,
			angularVZ = var_9_4.z
		}
	else
		if arg_9_1 and arg_9_0._recordSpeed then
			var_9_1 = Vector3(arg_9_0._recordSpeed.vX, arg_9_0._recordSpeed.vY, arg_9_0._recordSpeed.vZ)
			var_9_2 = Vector3(arg_9_0._recordSpeed.angularVX, arg_9_0._recordSpeed.angularVY, arg_9_0._recordSpeed.angularVZ)
		end

		arg_9_0._recordSpeed = nil
	end

	arg_9_0._rigidBody.useGravity = not arg_9_0._isFreeze
	arg_9_0._rigidBody.isKinematic = arg_9_0._isFreeze
	arg_9_0._rigidBody.velocity = var_9_1
	arg_9_0._rigidBody.angularVelocity = var_9_2
end

function var_0_0.reset(arg_10_0)
	arg_10_0._recordSpeed = nil

	arg_10_0:refreshKeyStatus()
	arg_10_0:setVisible(arg_10_0._showWorldPos, true)
end

function var_0_0.isCanTriggerComp(arg_11_0)
	return arg_11_0._isVisible and not arg_11_0._isFreeze
end

function var_0_0.getVelocity(arg_12_0)
	return arg_12_0._rigidBody and arg_12_0._rigidBody.velocity or Vector3.zero
end

function var_0_0.playBornVx(arg_13_0, arg_13_1)
	gohelper.setActive(arg_13_0._goBornVx, false)
	gohelper.setActive(arg_13_0._goBornVx, true)

	if arg_13_1 then
		AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_ball_reset)
	end
end

function var_0_0.playDieVx(arg_14_0)
	gohelper.setActive(arg_14_0._goDieVx, false)
	gohelper.setActive(arg_14_0._goDieVx, true)
end

function var_0_0.playLoopAudio(arg_15_0, arg_15_1)
	if arg_15_0._loopAudioId == arg_15_1 then
		return
	end

	arg_15_0:stopLoopAudio()

	arg_15_0._loopAudioId = arg_15_1

	AudioMgr.instance:trigger(arg_15_0._loopAudioId)
end

function var_0_0.stopLoopAudio(arg_16_0)
	AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.stop_ui_yuzhou_ball_loop)
	AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.stop_ui_yuzhou_ball_fire_loop)

	arg_16_0._loopAudioId = nil
end

function var_0_0.destroy(arg_17_0)
	arg_17_0._recordSpeed = nil

	arg_17_0:stopLoopAudio()
	gohelper.destroy(arg_17_0.ballRoot.gameObject)
end

function var_0_0.onDestroy(arg_18_0)
	return
end

return var_0_0
