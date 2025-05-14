module("modules.logic.explore.map.unit.ExploreRuneUnit", package.seeall)

local var_0_0 = class("ExploreRuneUnit", ExploreBaseDisplayUnit)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.tryTrigger(arg_2_0)
	arg_2_0._triggerType = ExploreEnum.RuneTriggerType.None

	local var_2_0 = ExploreModel.instance:getUseItemUid()
	local var_2_1 = ExploreBackpackModel.instance:getById(var_2_0)

	if var_2_1 and var_2_1.itemEffect == ExploreEnum.ItemEffect.Active then
		local var_2_2 = arg_2_0.mo:isInteractActiveState()
		local var_2_3 = var_2_1.status

		if ExploreEnum.RuneStatus.Inactive == var_2_3 and not var_2_2 or ExploreEnum.RuneStatus.Active == var_2_3 and var_2_2 then
			-- block empty
		elseif ExploreEnum.RuneStatus.Inactive == var_2_3 and var_2_2 then
			arg_2_0._triggerType = ExploreEnum.RuneTriggerType.ItemActive

			var_0_0.super.tryTrigger(arg_2_0)
		elseif ExploreEnum.RuneStatus.Active == var_2_3 and var_2_2 == false then
			arg_2_0._triggerType = ExploreEnum.RuneTriggerType.RuneActive

			var_0_0.super.tryTrigger(arg_2_0)
		end
	end
end

function var_0_0.canTrigger(arg_3_0)
	if not var_0_0.super.canTrigger(arg_3_0) then
		return false
	end

	if ExploreModel.instance:getStepPause() then
		return false
	end

	local var_3_0 = ExploreModel.instance:getUseItemUid()
	local var_3_1 = ExploreBackpackModel.instance:getById(var_3_0)

	if var_3_1 and var_3_1.itemEffect == ExploreEnum.ItemEffect.Active then
		local var_3_2 = arg_3_0.mo:isInteractActiveState()
		local var_3_3 = var_3_1.status

		if ExploreEnum.RuneStatus.Inactive == var_3_3 and not var_3_2 or ExploreEnum.RuneStatus.Active == var_3_3 and var_3_2 then
			return false
		elseif ExploreEnum.RuneStatus.Inactive == var_3_3 and var_3_2 then
			return true
		elseif ExploreEnum.RuneStatus.Active == var_3_3 and var_3_2 == false then
			return true
		end
	end

	return false
end

function var_0_0.needInteractAnim(arg_4_0)
	return true
end

function var_0_0.onTriggerDone(arg_5_0)
	if arg_5_0._triggerType == ExploreEnum.RuneTriggerType.ItemActive and arg_5_0._displayTr then
		local var_5_0 = ExploreController.instance:getMapWhirl():getWhirl(ExploreEnum.WhirlType.Rune)

		if var_5_0 then
			ExploreModel.instance:setStepPause(true)
			ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Rune)
			var_5_0:flyToPos(true, arg_5_0._whirlFlyBack, arg_5_0)

			return
		end
	end

	ExploreController.instance:getMap():getHero():setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Interact, true, false)

	arg_5_0._triggerType = nil
end

function var_0_0.playAnim(arg_6_0, arg_6_1)
	if arg_6_1 == ExploreAnimEnum.AnimName.nToA and arg_6_0._displayTr then
		local var_6_0 = ExploreController.instance:getMapWhirl():getWhirl(ExploreEnum.WhirlType.Rune)

		if var_6_0 then
			ExploreModel.instance:setStepPause(true)
			ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Rune)
			var_6_0:flyToPos(false, arg_6_0._realPlayNToA, arg_6_0)

			return
		end
	end

	var_0_0.super.playAnim(arg_6_0, arg_6_1)
end

function var_0_0.getHeroDir(arg_7_0)
	return ExploreController.instance:getMap():getHero().dir
end

function var_0_0.onAnimEnd(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == ExploreAnimEnum.AnimName.nToA or arg_8_1 == ExploreAnimEnum.AnimName.aToN then
		arg_8_0.mo:checkActiveCount()
	end
end

function var_0_0._whirlFlyBack(arg_9_0)
	local var_9_0 = ExploreController.instance:getMapWhirl():getWhirl(ExploreEnum.WhirlType.Rune)

	if var_9_0 then
		var_9_0:flyBack()
	end
end

function var_0_0._realPlayNToA(arg_10_0)
	var_0_0.super.playAnim(arg_10_0, ExploreAnimEnum.AnimName.nToA)
end

return var_0_0
