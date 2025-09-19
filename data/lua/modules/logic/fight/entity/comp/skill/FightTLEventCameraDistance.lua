module("modules.logic.fight.entity.comp.skill.FightTLEventCameraDistance", package.seeall)

local var_0_0 = class("FightTLEventCameraDistance", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.conditionState = FightHelper.detectTimelinePlayEffectCondition(arg_1_1, arg_1_3[5])

	if not arg_1_0.conditionState then
		return
	end

	arg_1_0.tweenComp = arg_1_0:addComponent(FightTweenComponent)

	local var_1_0 = CameraMgr.instance:getVirtualCameraGO()
	local var_1_1 = GameSceneMgr.instance:getCurScene().camera
	local var_1_2 = arg_1_3[6]

	if not string.nilorempty(var_1_2) then
		local var_1_3 = string.splitToNumber(var_1_2, "#")

		if var_1_3[1] and var_1_3[2] and var_1_3[3] then
			FightWorkFocusMonster.setVirtualCameDamping(var_1_3[1], var_1_3[2], var_1_3[3])
		end
	end

	local var_1_4 = arg_1_3[7]

	if not string.nilorempty(var_1_4) then
		local var_1_5 = string.splitToNumber(var_1_4, "#")

		if var_1_5[1] and var_1_5[2] and var_1_5[3] then
			transformhelper.setLocalPos(var_1_0.transform, var_1_5[1], var_1_5[2], var_1_5[3])
		end
	end

	local var_1_6 = arg_1_3[1]
	local var_1_7 = arg_1_3[2]
	local var_1_8 = var_1_7 == "1"
	local var_1_9 = var_1_7 == "2"

	arg_1_0.holdPosAfterTraceEnd = arg_1_3[3] == "1"

	if var_1_8 then
		local var_1_10 = var_1_1:getDefaultCameraOffset()

		arg_1_0.tweenComp:DOLocalMove(var_1_0.transform, var_1_10.x, var_1_10.y, var_1_10.z, arg_1_2)
	elseif var_1_9 then
		FightWorkFocusMonster.setVirtualCameDamping(0, 0, 0)
		var_1_1:setSceneCameraOffset()
		FightWorkFocusMonster.setVirtualCameDamping(1, 1, 1)
	elseif not string.nilorempty(var_1_6) then
		local var_1_11 = string.splitToNumber(var_1_6, ",")

		if var_1_11[1] and var_1_11[2] and var_1_11[3] then
			arg_1_0.tweenComp:DOLocalMove(var_1_0.transform, var_1_11[1], var_1_11[2], var_1_11[3], arg_1_2)
		else
			logError("相机统一距离参数错误（3个数字用逗号分隔）：" .. var_1_6)
		end
	else
		var_1_1:setSceneCameraOffset()
	end

	local var_1_12 = arg_1_3[4]

	if not string.nilorempty(var_1_12) then
		local var_1_13 = string.split(var_1_12, "#")
		local var_1_14 = var_1_13[2] == "1"
		local var_1_15 = CameraMgr.instance:getCameraRootGO()
		local var_1_16 = gohelper.findChild(var_1_15, "main/VirtualCameras/light/direct"):GetComponent(typeof(UnityEngine.Light))

		arg_1_0.light = var_1_16

		local var_1_17 = var_1_16.color
		local var_1_18 = tonumber(var_1_13[1])
		local var_1_19 = Color.New(var_1_17.r, var_1_17.g, var_1_17.b, var_1_18)

		if var_1_14 then
			var_1_16.color = var_1_19
		else
			arg_1_0.tweenComp:DOTweenFloat(var_1_17.a, var_1_18, arg_1_2, arg_1_0.frameCallback, nil, arg_1_0, var_1_19)
		end
	end
end

function var_0_0.frameCallback(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2.a = arg_2_1
	arg_2_0.light.color = arg_2_2
end

function var_0_0.onTrackEnd(arg_3_0)
	return
end

function var_0_0.onDestructor(arg_4_0)
	arg_4_0:revertCameraPos()
end

function var_0_0.revertCameraPos(arg_5_0)
	if not arg_5_0.conditionState then
		return
	end

	if not arg_5_0.holdPosAfterTraceEnd then
		GameSceneMgr.instance:getCurScene().camera:setSceneCameraOffset()
	end
end

return var_0_0
