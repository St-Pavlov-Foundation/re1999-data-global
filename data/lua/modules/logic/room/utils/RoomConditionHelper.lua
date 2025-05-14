module("modules.logic.room.utils.RoomConditionHelper", package.seeall)

local var_0_0 = {}

var_0_0._conditionFunction = nil

function var_0_0._getFuncDict()
	if not var_0_0._conditionFunction then
		var_0_0._conditionFunction = {
			EpisodeFinish = function(arg_2_0)
				return DungeonModel.instance:hasPassLevelAndStory(tonumber(arg_2_0))
			end,
			FinishTask = function(arg_3_0)
				local var_3_0 = TaskModel.instance:getTaskById(tonumber(arg_3_0))

				return var_3_0 and var_3_0.finishCount >= var_3_0.config.maxFinishCount
			end,
			OpenFunction = function(arg_4_0)
				return OpenModel.instance:isFunctionUnlock(tonumber(arg_4_0))
			end,
			ChapterMapElement = function(arg_5_0)
				return DungeonMapModel.instance:elementIsFinished(tonumber(arg_5_0))
			end,
			HasHeroId = function(arg_6_0)
				local var_6_0 = HeroModel.instance:getByHeroId(tonumber(arg_6_0))

				return var_6_0 and var_6_0:isOwnHero()
			end,
			HeroSkinId = function(arg_7_0)
				local var_7_0 = string.splitToNumber(arg_7_0, "#")

				if var_7_0 and #var_7_0 > 1 then
					local var_7_1 = HeroModel.instance:getByHeroId(var_7_0[1])

					if var_7_1 and var_7_1.skin == var_7_0[2] then
						return true
					end
				end

				return false
			end
		}
	end

	return var_0_0._conditionFunction
end

function var_0_0.isConditionStr(arg_8_0)
	if string.nilorempty(arg_8_0) then
		return true
	end

	local var_8_0 = var_0_0._getFuncDict()
	local var_8_1 = true
	local var_8_2 = string.split(arg_8_0, " or ")

	for iter_8_0, iter_8_1 in ipairs(var_8_2) do
		local var_8_3 = string.split(iter_8_1, " and ")

		if var_8_3 and #var_8_3 > 0 then
			var_8_1 = true

			for iter_8_2, iter_8_3 in ipairs(var_8_3) do
				local var_8_4 = string.split(iter_8_3, "=")
				local var_8_5 = var_8_0[string.trim(var_8_4[1])]

				if var_8_5 and not var_8_5(var_8_4[2]) then
					var_8_1 = false

					break
				end
			end
		end

		if var_8_1 then
			return true
		end
	end

	return var_8_1
end

return var_0_0
