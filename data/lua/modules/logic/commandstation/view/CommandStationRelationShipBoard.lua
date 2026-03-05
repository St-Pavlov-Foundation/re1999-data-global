-- chunkname: @modules/logic/commandstation/view/CommandStationRelationShipBoard.lua

module("modules.logic.commandstation.view.CommandStationRelationShipBoard", package.seeall)

local CommandStationRelationShipBoard = class("CommandStationRelationShipBoard", BaseView)

function CommandStationRelationShipBoard:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationRelationShipBoard:addEvents()
	return
end

function CommandStationRelationShipBoard:removeEvents()
	return
end

function CommandStationRelationShipBoard:_editableInitView()
	self._gridlayout = gohelper.findChild(self.viewGO, "gridlayout")
	self._animator = self.viewGO:GetComponent("Animator")
end

function CommandStationRelationShipBoard:_initCamera()
	local animator = CameraMgr.instance:getCameraRootAnimator()
	local path = self.viewContainer:getSetting().otherRes[1]
	local animatorInst = self.viewContainer._abLoader:getAssetItem(path):GetResource()

	animator.runtimeAnimatorController = animatorInst
	animator.enabled = true

	animator:Play("in", 0, 0)
end

function CommandStationRelationShipBoard:onUpdateParam()
	return
end

function CommandStationRelationShipBoard:_OnOpenView(viewName)
	if viewName == ViewName.CommandStationRelationShipDetail then
		self._animator.enabled = true

		self._animator:Play("to_detail", 0, 0)
	end
end

function CommandStationRelationShipBoard:_OnCloseView(viewName)
	if viewName == ViewName.CommandStationRelationShipDetail then
		self._animator.enabled = true

		self._animator:Play("back_detail", 0, 0)
	end
end

function CommandStationRelationShipBoard:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_3.CommandStationMap.play_ui_yuanzheng_zhb_open)
	self:addEventCb(CommandStationController.instance, CommandStationEvent.ClickRelationShipBoardCharacter, self._onClickRelationShipBoardCharacter, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self._OnOpenView, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._OnCloseView, self)

	self._firstOpenCharacter = self:getUserDataTb_()
	self._firstOpenLine = self:getUserDataTb_()

	self:_initFirstOpenTeam()

	self._characterGoMap = self:getUserDataTb_()
	self._lineGoMap = self:getUserDataTb_()

	self:_initGos()

	self._stateList = nil
	self._stateConnectMap = {}

	self:_initCharacterChain()
	self:_initStates(self._stateList)

	if self.viewParam and self.viewParam.fromMapView then
		return
	end

	self:_initCamera()
	TaskDispatcher.cancelTask(self._openPostProcess, self)
	TaskDispatcher.runRepeat(self._openPostProcess, self, 0)

	local go = ViewMgr.instance:getUILayer("POPUP_SECOND")

	gohelper.addChild(go, self.viewGO)

	local container = ViewMgr.instance:getContainer(ViewName.CommandStationEnterView)

	if container and not gohelper.isNil(container.viewGO) then
		container:setVisibleInternal(false)
	end
end

function CommandStationRelationShipBoard:_openPostProcess()
	PostProcessingMgr.instance:setUIActive(true)
end

function CommandStationRelationShipBoard:_clearCameraAnim()
	local animator = CameraMgr.instance:getCameraRootAnimator()

	animator.runtimeAnimatorController = nil

	TaskDispatcher.cancelTask(self._openPostProcess, self)
	PostProcessingMgr.instance:setUnitPPValue("radialBlurLevel", 1)
	PostProcessingMgr.instance:setUnitPPValue("RadialBlurLevel", 1)
	PostProcessingMgr.instance:setUnitPPValue("rgbSplitStrength", 0)
	PostProcessingMgr.instance:setUnitPPValue("RgbSplitStrength", 0)
	PostProcessingMgr.instance:setUnitPPValue("splitPercent", 0)
	PostProcessingMgr.instance:setUnitPPValue("SplitPercent", 0)

	local vec = Vector2(0.5, 0.5)

	PostProcessingMgr.instance:setUnitPPValue("rgbSplitCenter", vec)
	PostProcessingMgr.instance:setUnitPPValue("RgbSplitCenter", vec)
end

