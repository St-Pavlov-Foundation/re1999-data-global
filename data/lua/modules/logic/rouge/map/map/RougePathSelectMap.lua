module("modules.logic.rouge.map.map.RougePathSelectMap", package.seeall)

local var_0_0 = class("RougePathSelectMap", RougeBaseMap)

function var_0_0.initMap(arg_1_0)
	var_0_0.super.initMap(arg_1_0)

	local var_1_0 = RougeMapConfig.instance:getPathSelectInitCameraSize()

	RougeMapModel.instance:setCameraSize(var_1_0)

	local var_1_1 = RougeMapModel.instance:getMapSize()

	transformhelper.setLocalPos(arg_1_0.mapTransform, -var_1_1.x / 2, var_1_1.y / 2, RougeMapEnum.OffsetZ.Map)
end

function var_0_0.createMap(arg_2_0)
	arg_2_0.actorComp = nil

	var_0_0.super.createMap(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0.focusToTarget, arg_2_0, RougeMapEnum.PathSelectMapWaitTime)

	arg_2_0.openViewDone = ViewMgr.instance:isOpen(ViewName.RougeMapView)

	if not ViewMgr.instance:isOpen(ViewName.RougeMapView) then
		arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0.onOpenView, arg_2_0)
	end
end

function var_0_0.onOpenView(arg_3_0, arg_3_1)
	if arg_3_1 == ViewName.RougeMapView then
		arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0.onOpenView, arg_3_0)

		arg_3_0.openViewDone = true

		arg_3_0:_focusToTarget()
	end
end

function var_0_0.focusToTarget(arg_4_0)
	arg_4_0.delayDone = true

	arg_4_0:_focusToTarget()
end

function var_0_0._focusToTarget(arg_5_0)
	if not arg_5_0.delayDone or not arg_5_0.openViewDone then
		return
	end

	arg_5_0:clearTween()

	local var_5_0 = RougeMapModel.instance:getPathSelectCo()
	local var_5_1 = string.splitToNumber(var_5_0.focusMapPos, "#")

	arg_5_0.movingTweenId = ZProj.TweenHelper.DOLocalMove(arg_5_0.mapTransform, var_5_1[1], var_5_1[2], RougeMapEnum.OffsetZ.Map, RougeMapEnum.RevertDuration, arg_5_0.onMovingDone, arg_5_0)

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onPathSelectMapFocus, var_5_0.focusCameraSize)
end

function var_0_0.onMovingDone(arg_6_0)
	arg_6_0.movingTweenId = nil

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onPathSelectMapFocusDone)
end

function var_0_0.clearTween(arg_7_0)
	if arg_7_0.movingTweenId then
		ZProj.TweenHelper.KillById(arg_7_0.movingTweenId)
	end

	arg_7_0.movingTweenId = nil
end

function var_0_0.destroy(arg_8_0)
	arg_8_0:clearTween()
	TaskDispatcher.cancelTask(arg_8_0.focusToTarget, arg_8_0)
	var_0_0.super.destroy(arg_8_0)
end

return var_0_0
