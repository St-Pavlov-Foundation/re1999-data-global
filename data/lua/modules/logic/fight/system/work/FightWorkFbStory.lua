module("modules.logic.fight.system.work.FightWorkFbStory", package.seeall)

local var_0_0 = class("FightWorkFbStory", BaseWork)

var_0_0.Type_EnterWave = 1
var_0_0.Type_BeforePlaySkill = 2

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.conditionType = arg_1_1
	arg_1_0.exParam = arg_1_2

	local var_1_0 = FightModel.instance:getFightParam()

	arg_1_0.episodeId = var_1_0 and var_1_0.episodeId

	local var_1_1 = arg_1_0.episodeId and DungeonConfig.instance:getEpisodeCO(arg_1_0.episodeId)
	local var_1_2 = var_1_1 and string.split(var_1_1.story, "#")

	arg_1_0.configCondType = var_1_2 and tonumber(var_1_2[1])
	arg_1_0.configCondParam = var_1_2 and var_1_2[2]
	arg_1_0.configCondStoryId = var_1_2 and tonumber(var_1_2[3])
end

function var_0_0.onStart(arg_2_0)
	if not arg_2_0.configCondType or arg_2_0.conditionType ~= arg_2_0.configCondType then
		arg_2_0:onDone(true)

		return
	end

	if arg_2_0.configCondType == 1 then
		if FightModel.instance:getCurWaveId() ~= tonumber(arg_2_0.configCondParam) then
			arg_2_0:onDone(true)

			return
		end

		arg_2_0:_checkPlayStory()
	elseif arg_2_0.configCondType == 2 then
		local var_2_0 = tonumber(arg_2_0.configCondParam)

		if not var_2_0 or not arg_2_0.exParam or arg_2_0.exParam ~= var_2_0 then
			arg_2_0:onDone(true)

			return
		end

		arg_2_0:_checkPlayStory()
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0._checkPlayStory(arg_3_0)
	if StoryModel.instance:isStoryFinished(arg_3_0.configCondStoryId) then
		arg_3_0:onDone(true)

		return
	end

	arg_3_0:_setAllEntitysVisible(false)

	local var_3_0 = {}

	var_3_0.mark = true
	var_3_0.episodeId = arg_3_0.episodeId

	StoryController.instance:playStory(arg_3_0.configCondStoryId, var_3_0, arg_3_0._afterPlayStory, arg_3_0)
end

function var_0_0._afterPlayStory(arg_4_0)
	arg_4_0:_setAllEntitysVisible(true)
	arg_4_0:onDone(true)
end

function var_0_0._setAllEntitysVisible(arg_5_0, arg_5_1)
	local var_5_0 = FightHelper.getAllEntitys()

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		iter_5_1:setActive(arg_5_1)
	end
end

function var_0_0.checkHasFbStory()
	local var_6_0 = FightModel.instance:getFightParam()
	local var_6_1 = var_6_0 and var_6_0.episodeId
	local var_6_2 = var_6_1 and DungeonConfig.instance:getEpisodeCO(var_6_1)

	return var_6_2 and not string.nilorempty(var_6_2.story)
end

return var_0_0
