-- chunkname: @modules/logic/room/view/RoomBlockPackageDetailedItem.lua

module("modules.logic.room.view.RoomBlockPackageDetailedItem", package.seeall)

local RoomBlockPackageDetailedItem = class("RoomBlockPackageDetailedItem", RoomBlockPackageItem)

function RoomBlockPackageDetailedItem:_editableInitView()
	self._go = self.viewGO
	self._goitem = gohelper.findChild(self.viewGO, "item")
	self._txtnum = gohelper.findChildText(self.viewGO, "item/bottom/degree/txt_num")
	self._txtdegree = gohelper.findChildText(self.viewGO, "item/bottom/degree/txt_degree")
	self._imagerare = gohelper.findChildImage(self.viewGO, "item/image_rare")
	self._txtname = gohelper.findChildText(self.viewGO, "item/bottom/txt_name")
	self._goreddot = gohelper.findChild(self.viewGO, "item/image_icon/go_reddot")
	self._goselect = gohelper.findChild(self.viewGO, "go_select")
	self._btnItem = gohelper.findChildButtonWithAudio(self.viewGO, "item")
	self._goempty = gohelper.findChild(self.viewGO, "item/bottom/go_empty")
	self._simagedegree = gohelper.findChildImage(self.viewGO, "item/bottom/degree/txt_degree/icon")

	self._btnItem:AddClickListener(self._btnitemOnClick, self)
	UISpriteSetMgr.instance:setRoomSprite(self._simagedegree, "jianshezhi")
	self:_onInit(self.viewGO)
end

function RoomBlockPackageDetailedItem:_onInit(go)
	local itemgo = gohelper.findChild(go, "item")

	self._itemCanvasGroup = itemgo:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._imageIcon = gohelper.findChildSingleImage(go, "item/image_icon")
	self._gobirthday = gohelper.findChild(go, "item/go_birthday")
	self._txtbirthName = gohelper.findChildText(go, "item/go_birthday/txt_birthName")
end

function RoomBlockPackageDetailedItem:_onRefreshUI()
	self._imageIcon:LoadImage(ResUrl.getRoomImage("blockpackage/" .. self._packageCfg.icon))

	if self._packageCfg.id == RoomBlockPackageEnum.ID.RoleBirthday then
		local nameStr = self:_getNearBlockName()

		gohelper.setActive(self._gobirthday, nameStr ~= nil)

		if nameStr then
			self._txtbirthName.text = nameStr
		end
	else
		gohelper.setActive(self._gobirthday, false)
	end

	local splitName = RoomBlockPackageEnum.RareBigIcon[self._packageCfg.rare] or RoomBlockPackageEnum.RareBigIcon[1]

	UISpriteSetMgr.instance:setRoomSprite(self._imagerare, splitName)
end

function RoomBlockPackageDetailedItem:_getNearBlockName()
	local infoList = RoomModel.instance:getSpecialBlockInfoList()
	local nearInfo

	for _, tInfo in ipairs(infoList) do
		local cfg = RoomConfig.instance:getBlock(tInfo.blockId)

		if cfg and cfg.packageId == RoomBlockPackageEnum.ID.RoleBirthday and (nearInfo == nil or nearInfo.createTime < tInfo.createTime) then
			nearInfo = tInfo
		end
	end

	if nearInfo then
		local sbCfg = RoomConfig.instance:getSpecialBlockConfig(nearInfo.blockId)

		return sbCfg and sbCfg.name
	end

	return nil
end

function RoomBlockPackageDetailedItem:_onSelectUI()
	return
end

function RoomBlockPackageDetailedItem:onDestroyView()
	RoomBlockPackageDetailedItem.super.onDestroyView(self)
	self._imageIcon:UnLoadImage()
end

return RoomBlockPackageDetailedItem
