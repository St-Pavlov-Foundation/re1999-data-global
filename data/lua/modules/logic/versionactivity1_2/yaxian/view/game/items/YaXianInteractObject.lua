module("modules.logic.versionactivity1_2.yaxian.view.game.items.YaXianInteractObject", package.seeall)

slot0 = class("YaXianInteractObject", UserDataDispose)
slot1 = {
	[YaXianGameEnum.InteractType.Player] = YaXianInteractPlayerHandle,
	[YaXianGameEnum.InteractType.TriggerFail] = YaXianInteractTriggerFailHandle
}
slot2 = {
	[YaXianGameEnum.InteractType.Player] = YaXianInteractPlayerStatus,
	[YaXianGameEnum.InteractType.Enemy] = YaXianInteractEnemyStatus
}

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0.delete = false
	slot0.interactContainerTr = slot1
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.interactMo = slot1

	if YaXianConfig.instance:getInteractObjectCo(slot0.interactMo.actId, slot0.id) then
		slot0.config = slot2
		slot0.handler = (uv0[slot2.interactType] or YaXianInteractHandleBase).New()

		slot0.handler:init(slot0)
	else
		logError("can't find interact_object : " .. tostring(slot1.actId) .. ", " .. tostring(slot1.id))
	end

	slot0:createSceneNode()
end

function slot0.createSceneNode(slot0)
	slot0.interactItemContainerGo = UnityEngine.GameObject.New("interact_item")
	slot0.interactItemContainerTr = slot0.interactItemContainerGo.transform

	slot0.interactItemContainerTr:SetParent(slot0.interactContainerTr, false)
end

function slot0.loadAvatar(slot0)
	if slot0.loader then
		return
	end

	slot1 = slot0:getAvatarPath()

	if slot0:isExitInteract() then
		slot0.loader = MultiAbLoader.New()

		slot0.loader:addPath(YaXianGameEnum.SceneResPath.ExitDefaultPath)

		if not string.nilorempty(slot1) then
			slot0.loader:addPath(slot1)
		end

		slot0.loader:startLoad(slot0.onSceneObjectMultiLoadFinish, slot0)

		return
	end

	slot0.loader = PrefabInstantiate.Create(slot0.interactItemContainerGo)

	if not string.nilorempty(slot1) then
		slot0.loader:startLoad(slot1, slot0.onSceneObjectLoadFinish, slot0)
	end
end

function slot0.onSceneObjectLoadFinish(slot0)
	slot0.interactGo = slot0.loader:getInstGO()

	slot0:initInteractGo()
	slot0:getHandler():onAvatarLoaded()
	gohelper.setLayer(slot0.interactItemContainerGo, UnityLayer.Scene, true)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.OnInteractLoadDone, slot0.id)
end

function slot0.onSceneObjectMultiLoadFinish(slot0)
	slot0.defaultExitInteractGo = gohelper.clone(slot0.loader:getAssetItem(YaXianGameEnum.SceneResPath.ExitDefaultPath):GetResource(), slot0.interactItemContainerGo, "default")
	slot0.goEnd = gohelper.findChild(slot0.defaultExitInteractGo, "#go_end")
	slot0.goTxtEnd = gohelper.findChild(slot0.defaultExitInteractGo, "#go_end/#go_txtend")
	slot0.transformEnd = slot0.goEnd and slot0.goEnd.transform

	if not string.nilorempty(slot0:getAvatarPath()) then
		slot0.interactGo = gohelper.clone(slot0.loader:getAssetItem(slot2):GetResource(), slot0.interactItemContainerGo)

		slot0:initInteractGo()
	end

	slot0:getHandler():onAvatarLoaded()
	gohelper.setLayer(slot0.interactItemContainerGo, UnityLayer.Scene, true)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.OnInteractLoadDone, slot0.id)
end

function slot0.initInteractGo(slot0)
	slot0.interactGo.name = slot0.id
	slot0.interactAnimator = ZProj.ProjAnimatorPlayer.Get(slot0.interactGo)

	slot0:stopAnimation()
	slot0:initDirectionNode()

	slot0.iconGoContainer = gohelper.findChild(slot0.interactGo, "icon")
	slot0.effectGoContainer = gohelper.findChild(slot0.interactGo, "skill")

	if uv0[slot0.config.interactType] then
		slot0.status = slot1.New()

		slot0.status:init(slot0)
	end

	slot0.effectMgr = YaXianInteractEffect.New()

	slot0.effectMgr:init(slot0)

	slot0.goTop = gohelper.findChild(slot0.interactGo, "tou")
	slot0.transformTop = not gohelper.isNil(slot0.goTop) and slot0.goTop.transform or nil
end

function slot0.updateInteractPos(slot0)
	if slot0.delete then
		return
	end

	slot1, slot2, slot3 = YaXianGameHelper.calcTilePosInScene(slot0.interactMo.posX, slot0.interactMo.posY)

	transformhelper.setLocalPos(slot0.interactItemContainerTr, slot1, slot2, slot3)
end

function slot0.updateInteractMo(slot0, slot1)
	slot0.interactMo = slot1

	slot0:updateInteractDirection()
	slot0:updateInteractPos()
end

function slot0.getShowPriority(slot0)
	return YaXianGameEnum.InteractShowPriority[slot0.config.interactType] or YaXianGameEnum.MinShowPriority
end

