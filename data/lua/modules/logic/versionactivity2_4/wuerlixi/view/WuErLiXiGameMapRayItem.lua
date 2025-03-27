module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameMapRayItem", package.seeall)

slot0 = class("WuErLiXiGameMapRayItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._uiRootTrans = ViewMgr.instance:getUIRoot().transform
	slot0.go = slot1
	slot0._imageicon = gohelper.findChildImage(slot1, "icon")

	gohelper.setActive(slot0._imageicon.gameObject, false)

	slot0._imagenormalsignal = gohelper.findChildImage(slot1, "icon1")
	slot0._imageswitchsignal = gohelper.findChildImage(slot1, "icon2")
	slot0._imagenormalMat = UnityEngine.GameObject.Instantiate(slot0._imagenormalsignal.material)
	slot0._imagenormalsignal.material = slot0._imagenormalMat
	slot0._imageswitchMat = UnityEngine.GameObject.Instantiate(slot0._imageswitchsignal.material)
	slot0._imageswitchsignal.material = slot0._imageswitchMat
	slot0._matTempVector = Vector4(0, 0, 0, 0)
	slot2 = UnityEngine.Shader
	slot0._startKey = slot2.PropertyToID("_StartVec")
	slot0._endKey = slot2.PropertyToID("_EndVec")
end

function slot0.setItem(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot0.go, false)

	slot0._mo = slot1
	slot0.go.name = string.format("%s_%s#%s_%s", slot0._mo.startPos[2], slot0._mo.startPos[1], slot0._mo.endPos[2], slot0._mo.endPos[1])
	slot0._startNodeItem = slot2
	slot0._endNodeItem = slot3

	transformhelper.setLocalRotation(slot0.go.transform, 0, 0, -90 * slot0._mo.rayDir)
	recthelper.setHeight(slot0._imageicon.gameObject.transform, slot0._mo:getSignalLength() * WuErLiXiEnum.GameMapNodeWidth)
	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(slot0._imageicon, string.format("v2a4_wuerlixi_ray_icon%s", slot0._mo.rayType))
	gohelper.setActive(slot0._imagenormalsignal.gameObject, slot0._mo.rayType == WuErLiXiEnum.RayType.NormalSignal)
	gohelper.setActive(slot0._imageswitchsignal.gameObject, slot0._mo.rayType == WuErLiXiEnum.RayType.SwitchSignal)
	TaskDispatcher.runDelay(slot0.setPos, slot0, 0.05)
end

function slot0.setPos(slot0)
	gohelper.setActive(slot0.go, true)

	slot1, slot2, slot3 = transformhelper.getPos(slot0._startNodeItem.go.transform)

	transformhelper.setPos(slot0.go.transform, slot1, slot2, 0)

	slot0._curRayLength = 0
	slot0._lastEndNodeItem = slot0._startNodeItem

	slot0:_setLineStartPos()
	slot0:_playItemForward()
end

function slot0._setLinePosition(slot0, slot1, slot2, slot3, slot4)
	slot0._matTempVector.x = slot3
	slot0._matTempVector.y = slot4

	slot1:SetVector(slot2, slot0._matTempVector)
end

function slot0._setLineStartPos(slot0)
	slot2, slot3 = recthelper.rectToRelativeAnchorPos2(slot0._startNodeItem.go.gameObject.transform.position, slot0._uiRootTrans)

	slot0:_setLinePosition(slot0._imagenormalMat, slot0._startKey, slot2, slot3)
	slot0:_setLinePosition(slot0._imageswitchMat, slot0._startKey, slot2, slot3)
end

function slot0._setLineEndPos(slot0)
	slot2, slot3 = recthelper.rectToRelativeAnchorPos2(slot0._endNodeItem.go.transform.position, slot0._uiRootTrans)

	slot0:_setLinePosition(slot0._imagenormalMat, slot0._endKey, slot2, slot3)
	slot0:_setLinePosition(slot0._imageswitchMat, slot0._endKey, slot2, slot3)
end

function slot0.resetItem(slot0, slot1, slot2)
	if not slot0._curRayLength then
		TaskDispatcher.cancelTask(slot0.setPos, slot0, 0.05)

		slot0._curRayLength = 0
		slot0._lastEndNodeItem = slot0._startNodeItem

		slot0:_setLineStartPos()
	end

	if slot1.rayType ~= slot0._mo.rayType or slot1.rayDir ~= slot0._mo.rayDir then
		slot0:hide()
	end

	if slot0._forwardTweenId then
		ZProj.TweenHelper.KillById(slot0._forwardTweenId)

		slot0._forwardTweenId = nil
	end

	gohelper.setActive(slot0.go, true)

	slot0._lastEndNodeItem = slot0._endNodeItem
	slot0._endNodeItem = slot2
	slot0._mo = slot1

	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(slot0._imageicon, string.format("v2a4_wuerlixi_ray_icon%s", slot0._mo.rayType))

	slot0.go.name = string.format("%s_%s#%s_%s", slot0._mo.startPos[2], slot0._mo.startPos[1], slot0._mo.endPos[2], slot0._mo.endPos[1])

	gohelper.setActive(slot0._imagenormalsignal.gameObject, slot0._mo.rayType == WuErLiXiEnum.RayType.NormalSignal)
	gohelper.setActive(slot0._imageswitchsignal.gameObject, slot0._mo.rayType == WuErLiXiEnum.RayType.SwitchSignal)
	slot0:_playItemForward()
end

function slot0._playItemForward(slot0)
	slot0._curRayLength = math.abs(slot0._mo.startPos[2] + slot0._mo.startPos[1] - slot0._mo.endPos[2] - slot0._mo.endPos[1])

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("forwardPlaying")

	slot0._forwardTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, slot0._curRayLength - slot0._curRayLength > 0 and 0.001 * (slot0._curRayLength - slot1) * CommonConfig.instance:getConstNum(ConstEnum.WuErLiXiOnNodeSec) or 0, slot0._forwardUpdate, slot0._forwardFinished, slot0)
end

function slot0._forwardUpdate(slot0, slot1)
	slot2, slot3 = recthelper.rectToRelativeAnchorPos2(slot0._lastEndNodeItem.go.transform.position, slot0._uiRootTrans)
	slot4, slot5 = recthelper.rectToRelativeAnchorPos2(slot0._endNodeItem.go.transform.position, slot0._uiRootTrans)

	slot0:_setLinePosition(slot0._imagenormalMat, slot0._endKey, slot2 + slot1 * (slot4 - slot2), slot3 + slot1 * (slot5 - slot3))
	slot0:_setLinePosition(slot0._imageswitchMat, slot0._endKey, slot2 + slot1 * (slot4 - slot2), slot3 + slot1 * (slot5 - slot3))
end

function slot0._forwardFinished(slot0)
	UIBlockMgr.instance:endBlock("forwardPlaying")
	slot0:_setLineEndPos()
end

function slot0.hide(slot0)
	slot0._curRayLength = 0
	slot0._endNodeItem = slot0._startNodeItem
	slot0._lastEndNodeItem = slot0._startNodeItem

	slot0:_setLineEndPos()
	gohelper.setActive(slot0.go, false)
end

function slot0.destroy(slot0)
	if slot0._forwardTweenId then
		ZProj.TweenHelper.KillById(slot0._forwardTweenId)

		slot0._forwardTweenId = nil
	end

	TaskDispatcher.cancelTask(slot0.setPos, slot0)
end

return slot0
