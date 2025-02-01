module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGamePathView", package.seeall)

slot0 = class("YaXianGamePathView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.RefreshInteractPath, slot0.refreshInteractPath, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.OnUpdateEffectInfo, slot0.onUpdateEffectInfo, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.OnResetView, slot0.resetMapView, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.MainResLoadDone, slot0.onMainResLoadDone, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.playerPathPool = {}
	slot0.playerHalfPathPool = {}
	slot0.enemyPathPool = {}
	slot0.enemyHalfPathPool = {}
	slot0.playerPathList = {}
	slot0.playerHalfPathList = {}
	slot0.enemyPathList = {}
	slot0.enemyHalfPathList = {}
end

function slot0.onMainResLoadDone(slot0, slot1)
	if slot0.initResDone then
		return
	end

	slot0.loader = slot1
	slot0.sceneGo = slot0.viewContainer:getRootSceneGo()
	slot0.pathContainer = UnityEngine.GameObject.New("pathContainer")

	slot0.pathContainer.transform:SetParent(slot0.sceneGo.transform, false)
	transformhelper.setLocalPos(slot0.pathContainer.transform, 0, 0, YaXianGameEnum.ContainerOffsetZ.Path)

	slot0.greedLinePrefab = slot0.loader:getAssetItem(YaXianGameEnum.SceneResPath.GreenLine):GetResource()
	slot0.redLinePrefab = slot0.loader:getAssetItem(YaXianGameEnum.SceneResPath.RedLine):GetResource()
	slot0.greenHalfLinePrefab = slot0.loader:getAssetItem(YaXianGameEnum.SceneResPath.GreedLineHalf):GetResource()
	slot0.redHalfLinePrefab = slot0.loader:getAssetItem(YaXianGameEnum.SceneResPath.RedLineHalf):GetResource()
	slot0.initResDone = true
end

function slot0.onUpdateEffectInfo(slot0)
	slot0:refreshInteractPath(slot0.preIsShow)
end

function slot0.refreshInteractPath(slot0, slot1)
	slot0.preIsShow = slot1

	slot0:refreshPlayerInteractPath(slot1)
	slot0:refreshEnemyInteractPath(slot1)
end

function slot0.refreshPlayerInteractPath(slot0, slot1)
	slot0:recyclePlayerInteractPath()

	if slot1 then
		slot2 = YaXianGameModel.instance:getPlayerInteractMo()

		for slot7, slot8 in pairs(YaXianGameModel.instance:getCanWalkTargetPosDict()) do
			slot0:buildPath(slot2.posX, slot2.posY, slot8.x, slot8.y, true, slot7)
		end
	end
end

function slot0.refreshEnemyInteractPath(slot0, slot1)
	slot0:recycleEnemyInteractPath()

	if slot1 then
		for slot5, slot6 in ipairs(YaXianGameModel.instance:getInteractMoList()) do
			if slot6.nextPos then
				slot0:buildPath(slot6.posX, slot6.posY, slot6.nextPos.posX, slot6.nextPos.posY, false)
			end
		end
	end
end

function slot0.buildPath(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot6 = slot6 or YaXianGameHelper.getDirection(slot1, slot2, slot3, slot4)

	if slot1 ~= slot3 then
		slot7 = 1

		if slot3 < slot1 then
			slot7 = -1
		end

		for slot11 = slot1 + slot7, slot3 - slot7, slot7 do
			slot0:setPathItemPos(slot0:getPathItem(slot5), slot6, slot11, slot2)
		end

		slot0:setPathItemPos(slot0:getHalfPathItem(slot5), slot6, slot3, slot4)

		return
	end

	if slot2 ~= slot4 then
		slot7 = 1

		if slot4 < slot2 then
			slot7 = -1
		end

		for slot11 = slot2 + slot7, slot4 - slot7, slot7 do
			slot0:setPathItemPos(slot0:getPathItem(slot5), slot6, slot1, slot11)
		end

		slot0:setPathItemPos(slot0:getHalfPathItem(slot5), slot6, slot3, slot4)

		return
	end

	logError(string.format("build Path fail ... %s, %s, %s, %s", slot1, slot2, slot3, slot4))
end

function slot0.getPathItem(slot0, slot1)
	slot2 = nil

	if slot1 then
		slot2 = (not next(slot0.playerPathPool) or table.remove(slot0.playerPathPool)) and slot0:createPathItem(slot0.greedLinePrefab)

		table.insert(slot0.playerPathList, slot2)

		return slot2
	end

	slot2 = (not next(slot0.enemyPathPool) or table.remove(slot0.enemyPathPool)) and slot0:createPathItem(slot0.redLinePrefab)

	table.insert(slot0.enemyPathList, slot2)

	return slot2
end

function slot0.getHalfPathItem(slot0, slot1)
	slot2 = nil

	if slot1 then
		slot2 = (not next(slot0.playerHalfPathPool) or table.remove(slot0.playerHalfPathPool)) and slot0:createPathItem(slot0.greenHalfLinePrefab)

		table.insert(slot0.playerHalfPathList, slot2)

		return slot2
	end

	slot2 = (not next(slot0.enemyHalfPathPool) or table.remove(slot0.enemyHalfPathPool)) and slot0:createPathItem(slot0.redHalfLinePrefab)

	table.insert(slot0.enemyHalfPathList, slot2)

	return slot2
end

function slot0.createPathItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.clone(slot1, slot0.pathContainer)
	slot2.tr = slot2.go.transform
	slot2.goDirectionDict = {
		[YaXianGameEnum.MoveDirection.Bottom] = gohelper.findChild(slot2.go, YaXianGameEnum.DirectionName[YaXianGameEnum.MoveDirection.Bottom]),
		[YaXianGameEnum.MoveDirection.Left] = gohelper.findChild(slot2.go, YaXianGameEnum.DirectionName[YaXianGameEnum.MoveDirection.Left]),
		[YaXianGameEnum.MoveDirection.Right] = gohelper.findChild(slot2.go, YaXianGameEnum.DirectionName[YaXianGameEnum.MoveDirection.Right]),
		[YaXianGameEnum.MoveDirection.Top] = gohelper.findChild(slot2.go, YaXianGameEnum.DirectionName[YaXianGameEnum.MoveDirection.Top])
	}

	return slot2
end

function slot0.resetPathItem(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5, slot6 in pairs(YaXianGameEnum.MoveDirection) do
		gohelper.setActive(slot1.goDirectionDict[slot6], false)
	end
end

function slot0.setPathItemPos(slot0, slot1, slot2, slot3, slot4)
	slot0:resetPathItem(slot1)
	gohelper.setActive(slot1.go, true)
	gohelper.setActive(slot1.goDirectionDict[slot2], true)

	slot5, slot6, slot7 = YaXianGameHelper.calcTilePosInScene(slot3, slot4)

	transformhelper.setLocalPos(slot1.tr, slot5, slot6, slot7)
end

function slot0.recyclePlayerInteractPath(slot0)
	for slot4, slot5 in ipairs(slot0.playerPathList) do
		gohelper.setActive(slot5.go, false)
		table.insert(slot0.playerPathPool, slot5)
	end

	for slot4, slot5 in ipairs(slot0.playerHalfPathList) do
		gohelper.setActive(slot5.go, false)
		table.insert(slot0.playerHalfPathPool, slot5)
	end

	slot0.playerPathList = {}
	slot0.playerHalfPathList = {}
end

function slot0.recycleEnemyInteractPath(slot0)
	for slot4, slot5 in ipairs(slot0.enemyPathList) do
		gohelper.setActive(slot5.go, false)
		table.insert(slot0.enemyPathPool, slot5)
	end

	for slot4, slot5 in ipairs(slot0.enemyHalfPathList) do
		gohelper.setActive(slot5.go, false)
		table.insert(slot0.enemyHalfPathPool, slot5)
	end

	slot0.enemyPathList = {}
	slot0.enemyHalfPathList = {}
end

function slot0.recycleAllPath(slot0)
	slot0:recyclePlayerInteractPath()
	slot0:recycleEnemyInteractPath()
end

function slot0.resetMapView(slot0)
	slot0:recycleAllPath()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
