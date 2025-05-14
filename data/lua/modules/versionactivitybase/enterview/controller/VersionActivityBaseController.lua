module("modules.versionactivitybase.enterview.controller.VersionActivityBaseController", package.seeall)

local var_0_0 = class("VersionActivityBaseController", BaseController)

function var_0_0.isPlayedActivityVideo(arg_1_0, arg_1_1)
	local var_1_0 = ActivityConfig.instance:getActivityCo(arg_1_1)

	if not var_1_0 then
		return true
	end

	if string.nilorempty(var_1_0.storyId) or var_1_0.storyId == 0 then
		return true
	end

	return StoryModel.instance:isStoryFinished(var_1_0.storyId)
end

function var_0_0._initPlayedActUnlockAnimationList(arg_2_0)
	local var_2_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayedActUnlockAnimationKey))

	if string.nilorempty(var_2_0) then
		arg_2_0.playedActUnlockAnimationList = {}

		return
	end

	arg_2_0.playedActUnlockAnimationList = string.splitToNumber(var_2_0, "#")
end

function var_0_0.playedActivityUnlockAnimation(arg_3_0, arg_3_1)
	if not arg_3_1 then
		return
	end

	if not arg_3_0.playedActUnlockAnimationList then
		arg_3_0:_initPlayedActUnlockAnimationList()
	end

	if tabletool.indexOf(arg_3_0.playedActUnlockAnimationList, arg_3_1) then
		return
	end

	table.insert(arg_3_0.playedActUnlockAnimationList, arg_3_1)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayedActUnlockAnimationKey), table.concat(arg_3_0.playedActUnlockAnimationList, "#"))
end

function var_0_0.isPlayedUnlockAnimation(arg_4_0, arg_4_1)
	if not arg_4_0.playedActUnlockAnimationList then
		arg_4_0:_initPlayedActUnlockAnimationList()
	end

	return tabletool.indexOf(arg_4_0.playedActUnlockAnimationList, arg_4_1)
end

function var_0_0.clear(arg_5_0)
	arg_5_0.playedActUnlockAnimationList = nil
	arg_5_0.playedVideosActivityIdList = nil
end

function var_0_0.enterVersionActivityView(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0, var_6_1, var_6_2 = ActivityHelper.getActivityStatusAndToast(arg_6_2)

	if var_6_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_6_1 then
			GameFacade.showToast(var_6_1, var_6_2)
		end

		return
	end

	if arg_6_3 then
		arg_6_3(arg_6_4, arg_6_1, arg_6_2)

		return
	end

	ViewMgr.instance:openView(arg_6_1)
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
