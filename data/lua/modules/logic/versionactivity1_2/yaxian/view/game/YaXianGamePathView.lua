module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGamePathView", package.seeall)

local var_0_0 = class("YaXianGamePathView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.RefreshInteractPath, arg_2_0.refreshInteractPath, arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.OnUpdateEffectInfo, arg_2_0.onUpdateEffectInfo, arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.OnResetView, arg_2_0.resetMapView, arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.MainResLoadDone, arg_2_0.onMainResLoadDone, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.playerPathPool = {}
	arg_4_0.playerHalfPathPool = {}
	arg_4_0.enemyPathPool = {}
	arg_4_0.enemyHalfPathPool = {}
	arg_4_0.playerPathList = {}
	arg_4_0.playerHalfPathList = {}
	arg_4_0.enemyPathList = {}
	arg_4_0.enemyHalfPathList = {}
end

function var_0_0.onMainResLoadDone(arg_5_0, arg_5_1)
	if arg_5_0.initResDone then
		return
	end

	arg_5_0.loader = arg_5_1
	arg_5_0.sceneGo = arg_5_0.viewContainer:getRootSceneGo()
	arg_5_0.pathContainer = UnityEngine.GameObject.New("pathContainer")

	arg_5_0.pathContainer.transform:SetParent(arg_5_0.sceneGo.transform, false)
	transformhelper.setLocalPos(arg_5_0.pathContainer.transform, 0, 0, YaXianGameEnum.ContainerOffsetZ.Path)

	arg_5_0.greedLinePrefab = arg_5_0.loader:getAssetItem(YaXianGameEnum.SceneResPath.GreenLine):GetResource()
	arg_5_0.redLinePrefab = arg_5_0.loader:getAssetItem(YaXianGameEnum.SceneResPath.RedLine):GetResource()
	arg_5_0.greenHalfLinePrefab = arg_5_0.loader:getAssetItem(YaXianGameEnum.SceneResPath.GreedLineHalf):GetResource()
	arg_5_0.redHalfLinePrefab = arg_5_0.loader:getAssetItem(YaXianGameEnum.SceneResPath.RedLineHalf):GetResource()
	arg_5_0.initResDone = true
end

function var_0_0.onUpdateEffectInfo(arg_6_0)
	arg_6_0:refreshInteractPath(arg_6_0.preIsShow)
end

function var_0_0.refreshInteractPath(arg_7_0, arg_7_1)
	arg_7_0.preIsShow = arg_7_1

	arg_7_0:refreshPlayerInteractPath(arg_7_1)
	arg_7_0:refreshEnemyInteractPath(arg_7_1)
end

function var_0_0.refreshPlayerInteractPath(arg_8_0, arg_8_1)
	arg_8_0:recyclePlayerInteractPath()

	if arg_8_1 then
		local var_8_0 = YaXianGameModel.instance:getPlayerInteractMo()
		local var_8_1 = YaXianGameModel.instance:getCanWalkTargetPosDict()

		for iter_8_0, iter_8_1 in pairs(var_8_1) do
			arg_8_0:buildPath(var_8_0.posX, var_8_0.posY, iter_8_1.x, iter_8_1.y, true, iter_8_0)
		end
	end
end

function var_0_0.refreshEnemyInteractPath(arg_9_0, arg_9_1)
	arg_9_0:recycleEnemyInteractPath()

	if arg_9_1 then
		for iter_9_0, iter_9_1 in ipairs(YaXianGameModel.instance:getInteractMoList()) do
			if iter_9_1.nextPos then
				arg_9_0:buildPath(iter_9_1.posX, iter_9_1.posY, iter_9_1.nextPos.posX, iter_9_1.nextPos.posY, false)
			end
		end
	end
end

function var_0_0.buildPath(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
	arg_10_6 = arg_10_6 or YaXianGameHelper.getDirection(arg_10_1, arg_10_2, arg_10_3, arg_10_4)

	if arg_10_1 ~= arg_10_3 then
		local var_10_0 = 1

		if arg_10_3 < arg_10_1 then
			var_10_0 = -1
		end

		for iter_10_0 = arg_10_1 + var_10_0, arg_10_3 - var_10_0, var_10_0 do
			local var_10_1 = arg_10_0:getPathItem(arg_10_5)

			arg_10_0:setPathItemPos(var_10_1, arg_10_6, iter_10_0, arg_10_2)
		end

		local var_10_2 = arg_10_0:getHalfPathItem(arg_10_5)

		arg_10_0:setPathItemPos(var_10_2, arg_10_6, arg_10_3, arg_10_4)

		return
	end

	if arg_10_2 ~= arg_10_4 then
		local var_10_3 = 1

		if arg_10_4 < arg_10_2 then
			var_10_3 = -1
		end

		for iter_10_1 = arg_10_2 + var_10_3, arg_10_4 - var_10_3, var_10_3 do
			local var_10_4 = arg_10_0:getPathItem(arg_10_5)

			arg_10_0:setPathItemPos(var_10_4, arg_10_6, arg_10_1, iter_10_1)
		end

		local var_10_5 = arg_10_0:getHalfPathItem(arg_10_5)

		arg_10_0:setPathItemPos(var_10_5, arg_10_6, arg_10_3, arg_10_4)

		return
	end

	logError(string.format("build Path fail ... %s, %s, %s, %s", arg_10_1, arg_10_2, arg_10_3, arg_10_4))
end

function var_0_0.getPathItem(arg_11_0, arg_11_1)
	local var_11_0

	if arg_11_1 then
		if next(arg_11_0.playerPathPool) then
			var_11_0 = table.remove(arg_11_0.playerPathPool)
		else
			var_11_0 = arg_11_0:createPathItem(arg_11_0.greedLinePrefab)
		end

		table.insert(arg_11_0.playerPathList, var_11_0)

		return var_11_0
	end

	if next(arg_11_0.enemyPathPool) then
		var_11_0 = table.remove(arg_11_0.enemyPathPool)
	else
		var_11_0 = arg_11_0:createPathItem(arg_11_0.redLinePrefab)
	end

	table.insert(arg_11_0.enemyPathList, var_11_0)

	return var_11_0
end

function var_0_0.getHalfPathItem(arg_12_0, arg_12_1)
	local var_12_0

	if arg_12_1 then
		if next(arg_12_0.playerHalfPathPool) then
			var_12_0 = table.remove(arg_12_0.playerHalfPathPool)
		else
			var_12_0 = arg_12_0:createPathItem(arg_12_0.greenHalfLinePrefab)
		end

		table.insert(arg_12_0.playerHalfPathList, var_12_0)

		return var_12_0
	end

	if next(arg_12_0.enemyHalfPathPool) then
		var_12_0 = table.remove(arg_12_0.enemyHalfPathPool)
	else
		var_12_0 = arg_12_0:createPathItem(arg_12_0.redHalfLinePrefab)
	end

	table.insert(arg_12_0.enemyHalfPathList, var_12_0)

	return var_12_0
end

function var_0_0.createPathItem(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getUserDataTb_()

	var_13_0.go = gohelper.clone(arg_13_1, arg_13_0.pathContainer)
	var_13_0.tr = var_13_0.go.transform
	var_13_0.goDirectionDict = {
		[YaXianGameEnum.MoveDirection.Bottom] = gohelper.findChild(var_13_0.go, YaXianGameEnum.DirectionName[YaXianGameEnum.MoveDirection.Bottom]),
		[YaXianGameEnum.MoveDirection.Left] = gohelper.findChild(var_13_0.go, YaXianGameEnum.DirectionName[YaXianGameEnum.MoveDirection.Left]),
		[YaXianGameEnum.MoveDirection.Right] = gohelper.findChild(var_13_0.go, YaXianGameEnum.DirectionName[YaXianGameEnum.MoveDirection.Right]),
		[YaXianGameEnum.MoveDirection.Top] = gohelper.findChild(var_13_0.go, YaXianGameEnum.DirectionName[YaXianGameEnum.MoveDirection.Top])
	}

	return var_13_0
end

function var_0_0.resetPathItem(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	for iter_14_0, iter_14_1 in pairs(YaXianGameEnum.MoveDirection) do
		gohelper.setActive(arg_14_1.goDirectionDict[iter_14_1], false)
	end
end

function var_0_0.setPathItemPos(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	arg_15_0:resetPathItem(arg_15_1)
	gohelper.setActive(arg_15_1.go, true)
	gohelper.setActive(arg_15_1.goDirectionDict[arg_15_2], true)

	local var_15_0, var_15_1, var_15_2 = YaXianGameHelper.calcTilePosInScene(arg_15_3, arg_15_4)

	transformhelper.setLocalPos(arg_15_1.tr, var_15_0, var_15_1, var_15_2)
end

function var_0_0.recyclePlayerInteractPath(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.playerPathList) do
		gohelper.setActive(iter_16_1.go, false)
		table.insert(arg_16_0.playerPathPool, iter_16_1)
	end

	for iter_16_2, iter_16_3 in ipairs(arg_16_0.playerHalfPathList) do
		gohelper.setActive(iter_16_3.go, false)
		table.insert(arg_16_0.playerHalfPathPool, iter_16_3)
	end

	arg_16_0.playerPathList = {}
	arg_16_0.playerHalfPathList = {}
end

function var_0_0.recycleEnemyInteractPath(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.enemyPathList) do
		gohelper.setActive(iter_17_1.go, false)
		table.insert(arg_17_0.enemyPathPool, iter_17_1)
	end

	for iter_17_2, iter_17_3 in ipairs(arg_17_0.enemyHalfPathList) do
		gohelper.setActive(iter_17_3.go, false)
		table.insert(arg_17_0.enemyHalfPathPool, iter_17_3)
	end

	arg_17_0.enemyPathList = {}
	arg_17_0.enemyHalfPathList = {}
end

function var_0_0.recycleAllPath(arg_18_0)
	arg_18_0:recyclePlayerInteractPath()
	arg_18_0:recycleEnemyInteractPath()
end

function var_0_0.resetMapView(arg_19_0)
	arg_19_0:recycleAllPath()
end

function var_0_0.onClose(arg_20_0)
	return
end

function var_0_0.onDestroyView(arg_21_0)
	return
end

return var_0_0
