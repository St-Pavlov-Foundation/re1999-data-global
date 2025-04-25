module("modules.logic.open.controller.OpenController", package.seeall)

slot0 = class("OpenController", BaseController)

function slot0.onInit(slot0)
end

function slot0.addConstEvents(slot0)
	uv0.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, slot0._onCheckFuncUnlock, slot0)
	MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, slot0._onCheckFuncUnlock, slot0)
	uv0.instance:registerCallback(OpenEvent.NewFuncUnlock, slot0._newFuncUnlock, slot0)
end

function slot0.reInit(slot0)
	TaskDispatcher.cancelTask(slot0._delayCheckFuncUnlock, slot0)
end

function slot0._onCheckFuncUnlock(slot0)
	TaskDispatcher.cancelTask(slot0._delayCheckFuncUnlock, slot0)
	TaskDispatcher.runDelay(slot0._delayCheckFuncUnlock, slot0, 0.2)
end

function slot0._delayCheckFuncUnlock(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend) then
		FriendRpc.instance:sendLoadFriendInfosRequest()
	end

	SignInController.instance:sendGetSignInInfoRequestIfUnlock()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Bank) then
		StoreRpc.instance:sendGetStoreInfosRequest()
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Explore) then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Explore
		})
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Task) then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Daily,
			TaskEnum.TaskType.Weekly,
			TaskEnum.TaskType.Novice,
			TaskEnum.TaskType.WeekWalk,
			TaskEnum.TaskType.ActivityShow
		})
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch) then
		BgmRpc.instance:sendGetBgmInfoRequest()
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Room) then
		RoomController.instance:sendInitRoomObInfo()
	end

	if CritterModel.instance:isCritterUnlock() then
		CritterRpc.instance:sendCritterGetInfoRequest()
	end

	MailRpc.instance:sendGetAllMailsRequest()
	ActivityRpc.instance:sendGetActivityInfosRequest(function ()
		ActivityController.instance:updateAct101Infos()
	end)
	HandbookRpc.instance:sendGetHandbookInfoRequest()
	RedDotRpc.instance:sendGetRedDotInfosRequest()
	DungeonRpc.instance:sendInstructionDungeonInfoRequest()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BP) and not BpModel.instance:hasGetInfo() then
		BpRpc.instance:sendGetBpInfoRequest(false)
	end

	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
	UserSettingRpc.instance:sendGetSettingInfosRequest()
end

function slot0._newFuncUnlock(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot6 == OpenEnum.UnlockFunc.Talent then
			HeroRpc.instance:sendHeroInfoListRequest(slot0._heroInfoUpdate, slot0)
		elseif slot6 == OpenEnum.UnlockFunc.WeekWalk then
			WeekwalkRpc.instance:sendGetWeekwalkInfoRequest()
		elseif slot6 == OpenEnum.UnlockFunc.Explore then
			ExploreRpc.instance:sendGetExploreSimpleInfoRequest()
		end
	end
end

function slot0._heroInfoUpdate(slot0)
	CharacterController.instance:tryStatAllTalent()
end

slot0.instance = slot0.New()

return slot0
