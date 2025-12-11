module("modules.logic.necrologiststory.controller.NecrologistStoryController", package.seeall)

local var_0_0 = class("NecrologistStoryController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.addConstEvents(arg_2_0)
	return
end

function var_0_0.reInit(arg_3_0)
	return
end

function var_0_0.openTipView(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {
		tagId = arg_4_1,
		clickPosition = arg_4_2
	}

	ViewMgr.instance:openView(ViewName.NecrologistStoryTipView, var_4_0)
end

function var_0_0.closeGameView(arg_5_0, arg_5_1)
	if not arg_5_1 or arg_5_1 == 0 then
		return
	end

	local var_5_0 = NecrologistStoryEnum.StoryId2GameView[arg_5_1]

	if not var_5_0 then
		return
	end

	ViewMgr.instance:closeView(var_5_0)
end

function var_0_0.openGameView(arg_6_0, arg_6_1)
	if not arg_6_1 or arg_6_1 == 0 then
		return
	end

	arg_6_0._curStoryId = arg_6_1

	local var_6_0 = RoleStoryModel.instance:getMoById(arg_6_1)

	if not var_6_0 then
		return
	end

	if var_6_0.hasUnlock then
		arg_6_0:_onUnlockStory(0, 0)
	else
		HeroStoryRpc.instance:sendUnlocHeroStoryRequest(arg_6_1, arg_6_0._onUnlockStory, arg_6_0)
	end
end

function var_0_0._onUnlockStory(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2 ~= 0 then
		return
	end

	if not arg_7_0._curStoryId then
		return
	end

	NecrologistStoryRpc.instance:sendGetNecrologistStoryRequest(arg_7_0._curStoryId, arg_7_0._openCurView, arg_7_0)
end

function var_0_0._openCurView(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 ~= 0 then
		return
	end

	if not arg_8_0._curStoryId then
		return
	end

	local var_8_0 = NecrologistStoryEnum.StoryId2GameView[arg_8_0._curStoryId]

	if not var_8_0 then
		return
	end

	ViewMgr.instance:openView(var_8_0, {
		roleStoryId = arg_8_0._curStoryId
	})
end

function var_0_0.openStoryView(arg_9_0, arg_9_1, arg_9_2)
	ViewMgr.instance:openView(ViewName.NecrologistStoryView, {
		storyGroupId = arg_9_1,
		roleStoryId = arg_9_2
	})
end

function var_0_0.openTaskView(arg_10_0, arg_10_1)
	ViewMgr.instance:openView(ViewName.NecrologistStoryTaskView, {
		roleStoryId = arg_10_1
	})
end

function var_0_0.openReviewView(arg_11_0, arg_11_1)
	ViewMgr.instance:openView(ViewName.NecrologistStoryReviewView, {
		roleStoryId = arg_11_1
	})
end

function var_0_0.openCgUnlockView(arg_12_0, arg_12_1)
	ViewMgr.instance:openView(ViewName.NecrologistStoryReviewView, {
		cgUnlock = true,
		roleStoryId = arg_12_1
	})
end

function var_0_0.getNecrologistStoryActivityRed(arg_13_0, arg_13_1)
	return RedDotModel.instance:isDotShow(RedDotEnum.DotNode.NecrologistStoryTask, arg_13_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
