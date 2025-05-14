module("modules.spine.GuiSpine", package.seeall)

local var_0_0 = class("GuiSpine", BaseSpine)
local var_0_1 = "spine/spine_ui_image.mat"
local var_0_2 = "spine/spine_ui_rt_source.mat"

var_0_0.TypeSkeletonGraphic = typeof(Spine.Unity.SkeletonGraphic)
var_0_0.TypeUISpineAnimationEvent = typeof(ZProj.UISpineAnimationEvent)

function var_0_0.Create(arg_1_0, arg_1_1)
	local var_1_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0, var_0_0)

	var_1_0._isStory = arg_1_1

	return var_1_0
end

function var_0_0.initSkeletonComponent(arg_2_0)
	arg_2_0._skeletonComponent = arg_2_0._spineGo:GetComponent(var_0_0.TypeSkeletonGraphic)

	arg_2_0._skeletonComponent:Initialize(false)

	arg_2_0._skeletonComponent.freeze = arg_2_0._bFreeze
	arg_2_0._skeletonComponent.startingLoop = false
	arg_2_0._animationEvent = var_0_0.TypeUISpineAnimationEvent
end

function var_0_0.getSkeletonGraphic(arg_3_0)
	return arg_3_0._skeletonComponent
end

function var_0_0.onDestroy(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._updateMatProp, arg_4_0)
	var_0_0.super.onDestroy(arg_4_0)

	if arg_4_0._rawImageGo then
		gohelper.destroy(arg_4_0._rawImageGo)
	end

	arg_4_0:_disposeLoader()
	gohelper.destroy(arg_4_0._imgMat)

	arg_4_0._imgMat = nil
	arg_4_0._uiMaskBuffer = nil
	arg_4_0._useRT = nil
	arg_4_0._imgWidth = nil
	arg_4_0._imgHeight = nil
	arg_4_0._imgPosX = nil
	arg_4_0._imgPosY = nil
	arg_4_0._imgParent = nil
	arg_4_0._xialiRtMatPath = nil
	arg_4_0._tttRtMatPath = nil
end

function var_0_0._clear(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._updateMatProp, arg_5_0)
	var_0_0.super._clear(arg_5_0)
end

function var_0_0._useScreenCenter(arg_6_0, arg_6_1)
	return string.find(arg_6_1, "301702_xiali_p") or string.find(arg_6_1, "303301_ttt_p") or string.find(arg_6_1, "303302_ttt_p") or string.find(arg_6_1, "303303_ttt_p") or string.find(arg_6_1, "305901_door_p")
end

function var_0_0._onResLoaded(arg_7_0)
	var_0_0.super._onResLoaded(arg_7_0)

	if arg_7_0:_useScreenCenter(arg_7_0._resPath) then
		arg_7_0._mat = UnityEngine.Object.Instantiate(arg_7_0._skeletonComponent.material)
		arg_7_0._skeletonComponent.material = arg_7_0._mat
		arg_7_0._centerID = UnityEngine.Shader.PropertyToID("_ScreenCenter")
		arg_7_0._posVec3 = Vector3()
		arg_7_0._forceUpdateCount = 0

		TaskDispatcher.runRepeat(arg_7_0._updateMatProp, arg_7_0, 0)
	end

	if arg_7_0._useRT then
		arg_7_0._skeletonComponent.enabled = false

		arg_7_0:_initImageAndMat()
	end
end

function var_0_0._disposeLoader(arg_8_0)
	if arg_8_0._guispineLoader then
		arg_8_0._guispineLoader:dispose()

		arg_8_0._guispineLoader = nil
	end
end

