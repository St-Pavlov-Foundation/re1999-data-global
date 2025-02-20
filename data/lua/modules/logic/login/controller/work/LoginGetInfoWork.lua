module("modules.logic.login.controller.work.LoginGetInfoWork", package.seeall)

slot0 = class("LoginGetInfoWork", BaseWork)

function slot0._initInfo(slot0)
	slot0.GetInfoFuncList = {
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
		table.insert(slot0.GetInfoFuncList, {
			WeekwalkRpc.sendGetWeekwalkInfoRequest,
			WeekwalkRpc.instance,
			"sendGetWeekwalkInfoRequest",
			false
		})
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Explore) then
		table.insert(slot0.GetInfoFuncList, {
			ExploreRpc.sendGetExploreSimpleInfoRequest,
			ExploreRpc.instance,
			"sendGetExploreSimpleInfoRequest",
			false
		})
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Tower) then
		table.insert(slot0.GetInfoFuncList, {
			TowerRpc.sendGetTowerInfoRequest,
			TowerRpc.instance,
			"sendGetTowerInfoRequest",
			false
		})
	end

	slot0._callbackIdDict = {}
end

function slot0.onStart(slot0, slot1)
	slot0:_initInfo()

	slot0._leftInfoCount = #slot0.GetInfoFuncList
	slot0._waitCount = 0
	slot0._waitCount = slot0._waitCount + 1
	slot5 = DungeonEvent.OnUpdateDungeonInfo
	slot6 = slot0._onDungeonInfoUpdateAll

	DungeonController.instance:registerCallback(slot5, slot6, slot0)

	for slot5, slot6 in ipairs(slot0.GetInfoFuncList) do
		slot7 = slot6[1]
		slot8 = slot6[2]
		slot9 = slot6[3]
		slot10 = slot6[4]

		function slot12(slot0, slot1, slot2)
			if not uv0 and slot1 ~= 0 then
				logWarn((uv1.__cname or "nil") .. " " .. uv2 .. " 服务端报错了 resultCode = " .. slot1)
			end

			uv3:_onGetInfo(uv4)
		end

		slot13 = nil

		if (slot6[5] == nil or slot7(slot8, slot11, slot12)) and slot7(slot8, slot12) then
			slot0._callbackIdDict[slot5] = slot13
		else
			logWarn((slot8.__cname or "nil") .. " " .. slot9 .. " 不支持callback")
			slot0:_onGetInfo(slot5)
		end
	end

	TaskDispatcher.runDelay(slot0._getInfoTimeout, slot0, 30)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnLostConnect, slot0._onLostConnect, slot0)
end

function slot0._onGetInfo(slot0, slot1)
	if slot0._callbackIdDict[slot1] == nil then
		logError("登录流程有问题 index:" .. slot1)

		return
	end

	slot0._leftInfoCount = slot0._leftInfoCount - 1
	slot0._callbackIdDict[slot1] = nil

	slot0:_checkIsDone()
end

function slot0._checkIsDone(slot0)
	if slot0._leftInfoCount == 0 and slot0._waitCount == 0 then
		LoginController.instance:dispatchEvent(LoginEvent.OnGetInfoFinish)
		slot0:onDone(true)
	end
end

function slot0._onDungeonInfoUpdateAll(slot0)
	slot0._waitCount = slot0._waitCount - 1

	DungeonController.instance:unregisterCallback(DungeonEvent.OnUpdateDungeonInfo, slot0._onDungeonInfoUpdateAll, slot0)
	slot0:_checkIsDone()
end

function slot0._getInfoTimeout(slot0)
	for slot4, slot5 in pairs(slot0._callbackIdDict) do
		slot6 = slot0.GetInfoFuncList[slot4]

		slot6[2]:removeCallbackById(slot5)
		logError("获取信息超时，跳过保证不卡登录流程：" .. slot6[3])
	end

	PayController.instance:clearAllQueryProductDetailsCallBack()

	slot0._callbackIdDict = {}

	LoginController.instance:stopHeartBeat()
	ConnectAliveMgr.instance:stopReconnect()
	MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.LoginLostConnect1, MsgBoxEnum.BoxType.Yes, function ()
		LoginController.instance:logout()
	end)
	slot0:onDone(false)
end

function slot0._onLostConnect(slot0)
end

function slot0.clearWork(slot0)
	slot0:_removeEvents()

	for slot4, slot5 in pairs(slot0._callbackIdDict) do
		slot0.GetInfoFuncList[slot4][2]:removeCallbackById(slot5)
	end

	slot0._callbackIdDict = {}
end

function slot0._removeEvents(slot0)
	TaskDispatcher.cancelTask(slot0._getInfoTimeout, slot0)
	ConnectAliveMgr.instance:unregisterCallback(ConnectEvent.OnLostConnect, slot0._onLostConnect, slot0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnUpdateDungeonInfo, slot0._onDungeonInfoUpdateAll, slot0)
end

return slot0
