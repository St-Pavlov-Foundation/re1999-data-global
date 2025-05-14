module("modules.spine.UnitSpineRenderer", package.seeall)

local var_0_0 = class("UnitSpineRenderer", LuaCompBase)
local var_0_1 = "_ScriptCtrlColor"

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._entity = arg_1_1
	arg_1_0._color = nil
	arg_1_0._unitSpine = nil
	arg_1_0._alphaTweenId = nil
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
end

function var_0_0.onDestroy(arg_3_0)
	arg_3_0:_stopAlphaTween()
	gohelper.destroy(arg_3_0._replaceMat)
	gohelper.destroy(arg_3_0._cloneOriginMat)

	arg_3_0._color = nil
	arg_3_0._unitSpine = nil
	arg_3_0._skeletonAnim = nil
	arg_3_0._spineRenderer = nil
	arg_3_0._replaceMat = nil
	arg_3_0._sharedMaterial = nil
	arg_3_0._cloneOriginMat = nil
end

function var_0_0.setSpine(arg_4_0, arg_4_1)
	arg_4_0._unitSpine = arg_4_1
	arg_4_0._skeletonAnim = arg_4_0._unitSpine:getSpineGO():GetComponent(UnitSpine.TypeSkeletonAnimtion)
	arg_4_0._spineRenderer = arg_4_0._unitSpine:getSpineGO():GetComponent(typeof(UnityEngine.MeshRenderer))

	if not gohelper.isNil(arg_4_1:getSpineGO()) then
		arg_4_0._sharedMaterial = arg_4_0._spineRenderer.sharedMaterial

		if arg_4_0._replaceMat then
			arg_4_0:replaceSpineMat(arg_4_0._replaceMat)
		end
	end
end

function var_0_0.getReplaceMat(arg_5_0)
	if not arg_5_0._replaceMat then
		arg_5_0._replaceMat = arg_5_0:getSpineRenderMat()
		arg_5_0._cloneOriginMat = arg_5_0._replaceMat

		if arg_5_0._sharedMaterial and arg_5_0._replaceMat then
			arg_5_0:_setReplaceMat(arg_5_0._sharedMaterial, arg_5_0._replaceMat)
		end
	end

	return arg_5_0._replaceMat
end

function var_0_0.getCloneOriginMat(arg_6_0)
	return arg_6_0._cloneOriginMat
end

function var_0_0.getSpineRenderMat(arg_7_0)
	return arg_7_0._spineRenderer and arg_7_0._spineRenderer.material
end

function var_0_0._setReplaceMat(arg_8_0, arg_8_1, arg_8_2)
	if gohelper.isNil(arg_8_1) then
		return
	end

	if arg_8_0._skeletonAnim then
		local var_8_0 = arg_8_0._skeletonAnim.CustomMaterialOverride

		if var_8_0 then
			var_8_0:Clear()

			if not gohelper.isNil(arg_8_2) then
				var_8_0:Add(arg_8_1, arg_8_2)
			end
		end
	end
end

function var_0_0.replaceSpineMat(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0._replaceMat = arg_9_1

		if arg_9_0._skeletonAnim then
			local var_9_0 = arg_9_0:getSpineRenderMat()

			FightSpineMatPool.returnMat(var_9_0)
			arg_9_0:_setReplaceMat(arg_9_0._sharedMaterial, arg_9_0._replaceMat)
			arg_9_0._replaceMat:SetTexture("_MainTex", var_9_0:GetTexture("_MainTex"))
			arg_9_0._replaceMat:SetTexture("_NormalMap", var_9_0:GetTexture("_NormalMap"))
			arg_9_0._replaceMat:SetVector("_RoleST", var_9_0:GetVector("_RoleST"))
			arg_9_0._replaceMat:SetVector("_RoleSheet", var_9_0:GetVector("_RoleSheet"))
		end
	else
		logError("replaceSpineMat fail, mat = nil")
	end
end

function var_0_0.resetSpineMat(arg_10_0)
	if arg_10_0._replaceMat then
		if arg_10_0._cloneOriginMat then
			if arg_10_0._replaceMat ~= arg_10_0._cloneOriginMat then
				FightSpineMatPool.returnMat(arg_10_0._replaceMat)

				arg_10_0._replaceMat = arg_10_0._cloneOriginMat

				arg_10_0:_setReplaceMat(arg_10_0._sharedMaterial, arg_10_0._cloneOriginMat)
			end
		else
			FightSpineMatPool.returnMat(arg_10_0._replaceMat)

			arg_10_0._replaceMat = nil

			arg_10_0:getReplaceMat()
		end
	end
end

function var_0_0.setAlpha(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0._unitSpine then
		return
	end

	local var_11_0 = arg_11_0._sharedMaterial

	if gohelper.isNil(var_11_0) or not var_11_0:HasProperty(var_0_1) then
		return
	end

	arg_11_0:_stopAlphaTween()

	local var_11_1 = arg_11_0:getReplaceMat()

	arg_11_0._color = arg_11_0._color or var_11_1:GetColor(var_0_1)

	if arg_11_0._color.a == arg_11_1 then
		arg_11_0:setColor(arg_11_0._color)
		arg_11_0:_setRendererEnabled(arg_11_1 > 0)

		return
	end

	if not arg_11_2 or arg_11_2 <= 0 then
		arg_11_0._color.a = arg_11_1

		arg_11_0:setColor(arg_11_0._color)
		arg_11_0:_setRendererEnabled(arg_11_1 > 0)

		return
	end

	arg_11_0:_setRendererEnabled(true)

	arg_11_0._alphaTweenId = ZProj.TweenHelper.DOTweenFloat(arg_11_0._color.a, arg_11_1, arg_11_2, arg_11_0._frameCallback, arg_11_0._finishCallback, arg_11_0)
end

function var_0_0.setColor(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getReplaceMat()

	var_12_0:SetColor(var_0_1, arg_12_1)

	if arg_12_0._cloneOriginMat and arg_12_0._cloneOriginMat ~= var_12_0 then
		arg_12_0._cloneOriginMat:SetColor(var_0_1, arg_12_1)
	end
end

function var_0_0._frameCallback(arg_13_0, arg_13_1)
	if not arg_13_0._unitSpine then
		return
	end

	local var_13_0 = arg_13_0:getReplaceMat()

	arg_13_0._color = arg_13_0._color or var_13_0:GetColor(var_0_1)

	if arg_13_0._color.a == arg_13_1 then
		arg_13_0:setColor(arg_13_0._color)
		arg_13_0:_setRendererEnabled(arg_13_1 > 0)

		return
	end

	arg_13_0._color.a = arg_13_1

	arg_13_0:setColor(arg_13_0._color)
	arg_13_0:_setRendererEnabled(arg_13_1 > 0)
end

function var_0_0._finishCallback(arg_14_0)
	local var_14_0 = arg_14_0:getReplaceMat()
	local var_14_1 = var_14_0 and var_14_0:GetColor(var_0_1)

	arg_14_0:_setRendererEnabled(var_14_1 and var_14_1.a > 0)

	arg_14_0._color = nil
end

function var_0_0._stopAlphaTween(arg_15_0)
	if arg_15_0._alphaTweenId then
		ZProj.TweenHelper.KillById(arg_15_0._alphaTweenId)

		arg_15_0._alphaTweenId = nil
	end
end

function var_0_0._setRendererEnabled(arg_16_0, arg_16_1)
	if arg_16_0._spineRenderer then
		arg_16_0._spineRenderer.enabled = arg_16_1
	end
end

return var_0_0
