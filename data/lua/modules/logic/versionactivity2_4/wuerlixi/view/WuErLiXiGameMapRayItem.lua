module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameMapRayItem", package.seeall)

local var_0_0 = class("WuErLiXiGameMapRayItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._uiRootTrans = ViewMgr.instance:getUIRoot().transform
	arg_1_0.go = arg_1_1
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_1, "icon")

	gohelper.setActive(arg_1_0._imageicon.gameObject, false)

	arg_1_0._imagenormalsignal = gohelper.findChildImage(arg_1_1, "icon1")
	arg_1_0._imageswitchsignal = gohelper.findChildImage(arg_1_1, "icon2")
	arg_1_0._imagenormalMat = UnityEngine.GameObject.Instantiate(arg_1_0._imagenormalsignal.material)
	arg_1_0._imagenormalsignal.material = arg_1_0._imagenormalMat
	arg_1_0._imageswitchMat = UnityEngine.GameObject.Instantiate(arg_1_0._imageswitchsignal.material)
	arg_1_0._imageswitchsignal.material = arg_1_0._imageswitchMat
	arg_1_0._matTempVector = Vector4(0, 0, 0, 0)

	local var_1_0 = UnityEngine.Shader

	arg_1_0._startKey = var_1_0.PropertyToID("_StartVec")
	arg_1_0._endKey = var_1_0.PropertyToID("_EndVec")
end

