module("modules.logic.fight.entity.comp.skill.FightTLEventEntityRotate", package.seeall)

local var_0_0 = class("FightTLEventEntityRotate", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._attacker = FightHelper.getEntity(arg_1_1.fromId)

	if not arg_1_0._attacker then
		return
	end

	local var_1_0 = string.splitToNumber(arg_1_3[1], ",")
	local var_1_1 = arg_1_3[2]
	local var_1_2 = arg_1_3[3] == "1"
	local var_1_3 = {}

	if var_1_1 == "1" then
		var_1_3 = {}

		table.insert(var_1_3, FightHelper.getEntity(arg_1_1.fromId))
	elseif var_1_1 == "2" then
		var_1_3 = FightHelper.getSkillTargetEntitys(arg_1_1)
	elseif var_1_1 == "3" then
		var_1_3 = FightHelper.getSideEntitys(arg_1_0._attacker:getSide(), true)
	elseif var_1_1 == "4" then
		local var_1_4 = FightHelper.getEntity(arg_1_1.toId)

		if var_1_4 then
			var_1_3 = FightHelper.getSideEntitys(var_1_4:getSide(), true)
		end
	elseif var_1_1 == "5" then
		var_1_3 = FightHelper.getSkillTargetEntitys(arg_1_1)

		local var_1_5 = FightHelper.getEntity(arg_1_1.fromId)

		tabletool.removeValue(var_1_3, var_1_5)
	end

	if not string.nilorempty(arg_1_3[4]) then
		var_1_3 = var_1_3 or {}

		local var_1_6 = string.split(arg_1_3[4], "#")

		for iter_1_0, iter_1_1 in ipairs(var_1_6) do
			local var_1_7 = FightHelper.getEntity(arg_1_1.stepUid .. "_" .. iter_1_1)

			if var_1_7 then
				table.insert(var_1_3, var_1_7)
			end
		end
	end

	local var_1_8 = var_1_0[3]

	if arg_1_3[5] == "1" then
		var_1_8 = arg_1_0._attacker:isEnemySide() and -var_1_0[3] or var_1_0[3]
	end

	for iter_1_2, iter_1_3 in ipairs(var_1_3) do
		local var_1_9 = iter_1_3.spine and iter_1_3.spine:getSpineTr()

		if not gohelper.isNil(var_1_9) then
			if var_1_2 then
				transformhelper.setLocalRotation(var_1_9, var_1_0[1], var_1_0[2], var_1_8)
			else
				arg_1_0._tweenIdList = arg_1_0._tweenIdList or {}

				local var_1_10 = ZProj.TweenHelper.DOLocalRotate(var_1_9, var_1_0[1], var_1_0[2], var_1_8, arg_1_2)

				table.insert(arg_1_0._tweenIdList, var_1_10)
			end
		end
	end
end

function var_0_0._clear(arg_2_0)
	if arg_2_0._tweenIdList then
		for iter_2_0, iter_2_1 in ipairs(arg_2_0._tweenIdList) do
			ZProj.TweenHelper.KillById(iter_2_1)
		end

		arg_2_0._tweenIdList = nil
	end
end

function var_0_0.onDestructor(arg_3_0)
	arg_3_0:_clear()
end

return var_0_0
