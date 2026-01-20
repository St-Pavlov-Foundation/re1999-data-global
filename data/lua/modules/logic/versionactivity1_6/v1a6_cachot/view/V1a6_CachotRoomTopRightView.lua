-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotRoomTopRightView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoomTopRightView", package.seeall)

local V1a6_CachotRoomTopRightView = class("V1a6_CachotRoomTopRightView", BaseView)

function V1a6_CachotRoomTopRightView:onInitView()
	self._btngroup = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_group")
	self._btncollection = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_collection")
	self._txtcollectionnum = gohelper.findChildTextMesh(self.viewGO, "right/#btn_collection/bg/#txt_collectionnum")
	self._gocollectioneffect = gohelper.findChild(self.viewGO, "right/#btn_collection/icon_effect")
end

function V1a6_CachotRoomTopRightView:addEvents()
	self._btngroup:AddClickListener(self._btngroupOnClick, self)
	self._btncollection:AddClickListener(self._btncollectionOnClick, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateRogueInfo, self._refreshView, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateCollectionsInfo, self.updateCollectionNum, self)
end

function V1a6_CachotRoomTopRightView:removeEvents()
	self._btngroup:RemoveClickListener()
	self._btncollection:RemoveClickListener()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateRogueInfo, self._refreshView, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateCollectionsInfo, self.updateCollectionNum, self)
end

function V1a6_CachotRoomTopRightView:_btngroupOnClick()
	V1a6_CachotController.instance:openV1a6_CachotTeamPreView()
end

function V1a6_CachotRoomTopRightView:_btncollectionOnClick()
	V1a6_CachotController.instance:openV1a6_CachotCollectionBagView()
end

function V1a6_CachotRoomTopRightView:onOpen()
	self:_refreshView()
end

function V1a6_CachotRoomTopRightView:_refreshView()
	self:updateCollectionNum()
end

function V1a6_CachotRoomTopRightView:updateCollectionNum()
	self._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	local collectionNum = self._rogueInfo.collections and #self._rogueInfo.collections or 0

	self._txtcollectionnum.text = collectionNum

	local isBagCanEnchant = false

	if collectionNum > 0 then
		isBagCanEnchant = V1a6_CachotCollectionHelper.isCollectionBagCanEnchant()
	end

	gohelper.setActive(self._gocollectioneffect, isBagCanEnchant)
end

return V1a6_CachotRoomTopRightView
