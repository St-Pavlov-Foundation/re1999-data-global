module("projbooter.config.UrlConfig", package.seeall)

slot0 = class("UrlConfig")

function slot0.getConfig()
	if not uv0._config then
		slot0 = GameConfig.UrlCfg

		logNormal("UrlConfig.getConfig() =\n " .. slot0)

		uv0._config = cjson.decode(slot0)
	end

	return uv0._config
end

return slot0
