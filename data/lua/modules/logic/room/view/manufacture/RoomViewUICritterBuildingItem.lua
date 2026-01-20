-- chunkname: @modules/logic/room/view/manufacture/RoomViewUICritterBuildingItem.lua

module("modules.logic.room.view.manufacture.RoomViewUICritterBuildingItem", package.seeall)

local RoomViewUICritterBuildingItem = class("RoomViewUICritterBuildingItem", RoomViewUIBaseItem)

function RoomViewUICritterBuildingItem:_customOnInit()
	self._gomain = gohelper.findChild(self._gocontainer, "bubblebg/#go_main")
	self._imagebuildingicon = gohelper.findChildImage(self._gocontainer, "#image_buildingicon")
	self._txtnamecn = gohelper.findChildText(self._gocontainer, "bottom/txt_buildingName")
	self._goreddot = gohelper.findChild(self._gocontainer, "bottom/#go_reddot")
	self._txtnamecn.text = luaLang("critter_restroom_name")

	UISpriteSetMgr.instance:setCritterSprite(self._imagebuildingicon, "critter_buildingicon_1")
	gohelper.setActive(self._gomain, true)
end

function RoomViewUICritterBuildingItem:_customAddEventListeners()
	self:refreshUI(true)
end

function RoomViewUICritterBuildingItem:_customRemoveEventListeners()
	return
end

function RoomViewUICritterBuildingItem:_onClick(go, param)
	ManufactureController.instance:openCritterBuildingView()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function RoomViewUICritterBuildingItem:refreshUI(isInit)
	self:_refreshShow(isInit)
	self:_refreshPosition()
end

function RoomViewUICritterBuildingItem:_refreshShow(isInit)
	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		self:_setShow(false, isInit)

		return
	end

	local cameraState = self._scene.camera:getCameraState()

	if cameraState ~= RoomEnum.CameraState.Overlook and cameraState ~= RoomEnum.CameraState.OverlookAll then
		self:_setShow(false, isInit)

		return
	end

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		self:_setShow(false, isInit)

		return
	end

	self:_setShow(true, isInit)
end

function RoomViewUICritterBuildingItem:getUI3DPos()
	local buildingUid
	local buildingList = ManufactureModel.instance:getCritterBuildingListInOrder()

	if buildingList then
		buildingUid = buildingList[1].buildingUid
	end

	local buildingEntity = self._scene.buildingmgr:getBuildingEntity(buildingUid, SceneTag.RoomBuilding)

	if not buildingEntity then
		self:_setShow(false, true)

		return Vector3.zero
	end

	local headGO = buildingEntity:getHeadGO()
	local containerGo = buildingEntity.containerGO
	local position = headGO and headGO.transform.position or containerGo.transform.position
	local worldPos = Vector3(position.x, position.y, position.z)
	local bendingPos = RoomBendingHelper.worldToBendingSimple(worldPos)

	return bendingPos
end

function RoomViewUICritterBuildingItem:_customOnDestory()
	return
end

return RoomViewUICritterBuildingItem
