module("modules.logic.gm.notice.NoticeGmView", package.seeall)

slot0 = class("NoticeGmView", UserDataDispose)

function slot0.showGmView(slot0)
	if uv0.Instance then
		return
	end

	uv0.Instance = uv0.New()

	uv0.Instance:initView(slot0)
end

function slot0.closeGmView()
	if uv0.Instance then
		uv0.Instance:onDestroy()

		uv0.Instance = nil
	end
end

slot1 = "ui/viewres/gm/gmnotice.prefab"

function slot0.initView(slot0, slot1)
	slot0:__onInit()

	slot0.viewGo = slot1
	slot0.loader = PrefabInstantiate.Create(slot0.viewGo)

	slot0.loader:startLoad(uv0, slot0.onLoadCallback, slot0)
end

function slot0.onLoadCallback(slot0)
	slot0.goGmNode = slot0.loader:getInstGO()

	slot0:initChannelDrop()
	slot0:initSubChannelDrop()
	slot0:initServerTypeDrop()

	slot0.selectSdk = slot0.SDKTypeList[1]
	slot0.selectSubChannel = slot0.subChannelList[1]
	slot0.serverType = slot0.serverTypeList[1]

	NoticeController.instance:setSdkType(slot0.selectSdk)
	NoticeController.instance:setSubChannelId(slot0.selectSubChannel)
	NoticeController.instance:setServerType(slot0.serverType)
	slot0:refreshNoticeContent()
end

function slot0.initChannelDrop(slot0)
	slot0.channelDrop = gohelper.findChildDropdown(slot0.goGmNode, "channel_drop")

	slot0.channelDrop:ClearOptions()

	slot0.SDKNameList = {}
	slot0.SDKTypeList = {}

	for slot4, slot5 in pairs(NoticeGmDefine.SDKConfig) do
		table.insert(slot0.SDKNameList, slot5.name)
		table.insert(slot0.SDKTypeList, slot4)
	end

	slot0.channelDrop:AddOptions(slot0.SDKNameList)
	slot0.channelDrop:AddOnValueChanged(slot0.onChannelDropValueChanged, slot0)
end

function slot0.initSubChannelDrop(slot0)
	slot0.subChannelDrop = gohelper.findChildDropdown(slot0.goGmNode, "subchannel_drop")

	slot0.subChannelDrop:ClearOptions()

	slot0.subChannelNameList = {}
	slot0.subChannelList = {}

	for slot4, slot5 in pairs(NoticeGmDefine.SubChannelType) do
		table.insert(slot0.subChannelNameList, slot4)
		table.insert(slot0.subChannelList, slot5)
	end

	slot0.subChannelDrop:AddOptions(slot0.subChannelNameList)
	slot0.subChannelDrop:AddOnValueChanged(slot0.onSubChannelDropValueChanged, slot0)
end

function slot0.initServerTypeDrop(slot0)
	slot0.serverTypeDrop = gohelper.findChildDropdown(slot0.goGmNode, "servertype_drop")

	slot0.serverTypeDrop:ClearOptions()

	slot0.serverTypeList = {}
	slot0.serverTypeNameList = {}

	for slot4, slot5 in pairs(NoticeGmDefine.ServerTypeName) do
		table.insert(slot0.serverTypeList, slot4)
		table.insert(slot0.serverTypeNameList, slot5)
	end

	slot0.serverTypeDrop:AddOptions(slot0.serverTypeNameList)
	slot0.serverTypeDrop:AddOnValueChanged(slot0.onServerTypeDropValueChanged, slot0)
end

function slot0.onChannelDropValueChanged(slot0, slot1)
	if slot0.selectSdk == slot0.SDKTypeList[slot1 + 1] then
		return
	end

	slot0.selectSdk = slot0.SDKTypeList[slot1 + 1]

	NoticeController.instance:setSdkType(slot0.selectSdk)
	slot0:refreshNoticeContent()
end

function slot0.onSubChannelDropValueChanged(slot0, slot1)
	if slot0.selectSubChannel == slot0.subChannelList[slot1 + 1] then
		return
	end

	slot0.selectSubChannel = slot0.subChannelList[slot1 + 1]

	NoticeController.instance:setSubChannelId(slot0.selectSubChannel)
	slot0:refreshNoticeContent()
end

function slot0.onServerTypeDropValueChanged(slot0, slot1)
	if slot0.serverType == slot0.serverTypeList[slot1 + 1] then
		return
	end

	slot0.serverType = slot0.serverTypeList[slot1 + 1]

	NoticeController.instance:setServerType(slot0.serverType)
	slot0:refreshNoticeContent()
end

function slot0.refreshNoticeContent(slot0)
	NoticeController.instance:startRequest()
end

function slot0.onDestroy(slot0)
	slot0.channelDrop:RemoveOnValueChanged()
	slot0.subChannelDrop:RemoveOnValueChanged()
	slot0.serverTypeDrop:RemoveOnValueChanged()
	slot0.loader:onDestroy()
	slot0:__onDispose()
end

return slot0
