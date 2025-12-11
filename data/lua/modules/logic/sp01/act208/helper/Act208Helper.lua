module("modules.logic.sp01.act208.helper.Act208Helper", package.seeall)

return {
	getCurPlatformType = function()
		if SettingsModel.instance:isOverseas() then
			if SDKModel.instance:isPC() then
				return Act208Enum.ChannelId.PC
			else
				return Act208Enum.ChannelId.Mobile
			end
		end

		local var_1_0 = SDKMgr.instance:getSubChannelId()

		if var_1_0 == "1005" or var_1_0 == "1025" then
			return Act208Enum.ChannelId.PC
		else
			return Act208Enum.ChannelId.Mobile
		end
	end
}
