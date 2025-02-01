module("modules.logic.versionactivity1_2.yaxian.view.game.items.YaXianBaffleObject", package.seeall)

slot0 = class("YaXianBaffleObject", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0.baffleContainerTr = slot1
end

function slot0.init(slot0)
	slot0:createSceneNode()
end

function slot0.createSceneNode(slot0)
	slot0.viewGO = UnityEngine.GameObject.New("baffle_item")
	slot0.transform = slot0.viewGO.transform

	slot0.transform:SetParent(slot0.baffleContainerTr, false)
end

function slot0.getBaffleResPath(slot0)
	if slot0.baffleCo.direction == YaXianGameEnum.BaffleDirection.Left or slot0.baffleCo.direction == YaXianGameEnum.BaffleDirection.Right then
		return slot0.baffleCo.type == 0 and YaXianGameEnum.SceneResPath.LRBaffle0 or YaXianGameEnum.SceneResPath.LRBaffle1
	else
		return slot0.baffleCo.type == 0 and YaXianGameEnum.SceneResPath.TBBaffle0 or YaXianGameEnum.SceneResPath.TBBaffle1
	end
end

function slot0.loadAvatar(slot0)
	if not gohelper.isNil(slot0.baffleGo) then
		gohelper.destroy(slot0.baffleGo)
	end

	slot0.loader = PrefabInstantiate.Create(slot0.viewGO)

	slot0.loader:startLoad(slot0:getBaffleResPath(), slot0.onSceneObjectLoadFinish, slot0)
end

function slot0.onSceneObjectLoadFinish(slot0)
	slot0.baffleGo = slot0.loader:getInstGO()

	if not gohelper.isNil(slot0.baffleGo) and gohelper.findChild(slot0.baffleGo, "Canvas") and slot1:GetComponent(typeof(UnityEngine.Canvas)) then
		slot2.worldCamera = CameraMgr.instance:getMainCamera()
	end

	transformhelper.setLocalScale(slot0.viewGO.transform, 0.8, 0.8, 0.8)
	gohelper.setLayer(slot0.viewGO, UnityLayer.Scene, true)
end

function slot0.updatePos(slot0, slot1)
	slot0.baffleCo = slot1
	slot2, slot3, slot4 = YaXianGameHelper.calBafflePosInScene(slot0.baffleCo.x, slot0.baffleCo.y, slot0.baffleCo.direction)

	transformhelper.setLocalPos(slot0.transform, slot2, slot3, slot4)
	gohelper.setActive(slot0.viewGO, true)
	slot0:loadAvatar()
end

function slot0.recycle(slot0)
	gohelper.setActive(slot0.viewGO, false)
end

function slot0.dispose(slot0)
	if slot0.loader then
		slot0.loader:dispose()

		slot0.loader = nil
	end

	gohelper.setActive(slot0.viewGO, true)
	gohelper.destroy(slot0.viewGO)
	slot0:__onDispose()
end

return slot0
