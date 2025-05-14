module("modules.logic.gm.notice.NoticeGmView", package.seeall)

local var_0_0 = class("NoticeGmView", UserDataDispose)

function var_0_0.showGmView(arg_1_0)
	if var_0_0.Instance then
		return
	end

	var_0_0.Instance = var_0_0.New()

	var_0_0.Instance:initView(arg_1_0)
end

function var_0_0.closeGmView()
	if var_0_0.Instance then
		var_0_0.Instance:onDestroy()

		var_0_0.Instance = nil
	end
end

local var_0_1 = "ui/viewres/gm/gmnotice.prefab"

function var_0_0.initView(arg_3_0, arg_3_1)
	arg_3_0:__onInit()

	arg_3_0.viewGo = arg_3_1
	arg_3_0.loader = PrefabInstantiate.Create(arg_3_0.viewGo)

	arg_3_0.loader:startLoad(var_0_1, arg_3_0.onLoadCallback, arg_3_0)
end

function var_0_0.onLoadCallback(arg_4_0)
	arg_4_0.goGmNode = arg_4_0.loader:getInstGO()

	arg_4_0:initChannelDrop()
	arg_4_0:initSubChannelDrop()
	arg_4_0:initServerTypeDrop()

	arg_4_0.selectSdk = arg_4_0.SDKTypeList[1]
	arg_4_0.selectSubChannel = arg_4_0.subChannelList[1]
	arg_4_0.serverType = arg_4_0.serverTypeList[1]

	NoticeController.instance:setSdkType(arg_4_0.selectSdk)
	NoticeController.instance:setSubChannelId(arg_4_0.selectSubChannel)
	NoticeController.instance:setServerType(arg_4_0.serverType)
	arg_4_0:refreshNoticeContent()
end

function var_0_0.initChannelDrop(arg_5_0)
	arg_5_0.channelDrop = gohelper.findChildDropdown(arg_5_0.goGmNode, "channel_drop")

	arg_5_0.channelDrop:ClearOptions()

	arg_5_0.SDKNameList = {}
	arg_5_0.SDKTypeList = {}

	for iter_5_0, iter_5_1 in pairs(NoticeGmDefine.SDKConfig) do
		table.insert(arg_5_0.SDKNameList, iter_5_1.name)
		table.insert(arg_5_0.SDKTypeList, iter_5_0)
	end

	arg_5_0.channelDrop:AddOptions(arg_5_0.SDKNameList)
	arg_5_0.channelDrop:AddOnValueChanged(arg_5_0.onChannelDropValueChanged, arg_5_0)
end

function var_0_0.initSubChannelDrop(arg_6_0)
	arg_6_0.subChannelDrop = gohelper.findChildDropdown(arg_6_0.goGmNode, "subchannel_drop")

	arg_6_0.subChannelDrop:ClearOptions()

	arg_6_0.subChannelNameList = {}
	arg_6_0.subChannelList = {}

	for iter_6_0, iter_6_1 in pairs(NoticeGmDefine.SubChannelType) do
		table.insert(arg_6_0.subChannelNameList, iter_6_0)
		table.insert(arg_6_0.subChannelList, iter_6_1)
	end

	arg_6_0.subChannelDrop:AddOptions(arg_6_0.subChannelNameList)
	arg_6_0.subChannelDrop:AddOnValueChanged(arg_6_0.onSubChannelDropValueChanged, arg_6_0)
end

function var_0_0.initServerTypeDrop(arg_7_0)
	arg_7_0.serverTypeDrop = gohelper.findChildDropdown(arg_7_0.goGmNode, "servertype_drop")

	arg_7_0.serverTypeDrop:ClearOptions()

	arg_7_0.serverTypeList = {}
	arg_7_0.serverTypeNameList = {}

	for iter_7_0, iter_7_1 in pairs(NoticeGmDefine.ServerTypeName) do
		table.insert(arg_7_0.serverTypeList, iter_7_0)
		table.insert(arg_7_0.serverTypeNameList, iter_7_1)
	end

	arg_7_0.serverTypeDrop:AddOptions(arg_7_0.serverTypeNameList)
	arg_7_0.serverTypeDrop:AddOnValueChanged(arg_7_0.onServerTypeDropValueChanged, arg_7_0)
end

function var_0_0.onChannelDropValueChanged(arg_8_0, arg_8_1)
	if arg_8_0.selectSdk == arg_8_0.SDKTypeList[arg_8_1 + 1] then
		return
	end

	arg_8_0.selectSdk = arg_8_0.SDKTypeList[arg_8_1 + 1]

	NoticeController.instance:setSdkType(arg_8_0.selectSdk)
	arg_8_0:refreshNoticeContent()
end

function var_0_0.onSubChannelDropValueChanged(arg_9_0, arg_9_1)
	if arg_9_0.selectSubChannel == arg_9_0.subChannelList[arg_9_1 + 1] then
		return
	end

	arg_9_0.selectSubChannel = arg_9_0.subChannelList[arg_9_1 + 1]

	NoticeController.instance:setSubChannelId(arg_9_0.selectSubChannel)
	arg_9_0:refreshNoticeContent()
end

function var_0_0.onServerTypeDropValueChanged(arg_10_0, arg_10_1)
	if arg_10_0.serverType == arg_10_0.serverTypeList[arg_10_1 + 1] then
		return
	end

	arg_10_0.serverType = arg_10_0.serverTypeList[arg_10_1 + 1]

	NoticeController.instance:setServerType(arg_10_0.serverType)
	arg_10_0:refreshNoticeContent()
end

function var_0_0.refreshNoticeContent(arg_11_0)
	NoticeController.instance:startRequest()
end

function var_0_0.onDestroy(arg_12_0)
	arg_12_0.channelDrop:RemoveOnValueChanged()
	arg_12_0.subChannelDrop:RemoveOnValueChanged()
	arg_12_0.serverTypeDrop:RemoveOnValueChanged()
	arg_12_0.loader:onDestroy()
	arg_12_0:__onDispose()
end

return var_0_0
