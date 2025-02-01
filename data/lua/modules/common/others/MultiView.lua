module("modules.common.others.MultiView", package.seeall)

slot0 = class("MultiView", BaseView)

function slot0.ctor(slot0, slot1)
	slot0.viewGO = nil
	slot0.viewContainer = nil
	slot0.viewParam = nil
	slot0.viewName = nil
	slot0.tabContainer = nil
	slot0.rootGO = nil
	slot0._views = slot1
end

function slot0.onInitView(slot0)
	if slot0._views then
		for slot4, slot5 in pairs(slot0._views) do
			slot5:__onInit()

			slot5.viewGO = slot0.viewGO
			slot5.viewContainer = slot0.viewContainer
			slot5.viewParam = slot0.viewParam
			slot5.viewName = slot0.viewName
			slot5.tabContainer = slot0.tabContainer
			slot5.rootGO = slot0.rootGO

			slot5:onInitView()
		end
	end
end

function slot0.addEvents(slot0)
	if slot0._views then
		for slot4, slot5 in pairs(slot0._views) do
			slot5:addEvents()
		end
	end
end

function slot0.onOpen(slot0)
	if slot0._views then
		for slot4, slot5 in pairs(slot0._views) do
			slot5:onOpen()
		end
	end
end

function slot0.onTabSwitchOpen(slot0)
	if slot0._views then
		for slot4, slot5 in pairs(slot0._views) do
			if slot5.onTabSwitchOpen then
				slot5:onTabSwitchOpen()
			end
		end
	end
end

function slot0.onOpenFinish(slot0)
	if slot0._views then
		for slot4, slot5 in pairs(slot0._views) do
			slot5:onOpenFinish()
		end
	end
end

function slot0.onUpdateParam(slot0)
	if slot0._views then
		for slot4, slot5 in pairs(slot0._views) do
			slot5:onUpdateParam()
		end
	end
end

function slot0.onClickModalMask(slot0)
	if slot0._views then
		for slot4, slot5 in pairs(slot0._views) do
			slot5:onClickModalMask()
		end
	end
end

function slot0.onClose(slot0)
	if slot0._views then
		for slot4, slot5 in pairs(slot0._views) do
			slot5:onClose()
		end
	end
end

function slot0.onTabSwitchClose(slot0, slot1)
	if slot0._views then
		for slot5, slot6 in pairs(slot0._views) do
			if slot6.onTabSwitchClose then
				slot6:onTabSwitchClose(slot1)
			end
		end
	end
end

function slot0.onCloseFinish(slot0)
	if slot0._views then
		for slot4, slot5 in pairs(slot0._views) do
			slot5:onCloseFinish()
		end
	end
end

function slot0.removeEvents(slot0)
	if slot0._views then
		for slot4, slot5 in pairs(slot0._views) do
			slot5:removeEvents()
		end
	end
end

function slot0.onDestroyView(slot0)
	if slot0._views then
		for slot4, slot5 in pairs(slot0._views) do
			slot5:onDestroyView()
			slot5:__onDispose()
		end
	end
end

function slot0.callChildrenFunc(slot0, slot1, slot2)
	if slot0._views then
		slot3 = nil

		for slot7, slot8 in pairs(slot0._views) do
			if slot8[slot1] then
				slot3(slot8, slot2)
			end
		end
	end
end

return slot0
