-- chunkname: @modules/logic/commandstation/view/CommandStationMapEventView.lua

module("modules.logic.commandstation.view.CommandStationMapEventView", package.seeall)

local CommandStationMapEventView = class("CommandStationMapEventView", BaseView)

function CommandStationMapEventView:onInitView()
	self._goevents = gohelper.findChild(self.viewGO, "#go_bg/#go_events")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationMapEventView:_editableInitView()
	self._eventList = self:getUserDataTb_()
	self._decorationList = self:getUserDataTb_()
end

function CommandStationMapEventView:onOpen()
	self:addEventCb(CommandStationController.instance, CommandStationEvent.MapLoadFinish, self._onMapLoadFinish, self)
	self:addEventCb(CommandStationController.instance, CommandStationEvent.ChangeEventCategory, self._onChangeEventCategory, self)
	self:addEventCb(CommandStationController.instance, CommandStationEvent.MoveTimeline, self._onMoveTimeline, self)
	self:addEventCb(CommandStationController.instance, CommandStationEvent.FocusEvent, self._onFocusEvent, self)
end

function CommandStationMapEventView:_onFocusEvent(eventId)
	local item = self._eventList[eventId]

	if item then
		item:FocusEvent()
	end
end

function CommandStationMapEventView:_onMapLoadFinish(sceneGo)
	self:_addDecoration(sceneGo)
	self:_updateEventItems()
end

function CommandStationMapEventView:_onChangeEventCategory()
	self:_updateEventItems()
end

function CommandStationMapEventView:_onMoveTimeline()
	self:_updateEventItems()
end

function CommandStationMapEventView.filterEventList(targetCharacterId, list)
	local result = {}

	for i, chaEventId in ipairs(list) do
		if CommandStationConfig.instance:getCharacterIdByEventId(chaEventId) == targetCharacterId then
			table.insert(result, chaEventId)
		end
	end

	return result
end

function CommandStationMapEventView:_updateEventItems()
	local timeId = CommandStationMapModel.instance:getTimeId()
	local episodeId = CommandStationConfig.instance:getTimePointEpisodeId(timeId)

	if not DungeonModel.instance:hasPassLevelAndStory(episodeId) then
		self:_addEventItems()

		return
	end

	local category = CommandStationMapModel.instance:getEventCategory()
	local eventKey = category == CommandStationEnum.EventCategory.Normal and CommandStationEnum.EventCategoryKey.Normal or CommandStationEnum.EventCategoryKey.Character
	local list = CommandStationConfig.instance:getEventList(timeId, nil, eventKey)

	if category == CommandStationEnum.EventCategory.Character and CommandStationMapModel.instance:getCharacterId() then
		local targetCharacterId = CommandStationMapModel.instance:getCharacterId()

		list = CommandStationMapEventView.filterEventList(targetCharacterId, list)
	end

	self:_addEventItems(list)
end

function CommandStationMapEventView:FocuseLeftEvent()
	local leftEvent, _ = self:checkEventsDir()

	if leftEvent then
		leftEvent:FirstFocusEvent()
	end
end

function CommandStationMapEventView:FocuseRightEvent()
	local _, rightEvent = self:checkEventsDir()

	if rightEvent then
		rightEvent:FirstFocusEvent()
	end
end

function CommandStationMapEventView:checkEventsDir()
	local screenWidth = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local offsetX = 20
	local halfScreenWidth = screenWidth / 2 + offsetX
	local minX = -halfScreenWidth - offsetX
	local maxX = halfScreenWidth
	local leftEvent, rightEvent

	for i, v in pairs(self._eventList) do
		local posX = recthelper.getAnchorX(v.viewGO.transform)

		if posX < minX then
			leftEvent = v
		elseif maxX < posX then
			rightEvent = v
		end
	end

	return leftEvent, rightEvent
end

function CommandStationMapEventView:_addEventItems(list)
	for i, v in pairs(self._eventList) do
		v:playCloseAnim()
	end

	tabletool.clear(self._eventList)
	CommandStationMapModel.instance:clearSceneNodeList()

	if not list then
		return
	end

	local path = self.viewContainer:getSetting().otherRes[1]
	local category = CommandStationMapModel.instance:getEventCategory()
	local isFocusEvent = false
	local firstItem

	for i, v in ipairs(list) do
		local go = self:getResInst(path, self._goevents)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, CommandStationMapItem)

		item:onUpdateMO(v, category)

		self._eventList[v] = item

		if i == 1 then
			firstItem = item
		end

		if category == CommandStationEnum.EventCategory.Normal then
			if not isFocusEvent and item:isMainType() then
				isFocusEvent = true

				item:FirstFocusEvent()
			end
		elseif not isFocusEvent then
			isFocusEvent = true

			item:FirstFocusEvent()
		end
	end

	if not isFocusEvent and firstItem then
		firstItem:FirstFocusEvent()
	end

	CommandStationController.instance:dispatchEvent(CommandStationEvent.EventCreateFinish)
end

function CommandStationMapEventView:_addDecoration(sceneGo)
	for k, v in pairs(self._decorationList) do
		gohelper.destroy(v)

		self._decorationList[k] = nil
	end

	local timeId = CommandStationMapModel.instance:getTimeId()
	local config = lua_copost_time_point_event.configDict[timeId]
	local coordinatesId = config and config.coordinatesId

	if not coordinatesId then
		return
	end

	for i, id in ipairs(coordinatesId) do
		local coordinateConfig = lua_copost_decoration_coordinates.configDict[id]

		if coordinateConfig then
			local decorationId = coordinateConfig.decorationId
			local decorationConfig = lua_copost_decoration.configDict[decorationId]

			if decorationConfig then
				local go = UnityEngine.GameObject.New(tostring(id))

				gohelper.addChild(sceneGo, go)
				table.insert(self._decorationList, go)

				local pos = coordinateConfig.coordinates

				transformhelper.setLocalPos(go.transform, pos[1] or 0, pos[2] or 0, pos[3] or 0)

				local loader = PrefabInstantiate.Create(go)

				loader:startLoad(decorationConfig.decoration)
			else
				logError(string.format("can not find decoration config, id = %s", decorationId))
			end
		else
			logError(string.format("can not find decoration coordinate config, id = %s", id))
		end
	end
end

function CommandStationMapEventView:onClose()
	return
end

return CommandStationMapEventView
