module("modules.logic.weather.controller.WeatherEggContainerComp", package.seeall)

slot0 = class("WeatherEggContainerComp")

function slot0.ctor(slot0)
end

function slot0.onSceneHide(slot0)
	TaskDispatcher.cancelTask(slot0._switchEgg, slot0)

	for slot4, slot5 in ipairs(slot0._serialEggList) do
		slot5:onDisable()
	end

	for slot4, slot5 in ipairs(slot0._parallelEggList) do
		slot5:onDisable()
	end
end

function slot0.onSceneShow(slot0)
	for slot4, slot5 in ipairs(slot0._parallelEggList) do
		slot5:onEnable()
	end

	slot0:_startTimer()
end

function slot0.onReportChange(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._serialEggList) do
		slot6:onReportChange(slot1)
	end

	for slot5, slot6 in ipairs(slot0._parallelEggList) do
		slot6:onReportChange(slot1)
	end
end

function slot0.onInit(slot0, slot1, slot2)
	slot0._context = {
		isMainScene = slot2
	}
	slot0._sceneId = slot1
	slot3 = lua_scene_switch.configDict[slot1]
	slot0._eggList = slot3.eggList
	slot0._eggSwitchTime = slot3.eggSwitchTime
	slot0._serialEggList = {}
	slot0._parallelEggList = {}
	slot0._index = 0
end

function slot0._startTimer(slot0)
	TaskDispatcher.cancelTask(slot0._switchEgg, slot0)

	if #slot0._serialEggList > 0 then
		slot0._time = slot0._time or Time.time

		TaskDispatcher.runRepeat(slot0._switchEgg, slot0, 0)
	end
end

function slot0._switchEgg(slot0)
	if not slot0._time or Time.time - slot0._time <= slot0._eggSwitchTime then
		return
	end

	slot0._time = Time.time

	if slot0._serialEggList[slot0._index] then
		slot1:onDisable()
	end

	if slot0._serialEggList[slot0:getNextIndex()] then
		slot3:onEnable()
	end
end

function slot0.getNextIndex(slot0)
	slot0._index = slot0._index + 1

	if slot0._index > #slot0._serialEggList then
		slot0._index = 1
	end

	return slot0._index
end

function slot0.getSceneNode(slot0, slot1)
	return gohelper.findChild(slot0._sceneGo, slot1)
end

function slot0.getGoList(slot0, slot1)
	for slot6, slot7 in ipairs(string.split(slot1, "|")) do
		slot8 = slot0:getSceneNode(slot7)
		slot2[slot6] = slot8

		if not slot8 then
			logError(string.format("WeatherEggContainerComp can not find go by path:%s", slot7))
		end
	end

	return slot2
end

function slot0.initSceneGo(slot0, slot1)
	slot0._sceneGo = slot1

	for slot5, slot6 in ipairs(slot0._eggList) do
		slot7 = lua_scene_eggs.configDict[slot6]

		_G[slot7.actionClass].New():init(slot0._sceneGo, slot0:getGoList(slot7.path), slot7, slot0._context)

		if slot7.parallel == 1 then
			table.insert(slot0._parallelEggList, slot9)
		else
			table.insert(slot0._serialEggList, slot9)
		end
	end

	slot0:_startTimer()
end

function slot0.onSceneClose(slot0)
	TaskDispatcher.cancelTask(slot0._switchEgg, slot0)

	for slot4, slot5 in ipairs(slot0._serialEggList) do
		slot5:onSceneClose()
	end

	for slot4, slot5 in ipairs(slot0._parallelEggList) do
		slot5:onSceneClose()
	end
end

return slot0
