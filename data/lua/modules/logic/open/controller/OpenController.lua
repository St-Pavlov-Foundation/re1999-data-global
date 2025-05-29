module("modules.logic.open.controller.OpenController", package.seeall)

local var_0_0 = class("OpenController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.addConstEvents(arg_2_0)
	var_0_0.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, arg_2_0._onCheckFuncUnlock, arg_2_0)
	MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, arg_2_0._onCheckFuncUnlock, arg_2_0)
	var_0_0.instance:registerCallback(OpenEvent.NewFuncUnlock, arg_2_0._newFuncUnlock, arg_2_0)
end

function var_0_0.reInit(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._delayCheckFuncUnlock, arg_3_0)
end

function var_0_0._onCheckFuncUnlock(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayCheckFuncUnlock, arg_4_0)
	TaskDispatcher.runDelay(arg_4_0._delayCheckFuncUnlock, arg_4_0, 0.2)
end

function var_0_0._delayCheckFuncUnlock(arg_5_0)
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
			TaskEnum.TaskType.WeekWalk_2,
			TaskEnum.TaskType.ActivityShow,
			TaskEnum.TaskType.Activity189
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
	ActivityRpc.instance:sendGetActivityInfosRequest(function()
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

function var_0_0._newFuncUnlock(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		if iter_7_1 == OpenEnum.UnlockFunc.Talent then
			HeroRpc.instance:sendHeroInfoListRequest(arg_7_0._heroInfoUpdate, arg_7_0)
		elseif iter_7_1 == OpenEnum.UnlockFunc.WeekWalk then
			WeekwalkRpc.instance:sendGetWeekwalkInfoRequest()
			Weekwalk_2Rpc.instance:sendWeekwalkVer2GetInfoRequest()
		elseif iter_7_1 == OpenEnum.UnlockFunc.Explore then
			ExploreRpc.instance:sendGetExploreSimpleInfoRequest()
		end
	end
end

function var_0_0._heroInfoUpdate(arg_8_0)
	CharacterController.instance:tryStatAllTalent()
end

var_0_0.instance = var_0_0.New()

return var_0_0
