module("modules.logic.fight.entity.comp.skill.FightTLEventCameraDistance", package.seeall)

local var_0_0 = class("FightTLEventCameraDistance", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = CameraMgr.instance:getVirtualCameraGO()
	local var_1_1 = GameSceneMgr.instance:getCurScene().camera
	local var_1_2 = arg_1_3[1]

	if arg_1_3[2] == "1" then
		local var_1_3 = var_1_1:getDefaultCameraOffset()

		arg_1_0._tween = ZProj.TweenHelper.DOLocalMove(var_1_0.transform, var_1_3.x, var_1_3.y, var_1_3.z, arg_1_2)
	elseif not string.nilorempty(var_1_2) then
		local var_1_4 = string.splitToNumber(var_1_2, ",")

		if var_1_4[1] and var_1_4[2] and var_1_4[3] then
			arg_1_0._tween = ZProj.TweenHelper.DOLocalMove(var_1_0.transform, var_1_4[1], var_1_4[2], var_1_4[3], arg_1_2)
		else
			logError("相机统一距离参数错误（3个数字用逗号分隔）：" .. var_1_2)
		end
	else
		var_1_1:setSceneCameraOffset()
	end
end

function var_0_0._releaseTween(arg_2_0)
	if arg_2_0._tween then
		ZProj.TweenHelper.KillById(arg_2_0._tween)

		arg_2_0._tween = nil
	end
end

function var_0_0.onTrackEnd(arg_3_0)
	return
end

function var_0_0.onDestructor(arg_4_0)
	if arg_4_0._tween then
		GameSceneMgr.instance:getCurScene().camera:setSceneCameraOffset()
	end

	arg_4_0:_releaseTween()
end

return var_0_0
