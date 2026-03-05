-- chunkname: @modules/logic/commandstation/controller/CommandStationController.lua

module("modules.logic.commandstation.controller.CommandStationController", package.seeall)

local CommandStationController = class("CommandStationController", BaseController)

function CommandStationController:onInit()
	return
end

function CommandStationController:onInitFinish()
	return
end

function CommandStationController:addConstEvents()
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, self._newFuncUnlock, self)
	RedDotController.instance:registerCallback(RedDotEvent.PreSetRedDot, self._onInsertRed, self)
	ViewMgr.instance:registerCallback(ViewEvent.BeforeOpenView, self._onBeforeOpenView, self)
end

function CommandStationController:reInit()
	self._chapterList = nil
	self._episodeId = nil
end

function CommandStationController:setRecordEpisodeId(episodeId)
	self._episodeId = episodeId
end

function CommandStationController:getRecordEpisodeId()
	return self._episodeId
end

function CommandStationController:chapterInCommandStation(chapterId)
	if not self._chapterList then
		local chapterListConfig = CommandStationConfig.instance:getConstConfig(CommandStationEnum.ConstId.ChapterList)

		if chapterListConfig then
			self._chapterList = string.splitToNumber(chapterListConfig.value2, "#")
		end
	end

	if not self._chapterList or not chapterId or not tabletool.indexOf(self._chapterList, chapterId) then
		return false
	end

	return OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CommandStation)
end

function CommandStationController:_onBeforeOpenView(viewName)
	if viewName == ViewName.CommandStationMapView then
		CommandStationMapModel.instance:initTimeId()
	end
end

function CommandStationController:_newFuncUnlock(newIds)
	for i, id in ipairs(newIds) do
		if id == OpenEnum.UnlockFunc.CommandStation then
			CommandStationRpc.instance:sendGetCommandPostInfoRequest()

			break
		end
	end
end

function CommandStationController:_onInsertRed(dotInfos)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CommandStation) then
		return
	end

	local curVersion = CommandStationConfig.instance:getCurVersionId()

	self:_initializeRedDotInfo(dotInfos, RedDotEnum.DotNode.CommandStationTaskNormal, PlayerPrefsKey.CommandStationTaskNormalOnce .. curVersion)

	if #CommandStationTaskListModel.instance.allCatchTaskMos > 0 then
		self:_initializeRedDotInfo(dotInfos, RedDotEnum.DotNode.CommandStationTaskCatch, PlayerPrefsKey.CommandStationTaskCatchOnce .. curVersion)
	end
end

function CommandStationController:_initializeRedDotInfo(dotInfos, dotNode, prefsKey)
	local redValue = GameUtil.playerPrefsGetNumberByUserId(prefsKey, 1)
	local redDotGroup = dotInfos[dotNode]
	local redDotItem = RedDotRpc.instance:clientMakeRedDotGroupItem(-1, redValue)
	local redDotInfo = RedDotRpc.instance:clientMakeRedDotGroup(dotNode, {
		redDotItem
	}, false)

	if not redDotGroup then
		redDotGroup = RedDotGroupMo.New()
		dotInfos[dotNode] = redDotGroup

		redDotGroup:init(redDotInfo)
	else
		redDotGroup:_resetDotInfo(redDotInfo)
	end
end

function CommandStationController.getCommandStationRelationChain()
	if CommandStationEnum.TestCharacterChainId then
		return lua_copost_character_chain.configDict[CommandStationEnum.TestCharacterChainId]
	end

	local num = #lua_copost_character_chain.configList

	for i = num, 1, -1 do
		local config = lua_copost_character_chain.configList[i]

		if config.fightId == 0 or DungeonModel.instance:hasPassLevelAndStory(config.fightId) then
			return config
		end
	end
end

function CommandStationController.getCommandStationRelationShipBoardReddot()
	local config = CommandStationController.getCommandStationRelationChain()
	local stateList = config and config.stateId

	if stateList then
		for i, v in ipairs(stateList) do
			if not CommandStationModel.instance:getCharacterState(v) then
				local config = lua_copost_character_state.configDict[v]

				if config and config.isClick ~= CommandStationEnum.CharacterClickState.NoClick then
					return true
				end
			end
		end
	end

	return false
end

function CommandStationController:openCommandStationTimelineEventView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.CommandStationTimelineEventView, param, isImmediate)
end

function CommandStationController:openCommandStationDispatchEventMainView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.CommandStationDispatchEventMainView, param, isImmediate)
end

function CommandStationController:openCommandStationCharacterEventView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.CommandStationCharacterEventView, param, isImmediate)
end

