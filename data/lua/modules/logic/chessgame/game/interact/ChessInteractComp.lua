module("modules.logic.chessgame.game.interact.ChessInteractComp", package.seeall)

slot0 = class("ChessInteractComp")
slot1 = {
	[ChessGameEnum.InteractType.Normal] = ChessInteractBase,
	[ChessGameEnum.InteractType.Role] = ChessInteractPlayer,
	[ChessGameEnum.InteractType.Teleport] = ChessInteractBase,
	[ChessGameEnum.InteractType.Hit] = ChessInteractBase,
	[ChessGameEnum.InteractType.Save] = ChessInteractBase,
	[ChessGameEnum.InteractType.Hunter] = ChessInteractHunter,
	[ChessGameEnum.InteractType.Prey] = ChessInteractBase,
	[ChessGameEnum.InteractType.Obstacle] = ChessInteractObstacle
}
slot2 = {}
slot3 = {
	[ChessGameEnum.GameEffectType.Display] = ChessEffectBase,
	[ChessGameEnum.GameEffectType.Talk] = ChessEffectBase
}
slot4 = {}

function slot0.init(slot0, slot1, slot2)
	slot0.mo = slot2
	slot0.mapId = slot1
	slot0.id = slot0.mo:getId()

	if slot0.mo:getConfig() then
		slot0.objType = slot3.interactType
		slot0.config = slot3
		slot0._handler = (uv0[slot3.interactType] or uv1).New()

		slot0._handler:init(slot0)
	end

	if slot0.mo:getEffectType() and slot4 ~= ChessGameEnum.GameEffectType.None then
		slot0.chessEffectObj = (uv2[slot2.actId] and slot5[slot4] or uv3[slot4]).New(slot0)
	end

	slot0.avatar = nil
end

function slot0.updateComp(slot0, slot1)
	slot0.mo = slot1

	slot0:updatePos(slot0.mo:getConfig())

	if slot0.objType == ChessGameEnum.InteractType.Hunter then
		slot0:getHandler():refreshAlarmArea()
	end
end

function slot0.setAvatar(slot0, slot1)
	slot0.avatar = slot1

	slot0:updateAvatarInScene()
end

function slot0.checkShowAvatar(slot0)
	return slot0.avatar and slot0.avatar.isLoaded
end

function slot0.setCurrpath(slot0, slot1)
	slot0._path = slot1
end

function slot0.getCurrpath(slot0)
	return slot0._path
end

function slot0.checkHaveAvatarPath(slot0)
	if not string.nilorempty(slot0.mo:getConfig().path) then
		return true
	end

	return false
end

function slot0.updateAvatarInScene(slot0)
	if not slot0.avatar or not slot0.avatar.sceneGo then
		return
	end

	slot0:updatePos(slot0.mo:getConfig())

	if slot0.avatar.loader and slot1 then
		slot2 = slot1.path
		slot0.avatar.name = SLFramework.FileHelper.GetFileName(slot2, false)

		if not string.nilorempty(slot2) then
			if slot0:getCurrpath() == slot2 then
				return
			end

			if not slot0.avatar.loader:getAssetItem(slot2) then
				slot0.avatar.loader:startLoad(slot2, slot0.onSceneObjectLoadFinish, slot0)
				slot0:setCurrpath(slot2)
			end
		end
	end
end

function slot0.updatePos(slot0, slot1)
	if not slot0.avatar or not slot0.avatar.sceneGo then
		return
	end

	if slot0.mo.posX and slot0.mo.posY and slot1 then
		slot2 = slot1.offset
		slot0.avatar.sceneX = slot0.mo.posX or slot1.x
		slot0.avatar.sceneY = slot0.mo.posY or slot1.x
		slot4 = ChessGameHelper.nodePosToWorldPos({
			z = 0,
			x = slot0.mo.posX,
			y = slot0.mo.posY
		})

		transformhelper.setLocalPos(slot0.avatar.sceneTf, slot4.x + slot2.x, slot4.y + slot2.y, slot4.z + slot2.z)
		slot0._handler:faceTo(slot0.mo.direction or slot1.dir)
	end
end

function slot0.changeModule(slot0, slot1)
	if slot0:getCurrpath() == slot1 then
		return
	end

	if not slot0._oldLoader then
		slot0._oldLoader = slot0.avatar.loader
	elseif slot0.avatar.loader then
		slot0.avatar.loader:dispose()

		slot0.avatar.loader = nil
	end

	slot0:loadModule(slot1)
end

