module("modules.logic.login.controller.work.LoginGetInfoWork", package.seeall)

local var_0_0 = class("LoginGetInfoWork", BaseWork)

function var_0_0._initInfo(arg_1_0)
	arg_1_0.GetInfoFuncList = {
		{
			PlayerRpc.sendGetSimplePropertyRequest,
			PlayerRpc.instance,
			"sendGetSimplePropertyRequest",
			false
		},
		{
			PlayerRpc.sendGetClothInfoRequest,
			PlayerRpc.instance,
			"sendGetClothInfoRequest",
			false
		},
		{
			HeroRpc.sendHeroInfoListRequest,
			HeroRpc.instance,
			"sendHeroInfoListRequest",
			false
		},
		{
			HeroGroupRpc.sendGetHeroGroupCommonListRequest,
			HeroGroupRpc.instance,
			"sendGetHeroGroupCommonListRequest",
			false
		},
		{
			HeroGroupRpc.sendGetHeroGroupListRequest,
			HeroGroupRpc.instance,
			"sendGetHeroGroupListRequest",
			false
		},
		{
			ItemRpc.sendGetItemListRequest,
			ItemRpc.instance,
			"sendGetItemListRequest",
			false
		},
		{
			DungeonRpc.sendGetDungeonRequest,
			DungeonRpc.instance,
			"sendGetDungeonRequest",
			false
		},
		{
			FightRpc.sendReconnectFightRequest,
			FightRpc.instance,
			"sendReconnectFightRequest",
			true
		},
		{
			CurrencyRpc.sendGetBuyPowerInfoRequest,
			CurrencyRpc.instance,
			"sendGetBuyPowerInfoRequest",
			false
		},
		{
			EquipRpc.sendGetEquipInfoRequest,
			EquipRpc.instance,
			"sendGetEquipInfoRequest",
			false
		},
		{
			StoryRpc.sendGetStoryRequest,
			StoryRpc.instance,
			"sendGetStoryRequest",
			false
		},
		{
			ChargeRpc.sendGetChargeInfoRequest,
			ChargeRpc.instance,
			"sendGetChargeInfoRequest",
			false
		},
		{
			ChargeRpc.sendGetMonthCardInfoRequest,
			ChargeRpc.instance,
			"sendGetMonthCardInfoRequest",
			false
		},
		{
			RoomRpc.sendGetBlockPackageInfoRequset,
			RoomRpc.instance,
			"sendGetBlockPackageInfoRequset",
			false
		},
		{
			RoomRpc.sendGetBuildingInfoRequest,
			RoomRpc.instance,
			"sendGetBuildingInfoRequest",
			false
		},
		{
			RoomRpc.sendGetCharacterInteractionInfoRequest,
			RoomRpc.instance,
			"sendGetCharacterInteractionInfoRequest",
			false
		},
		{
			SummonRpc.sendGetSummonInfoRequest,
			SummonRpc.instance,
			"sendGetSummonInfoRequest",
			false
		},
		{
			AchievementRpc.sendGetAchievementInfoRequest,
			AchievementRpc.instance,
			"sendGetAchievementInfoRequest",
			false
		},
		{
			DialogueRpc.sendGetDialogInfoRequest,
			DialogueRpc.instance,
			"sendGetDialogInfoRequest",
			false
		},
		{
			AntiqueRpc.sendGetAntiqueInfoRequest,
			AntiqueRpc.instance,
			"sendGetAntiqueInfoRequest",
			false
		}
	}

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		table.insert(arg_1_0.GetInfoFuncList, {
			WeekwalkRpc.sendGetWeekwalkInfoRequest,
			WeekwalkRpc.instance,
			"sendGetWeekwalkInfoRequest",
			false
		})
		table.insert(arg_1_0.GetInfoFuncList, {
			Weekwalk_2Rpc.sendWeekwalkVer2GetInfoRequest,
			Weekwalk_2Rpc.instance,
			"sendWeekwalkVer2GetInfoRequest",
			false
		})
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Explore) then
		table.insert(arg_1_0.GetInfoFuncList, {
			ExploreRpc.sendGetExploreSimpleInfoRequest,
			ExploreRpc.instance,
			"sendGetExploreSimpleInfoRequest",
			false
		})
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Tower) then
		table.insert(arg_1_0.GetInfoFuncList, {
			TowerRpc.sendGetTowerInfoRequest,
			TowerRpc.instance,
			"sendGetTowerInfoRequest",
			false
		})
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.PlayerCard) then
		table.insert(arg_1_0.GetInfoFuncList, {
			PlayerCardRpc.sendGetPlayerCardInfoRequest,
			PlayerCardRpc.instance,
			"sendGetPlayerCardInfoRequest",
			false
		})
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CommandStation) then
		table.insert(arg_1_0.GetInfoFuncList, {
			CommandStationRpc.sendGetCommandPostInfoRequest,
			CommandStationRpc.instance,
			"sendGetCommandPostInfoRequest",
			false
		})
	end

	if RougeOutsideController.instance:isOpen() then
		local var_1_0 = RougeOutsideModel.instance:season()

		table.insert(arg_1_0.GetInfoFuncList, {
			RougeOutsideRpc.sendGetRougeOutSideInfoRequest,
			RougeOutsideRpc.instance,
			"sendGetRougeOutSideInfoRequest",
			false,
			var_1_0
		})
	end

	arg_1_0._callbackIdDict = {}
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	arg_2_0:_initInfo()

	arg_2_0._leftInfoCount = #arg_2_0.GetInfoFuncList
	arg_2_0._waitCount = 0
	arg_2_0._waitCount = arg_2_0._waitCount + 1

	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, arg_2_0._onDungeonInfoUpdateAll, arg_2_0)

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.GetInfoFuncList) do
		local var_2_0 = iter_2_1[1]
		local var_2_1 = iter_2_1[2]
		local var_2_2 = iter_2_1[3]
		local var_2_3 = iter_2_1[4]
		local var_2_4 = iter_2_1[5]

		local function var_2_5(arg_3_0, arg_3_1, arg_3_2)
			if not var_2_3 and arg_3_1 ~= 0 then
				logError((var_2_1.__cname or "nil") .. " " .. var_2_2 .. " 服务端报错了 resultCode = " .. arg_3_1)
			end

			arg_2_0:_onGetInfo(iter_2_0)
		end

		local var_2_6

		if var_2_4 ~= nil then
			var_2_6 = var_2_0(var_2_1, var_2_4, var_2_5)
		else
			var_2_6 = var_2_0(var_2_1, var_2_5)
		end

		if var_2_6 then
			arg_2_0._callbackIdDict[iter_2_0] = var_2_6
		else
			logError((var_2_1.__cname or "nil") .. " " .. var_2_2 .. " 不支持callback")
			arg_2_0:_onGetInfo(iter_2_0)
		end
	end

	TaskDispatcher.runDelay(arg_2_0._getInfoTimeout, arg_2_0, 30)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnLostConnect, arg_2_0._onLostConnect, arg_2_0)
