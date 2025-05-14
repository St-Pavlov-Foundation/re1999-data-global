module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaGameScene", package.seeall)

local var_0_0 = class("JiaLaBoNaGameScene", Va3ChessGameScene)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._posuiGroundTbList = {}

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.resetCamera(arg_3_0)
	if not ViewMgr.instance:isOpen(ViewName.JiaLaBoNaMapView) then
		var_0_0.super.resetCamera(arg_3_0)
	end
end

function var_0_0._getGroundItemUrlList(arg_4_0)
	local var_4_0 = Va3ChessGameModel.instance:getMapId()
	local var_4_1 = Va3ChessGameModel.instance:getActId()

	if arg_4_0._groundItemUrlList and arg_4_0._lastActId == var_4_1 and arg_4_0._lastMapId == var_4_0 then
		return arg_4_0._groundItemUrlList
	end

	arg_4_0._lastActId = var_4_1
	arg_4_0._lastMapId = var_4_0
	arg_4_0._groundItemUrlList = {}

	local var_4_2 = Va3ChessConfig.instance:getMapCo(var_4_1, var_4_0)

	if var_4_2 and var_4_2.groundItems and not string.nilorempty(var_4_2.groundItems) then
		local var_4_3 = string.split(var_4_2.groundItems, "#")

		if var_4_3 and #var_4_3 > 0 then
			for iter_4_0, iter_4_1 in ipairs(var_4_3) do
				if not string.nilorempty(iter_4_1) then
					table.insert(arg_4_0._groundItemUrlList, string.format(Va3ChessEnum.SceneResPath.AvatarItemPath, iter_4_1))
				end
			end
		end
	end

	if #arg_4_0._groundItemUrlList < 1 then
		table.insert(arg_4_0._groundItemUrlList, Va3ChessEnum.SceneResPath.GroundItem)
	end

	return arg_4_0._groundItemUrlList
end

function var_0_0.onLoadRes(arg_5_0)
	local var_5_0 = arg_5_0:_getGroundItemUrlList()

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		arg_5_0._loader:addPath(iter_5_1)
	end

	arg_5_0._loader:addPath(JiaLaBoNaEnum.SceneResPath.GroundPoSui)
end

function var_0_0.getGroundItemUrl(arg_6_0)
	local var_6_0 = arg_6_0:_getGroundItemUrlList()

	if var_6_0 and #var_6_0 > 0 then
		return var_6_0[math.random(1, #var_6_0)]
	end

	return Va3ChessEnum.SceneResPath.GroundItem
end

function var_0_0._initEventCb(arg_7_0)
	if arg_7_0._isFinshInitEventCb then
		return
	end

	arg_7_0._isFinshInitEventCb = true

	arg_7_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.EnterNextMap, arg_7_0._onEnterNextMap, arg_7_0)
	arg_7_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.TilePosuiTrigger, arg_7_0._onTilePosuiTrigger, arg_7_0)
	arg_7_0:addEventCb(JiaLaBoNaController.instance, JiaLaBoNaEvent.GamePointReturn, arg_7_0._onGamePointReturn, arg_7_0)
	arg_7_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameMapDataUpdate, arg_7_0.onGameDataUpdate, arg_7_0)
	var_0_0.super.addEvents(arg_7_0)
end

function var_0_0._onEnterNextMap(arg_8_0)
	arg_8_0:_checkLoadMapScene()
	arg_8_0:resetTiles()
	Va3ChessGameController.instance:setSelectObj(nil)
	Va3ChessGameController.instance:autoSelectPlayer()
end

function var_0_0._onGamePointReturn(arg_9_0)
	arg_9_0:_checkLoadMapScene()
	arg_9_0:resetTiles()
	Va3ChessGameController.instance:setSelectObj(nil)
	Va3ChessGameController.instance:autoSelectPlayer()
end

function var_0_0._checkLoadMapScene(arg_10_0)
	local var_10_0 = arg_10_0:getCurrentSceneUrl()

	if arg_10_0._currentSceneResPath ~= var_10_0 then
		UIBlockMgr.instance:startBlock(Va3ChessGameScene.BLOCK_KEY)
		arg_10_0._loader:addPath(var_10_0)
		arg_10_0._loader:startLoad(arg_10_0.loadResCompleted, arg_10_0)
	else
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Finish)
	end
end

function var_0_0.loadResCompleted(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._sceneGo

	arg_11_0._currentSceneResPath = arg_11_0:getCurrentSceneUrl()

	var_0_0.super.loadResCompleted(arg_11_0, arg_11_1)

	if var_11_0 then
		gohelper.destroy(var_11_0)
	end

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Finish)
	arg_11_0:_initEventCb()
end

function var_0_0.onResetGame(arg_12_0)
	arg_12_0:_resetMapId()
	arg_12_0:_checkLoadMapScene()
	var_0_0.super.onResetGame(arg_12_0)
end

