module("modules.ugui.icon.common.CommonRedDotIconNoEvent", package.seeall)

slot0 = class("CommonRedDotIconNoEvent", LuaCompBase)

function slot0.init(slot0, slot1)
	slot5 = IconMgrConfig.UrlRedDotIcon
	slot6 = slot1
	slot0.go = IconMgr.instance:_getIconInstance(slot5, slot6)
	slot0.typeGoDict = slot0:getUserDataTb_()
	slot0.isShowRedDot = false

	for slot5, slot6 in pairs(RedDotEnum.Style) do
		slot0.typeGoDict[slot6] = gohelper.findChild(slot0.go, "type" .. slot6)

		gohelper.setActive(slot0.typeGoDict[slot6], false)
	end
end

function slot0.onStart(slot0)
	slot0:refreshRedDot()
end

function slot0.setCheckShowRedDotFunc(slot0, slot1, slot2)
	slot0.checkFunc = slot1
	slot0.checkFuncObj = slot2

	slot0:refreshRedDot()
end

function slot0.setShowType(slot0, slot1)
	slot0.showType = slot1 or RedDotEnum.Style.Normal
end

function slot0.refreshRedDot(slot0)
	if not slot0.checkFunc then
		gohelper.setActive(slot0.go, false)

		return
	end

	slot1 = slot0.checkFunc(slot0.checkFuncObj)
	slot0.isShowRedDot = slot1

	gohelper.setActive(slot0.go, slot1)

	if slot1 then
		for slot5, slot6 in pairs(RedDotEnum.Style) do
			gohelper.setActive(slot0.typeGoDict[slot6], slot0.showType == slot6)
		end
	end
end

function slot0.setScale(slot0, slot1)
	transformhelper.setLocalScale(slot0.go.transform, slot1, slot1, slot1)
end

function slot0.onDestroy(slot0)
	slot0.checkFunc = nil
	slot0.checkFuncObj = nil
end

return slot0
