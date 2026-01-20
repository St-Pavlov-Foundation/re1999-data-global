-- chunkname: @modules/logic/gm/notice/NoticeGmView.lua

module("modules.logic.gm.notice.NoticeGmView", package.seeall)

local NoticeGmView = class("NoticeGmView", UserDataDispose)

function NoticeGmView.showGmView(go)
	if NoticeGmView.Instance then
		return
	end

	NoticeGmView.Instance = NoticeGmView.New()

	NoticeGmView.Instance:initView(go)
end

function NoticeGmView.closeGmView()
	if NoticeGmView.Instance then
		NoticeGmView.Instance:onDestroy()

		NoticeGmView.Instance = nil
	end
end

local prefabPath = "ui/viewres/gm/gmnotice.prefab"

function NoticeGmView:initView(go)
	self:__onInit()

	self.viewGo = go
	self.loader = PrefabInstantiate.Create(self.viewGo)

	self.loader:startLoad(prefabPath, self.onLoadCallback, self)
end

function NoticeGmView:onLoadCallback()
	self.goGmNode = self.loader:getInstGO()

	self:initChannelDrop()
	self:initSubChannelDrop()
	self:initServerTypeDrop()

	self.selectSdk = self.SDKTypeList[1]
	self.selectSubChannel = self.subChannelList[1]
	self.serverType = self.serverTypeList[1]

	NoticeController.instance:setSdkType(self.selectSdk)
	NoticeController.instance:setSubChannelId(self.selectSubChannel)
	NoticeController.instance:setServerType(self.serverType)
	self:refreshNoticeContent()
end

function NoticeGmView:initChannelDrop()
	self.channelDrop = gohelper.findChildDropdown(self.goGmNode, "channel_drop")

	self.channelDrop:ClearOptions()

	self.SDKNameList = {}
	self.SDKTypeList = {}

	for sdk, sdkCo in pairs(NoticeGmDefine.SDKConfig) do
		table.insert(self.SDKNameList, sdkCo.name)
		table.insert(self.SDKTypeList, sdk)
	end

	self.channelDrop:AddOptions(self.SDKNameList)
	self.channelDrop:AddOnValueChanged(self.onChannelDropValueChanged, self)
end

function NoticeGmView:initSubChannelDrop()
	self.subChannelDrop = gohelper.findChildDropdown(self.goGmNode, "subchannel_drop")

	self.subChannelDrop:ClearOptions()

	self.subChannelNameList = {}
	self.subChannelList = {}

	for name, value in pairs(NoticeGmDefine.SubChannelType) do
		table.insert(self.subChannelNameList, name)
		table.insert(self.subChannelList, value)
	end

	self.subChannelDrop:AddOptions(self.subChannelNameList)
	self.subChannelDrop:AddOnValueChanged(self.onSubChannelDropValueChanged, self)
end

function NoticeGmView:initServerTypeDrop()
	self.serverTypeDrop = gohelper.findChildDropdown(self.goGmNode, "servertype_drop")

	self.serverTypeDrop:ClearOptions()

	self.serverTypeList = {}
	self.serverTypeNameList = {}

	for serverType, name in pairs(NoticeGmDefine.ServerTypeName) do
		table.insert(self.serverTypeList, serverType)
		table.insert(self.serverTypeNameList, name)
	end

	self.serverTypeDrop:AddOptions(self.serverTypeNameList)
	self.serverTypeDrop:AddOnValueChanged(self.onServerTypeDropValueChanged, self)
end

function NoticeGmView:onChannelDropValueChanged(index)
	if self.selectSdk == self.SDKTypeList[index + 1] then
		return
	end

	self.selectSdk = self.SDKTypeList[index + 1]

	NoticeController.instance:setSdkType(self.selectSdk)
	self:refreshNoticeContent()
end

function NoticeGmView:onSubChannelDropValueChanged(index)
	if self.selectSubChannel == self.subChannelList[index + 1] then
		return
	end

	self.selectSubChannel = self.subChannelList[index + 1]

	NoticeController.instance:setSubChannelId(self.selectSubChannel)
	self:refreshNoticeContent()
end

function NoticeGmView:onServerTypeDropValueChanged(index)
	if self.serverType == self.serverTypeList[index + 1] then
		return
	end

	self.serverType = self.serverTypeList[index + 1]

	NoticeController.instance:setServerType(self.serverType)
	self:refreshNoticeContent()
end

function NoticeGmView:refreshNoticeContent()
	NoticeController.instance:startRequest()
end

function NoticeGmView:onDestroy()
	self.channelDrop:RemoveOnValueChanged()
	self.subChannelDrop:RemoveOnValueChanged()
	self.serverTypeDrop:RemoveOnValueChanged()
	self.loader:onDestroy()
	self:__onDispose()
end

return NoticeGmView
