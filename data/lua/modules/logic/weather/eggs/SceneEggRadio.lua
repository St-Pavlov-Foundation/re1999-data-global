module("modules.logic.weather.eggs.SceneEggRadio", package.seeall)

slot0 = class("SceneEggRadio", SceneBaseEgg)

function slot0._onInit(slot0)
	slot0._heroId = tonumber(slot0._eggConfig.actionParams)
	slot0._isMainScene = slot0._context and slot0._context.isMainScene

	if slot0._isMainScene then
		CharacterController.instance:registerCallback(CharacterEvent.ChangeMainHero, slot0._onChangeMainHero, slot0)
	end

	slot0:_onChangeMainHero()
end

function slot0._onChangeMainHero(slot0)
	if not slot0._isMainScene then
		slot0:setGoListVisible(true)

		return
	end

	slot0:setGoListVisible(slot0._heroId ~= CharacterSwitchListModel.instance:getMainHero())
end

function slot0._onSceneClose(slot0)
	if slot0._isMainScene then
		CharacterController.instance:unregisterCallback(CharacterEvent.ChangeMainHero, slot0._onChangeMainHero, slot0)
	end
end

return slot0
