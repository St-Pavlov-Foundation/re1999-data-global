module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoomView", package.seeall)

local var_0_0 = class("V1a6_CachotRoomView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._viewAnim = gohelper.findChild(arg_1_0.viewGO, "#go_excessive"):GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._viewAnim.keepAnimatorControllerStateOnDisable = true
	arg_1_0._txttest = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_test")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_2_0._checkHaveViewOpen, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.CheckOpenEnding, arg_2_0._checkShowEnding, arg_2_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.RoomChangeBegin, arg_2_0._beginSwitchScene, arg_2_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.RoomChangePlayAnim, arg_2_0._endSwitchScene, arg_2_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateRogueInfo, arg_2_0.____testShowInfo, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_3_0._checkHaveViewOpen, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.CheckOpenEnding, arg_3_0._checkShowEnding, arg_3_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.RoomChangeBegin, arg_3_0._beginSwitchScene, arg_3_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.RoomChangePlayAnim, arg_3_0._endSwitchScene, arg_3_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateRogueInfo, arg_3_0.____testShowInfo, arg_3_0)
end

function var_0_0._checkHaveViewOpen(arg_4_0)
	local var_4_0 = arg_4_0:isOpenView()

	if var_4_0 then
		transformhelper.setLocalPos(arg_4_0.viewGO.transform, 0, -99999, 0)
	else
		transformhelper.setLocalPos(arg_4_0.viewGO.transform, 0, 0, 0)
	end

	if not var_4_0 then
		arg_4_0:_checkShowEnding()
	end
end

function var_0_0.isOpenView(arg_5_0)
	local var_5_0 = not ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotRoomView, {
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor
	})

	if PopupController.instance:getPopupCount() > 0 then
		var_5_0 = true
	end

	return var_5_0
end

function var_0_0._checkShowEnding(arg_6_0)
	if arg_6_0:isOpenView() then
		return
	end

	if V1a6_CachotModel.instance:getRogueEndingInfo() then
		V1a6_CachotController.instance:openV1a6_CachotFinishView()
	end
end

function var_0_0._onCloseView(arg_7_0, arg_7_1)
	arg_7_0:_checkHaveViewOpen()
end

function var_0_0._onCloseViewFinish(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.V1a6_CachotLoadingView then
		gohelper.setActive(arg_8_0.viewGO, false)
		gohelper.setActive(arg_8_0.viewGO, true)
	end
end

function var_0_0._beginSwitchScene(arg_9_0)
	arg_9_0._viewAnim:Play("open", 0, 0)
	TaskDispatcher.runDelay(arg_9_0._onOpenAnimEnd, arg_9_0, 1)
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._onOpenAnimEnd, arg_10_0)
end

function var_0_0._onOpenAnimEnd(arg_11_0)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.RoomViewOpenAnimEnd)
end

function var_0_0._endSwitchScene(arg_12_0, arg_12_1)
	arg_12_0._viewAnim:Play("close", 0, arg_12_1 and 0 or 1)
	arg_12_0.viewContainer:dispatchEvent(V1a6_CachotEvent.RoomChangeAnimEnd)
end

function var_0_0.onOpen(arg_13_0)
	gohelper.setActive(arg_13_0._txttest, false)

	arg_13_0._isShowGo = true

	arg_13_0:_checkHaveViewOpen()
	arg_13_0._viewAnim:Play("close", 0, 1)
	arg_13_0:____testShowInfo()
end

function var_0_0.____testShowInfo(arg_14_0)
	if not isDebugBuild then
		return
	end

	arg_14_0._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not arg_14_0._rogueInfo then
		return
	end

	local var_14_0, var_14_1 = V1a6_CachotRoomConfig.instance:getRoomIndexAndTotal(arg_14_0._rogueInfo.room)
	local var_14_2 = {}

	for iter_14_0 = 1, #arg_14_0._rogueInfo.currentEvents do
		local var_14_3 = arg_14_0._rogueInfo.currentEvents[iter_14_0]

		table.insert(var_14_2, var_14_3.eventId .. ":" .. var_14_3.status .. ">>" .. var_14_3.eventData)
	end

	local var_14_4 = ("" .. string.format("当前房间：%d (%d / %d)\n", arg_14_0._rogueInfo.room, var_14_0, var_14_1)) .. string.format("当前房间事件：\n" .. table.concat(var_14_2, "\n"))

	arg_14_0._txttest.text = var_14_4
end

return var_0_0
