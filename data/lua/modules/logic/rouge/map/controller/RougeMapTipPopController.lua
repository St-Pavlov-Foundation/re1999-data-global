module("modules.logic.rouge.map.controller.RougeMapTipPopController", package.seeall)

slot0 = class("RougeMapTipPopController")

function slot0.init(slot0)
	if slot0.inited then
		return
	end

	slot0.inited = true
	slot0.waitTipsList = {}
	slot0.showing = false

	RougeMapController.instance:registerCallback(RougeMapEvent.onCreateMapDoneFlowDone, slot0.popNextTip, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0.popNextTip, slot0)
end

function slot0.addPopTip(slot0, slot1)
	if not slot0.waitTipsList or string.nilorempty(slot1) then
		return
	end

	table.insert(slot0.waitTipsList, slot1)
	slot0:popNextTip()
end

function slot0.addPopTipByInteractId(slot0, slot1)
	if not lua_rouge_interactive.configDict[slot1] then
		logError("not found interact id .. " .. tostring(slot1))

		return
	end

	slot0:addPopTip(slot2.tips)
end

function slot0.addPopTipByEffect(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if not lua_rouge_effect.configDict[slot6] then
			logError("not found effect id .. " .. tostring(slot6))
		else
			slot0:addPopTip(slot7.tips)
		end
	end
end

function slot0.popNextTip(slot0)
	if RougeMapModel.instance:getMapState() <= RougeMapEnum.MapState.WaitFlow then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.RougeNextLayerView) then
		return
	end

	if slot0.showing then
		return
	end

	if string.nilorempty(table.remove(slot0.waitTipsList, 1)) then
		return
	end

	slot0.showing = true

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onShowTip, slot2)
	TaskDispatcher.runDelay(slot0._onHideTip, slot0, RougeMapEnum.TipShowDuration)
end

function slot0._onHideTip(slot0)
	slot0.showing = false

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onHideTip)
	TaskDispatcher.runDelay(slot0.popNextTip, slot0, RougeMapEnum.TipShowInterval)
end

function slot0.clear(slot0)
	TaskDispatcher.cancelTask(slot0.onHideTip, slot0)
	TaskDispatcher.cancelTask(slot0.popNextTip, slot0)

	slot0.showing = false

	if slot0.waitTipsList then
		tabletool.clear(slot0.waitTipsList)
	end

	RougeMapController.instance:unregisterCallback(RougeMapEvent.onCreateMapDoneFlowDone, slot0.popNextTip, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0.popNextTip, slot0)

	slot0.inited = nil
end

function slot0.getTipsByEffectId(slot0)
	return lua_rouge_effect.configDict[slot0].tips
end

slot0.instance = slot0.New()

return slot0