function CommandStationController:openCommandStationDialogueEventView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.CommandStationDialogueEventView, param, isImmediate)
end

function CommandStationController:openCommandStationMapView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.CommandStationMapView, param, isImmediate)
end

function CommandStationController:openCommandStationDetailView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.CommandStationDetailView, param, isImmediate)
end

function CommandStationController:openCommandStationRelationShipBoard(param, isImmediate)
	ViewMgr.instance:openView(ViewName.CommandStationRelationShipBoard, param, isImmediate)
end

function CommandStationController:openCommandStationRelationShipDetail(param, isImmediate)
	ViewMgr.instance:openView(ViewName.CommandStationRelationShipDetail, param, isImmediate)
end

function CommandStationController:getMapDisplayViewParam()
	return self._mapDisplayViewParam
end

function CommandStationController:openCommandStationMapDisplayView(param, isImmediate)
	self._mapDisplayViewParam = param

	ViewMgr.instance:openView(ViewName.CommandStationMapDisplayView, param, isImmediate)
end

function CommandStationController:openCommandStationEnterView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.CommandStationEnterView, param, isImmediate)
end

function CommandStationController:openCommandStationEnterAnimView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.CommandStationEnterAnimView, param, isImmediate)
end

function CommandStationController:openCommandStationPaperView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.CommandStationPaperView, param, isImmediate)
end

function CommandStationController:openCommandStationPaperGetView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.CommandStationPaperGetView, param, isImmediate)
end

function CommandStationController:openCommandStationTaskView(param, isImmediate)
	CommandStationRpc.instance:sendGetCommandPostInfoRequest(self._onGetPostInfo, self)
end

function CommandStationController:_onGetPostInfo(cmd, resultCode, msg)
	if resultCode == 0 then
		ViewMgr.instance:openView(ViewName.CommandStationTaskView)
	end
end

function CommandStationController.hasOnceActionKey(type, id)
	local key = CommandStationController._getKey(type, id)

	return PlayerPrefsHelper.hasKey(key)
end

function CommandStationController.setOnceActionKey(type, id)
	local key = CommandStationController._getKey(type, id)

	PlayerPrefsHelper.setNumber(key, 1)
end

function CommandStationController.setSaveNumber(type, value)
	local key = CommandStationController._getKey(type)

	PlayerPrefsHelper.setNumber(key, value)
end

function CommandStationController.getSaveNumber(type)
	local key = CommandStationController._getKey(type)
	local value = PlayerPrefsHelper.getNumber(key, 0)

	return value
end

function CommandStationController._getKey(type, id)
	local key = string.format("%s%s_%s_%s", PlayerPrefsKey.CommandStationOnceAnim, PlayerModel.instance:getPlayinfo().userId, type, id)

	return key
end

function CommandStationController.CustomOutBack(transform, time, posX, maxEaseOffsetX, callback, callbackObj, param, easyType)
	local startPosX = recthelper.getAnchorX(transform)
	local deltaX = math.abs(posX - startPosX)
	local ratio = maxEaseOffsetX >= deltaX * 0.1 and 1 or maxEaseOffsetX / (deltaX * 0.1)

	return ZProj.TweenHelper.DOTweenFloat(startPosX, posX, time, function(self, value)
		if startPosX < posX then
			if value >= posX then
				local deltaX = value - posX

				value = posX + deltaX * ratio
			end
		elseif value <= posX then
			local deltaX = posX - value

			value = posX - deltaX * ratio
		end

		recthelper.setAnchorX(transform, value)
	end, callback, callbackObj, param, easyType or EaseType.OutBack)
end

function CommandStationController.StatCommandStationViewClose(viewName, time)
	StatController.instance:track(StatEnum.EventName.CommandStationViewClose, {
		[StatEnum.EventProperties.ViewName] = viewName,
		[StatEnum.EventProperties.UseTime] = time
	})
end

function CommandStationController.StatCommandStationButtonClick(viewName, buttonName, timeline_mode)
	local timelineModeName
	local category = timeline_mode or CommandStationMapModel.instance:getEventCategory()

	if category == CommandStationEnum.EventCategory.Normal then
		timelineModeName = luaLang("commandstation_map_event")
	else
		timelineModeName = luaLang("commandstation_map_character")
	end

	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.ViewName] = viewName,
		[StatEnum.EventProperties.CommandStationTimelineMode] = timelineModeName,
		[StatEnum.EventProperties.ButtonName] = buttonName
	})
end

CommandStationController.instance = CommandStationController.New()

return CommandStationController
