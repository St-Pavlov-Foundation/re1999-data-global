module("modules.logic.fight.entity.comp.skill.FightTLEventEntityVisible", package.seeall)

local var_0_0 = class("FightTLEventEntityVisible", FightTimelineTrackItem)
local var_0_1
local var_0_2 = {
	[FightEnum.EffectType.DAMAGEFROMABSORB] = true,
	[FightEnum.EffectType.STORAGEINJURY] = true,
	[FightEnum.EffectType.SHIELDVALUECHANGE] = true,
	[FightEnum.EffectType.SHAREHURT] = true
}

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = FightHelper.getEntity(arg_1_1.fromId)
	local var_1_1 = var_1_0 and var_1_0.skill and var_1_0.skill:sameSkillPlaying()

	if var_1_1 then
		-- block empty
	elseif var_0_1 and arg_1_1.stepUid < var_0_1 then
		return
	end

	if not arg_1_1.isFakeStep then
		var_0_1 = arg_1_1.stepUid
		var_0_0.latestStepUid = var_0_1
	end

	local var_1_2 = tonumber(arg_1_3[1]) or 1
	local var_1_3 = tonumber(arg_1_3[2]) or 1
	local var_1_4 = tonumber(arg_1_3[3]) or 0.2
	local var_1_5 = FightHelper.getEntity(arg_1_1.fromId)
	local var_1_6 = FightHelper.getDefenders(arg_1_1, false, var_0_2)
	local var_1_7 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_1_8 = var_1_7:getTagUnitDict(SceneTag.UnitPlayer)
	local var_1_9 = var_1_7:getTagUnitDict(SceneTag.UnitMonster)
	local var_1_10 = var_1_5:isMySide() and var_1_8 or var_1_9
	local var_1_11 = var_1_5:isMySide() and var_1_9 or var_1_8
	local var_1_12, var_1_13 = arg_1_0:_getVisibleList(var_1_5, var_1_6, var_1_10, var_1_2, var_1_11, var_1_3, arg_1_1)

	if not string.nilorempty(arg_1_3[5]) then
		local var_1_14 = FightHelper.getEntity(arg_1_1.stepUid .. "_" .. arg_1_3[5])

		if var_1_14 then
			table.insert(var_1_13, var_1_14)
		end
	end

	if not string.nilorempty(arg_1_3[6]) then
		local var_1_15 = FightHelper.getEntity(arg_1_1.stepUid .. "_" .. arg_1_3[6])

		if var_1_15 then
			table.insert(var_1_12, var_1_15)
		end
	end

	for iter_1_0, iter_1_1 in ipairs(var_1_12) do
		FightController.instance:dispatchEvent(FightEvent.SetEntityVisibleByTimeline, iter_1_1, arg_1_1, true, var_1_4)
	end

	if arg_1_3[4] == "1" and var_1_1 then
		-- block empty
	else
		for iter_1_2, iter_1_3 in ipairs(var_1_13) do
			local var_1_16 = true

			if var_1_16 then
				FightController.instance:dispatchEvent(FightEvent.SetEntityVisibleByTimeline, iter_1_3, arg_1_1, false, var_1_4)
			end
		end
	end
end

function var_0_0._getVisibleList(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)
	local var_2_0 = {}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_3) do
		local var_2_2

		if arg_2_4 == 0 then
			var_2_2 = true
		elseif arg_2_4 == 1 then
			var_2_2 = false
		elseif arg_2_4 == 2 then
			var_2_2 = arg_2_1 ~= iter_2_1
		elseif arg_2_4 == 3 then
			var_2_2 = arg_2_1 == iter_2_1
		elseif arg_2_4 == 4 then
			var_2_2 = arg_2_1 ~= iter_2_1 and not tabletool.indexOf(arg_2_2, iter_2_1)
		end

		if var_2_2 then
			table.insert(var_2_0, iter_2_1)
		else
			table.insert(var_2_1, iter_2_1)
		end
	end

	for iter_2_2, iter_2_3 in pairs(arg_2_5) do
		local var_2_3

		if arg_2_6 == 0 then
			var_2_3 = true
		elseif arg_2_6 == 1 then
			var_2_3 = false
		elseif arg_2_6 == 2 then
			var_2_3 = not tabletool.indexOf(arg_2_2, iter_2_3)

			if var_2_3 then
				local var_2_4 = iter_2_3:getMO()

				if var_2_4 then
					local var_2_5 = FightConfig.instance:getSkinCO(var_2_4.skin)

					if var_2_5 and var_2_5.canHide == 1 then
						var_2_3 = false
					end
				end
			end
		elseif arg_2_6 == 3 then
			var_2_3 = tabletool.indexOf(arg_2_2, iter_2_3)
		elseif arg_2_6 == 4 then
			var_2_3 = iter_2_3.id ~= arg_2_7.toId
		end

		if var_2_3 then
			table.insert(var_2_0, iter_2_3)
		else
			table.insert(var_2_1, iter_2_3)
		end
	end

	return var_2_1, var_2_0
end

return var_0_0
