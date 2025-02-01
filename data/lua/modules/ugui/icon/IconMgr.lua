module("modules.ugui.icon.IconMgr", package.seeall)

slot0 = class("IconMgr")

function slot0.preload(slot0, slot1, slot2)
	slot0._callback = slot1
	slot0._callbackObj = slot2
	slot0._resDict = {}
	slot0._loader = MultiAbLoader.New()

	slot0._loader:setPathList(IconMgrConfig.getPreloadList())
	slot0._loader:setOneFinishCallback(slot0._onOnePreloadCallback, slot0)
	slot0._loader:startLoad(slot0._onPreloadCallback, slot0)

	slot0._liveIconReferenceTimeDic = {}
	slot0._liveIconCountDic = {}
end

function slot0.getCommonPropItemIcon(slot0, slot1)
	if slot0:_getIconInstance(IconMgrConfig.UrlPropItemIcon, slot1) then
		return MonoHelper.addNoUpdateLuaComOnceToGo(slot2, CommonPropItemIcon)
	end
end

function slot0.getCommonPropListItemIcon(slot0, slot1)
	if slot0:_getIconInstance(IconMgrConfig.UrlPropItemIcon, slot1) then
		return MonoHelper.addNoUpdateLuaComOnceToGo(slot2, CommonPropListItem)
	end
end

function slot0.getCommonPropItemIconList(slot0, slot1, slot2, slot3, slot4)
	slot0:CreateCellList(slot1, slot2, slot3, slot4, IconMgrConfig.UrlPropItemIcon, CommonPropItemIcon)
end

function slot0.getCommonItemIcon(slot0, slot1)
	if slot0:_getIconInstance(IconMgrConfig.UrlItemIcon, slot1) then
		return MonoHelper.addNoUpdateLuaComOnceToGo(slot2, CommonItemIcon)
	end
end

function slot0.getCommonEquipIcon(slot0, slot1, slot2)
	if slot0:_getIconInstance(IconMgrConfig.UrlEquipIcon, slot1) then
		if slot2 then
			transformhelper.setLocalScale(slot3.transform, slot2, slot2, slot2)
		end

		return MonoHelper.addNoUpdateLuaComOnceToGo(slot3, CommonEquipIcon)
	end
end

function slot0.getCommonHeroIcon(slot0, slot1)
	if slot0:_getIconInstance(IconMgrConfig.UrlHeroIcon, slot1) then
		return MonoHelper.addNoUpdateLuaComOnceToGo(slot2, CommonHeroIcon)
	end
end

function slot0.getCommonHeroIconNew(slot0, slot1)
	if slot0:_getIconInstance(IconMgrConfig.UrlHeroIconNew, slot1) then
		return MonoHelper.addNoUpdateLuaComOnceToGo(slot2, CommonHeroIconNew)
	end
end

function slot0.getCommonHeroItem(slot0, slot1)
	if slot0:_getIconInstance(IconMgrConfig.UrlHeroItemNew, slot1) then
		return MonoHelper.addNoUpdateLuaComOnceToGo(slot2, CommonHeroItem)
	end
end

function slot0.getCommonPlayerIcon(slot0, slot1)
	if slot0:_getIconInstance(IconMgrConfig.UrlPlayerIcon, slot1) then
		return MonoHelper.addNoUpdateLuaComOnceToGo(slot2, CommonPlayerIcon)
	end
end

function slot0.getRoomGoodsItem(slot0, slot1, slot2)
	if slot2 and slot2:getResInst(IconMgrConfig.UrlRoomGoodsItemIcon, slot1) then
		return MonoHelper.addNoUpdateLuaComOnceToGo(slot3, RoomGoodsItem)
	end
end

function slot0.getCommonTextMarkTop(slot0, slot1)
	return slot0:_getIconInstance(IconMgrConfig.UrlCommonTextMarkTop, slot1)
end

function slot0.getCommonTextDotBottom(slot0, slot1)
	return slot0:_getIconInstance(IconMgrConfig.UrlCommonTextDotBottom, slot1)
end

function slot0.getCommonHeadIcon(slot0, slot1)
	if slot0:_getIconInstance(IconMgrConfig.UrlHeadIcon, slot1) then
		return MonoHelper.addNoUpdateLuaComOnceToGo(slot2, CommonHeadIcon)
	end
end

