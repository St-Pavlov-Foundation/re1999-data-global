module("modules.logic.weather.eggs.SceneEggRandomShow", package.seeall)

slot0 = class("SceneEggRandomShow", SceneBaseEgg)

function slot0._onEnable(slot0)
	slot0:setGoListVisible(true)
end

function slot0._onDisable(slot0)
	slot0:setGoListVisible(false)
end

function slot0._onInit(slot0)
	slot0:setGoListVisible(false)
end

return slot0