function slot0.updateActiveByShowPriority(slot0, slot1)
	gohelper.setActive(slot0.interactGo, slot1 <= slot0:getShowPriority())

	if slot0:isExitInteract() then
		if slot0:getShowPriority() < slot1 then
			gohelper.setActive(slot0.goEnd, false)

			return
		end

		gohelper.setActive(slot0.goEnd, true)
		gohelper.setActive(slot0.goTxtEnd, not slot0.interactGo)

		if slot0.interactGo then
			if not gohelper.isNil(slot0.transformEnd) then
				transformhelper.setLocalPosXY(slot0.transformEnd, 0, slot0.transformTop and slot0.transformTop.localPosition.y or 0.5)
			else
				logError("transformEnd is nil, interact name : " .. tostring(slot0.config and slot0.config.name or "nil"))
			end
		elseif not gohelper.isNil(slot0.transformEnd) then
			transformhelper.setLocalPosXY(slot0.transformEnd, 0, 0)
		else
			logError("transformEnd is nil, interact name : " .. tostring(slot0.config and slot0.config.name or "nil"))
		end
	end
end

function slot0.updateInteractDirection(slot0)
	slot0:getHandler():faceTo(slot0.interactMo.direction)
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0.interactItemContainerGo, slot1)
end

function slot0.deleteSelf(slot0)
	slot0.delete = true

	gohelper.setActive(slot0.interactItemContainerGo, false)
end

function slot0.renewSelf(slot0)
	slot0.delete = false

	gohelper.setActive(slot0.interactItemContainerGo, true)
	slot0:_stopAnimation()
end

function slot0.isDelete(slot0)
	return slot0.delete
end

function slot0.getAvatarPath(slot0)
	if slot0.config and not string.nilorempty(slot0.config.avatar) then
		return "scenes/" .. slot0.config.avatar
	end

	return nil
end

function slot0.initDirectionNode(slot0)
	slot0.directionAvatarDict = slot0:getUserDataTb_()
	slot0.directionAvatarDict[YaXianGameEnum.MoveDirection.Bottom] = gohelper.findChild(slot0.interactGo, "cha4_" .. YaXianGameEnum.MoveDirection.Bottom)
	slot0.directionAvatarDict[YaXianGameEnum.MoveDirection.Left] = gohelper.findChild(slot0.interactGo, "cha4_" .. YaXianGameEnum.MoveDirection.Left)
	slot0.directionAvatarDict[YaXianGameEnum.MoveDirection.Right] = gohelper.findChild(slot0.interactGo, "cha4_" .. YaXianGameEnum.MoveDirection.Right)
	slot0.directionAvatarDict[YaXianGameEnum.MoveDirection.Top] = gohelper.findChild(slot0.interactGo, "cha4_" .. YaXianGameEnum.MoveDirection.Top)
end

function slot0.getHandler(slot0)
	return slot0.handler
end

function slot0.getSelectPriority(slot0)
	slot1 = nil

	if slot0.config then
		slot1 = YaXianGameEnum.InteractSelectPriority[slot0.config.interactType]
	end

	return slot1 or slot0.id
end

function slot0.isFighting(slot0)
	if slot0.config.alertType ~= YaXianGameEnum.AlertType.FourWay then
		return false
	end

	return slot0.interactMo.alertPosList and next(slot0.interactMo.alertPosList)
end

function slot0.isEnemy(slot0)
	return slot0.config.interactType == YaXianGameEnum.InteractType.Enemy or slot0.config.interactType == YaXianGameEnum.InteractType.TriggerFail
end

function slot0.getEffectMgr(slot0)
	return slot0.effectMgr
end

function slot0.showEffect(slot0, slot1, slot2, slot3)
	if slot0.effectMgr then
		slot0.effectMgr:showEffect(slot1, slot2, slot3)
	end
end

function slot0.cancelEffectTask(slot0)
	if slot0.effectMgr then
		slot0.effectMgr:cancelTask()
	end
end

function slot0.isExitInteract(slot0)
	return slot0.config.interactType == YaXianGameEnum.InteractType.TriggerVictory
end

function slot0.isPlayer(slot0)
	return slot0.config.interactType == YaXianGameEnum.InteractType.Player
end

function slot0.playAnimation(slot0, slot1)
	if slot0.interactAnimator then
		slot0.currentPlayAnimationName = slot1

		slot0.interactAnimator:Play(slot1)
	end
end

function slot0.stopAnimation(slot0)
	if string.nilorempty(slot0.currentPlayAnimationName) and YaXianGameEnum.CloseAnimationName[slot0.currentPlayAnimationName] then
		slot0.interactAnimator:Play(slot1, slot0._stopAnimation, slot0)

		return
	end

	slot0:_stopAnimation()
end

function slot0._stopAnimation(slot0)
	if slot0.interactAnimator then
		slot0.interactAnimator:Play("idle")
	end
end

function slot0.dispose(slot0)
	gohelper.setActive(slot0.iconGoContainer, true)
	gohelper.setActive(slot0.interactItemContainerGo, true)
	gohelper.destroy(slot0.iconGoContainer)
	gohelper.destroy(slot0.interactItemContainerGo)

	if slot0.handler ~= nil then
		slot0.handler:dispose()
	end

	if slot0.loader then
		slot0.loader:dispose()
	end

	if slot0.status then
		slot0.status:dispose()
	end

	if slot0.effectMgr then
		slot0.effectMgr:dispose()
	end

	slot0:__onDispose()
end

return slot0
