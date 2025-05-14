module("modules.logic.activity.model.Activity109Model", package.seeall)

local var_0_0 = class("Activity109Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.getCurActivityID(arg_3_0)
	return arg_3_0._activity_id
end

function var_0_0.onReceiveGetAct109InfoReply(arg_4_0, arg_4_1)
	arg_4_0._activity_id = arg_4_1.activityId
	arg_4_0._is_all_clear = true
	arg_4_0._episode_data = {}

	arg_4_0:initChapterClear()

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.episodes) do
		local var_4_0 = iter_4_1.id

		arg_4_0._episode_data[var_4_0] = {}
		arg_4_0._episode_data[var_4_0].id = iter_4_1.id
		arg_4_0._episode_data[var_4_0].star = iter_4_1.star
		arg_4_0._episode_data[var_4_0].totalCount = iter_4_1.totalCount

		local var_4_1 = Activity109Config.instance:getEpisodeCo(arg_4_0._activity_id, var_4_0)

		if iter_4_1.star and iter_4_1.star <= 0 then
			arg_4_0._is_all_clear = false

			if var_4_1 then
				arg_4_0._episode_clear[var_4_1.chapterId] = false
			end
		end
	end

	Activity109ChessController.instance:dispatchEvent(ActivityEvent.Refresh109ActivityData)
end

function var_0_0.initChapterClear(arg_5_0)
	arg_5_0._episode_clear = {}

	local var_5_0, var_5_1 = Activity109Config.instance:getEpisodeList(arg_5_0._activity_id)

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		arg_5_0._episode_clear[iter_5_1] = true
	end

	arg_5_0._chapter_id_list = var_5_1
end

function var_0_0.getEpisodeData(arg_6_0, arg_6_1)
	return arg_6_0._episode_data and arg_6_0._episode_data[arg_6_1]
end

function var_0_0.getTaskData(arg_7_0, arg_7_1)
	return TaskModel.instance:getTaskById(arg_7_1)
end

function var_0_0.isAllClear(arg_8_0)
	return arg_8_0._is_all_clear
end

function var_0_0.isChapterClear(arg_9_0, arg_9_1)
	return arg_9_0._episode_clear[arg_9_1]
end

function var_0_0.getChapterList(arg_10_0)
	return arg_10_0._chapter_id_list
end

function var_0_0.increaseCount(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._episode_data and arg_11_0._episode_data[arg_11_1]

	if var_11_0 then
		var_11_0.totalCount = var_11_0.totalCount + 1
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
