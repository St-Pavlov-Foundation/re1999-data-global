module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameTipAreaView", package.seeall)

slot0 = class("YaXianGameTipAreaView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.RefreshAllInteractAlertArea, slot0.refreshAllInteractArea, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.ShowCanWalkGround, slot0.refreshCanWalkGround, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.OnUpdateEffectInfo, slot0.onUpdateEffectInfo, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.DeleteInteractObj, slot0.recycleEnemyInteractTipArea, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.OnResetView, slot0.resetMapView, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.MainResLoadDone, slot0.onMainResLoadDone, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._alarmItemDict = {}
	slot0._alarmItemPool = {}
	slot0._targetPosItemDict = {}
	slot0._targetPosItemPool = {}
	slot0._canWalkItems = {}
	slot0._canWalkItemPool = {}
end

function slot0.onMainResLoadDone(slot0, slot1)
	if slot0.initResDone then
		return
	end

	slot0.loader = slot1
	slot0.sceneGo = slot0.viewContainer:getRootSceneGo()
	slot0.sceneTipContainer = UnityEngine.GameObject.New("tipAreaContainer")

	slot0.sceneTipContainer.transform:SetParent(slot0.sceneGo.transform, false)
	transformhelper.setLocalPos(slot0.sceneTipContainer.transform, 0, 0, YaXianGameEnum.ContainerOffsetZ.TipArea)

	slot0.alarmPrefab = slot0.loader:getAssetItem(YaXianGameEnum.SceneResPath.AlarmItem):GetResource()
	slot0.targetPrefab = slot0.loader:getAssetItem(YaXianGameEnum.SceneResPath.TargetItem):GetResource()
	slot0.canWalkPrefab = slot0.loader:getAssetItem(YaXianGameEnum.SceneResPath.DirItem):GetResource()
	slot0.initResDone = true
end

function slot0.onUpdateEffectInfo(slot0)
	slot0:refreshCanWalkGround(slot0.preIsShow)
end

function slot0.refreshAllInteractArea(slot0, slot1)
	for slot5, slot6 in ipairs(YaXianGameModel.instance:getInteractMoList()) do
		slot0:refreshInteractAlertArea(slot6, slot1)
		slot0:refreshTargetPosArea(slot6, slot1)
	end
end

function slot0.refreshCanWalkGround(slot0, slot1)
	slot0.preIsShow = slot1

	slot0:recycleAllCanWalkItem()

	if not YaXianGameController.instance:isSelectingPlayer() then
		return
	end

	if slot1 then
		slot2 = YaXianGameModel.instance:getPlayerInteractMo()
		slot3 = slot0:getCanWalkTargetPosDict(slot2.posX, slot2.posY)

		YaXianGameModel.instance:setCanWalkTargetPosDict(slot3)

		for slot7, slot8 in pairs(slot3) do
			slot9 = slot0:createCanWalkItem(slot8.x, slot8.y)

			gohelper.setActive(slot9.goNormal, true)
			gohelper.setActive(slot9.goCenter, false)
		end

		slot4 = slot0:createCanWalkItem(slot2.posX, slot2.posY)

		gohelper.setActive(slot4.goNormal, false)
		gohelper.setActive(slot4.goCenter, true)
	end
end

function slot0.refreshInteractAlertArea(slot0, slot1, slot2)
	slot0:recycleInteractAlertArea(slot1.id)

	if not slot2 then
		return
	end

	if slot1 and slot1.alertPosList and #slot3 > 0 then
		slot4, slot5 = nil

		for slot9, slot10 in ipairs(slot3) do
			slot4 = slot0:createAlarmGroundItem(slot10.posX, slot10.posY)

			if not slot0._alarmItemDict[slot1.id] then
				slot0._alarmItemDict[slot1.id] = {}
			end

			table.insert(slot5, slot4)
		end
	end
end

function slot0.refreshTargetPosArea(slot0, slot1, slot2)
	slot0:recycleInteractTargetPosArea(slot1.id)

	if not slot2 then
		return
	end

	if slot1.nextPos then
		slot0._targetPosItemDict[slot1.id] = slot0:createTargetPosItem(slot1.nextPos.posX, slot1.nextPos.posY)
	end
end

function slot0.getCanWalkTargetPosDict(slot0, slot1, slot2)
	slot3 = YaXianGameModel.instance:hasInVisibleEffect()
	slot5 = 0

	if YaXianGameModel.instance:hasThroughWallEffect() then
		slot5 = YaXianConfig.instance:getThroughSkillDistance()
	end

	slot6 = {}

	slot0:getMoveTargetPos(slot6, slot1, slot2, YaXianGameEnum.MoveDirection.Left, slot5, slot3)
	slot0:getMoveTargetPos(slot6, slot1, slot2, YaXianGameEnum.MoveDirection.Right, slot5, slot3)
	slot0:getMoveTargetPos(slot6, slot1, slot2, YaXianGameEnum.MoveDirection.Bottom, slot5, slot3)
	slot0:getMoveTargetPos(slot6, slot1, slot2, YaXianGameEnum.MoveDirection.Top, slot5, slot3)

	return slot6
end

function slot0.getMoveTargetPos(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7, slot8, slot9 = YaXianGameController.instance:getMoveTargetPos({
		posX = slot2,
		posY = slot3,
		moveDirection = slot4,
		throughDistance = slot5,
		isHide = slot6
	})

	if slot7 == slot2 and slot8 == slot3 then
		slot1[slot4] = nil
	else
		slot1[slot4] = {
			x = slot7,
			y = slot8,
			passedWall = slot9
		}
	end
end

function slot0.createAlarmGroundItem(slot0, slot1, slot2)
	slot3 = nil

	if #slot0._alarmItemPool > 0 then
		slot3 = slot0._alarmItemPool[slot4]
		slot0._alarmItemPool[slot4] = nil
	end

	if not slot3 then
		slot3 = slot0:getUserDataTb_()
		slot3.go = gohelper.clone(slot0.alarmPrefab, slot0.sceneTipContainer, "alarmItem")
		slot3.sceneTf = slot3.go.transform
	end

	gohelper.setActive(slot3.go, true)

	slot5, slot6, slot7 = YaXianGameHelper.calcTilePosInScene(slot1, slot2)

	transformhelper.setLocalPos(slot3.sceneTf, slot5, slot6, slot7 + YaXianGameEnum.AlertOffsetZ)

	return slot3
end

function slot0.createTargetPosItem(slot0, slot1, slot2)
	slot3 = nil

	if #slot0._targetPosItemPool > 0 then
		slot3 = table.remove(slot0._targetPosItemPool)
	end

	if not slot3 then
		slot3 = slot0:getUserDataTb_()
		slot3.go = gohelper.clone(slot0.targetPrefab, slot0.sceneTipContainer, "targetPosItem")
		slot3.sceneTf = slot3.go.transform
	end

	gohelper.setActive(slot3.go, true)

	slot5, slot6, slot7 = YaXianGameHelper.calcTilePosInScene(slot1, slot2)

	transformhelper.setLocalPos(slot3.sceneTf, slot5, slot6, slot7)

	return slot3
end

function slot0.createCanWalkItem(slot0, slot1, slot2)
	slot3 = nil

	if #slot0._canWalkItemPool > 0 then
		slot3 = slot0._canWalkItemPool[slot4]
		slot0._canWalkItemPool[slot4] = nil
	end

	if not slot3 then
		slot3 = slot0:getUserDataTb_()
		slot3.go = gohelper.clone(slot0.canWalkPrefab, slot0.sceneTipContainer, "canWalkItem")
		slot3.sceneTf = slot3.go.transform
		slot3.goCenter = gohelper.findChild(slot3.go, "#go_center")
		slot3.goNormal = gohelper.findChild(slot3.go, "#go_normal")
	end

	gohelper.setActive(slot3.go, true)

	slot5, slot6, slot7 = YaXianGameHelper.calcTilePosInScene(slot1, slot2)

	transformhelper.setLocalPos(slot3.sceneTf, slot5, slot6, slot7)
	table.insert(slot0._canWalkItems, slot3)

	return slot3
end

function slot0.recycleInteractAlertArea(slot0, slot1)
	if slot0._alarmItemDict[slot1] and #slot2 > 0 then
		for slot6 = 1, #slot2 do
			gohelper.setActive(slot2[slot6].go, false)
			table.insert(slot0._alarmItemPool, slot2[slot6])
		end

		slot2 = nil
		slot0._alarmItemDict[slot1] = nil
	end
end

function slot0.recycleInteractTargetPosArea(slot0, slot1)
	if slot0._targetPosItemDict[slot1] then
		gohelper.setActive(slot2.go, false)
		table.insert(slot0._targetPosItemPool, slot2)

		slot0._targetPosItemDict[slot1] = nil
	end
end

function slot0.recycleEnemyInteractTipArea(slot0, slot1)
	slot0:recycleInteractTargetPosArea(slot1)
	slot0:recycleInteractAlertArea(slot1)
end

function slot0.recycleAllAlarmItem(slot0)
	for slot4, slot5 in pairs(slot0._alarmItemDict) do
		for slot9 = 1, #slot5 do
			gohelper.setActive(slot5[slot9].go, false)
			table.insert(slot0._alarmItemPool, slot5[slot9])
		end

		slot5 = nil
		slot0._alarmItemDict[slot4] = nil
	end
end

function slot0.recycleAllCanWalkItem(slot0)
	for slot4, slot5 in pairs(slot0._canWalkItems) do
		gohelper.setActive(slot5.go, false)
		table.insert(slot0._canWalkItemPool, slot5)

		slot0._canWalkItems[slot4] = nil
	end
end

function slot0.recycleAllTargetPosItem(slot0)
	for slot4, slot5 in pairs(slot0._targetPosItemDict) do
		gohelper.setActive(slot5.go, false)
		table.insert(slot0._targetPosItemPool, slot5)

		slot0._targetPosItemDict[slot4] = nil
	end
end

function slot0.resetMapView(slot0)
	slot0:recycleAllAlarmItem()
	slot0:recycleAllCanWalkItem()
	slot0:recycleAllTargetPosItem()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
