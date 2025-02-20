module("modules.logic.summon.controller.SummonMainController", package.seeall)

slot0 = class("SummonMainController", BaseController)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._pickHandlerMap = {
		[SummonEnum.TabContentIndex.CharNormal] = slot0.pickCharNormalRes,
		[SummonEnum.TabContentIndex.EquipNormal] = slot0.pickEquipNormalRes,
		[SummonEnum.TabContentIndex.CharNewbie] = slot0.pickCharNewbieRes,
		[SummonEnum.TabContentIndex.CharProbUp] = slot0.pickCharProbUpRes,
		[SummonEnum.TabContentIndex.EquipProbUp] = slot0.pickEquipProbUpRes
	}
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.handleDailyRefresh, slot0)
end

function slot0.openSummonView(slot0, slot1, slot2, slot3, slot4)
	SummonMainModel.instance:initCategory()
	SummonMainModel.instance:resetTabResSettings()
	SummonMainCategoryListModel.instance:initCategory()

	if slot1 and slot1.jumpPoolId or slot0:trySetDefaultPoolId(slot1) then
		SummonMainModel.instance:trySetSelectPoolId(slot5)
	end

	if slot1 and slot1.jumpPoolId ~= nil and slot1.defaultTabIds == nil and SummonConfig.instance:getSummonPool(slot1.jumpPoolId) then
		slot1.defaultTabIds = {
			[3] = SummonMainModel.instance:getADPageTabIndexForUI(slot6)
		}
	end

	slot0._openByEnterScene = slot2

	logNormal("openSummonView jumpPoolId = " .. tostring(slot5))

	slot0._callbackOpen = slot3
	slot0._callbackObjOpen = slot4

	ViewMgr.instance:openView(ViewName.SummonView)

	if slot1 and slot1.hideADView then
		slot0:onViewOpened(ViewName.SummonADView)
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0.onViewOpened, slot0)
		ViewMgr.instance:openView(ViewName.SummonADView, slot1)
	end

	if SummonMainModel.equipPoolIsValid() and SummonModel.instance:getFreeEquipSummon() then
		SummonController.instance:dispatchEvent(SummonEvent.GuideEquipPool)
	end
end

function slot0.trySetDefaultPoolId(slot0, slot1)
	slot2 = nil

	if (slot1 == nil or slot1.defaultTabIds == nil) and SummonMainModel.instance:getFirstValidPool() then
		slot2 = slot3.id

		if slot1 ~= nil then
			slot1.jumpPoolId = slot2
		end

		return slot2
	end
end

function slot0.onViewOpened(slot0, slot1)
	if slot1 == ViewName.SummonADView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onViewOpened, slot0)

		if slot0._callbackOpen then
			slot0._callbackOpen(slot0._callbackObjOpen)
		end

		slot0._callbackOpen = nil
		slot0._callbackObjOpen = nil
	end
end

function slot0.sendStartSummon(slot0, slot1, slot2, slot3, slot4)
	SummonController.instance:setSendPoolId(slot1)

	slot0._needGetInfo = false

	if slot3 then
		slot5 = SummonModel.instance:getFreeEquipSummon()

		SummonModel.instance:setSendEquipFreeSummon(slot5)
		SummonRpc.instance:sendSummonRequest(slot1, slot2)

		if slot5 then
			slot0._needGetInfo = true
		end
	else
		SummonModel.instance:setSendEquipFreeSummon(false)
		SummonRpc.instance:sendSummonRequest(slot1, slot2)

		if slot4 then
			slot0._needGetInfo = true
		end
	end
end

function slot0.getNeedGetInfo(slot0)
	return slot0._needGetInfo
end

function slot0.openSummonDetail(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)

	if SummonConfig.poolIsLuckyBag(slot1.id) then
		if slot2 then
			-- Nothing
		end

		ViewMgr.instance:openView(ViewName.SummonLuckyBagDetailView, {
			poolId = slot1.id,
			poolDetailId = slot1.poolDetail,
			poolAwardTime = slot1.awardTime,
			summonSimulationActId = slot3,
			luckyBagId = slot2
		})
	elseif slot1.type == SummonEnum.Type.CustomPick or slot1.type == SummonEnum.Type.StrongCustomOnePick then
		ViewMgr.instance:openView(ViewName.SummonCustomPickDetailView, slot4)
	else
		ViewMgr.instance:openView(ViewName.SummonPoolDetailView, slot4)
	end
end

function slot0.isFromSceneOpen(slot0)
	return slot0._openByEnterScene
end

function slot0.pickAllUIPreloadRes(slot0)
	slot1 = {}
	slot2 = {}

	for slot7, slot8 in ipairs(SummonMainModel.getValidPools()) do
		if SummonMainModel.instance:getADPageTabIndexForUI(slot8) and SummonMainModel.instance:getUIClassDef(slot9) and slot10.preloadList then
			for slot14, slot15 in ipairs(slot10.preloadList) do
				if not slot1[slot15] then
					table.insert(slot2, slot15)

					slot1[slot15] = true
				end
			end
		end
	end

	return slot2
end

function slot0.getCurPoolPreloadRes(slot0)
	slot1 = {}
	slot2 = {}

	if SummonConfig.instance:getSummonPool(SummonMainModel.instance:getCurId()) then
		slot6 = SummonMainModel.defaultUIClzMap[SummonMainModel.getADPageTabIndex(slot4)]
		slot7 = nil

		if not string.nilorempty(slot4.customClz) then
			slot7 = _G[slot4.customClz]
		end

		if (slot7 or slot6) and slot7.preloadList then
			for slot11, slot12 in ipairs(slot7.preloadList) do
				if not slot1[slot12] then
					table.insert(slot2, slot12)

					slot1[slot12] = true
				end
			end
		end
	end

	return slot2
end

function slot0.handleDailyRefresh(slot0)
	SummonRpc.instance:sendGetSummonInfoRequest()
end

slot0.instance = slot0.New()

return slot0
