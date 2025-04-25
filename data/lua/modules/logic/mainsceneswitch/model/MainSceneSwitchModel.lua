module("modules.logic.mainsceneswitch.model.MainSceneSwitchModel", package.seeall)

slot0 = class("MainSceneSwitchModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._sceneId = nil
	slot0._sceneConfig = nil
end

function slot0.initSceneId(slot0)
	if slot0._sceneId then
		return
	end

	slot0:updateSceneIdByItemId(tonumber(PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.MainSceneSkin)) or 0)

	if slot0._sceneId then
		MainSceneSwitchController.closeSceneReddot(slot0._sceneId)
	end
end

function slot0.updateSceneIdByItemId(slot0, slot1)
	slot0:setCurSceneId(MainSceneSwitchConfig.instance:getConfigByItemId(slot1) and slot2.id or MainSceneSwitchConfig.instance:getDefaultSceneId())
end

function slot0.getCurSceneId(slot0)
	return slot0._sceneId
end

function slot0.setCurSceneId(slot0, slot1)
	slot0._sceneId = slot1
	slot0._sceneConfig = lua_scene_switch.configDict[slot0._sceneId]

	if not slot0._sceneConfig then
		slot0._sceneId = MainSceneSwitchConfig.instance:getDefaultSceneId()
		slot0._sceneConfig = lua_scene_switch.configDict[slot0._sceneId]
	end
end

function slot0.getCurSceneResName(slot0)
	return slot0._sceneConfig and slot0._sceneConfig.resName
end

function slot0.getSceneStatus(slot0)
	if not lua_scene_switch.configDict[slot0] then
		return MainSceneSwitchEnum.SceneStutas.Lock
	end

	if slot1.defaultUnlock == 1 then
		return MainSceneSwitchEnum.SceneStutas.Unlock
	end

	if ItemModel.instance:getItemCount(slot1.itemId) > 0 then
		return MainSceneSwitchEnum.SceneStutas.Unlock
	end

	if uv0.canJump(slot1.itemId) then
		return MainSceneSwitchEnum.SceneStutas.LockCanGet
	end

	return MainSceneSwitchEnum.SceneStutas.Lock
end

function slot0.canJump(slot0)
	for slot5, slot6 in ipairs(MainSceneSwitchConfig.instance:getItemSource(slot0)) do
		slot7, slot8 = uv0._getCantJump(slot6)

		if not slot7 then
			return true
		end
	end

	return false
end

function slot0._getCantJump(slot0)
	slot2, slot3 = nil

	if not JumpController.instance:isJumpOpen(slot0.sourceId) then
		slot2, slot3 = OpenHelper.getToastIdAndParam(JumpConfig.instance:getJumpConfig(slot0.sourceId).openId)
	else
		slot2, slot3 = JumpController.instance:cantJump(slot4.param)
	end

	return slot2, slot3
end

slot0.instance = slot0.New()

return slot0