function slot0.loadModule(slot0, slot1)
	gohelper.destroyAllChildren(slot0.avatar.sceneGo)

	slot0.avatar.loader = PrefabInstantiate.Create(slot0.avatar.sceneGo)

	if not string.nilorempty(slot1) and not gohelper.isNil(slot0.avatar.loader:getAssetItem(slot1)) then
		slot0.avatar.loader:startLoad(slot1, slot0.onSceneObjectLoadFinish, slot0)
		slot0:setCurrpath(slot1)
	end
end

slot0.DirectionList = {
	2,
	4,
	6,
	8
}
slot0.DirectionSet = {}

for slot8, slot9 in pairs(slot0.DirectionList) do
	slot0.DirectionSet[slot9] = true
end

function slot0.onSceneObjectLoadFinish(slot0)
	if slot0.avatar and slot0.avatar.loader then
		if not gohelper.isNil(slot0.avatar.loader:getInstGO()) and not slot0.avatar.isLoaded then
			if gohelper.findChild(slot1, "Canvas") and slot2:GetComponent(typeof(UnityEngine.Canvas)) then
				slot3.worldCamera = CameraMgr.instance:getMainCamera()
			end

			for slot6, slot7 in ipairs(uv0.DirectionList) do
				slot0.avatar["goFaceTo" .. slot7] = gohelper.findChild(slot1, "dir_" .. slot7)
			end

			slot0.avatar.effectNode = gohelper.findChild(slot1, "icon")
		end

		slot0.avatar.isLoaded = true

		slot0:getHandler():onAvatarLoaded()
		ChessGameController.instance.interactsMgr:checkCompleletedLoaded(slot0.mo.id)
	end
end

function slot0.tryGetGameObject(slot0)
	if slot0.avatar and slot0.avatar.loader and not gohelper.isNil(slot0.avatar.loader:getInstGO()) then
		return slot1
	end
end

function slot0.tryGetSceneGO(slot0)
	if slot0.avatar and not gohelper.isNil(slot0.avatar.sceneGo) then
		return slot0.avatar.sceneGo
	end
end

function slot0.hideSelf(slot0)
	if slot0.avatar and not gohelper.isNil(slot0.avatar.sceneGo) then
		gohelper.setActive(slot0.avatar.sceneGo, false)
	end
end

function slot0.isShow(slot0)
	if not slot0.mo then
		return false
	else
		return slot0.mo:isShow()
	end
end

function slot0.getAvatarName(slot0)
	if ChessGameConfig.instance:getInteractObjectCo(slot0.mo.actId, slot0.mo.id) then
		return slot3.avatar
	end
end

function slot0.getObjId(slot0)
	return slot0.id
end

function slot0.getObjType(slot0)
	return slot0.objType
end

function slot0.getObjPosIndex(slot0)
	return slot0.mo:getPosIndex()
end

function slot0.getHandler(slot0)
	return slot0._handler
end

function slot0.onCancelSelect(slot0)
	if slot0:getHandler() then
		slot0:getHandler():onCancelSelect()
	end

	if slot0.chessEffectObj then
		slot0.chessEffectObj:onCancelSelect()
	end
end

function slot0.onSelected(slot0)
	if slot0:getHandler() then
		slot0:getHandler():onSelected()
	end

	if slot0.chessEffectObj then
		slot0.chessEffectObj:onSelected()
	end
end

function slot0.canSelect(slot0)
	return slot0.config and slot0.config.interactType == ChessGameEnum.InteractType.Player or slot0.config.interactType == ChessGameEnum.InteractType.AssistPlayer
end

function slot0.dispose(slot0)
	if slot0.avatar ~= nil then
		if slot0.avatar.loader then
			slot0.avatar.loader:dispose()

			slot0.avatar.loader = nil
		end

		if not gohelper.isNil(slot0.avatar.sceneGo) then
			gohelper.setActive(slot0.avatar.sceneGo, false)
			gohelper.destroy(slot0.avatar.sceneGo)
		end

		ChessGameController.instance:dispatchEvent(ChessGameEvent.DeleteInteractAvatar, slot0.id)

		slot0.avatar = nil
	end

	for slot5, slot6 in ipairs({
		"_handler",
		"chessEffectObj"
	}) do
		if slot0[slot6] ~= nil then
			slot0[slot6]:dispose()

			slot0[slot6] = nil
		end
	end
end

function slot0.showStateView(slot0, slot1, slot2)
	if slot0:getHandler().showStateView then
		return slot0:getHandler():showStateView(slot1, slot2)
	end
end

return slot0
