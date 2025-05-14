module("modules.logic.seasonver.act123.view2_0.component.Season123_2_0EntryDrag", package.seeall)

local var_0_0 = class("Season123_2_0EntryDrag", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0._goFullScreen = arg_1_1
	arg_1_0._sceneGo = arg_1_2.gameObject
	arg_1_0._tfScene = arg_1_2
	arg_1_0._tempVector = Vector3.New()
	arg_1_0._dragDeltaPos = Vector3.New()
	arg_1_0._tweenId = nil
	arg_1_0._dragEnabled = true
	arg_1_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_1_0._goFullScreen)

	arg_1_0._drag:AddDragBeginListener(arg_1_0.onDragBegin, arg_1_0)
	arg_1_0._drag:AddDragEndListener(arg_1_0.onDragEnd, arg_1_0)
	arg_1_0._drag:AddDragListener(arg_1_0.onDrag, arg_1_0)
	arg_1_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_1_0.handleScreenResize, arg_1_0)
end

function var_0_0.dispose(arg_2_0)
	if arg_2_0._drag then
		arg_2_0._drag:RemoveDragBeginListener()
		arg_2_0._drag:RemoveDragListener()
		arg_2_0._drag:RemoveDragEndListener()
	end

	arg_2_0:killTween()
	arg_2_0:__onDispose()
end

function var_0_0.initBound(arg_3_0)
	arg_3_0._mapSize = gohelper.findChild(arg_3_0._sceneGo, "root/size"):GetComponentInChildren(typeof(UnityEngine.BoxCollider)).size

	local var_3_0
	local var_3_1 = GameUtil.getAdapterScale()

	if var_3_1 ~= 1 then
		var_3_0 = ViewMgr.instance:getUILayer(UILayerName.Hud)
	else
		var_3_0 = ViewMgr.instance:getUIRoot()
	end

	local var_3_2 = var_3_0.transform:GetWorldCorners()
	local var_3_3 = var_3_2[1] * var_3_1
	local var_3_4 = var_3_2[3] * var_3_1

	arg_3_0._viewWidth = math.abs(var_3_4.x - var_3_3.x)
	arg_3_0._viewHeight = math.abs(var_3_4.y - var_3_3.y)
	arg_3_0._mapMinX = var_3_3.x - (arg_3_0._mapSize.x - arg_3_0._viewWidth)
	arg_3_0._mapMaxX = var_3_3.x
	arg_3_0._mapMinY = var_3_3.y
	arg_3_0._mapMaxY = var_3_3.y + (arg_3_0._mapSize.y - arg_3_0._viewHeight)
end

function var_0_0.onDragBegin(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0._dragEnabled then
		return
	end

	arg_4_0:killTween()

	arg_4_0._dragBeginPos = arg_4_0:getDragWorldPos(arg_4_2)

	if arg_4_0._tfScene then
		arg_4_0._beginDragPos = arg_4_0._tfScene.localPosition
	end
end

function var_0_0.onDragEnd(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._dragBeginPos = nil
	arg_5_0._beginDragPos = nil
end

function var_0_0.onDrag(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0._dragBeginPos then
		return
	end

	local var_6_0 = arg_6_0:getDragWorldPos(arg_6_2) - arg_6_0._dragBeginPos

	arg_6_0:drag(var_6_0)
end

function var_0_0.drag(arg_7_0, arg_7_1)
	if not arg_7_0._tfScene or not arg_7_0._beginDragPos then
		return
	end

	arg_7_0._dragDeltaPos.x = arg_7_1.x
	arg_7_0._dragDeltaPos.y = arg_7_1.y

	local var_7_0 = arg_7_0:vectorAdd(arg_7_0._beginDragPos, arg_7_0._dragDeltaPos)

	arg_7_0:setScenePosDrag(var_7_0)
end

function var_0_0.setScenePosDrag(arg_8_0, arg_8_1)
	arg_8_1.x, arg_8_1.y = arg_8_0:fixTargetPos(arg_8_1)
	arg_8_0._targetPos = arg_8_1

	transformhelper.setLocalPos(arg_8_0._tfScene, arg_8_1.x, arg_8_1.y, 0)
end

function var_0_0.setScenePosTween(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if not arg_9_0._tfScene then
		return
	end

	arg_9_0._targetPos = arg_9_1

	local var_9_0 = arg_9_2 or 0.46

	arg_9_0:killTween()

	arg_9_0._tweenId = ZProj.TweenHelper.DOLocalMove(arg_9_0._tfScene, arg_9_1.x, arg_9_1.y, 0, var_9_0, arg_9_0.localMoveDone, arg_9_0, nil, EaseType.OutQuad)
end

function var_0_0.fixTargetPos(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.x
	local var_10_1 = arg_10_1.y

	if arg_10_0._mapMinX and arg_10_0._mapMaxX then
		if arg_10_1.x < arg_10_0._mapMinX then
			var_10_0 = arg_10_0._mapMinX
		elseif arg_10_1.x > arg_10_0._mapMaxX then
			var_10_0 = arg_10_0._mapMaxX
		end
	end

	if arg_10_0._mapMinY and arg_10_0._mapMaxY then
		if arg_10_1.y < arg_10_0._mapMinY then
			var_10_1 = arg_10_0._mapMinY
		elseif arg_10_1.y > arg_10_0._mapMaxY then
			var_10_1 = arg_10_0._mapMaxY
		end
	end

	return var_10_0, var_10_1
end

function var_0_0.localMoveDone(arg_11_0)
	arg_11_0._tweenId = nil
end

function var_0_0.vectorAdd(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._tempVector

	var_12_0.x = arg_12_1.x + arg_12_2.x
	var_12_0.y = arg_12_1.y + arg_12_2.y

	return var_12_0
end

function var_0_0.getTempPos(arg_13_0)
	return arg_13_0._tempVector
end

function var_0_0.killTween(arg_14_0)
	if arg_14_0._tweenId then
		ZProj.TweenHelper.KillById(arg_14_0._tweenId)

		arg_14_0._tweenId = nil
	end
end

function var_0_0.setDragEnabled(arg_15_0, arg_15_1)
	arg_15_0._dragEnabled = arg_15_1
end

function var_0_0.getDragWorldPos(arg_16_0, arg_16_1)
	local var_16_0 = CameraMgr.instance:getMainCamera()
	local var_16_1 = arg_16_0._goFullScreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(arg_16_1.position, var_16_0, var_16_1))
end

function var_0_0.handleScreenResize(arg_17_0)
	arg_17_0:initBound()

	if arg_17_0._dragEnabled then
		local var_17_0 = arg_17_0:getTempPos()

		var_17_0.x, var_17_0.y = SeasonEntryEnum.DefaultScenePosX, SeasonEntryEnum.DefaultScenePosY

		arg_17_0:setScenePosDrag(var_17_0)
	end
end

return var_0_0
