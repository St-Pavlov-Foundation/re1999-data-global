module("modules.logic.achievement.view.AchievementMainViewPool", package.seeall)

slot0 = class("AchievementMainViewPool", BaseView)

function slot0.ctor(slot0, slot1)
	slot0._resPath = slot1 or ""
end

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0:initPool()
end

function slot0.initPool(slot0)
	slot0._gopool = gohelper.findChild(slot0.viewGO, "#go_pool")

	if not slot0._gopool then
		slot0._gopool = gohelper.create2d(slot0.viewGO, "#go_pool")
		slot1 = gohelper.onceAddComponent(slot0._gopool, gohelper.Type_CanvasGroup)
		slot1.alpha = 0
		slot1.interactable = false
		slot1.blocksRaycasts = false

		recthelper.setAnchorX(slot0._gopool.transform, 10000)
	end

	slot0._tfpool = slot0._gopool.transform
	slot0._iconIndex = 1
	slot0._freeIconList = {}
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.getIcon(slot0, slot1)
	if string.nilorempty(slot0._resPath) then
		logError("resPath is nil")

		return
	end

	slot2 = slot0:getOrCreateIconInternal()

	slot2.viewGO.transform:SetParent(slot1.transform, false)
	recthelper.setAnchor(slot2.viewGO.transform, 0, 0)
	transformhelper.setLocalScale(slot2.viewGO.transform, 1, 1, 1)

	return slot2
end

function slot0.getOrCreateIconInternal(slot0)
	slot1 = nil
	slot2 = slot0._freeIconList and #slot0._freeIconList or 0

	return (slot2 > 0 or slot0:createIconInternal()) and table.remove(slot0._freeIconList, slot2)
end

function slot0.createIconInternal(slot0)
	slot1 = AchievementMainIcon.New()
	slot0._iconIndex = slot0._iconIndex + 1

	slot1:init(slot0:getResInst(slot0._resPath, slot0._gopool, "icon" .. tostring(slot0._iconIndex)))

	return slot1
end

function slot0.recycleIcon(slot0, slot1)
	if not gohelper.isNil(slot1.viewGO) then
		slot1.viewGO.transform:SetParent(slot0._tfpool)
	end

	if slot0._freeIconList then
		table.insert(slot0._freeIconList, slot1)
	end
end

function slot0.onDestroyView(slot0)
	slot0:release()
end

function slot0.release(slot0)
	if slot0._freeIconList then
		for slot4, slot5 in pairs(slot0._freeIconList) do
			slot5:dispose()
		end

		slot0._freeIconList = nil
	end
end

return slot0
