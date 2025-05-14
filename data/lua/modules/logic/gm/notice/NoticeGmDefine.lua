module("modules.logic.gm.notice.NoticeGmDefine", package.seeall)

local var_0_0 = _M

var_0_0.ServerType = {
	Release = 4,
	Dev = 1,
	TestDev = 2,
	Experience = 5,
	PreRelease = 3
}
var_0_0.ServerTypeName = {
	[var_0_0.ServerType.Dev] = "开发环境",
	[var_0_0.ServerType.TestDev] = "测试环境",
	[var_0_0.ServerType.PreRelease] = "预发布服环境",
	[var_0_0.ServerType.Release] = "正式环境",
	[var_0_0.ServerType.Experience] = "体验服环境"
}
var_0_0.SubChannelType = {
	Android = 1,
	PC = 3,
	IOS = 2
}
var_0_0.SDKConfig = {
	[GameChannelConfig.SDKType.gp_global] = {
		name = "欧美",
		channelId = 200,
		gameId = 60001,
		subChannelId = {
			[var_0_0.SubChannelType.Android] = 4001,
			[var_0_0.SubChannelType.IOS] = 5001,
			[var_0_0.SubChannelType.PC] = 6001
		}
	},
	[GameChannelConfig.SDKType.gp_japan] = {
		name = "日服",
		channelId = 300,
		gameId = 70001,
		subChannelId = {
			[var_0_0.SubChannelType.Android] = 4002,
			[var_0_0.SubChannelType.IOS] = 5002,
			[var_0_0.SubChannelType.PC] = 6002
		}
	},
	[GameChannelConfig.SDKType.efun] = {
		name = "港澳台",
		channelId = 201,
		gameId = 80001,
		subChannelId = {
			[var_0_0.SubChannelType.Android] = 4003,
			[var_0_0.SubChannelType.IOS] = 5003,
			[var_0_0.SubChannelType.PC] = 6003
		}
	},
	[GameChannelConfig.SDKType.longcheng] = {
		name = "韩服",
		channelId = 202,
		gameId = 90001,
		subChannelId = {
			[var_0_0.SubChannelType.Android] = 4004,
			[var_0_0.SubChannelType.IOS] = 5004,
			[var_0_0.SubChannelType.PC] = 6005
		}
	}
}

return var_0_0