function var_0_0.setItem(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	gohelper.setActive(arg_2_0.go, false)

	arg_2_0._mo = arg_2_1
	arg_2_0.go.name = string.format("%s_%s#%s_%s", arg_2_0._mo.startPos[2], arg_2_0._mo.startPos[1], arg_2_0._mo.endPos[2], arg_2_0._mo.endPos[1])
	arg_2_0._startNodeItem = arg_2_2
	arg_2_0._endNodeItem = arg_2_3

	transformhelper.setLocalRotation(arg_2_0.go.transform, 0, 0, -90 * arg_2_0._mo.rayDir)
	recthelper.setHeight(arg_2_0._imageicon.gameObject.transform, arg_2_0._mo:getSignalLength() * WuErLiXiEnum.GameMapNodeWidth)
	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(arg_2_0._imageicon, string.format("v2a4_wuerlixi_ray_icon%s", arg_2_0._mo.rayType))
	gohelper.setActive(arg_2_0._imagenormalsignal.gameObject, arg_2_0._mo.rayType == WuErLiXiEnum.RayType.NormalSignal)
	gohelper.setActive(arg_2_0._imageswitchsignal.gameObject, arg_2_0._mo.rayType == WuErLiXiEnum.RayType.SwitchSignal)
	TaskDispatcher.runDelay(arg_2_0.setPos, arg_2_0, 0.05)
end

function var_0_0.setPos(arg_3_0)
	gohelper.setActive(arg_3_0.go, true)

	local var_3_0, var_3_1, var_3_2 = transformhelper.getPos(arg_3_0._startNodeItem.go.transform)

	transformhelper.setPos(arg_3_0.go.transform, var_3_0, var_3_1, 0)

	arg_3_0._curRayLength = 0
	arg_3_0._lastEndNodeItem = arg_3_0._startNodeItem

	arg_3_0:_setLineStartPos()
	arg_3_0:_playItemForward()
end

function var_0_0._setLinePosition(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0._matTempVector.x = arg_4_3
	arg_4_0._matTempVector.y = arg_4_4

	arg_4_1:SetVector(arg_4_2, arg_4_0._matTempVector)
end

function var_0_0._setLineStartPos(arg_5_0)
	local var_5_0 = arg_5_0._startNodeItem.go.gameObject.transform.position
	local var_5_1, var_5_2 = recthelper.rectToRelativeAnchorPos2(var_5_0, arg_5_0._uiRootTrans)

	arg_5_0:_setLinePosition(arg_5_0._imagenormalMat, arg_5_0._startKey, var_5_1, var_5_2)
	arg_5_0:_setLinePosition(arg_5_0._imageswitchMat, arg_5_0._startKey, var_5_1, var_5_2)
end

function var_0_0._setLineEndPos(arg_6_0)
	local var_6_0 = arg_6_0._endNodeItem.go.transform.position
	local var_6_1, var_6_2 = recthelper.rectToRelativeAnchorPos2(var_6_0, arg_6_0._uiRootTrans)

	arg_6_0:_setLinePosition(arg_6_0._imagenormalMat, arg_6_0._endKey, var_6_1, var_6_2)
	arg_6_0:_setLinePosition(arg_6_0._imageswitchMat, arg_6_0._endKey, var_6_1, var_6_2)
end

function var_0_0.resetItem(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0._curRayLength then
		TaskDispatcher.cancelTask(arg_7_0.setPos, arg_7_0, 0.05)

		arg_7_0._curRayLength = 0
		arg_7_0._lastEndNodeItem = arg_7_0._startNodeItem

		arg_7_0:_setLineStartPos()
	end

	if arg_7_1.rayType ~= arg_7_0._mo.rayType or arg_7_1.rayDir ~= arg_7_0._mo.rayDir then
		arg_7_0:hide()
	end

	if arg_7_0._forwardTweenId then
		ZProj.TweenHelper.KillById(arg_7_0._forwardTweenId)

		arg_7_0._forwardTweenId = nil
	end

	gohelper.setActive(arg_7_0.go, true)

	arg_7_0._lastEndNodeItem = arg_7_0._endNodeItem
	arg_7_0._endNodeItem = arg_7_2
	arg_7_0._mo = arg_7_1

	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(arg_7_0._imageicon, string.format("v2a4_wuerlixi_ray_icon%s", arg_7_0._mo.rayType))

	arg_7_0.go.name = string.format("%s_%s#%s_%s", arg_7_0._mo.startPos[2], arg_7_0._mo.startPos[1], arg_7_0._mo.endPos[2], arg_7_0._mo.endPos[1])

	gohelper.setActive(arg_7_0._imagenormalsignal.gameObject, arg_7_0._mo.rayType == WuErLiXiEnum.RayType.NormalSignal)
	gohelper.setActive(arg_7_0._imageswitchsignal.gameObject, arg_7_0._mo.rayType == WuErLiXiEnum.RayType.SwitchSignal)
	arg_7_0:_playItemForward()
end

function var_0_0._playItemForward(arg_8_0)
	local var_8_0 = arg_8_0._curRayLength

	arg_8_0._curRayLength = math.abs(arg_8_0._mo.startPos[2] + arg_8_0._mo.startPos[1] - arg_8_0._mo.endPos[2] - arg_8_0._mo.endPos[1])

	local var_8_1 = CommonConfig.instance:getConstNum(ConstEnum.WuErLiXiOnNodeSec)
	local var_8_2 = arg_8_0._curRayLength - var_8_0 > 0 and 0.001 * (arg_8_0._curRayLength - var_8_0) * var_8_1 or 0

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("forwardPlaying")

	arg_8_0._forwardTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, var_8_2, arg_8_0._forwardUpdate, arg_8_0._forwardFinished, arg_8_0)
end

function var_0_0._forwardUpdate(arg_9_0, arg_9_1)
	local var_9_0, var_9_1 = recthelper.rectToRelativeAnchorPos2(arg_9_0._lastEndNodeItem.go.transform.position, arg_9_0._uiRootTrans)
	local var_9_2, var_9_3 = recthelper.rectToRelativeAnchorPos2(arg_9_0._endNodeItem.go.transform.position, arg_9_0._uiRootTrans)

	arg_9_0:_setLinePosition(arg_9_0._imagenormalMat, arg_9_0._endKey, var_9_0 + arg_9_1 * (var_9_2 - var_9_0), var_9_1 + arg_9_1 * (var_9_3 - var_9_1))
	arg_9_0:_setLinePosition(arg_9_0._imageswitchMat, arg_9_0._endKey, var_9_0 + arg_9_1 * (var_9_2 - var_9_0), var_9_1 + arg_9_1 * (var_9_3 - var_9_1))
end

function var_0_0._forwardFinished(arg_10_0)
	UIBlockMgr.instance:endBlock("forwardPlaying")
	arg_10_0:_setLineEndPos()
end

function var_0_0.hide(arg_11_0)
	arg_11_0._curRayLength = 0
	arg_11_0._endNodeItem = arg_11_0._startNodeItem
	arg_11_0._lastEndNodeItem = arg_11_0._startNodeItem

	arg_11_0:_setLineEndPos()
	gohelper.setActive(arg_11_0.go, false)
end

function var_0_0.destroy(arg_12_0)
	if arg_12_0._forwardTweenId then
		ZProj.TweenHelper.KillById(arg_12_0._forwardTweenId)

		arg_12_0._forwardTweenId = nil
	end

	TaskDispatcher.cancelTask(arg_12_0.setPos, arg_12_0)
end

return var_0_0
