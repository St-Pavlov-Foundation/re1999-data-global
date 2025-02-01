module("modules.common.others.LuaMixScrollViewExtended", package.seeall)

slot0 = LuaMixScrollView
slot0.__onUpdateCell = slot0._onUpdateCell

function slot0.setDynamicGetItem(slot0, slot1, slot2)
	slot0._dynamicGetCallback = slot1
	slot0._dynamicGetCallbackObj = slot2
	slot0._useDynamicGetItem = true
end

function slot0._onUpdateCell(slot0, slot1, slot2, slot3, slot4)
	if not slot0._useDynamicGetItem then
		uv0.__onUpdateCell(slot0, slot1, slot2, slot3, slot4)

		return
	end

	slot6, slot7, slot8 = slot0._dynamicGetCallback(slot0._dynamicGetCallbackObj, slot0._model:getByIndex(slot2 + 1))
	slot6 = slot6 or LuaListScrollView.PrefabInstName
	slot7 = slot7 or slot0._param.cellClass
	slot8 = slot8 or slot0._param.prefabUrl

	for slot14 = 1, slot1.transform.childCount do
		slot15 = slot9:GetChild(slot14 - 1)

		gohelper.setActive(slot15, slot15.name == slot6)
	end

	slot11 = slot0:_getLuaCellComp(slot1, slot6, slot7, slot8)
	slot11._index = slot2 + 1

	slot11:onUpdateMO(slot5, slot3, slot4)
end

function slot0._getLuaCellComp(slot0, slot1, slot2, slot3, slot4)
	slot6 = nil

	if gohelper.findChild(slot1, slot2) then
		slot6 = MonoHelper.getLuaComFromGo(slot5, slot3)
	else
		if slot0._param.prefabType == ScrollEnum.ScrollPrefabFromRes then
			slot5 = slot0:getResInst(slot4, slot1, slot2)
		elseif slot0._param.prefabType == ScrollEnum.ScrollPrefabFromView then
			gohelper.setActive(gohelper.clone(slot0._cellSourceGO, slot1, slot2), true)
		else
			logError("LuaMixScrollView prefabType not support: " .. slot0._param.prefabType)
		end

		slot6 = MonoHelper.addNoUpdateLuaComOnceToGo(slot5, slot3)

		slot6:initInternal(slot5, slot0)

		slot0._cellCompDict[slot6] = true
	end

	return slot6
end

function slot0.activateExtend()
end

return slot0
