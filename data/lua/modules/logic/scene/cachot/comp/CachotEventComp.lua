module("modules.logic.scene.cachot.comp.CachotEventComp", package.seeall)

local var_0_0 = class("CachotEventComp", BaseSceneComp)

function var_0_0.init(arg_1_0)
	arg_1_0._isShowEvents = true
	arg_1_0._eventItems = {}
	arg_1_0._preloadComp = arg_1_0:getCurScene().preloader
	arg_1_0._levelComp = arg_1_0:getCurScene().level

	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.RoomChangeBegin, arg_1_0._clearEvents, arg_1_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.TriggerEvent, arg_1_0._clearEvents, arg_1_0)
	arg_1_0._levelComp:registerCallback(CommonSceneLevelComp.OnLevelLoaded, arg_1_0.onSceneLevelLoaded, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_1_0._checkHaveViewOpen, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_1_0._checkHaveViewOpen, arg_1_0)

	if arg_1_0._levelComp:getSceneGo() then
		arg_1_0:onSceneLevelLoaded()
	end
end

function var_0_0._checkHaveViewOpen(arg_2_0)
	local var_2_0 = ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotRoomView, {
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor
	})

	if PopupController.instance:getPopupCount() > 0 then
		var_2_0 = false
	end

	if ViewMgr.instance:isOpen(ViewName.LoadingView) or ViewMgr.instance:isOpen(ViewName.V1a6_CachotLoadingView) or ViewMgr.instance:isOpen(ViewName.V1a6_CachotLayerChangeView) then
		var_2_0 = false
	end

	if arg_2_0._isShowEvents ~= var_2_0 then
		arg_2_0._isShowEvents = var_2_0

		for iter_2_0, iter_2_1 in pairs(arg_2_0._eventItems) do
			gohelper.setActive(iter_2_1.go, var_2_0)
		end
	end
end

function var_0_0._clearEvents(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0._eventItems) do
		gohelper.destroy(iter_3_1.go)
	end

	arg_3_0._eventItems = {}
end

function var_0_0.onSceneLevelLoaded(arg_4_0)
	arg_4_0:_checkHaveViewOpen()

	local var_4_0 = V1a6_CachotRoomModel.instance:getRoomEventMos()

	for iter_4_0 = 1, #var_4_0 do
		local var_4_1 = var_4_0[iter_4_0]
		local var_4_2 = arg_4_0._levelComp:getEventTr(var_4_1.index).gameObject
		local var_4_3 = arg_4_0._preloadComp:getResInst(CachotScenePreloader.EventItem, var_4_2)

		gohelper.removeEffectNode(var_4_3)

		arg_4_0._eventItems[iter_4_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_3, CachotEventItem)

		arg_4_0._eventItems[iter_4_0]:updateMo(var_4_1)
		gohelper.setActive(var_4_3, arg_4_0._isShowEvents)
	end
end

function var_0_0.onSceneClose(arg_5_0)
	arg_5_0._eventItems = {}

	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.RoomChangeBegin, arg_5_0._clearEvents, arg_5_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.TriggerEvent, arg_5_0._clearEvents, arg_5_0)
	arg_5_0._levelComp:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, arg_5_0.onSceneLevelLoaded, arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_5_0._checkHaveViewOpen, arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_5_0._checkHaveViewOpen, arg_5_0)
end

return var_0_0
