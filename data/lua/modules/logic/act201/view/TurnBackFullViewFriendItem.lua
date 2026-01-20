-- chunkname: @modules/logic/act201/view/TurnBackFullViewFriendItem.lua

module("modules.logic.act201.view.TurnBackFullViewFriendItem", package.seeall)

local TurnBackFullViewFriendItem = class("TurnBackFullViewFriendItem", RougeSimpleItemBase)

function TurnBackFullViewFriendItem:ctor(...)
	TurnBackFullViewFriendItem.super.ctor(self, ...)
end

function TurnBackFullViewFriendItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnBackFullViewFriendItem:_editableInitView()
	self._txtName = gohelper.findChildTextMesh(self.viewGO, "invited/namebg/#txt_name")
	self._goInvited = gohelper.findChild(self.viewGO, "invited")
	self._goUnInvite = gohelper.findChild(self.viewGO, "uninvite")
	self._simgHeadIcon = gohelper.findChildSingleImage(self.viewGO, "invited/#go_playerheadicon")
	self._goframenode = gohelper.findChild(self.viewGO, "invited/#go_playerheadicon/#go_framenode")
	self._txtstatetext = gohelper.findChildText(self.viewGO, "invited/playerstate/#txt_statetext")
	self._txtframenum1 = gohelper.findChildText(self.viewGO, "uninvite/frame/#txt_framenum")
	self._txtframenum2 = gohelper.findChildText(self.viewGO, "invited/frame/#txt_framenum")
	self._txtframenum1.text = ""
	self._txtframenum2.text = ""
	self._loader = MultiAbLoader.New()
end

function TurnBackFullViewFriendItem:setData(info)
	self._roleInfo = info

	self:_refreshItem()
end

function TurnBackFullViewFriendItem:setEmpty()
	self:setInfoState(false)
	self:_refreshItemNum()
end

function TurnBackFullViewFriendItem:setInfoState(invited)
	gohelper.setActive(self._goInvited, invited)
	gohelper.setActive(self._goUnInvite, not invited)
end

function TurnBackFullViewFriendItem:_refreshItem()
	local roleInfo = self._roleInfo

	if roleInfo == nil then
		self:setEmpty()

		return
	end

	self:setInfoState(true)
	self:_refreshItemNum()

	self._txtName.text = roleInfo.name
	self._txtstatetext.text = Activity201Config.instance:getRoleTypeStr(roleInfo.roleType)

	local config = lua_item.configDict[roleInfo.portrait]

	if not self._liveHeadIcon then
		local commonLiveIcon = IconMgr.instance:getCommonLiveHeadIcon(self._simgHeadIcon)

		self._liveHeadIcon = commonLiveIcon
	end

	self._liveHeadIcon:setLiveHead(config.id)

	local effectArr = string.split(config.effect, "#")

	if #effectArr > 1 then
		if config.id == tonumber(effectArr[#effectArr]) then
			gohelper.setActive(self._goframenode, true)

			if not self.frame then
				local framePath = "ui/viewres/common/effect/frame.prefab"

				self._loader:addPath(framePath)
				self._loader:startLoad(self._onLoadCallback, self)
			end
		end
	else
		gohelper.setActive(self._goframenode, false)
	end
end

function TurnBackFullViewFriendItem:_onLoadCallback()
	local framePrefab = self._loader:getFirstAssetItem():GetResource()

	gohelper.clone(framePrefab, self._goframenode, "frame")

	self.frame = gohelper.findChild(self._goframenode, "frame")

	local img = self.frame:GetComponent(gohelper.Type_Image)

	img.enabled = false

	local iconwidth = recthelper.getWidth(self._simgHeadIcon.transform)
	local framenodewidth = recthelper.getWidth(self.frame.transform)
	local scale = 1.41 * (iconwidth / framenodewidth)

	transformhelper.setLocalScale(self.frame.transform, scale, scale, 1)
end

function TurnBackFullViewFriendItem:addEventListeners()
	return
end

function TurnBackFullViewFriendItem:removeEventListeners()
	return
end

function TurnBackFullViewFriendItem:destroy()
	self._simgHeadIcon:UnLoadImage()

	self._roleInfo = nil

	self:disposeLoader()
	self:__onDispose()
end

function TurnBackFullViewFriendItem:onDestroyView()
	self:destroy()
end

function TurnBackFullViewFriendItem:onDestroy()
	self:onDestroyView()
end

function TurnBackFullViewFriendItem:_refreshItemNum()
	local showNum = self._index < 10 and "0" .. self._index or self._index

	self._txtframenum1.text = showNum
	self._txtframenum2.text = showNum
end

function TurnBackFullViewFriendItem:disposeLoader()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return TurnBackFullViewFriendItem
