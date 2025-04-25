module("modules.logic.weather.eggs.SceneEggLightModeAnimShow", package.seeall)

slot0 = class("SceneEggLightModeAnimShow", SceneBaseEgg)

function slot0._onInit(slot0)
	slot0._animNameList = string.split(slot0._eggConfig.actionParams, "#")

	slot0:setGoListVisible(false)
end

function slot0._onEnable(slot0)
	if not slot0._lightMode then
		return
	end

	if not slot0._animNameList[slot0._lightMode] then
		return
	end

	slot0:playAnim(slot1)
end

function slot0._onDisable(slot0)
	slot0:setGoListVisible(false)
end

function slot0._onReportChange(slot0, slot1)
	if not slot1 then
		return
	end

	slot0._lightMode = slot1.lightMode
end

return slot0
