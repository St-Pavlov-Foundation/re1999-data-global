module("modules.ugui.icon.common.CommonLiveHeadIcon", package.seeall)

slot0 = class("CommonLiveHeadIcon", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._simageHeadIcon = slot1
	slot0._imageComp = slot0._simageHeadIcon.gameObject:GetComponent(gohelper.Type_Image)
end

function slot0.setLiveHead(slot0, slot1, slot2, slot3, slot4, slot5)
	slot2 = slot2 and true or false
	slot3 = slot3 and true or false

	if not tonumber(slot1) then
		return
	end

	if lua_item.configDict[slot1] == nil then
		return
	end

	slot0.isDynamic = slot6.isDynamic == IconMgrConfig.HeadIconType.Dynamic
	slot0.setNativeSize = slot2
	slot0.isParallel = slot3
	slot0.isGray = false

	if slot0.portraitId and slot0.portraitId == tonumber(slot6.icon) then
		slot0:syncAnimationTime()
		slot0:calculateSize()

		if slot4 and slot5 then
			slot4(slot5, slot0)
		end

		return
	end

	if not slot0._loader then
		slot0._loader = PrefabInstantiate.Create(slot0._simageHeadIcon.gameObject)
	end

	if not gohelper.isNil(slot0._dynamicIconObj) then
		logNormal("destroy liveHead icon" .. tostring(slot0._dynamicIconObj.name))
		slot0:removeHeadLiveIcon()
		slot0._loader:dispose()

		slot0.animation = nil
	elseif slot0._loader:getPath() then
		slot0._loader:dispose()
	end

	slot0.portraitId = slot7
	slot0.callBack = slot4
	slot0.callBackObj = slot5

	if not slot8 then
		logNormal("set static icon portraitId: " .. tostring(slot7))
		slot0._simageHeadIcon:LoadImage(ResUrl.getPlayerHeadIcon(slot7), slot0._onStaticLoadCallBack, slot0)
	else
		logNormal("set dynamic icon portraitId: " .. tostring(slot7))
		slot0:setDynamicIcon(slot7)
	end
end

function slot0.setDynamicIcon(slot0, slot1)
	slot0.portraitId = slot1

	slot0._loader:startLoad(ResUrl.getLiveHeadIconPrefab(slot1), slot0._onLoadCallBack, slot0)
end

function slot0._onStaticLoadCallBack(slot0)
	if slot0.setNativeSize then
		slot0._imageComp:SetNativeSize()
	end

	slot0:invokeCallBack()
end

function slot0._onLoadCallBack(slot0)
	slot0:reInitComp()
	slot0:syncAnimationTime()
	slot0:setMaterial()
	slot0:calculateSize()
	slot0:invokeCallBack()
end

function slot0.reInitComp(slot0)
	slot0._dynamicIconObj = slot0._loader:getInstGO()
	slot0._root = gohelper.findChild(slot0._dynamicIconObj, "root")
	slot0.animation = gohelper.findChildComponent(slot0._dynamicIconObj, "root", gohelper.Type_Animation)

	if slot0.animation ~= nil and slot0.animation.clip ~= nil then
		slot0.animationState = slot0.animation:get_Item(slot0.animation.clip.name)
	end

	IconMgr.instance:addLiveIconAnimationReferenceTime(slot0.portraitId)
end

function slot0.invokeCallBack(slot0)
	if not slot0.callBack or not slot0.callBackObj then
		return
	end

	slot0.callBack(slot0.callBackObj, slot0)

	slot0.callBack = nil
	slot0.callBackObj = nil
end

function slot0.calculateSize(slot0)
	if gohelper.isNil(slot0._dynamicIconObj) then
		return
	end

	if slot0.isParallel then
		slot0._dynamicIconObj.transform.parent = slot0._simageHeadIcon.transform.parent
	else
		slot0._dynamicIconObj.transform.parent = slot0._simageHeadIcon.transform
	end

	slot0:setDynamicVisible(slot0.isDynamic and not slot0.isGray)
	slot0:setStaticVisible(not slot0.isDynamic or slot0.isGray)

	slot1 = slot0._simageHeadIcon.gameObject.transform
	slot2 = recthelper.getWidth(slot0._root.transform)

	if not slot0.isParallel then
		slot3 = 1

		if not slot0.setNativeSize then
			gohelper.setAsFirstSibling(slot0._dynamicIconObj)

			slot3 = math.max(0, recthelper.getWidth(slot0._simageHeadIcon.transform) / recthelper.getWidth(slot0._root.transform))

			transformhelper.setLocalScale(slot0._dynamicIconObj.transform, slot3, slot3, 1)
		else
			recthelper.setSize(slot1, slot2, slot2)
		end

		return
	end

	gohelper.setSiblingAfter(slot0._dynamicIconObj, slot0._simageHeadIcon.gameObject)

	slot3, slot4 = transformhelper.getLocalScale(slot1)
	slot5, slot6, slot7 = transformhelper.getPos(slot1)
	slot8 = 1

	if not slot0.setNativeSize then
		slot8 = math.max(0, recthelper.getWidth(slot1) / slot2)
	else
		recthelper.setSize(slot1, slot2, slot2)
	end

	slot9, slot10, slot11 = transformhelper.getLocalRotation(slot1)

	transformhelper.setLocalRotation(slot0._dynamicIconObj.transform, slot9, slot10, slot11)
	transformhelper.setLocalScale(slot0._dynamicIconObj.transform, slot8 * slot3, slot8 * slot4, 1)
	transformhelper.setPos(slot0._dynamicIconObj.transform, slot5, slot6, slot7)
end

function slot0.setMaterial(slot0)
	if not slot0.isDynamic then
		return
	end

	if gohelper.findChildImage(slot0.imageReference, "") == nil or slot1.material == nil then
		return
	end

	slot0:traverseReplaceChildrenMaterial(slot0._root, slot1.material)
end

function slot0.traverseReplaceChildrenMaterial(slot0, slot1, slot2)
	if slot1:GetComponentsInChildren(gohelper.Type_Image).Length <= 0 then
		return
	end

	for slot8 = 0, slot4 - 1 do
		if slot3[slot8] and slot9.material == slot9.defaultMaterial then
			slot9.material = slot2
		end
	end
end

function slot0.setAlpha(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0.isDynamic then
		ZProj.UGUIHelper.SetColorAlpha(slot0._imageComp, slot1)

		return
	end

	if slot0.canvasGroup == nil then
		slot0.canvasGroup = gohelper.onceAddComponent(slot0._dynamicIconObj, gohelper.Type_CanvasGroup)
	end

	if slot0.canvasGroup then
		slot0.canvasGroup.alpha = slot1
	end
end

function slot0.setAnimationTime(slot0, slot1)
	if not slot0.isDynamic or gohelper.isNil(slot0._dynamicIconObj) or slot0.animationState == nil then
		return
	end

	slot3 = UnityEngine.Time.timeSinceLevelLoad - slot1

	if slot0.animationState.length == nil then
		return
	end

	slot2.time = slot3 % slot4
end

function slot0.setGray(slot0, slot1)
	ZProj.UGUIHelper.SetGrayscale(slot0._simageHeadIcon.gameObject, slot1)

	slot0.isGray = slot1

	if not slot0.isDynamic then
		return
	end

	slot0:setStaticVisible(slot1)
	slot0:setDynamicVisible(not slot1)
	slot0._simageHeadIcon:LoadImage(ResUrl.getPlayerHeadIcon(slot0.portraitId))
end

function slot0.setDynamicVisible(slot0, slot1)
	gohelper.setActive(slot0._dynamicIconObj, slot0.isDynamic and slot1)
end

function slot0.setStaticVisible(slot0, slot1)
	if slot0.isParallel then
		gohelper.setActive(slot0._simageHeadIcon, slot1)
	end
end

function slot0.onEnable(slot0)
	slot0:syncAnimationTime()
end

function slot0.syncAnimationTime(slot0)
	if not slot0.isDynamic or gohelper.isNil(slot0._dynamicIconObj) or slot0.animationState == nil then
		return
	end

	if IconMgr.instance:getLiveIconReferenceTime(slot0.portraitId) then
		slot0:setAnimationTime(slot1)
	end
end

function slot0.removeHeadLiveIcon(slot0)
	if not slot0.isDynamic or gohelper.isNil(slot0._dynamicIconObj) then
		return
	end

	IconMgr.instance:removeHeadLiveIcon(slot0.portraitId)

	slot0._dynamicIconObj = nil
end

function slot0.onDestroy(slot0)
	slot0:removeHeadLiveIcon()

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

return slot0
