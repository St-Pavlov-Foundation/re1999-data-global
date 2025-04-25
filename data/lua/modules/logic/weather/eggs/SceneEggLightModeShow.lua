module("modules.logic.weather.eggs.SceneEggLightModeShow", package.seeall)

slot0 = class("SceneEggLightModeShow", SceneBaseEgg)

function slot0._onInit(slot0)
	slot0._lightMode = tonumber(slot0._eggConfig.actionParams)

	slot0:setGoListVisible(false)
end

function slot0._onReportChange(slot0, slot1)
	if not slot1 then
		slot0:setGoListVisible(false)

		return
	end

	slot0:setGoListVisible(slot0._lightMode == slot1.lightMode)
end

return slot0