function slot0.getCommonCritterIcon(slot0, slot1)
	if slot0:_getIconInstance(IconMgrConfig.UrlCritterIcon, slot1) then
		return MonoHelper.addNoUpdateLuaComOnceToGo(slot2, CommonCritterIcon)
	end
end

function slot0._getIconInstance(slot0, slot1, slot2)
	if slot0._resDict[slot1] then
		if slot3:GetResource(slot1) then
			return gohelper.clone(slot4, slot2)
		else
			logError(slot1 .. " prefab not in ab")
		end
	end

	logError(slot1 .. " iconPrefab need preload")
end

function slot0._onOnePreloadCallback(slot0, slot1, slot2)
	slot0._resDict[slot2.ResPath] = slot2
end

function slot0._onPreloadCallback(slot0)
	if slot0._callback then
		slot0._callback(slot0._callbackObj)
	end

	slot0._callback = nil
	slot0._callbackObj = nil
end

function slot0.CreateCellList(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	gohelper.CreateObjList(slot1, slot2, slot3, slot4, slot0:getModelPrefab(slot5), slot6)
end

function slot0.getModelPrefab(slot0, slot1)
	return slot0._resDict[slot1]:GetResource(slot1)
end

function slot0.getCommonLiveHeadIcon(slot0, slot1)
	slot2 = MonoHelper.addNoUpdateLuaComOnceToGo(slot1.gameObject, CommonLiveHeadIcon)

	slot2:init(slot1)

	return slot2
end

function slot0.setHeadIcon(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot3 = slot3 and true or false
	slot4 = slot4 and true or false
	slot5 = slot5 and true or false

	if lua_item.configDict[tonumber(slot0)] == nil then
		return
	end

	if slot6 then
		ZProj.UGUIHelper.SetColorAlpha(slot1.gameObject:GetComponent(gohelper.Type_Image), slot6)
	end

	slot10 = tonumber(slot9.icon)

	if slot9.isDynamic == IconMgrConfig.HeadIconType.Dynamic then
		if not slot2 then
			MonoHelper.addNoUpdateLuaComOnceToGo(slot1.gameObject, CommonLiveHeadIcon):init(slot5 and slot1.transform.parent.gameObject or slot1.transform.gameObject)
		end

		slot2:setLiveHead(slot10, slot1.gameObject, slot3, slot5, slot6)
	else
		slot12 = ItemConfig.instance:getItemIconById(slot10)
		slot13 = slot3 and function ()
			if uv0 then
				uv1.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
			end

			if uv2 then
				uv2(uv3)
			end
		end or slot7

		if slot3 then
			-- Nothing
		end

		slot1:LoadImage(ResUrl.getPlayerHeadIcon(slot12), slot13, slot8)
	end

	if slot2 then
		slot2:setVisible(slot11)
	end

	if slot4 then
		gohelper.setActive(slot1.gameObject, not slot11)
	end

	return slot2
end

function slot0.addLiveIconAnimationReferenceTime(slot0, slot1)
	if slot0._liveIconReferenceTimeDic == nil or slot0._liveIconCountDic == nil then
		slot0._liveIconReferenceTimeDic = {}
		slot0._liveIconCountDic = {}
	end

	logNormal("Add LiveIcon")

	if not slot0._liveIconReferenceTimeDic[slot1] then
		slot0._liveIconCountDic[slot1] = 1
		slot0._liveIconReferenceTimeDic[slot1] = UnityEngine.Time.timeSinceLevelLoad
	else
		slot0._liveIconCountDic[slot1] = slot0._liveIconCountDic[slot1] + 1
	end
end

function slot0.removeHeadLiveIcon(slot0, slot1)
	if not slot0._liveIconReferenceTimeDic[slot1] then
		logNormal("Have no headLiveIcon Reference")

		return
	end

	logNormal("Remove LiveIcon")

	if math.max(0, slot0._liveIconCountDic[slot1] - 1) <= 0 then
		slot0._liveIconReferenceTimeDic[slot1] = nil
		slot0._liveIconCountDic[slot1] = nil
	else
		slot0._liveIconCountDic[slot1] = slot3
	end
end

function slot0.getLiveIconReferenceTime(slot0, slot1)
	if not slot0._liveIconReferenceTimeDic or not slot0._liveIconReferenceTimeDic[slot1] then
		logError("Have no ReferenceTime id: " .. tostring(slot1))

		return 0
	end

	return slot0._liveIconReferenceTimeDic[slot1]
end

slot0.instance = slot0.New()

return slot0
