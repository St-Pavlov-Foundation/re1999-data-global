module("modules.spine.UnitSpineRenderer", package.seeall)

slot0 = class("UnitSpineRenderer", LuaCompBase)
slot1 = "_ScriptCtrlColor"

function slot0.ctor(slot0, slot1)
	slot0._entity = slot1
	slot0._color = nil
	slot0._unitSpine = nil
	slot0._alphaTweenId = nil
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
end

function slot0.onDestroy(slot0)
	slot0:_stopAlphaTween()
	gohelper.destroy(slot0._replaceMat)
	gohelper.destroy(slot0._cloneOriginMat)

	slot0._color = nil
	slot0._unitSpine = nil
	slot0._skeletonAnim = nil
	slot0._spineRenderer = nil
	slot0._replaceMat = nil
	slot0._sharedMaterial = nil
	slot0._cloneOriginMat = nil
end

function slot0.setSpine(slot0, slot1)
	slot0._unitSpine = slot1
	slot0._skeletonAnim = slot0._unitSpine:getSpineGO():GetComponent(UnitSpine.TypeSkeletonAnimtion)
	slot0._spineRenderer = slot0._unitSpine:getSpineGO():GetComponent(typeof(UnityEngine.MeshRenderer))

	if not gohelper.isNil(slot1:getSpineGO()) then
		slot0._sharedMaterial = slot0._spineRenderer.sharedMaterial

		if slot0._replaceMat then
			slot0:replaceSpineMat(slot0._replaceMat)
		end
	end
end

function slot0.getReplaceMat(slot0)
	if not slot0._replaceMat then
		slot0._replaceMat = slot0:getSpineRenderMat()
		slot0._cloneOriginMat = slot0._replaceMat

		if slot0._sharedMaterial and slot0._replaceMat then
			slot0:_setReplaceMat(slot0._sharedMaterial, slot0._replaceMat)
		end
	end

	return slot0._replaceMat
end

function slot0.getCloneOriginMat(slot0)
	return slot0._cloneOriginMat
end

function slot0.getSpineRenderMat(slot0)
	return slot0._spineRenderer and slot0._spineRenderer.material
end

function slot0._setReplaceMat(slot0, slot1, slot2)
	if gohelper.isNil(slot1) then
		return
	end

	if slot0._skeletonAnim and slot0._skeletonAnim.CustomMaterialOverride then
		slot3:Clear()

		if not gohelper.isNil(slot2) then
			slot3:Add(slot1, slot2)
		end
	end
end

function slot0.replaceSpineMat(slot0, slot1)
	if slot1 then
		slot0._replaceMat = slot1

		if slot0._skeletonAnim then
			slot2 = slot0:getSpineRenderMat()

			FightSpineMatPool.returnMat(slot2)
			slot0:_setReplaceMat(slot0._sharedMaterial, slot0._replaceMat)
			slot0._replaceMat:SetTexture("_MainTex", slot2:GetTexture("_MainTex"))
			slot0._replaceMat:SetTexture("_NormalMap", slot2:GetTexture("_NormalMap"))
			slot0._replaceMat:SetVector("_RoleST", slot2:GetVector("_RoleST"))
			slot0._replaceMat:SetVector("_RoleSheet", slot2:GetVector("_RoleSheet"))
		end
	else
		logError("replaceSpineMat fail, mat = nil")
	end
end

function slot0.resetSpineMat(slot0)
	if slot0._replaceMat then
		if slot0._cloneOriginMat then
			if slot0._replaceMat ~= slot0._cloneOriginMat then
				FightSpineMatPool.returnMat(slot0._replaceMat)

				slot0._replaceMat = slot0._cloneOriginMat

				slot0:_setReplaceMat(slot0._sharedMaterial, slot0._cloneOriginMat)
			end
		else
			FightSpineMatPool.returnMat(slot0._replaceMat)

			slot0._replaceMat = nil

			slot0:getReplaceMat()
		end
	end
end

function slot0.setAlpha(slot0, slot1, slot2)
	if not slot0._unitSpine then
		return
	end

	if gohelper.isNil(slot0._sharedMaterial) or not slot3:HasProperty(uv0) then
		return
	end

	slot0:_stopAlphaTween()

	slot0._color = slot0._color or slot0:getReplaceMat():GetColor(uv0)

	if slot0._color.a == slot1 then
		slot0:setColor(slot0._color)
		slot0:_setRendererEnabled(slot1 > 0)

		return
	end

	if not slot2 or slot2 <= 0 then
		slot0._color.a = slot1

		slot0:setColor(slot0._color)
		slot0:_setRendererEnabled(slot1 > 0)

		return
	end

	slot0:_setRendererEnabled(true)

	slot0._alphaTweenId = ZProj.TweenHelper.DOTweenFloat(slot0._color.a, slot1, slot2, slot0._frameCallback, slot0._finishCallback, slot0)
end

function slot0.setColor(slot0, slot1)
	slot0:getReplaceMat():SetColor(uv0, slot1)

	if slot0._cloneOriginMat and slot0._cloneOriginMat ~= slot2 then
		slot0._cloneOriginMat:SetColor(uv0, slot1)
	end
end

function slot0._frameCallback(slot0, slot1)
	if not slot0._unitSpine then
		return
	end

	slot0._color = slot0._color or slot0:getReplaceMat():GetColor(uv0)

	if slot0._color.a == slot1 then
		slot0:setColor(slot0._color)
		slot0:_setRendererEnabled(slot1 > 0)

		return
	end

	slot0._color.a = slot1

	slot0:setColor(slot0._color)
	slot0:_setRendererEnabled(slot1 > 0)
end

function slot0._finishCallback(slot0)
	slot2 = slot0:getReplaceMat() and slot1:GetColor(uv0)

	slot0:_setRendererEnabled(slot2 and slot2.a > 0)

	slot0._color = nil
end

function slot0._stopAlphaTween(slot0)
	if slot0._alphaTweenId then
		ZProj.TweenHelper.KillById(slot0._alphaTweenId)

		slot0._alphaTweenId = nil
	end
end

function slot0._setRendererEnabled(slot0, slot1)
	if slot0._spineRenderer then
		slot0._spineRenderer.enabled = slot1
	end
end

return slot0
