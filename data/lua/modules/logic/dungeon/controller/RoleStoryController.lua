module("modules.logic.dungeon.controller.RoleStoryController", package.seeall)

local var_0_0 = class("RoleStoryController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, arg_1_0._onGetInfoFinish, arg_1_0)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, arg_1_0._onFuncOpen, arg_1_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_1_0._onDailyRefresh, arg_1_0)
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0._onFuncOpen(arg_4_0, arg_4_1)
	if tabletool.indexOf(arg_4_1, OpenEnum.UnlockFunc.RoleStory) then
		HeroStoryRpc.instance:sendGetHeroStoryRequest()
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.NecrologistStory
		})
	end
end

function var_0_0._onGetInfoFinish(arg_5_0)
	NecrologistStoryRpc.instance:sendGetNecrologistStoryRequest(NecrologistStoryEnum.RoleStoryId.V3A1)

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.RoleStory) then
		HeroStoryRpc.instance:sendGetHeroStoryRequest()
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.NecrologistStory
		})
	end
end

function var_0_0.openRoleStoryDispatchMainView(arg_6_0, arg_6_1)
	if not RoleStoryModel.instance:checkActStoryOpen() then
		if ViewMgr.instance:isOpen(ViewName.RoleStoryDispatchMainView) then
			ViewMgr.instance:closeView(ViewName.RoleStoryDispatchMainView)
		end

		GameFacade.showToast(ToastEnum.BattlePass)

		return false
	end

	HeroStoryRpc.instance:sendGetHeroStoryRequest(function()
		ViewMgr.instance:openView(ViewName.RoleStoryDispatchMainView, arg_6_1)
	end)

	return true
end

function var_0_0.openRoleStoryActivityMainView(arg_8_0, arg_8_1)
	if not RoleStoryModel.instance:checkActStoryOpen() then
		if ViewMgr.instance:isOpen(ViewName.RoleStoryActivityMainView) then
			ViewMgr.instance:closeView(ViewName.RoleStoryActivityMainView)
		end

		GameFacade.showToast(ToastEnum.BattlePass)

		return false
	end

	HeroStoryRpc.instance:sendGetHeroStoryRequest(function()
		ViewMgr.instance:openView(ViewName.RoleStoryActivityMainView, arg_8_1)
	end)

	return true
end

function var_0_0.enterRoleStoryChapter(arg_10_0, arg_10_1)
	if not arg_10_1 or arg_10_1 == 0 then
		return
	end

	RoleStoryModel.instance:setCurStoryId(arg_10_1)

	local var_10_0 = RoleStoryConfig.instance:getStoryById(arg_10_1)
	local var_10_1 = {
		chapterId = var_10_0.chapterId
	}

	DungeonController.instance:openDungeonChapterView(var_10_1)
end

function var_0_0.openDispatchView(arg_11_0, arg_11_1)
	if not arg_11_1 or arg_11_1 == 0 then
		return
	end

	local var_11_0 = {
		storyId = arg_11_1
	}

	ViewMgr.instance:openView(ViewName.RoleStoryDispatchView, var_11_0)
end

function var_0_0.openReviewView(arg_12_0)
	local var_12_0 = RoleStoryModel.instance:getCurStoryId()

	if not var_12_0 or var_12_0 == 0 then
		return
	end

	local var_12_1 = {
		storyId = var_12_0
	}

	ViewMgr.instance:openView(ViewName.RoleStoryReviewView, var_12_1)
end

function var_0_0._onDailyRefresh(arg_13_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.RoleStory) then
		HeroStoryRpc.instance:sendGetHeroStoryRequest()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
