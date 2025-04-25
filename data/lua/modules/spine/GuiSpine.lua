module("modules.spine.GuiSpine", package.seeall)

slot0 = class("GuiSpine", BaseSpine)
slot1 = "spine/spine_ui_image.mat"
slot2 = "spine/spine_ui_rt_source.mat"
slot0.TypeSkeletonGraphic = typeof(Spine.Unity.SkeletonGraphic)
slot0.TypeUISpineAnimationEvent = typeof(ZProj.UISpineAnimationEvent)

function slot0.Create(slot0, slot1)
	slot2 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0, uv0)
	slot2._isStory = slot1

	return slot2
end

function slot0.initSkeletonComponent(slot0)
	slot0._skeletonComponent = slot0._spineGo:GetComponent(uv0.TypeSkeletonGraphic)

	slot0._skeletonComponent:Initialize(false)

	slot0._skeletonComponent.freeze = slot0._bFreeze
	slot0._skeletonComponent.startingLoop = false
	slot0._animationEvent = uv0.TypeUISpineAnimationEvent
end

function slot0.getSkeletonGraphic(slot0)
	return slot0._skeletonComponent
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._updateMatProp, slot0)
	uv0.super.onDestroy(slot0)

	if slot0._rawImageGo then
		gohelper.destroy(slot0._rawImageGo)
	end

	slot0:_disposeLoader()
	gohelper.destroy(slot0._imgMat)

	slot0._imgMat = nil
	slot0._uiMaskBuffer = nil
	slot0._useRT = nil
	slot0._imgWidth = nil
	slot0._imgHeight = nil
	slot0._imgPosX = nil
	slot0._imgPosY = nil
	slot0._imgParent = nil
	slot0._xialiRtMatPath = nil
	slot0._tttRtMatPath = nil
end

function slot0._clear(slot0)
	TaskDispatcher.cancelTask(slot0._updateMatProp, slot0)
	uv0.super._clear(slot0)
end

function slot0._useScreenCenter(slot0, slot1)
	return string.find(slot1, "301702_xiali_p") or string.find(slot1, "303301_ttt_p") or string.find(slot1, "303302_ttt_p") or string.find(slot1, "303303_ttt_p") or string.find(slot1, "305901_door_p")
end

function slot0._onResLoaded(slot0)
	uv0.super._onResLoaded(slot0)

	if slot0:_useScreenCenter(slot0._resPath) then
		slot0._mat = UnityEngine.Object.Instantiate(slot0._skeletonComponent.material)
		slot0._skeletonComponent.material = slot0._mat
		slot0._centerID = UnityEngine.Shader.PropertyToID("_ScreenCenter")
		slot0._posVec3 = Vector3()
		slot0._forceUpdateCount = 0

		TaskDispatcher.runRepeat(slot0._updateMatProp, slot0, 0)
	end

	if slot0._useRT then
		slot0._skeletonComponent.enabled = false

		slot0:_initImageAndMat()
	end
end

function slot0._disposeLoader(slot0)
	if slot0._guispineLoader then
		slot0._guispineLoader:dispose()

		slot0._guispineLoader = nil
	end
end

function slot0._initImageAndMat(slot0)
	slot0._rawImageGo = slot0._rawImageGo or UnityEngine.GameObject.New("spine_rawImage")

	slot0._rawImageGo.transform:SetParent(slot0._imgParent or slot0._gameTr.parent)
	gohelper.setAsFirstSibling(slot0._rawImageGo)
	slot0:_disposeLoader()

	slot0._guispineLoader = MultiAbLoader.New()

	slot0._guispineLoader:addPath(uv0)

	if string.find(slot0._resPath, "301702_xiali_p") then
		slot0._xialiRtMatPath = "rolesstory/dynamic/301702_xiali_p_material_ui_rt_source.mat"

		slot0._guispineLoader:addPath(slot0._xialiRtMatPath)
	elseif string.find(slot0._resPath, "303301_ttt_p") then
		slot0._tttRtMatPath = "rolesstory/dynamic/303301_ttt_p_material_ui_rt_source.mat"

		slot0._guispineLoader:addPath(slot0._tttRtMatPath)
	elseif string.find(slot0._resPath, "303302_ttt_p") then
		slot0._tttRtMatPath = "rolesstory/dynamic/303302_ttt_p_material_ui_rt_source.mat"

		slot0._guispineLoader:addPath(slot0._tttRtMatPath)
	elseif string.find(slot0._resPath, "303303_ttt_p") then
		slot0._tttRtMatPath = "rolesstory/dynamic/303303_ttt_p_material_ui_rt_source.mat"

		slot0._guispineLoader:addPath(slot0._tttRtMatPath)
	else
		slot0._guispineLoader:addPath(uv1)
	end

	slot0._guispineLoader:startLoad(slot0._onSpineImgLoaderFinish, slot0)
end