function var_0_0._initImageAndMat(arg_9_0)
	arg_9_0._rawImageGo = arg_9_0._rawImageGo or UnityEngine.GameObject.New("spine_rawImage")

	arg_9_0._rawImageGo.transform:SetParent(arg_9_0._imgParent or arg_9_0._gameTr.parent)
	gohelper.setAsFirstSibling(arg_9_0._rawImageGo)
	arg_9_0:_disposeLoader()

	arg_9_0._guispineLoader = MultiAbLoader.New()

	arg_9_0._guispineLoader:addPath(var_0_1)

	if string.find(arg_9_0._resPath, "301702_xiali_p") then
		arg_9_0._xialiRtMatPath = "rolesstory/dynamic/301702_xiali_p_material_ui_rt_source.mat"

		arg_9_0._guispineLoader:addPath(arg_9_0._xialiRtMatPath)
	elseif string.find(arg_9_0._resPath, "303301_ttt_p") then
		arg_9_0._tttRtMatPath = "rolesstory/dynamic/303301_ttt_p_material_ui_rt_source.mat"

		arg_9_0._guispineLoader:addPath(arg_9_0._tttRtMatPath)
	elseif string.find(arg_9_0._resPath, "303302_ttt_p") then
		arg_9_0._tttRtMatPath = "rolesstory/dynamic/303302_ttt_p_material_ui_rt_source.mat"

		arg_9_0._guispineLoader:addPath(arg_9_0._tttRtMatPath)
	elseif string.find(arg_9_0._resPath, "303303_ttt_p") then
		arg_9_0._tttRtMatPath = "rolesstory/dynamic/303303_ttt_p_material_ui_rt_source.mat"

		arg_9_0._guispineLoader:addPath(arg_9_0._tttRtMatPath)
	else
		arg_9_0._guispineLoader:addPath(var_0_2)
	end

	arg_9_0._guispineLoader:startLoad(arg_9_0._onSpineImgLoaderFinish, arg_9_0)
end

function var_0_0._onSpineImgLoaderFinish(arg_10_0)
	local var_10_0 = arg_10_0._guispineLoader:getAssetItem(var_0_1)

	if var_10_0 then
		arg_10_0._imgMat = arg_10_0._imgMat or UnityEngine.Object.Instantiate(var_10_0:GetResource())

		if arg_10_0._uiMaskBuffer ~= nil then
			arg_10_0:setImageUIMask(arg_10_0._uiMaskBuffer)
		end

		local var_10_1 = gohelper.onceAddComponent(arg_10_0._rawImageGo, gohelper.Type_RawImage)

		gohelper.onceAddComponent(arg_10_0._rawImageGo, typeof(ZProj.UISpineImage))

		local var_10_2 = arg_10_0._rawImageGo.transform

		transformhelper.setLocalScale(var_10_2, 0, 0, 0)

		if var_10_1 then
			var_10_1.raycastTarget = false
			var_10_1.material = arg_10_0._imgMat

			local var_10_3 = ViewMgr:getUIRoot()
			local var_10_4 = arg_10_0._imgWidth or var_10_3.transform.sizeDelta.x
			local var_10_5 = arg_10_0._imgHeight or var_10_3.transform.sizeDelta.y

			recthelper.setSize(var_10_2, var_10_4, var_10_5)
			transformhelper.setLocalScale(var_10_2, 1, 1, 1)

			if arg_10_0._imgPosX or arg_10_0._imgPosY then
				transformhelper.setLocalPos(var_10_2, arg_10_0._imgPosX or var_10_2.localPosition.x, arg_10_0._imgPosY or var_10_2.localPosition.y, var_10_2.localPosition.z)
			end
		end
	end

	local var_10_6 = arg_10_0._guispineLoader:getAssetItem(arg_10_0._tttRtMatPath or arg_10_0._xialiRtMatPath or var_0_2)

	if var_10_6 then
		local var_10_7 = UnityEngine.Object.Instantiate(var_10_6:GetResource())

		if arg_10_0:getSkeletonGraphic() then
			arg_10_0:getSkeletonGraphic().material = var_10_7
		end

		if arg_10_0._xialiRtMatPath then
			arg_10_0._mat = arg_10_0:getSkeletonGraphic().material

			TaskDispatcher.runRepeat(arg_10_0._updateMatProp, arg_10_0, 0)
		end

		if arg_10_0._tttRtMatPath then
			arg_10_0._mat = arg_10_0:getSkeletonGraphic().material

			TaskDispatcher.runRepeat(arg_10_0._updateMatProp, arg_10_0, 0)
		end
	end

	if arg_10_0._skeletonComponent then
		arg_10_0._skeletonComponent.enabled = true
	end
