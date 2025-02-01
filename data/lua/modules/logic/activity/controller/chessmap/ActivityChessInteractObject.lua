module("modules.logic.activity.controller.chessmap.ActivityChessInteractObject", package.seeall)

slot0 = class("ActivityChessInteractObject")
slot1 = {
	[ActivityChessEnum.InteractType.Player] = ActivityChessInteractPlayer,
	[ActivityChessEnum.InteractType.TriggerFail] = ActivityChessInteractTriggerFail
}

function slot0.init(slot0, slot1)
	slot0.originData = slot1
	slot0.id = slot1.id

	if Activity109Config.instance:getInteractObjectCo(slot0.originData.actId, slot0.id) then
		slot0.objType = slot2.interactType
		slot0.config = slot2
		slot0._handler = (uv0[slot2.interactType] or ActivityChessInteractBase).New()

		slot0._handler:init(slot0)
	else
		logError("can't find interact_object : " .. tostring(slot1.actId) .. ", " .. tostring(slot1.id))
	end

	slot0.goToObject = ActivityChessGotoObject.New(slot0)
	slot0.effect = ActivityChessInteractEffect.New(slot0)
	slot0.avatar = nil
end

function slot0.setAvatar(slot0, slot1)
	slot0.avatar = slot1

	slot0:updateAvatarInScene()
end

function slot0.updateAvatarInScene(slot0)
	if not slot0.avatar or not slot0.avatar.sceneGo then
		return
	end

	if slot0.originData.posX and slot0.originData.posY then
		slot1, slot2, slot3 = ActivityChessGameController.instance:calcTilePosInScene(slot0.originData.posX, slot0.originData.posY, slot0.avatar.order)
		slot0.avatar.sceneX = slot1
		slot0.avatar.sceneY = slot2

		transformhelper.setLocalPos(slot0.avatar.sceneTf, slot1, slot2, slot3)
	end

	slot1 = 0.6

	transformhelper.setLocalScale(slot0.avatar.sceneTf, slot1, slot1, slot1)

	if slot0.avatar.loader and not string.nilorempty(slot0:getAvatarPath()) then
		slot0.avatar.loader:startLoad(string.format("scenes/m_s12_dfw/prefab/picpe/%s.prefab", slot2), slot0.onSceneObjectLoadFinish, slot0)
	end
end

slot0.DirectionList = {
	2,
	4,
	6,
	8
}
slot0.DirectionSet = {}

for slot5, slot6 in pairs(slot0.DirectionList) do
	slot0.DirectionSet[slot6] = true
end

function slot0.onSceneObjectLoadFinish(slot0)
	if slot0.avatar and slot0.avatar.loader then
		if not gohelper.isNil(slot0.avatar.loader:getInstGO()) then
			if gohelper.findChild(slot1, "Canvas") and slot2:GetComponent(typeof(UnityEngine.Canvas)) then
				slot3.worldCamera = CameraMgr.instance:getMainCamera()
			end

			for slot6, slot7 in ipairs(uv0.DirectionList) do
				slot0.avatar["goFaceTo" .. slot7] = gohelper.findChild(slot1, "piecea/char_" .. slot7)
			end
		end

		slot0.avatar.isLoaded = true

		slot0:getHandler():onAvatarLoaded()
		slot0.goToObject:onAvatarLoaded()
		slot0.effect:onAvatarLoaded()
	end
end

function slot0.tryGetGameObject(slot0)
	if slot0.avatar and slot0.avatar.loader and not gohelper.isNil(slot0.avatar.loader:getInstGO()) then
		return slot1
	end
end

function slot0.getAvatarPath(slot0)
	if Activity109Config.instance:getInteractObjectCo(slot0.originData.actId, slot0.originData.id) then
		return slot3.avatar
	end
end

function slot0.canSelect(slot0)
	return slot0.config and slot0.config.interactType == ActivityChessEnum.InteractType.Player
end

function slot0.getHandler(slot0)
	return slot0._handler
end

function slot0.canBlock(slot0)
	return slot0.config and (slot0.config.interactType == ActivityChessEnum.InteractType.Obstacle or slot0.config.interactType == ActivityChessEnum.InteractType.TriggerFail or slot0.config.interactType == ActivityChessEnum.InteractType.Player)
end

function slot0.getSelectPriority(slot0)
	slot1 = nil

	if slot0.config then
		slot1 = ActivityChessEnum.InteractSelectPriority[slot0.config.interactType]
	end

	return slot1 or slot0.id
end

function slot0.dispose(slot0)
	if slot0.avatar ~= nil then
		if slot0.avatar.loader then
			slot0.avatar.loader:dispose()

			slot0.avatar.loader = nil
		end

		if not gohelper.isNil(slot0.avatar.sceneGo) then
			gohelper.setActive(slot0.avatar.sceneGo, true)
			gohelper.destroy(slot0.avatar.sceneGo)
		end

		ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.DeleteInteractAvatar, slot0.avatar)

		slot0.avatar = nil
	end

	for slot5, slot6 in ipairs({
		"_handler",
		"goToObject",
		"effect"
	}) do
		if slot0[slot6] ~= nil then
			slot0[slot6]:dispose()

			slot0[slot6] = nil
		end
	end
end

return slot0
