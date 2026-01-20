-- chunkname: @modules/logic/room/view/RoomBlockPackageSimpleItem.lua

module("modules.logic.room.view.RoomBlockPackageSimpleItem", package.seeall)

local RoomBlockPackageSimpleItem = class("RoomBlockPackageSimpleItem", RoomBlockPackageItem)

function RoomBlockPackageSimpleItem:_editableInitView()
	self._go = self.viewGO
	self._goitem = gohelper.findChild(self.viewGO, "item")
	self._txtnum = gohelper.findChildText(self.viewGO, "item/image_rare/bottom/txt_num")
	self._txtdegree = gohelper.findChildText(self.viewGO, "item/image_rare/bottom/txt_degree")
	self._imagerare = gohelper.findChildImage(self.viewGO, "item/image_rare")
	self._txtname = gohelper.findChildText(self.viewGO, "item/image_rare/txt_name")
	self._goreddot = gohelper.findChild(self.viewGO, "item/image_rare/go_reddot")
	self._goselect = gohelper.findChild(self.viewGO, "item/image_rare/go_select")
	self._btnItem = gohelper.findChildButtonWithAudio(self.viewGO, "item")
	self._goempty = gohelper.findChild(self.viewGO, "item/image_rare/bottom/go_empty")
	self._simagedegree = gohelper.findChildImage(self.viewGO, "item/image_rare/bottom/txt_degree/icon")

	self._btnItem:AddClickListener(self._btnitemOnClick, self)
	UISpriteSetMgr.instance:setRoomSprite(self._simagedegree, "jianshezhi")
	self:_onInit(self.viewGO)
end

function RoomBlockPackageSimpleItem:_onInit(go)
	gohelper.setActive(self._goselect, false)
end

function RoomBlockPackageSimpleItem:_onRefreshUI()
	local splitName = RoomBlockPackageEnum.RareIcon[self._packageCfg.rare] or RoomBlockPackageEnum.RareIcon[1]

	UISpriteSetMgr.instance:setRoomSprite(self._imagerare, splitName)
end

function RoomBlockPackageSimpleItem:_onSelectUI()
	return
end

return RoomBlockPackageSimpleItem
