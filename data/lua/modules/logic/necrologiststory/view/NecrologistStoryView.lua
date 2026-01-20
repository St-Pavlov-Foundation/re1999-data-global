-- chunkname: @modules/logic/necrologiststory/view/NecrologistStoryView.lua

module("modules.logic.necrologiststory.view.NecrologistStoryView", package.seeall)

local NecrologistStoryView = class("NecrologistStoryView", BaseView)

function NecrologistStoryView:onInitView()
	self.goTitle = gohelper.findChild(self.viewGO, "Title")
	self.animTitle = self.goTitle:GetComponent(typeof(UnityEngine.Animator))
	self.txtTime = gohelper.findChildTextMesh(self.viewGO, "Title/#txt_time")
	self.txtPlace = gohelper.findChildTextMesh(self.viewGO, "Title/#txt_place")
	self.imageWeather = gohelper.findChildImage(self.viewGO, "Title/#image_weather")
	self.goWeatherRoot = gohelper.findChild(self.viewGO, "#weather")
	self.goLeft = gohelper.findChild(self.viewGO, "left")
	self.animLeft = self.goLeft:GetComponent(typeof(UnityEngine.Animator))
	self.txtTitle = gohelper.findChildTextMesh(self.viewGO, "left/#txt_title")
	self.txtTitleEn = gohelper.findChildTextMesh(self.viewGO, "left/#txt_title/#txt_sectionEn")
	self.simageSectionpic = gohelper.findChildSingleImage(self.viewGO, "left/#simage_sectionpic")
	self.goLeftArea = gohelper.findChild(self.viewGO, "left/simage_leftbg")
	self.goDragPicture = gohelper.findChild(self.viewGO, "left/#dragpicture")
	self.goEnd = gohelper.findChild(self.viewGO, "right/#go_end")
	self.goEndTxt1 = gohelper.findChild(self.viewGO, "right/#go_end/text")
	self.goEndTxt2 = gohelper.findChild(self.viewGO, "right/#go_end/text2")
	self.goArrow = gohelper.findChild(self.viewGO, "right/#go_Talk/Scroll DecView/Viewport/arrow")
	self.scrollRect = gohelper.findChildComponent(self.viewGO, "right/#go_Talk/Scroll DecView", gohelper.Type_LimitedScrollRect)
	self.goContent = gohelper.findChild(self.viewGO, "right/#go_Talk/Scroll DecView/Viewport/Content")
	self.rectContent = self.goContent.transform
	self.storyItemList = {}
	self.itemCount = 0
	self.goLine = gohelper.findChild(self.viewGO, "right/#go_Talk/Scroll DecView/Viewport/Content/#go_Line")

	gohelper.setActive(self.goLine, false)

	self.lineList = {}
	self.normalSpace = 20
	self.paragraphSpace = 40
	self.bottomSpace = 30

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NecrologistStoryView:addEvents()
	self:addEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnClickNext, self.onClickNext, self)
	self:addEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnAutoChange, self.onAutoChange, self)
	self:addEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnClickSkip, self.onClickSkip, self)
	self:addEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnSelectSection, self.onSelectSection, self)
	self:addEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnChangeWeather, self.onChangeWeather, self)
	self:addEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnChangePic, self.onChangePic, self)
end

function NecrologistStoryView:removeEvents()
	self:removeEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnClickNext, self.onClickNext, self)
	self:removeEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnAutoChange, self.onAutoChange, self)
	self:removeEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnClickSkip, self.onClickSkip, self)
	self:removeEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnSelectSection, self.onSelectSection, self)
	self:removeEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnChangeWeather, self.onChangeWeather, self)
	self:removeEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnChangePic, self.onChangePic, self)
end

function NecrologistStoryView:_editableInitView()
	return
end

function NecrologistStoryView:getScrollViewGO()
	return self.scrollRect.gameObject
end

function NecrologistStoryView:onChangePic(picName)
	self:setLeftPic(picName)
end

function NecrologistStoryView:onChangeWeather(weather)
	self:setWeather(weather)
end

