module("modules.ugui.icon.common.CommonRedDotIcon", package.seeall)

slot0 = class("CommonRedDotIcon", ListScrollCell)

function slot0.init(slot0, slot1)
	slot5 = slot1
	slot0.go = IconMgr.instance:_getIconInstance(IconMgrConfig.UrlRedDotIcon, slot5)
	slot0._txtCount = gohelper.findChildText(slot0.go, "type2/#txt_count")
	slot0.typeGoDict = slot0:getUserDataTb_()

	for slot5, slot6 in pairs(RedDotEnum.Style) do
		slot0.typeGoDict[slot6] = gohelper.findChild(slot0.go, "type" .. slot6)

		gohelper.setActive(slot0.typeGoDict[slot6], false)
	end
end

function slot0.addEventListeners(slot0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateFriendInfoDot, slot0.refreshDot, slot0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, slot0.refreshDot, slot0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, slot0.refreshRelateDot, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, slot0.refreshDot, slot0)
end

function slot0.removeEventListeners(slot0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, slot0.refreshDot, slot0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateFriendInfoDot, slot0.refreshDot, slot0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, slot0.refreshRelateDot, slot0)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, slot0.refreshDot, slot0)
end

function slot0.onStart(slot0)
	slot0:refreshDot()
end

function slot0.refreshDot(slot0)
	gohelper.setActive(slot0.go, false)

	if slot0.overrideFunc then
		slot1, slot2 = pcall(slot0.overrideFunc, slot0.overrideFuncObj, slot0)

		if not slot1 then
			logError(string.format("CommonRedDotIcon:overrideFunc error:%s", slot2))
		end

		return
	end

	slot0:defaultRefreshDot()
end

function slot0.defaultRefreshDot(slot0)
	slot0.show = false

	if slot0.infoList then
		for slot4, slot5 in ipairs(slot0.infoList) do
			slot0.show = RedDotModel.instance:isDotShow(slot5.id, slot5.uid)

			if slot0.show then
				slot0._txtCount.text = RedDotModel.instance:getDotInfoCount(slot5.id, slot5.uid)

				slot0:showRedDot(RedDotConfig.instance:getRedDotCO(slot5.id).style)

				return
			end
		end
	end
end

function slot0.refreshRelateDot(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if slot0.infoDict[slot5] then
			slot0:refreshDot()

			return
		end
	end
end

function slot0.setScale(slot0, slot1)
	transformhelper.setLocalScale(slot0.go.transform, slot1, slot1, slot1)
end

function slot0.setId(slot0, slot1, slot2)
	slot0:setMultiId({
		{
			id = slot1,
			uid = slot2
		}
	})
end

function slot0.setMultiId(slot0, slot1)
	slot0.infoDict = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			slot6.uid = slot6.uid or 0
			slot0.infoDict[slot6.id] = slot6.uid
		end
	end

	slot0.infoList = slot1
end

function slot0.showRedDot(slot0, slot1)
	gohelper.setActive(slot0.go, slot0.show)

	if slot0.show then
		for slot5, slot6 in pairs(RedDotEnum.Style) do
			gohelper.setActive(slot0.typeGoDict[slot6], slot1 == slot6)
		end
	end
end

function slot0.SetRedDotTrsWithType(slot0, slot1, slot2, slot3)
	recthelper.setAnchor(slot0.typeGoDict[slot1].transform, slot2, slot3)
end

function slot0.setRedDotTranScale(slot0, slot1, slot2, slot3, slot4)
	transformhelper.setLocalScale(slot0.typeGoDict[slot1].transform, slot2 or 1, slot3 or 1, slot4 or 1)
end

function slot0.setRedDotTranLocalRotation(slot0, slot1, slot2, slot3, slot4)
	transformhelper.setLocalRotation(slot0.typeGoDict[slot1].transform, slot2 or 0, slot3 or 0, slot4 or 0)
end

function slot0.overrideRefreshDotFunc(slot0, slot1, slot2)
	slot0.overrideFunc = slot1
	slot0.overrideFuncObj = slot2
end

function slot0.onDestroy(slot0)
end

return slot0
