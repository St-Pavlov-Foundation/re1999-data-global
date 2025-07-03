module("modules.logic.fight.entity.comp.skill.FightTLEventSetTimelineTime", package.seeall)

local var_0_0 = class("FightTLEventSetTimelineTime", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = tonumber(arg_1_3[1])
	local var_1_1 = var_1_0
	local var_1_2 = FightDataHelper.entityMgr:getById(arg_1_1.fromId)

	if var_1_2 then
		local var_1_3 = string.splitToNumber(arg_1_3[2], "#")

		if #var_1_3 > 0 then
			for iter_1_0, iter_1_1 in ipairs(var_1_3) do
				for iter_1_2, iter_1_3 in pairs(var_1_2:getBuffDic()) do
					if iter_1_3.buffId == iter_1_1 then
						var_1_1 = false

						break
					end
				end

				if not var_1_1 then
					break
				end
			end
		end
	end

	if not string.nilorempty(arg_1_3[3]) then
		local var_1_4 = string.splitToNumber(arg_1_3[3], "#")
		local var_1_5 = false

		for iter_1_4, iter_1_5 in ipairs(var_1_4) do
			if iter_1_5 == arg_1_1.actId then
				var_1_5 = true
			end
		end

		if not var_1_5 then
			var_1_1 = false
		end
	end

	if var_1_1 then
		arg_1_0.binder:SetTime(var_1_0)
	end
end

function var_0_0.onTrackEnd(arg_2_0)
	return
end

function var_0_0.onDestructor(arg_3_0)
	return
end

return var_0_0