function NecrologistStoryView:onSelectSection(sectionId, isSkip)
	if not self._storyGroupMo then
		return
	end

	self._storyGroupMo:setSection(sectionId)
	self:runNextStep(isSkip)
end

function NecrologistStoryView:onClickNext()
	if not self._storyGroupMo then
		return
	end

	if self:isStoryFinish() then
		return
	end

	local item = self:getLastItem()

	if item then
		item:onClickNext()

		if not item:isDone() then
			item:justDone()

			return
		end
	end

	self:runNextStep()
end

function NecrologistStoryView:onAutoChange()
	if not self._storyGroupMo then
		return
	end

	if self:isStoryFinish() then
		return
	end

	if not self._storyGroupMo:getIsAuto() then
		self:clearTweenBottom()

		return
	end

	local item = self:getLastItem()

	if item and item:isDone() then
		self:runNextStep()
	end
end

function NecrologistStoryView:onClickSkip()
	if not self._storyGroupMo then
		return
	end

	if self:isStoryFinish() then
		return
	end

	self._storyGroupMo:setIsAuto(false)

	local item = self:getLastItem()

	if item and not item:isDone() then
		item:justDone()

		if not item:isDone() then
			return
		end
	end

	self._storyGroupMo:onSkip()

	local statParam = self._storyGroupMo:getStatParam(self:isInReview())

	statParam.lastText = self:getLastText()

	NecrologistStoryStatController.instance:statStorySkip(statParam)

	while not self:isStoryFinish() do
		self:runNextStep(true)

		local item = self:getLastItem()

		if not item or not item:isDone() then
			break
		end
	end

	if self:isStoryFinish() then
		self:onFinishStory()
	end
end

function NecrologistStoryView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_activity_meeting_book_open)
	self:refreshViewParam()
end

function NecrologistStoryView:onUpdateParam()
	self:refreshViewParam()
end

function NecrologistStoryView:refreshViewParam()
	self.roleStoryId = self.viewParam and self.viewParam.roleStoryId

	local storyGroupId = self.viewParam and self.viewParam.storyGroupId

	self:startStoryGroup(storyGroupId)
end

function NecrologistStoryView:startStoryGroup(storyGroupId)
	if not storyGroupId then
		return
	end

	NecrologistStoryStatController.instance:startStoryStat()

	self._storyGroupMo = self:getStoryMo(storyGroupId)

	self._storyGroupMo:initData()

	if self.roleStoryId then
		local storyMo = NecrologistStoryModel.instance:getGameMO(self.roleStoryId)

		storyMo:setStoryState(storyGroupId, NecrologistStoryEnum.StoryState.Reading)
	end

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnStoryStart)

	self.isFinish = false

	self:setIsEnd(false)
	self:clearAll()
	self:refreshUI(storyGroupId)
	TaskDispatcher.runDelay(self.runNextStep, self, 0.1)
end

function NecrologistStoryView:refreshUI(storyGroupId)
	local plotGroupCo = NecrologistStoryConfig.instance:getPlotGroupCo(storyGroupId)

	if not plotGroupCo then
		return
	end

	self.txtTitle.text = plotGroupCo.storyName
	self.txtTitleEn.text = plotGroupCo.storyNameEn

	local displayHour, minute = NecrologistStoryHelper.getTimeFormat2(plotGroupCo.time)

	self.txtTime.text = string.format("%d:%02d", displayHour, minute)
	self.txtPlace.text = plotGroupCo.place

	self:setLeftPic(plotGroupCo.storyPic)
	self:setWeather(plotGroupCo.weather)
end

function NecrologistStoryView:setWeather(weatherType)
	TaskDispatcher.cancelTask(self._refreshWeather, self)

	self._lastWeather = self._curWeather

	if self._curWeather and self._curWeather ~= weatherType then
		self._curWeather = weatherType

		self.animTitle:Play("weather", 0, 0)
		TaskDispatcher.runDelay(self._refreshWeather, self, 0.16)
	else
		self._curWeather = weatherType

		self:_refreshWeather()
	end
end

