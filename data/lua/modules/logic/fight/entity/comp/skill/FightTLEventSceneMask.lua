module("modules.logic.fight.entity.comp.skill.FightTLEventSceneMask", package.seeall)

local var_0_0 = class("FightTLEventSceneMask")

function var_0_0.ctor(arg_1_0)
	arg_1_0._effectWrap = nil
end

function var_0_0.handleSkillEvent(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = ResUrl.getEffect(arg_2_3[1])

	arg_2_0._colorStr = arg_2_3[2]

	local var_2_1 = arg_2_3[3]

	if not string.nilorempty(var_2_1) then
		local var_2_2 = string.split(var_2_1, "#")

		if var_2_2 and #var_2_2 > 0 then
			arg_2_0._fadeInTime = tonumber(var_2_2[1]) or 0.15
			arg_2_0._fadeOutTime = var_2_2[2] and tonumber(var_2_2[2]) or arg_2_0._fadeInTime
		end
	end

	arg_2_0._color = GameUtil.parseColor(arg_2_0._colorStr)

	if arg_2_0._fadeInTime and arg_2_0._fadeInTime > 0 then
		arg_2_0._fadeInId = ZProj.TweenHelper.DOTweenFloat(0, arg_2_0._color.a, arg_2_0._fadeInTime, arg_2_0._tweenFrameCb, nil, arg_2_0)
		arg_2_0._color = Color.New(arg_2_0._color.r, arg_2_0._color.g, arg_2_0._color.b, 0)
	end

	if arg_2_0._fadeOutTime and arg_2_0._fadeOutTime > 0 then
		TaskDispatcher.runDelay(arg_2_0._fadeOut, arg_2_0, arg_2_2 - arg_2_0._fadeOutTime)
	end

	local var_2_3 = CameraMgr.instance:getMainCameraGO()
	local var_2_4 = gohelper.findChild(var_2_3, "scenemask")

	arg_2_0._effectWrap = FightEffectPool.getEffect(var_2_0, FightEnum.EntitySide.BothSide, arg_2_0._onEffectLoaded, arg_2_0, var_2_4)

	arg_2_0._effectWrap:setLayer(UnityLayer.Unit)
end

function var_0_0.handleSkillEventEnd(arg_3_0)
	arg_3_0:_clear()
end

function var_0_0._fadeOut(arg_4_0)
	if arg_4_0._fadeInId then
		ZProj.TweenHelper.KillById(arg_4_0._fadeInId)
	end

	arg_4_0._fadeOutId = ZProj.TweenHelper.DOTweenFloat(arg_4_0._color.a, 0, arg_4_0._fadeOutTime, arg_4_0._tweenFrameCb, nil, arg_4_0)
end

function var_0_0._tweenFrameCb(arg_5_0, arg_5_1)
	arg_5_0._color.a = arg_5_1

	arg_5_0:_setMaskColor()
end

function var_0_0.reset(arg_6_0)
	arg_6_0:_clear()
end

function var_0_0.dispose(arg_7_0)
	arg_7_0:_clear()
end

function var_0_0._onEffectLoaded(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_2 then
		return
	end

	local var_8_0 = arg_8_1.effectGO:GetComponent("MeshRenderer")

	if var_8_0 then
		arg_8_0._material = var_8_0.material

		if arg_8_0._material:HasProperty(MaterialUtil._MaskColorId) then
			arg_8_0:_setMaskColor()
		end
	end
end

function var_0_0._setMaskColor(arg_9_0)
	if arg_9_0._material then
		arg_9_0._material:SetColor(MaterialUtil._MaskColorId, arg_9_0._color)
	end
end

function var_0_0._clear(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._fadeOut, arg_10_0)

	if arg_10_0._fadeInId then
		ZProj.TweenHelper.KillById(arg_10_0._fadeInId)

		arg_10_0._fadeInId = nil
	end

	if arg_10_0._fadeOutId then
		ZProj.TweenHelper.KillById(arg_10_0._fadeOutId)

		arg_10_0._fadeOutId = nil
	end

	if arg_10_0._effectWrap then
		FightEffectPool.returnEffect(arg_10_0._effectWrap)

		arg_10_0._effectWrap = nil
	end

	arg_10_0._material = nil
end

return var_0_0
