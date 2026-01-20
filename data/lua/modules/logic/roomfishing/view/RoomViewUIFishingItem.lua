-- chunkname: @modules/logic/roomfishing/view/RoomViewUIFishingItem.lua

module("modules.logic.roomfishing.view.RoomViewUIFishingItem", package.seeall)

local RoomViewUIFishingItem = class("RoomViewUIFishingItem", RoomViewUIBaseItem)

function RoomViewUIFishingItem:_customOnInit()
	self._simageProp = gohelper.findChildSingleImage(self._gocontainer, "#simage_Prop")
	self._goNum = gohelper.findChild(self._gocontainer, "Num")
	self._txtNum = gohelper.findChildText(self._gocontainer, "Num/#txt_Num")
	self._gounfishing = gohelper.findChild(self._gocontainer, "#go_unfishing")
	self._gofishing = gohelper.findChild(self._gocontainer, "#go_fishing")
	self._txtTime = gohelper.findChildText(self._gocontainer, "#go_fishing/#txt_RemainTime")
	self._transtipnode = gohelper.findChild(self._gocontainer, "#go_tipNode").transform

	self:refreshUI(true)
end

function RoomViewUIFishingItem:_customAddEventListeners()
	self:addEventCb(FishingController.instance, FishingEvent.OnFishingInfoUpdate, self._onFishingInfoUpdate, self)
	self:addEventCb(FishingController.instance, FishingEvent.OnFishingProgressUpdate, self._onFishingProgressUpdate, self)
end

function RoomViewUIFishingItem:_customRemoveEventListeners()
	self:removeEventCb(FishingController.instance, FishingEvent.OnFishingInfoUpdate, self._onFishingInfoUpdate, self)
	self:removeEventCb(FishingController.instance, FishingEvent.OnFishingProgressUpdate, self._onFishingProgressUpdate, self)
end

function RoomViewUIFishingItem:_onClick(go, param)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local buildingMO = self:getBuildingMO()

	if not buildingMO then
		self:_cameraTweenFinish()

		return
	end

	local camState = self._scene.camera:getCameraState()
	local cameraFocus = self._scene.camera:getCameraFocus()
	local pos = HexMath.hexToPosition(buildingMO.hexPoint, RoomBlockEnum.BlockSize)
	local targetX = pos.x
	local targetY = pos.y

	if camState == RoomEnum.CameraState.OverlookAll and math.abs(cameraFocus.x - targetX) < 0.1 and math.abs(cameraFocus.y - targetY) < 0.1 then
		self:_cameraTweenFinish()

		return
	end

	self._scene.camera:switchCameraState(RoomEnum.CameraState.OverlookAll, {
		focusX = targetX,
		focusY = targetY
	}, nil, self._cameraTweenFinish, self)
end

function RoomViewUIFishingItem:_cameraTweenFinish()
	local curPoolUserId = FishingModel.instance:getCurShowingUserId()
	local isFishing = FishingModel.instance:getIsFishingInUserPool(curPoolUserId)

	if isFishing then
		return
	end

	FishingController.instance:dispatchEvent(FishingEvent.ShowFishingTip, self._transtipnode.position)
end

function RoomViewUIFishingItem:_onFishingInfoUpdate()
	self:_onInfoUpdate()
end

function RoomViewUIFishingItem:_onFishingProgressUpdate()
	self:_onInfoUpdate()
end

function RoomViewUIFishingItem:_onInfoUpdate()
	self:_refreshItem()

	local playSwitchAnim = false
	local curPoolUserId = FishingModel.instance:getCurShowingUserId()
	local isFishing = FishingModel.instance:getIsFishingInUserPool(curPoolUserId)

	if self._isShowFishing ~= isFishing then
		playSwitchAnim = true
	end

	self:_refreshStatus(playSwitchAnim)
end

function RoomViewUIFishingItem:refreshUI(isInit)
	self:_refreshShow(isInit)
	self:_refreshItem()
	self:_refreshPosition()
	self:_refreshStatus()
end

function RoomViewUIFishingItem:_refreshItem()
	local itemData = FishingModel.instance:getCurFishingPoolItem()

	if not itemData then
		return
	end

	local _, icon = ItemModel.instance:getItemConfigAndIcon(itemData[1], itemData[2])

	self._simageProp:LoadImage(icon)