function CommandStationRelationShipBoard:onOpenFinish()
	local go = ViewMgr.instance:getUILayer(UILayerName.PopUpTop)

	gohelper.addChild(go, self.viewGO)
	self:_clearCameraAnim()
	self:_playFirstOpenAnim()
end

function CommandStationRelationShipBoard:_playFirstOpenAnim()
	self:_playFirstOpenTeamAnim()
	self:_playFirstOpenChaAnim()
	self:_playFirstOpenLineAnim()
end

function CommandStationRelationShipBoard:_initFirstOpenTeam()
	if not CommandStationController.hasOnceActionKey(CommandStationEnum.PrefsKey.RelationShipBoardFirstOpenTeam) or self._showAllFirstOpenAnim then
		for i = 1, 5 do
			local go = gohelper.findChild(self.viewGO, "Team" .. i)

			gohelper.setActive(go, false)
		end
	end
end

function CommandStationRelationShipBoard:_playFirstOpenTeamAnim()
	if not CommandStationController.hasOnceActionKey(CommandStationEnum.PrefsKey.RelationShipBoardFirstOpenTeam) or self._showAllFirstOpenAnim then
		CommandStationController.setOnceActionKey(CommandStationEnum.PrefsKey.RelationShipBoardFirstOpenTeam)

		for i = 1, 5 do
			local go = gohelper.findChild(self.viewGO, "Team" .. i)

			gohelper.setActive(go, true)

			local animator = go:GetComponent("Animator")

			if animator then
				animator:Play("firstopen", 0, 0)
			end
		end
	end
end

function CommandStationRelationShipBoard:_playFirstOpenChaAnim()
	for posId, animator in pairs(self._firstOpenCharacter) do
		gohelper.setActive(animator, true)
		animator:Play("firstopen", 0, 0)
		CommandStationController.setOnceActionKey(CommandStationEnum.PrefsKey.RelationShipBoardFirstOpenCha, posId)
	end
end

function CommandStationRelationShipBoard:_playFirstOpenLineAnim()
	for line, animatorList in pairs(self._firstOpenLine) do
		CommandStationController.setOnceActionKey(CommandStationEnum.PrefsKey.RelationShipBoardFirstOpenLine, line)

		for _, animator in pairs(animatorList) do
			gohelper.setActive(animator, true)
			animator:Play("firstopen", 0, 0)
		end
	end
end

function CommandStationRelationShipBoard:_initGos()
	local transform = self._gridlayout.transform
	local itemCount = transform.childCount
	local linePattern = "^line_(%d+)_(%d+)$"

	for i = 1, itemCount do
		local child = transform:GetChild(i - 1)
		local name = child.name

		if string.find(name, "character_") ~= nil then
			self:_initCharacterGo(child, name)
		elseif string.find(name, "point_") ~= nil then
			local match = child.name:gmatch("%d+")
			local id1, id2 = match(), match()

			id1 = tonumber(id1)
			id2 = tonumber(id2)

			if id1 then
				if id2 then
					self:_addLineGo(child, id1, id2)
				else
					self:_addCharacterGo(child, id1)
				end
			else
				logError("point is not match pattern:", name)
			end
		elseif string.find(name, "line_") ~= nil then
			local id1, id2 = string.match(child.name, linePattern)

			id1 = tonumber(id1)
			id2 = tonumber(id2)

			if id1 and id2 then
				self:_addLineGo(child, id1, id2)
			else
				logError("line is not match pattern:", name)
			end
		else
			logError("child name is not match pattern:", name)
		end
	end
end

function CommandStationRelationShipBoard:_getLineKey(id1, id2)
	local minId = math.min(id1, id2)
	local maxId = math.max(id1, id2)

	return string.format("%d_%d", minId, maxId)
end

function CommandStationRelationShipBoard:_addLineGo(child, id1, id2)
	local key = self:_getLineKey(id1, id2)
	local list = self._lineGoMap[key] or {}

	table.insert(list, child)

	self._lineGoMap[key] = list

	gohelper.setActive(child, false)
end

function CommandStationRelationShipBoard:_initCharacterGo(child, name)
	local characterId = tonumber(string.sub(name, 11))

	if not characterId then
		logError("characterId is nil name:", name)
	else
		self:_addCharacterGo(child, characterId, true)
	end
end