end

function var_0_0._onGetInfo(arg_4_0, arg_4_1)
	if arg_4_0._callbackIdDict[arg_4_1] == nil then
		logError("登录流程有问题 index:" .. arg_4_1)

		return
	end

	arg_4_0._leftInfoCount = arg_4_0._leftInfoCount - 1
	arg_4_0._callbackIdDict[arg_4_1] = nil

	arg_4_0:_checkIsDone()
end

function var_0_0._checkIsDone(arg_5_0)
	if arg_5_0._leftInfoCount == 0 and arg_5_0._waitCount == 0 then
		LoginController.instance:dispatchEvent(LoginEvent.OnGetInfoFinish)
		arg_5_0:onDone(true)
	end
end

function var_0_0._onDungeonInfoUpdateAll(arg_6_0)
	arg_6_0._waitCount = arg_6_0._waitCount - 1

	DungeonController.instance:unregisterCallback(DungeonEvent.OnUpdateDungeonInfo, arg_6_0._onDungeonInfoUpdateAll, arg_6_0)
	arg_6_0:_checkIsDone()
end

function var_0_0._getInfoTimeout(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._callbackIdDict) do
		local var_7_0 = arg_7_0.GetInfoFuncList[iter_7_0]
		local var_7_1 = var_7_0[2]
		local var_7_2 = var_7_0[3]

		var_7_1:removeCallbackById(iter_7_1)
		logError("获取信息超时，跳过保证不卡登录流程：" .. var_7_2)
	end

	PayController.instance:clearAllQueryProductDetailsCallBack()

	arg_7_0._callbackIdDict = {}

	LoginController.instance:stopHeartBeat()
	ConnectAliveMgr.instance:stopReconnect()
	MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.LoginLostConnect1, MsgBoxEnum.BoxType.Yes, function()
		LoginController.instance:logout()
	end)
	arg_7_0:onDone(false)
end

function var_0_0._onLostConnect(arg_9_0)
	return
end

function var_0_0.clearWork(arg_10_0)
	arg_10_0:_removeEvents()

	for iter_10_0, iter_10_1 in pairs(arg_10_0._callbackIdDict) do
		arg_10_0.GetInfoFuncList[iter_10_0][2]:removeCallbackById(iter_10_1)
	end

	arg_10_0._callbackIdDict = {}
end

function var_0_0._removeEvents(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._getInfoTimeout, arg_11_0)
	ConnectAliveMgr.instance:unregisterCallback(ConnectEvent.OnLostConnect, arg_11_0._onLostConnect, arg_11_0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnUpdateDungeonInfo, arg_11_0._onDungeonInfoUpdateAll, arg_11_0)
end

return var_0_0