end

function RoomViewUIFishingItem:_refreshShow(isInit)
	local cameraState = self._scene.camera:getCameraState()

	if cameraState ~= RoomEnum.CameraState.Overlook and cameraState ~= RoomEnum.CameraState.OverlookAll then
		self:_setShow(false, isInit)

		return
	end

	local hasBuilding = self:getBuildingEntity() ~= nil

	self:_setShow(hasBuilding, isInit)
	self:_refreshStatus()
end

function RoomViewUIFishingItem:_refreshStatus(playAnim)
	local audioId
	local animName = "room_task_in"
	local curPoolUserId = FishingModel.instance:getCurShowingUserId()
	local isFishing = FishingModel.instance:getIsFishingInUserPool(curPoolUserId)

	if isFishing then
		self:_refreshTime()
		TaskDispatcher.cancelTask(self._refreshTime, self)
		TaskDispatcher.runRepeat(self._refreshTime, self, TimeUtil.OneSecond)

		local itemData = FishingModel.instance:getCurFishingPoolItem()

		if itemData then
			local fishingTimes = FishingModel.instance:getFishingTimes(curPoolUserId)

			self._txtNum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), itemData[3] * fishingTimes)

			gohelper.setActive(self._goNum, true)
		end

		gohelper.setActive(self._gofishing, true)
		gohelper.setActive(self._gounfishing, true)

		animName = "switch"
		audioId = AudioEnum3_1.RoomFishing.ui_home_mingdi_dalao
	else
		gohelper.setActive(self._gofishing, false)
		gohelper.setActive(self._gounfishing, true)
		gohelper.setActive(self._goNum, false)
	end

	self._isShowFishing = isFishing

	if playAnim then
		self._baseAnimator:Play(animName, 0, 0)

		if audioId then
			AudioMgr.instance:trigger(audioId)
		end
	else
		self._baseAnimator:Play(animName, 0, 1)
	end
end

function RoomViewUIFishingItem:_refreshTime()
	local curPoolUserId = FishingModel.instance:getCurShowingUserId()
	local remainSecond = FishingModel.instance:getRemainFishingTime(curPoolUserId)
	local hour, minute, second = TimeUtil.secondToHMS(remainSecond)

	hour = string.format("%02d", hour)
	minute = string.format("%02d", minute)
	second = string.format("%02d", second)
	self._txtTime.text = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("RoomFishing_fishing_time"), hour, minute, second)

	if remainSecond <= 0 then
		TaskDispatcher.cancelTask(self._refreshTime, self)
	end
end

function RoomViewUIFishingItem:getUI3DPos()
	local buildingEntity = self:getBuildingEntity()

	if not buildingEntity then
		self:_setShow(false, true)

		return Vector3.zero
	end

	local containerGo = buildingEntity.containerGO
	local headGO = buildingEntity:getHeadGO()
	local position = headGO and headGO.transform.position or containerGo.transform.position
	local worldPos = Vector3(position.x, position.y, position.z)
	local bendingPos = RoomBendingHelper.worldToBendingSimple(worldPos)

	return bendingPos
end

function RoomViewUIFishingItem:getBuildingMO()
	local buildingList = RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Fishing)

	if buildingList then
		for _, buildingMO in ipairs(buildingList) do
			local belongUserId = buildingMO:getBelongUserId()
			local myUserId = PlayerModel.instance:getMyUserId()

			if belongUserId and belongUserId == myUserId then
				return buildingMO
			end
		end
	end
end

function RoomViewUIFishingItem:getBuildingEntity()
	local buildingMO = self:getBuildingMO()

	if buildingMO then
		local buildingEntity = self._scene.buildingmgr:getBuildingEntity(buildingMO.buildingUid, SceneTag.RoomBuilding)

		return buildingEntity
	end
end

function RoomViewUIFishingItem:_customOnDestory()
	self._simageProp:UnLoadImage()
	TaskDispatcher.cancelTask(self._refreshTime, self)
end

RoomViewUIFishingItem.prefabPath = "ui/viewres/room/fish/roomfishbubbleui.prefab"

return RoomViewUIFishingItem
