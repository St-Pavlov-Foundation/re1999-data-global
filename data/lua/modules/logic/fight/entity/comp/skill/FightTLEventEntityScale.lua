module("modules.logic.fight.entity.comp.skill.FightTLEventEntityScale", package.seeall)

local var_0_0 = class("FightTLEventEntityScale", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._paramsArr = arg_1_3
	arg_1_0._targetScale = tonumber(arg_1_3[1])
	arg_1_0._revertScale = arg_1_3[5] == "1"

	local var_1_0 = arg_1_3[2]
	local var_1_1 = arg_1_3[3] == "1"
	local var_1_2

	if var_1_0 == "1" then
		var_1_2 = {}

		table.insert(var_1_2, FightHelper.getEntity(arg_1_1.fromId))
	elseif var_1_0 == "2" then
		var_1_2 = FightHelper.getSkillTargetEntitys(arg_1_1)
	elseif var_1_0 == "3" then
		local var_1_3 = FightHelper.getEntity(arg_1_1.fromId)

		var_1_2 = FightHelper.getSideEntitys(var_1_3:getSide(), true)
	elseif var_1_0 == "4" then
		local var_1_4 = FightHelper.getEntity(arg_1_1.toId)

		if var_1_4 then
			var_1_2 = FightHelper.getSideEntitys(var_1_4:getSide(), true)
		else
			var_1_2 = {}
		end
	end

	if not string.nilorempty(arg_1_3[4]) then
		local var_1_5 = FightHelper.getEntity(arg_1_1.stepUid .. "_" .. arg_1_3[4])

		var_1_2 = {}

		if var_1_5 then
			table.insert(var_1_2, var_1_5)
		end
	end

	if var_1_1 then
		for iter_1_0, iter_1_1 in ipairs(var_1_2) do
			local var_1_6 = arg_1_0:_getScale(iter_1_1)

			iter_1_1:setScale(var_1_6)
			FightHelper.refreshCombinativeMonsterScaleAndPos(iter_1_1, var_1_6)
		end
	elseif #var_1_2 > 0 then
		arg_1_0._tweenList = {}

		for iter_1_2, iter_1_3 in ipairs(var_1_2) do
			if not gohelper.isNil(iter_1_3.go) then
				local var_1_7 = iter_1_3:getScale() or 1
				local var_1_8 = arg_1_0:_getScale(iter_1_3)
				local var_1_9 = ZProj.TweenHelper.DOTweenFloat(var_1_7, var_1_8, arg_1_2, function(arg_2_0)
					if iter_1_3.go then
						iter_1_3:setScale(arg_2_0)
						FightHelper.refreshCombinativeMonsterScaleAndPos(iter_1_3, arg_2_0)
					end
				end)

				table.insert(arg_1_0._tweenList, var_1_9)
			end
		end
	end
end

function var_0_0._getScale(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1 and arg_3_1:getMO()

	if arg_3_0._revertScale and var_3_0 then
		local var_3_1, var_3_2, var_3_3, var_3_4 = FightHelper.getEntityStandPos(var_3_0)

		return var_3_4
	end

	if var_3_0 and not string.nilorempty(arg_3_0._paramsArr[6]) then
		local var_3_5 = FightStrUtil.instance:getSplitCache(arg_3_0._paramsArr[6], "|")

		for iter_3_0, iter_3_1 in ipairs(var_3_5) do
			local var_3_6 = FightStrUtil.instance:getSplitToNumberCache(iter_3_1, "_")

			if var_3_0.skin == var_3_6[1] then
				return var_3_6[2]
			end
		end
	end

	return arg_3_0._targetScale
end

function var_0_0.onTrackEnd(arg_4_0)
	arg_4_0:_clear()
end

function var_0_0.onDestructor(arg_5_0)
	arg_5_0:_clear()
end

function var_0_0._clear(arg_6_0)
	if arg_6_0._tweenList then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0._tweenList) do
			ZProj.TweenHelper.KillById(iter_6_1)
		end

		arg_6_0._tweenList = nil
	end
end

return var_0_0
