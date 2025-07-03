module("modules.logic.fight.entity.comp.skill.FightTLEventSceneMask", package.seeall)

local var_0_0 = class("FightTLEventSceneMask", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = ResUrl.getEffect(arg_1_3[1])

	arg_1_0._colorStr = arg_1_3[2]

	local var_1_1 = arg_1_3[3]

	if not string.nilorempty(var_1_1) then
		local var_1_2 = string.split(var_1_1, "#")

		if var_1_2 and #var_1_2 > 0 then
			arg_1_0._fadeInTime = tonumber(var_1_2[1]) or 0.15
			arg_1_0._fadeOutTime = var_1_2[2] and tonumber(var_1_2[2]) or arg_1_0._fadeInTime
		end
	end

	arg_1_0._color = GameUtil.parseColor(arg_1_0._colorStr)

	if arg_1_0._fadeInTime and arg_1_0._fadeInTime > 0 then
		arg_1_0._fadeInId = ZProj.TweenHelper.DOTweenFloat(0, arg_1_0._color.a, arg_1_0._fadeInTime, arg_1_0._tweenFrameCb, nil, arg_1_0)
		arg_1_0._color = Color.New(arg_1_0._color.r, arg_1_0._color.g, arg_1_0._color.b, 0)
	end

	if arg_1_0._fadeOutTime and arg_1_0._fadeOutTime > 0 then
		TaskDispatcher.runDelay(arg_1_0._fadeOut, arg_1_0, arg_1_2 - arg_1_0._fadeOutTime)
	end

	local var_1_3 = CameraMgr.instance:getMainCameraGO()
	local var_1_4 = gohelper.findChild(var_1_3, "scenemask")

	arg_1_0._effectWrap = FightEffectPool.getEffect(var_1_0, FightEnum.EntitySide.BothSide, arg_1_0._onEffectLoaded, arg_1_0, var_1_4)

	arg_1_0._effectWrap:setLayer(UnityLayer.Unit)
end

function var_0_0.onTrackEnd(arg_2_0)
	arg_2_0:_clear()
end

function var_0_0._fadeOut(arg_3_0)
	if arg_3_0._fadeInId then
		ZProj.TweenHelper.KillById(arg_3_0._fadeInId)
	end

	arg_3_0._fadeOutId = ZProj.TweenHelper.DOTweenFloat(arg_3_0._color.a, 0, arg_3_0._fadeOutTime, arg_3_0._tweenFrameCb, nil, arg_3_0)
end

function var_0_0._tweenFrameCb(arg_4_0, arg_4_1)
	arg_4_0._color.a = arg_4_1

	arg_4_0:_setMaskColor()
end

function var_0_0.onDestructor(arg_5_0)
	arg_5_0:_clear()
end

function var_0_0._onEffectLoaded(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_2 then
		return
	end

	local var_6_0 = arg_6_1.effectGO:GetComponent("MeshRenderer")

	if var_6_0 then
		arg_6_0._material = var_6_0.material

		if arg_6_0._material:HasProperty(MaterialUtil._MaskColorId) then
			arg_6_0:_setMaskColor()
		end
	end
end

function var_0_0._setMaskColor(arg_7_0)
	if arg_7_0._material then
		arg_7_0._material:SetColor(MaterialUtil._MaskColorId, arg_7_0._color)
	end
end

function var_0_0._clear(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._fadeOut, arg_8_0)

	if arg_8_0._fadeInId then
		ZProj.TweenHelper.KillById(arg_8_0._fadeInId)

		arg_8_0._fadeInId = nil
	end

	if arg_8_0._fadeOutId then
		ZProj.TweenHelper.KillById(arg_8_0._fadeOutId)

		arg_8_0._fadeOutId = nil
	end

	if arg_8_0._effectWrap then
		FightEffectPool.returnEffect(arg_8_0._effectWrap)

		arg_8_0._effectWrap = nil
	end

	arg_8_0._material = nil
end

return var_0_0
