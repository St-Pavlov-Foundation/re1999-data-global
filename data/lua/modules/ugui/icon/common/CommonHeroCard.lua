module("modules.ugui.icon.common.CommonHeroCard", package.seeall)

slot0 = class("CommonHeroCard", ListScrollCell)
slot1 = typeof(UnityEngine.UI.Mask)
slot2 = 0.001

function slot0.create(slot0, slot1)
	slot2 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0, uv0)

	slot2:setUseCase(slot1)

	return slot2
end

slot3 = {}

function slot0.put(slot0, slot1, slot2)
	if not slot0 or not slot1 or not slot2 then
		if isDebugBuild then
			logError(string.format("put 参数为空 case{%s} skin{%s} spine{%s}", tostring(slot0), tostring(slot1), tostring(slot2)))
		end

		return
	end

	uv0[slot0] = uv0[slot0] or {}
	uv0[slot0][slot1] = uv0[slot0][slot1] or {}

	table.insert(uv0[slot0][slot1], slot2)
end

function slot0.get(slot0, slot1)
	if not slot0 or not slot1 then
		if isDebugBuild then
			logError(string.format("get 参数为空 case{%s} skin{%s}", tostring(slot0), tostring(slot1)))
		end

		return
	end

	if uv0[slot0] and slot2[slot1] and #slot3 > 0 then
		for slot7 = #slot3, 1, -1 do
			if not gohelper.isNil(table.remove(slot3, #slot3):getSpineGo()) then
				return slot8
			end
		end
	end
end

function slot0.release(slot0, slot1)
	if not slot0 or not slot1 then
		if isDebugBuild then
			logError(string.format("release 参数为空 case{%s} spine{%s}", tostring(slot0), tostring(slot1)))
		end

		return
	end

	if uv0[slot0] then
		for slot6, slot7 in pairs(slot2) do
			for slot11 = #slot7, 1, -1 do
				if slot1 == slot7[slot11] then
					table.remove(slot7, slot11)
				end
			end
		end
	end
end

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._tr = slot1.transform
	slot0._imgIcon = gohelper.onceAddComponent(slot0._go, gohelper.Type_Image)
	slot0._spineGO = nil
	slot0._guiSpine = nil
end

function slot0.setUseCase(slot0, slot1)
	slot0._reuseCase = slot1
end

function slot0.setSpineRaycastTarget(slot0, slot1)
	slot0._raycastTarget = slot1 == true and true or false

	if slot0._uiLimitSpine and slot0._uiLimitSpine:getSkeletonGraphic() then
		slot2.raycastTarget = slot0._raycastTarget
	end
end

function slot0.setGrayScale(slot0, slot1)
	ZProj.UGUIHelper.SetGrayscale(slot0._go, slot1)
end

function slot0.setGrayFactor(slot0, slot1)
	slot0._grayFactor = slot1
	slot4 = slot0._grayFactor and uv0 < slot0._grayFactor

	if (slot0._grayFactor and uv0 < slot2 and not slot4 or not slot3 and slot4) and slot0._skinConfig then
		slot0:onUpdateMO(slot0._skinConfig, true)
	end

	ZProj.UGUIHelper.SetGrayFactor(slot0._go, slot1)
end

function slot0.onUpdateMO(slot0, slot1, slot2)
	if slot1 and slot1 == slot0._skinConfig and not slot2 then
		return
	end

	slot0:_checkPutSpineToPool(slot0._skinConfig)

	slot0._skinConfig = slot1
	slot0._limitedCO = slot0._skinConfig and lua_character_limited.configDict[slot0._skinConfig.id]

	if slot0._limitedCO and not string.nilorempty(slot0._limitedCO.spine) and not (slot0._grayFactor and uv0 < slot0._grayFactor) then
		if slot0._uiLimitSpine then
			slot0._uiLimitSpine:setResPath(ResUrl.getRolesBustPrefab(slot0._limitedCO.spine), slot0._onSpineLoaded, slot0, true)
		else
			if slot0._reuseCase then
				slot0._uiLimitSpine = uv1.get(slot0._reuseCase, slot0._skinConfig.id)

				if slot0._uiLimitSpine then
					slot0._limitSpineGO = slot0._uiLimitSpine._gameObj
					slot6, slot7 = recthelper.getAnchor(slot0._limitSpineGO.transform)

					gohelper.addChild(slot0._go, slot0._limitSpineGO)
					recthelper.setAnchor(slot0._limitSpineGO.transform, slot6, slot7)
				end
			end

			if not slot0._uiLimitSpine then
				slot0._limitSpineGO = gohelper.create2d(slot0._go, "LimitedSpine")
				slot0._uiLimitSpine = GuiSpine.Create(slot0._limitSpineGO, false)

				slot0._uiLimitSpine:setResPath(slot5, slot0._onSpineLoaded, slot0, true)
			end
		end

		gohelper.setActive(slot0._limitSpineGO, true)
		gohelper.setAsFirstSibling(slot0._limitSpineGO)

		if slot0._simageIcon then
			slot0._simageIcon:UnLoadImage()
		end

		slot0._imgIcon.enabled = true

		TaskDispatcher.runRepeat(slot0._checkAlphaClip, slot0, 0.05, 20)
	else
		TaskDispatcher.cancelTask(slot0._checkAlphaClip, slot0)

		if not slot0._simageIcon then
			slot0._simageIcon = gohelper.getSingleImage(slot0._go)
		end

		if slot0._simageIcon.curImageUrl ~= ResUrl.getHeadIconMiddle(slot0._skinConfig.retangleIcon) then
			slot0._simageIcon:UnLoadImage()
		end

		slot0._simageIcon:LoadImage(slot5)
	end

	if slot4 then
		if not slot0._mask then
			slot0._mask = gohelper.onceAddComponent(slot0._go, uv2)
			slot0._mask.showMaskGraphic = false
		end

		slot0._mask.enabled = true
	elseif slot0._mask then
		slot0._mask.enabled = false
	end
end

function slot0.onEnable(slot0)
	if slot0._uiLimitSpine then
		TaskDispatcher.runRepeat(slot0._checkAlphaClip, slot0, 0.05, 20)
	end
end

function slot0._checkAlphaClip(slot0)
	if not slot0._uiLimitSpine then
		TaskDispatcher.cancelTask(slot0._checkAlphaClip, slot0)

		return
	end

	if gohelper.isNil(slot0._uiLimitSpine:getSkeletonGraphic()) then
		return
	end

	if slot1.color.a < 1 then
		ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, 0.5)

		return
	end

	slot2 = slot1.transform.parent

	for slot6 = 1, 5 do
		if slot2 == nil then
			return
		end

		if slot2:GetComponent(gohelper.Type_CanvasGroup) and slot7.alpha < 1 then
			ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, 0.5)

			return
		end

		slot2 = slot2.parent
	end