function slot0._onSpineImgLoaderFinish(slot0)
	if slot0._guispineLoader:getAssetItem(uv0) then
		slot0._imgMat = slot0._imgMat or UnityEngine.Object.Instantiate(slot1:GetResource())

		if slot0._uiMaskBuffer ~= nil then
			slot0:setImageUIMask(slot0._uiMaskBuffer)
		end

		gohelper.onceAddComponent(slot0._rawImageGo, typeof(ZProj.UISpineImage))
		transformhelper.setLocalScale(slot0._rawImageGo.transform, 0, 0, 0)

		if gohelper.onceAddComponent(slot0._rawImageGo, gohelper.Type_RawImage) then
			slot2.raycastTarget = false
			slot2.material = slot0._imgMat
			slot4 = ViewMgr:getUIRoot()

			recthelper.setSize(slot3, slot0._imgWidth or slot4.transform.sizeDelta.x, slot0._imgHeight or slot4.transform.sizeDelta.y)
			transformhelper.setLocalScale(slot3, 1, 1, 1)

			if slot0._imgPosX or slot0._imgPosY then
				transformhelper.setLocalPos(slot3, slot0._imgPosX or slot3.localPosition.x, slot0._imgPosY or slot3.localPosition.y, slot3.localPosition.z)
			end
		end
	end

	if slot0._guispineLoader:getAssetItem(slot0._tttRtMatPath or slot0._xialiRtMatPath or uv1) then
		if slot0:getSkeletonGraphic() then
			slot0:getSkeletonGraphic().material = UnityEngine.Object.Instantiate(slot2:GetResource())
		end

		if slot0._xialiRtMatPath then
			slot0._mat = slot0:getSkeletonGraphic().material

			TaskDispatcher.runRepeat(slot0._updateMatProp, slot0, 0)
		end

		if slot0._tttRtMatPath then
			slot0._mat = slot0:getSkeletonGraphic().material

			TaskDispatcher.runRepeat(slot0._updateMatProp, slot0, 0)
		end
	end

	if slot0._skeletonComponent then
		slot0._skeletonComponent.enabled = true
	end
end

function slot0.setImgSize(slot0, slot1, slot2)
	slot0._imgWidth = slot1
	slot0._imgHeight = slot2
end

function slot0.setImgParent(slot0, slot1)
	slot0._imgParent = slot1
end

function slot0.setImgPos(slot0, slot1, slot2)
	slot0._imgPosX = slot1
	slot0._imgPosY = slot2
end

function slot0._updateMatProp(slot0)
	if gohelper.isNil(slot0._spineGo) then
		TaskDispatcher.cancelTask(slot0._updateMatProp, slot0)

		return
	end

	if slot0._spineGo and not slot0._spineGo.activeInHierarchy then
		slot0._forceUpdateCount = 2

		return
	end

	slot1, slot2, slot3 = transformhelper.getPos(slot0._spineTr)
	slot4, slot5, slot6 = transformhelper.getLocalScale(slot0._spineTr.parent)

	if slot0._posVec3.x == slot1 and slot0._posVec3.y == slot2 and slot0._posVec3.z == slot3 and slot4 == slot0._preScaleX and slot5 == slot0.preScaleY and slot0._forceUpdateCount == 0 then
		return
	end

	if slot0._forceUpdateCount > 0 then
		slot0._forceUpdateCount = slot0._forceUpdateCount - 1
	end

	slot0._posVec3.x = slot1
	slot0._posVec3.y = slot2
	slot0._posVec3.z = slot3
	slot0.preScaleY = slot5
	slot0._preScaleX = slot4
	slot8, slot9, slot10 = transformhelper.getLocalScale(ViewMgr.instance:getUIRoot().transform)

	slot0._mat:SetVector(slot0._centerID, Vector4(slot1 / slot8, slot2 / slot8, 1 / slot4, 1 / slot5))
end

function slot0._setKeyword(slot0, slot1, slot2)
	if not slot0:getSkeletonGraphic() then
		return
	end

	if not slot0:getSkeletonGraphic().material then
		return
	end

	if slot2 == true then
		slot3:EnableKeyword(slot1)
	else
		slot3:DisableKeyword(slot1)
	end
end

function slot0.setUIMask(slot0, slot1)
	slot0:_setKeyword("_UIMASK_ON", slot1)
end

function slot0.useRT(slot0)
	slot0._useRT = true
end

function slot0.showModel(slot0)
	if slot0._rawImageGo then
		gohelper.setActive(slot0._rawImageGo, true)
	end
end

function slot0.hideModel(slot0)
	if slot0._rawImageGo then
		gohelper.setActive(slot0._rawImageGo, false)
	end
end

function slot0.setImageUIMask(slot0, slot1)
	if slot0._imgMat then
		if slot1 == true then
			slot0._imgMat:EnableKeyword("_UIMASK_ON")
		else
			slot0._imgMat:DisableKeyword("_UIMASK_ON")
		end
	else
		slot0._uiMaskBuffer = slot1
	end
end

function slot0.setFreezeState(slot0, slot1)
	slot0._bFreeze = slot1

	if not slot0._skeletonComponent then
		return
	end

	slot0._skeletonComponent.freeze = slot1
end

return slot0