function NecrologistStoryView:_refreshWeather()
	if self._curWeather and self._curWeather > 0 then
		gohelper.setActive(self.imageWeather, true)

		if self._curWeather < NecrologistStoryEnum.WeatherType.Flow then
			UISpriteSetMgr.instance:setRoleStorySprite(self.imageWeather, string.format("rolestory_weather%s", self._curWeather))
		end
	else
		gohelper.setActive(self.imageWeather, false)
	end

	self:playWeather()
end

function NecrologistStoryView:playWeather()
	if not self.goWeather then
		local resPath = self.viewContainer:getSetting().otherRes.weatherRes

		self.goWeather = self.viewContainer:getResInst(resPath, self.goWeatherRoot, "weather")
		self.weatherList = {}

		for type, name in pairs(NecrologistStoryEnum.WeatherType2Name) do
			local item = self:getUserDataTb_()

			item.go = gohelper.findChild(self.goWeather, name)
			item.anim = item.go:GetComponent(typeof(UnityEngine.Animator))

			gohelper.setActive(item.go, false)

			self.weatherList[type] = item
		end
	end

	if self._lastWeather == self._curWeather then
		return
	end

	if self._lastWeather then
		local item = self.weatherList[self._lastWeather]

		if item then
			if item.anim then
				gohelper.setActive(item.go, true)
				item.anim:Play("close", 0, 0)
			else
				gohelper.setActive(item.go, false)
			end
		end
	end

	if self._curWeather then
		local item = self.weatherList[self._curWeather]

		if item then
			gohelper.setActive(item.go, true)

			if item.anim then
				item.anim:Play("open", 0, 0)
			end
		end
	end
end

function NecrologistStoryView:setLeftPic(picRes)
	TaskDispatcher.cancelTask(self._refreshLeftPic, self)

	if self._curPicRes and self._curPicRes ~= picRes then
		self._curPicRes = picRes

		self.animLeft:Play("switch", 0, 0)
		TaskDispatcher.runDelay(self._refreshLeftPic, self, 0.16)
	else
		self._curPicRes = picRes

		self:_refreshLeftPic()
	end
end

function NecrologistStoryView:_refreshLeftPic()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_mln_day_night)

	if string.nilorempty(self._curPicRes) then
		self.simageSectionpic:LoadImage(ResUrl.getNecrologistStoryPicBg("rolestory_pic_01"))
	else
		self.simageSectionpic:LoadImage(ResUrl.getNecrologistStoryPicBg(self._curPicRes))
	end
end

function NecrologistStoryView:isStoryFinish()
	if not self._storyGroupMo:isStoryFinish() then
		return false
	end

	local beforeItem = self:getLastItem()

	if beforeItem and not beforeItem:isDone() then
		return false
	end

	return true
end

function NecrologistStoryView:runNextStep(isSkip)
	if self:isStoryFinish() then
		self:onFinishStory()

		return
	end

	self._isSkip = isSkip

	TaskDispatcher.cancelTask(self.realPlayNextStep, self)

	if not isSkip and self._storyGroupMo:isNextStepNeedDelay() then
		TaskDispatcher.runDelay(self.realPlayNextStep, self, 0.75)
	else
		self:realPlayNextStep()
	end
end

function NecrologistStoryView:realPlayNextStep()
	self._storyGroupMo:runNextStep()
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnStoryNextStep)

	local storyConfig = self._storyGroupMo:getCurStoryConfig()

	if not storyConfig then
		self:onFinishStory()

		return
	end

	self:playStory(storyConfig, self._isSkip)
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnPlayStory, storyConfig.id)
end

function NecrologistStoryView:playStory(storyConfig, isSkip)
	local type = storyConfig.type
	local isPause = storyConfig.pause == 1

	if isPause then
		isSkip = false
	end

	local funcName = string.format("playStory_%s", type)
	local func = self[funcName]

	if func then
		func(self, storyConfig, isSkip)
	else
		self:runNextStep()
	end
end

function NecrologistStoryView:onItemPlayFinish(isAutoNext)
	if not self._storyGroupMo:getIsAuto() and not isAutoNext then
		if self:isStoryFinish() then
			self:onFinishStory()
		end

		return
	end

	self:runNextStep()