function CommandStationRelationShipBoard:_addCharacterGo(child, characterId, mainCharacter)
	local list = self._characterGoMap[characterId] or {}

	table.insert(list, child)

	self._characterGoMap[characterId] = list

	if mainCharacter then
		list.mainCharacter = child
	end

	gohelper.setActive(child, false)
end

function CommandStationRelationShipBoard:_initCharacterChain()
	local config = CommandStationController.getCommandStationRelationChain()

	self._stateList = config.stateId
end

function CommandStationRelationShipBoard:_initStates(stateId)
	if not stateId then
		logError("CommandStationRelationShipBoard stateId is nil")

		return
	end

	for i, id in ipairs(stateId) do
		local config = lua_copost_character_state.configDict[id]

		if not config then
			logError(string.format("copost_character_state stateId:%d not find config", id))
		else
			self:_initState(config)
		end
	end
end

function CommandStationRelationShipBoard:_initState(config)
	self:_initCharacterState(config.stateId, tonumber(config.chaId), config.positionId, config.state, config.chaTxt)

	for i, characterId in ipairs(config.relationshipCha) do
		self:_initChaConnect(config.chaId, characterId, config.relationshipTxt[i], config)
	end
end

function CommandStationRelationShipBoard:_initCharacterState(stateId, characterId, posId, state, chaTxt)
	local characterGos = self._characterGoMap[posId]

	if not characterGos then
		logError(string.format("CommandStationRelationShipBoard itemGo is nil characterId:%s,posId:%s", tostring(characterId), tostring(posId)))

		return
	end

	for i, itemGo in ipairs(characterGos) do
		gohelper.setActive(itemGo, true)
	end

	local mainCharacter = characterGos.mainCharacter

	if not mainCharacter then
		logError(string.format("CommandStationRelationShipBoard mainCharacter is nil characterId:%s,posId:%s", tostring(characterId), tostring(posId)))

		return
	end

	local item = MonoHelper.addNoUpdateLuaComOnceToGo(mainCharacter.gameObject, CommandStationRelationShipItem)

	item:onUpdateMO(stateId, characterId, state, chaTxt, true)

	local animator = item:getAnimator()

	if animator and not CommandStationController.hasOnceActionKey(CommandStationEnum.PrefsKey.RelationShipBoardFirstOpenCha, posId) or self._showAllFirstOpenAnim then
		gohelper.setActive(animator, false)

		self._firstOpenCharacter[posId] = animator
	end
end

function CommandStationRelationShipBoard:_initChaConnect(characterId1, characterId2, relationshipId, configState)
	characterId1 = tonumber(characterId1)
	characterId2 = tonumber(characterId2)

	local pos1 = CommandStationConfig.instance:getCharacterPos(characterId1)
	local pos2 = CommandStationConfig.instance:getCharacterPos(characterId2)
	local key = self:_getLineKey(pos1, pos2)

	if self._stateConnectMap[key] then
		return
	end

	self._stateConnectMap[key] = true

	local lineGos = self._lineGoMap[key]

	if not lineGos then
		logError(string.format("CommandStationRelationShipBoard lineGo is nil stateId:%s,characterId1:%s,characterId2:%s, pos1:%s,pos2:%s", configState.stateId, characterId1, characterId2, tostring(pos1), tostring(pos2)))

		return
	end

	local animatorList = {}

	for _, lineGo in ipairs(lineGos) do
		gohelper.setActive(lineGo, true)

		local animator = lineGo:GetComponent("Animator")

		if animator and not CommandStationController.hasOnceActionKey(CommandStationEnum.PrefsKey.RelationShipBoardFirstOpenLine, key) or self._showAllFirstOpenAnim then
			gohelper.setActive(animator, false)
			table.insert(animatorList, animator)
		end
	end

	self._firstOpenLine[key] = animatorList

	local config = lua_copost_event_text.configDict[relationshipId]

	if not config then
		logError(string.format("CommandStationRelationShipBoard stateId:%s, characterId1:%s,characterId2:%s, config is nil relationshipId:%s", configState.stateId, characterId1, characterId2, tostring(relationshipId)))

		return
	end
end

function CommandStationRelationShipBoard:_onClickRelationShipBoardCharacter(params)
	CommandStationController.instance:openCommandStationRelationShipDetail(params)
end

function CommandStationRelationShipBoard:onClose()
	self:_clearCameraAnim()
end

function CommandStationRelationShipBoard:onDestroyView()
	return
end

return CommandStationRelationShipBoard
