module("modules.logic.versionactivity1_7.doubledrop.model.DoubleDropModel", package.seeall)

local var_0_0 = class("DoubleDropModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.act153Dict = {}
end

function var_0_0.getActId(arg_3_0)
	local var_3_0 = ActivityModel.instance:getOnlineActIdByType(ActivityEnum.ActivityTypeID.DoubleDrop)

	return var_3_0 and var_3_0[1]
end

function var_0_0.setActivity153Infos(arg_4_0, arg_4_1)
	arg_4_0:updateActivity153Info(arg_4_1)
	ActivityController.instance:dispatchEvent(ActivityEvent.RefreshDoubleDropInfo)
end

function var_0_0.updateActivity153Info(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getById(arg_5_1.activityId)

	if not var_5_0 then
		var_5_0 = DoubleDropMo.New()

		var_5_0:init(arg_5_1)
		arg_5_0:addAtLast(var_5_0)
	else
		var_5_0:init(arg_5_1)
	end
end

function var_0_0.isShowDoubleByChapter(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:getActId()

	if not var_6_0 or not ActivityModel.instance:isActOnLine(var_6_0) then
		return false
	end

	local var_6_1 = DoubleDropConfig.instance:getAct153ActEpisodes(var_6_0)

	if not var_6_1 then
		return false
	end

	local var_6_2 = false

	for iter_6_0, iter_6_1 in pairs(var_6_1) do
		local var_6_3 = DungeonConfig.instance:getEpisodeCO(iter_6_1.episodeId)

		if var_6_3 and var_6_3.chapterId == arg_6_1 then
			var_6_2 = true

			break
		end
	end

	if var_6_2 then
		if not arg_6_2 then
			local var_6_4 = DungeonConfig.instance:getChapterCO(arg_6_1)

			if var_6_4.enterAfterFreeLimit > 0 and DungeonModel.instance:getChapterRemainingNum(var_6_4.type) > 0 then
				return false
			end
		end

		local var_6_5, var_6_6, var_6_7 = arg_6_0:isDoubleTimesout()

		return not var_6_5, var_6_6, var_6_7
	end

	return false
end

function var_0_0.isShowDoubleByEpisode(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:getActId()

	if not var_7_0 or not ActivityModel.instance:isActOnLine(var_7_0) then
		return false
	end

	local var_7_1 = DoubleDropConfig.instance:getAct153ActEpisodes(var_7_0)

	if not var_7_1 then
		return false
	end

	local var_7_2 = false

	for iter_7_0, iter_7_1 in pairs(var_7_1) do
		if iter_7_1.episodeId == arg_7_1 then
			var_7_2 = true

			break
		end
	end

	if var_7_2 then
		if not arg_7_2 then
			local var_7_3 = DungeonConfig.instance:getEpisodeCO(arg_7_1)
			local var_7_4 = DungeonConfig.instance:getChapterCO(var_7_3.chapterId)

			if var_7_4.enterAfterFreeLimit > 0 and DungeonModel.instance:getChapterRemainingNum(var_7_4.type) > 0 then
				return false
			end
		end

		local var_7_5, var_7_6, var_7_7 = arg_7_0:isDoubleTimesout()

		return not var_7_5, var_7_6, var_7_7
	end

	return false
end

function var_0_0.isDoubleTimesout(arg_8_0)
	local var_8_0 = arg_8_0:getActId()

	if not var_8_0 or not ActivityModel.instance:isActOnLine(var_8_0) then
		return true
	end

	local var_8_1 = arg_8_0:getById(var_8_0)

	if not var_8_1 then
		return true
	end

	return var_8_1:isDoubleTimesout()
end

function var_0_0.getDailyRemainTimes(arg_9_0)
	local var_9_0 = arg_9_0:getActId()

	if not var_9_0 then
		return
	end

	local var_9_1 = arg_9_0:getById(var_9_0)

	if not var_9_1 then
		local var_9_2 = DoubleDropConfig.instance:getAct153Co(var_9_0)
		local var_9_3 = var_9_2 and var_9_2.dailyLimit or 0

		return var_9_3, var_9_3
	end

	return var_9_1:getDailyRemainTimes()
end

var_0_0.instance = var_0_0.New()

return var_0_0
