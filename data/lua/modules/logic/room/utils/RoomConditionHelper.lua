module("modules.logic.room.utils.RoomConditionHelper", package.seeall)

return {
	_conditionFunction = nil,
	_getFuncDict = function ()
		if not uv0._conditionFunction then
			uv0._conditionFunction = {
				EpisodeFinish = function (slot0)
					return DungeonModel.instance:hasPassLevelAndStory(tonumber(slot0))
				end,
				FinishTask = function (slot0)
					return TaskModel.instance:getTaskById(tonumber(slot0)) and slot1.config.maxFinishCount <= slot1.finishCount
				end,
				OpenFunction = function (slot0)
					return OpenModel.instance:isFunctionUnlock(tonumber(slot0))
				end,
				ChapterMapElement = function (slot0)
					return DungeonMapModel.instance:elementIsFinished(tonumber(slot0))
				end,
				HasHeroId = function (slot0)
					return HeroModel.instance:getByHeroId(tonumber(slot0)) and slot1:isOwnHero()
				end,
				HeroSkinId = function (slot0)
					if string.splitToNumber(slot0, "#") and #slot1 > 1 and HeroModel.instance:getByHeroId(slot1[1]) and slot2.skin == slot1[2] then
						return true
					end

					return false
				end
			}
		end

		return uv0._conditionFunction
	end,
	isConditionStr = function (slot0)
		if string.nilorempty(slot0) then
			return true
		end

		slot1 = uv0._getFuncDict()
		slot2 = true

		for slot7, slot8 in ipairs(string.split(slot0, " or ")) do
			if string.split(slot8, " and ") and #slot9 > 0 then
				slot2 = true

				for slot13, slot14 in ipairs(slot9) do
					if slot1[string.trim(string.split(slot14, "=")[1])] and not slot16(slot15[2]) then
						slot2 = false

						break
					end
				end
			end

			if slot2 then
				return true
			end
		end

		return slot2
	end
}