end

function var_0_0.setImgSize(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._imgWidth = arg_11_1
	arg_11_0._imgHeight = arg_11_2
end

function var_0_0.setImgParent(arg_12_0, arg_12_1)
	arg_12_0._imgParent = arg_12_1
end

function var_0_0.setImgPos(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._imgPosX = arg_13_1
	arg_13_0._imgPosY = arg_13_2
end

function var_0_0._updateMatProp(arg_14_0)
	if gohelper.isNil(arg_14_0._spineGo) then
		TaskDispatcher.cancelTask(arg_14_0._updateMatProp, arg_14_0)

		return
	end

	if arg_14_0._spineGo and not arg_14_0._spineGo.activeInHierarchy then
		arg_14_0._forceUpdateCount = 2

		return
	end

	local var_14_0, var_14_1, var_14_2 = transformhelper.getPos(arg_14_0._spineTr)
	local var_14_3, var_14_4, var_14_5 = transformhelper.getLocalScale(arg_14_0._spineTr.parent)

	if arg_14_0._posVec3.x == var_14_0 and arg_14_0._posVec3.y == var_14_1 and arg_14_0._posVec3.z == var_14_2 and var_14_3 == arg_14_0._preScaleX and var_14_4 == arg_14_0.preScaleY and arg_14_0._forceUpdateCount == 0 then
		return
	end

	if arg_14_0._forceUpdateCount > 0 then
		arg_14_0._forceUpdateCount = arg_14_0._forceUpdateCount - 1
	end

	arg_14_0._posVec3.x = var_14_0
	arg_14_0._posVec3.y = var_14_1
	arg_14_0._posVec3.z = var_14_2
	arg_14_0._preScaleX, arg_14_0.preScaleY = var_14_3, var_14_4

	local var_14_6 = ViewMgr.instance:getUIRoot()
	local var_14_7, var_14_8, var_14_9 = transformhelper.getLocalScale(var_14_6.transform)
	local var_14_10 = Vector4(var_14_0 / var_14_7, var_14_1 / var_14_7, 1 / var_14_3, 1 / var_14_4)

	arg_14_0._mat:SetVector(arg_14_0._centerID, var_14_10)
end

function var_0_0._setKeyword(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_0:getSkeletonGraphic() then
		return
	end

	local var_15_0 = arg_15_0:getSkeletonGraphic().material

	if not var_15_0 then
		return
	end

	if arg_15_2 == true then
		var_15_0:EnableKeyword(arg_15_1)
	else
		var_15_0:DisableKeyword(arg_15_1)
	end
end

function var_0_0.setUIMask(arg_16_0, arg_16_1)
	arg_16_0:_setKeyword("_UIMASK_ON", arg_16_1)
end

function var_0_0.useRT(arg_17_0)
	arg_17_0._useRT = true
end

function var_0_0.showModel(arg_18_0)
	if arg_18_0._rawImageGo then
		gohelper.setActive(arg_18_0._rawImageGo, true)
	end
end

function var_0_0.hideModel(arg_19_0)
	if arg_19_0._rawImageGo then
		gohelper.setActive(arg_19_0._rawImageGo, false)
	end
end

function var_0_0.setImageUIMask(arg_20_0, arg_20_1)
	if arg_20_0._imgMat then
		if arg_20_1 == true then
			arg_20_0._imgMat:EnableKeyword("_UIMASK_ON")
		else
			arg_20_0._imgMat:DisableKeyword("_UIMASK_ON")
		end
	else
		arg_20_0._uiMaskBuffer = arg_20_1
	end
end

function var_0_0.setFreezeState(arg_21_0, arg_21_1)
	arg_21_0._bFreeze = arg_21_1

	if not arg_21_0._skeletonComponent then
		return
	end

	arg_21_0._skeletonComponent.freeze = arg_21_1
end

return var_0_0
