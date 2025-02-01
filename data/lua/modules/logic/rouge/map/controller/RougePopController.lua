module("modules.logic.rouge.map.controller.RougePopController", package.seeall)

slot0 = class("RougePopController")

function slot0._init(slot0)
	if slot0._inited then
		return
	end

	slot0._inited = true
	slot0.waitPopViewList = {}
	slot0.dataPool = {}
	slot0.showingViewName = nil

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0.onCloseView, slot0)
end

function slot0.getViewData(slot0, slot1, slot2)
	slot3 = nil
	slot3 = (#slot0.dataPool <= 1 or table.remove(slot0.dataPool)) and {}
	slot3.type = RougeEnum.PopType.ViewName
	slot3.viewName = slot1
	slot3.param = slot2

	return slot3
end

function slot0.getViewDataByFunc(slot0, slot1, slot2, slot3, ...)
	slot4 = nil
	slot4 = (#slot0.dataPool <= 1 or table.remove(slot0.dataPool)) and {}
	slot4.type = RougeEnum.PopType.Func
	slot4.viewName = slot1
	slot4.openFunc = slot2
	slot4.openFuncObj = slot3
	slot4.funcParam = {
		...
	}

	return slot4
end

function slot0.recycleData(slot0, slot1)
	tabletool.clear(slot1)
	table.insert(slot0.dataPool, slot1)
end

function slot0.onCloseView(slot0, slot1)
	if slot0.showingViewName ~= slot1 then
		return
	end

	slot0:recycleData(slot0.data)

	slot0.data = nil
	slot0.showingViewName = nil

	if slot0:hadPopView() then
		slot0:_popNextView()
	else
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onPopViewDone)
	end
end

function slot0.popViewData(slot0)
	return table.remove(slot0.waitPopViewList, 1)
end

function slot0.hadPopView(slot0)
	return slot0.showingViewName ~= nil or slot0.waitPopViewList and #slot0.waitPopViewList > 0
end

function slot0.addPopViewWithViewName(slot0, slot1, slot2)
	slot0:_init()
	logNormal("add pop view : " .. slot1)
	table.insert(slot0.waitPopViewList, slot0:getViewData(slot1, slot2))
	slot0:_popNextView()
end

function slot0.addPopViewWithOpenFunc(slot0, slot1, slot2, slot3, ...)
	slot0:_init()
	logNormal("add pop view : " .. slot1)
	table.insert(slot0.waitPopViewList, slot0:getViewDataByFunc(slot1, slot2, slot3, ...))
	slot0:_popNextView()
end

function slot0._popNextView(slot0)
	if RougeMapModel.instance:getMapState() <= RougeMapEnum.MapState.LoadingMap then
		return
	end

	if slot0.showingViewName then
		return
	end

	slot0.data = slot0:popViewData()

	if not slot0.data then
		return
	end

	slot0.showingViewName = slot0.data.viewName

	if slot0.data.type == RougeEnum.PopType.ViewName then
		ViewMgr.instance:openView(slot0.data.viewName, slot0.data.param)
	else
		slot0.data.openFunc(slot0.data.openFuncObj, unpack(slot0.data.funcParam))
	end
end

function slot0.tryPopView(slot0)
	slot0:_popNextView()
end

function slot0.isPopping(slot0)
	return slot0.showingViewName ~= nil
end

function slot0.clearAllPopView(slot0)
	if slot0.waitPopViewList then
		for slot4 = 1, #slot0.waitPopViewList do
			slot0:recycleData(table.remove(slot0.waitPopViewList))
		end
	end
end

slot0.instance = slot0.New()

return slot0