end

function slot0._checkPutSpineToPool(slot0, slot1)
	if slot0._uiLimitSpine then
		if not gohelper.isNil(slot0._uiLimitSpine:getSpineGo()) then
			gohelper.setActive(slot0._limitSpineGO, false)

			if slot0._reuseCase and slot1 then
				uv0.put(slot0._reuseCase, slot1.id, slot0._uiLimitSpine)

				slot0._uiLimitSpine = nil
				slot0._limitSpineGO = nil
			end
		else
			slot0._uiLimitSpine:doClear()

			if not gohelper.isNil(slot0._limitSpineGO) then
				gohelper.destroy(slot0._limitSpineGO)
			end

			slot0._uiLimitSpine = nil
			slot0._limitSpineGO = nil
		end
	end
end

function slot0._onSpineLoaded(slot0)
	slot3 = slot0._limitedCO.spineParam[3] or 1
	slot4 = slot0._uiLimitSpine:getSpineTr()

	recthelper.setAnchor(slot4, recthelper.getAnchor(slot0._tr))
	recthelper.setWidth(slot4, recthelper.getWidth(slot0._tr))
	recthelper.setHeight(slot4, recthelper.getHeight(slot0._tr))
	recthelper.setAnchor(slot4, slot0._limitedCO.spineParam[1] or 0, slot0._limitedCO.spineParam[2] or 0)
	transformhelper.setLocalScale(slot4, slot3, slot3, 1)
	slot0:setSpineRaycastTarget(slot0._raycastTarget)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._checkAlphaClip, slot0)

	if slot0._reuseCase then
		if not slot0._uiLimitSpine and gohelper.findChild(slot0._go, "LimitedSpine") then
			slot0._uiLimitSpine = MonoHelper.getLuaComFromGo(slot1, GuiSpine)
		end

		if slot0._uiLimitSpine then
			uv0.release(slot0._reuseCase, slot0._uiLimitSpine)
		end
	end

	if slot0._uiLimitSpine then
		slot0._uiLimitSpine:doClear()

		slot0._uiLimitSpine = nil
	end

	if slot0._simageIcon then
		slot0._simageIcon:UnLoadImage()

		slot0._simageIcon = nil
	end
end

return slot0
