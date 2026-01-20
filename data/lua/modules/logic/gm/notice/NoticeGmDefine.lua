-- chunkname: @modules/logic/gm/notice/NoticeGmDefine.lua

module("modules.logic.gm.notice.NoticeGmDefine", package.seeall)

local NoticeGmDefine = _M

NoticeGmDefine.ServerType = {
	Release = 4,
	Dev = 1,
	TestDev = 2,
	Experience = 5,
	PreRelease = 3
}
NoticeGmDefine.ServerTypeName = {
	[NoticeGmDefine.ServerType.Dev] = "开发环境",
	[NoticeGmDefine.ServerType.TestDev] = "测试环境",
	[NoticeGmDefine.ServerType.PreRelease] = "预发布服环境",
	[NoticeGmDefine.ServerType.Release] = "正式环境",
	[NoticeGmDefine.ServerType.Experience] = "体验服环境"
}
NoticeGmDefine.SubChannelType = {
	Android = 1,
	PC = 3,
	IOS = 2
}
NoticeGmDefine.SDKConfig = {
	[GameChannelConfig.SDKType.gp_global] = {
		name = "欧美",
		channelId = 200,
		gameId = 60001,
		subChannelId = {
			[NoticeGmDefine.SubChannelType.Android] = 4001,
			[NoticeGmDefine.SubChannelType.IOS] = 5001,
			[NoticeGmDefine.SubChannelType.PC] = 6001
		}
	},
	[GameChannelConfig.SDKType.gp_japan] = {
		name = "日服",
		channelId = 300,
		gameId = 70001,
		subChannelId = {
			[NoticeGmDefine.SubChannelType.Android] = 4002,
			[NoticeGmDefine.SubChannelType.IOS] = 5002,
			[NoticeGmDefine.SubChannelType.PC] = 6002
		}
	},
	[GameChannelConfig.SDKType.efun] = {
		name = "港澳台",
		channelId = 201,
		gameId = 80001,
		subChannelId = {
			[NoticeGmDefine.SubChannelType.Android] = 4003,
			[NoticeGmDefine.SubChannelType.IOS] = 5003,
			[NoticeGmDefine.SubChannelType.PC] = 6003
		}
	},
	[GameChannelConfig.SDKType.longcheng] = {
		name = "韩服",
		channelId = 202,
		gameId = 90001,
		subChannelId = {
			[NoticeGmDefine.SubChannelType.Android] = 4004,
			[NoticeGmDefine.SubChannelType.IOS] = 5004,
			[NoticeGmDefine.SubChannelType.PC] = 6005
		}
	}
}

return NoticeGmDefine
