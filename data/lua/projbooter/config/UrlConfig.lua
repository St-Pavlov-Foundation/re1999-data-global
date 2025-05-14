module("projbooter.config.UrlConfig", package.seeall)

local var_0_0 = class("UrlConfig")

function var_0_0.getConfig()
	if not var_0_0._config then
		local var_1_0 = GameConfig.UrlCfg

		logNormal("UrlConfig.getConfig() =\n " .. var_1_0)

		var_0_0._config = cjson.decode(var_1_0)
	end

	return var_0_0._config
end

return var_0_0
