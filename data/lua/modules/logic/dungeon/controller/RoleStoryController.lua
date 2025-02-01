module("modules.logic.dungeon.controller.RoleStoryController", package.seeall)

slot0 = class("RoleStoryController", BaseController)

function slot0.addConstEvents(slot0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, slot0._onGetInfoFinish, slot0)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, slot0._onFuncOpen, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
end

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0._onFuncOpen(slot0, slot1)
	if tabletool.indexOf(slot1, OpenEnum.UnlockFunc.RoleStory) then
		HeroStoryRpc.instance:sendGetHeroStoryRequest()
	end
end

function slot0._onGetInfoFinish(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.RoleStory) then
		HeroStoryRpc.instance:sendGetHeroStoryRequest()
	end
end

function slot0.openRoleStoryDispatchMainView(slot0, slot1)
	if not RoleStoryModel.instance:checkActStoryOpen() then
		if ViewMgr.instance:isOpen(ViewName.RoleStoryDispatchMainView) then
			ViewMgr.instance:closeView(ViewName.RoleStoryDispatchMainView)
		end

		GameFacade.showToast(ToastEnum.BattlePass)

		return false
	end

	HeroStoryRpc.instance:sendGetHeroStoryRequest(function ()
		ViewMgr.instance:openView(ViewName.RoleStoryDispatchMainView, uv0)
	end)

	return true
end

function slot0.openRoleStoryActivityMainView(slot0, slot1)
	if not RoleStoryModel.instance:checkActStoryOpen() then
		if ViewMgr.instance:isOpen(ViewName.RoleStoryActivityMainView) then
			ViewMgr.instance:closeView(ViewName.RoleStoryActivityMainView)
		end

		GameFacade.showToast(ToastEnum.BattlePass)

		return false
	end

	HeroStoryRpc.instance:sendGetHeroStoryRequest(function ()
		ViewMgr.instance:openView(ViewName.RoleStoryActivityMainView, uv0)
	end)

	return true
end

function slot0.enterRoleStoryChapter(slot0, slot1)
	if not slot1 or slot1 == 0 then
		return
	end

	RoleStoryModel.instance:setCurStoryId(slot1)
	DungeonController.instance:openDungeonChapterView({
		chapterId = RoleStoryConfig.instance:getStoryById(slot1).chapterId
	})
end

function slot0.openDispatchView(slot0, slot1)
	if not slot1 or slot1 == 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.RoleStoryDispatchView, {
		storyId = slot1
	})
end

function slot0.openReviewView(slot0)
	if not RoleStoryModel.instance:getCurStoryId() or slot1 == 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.RoleStoryReviewView, {
		storyId = slot1
	})
end

function slot0._onDailyRefresh(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.RoleStory) then
		HeroStoryRpc.instance:sendGetHeroStoryRequest()
	end
end

slot0.instance = slot0.New()

return slot0
