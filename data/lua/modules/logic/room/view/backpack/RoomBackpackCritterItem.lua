-- chunkname: @modules/logic/room/view/backpack/RoomBackpackCritterItem.lua

module("modules.logic.room.view.backpack.RoomBackpackCritterItem", package.seeall)

local RoomBackpackCritterItem = class("RoomBackpackCritterItem", ListScrollCellExtend)

function RoomBackpackCritterItem:onInitView()
	self._goCritterIcon = gohelper.findChild(self.viewGO, "#go_critterIcon")
end

function RoomBackpackCritterItem:addEvents()
	self:addEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, self._onCritterInfoUpdate, self)
	self:addEventCb(CritterController.instance, CritterEvent.CritterChangeLockStatus, self._onCritterLockStatusChange, self)
end

function RoomBackpackCritterItem:removeEvents()
	self:removeEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, self._onCritterInfoUpdate, self)
	self:removeEventCb(CritterController.instance, CritterEvent.CritterChangeLockStatus, self._onCritterLockStatusChange, self)
end

function RoomBackpackCritterItem:_onCritterInfoUpdate(critterUidDict)
	local critterUid = self._mo and self._mo:getId()

	if not self._critterIcon or not critterUid or critterUidDict and not critterUidDict[critterUid] then
		return
	end

	self._critterIcon:refreshLockIcon()
	self._critterIcon:refreshMaturityIcon()
end

function RoomBackpackCritterItem:_onCritterLockStatusChange(changeCritterUid)
	local critterUid = self._mo and self._mo:getId()

	if not self._critterIcon or not critterUid or critterUid ~= changeCritterUid then
		return
	end

	self._critterIcon:refreshLockIcon()
end

function RoomBackpackCritterItem:onUpdateMO(mo)
	self._mo = mo

	if not self._critterIcon then
		self._critterIcon = IconMgr.instance:getCommonCritterIcon(self._goCritterIcon)

		self._critterIcon:setLockIconShow(true)
		self._critterIcon:setMaturityIconShow(true)
	end

	self._critterIcon:onUpdateMO(self._mo)
	self._critterIcon:setCustomClick(self.onClickCB, self)
	self._critterIcon:setIsShowBuildingIcon(true)
end

function RoomBackpackCritterItem:onClickCB()
	local isMaturity = self._mo:isMaturity()

	CritterController.instance:openRoomCritterDetailView(not isMaturity, self._mo)
end

function RoomBackpackCritterItem:onDestroyView()
	return
end

return RoomBackpackCritterItem