end

function NecrologistStoryView:refreshContentSize(curItem)
	local curIndex = curItem.index
	local beforeItem = self.storyItemList[curIndex - 1]
	local posY = 0
	local endItem = self:getLastItem()
	local endIndex = endItem.index

	for i = curIndex, endIndex do
		if beforeItem then
			posY = beforeItem:getPosY() - beforeItem:getHeight()
		end

		local tempItem = self.storyItemList[i]
		local itemSpace = self:getItemSpace(tempItem, beforeItem)
		local curPosY = posY - itemSpace

		tempItem:setPosY(curPosY)
		self:tryAddLine(tempItem, beforeItem)

		beforeItem = tempItem
	end

	local endItem = self:getLastItem()
	local endPos = endItem:getPosY()
	local allHeight = math.abs(endPos) + endItem:getHeight() + self.bottomSpace
	local noMove = curIndex ~= endIndex

	self:setContentHeight(allHeight, noMove)
end

function NecrologistStoryView:setContentHeight(height, noMove)
	local oldHeight = recthelper.getHeight(self.rectContent)

	if oldHeight ~= height then
		self:clearTweenBottom()
		recthelper.setHeight(self.rectContent, height)

		if not noMove then
			self:moveToContentBottom()
		end
	end
end

function NecrologistStoryView:moveToContentBottom()
	local startValue = self.scrollRect.verticalNormalizedPosition
	local endValue = 0

	if math.abs(startValue - endValue) < 0.001 then
		return
	end

	local duration = 0.2

	self._tweenBottomId = ZProj.TweenHelper.DOTweenFloat(startValue, endValue, duration, self._onTweenBottomUpdate, self._onTweenBottomFinish, self, nil, EaseType.Linear)
end

function NecrologistStoryView:_onTweenBottomUpdate(value)
	self.scrollRect.verticalNormalizedPosition = value
end

function NecrologistStoryView:_onTweenBottomFinish()
	self.scrollRect.verticalNormalizedPosition = 0
end

function NecrologistStoryView:clearTweenBottom()
	if self._tweenBottomId then
		ZProj.TweenHelper.KillById(self._tweenBottomId)

		self._tweenBottomId = nil
	end
end

function NecrologistStoryView:getItemSpace(curItem, beforeItem)
	local space = 0

	if not beforeItem then
		return space
	end

	local isDifferentParagraphs = self:isDifferentParagraphs(curItem, beforeItem)

	if isDifferentParagraphs then
		space = self.paragraphSpace
	else
		space = self.normalSpace
	end

	return space
end

function NecrologistStoryView:isDifferentParagraphs(curItem, beforeItem)
	local curType = curItem:getItemType()
	local beforeType = beforeItem:getItemType()

	if curType == nil or beforeType == nil then
		return false
	end

	if curType == beforeType then
		return false
	end

	return true
end

function NecrologistStoryView:onFinishStory()
	if self.isFinish then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_qiutu_revelation_open)

	self.isFinish = true

	self:setIsEnd(true, self._storyGroupMo.config.isEnd == "1")
	self._storyGroupMo:saveSituation()

	if self.roleStoryId then
		local storyMo = NecrologistStoryModel.instance:getGameMO(self.roleStoryId)

		storyMo:setStoryState(self._storyGroupMo.id, NecrologistStoryEnum.StoryState.Finish)
	end

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnStoryEnd)

	local statParam = self._storyGroupMo:getStatParam(self:isInReview())

	statParam.lastText = self:getLastText()

	NecrologistStoryStatController.instance:statStoryEnd(statParam)
end

function NecrologistStoryView:setIsEnd(isEnd, allEnd)
	gohelper.setActive(self.goEnd, isEnd)
	gohelper.setActive(self.goEndTxt1, allEnd)
	gohelper.setActive(self.goEndTxt2, not allEnd)
	gohelper.setActive(self.goArrow, not isEnd)
end

