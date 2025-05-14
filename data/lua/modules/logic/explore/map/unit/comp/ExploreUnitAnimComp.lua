module("modules.logic.explore.map.unit.comp.ExploreUnitAnimComp", package.seeall)

local var_0_0 = class("ExploreUnitAnimComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.unit = arg_1_1
	arg_1_0._curAnim = nil
	arg_1_0._curAnimHash = nil
	arg_1_0._checkTime = 0
	arg_1_0._playTime = 0
	arg_1_0._showEffect = true
end

function var_0_0.setup(arg_2_0, arg_2_1)
	arg_2_0.animator = arg_2_1:GetComponent(typeof(UnityEngine.Animator))

	if arg_2_0.animator then
		arg_2_0._goName = arg_2_0.animator.runtimeAnimatorController.name
		arg_2_0.animator.keepAnimatorControllerStateOnDisable = true
	else
		arg_2_0._goName = nil
	end

	if arg_2_0._curAnim then
		arg_2_0:playAnim(arg_2_0._curAnim)
	else
		arg_2_0:playIdleAnim()
	end
end

function var_0_0.playIdleAnim(arg_3_0)
	arg_3_0:playAnim(arg_3_0.unit:getIdleAnim(), true)
end

function var_0_0.onUpdate(arg_4_0)
	if not arg_4_0.animator then
		return
	end

	if arg_4_0:isIdleAnim() then
		return
	end

	if arg_4_0.unit:needUpdateHeroPos() then
		local var_4_0 = ExploreController.instance:getMap():getHero()

		var_4_0:setPos(var_4_0:getPos())
	end

	local var_4_1 = arg_4_0.animator:GetCurrentAnimatorStateInfo(0)

	if arg_4_0._curAnim == ExploreAnimEnum.AnimName.exit and var_4_1.normalizedTime >= 1 then
		arg_4_0:onAnimPlayEnd(ExploreAnimEnum.AnimName.exit, nil)
	elseif arg_4_0._curAnimHash ~= var_4_1.shortNameHash then
		arg_4_0:onAnimPlayEnd(arg_4_0._curAnim, ExploreAnimEnum.AnimHashToName[var_4_1.shortNameHash])
	end
end

function var_0_0.onAnimPlayEnd(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:_setCurAnimName(arg_5_2)
	arg_5_0.unit:onAnimEnd(arg_5_1, arg_5_2)
end

function var_0_0.isIdleAnim(arg_6_0, arg_6_1)
	arg_6_1 = arg_6_1 or arg_6_0._curAnim

	return ExploreAnimEnum.LoopAnims[arg_6_1] or arg_6_1 == nil
end

function var_0_0.haveAnim(arg_7_0, arg_7_1)
	if arg_7_1 == nil then
		return false
	end

	if not arg_7_0._goName then
		return false
	end

	return ExploreConfig.instance:getAnimLength(arg_7_0._goName, arg_7_1)
end

function var_0_0.playAnim(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0.animator then
		arg_8_0:_setCurAnimName(arg_8_1, arg_8_2)

		if ExploreAnimEnum.NextAnimName[arg_8_1] and ExploreAnimEnum.NextAnimName[arg_8_1] ~= arg_8_1 then
			arg_8_0.unit:onAnimEnd(arg_8_1, ExploreAnimEnum.NextAnimName[arg_8_1])
			arg_8_0:playAnim(ExploreAnimEnum.NextAnimName[arg_8_1], arg_8_2)
		elseif not arg_8_0:isIdleAnim(arg_8_1) then
			arg_8_0.unit:onAnimEnd(arg_8_1, nil)
		end

		return
	end

	local var_8_0

	if not arg_8_0:haveAnim(arg_8_1) and ExploreAnimEnum.NextAnimName[arg_8_1] and ExploreAnimEnum.NextAnimName[arg_8_1] ~= arg_8_1 then
		var_8_0 = arg_8_1
		arg_8_1 = ExploreAnimEnum.NextAnimName[arg_8_1]
	end

	local var_8_1 = arg_8_0._curAnim
	local var_8_2 = arg_8_0._curAnimHash

	arg_8_0:_setCurAnimName(arg_8_1, arg_8_2)

	local var_8_3 = 0
	local var_8_4 = arg_8_0.animator:GetCurrentAnimatorStateInfo(0)

	if var_8_4.shortNameHash ~= var_8_2 then
		var_8_2 = var_8_4.shortNameHash
		var_8_1 = ExploreAnimEnum.AnimHashToName[var_8_2]
	end

	if var_8_2 == arg_8_0._curAnimHash then
		var_8_3 = var_8_4.normalizedTime
	elseif arg_8_0.unit:isPairAnim(var_8_1, arg_8_0._curAnim) then
		local var_8_5 = ExploreConfig.instance:getAnimLength(arg_8_0._goName, var_8_1)
		local var_8_6 = ExploreConfig.instance:getAnimLength(arg_8_0._goName, arg_8_0._curAnim)

		if var_8_5 and var_8_6 then
			if var_8_5 == var_8_6 then
				var_8_3 = 1 - var_8_4.normalizedTime
			else
				var_8_3 = 1 - (var_8_5 * var_8_4.normalizedTime - (var_8_5 - var_8_6)) / var_8_6
			end

			var_8_3 = math.max(0, var_8_3)
		end
	end

	if arg_8_0:haveAnim(arg_8_1) then
		arg_8_0.animator:Play(arg_8_1, 0, var_8_3)
		arg_8_0.animator:Update(0)
	end

	if var_8_0 then
		arg_8_0.unit:onAnimEnd(var_8_0, arg_8_1)
	end
end

function var_0_0.setShowEffect(arg_9_0, arg_9_1)
	arg_9_0._showEffect = arg_9_1
end

function var_0_0._setCurAnimName(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._curAnim = arg_10_1
	arg_10_0._curAnimHash = ExploreAnimEnum.AnimNameToHash[arg_10_1]

	if arg_10_0.unit.animEffectComp and arg_10_0._showEffect then
		arg_10_0.unit.animEffectComp:playAnim(arg_10_1, arg_10_2)
	end
end

function var_0_0.clear(arg_11_0)
	if not arg_11_0:isIdleAnim() then
		ExploreController.instance:dispatchEvent(ExploreEvent.OnUnitAnimEnd, arg_11_0.unit.id, arg_11_0._curAnim)
	end

	arg_11_0._curAnim = nil
	arg_11_0.animator = nil
end

function var_0_0.onDestroy(arg_12_0)
	arg_12_0:clear()
end

return var_0_0
