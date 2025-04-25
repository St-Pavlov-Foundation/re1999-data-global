module("modules.logic.main.controller.MainController", package.seeall)

slot0 = class("MainController", BaseController)

function slot0.addConstEvents(slot0)
	LoginController.instance:registerCallback(LoginEvent.OnLoginEnterMainScene, slot0._onLoginEnterMainScene, slot0)
	PlayerController.instance:registerCallback(PlayerEvent.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.UpdateActivity, slot0._onActivityUpdate, slot0)
end

function slot0.onInit(slot0)
	slot0.firstEnterMainScene = true
	slot0._inPopupFlow = false
end

function slot0.reInit(slot0)
	slot0:_destroyPopupFlow()

	slot0.firstEnterMainScene = true
	slot0._inPopupFlow = false
end

function slot0._startPopupFlow(slot0)
	slot0:_destroyPopupFlow()

	slot0._popupFlow = FlowSequence.New()

	slot0._popupFlow:addWork(MainGuideWork.New())
	slot0._popupFlow:addWork(MainLimitedRoleEffect.New())
	slot0._popupFlow:addWork(FunctionWork.New(function ()
		BGMSwitchController.instance:startAllOnLogin()
	end))
	slot0._popupFlow:addWork(MainAchievementToast.New())
	slot0._popupFlow:addWork(MainThumbnailWork.New())
	slot0._popupFlow:addWork(MainMailWork.New())
	slot0._popupFlow:addWork(MainUseExpireItemWork.New())
	slot0._popupFlow:addWork(MainSignInWork.New())
	slot0._popupFlow:addWork(MainFightReconnectWork.New())
	slot0._popupFlow:addWork(MainPatFaceWork.New())
	slot0._popupFlow:addWork(MainParallelGuideWork.New())
	slot0._popupFlow:addWork(AutoOpenNoticeWork.New())
	slot0._popupFlow:registerDoneListener(slot0._onPopupFlowDone, slot0)
	slot0._popupFlow:start({})

	slot0._inPopupFlow = true
end

function slot0._destroyPopupFlow(slot0)
	if slot0._popupFlow then
		slot0._popupFlow:destroy()

		slot0._popupFlow = nil
		slot0._inPopupFlow = false
	end
end

function slot0._onLoginEnterMainScene(slot0)
	uv0.instance:dispatchEvent(MainEvent.OnFirstEnterMain)
	slot0:_startPopupFlow()
end

function slot0._onDailyRefresh(slot0)
	slot0:_onCheckAutoPop(true)
end

function slot0._onActivityUpdate(slot0)
	slot0:_onCheckAutoPop(false)
end

function slot0._onCheckAutoPop(slot0, slot1)
	slot0:_destroyPopupFlow()

	slot0._popupFlow = FlowSequence.New()

	slot0._popupFlow:addWork(MainSignInWork.New())

	if slot1 then
		slot0._popupFlow:addWork(MainPatFaceWork.New())
	else
		slot0._popupFlow:addWork(Activity152PatFaceWork.New())
	end

	slot0._popupFlow:start({
		dailyRefresh = slot1
	})

	slot0._inPopupFlow = true
end

function slot0._onPopupFlowDone(slot0, slot1)
	slot0._inPopupFlow = false

	uv0.instance:dispatchEvent(MainEvent.OnMainPopupFlowFinish)
end

function slot0.enterMainScene(slot0, slot1, slot2)
	GameSceneMgr.instance:startSceneDefaultLevel(SceneType.Main, 101, slot1, slot2)
end

function slot0.openMainThumbnailView(slot0, slot1, slot2)
	uv0.instance:dispatchEvent(MainEvent.OnClickSwitchRole)
	ViewMgr.instance:openView(ViewName.MainThumbnailView, slot1, slot2)
end

function slot0.setRequestNoticeTime(slot0)
	slot0.requestTime = Time.realtimeSinceStartup
end

function slot0.getLastRequestNoticeTime(slot0)
	return slot0.requestTime
end

function slot0.isInMainView(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(ViewMgr.instance:getOpenViewNameList()) do
		if ViewMgr.instance:getSetting(slot7).layer ~= UILayerName.Message and slot8.layer ~= UILayerName.IDCanvasPopUp then
			table.insert(slot2, slot7)
		end
	end

	slot3 = true

	if #slot2 > 1 or slot2[1] ~= ViewName.MainView then
		slot3 = false
	end

	return slot3
end

function slot0.isInPopupFlow(slot0)
	return slot0._inPopupFlow
end

slot0.instance = slot0.New()

return slot0