function NecrologistStoryView:getStoryMo(id)
	local mo = NecrologistStoryModel.instance:getStoryMO(id)

	return mo
end

function NecrologistStoryView:getLastItem()
	return self.storyItemList[self.itemCount]
end

function NecrologistStoryView:clearStoryItem()
	for i, v in ipairs(self.storyItemList) do
		v:destory()
	end

	self.storyItemList = {}
	self.itemCount = 0
end

function NecrologistStoryView:clearAll()
	TaskDispatcher.cancelTask(self.realPlayNextStep, self)
	TaskDispatcher.cancelTask(self.runNextStep, self)
	TaskDispatcher.cancelTask(self._refreshWeather, self)
	TaskDispatcher.cancelTask(self._refreshLeftPic, self)
	self:clearTweenBottom()
	self:clearStoryItem()
end

function NecrologistStoryView:playStory_location(storyConfig, isSkip)
	self:createStoryItem(NecrologistStoryLocationItem, storyConfig, isSkip)
end

function NecrologistStoryView:playStory_dialog(storyConfig, isSkip)
	self:createStoryItem(NecrologistStoryDialogItem, storyConfig, isSkip)
end

function NecrologistStoryView:playStory_aside(storyConfig, isSkip)
	self:createStoryItem(NecrologistStoryAsideItem, storyConfig, isSkip)
end

function NecrologistStoryView:playStory_options(storyConfig, isSkip)
	self:createStoryItem(NecrologistStoryOptionsItem, storyConfig, isSkip)
end

function NecrologistStoryView:playStory_system(storyConfig, isSkip)
	self:createStoryItem(NecrologistStorySystemItem, storyConfig, isSkip)
end

function NecrologistStoryView:playStory_pause(storyConfig, isSkip)
	self:createStoryItem(NecrologistStoryPauseItem, storyConfig, isSkip)
end

function NecrologistStoryView:playStory_control(storyConfig, isSkip)
	self:addControl(storyConfig, isSkip)
end

function NecrologistStoryView:playStory_situationValue(storyConfig, isSkip)
	local arr = GameUtil.splitString2(storyConfig.param, false, "|", "#")

	if arr then
		for i, v in ipairs(arr) do
			self._storyGroupMo:addSituationValue(v[1], tonumber(v[2]))
		end
	end

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnSituationValue)
	self:runNextStep(isSkip)
end

function NecrologistStoryView:playStory_situation(storyConfig, isSkip)
	local sectionId = self._storyGroupMo:compareSituationValue(storyConfig.param)

	if sectionId then
		NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnSelectSection, sectionId, isSkip)
	end
end

function NecrologistStoryView:playStory_v3a2options(storyConfig, isSkip)
	self:createStoryItem(V3A2NecrologistStoryOptionsItem, storyConfig, isSkip)
end

function NecrologistStoryView:createStoryItem(cls, storyConfig, isSkip)
	local resPath = cls.getResPath()
	local go
	local storyId = storyConfig.id

	if string.nilorempty(resPath) then
		go = gohelper.create2d(self.goContent, tostring(storyId))
	else
		go = self:getResInst(resPath, self.goContent, tostring(storyId))
	end

	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, cls, self)

	self:addItem(item)
	item:playStory(storyConfig, isSkip, self.onItemPlayFinish, self, self.refreshContentSize, self)
	self:tryAddLine()

	return item
end

function NecrologistStoryView:addItem(item)
	self.itemCount = self.itemCount + 1
	item.index = self.itemCount
	self.storyItemList[self.itemCount] = item
end

function NecrologistStoryView:delItem(item)
	if not item then
		return
	end

	local index = item.index

	table.remove(self.storyItemList, index)

	self.itemCount = self.itemCount - 1

	for i, v in ipairs(self.storyItemList) do
		v.index = i
	end

	item:destory()
	self:runNextStep()
end

function NecrologistStoryView:addControl(storyConfig, isSkip, fromItem)
	local storyId = storyConfig.id
	local control = storyConfig.addControl
	local isEmpty = string.nilorempty(control)

	if isEmpty then
		return
	end

	if not self.controlMgr then
		self.controlMgr = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, NecrologistStoryControlMgrComp, self)
	end

	self.controlMgr:playControl(storyConfig, isSkip, fromItem)
