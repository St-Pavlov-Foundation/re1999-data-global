module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameTipAreaView", package.seeall)

local var_0_0 = class("YaXianGameTipAreaView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.RefreshAllInteractAlertArea, arg_2_0.refreshAllInteractArea, arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.ShowCanWalkGround, arg_2_0.refreshCanWalkGround, arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.OnUpdateEffectInfo, arg_2_0.onUpdateEffectInfo, arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.DeleteInteractObj, arg_2_0.recycleEnemyInteractTipArea, arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.OnResetView, arg_2_0.resetMapView, arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.MainResLoadDone, arg_2_0.onMainResLoadDone, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._alarmItemDict = {}
	arg_4_0._alarmItemPool = {}
	arg_4_0._targetPosItemDict = {}
	arg_4_0._targetPosItemPool = {}
	arg_4_0._canWalkItems = {}
	arg_4_0._canWalkItemPool = {}
end

function var_0_0.onMainResLoadDone(arg_5_0, arg_5_1)
	if arg_5_0.initResDone then
		return
	end

	arg_5_0.loader = arg_5_1
	arg_5_0.sceneGo = arg_5_0.viewContainer:getRootSceneGo()
	arg_5_0.sceneTipContainer = UnityEngine.GameObject.New("tipAreaContainer")

	arg_5_0.sceneTipContainer.transform:SetParent(arg_5_0.sceneGo.transform, false)
	transformhelper.setLocalPos(arg_5_0.sceneTipContainer.transform, 0, 0, YaXianGameEnum.ContainerOffsetZ.TipArea)

	arg_5_0.alarmPrefab = arg_5_0.loader:getAssetItem(YaXianGameEnum.SceneResPath.AlarmItem):GetResource()
	arg_5_0.targetPrefab = arg_5_0.loader:getAssetItem(YaXianGameEnum.SceneResPath.TargetItem):GetResource()
	arg_5_0.canWalkPrefab = arg_5_0.loader:getAssetItem(YaXianGameEnum.SceneResPath.DirItem):GetResource()
	arg_5_0.initResDone = true
end

function var_0_0.onUpdateEffectInfo(arg_6_0)
	arg_6_0:refreshCanWalkGround(arg_6_0.preIsShow)
end

function var_0_0.refreshAllInteractArea(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(YaXianGameModel.instance:getInteractMoList()) do
		arg_7_0:refreshInteractAlertArea(iter_7_1, arg_7_1)
		arg_7_0:refreshTargetPosArea(iter_7_1, arg_7_1)
	end
end

function var_0_0.refreshCanWalkGround(arg_8_0, arg_8_1)
	arg_8_0.preIsShow = arg_8_1

	arg_8_0:recycleAllCanWalkItem()

	if not YaXianGameController.instance:isSelectingPlayer() then
		return
	end

	if arg_8_1 then
		local var_8_0 = YaXianGameModel.instance:getPlayerInteractMo()
		local var_8_1 = arg_8_0:getCanWalkTargetPosDict(var_8_0.posX, var_8_0.posY)

		YaXianGameModel.instance:setCanWalkTargetPosDict(var_8_1)

		for iter_8_0, iter_8_1 in pairs(var_8_1) do
			local var_8_2 = arg_8_0:createCanWalkItem(iter_8_1.x, iter_8_1.y)

			gohelper.setActive(var_8_2.goNormal, true)
			gohelper.setActive(var_8_2.goCenter, false)
		end

		local var_8_3 = arg_8_0:createCanWalkItem(var_8_0.posX, var_8_0.posY)

		gohelper.setActive(var_8_3.goNormal, false)
		gohelper.setActive(var_8_3.goCenter, true)
	end
end

function var_0_0.refreshInteractAlertArea(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:recycleInteractAlertArea(arg_9_1.id)

	if not arg_9_2 then
		return
	end

	local var_9_0 = arg_9_1 and arg_9_1.alertPosList

	if var_9_0 and #var_9_0 > 0 then
		local var_9_1
		local var_9_2

		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			local var_9_3 = arg_9_0:createAlarmGroundItem(iter_9_1.posX, iter_9_1.posY)
			local var_9_4 = arg_9_0._alarmItemDict[arg_9_1.id]

			if not var_9_4 then
				var_9_4 = {}
				arg_9_0._alarmItemDict[arg_9_1.id] = var_9_4
			end

			table.insert(var_9_4, var_9_3)
		end
	end
end

function var_0_0.refreshTargetPosArea(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:recycleInteractTargetPosArea(arg_10_1.id)

	if not arg_10_2 then
		return
	end

	if arg_10_1.nextPos then
		local var_10_0 = arg_10_0:createTargetPosItem(arg_10_1.nextPos.posX, arg_10_1.nextPos.posY)

		arg_10_0._targetPosItemDict[arg_10_1.id] = var_10_0
	end
end

function var_0_0.getCanWalkTargetPosDict(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = YaXianGameModel.instance:hasInVisibleEffect()
	local var_11_1 = YaXianGameModel.instance:hasThroughWallEffect()
	local var_11_2 = 0

	if var_11_1 then
		var_11_2 = YaXianConfig.instance:getThroughSkillDistance()
	end

	local var_11_3 = {}

	arg_11_0:getMoveTargetPos(var_11_3, arg_11_1, arg_11_2, YaXianGameEnum.MoveDirection.Left, var_11_2, var_11_0)
	arg_11_0:getMoveTargetPos(var_11_3, arg_11_1, arg_11_2, YaXianGameEnum.MoveDirection.Right, var_11_2, var_11_0)
	arg_11_0:getMoveTargetPos(var_11_3, arg_11_1, arg_11_2, YaXianGameEnum.MoveDirection.Bottom, var_11_2, var_11_0)
	arg_11_0:getMoveTargetPos(var_11_3, arg_11_1, arg_11_2, YaXianGameEnum.MoveDirection.Top, var_11_2, var_11_0)

	return var_11_3
end

function var_0_0.getMoveTargetPos(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
	local var_12_0, var_12_1, var_12_2 = YaXianGameController.instance:getMoveTargetPos({
		posX = arg_12_2,
		posY = arg_12_3,
		moveDirection = arg_12_4,
		throughDistance = arg_12_5,
		isHide = arg_12_6
	})

	if var_12_0 == arg_12_2 and var_12_1 == arg_12_3 then
		arg_12_1[arg_12_4] = nil
	else
		arg_12_1[arg_12_4] = {
			x = var_12_0,
			y = var_12_1,
			passedWall = var_12_2
		}
	end
end

function var_0_0.createAlarmGroundItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0
	local var_13_1 = #arg_13_0._alarmItemPool

	if var_13_1 > 0 then
		var_13_0 = arg_13_0._alarmItemPool[var_13_1]
		arg_13_0._alarmItemPool[var_13_1] = nil
	end

	if not var_13_0 then
		var_13_0 = arg_13_0:getUserDataTb_()
		var_13_0.go = gohelper.clone(arg_13_0.alarmPrefab, arg_13_0.sceneTipContainer, "alarmItem")
		var_13_0.sceneTf = var_13_0.go.transform
	end

	gohelper.setActive(var_13_0.go, true)

	local var_13_2, var_13_3, var_13_4 = YaXianGameHelper.calcTilePosInScene(arg_13_1, arg_13_2)

	transformhelper.setLocalPos(var_13_0.sceneTf, var_13_2, var_13_3, var_13_4 + YaXianGameEnum.AlertOffsetZ)

	return var_13_0
end

function var_0_0.createTargetPosItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0

	if #arg_14_0._targetPosItemPool > 0 then
		var_14_0 = table.remove(arg_14_0._targetPosItemPool)
	end

	if not var_14_0 then
		var_14_0 = arg_14_0:getUserDataTb_()
		var_14_0.go = gohelper.clone(arg_14_0.targetPrefab, arg_14_0.sceneTipContainer, "targetPosItem")
		var_14_0.sceneTf = var_14_0.go.transform
	end

	gohelper.setActive(var_14_0.go, true)

	local var_14_1, var_14_2, var_14_3 = YaXianGameHelper.calcTilePosInScene(arg_14_1, arg_14_2)

	transformhelper.setLocalPos(var_14_0.sceneTf, var_14_1, var_14_2, var_14_3)

	return var_14_0
end

function var_0_0.createCanWalkItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0
	local var_15_1 = #arg_15_0._canWalkItemPool

	if var_15_1 > 0 then
		var_15_0 = arg_15_0._canWalkItemPool[var_15_1]
		arg_15_0._canWalkItemPool[var_15_1] = nil
	end

	if not var_15_0 then
		var_15_0 = arg_15_0:getUserDataTb_()
		var_15_0.go = gohelper.clone(arg_15_0.canWalkPrefab, arg_15_0.sceneTipContainer, "canWalkItem")
		var_15_0.sceneTf = var_15_0.go.transform
		var_15_0.goCenter = gohelper.findChild(var_15_0.go, "#go_center")
		var_15_0.goNormal = gohelper.findChild(var_15_0.go, "#go_normal")
	end

	gohelper.setActive(var_15_0.go, true)

	local var_15_2, var_15_3, var_15_4 = YaXianGameHelper.calcTilePosInScene(arg_15_1, arg_15_2)

	transformhelper.setLocalPos(var_15_0.sceneTf, var_15_2, var_15_3, var_15_4)
	table.insert(arg_15_0._canWalkItems, var_15_0)

	return var_15_0
end

function var_0_0.recycleInteractAlertArea(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._alarmItemDict[arg_16_1]

	if var_16_0 and #var_16_0 > 0 then
		for iter_16_0 = 1, #var_16_0 do
			gohelper.setActive(var_16_0[iter_16_0].go, false)
			table.insert(arg_16_0._alarmItemPool, var_16_0[iter_16_0])
		end

		local var_16_1

		arg_16_0._alarmItemDict[arg_16_1] = nil
	end
end

function var_0_0.recycleInteractTargetPosArea(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._targetPosItemDict[arg_17_1]

	if var_17_0 then
		gohelper.setActive(var_17_0.go, false)
		table.insert(arg_17_0._targetPosItemPool, var_17_0)

		arg_17_0._targetPosItemDict[arg_17_1] = nil
	end
end

function var_0_0.recycleEnemyInteractTipArea(arg_18_0, arg_18_1)
	arg_18_0:recycleInteractTargetPosArea(arg_18_1)
	arg_18_0:recycleInteractAlertArea(arg_18_1)
end

function var_0_0.recycleAllAlarmItem(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0._alarmItemDict) do
		for iter_19_2 = 1, #iter_19_1 do
			gohelper.setActive(iter_19_1[iter_19_2].go, false)
			table.insert(arg_19_0._alarmItemPool, iter_19_1[iter_19_2])
		end

		iter_19_1 = nil
		arg_19_0._alarmItemDict[iter_19_0] = nil
	end
end

function var_0_0.recycleAllCanWalkItem(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0._canWalkItems) do
		gohelper.setActive(iter_20_1.go, false)
		table.insert(arg_20_0._canWalkItemPool, iter_20_1)

		arg_20_0._canWalkItems[iter_20_0] = nil
	end
end

function var_0_0.recycleAllTargetPosItem(arg_21_0)
	for iter_21_0, iter_21_1 in pairs(arg_21_0._targetPosItemDict) do
		gohelper.setActive(iter_21_1.go, false)
		table.insert(arg_21_0._targetPosItemPool, iter_21_1)

		arg_21_0._targetPosItemDict[iter_21_0] = nil
	end
end

function var_0_0.resetMapView(arg_22_0)
	arg_22_0:recycleAllAlarmItem()
	arg_22_0:recycleAllCanWalkItem()
	arg_22_0:recycleAllTargetPosItem()
end

function var_0_0.onClose(arg_23_0)
	return
end

function var_0_0.onDestroyView(arg_24_0)
	return
end

return var_0_0