function var_0_0.handleResetByResult(arg_13_0)
	arg_13_0:_resetMapId()
	arg_13_0:_checkLoadMapScene()
	arg_13_0:resetTiles()
	var_0_0.super.handleResetByResult(arg_13_0)
end

function var_0_0.fillChessBoardBase(arg_14_0)
	var_0_0.super.fillChessBoardBase(arg_14_0)

	local var_14_0 = Va3ChessGameModel.instance
	local var_14_1, var_14_2 = var_14_0:getGameSize()
	local var_14_3 = 0

	for iter_14_0 = 1, var_14_1 do
		for iter_14_1 = 1, var_14_2 do
			local var_14_4 = var_14_0:getTileMO(iter_14_0 - 1, iter_14_1 - 1)

			if var_14_4 and var_14_4:isHasTrigger(Va3ChessEnum.TileTrigger.PoSui) then
				var_14_3 = var_14_3 + 1

				if var_14_3 >= #arg_14_0._posuiGroundTbList then
					table.insert(arg_14_0._posuiGroundTbList, arg_14_0:_cratePosuiItemTb())
				end

				local var_14_5 = arg_14_0._posuiGroundTbList[var_14_3]

				var_14_5.posX = iter_14_0 - 1
				var_14_5.posY = iter_14_1 - 1

				arg_14_0:setTileBasePosition(var_14_5, var_14_5.posX, var_14_5.posY)
				arg_14_0:_updatePosuiItemTb(var_14_5, var_14_4)

				local var_14_6 = arg_14_0:getBaseTile(var_14_5.posX, var_14_5.posY)

				if var_14_6 then
					gohelper.setActive(var_14_6.go, false)
				end
			end
		end
	end

	for iter_14_2 = var_14_3 + 1, #arg_14_0._posuiGroundTbList do
		local var_14_7 = arg_14_0._posuiGroundTbList[iter_14_2]

		var_14_7.posX = -1
		var_14_7.posY = -1

		arg_14_0:_updatePosuiItemTb(var_14_7)
	end
end

function var_0_0._cratePosuiItemTb(arg_15_0)
	local var_15_0 = arg_15_0:getUserDataTb_()
	local var_15_1 = arg_15_0._loader:getAssetItem(JiaLaBoNaEnum.SceneResPath.GroundPoSui)
	local var_15_2 = gohelper.clone(var_15_1:GetResource(), arg_15_0._sceneBackground, "posui")

	var_15_0.go = var_15_2
	var_15_0.sceneTf = var_15_2.transform
	var_15_0.animName = nil
	var_15_0.animator = var_15_2:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)

	return var_15_0
end

function var_0_0.getPosuiItem(arg_16_0, arg_16_1, arg_16_2)
	for iter_16_0 = 1, #arg_16_0._posuiGroundTbList do
		local var_16_0 = arg_16_0._posuiGroundTbList[iter_16_0]

		if var_16_0.posX == arg_16_1 and var_16_0.posY == arg_16_2 then
			return var_16_0
		end
	end
end

function var_0_0._onTilePosuiTrigger(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0:getPosuiItem(arg_17_1, arg_17_2)
	local var_17_1 = Va3ChessGameModel.instance:getTileMO(arg_17_1, arg_17_2)

	arg_17_0:_updatePosuiItemTb(var_17_0, var_17_1, true)
end

function var_0_0._updatePosuiItemTb(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if not arg_18_1 then
		return
	end

	if arg_18_2 and arg_18_2:isHasTrigger(Va3ChessEnum.TileTrigger.PoSui) then
		gohelper.setActive(arg_18_1.go, true)

		local var_18_0 = arg_18_2:isFinishTrigger(Va3ChessEnum.TileTrigger.PoSui)
		local var_18_1 = var_18_0 and "close" or "idle"

		if arg_18_3 or var_18_1 ~= arg_18_1.animName then
			arg_18_1.animName = var_18_1

			arg_18_1.animator:Play(var_18_1, 0, arg_18_3 and 0 or 1)
		end

		if arg_18_3 and var_18_0 then
			AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_glass_broken)
		end
	else
		arg_18_1.animName = nil

		gohelper.setActive(arg_18_1.go, false)
	end
end

function var_0_0._resetMapId(arg_19_0)
	Va3ChessGameModel.instance:initData(Va3ChessModel.instance:getActId(), Va3ChessModel.instance:getMapId())
end

function var_0_0.loadRes(arg_20_0)
	UIBlockMgr.instance:startBlock(Va3ChessGameScene.BLOCK_KEY)

	arg_20_0._loader = MultiAbLoader.New()

	arg_20_0._loader:addPath(arg_20_0:getCurrentSceneUrl())
	arg_20_0._loader:addPath(arg_20_0:getGroundItemUrl())
	arg_20_0._loader:addPath(Va3ChessEnum.SceneResPath.DirItem)
	arg_20_0._loader:addPath(Va3ChessEnum.SceneResPath.AlarmItem)
	arg_20_0:onLoadRes()
	arg_20_0._loader:startLoad(arg_20_0.loadResCompleted, arg_20_0)
end

return var_0_0