end

function NecrologistStoryView:createControlItem(cls, storyId, controlParam, playFinishCallback, playFinishCallbackObj)
	local resPath = cls.getResPath()
	local go = self:getResInst(resPath, self.goContent, tostring(storyId))
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, cls, self)

	self:addItem(item)
	item:setStoryId(storyId)
	item:playControl(controlParam, playFinishCallback, playFinishCallbackObj, self.refreshContentSize, self)
	self:tryAddLine()

	return item
end

function NecrologistStoryView:recycelLines()
	if not self._linePool then
		self._linePool = {}
	end

	for _, v in pairs(self.lineList) do
		gohelper.setActive(v, false)
		table.insert(self._linePool, v)
	end

	self.lineList = {}
end

function NecrologistStoryView:getLine()
	local goLine

	if self._linePool and #self._linePool > 0 then
		goLine = table.remove(self._linePool)
	else
		goLine = gohelper.cloneInPlace(self.goLine, "line")
	end

	return goLine
end

function NecrologistStoryView:tryAddLine(curItem, beforeItem)
	local flag, posY, key = self:isNeedAddLine(curItem, beforeItem)

	if flag then
		local goLine = self.lineList[key]

		if not goLine then
			goLine = self:getLine()

			gohelper.setActive(goLine, true)

			self.lineList[key] = goLine
		end

		recthelper.setAnchorY(goLine.transform, posY)
	end
end

function NecrologistStoryView:isNeedAddLine(curItem, beforeItem)
	if not curItem then
		local itemCount = self.itemCount

		curItem = self.storyItemList[itemCount]
		beforeItem = self.storyItemList[itemCount - 1]
	end

	if not curItem or not beforeItem then
		return false
	end

	local posY = 0
	local flag = self:isDifferentParagraphs(curItem, beforeItem)

	if flag then
		local itemSpace = self:getItemSpace(curItem, beforeItem)
		local itemPosY = curItem:getPosY()
		local halfSpace = itemSpace * 0.5

		posY = itemPosY + halfSpace
	end

	local key = string.format("%s_%s", curItem:getStoryId(), beforeItem:getStoryId())

	return flag, posY, key
end

function NecrologistStoryView:isInLeftArea(transform)
	if not transform or not self.goLeftArea then
		return false
	end

	local uiCamera = CameraMgr.instance:getUICamera()
	local screenPosX, screenPosY = recthelper.uiPosToScreenPos2(transform)

	return recthelper.screenPosInRect(self.goLeftArea.transform, uiCamera, screenPosX, screenPosY)
end

function NecrologistStoryView:onDragPicEnable(isEnable)
	gohelper.setActive(self.goDragPicture, isEnable)
end

function NecrologistStoryView:onClose()
	if self.roleStoryId then
		local storyGameMo = NecrologistStoryModel.instance:getGameMO(self.roleStoryId)
		local storyId = self._storyGroupMo.id
		local storyCo = RoleStoryConfig.instance:getStoryById(self.roleStoryId)
		local unlock = storyCo.cgUnlockStoryId == storyId and storyGameMo:isStoryFinish(storyId)

		if unlock then
			NecrologistStoryController.instance:openCgUnlockView(self.roleStoryId)
		end
	end

	local statParam = self._storyGroupMo:getStatParam(self:isInReview())

	statParam.lastText = self:getLastText()

	NecrologistStoryStatController.instance:statStoryInterrupt(statParam)
end

function NecrologistStoryView:isInReview()
	return self.roleStoryId == nil
end

function NecrologistStoryView:getLastText()
	for i = #self.storyItemList, 1, -1 do
		local item = self.storyItemList[i]
		local lastText = item:getTextStr()

		if not string.nilorempty(lastText) then
			return lastText
		end
	end

	return ""
end

function NecrologistStoryView:onDestroyView()
	self:clearAll()
	self.simageSectionpic:UnLoadImage()
end

return NecrologistStoryView
