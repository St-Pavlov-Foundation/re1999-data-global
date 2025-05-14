module("modules.logic.versionactivity1_2.yaxian.controller.YaXianController", package.seeall)

local var_0_0 = class("YaXianController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.openYaXianMapView(arg_3_0, arg_3_1)
	local var_3_0, var_3_1, var_3_2 = ActivityHelper.getActivityStatusAndToast(YaXianEnum.ActivityId)

	if var_3_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_3_1 then
			GameFacade.showToastWithTableParam(var_3_1, var_3_2)
		end

		return
	end

	if not VersionActivityBaseController.instance:isPlayedActivityVideo(YaXianEnum.ActivityId) then
		local var_3_3 = ActivityConfig.instance:getActivityCo(YaXianEnum.ActivityId)
		local var_3_4 = var_3_3 and var_3_3.storyId

		if var_3_4 and var_3_4 ~= 0 then
			arg_3_0.enterChapterId = arg_3_1

			StoryController.instance:playStory(var_3_4, nil, arg_3_0._onFinishStory, arg_3_0)

			return
		end
	end

	Activity115Rpc.instance:sendGetAct115InfoRequest(YaXianEnum.ActivityId, function()
		ViewMgr.instance:openView(ViewName.YaXianMapView, {
			chapterId = arg_3_1
		})
	end)
end

function var_0_0._onFinishStory(arg_5_0)
	arg_5_0:openYaXianMapView(arg_5_0.enterChapterId)

	arg_5_0.enterChapterId = nil
end

function var_0_0.getChapterStatus(arg_6_0, arg_6_1)
	local var_6_0 = YaXianConfig.instance:getChapterConfig(arg_6_1)
	local var_6_1 = var_6_0 and var_6_0.openId

	if var_6_1 and var_6_1 ~= 0 and not OpenModel.instance:isFunctionUnlock(var_6_1) then
		return YaXianEnum.ChapterStatus.notOpen
	end

	if not YaXianModel.instance:chapterIsUnlock(arg_6_1) then
		return YaXianEnum.ChapterStatus.Lock
	end

	return YaXianEnum.ChapterStatus.Normal
end

function var_0_0.checkChapterIsUnlock(arg_7_0, arg_7_1)
	return arg_7_0:getChapterStatus(arg_7_1) == YaXianEnum.ChapterStatus.Normal
end

var_0_0.instance = var_0_0.New()

return var_0_0
