module("modules.logic.versionactivity1_3.chess.view.game.Activity1_3ChessGameScene", package.seeall)

local var_0_0 = class("Activity1_3ChessGameScene", Va3ChessGameScene)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._btnEffect1ClickArea = gohelper.findChildButton(arg_1_0.viewGO, "btn_effect1ClickArea")
	arg_1_0._btnEffect2ClickArea = gohelper.findChildButton(arg_1_0.viewGO, "btn_effect2ClickArea")
	arg_1_0._fireTileMap = {}
	arg_1_0._sightTileMap = {}

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.ObjMoveStep, arg_2_0._onObjMove, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.ObjMoveEnd, arg_2_0._onObjMoveEnd, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.EnterNextMap, arg_2_0._onEnterNextMap, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.CurrentHpUpdate, arg_2_0._onHpUpdate, arg_2_0)
	arg_2_0:addEventCb(Activity1_3ChessGameController.instance, Activity1_3ChessEvent.UpdateGameScene, arg_2_0._onMapUpdate, arg_2_0)
	arg_2_0:addEventCb(Activity1_3ChessGameController.instance, Activity1_3ChessEvent.InitGameScene, arg_2_0._onSceneInit, arg_2_0)
	arg_2_0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.AfterResetChessGame, arg_2_0._onResetGame, arg_2_0)
	arg_2_0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.OnReadChessGame, arg_2_0._onReadGame, arg_2_0)
	arg_2_0._btnEffect1ClickArea:AddClickListener(arg_2_0._onClickEffect1, arg_2_0)
	arg_2_0._btnEffect2ClickArea:AddClickListener(arg_2_0._onClickEffect2, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(Activity1_3ChessGameController.instance, Activity1_3ChessEvent.UpdateGameScene, arg_3_0._onMapUpdate, arg_3_0)
	arg_3_0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.ObjMoveStep, arg_3_0._onObjMove, arg_3_0)
	arg_3_0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.ObjMoveEnd, arg_3_0._onObjMoveEnd, arg_3_0)
	arg_3_0:removeEventCb(Activity1_3ChessGameController.instance, Activity1_3ChessEvent.InitGameScene, arg_3_0._onSceneInit, arg_3_0)
	arg_3_0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.EnterNextMap, arg_3_0._onEnterNextMap, arg_3_0)
	arg_3_0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.CurrentHpUpdate, arg_3_0._onHpUpdate, arg_3_0)
	arg_3_0:removeEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.AfterResetChessGame, arg_3_0._onResetGame, arg_3_0)
	arg_3_0:removeEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.OnReadChessGame, arg_3_0._onReadGame, arg_3_0)
	arg_3_0._btnEffect1ClickArea:RemoveClickListener()
	arg_3_0._btnEffect2ClickArea:RemoveClickListener()
end

function var_0_0.onRefreshViewParam(arg_4_0)
	local var_4_0 = CameraMgr.instance:getMainCamera()
	local var_4_1 = CameraMgr.instance:getUnitCamera()

	var_4_1.orthographic = true
	var_4_1.orthographicSize = var_4_0.orthographicSize

	gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), true)
	gohelper.setActive(PostProcessingMgr.instance._unitPPVolume.gameObject, true)
	PostProcessingMgr.instance:setUnitActive(true)
	PostProcessingMgr.instance:setUnitPPValue("localBloomActive", false)
	PostProcessingMgr.instance:setUnitPPValue("bloomActive", false)
end

function var_0_0.initCamera(arg_5_0)
	return
end

function var_0_0.resetCamera(arg_6_0)
	return
end

function var_0_0.loadRes(arg_7_0)
	UIBlockMgr.instance:startBlock(Va3ChessGameScene.BLOCK_KEY)

	arg_7_0._loader = MultiAbLoader.New()

	arg_7_0._loader:addPath(arg_7_0:getCurrentSceneUrl())
	arg_7_0._loader:addPath(Va3ChessEnum.SceneResPath.GroundItem)
	arg_7_0._loader:addPath(Va3ChessEnum.SceneResPath.DirItem)
	arg_7_0._loader:addPath(Va3ChessEnum.SceneResPath.AlarmItem)
	arg_7_0:onLoadRes()
	arg_7_0._loader:startLoad(arg_7_0.loadResCompleted, arg_7_0)
end

function var_0_0.onLoadRes(arg_8_0)
	arg_8_0._loader:addPath(Activity1_3ChessEnum.SceneResPath.FireTile)
	arg_8_0._loader:addPath(Activity1_3ChessEnum.SceneResPath.SightTile1)
	arg_8_0._loader:addPath(Activity1_3ChessEnum.SceneResPath.SightTile2)
	arg_8_0._loader:addPath(Activity1_3ChessEnum.SceneResPath.SightTile3)
	arg_8_0._loader:addPath(Activity1_3ChessEnum.SceneResPath.SightEdgeTile)
end

function var_0_0.createAllInteractObjs(arg_9_0)
	if not Va3ChessGameController.instance.interacts then
		return
	end

	local var_9_0 = Va3ChessGameController.instance.interacts:getList()

	table.sort(var_9_0, Va3ChessInteractMgr.sortRenderOrder)

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if iter_9_1:GetIgnoreSight() then
			arg_9_0:createInteractObj(iter_9_1)
		end
	end

	arg_9_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.AllObjectCreated, arg_9_0.createAllInteractObjs, arg_9_0)
end

function var_0_0.onloadResCompleted(arg_10_0, arg_10_1)
	local var_10_0 = gohelper.findChild(arg_10_0._sceneGo, "Obj-Plant/scence_smoke")

	gohelper.setActive(var_10_0, true)

	arg_10_0._sceneSight = UnityEngine.GameObject.New("sight")

	transformhelper.setLocalPos(arg_10_0._sceneSight.transform, 0, 0, -2.5)

	arg_10_0._sceneFire = UnityEngine.GameObject.New("fire")

	transformhelper.setLocalPos(arg_10_0._sceneFire.transform, 0, 0, -1)
	arg_10_0._sceneSight.transform:SetParent(arg_10_0._sceneGo.transform, false)
	arg_10_0._sceneFire.transform:SetParent(arg_10_0._sceneGo.transform, false)

	arg_10_0._sceneEffect1 = gohelper.findChild(arg_10_0._sceneGo, "Obj-Plant/all/diffuse/vx_click_quan")
	arg_10_0._sceneEffect2 = gohelper.findChild(arg_10_0._sceneGo, "Obj-Plant/all/diffuse/vx_click_eye")

	if arg_10_0._sceneEffect1 then
		local var_10_1 = CameraMgr.instance:getUICamera()
		local var_10_2 = CameraMgr.instance:getMainCamera()
		local var_10_3 = Vector3.New()

		var_10_3.x, var_10_3.y, var_10_3.z = transformhelper.getPos(arg_10_0._sceneEffect1.transform)

		local var_10_4 = recthelper.worldPosToAnchorPos(var_10_3, arg_10_0.viewGO.transform, var_10_1, var_10_2)
		local var_10_5 = Vector3.New()

		var_10_5.x, var_10_5.y, var_10_5.z = transformhelper.getPos(arg_10_0._sceneEffect2.transform)

		local var_10_6 = recthelper.worldPosToAnchorPos(var_10_5, arg_10_0.viewGO.transform, var_10_1, var_10_2)

		arg_10_0._btnEffect1ClickArea.transform.localPosition = var_10_4
		arg_10_0._btnEffect2ClickArea.transform.localPosition = var_10_6

		gohelper.setActive(arg_10_0._sceneEffect1, false)
		gohelper.setActive(arg_10_0._sceneEffect2, false)
	else
		gohelper.setActive(arg_10_0._btnEffect1ClickArea.gameObject, false)
		gohelper.setActive(arg_10_0._btnEffect2ClickArea.gameObject, false)
	end

	arg_10_0:_onSceneInit()
end

function var_0_0._onSceneInit(arg_11_0)
	arg_11_0:removeFireTiles()
	arg_11_0:removeSightTiles()

	local var_11_0 = Activity122Model.instance:getCurEpisodeSightMap()

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		local var_11_1, var_11_2 = Va3ChessMapUtils.calPosXY(iter_11_0)

		arg_11_0:createSightTileItem(var_11_1, var_11_2)

		local var_11_3, var_11_4 = Va3ChessGameController.instance:searchInteractByPos(var_11_1, var_11_2)

		if var_11_3 == 1 then
			local var_11_5 = var_11_4

			if var_11_5 then
				arg_11_0:createInteractObj(var_11_5)
			end
		elseif var_11_3 > 1 then
			local var_11_6 = var_11_4

			for iter_11_2, iter_11_3 in pairs(var_11_6) do
				arg_11_0:createInteractObj(iter_11_3)
			end
		end
	end

	local var_11_7 = Activity122Model.instance:getCurEpisodeFireMap()

	for iter_11_4, iter_11_5 in pairs(var_11_7) do
		local var_11_8, var_11_9 = Va3ChessMapUtils.calPosXY(iter_11_4)

		arg_11_0:createFireTileItem(var_11_8, var_11_9)
	end

	local var_11_10 = Va3ChessGameModel.instance:getMapId()

	Activity1_3ChessGameController.instance:dispatchEvent(Activity1_3ChessEvent.GameSceneInited, var_11_10)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameViewOpened, arg_11_0.viewParam)
end

function var_0_0.onOpenFinish(arg_12_0)
	return
end

function var_0_0.onChessStateUpdate(arg_13_0, arg_13_1)
	var_0_0.super.onChessStateUpdate(arg_13_0)

	if arg_13_1 == Va3ChessEnum.GameEventType.Normal then
		-- block empty
	end
end

function var_0_0._onMapUpdate(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.addFires
	local var_14_1 = false

	if var_14_0 then
		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			arg_14_0:createFireTileItem(iter_14_1.x, iter_14_1.y)

			var_14_1 = true
		end
	end

	if var_14_1 then
		AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.FireSpread)
	end

	local var_14_2 = arg_14_1.removeFires

	if var_14_2 then
		for iter_14_2, iter_14_3 in ipairs(var_14_2) do
			arg_14_0:hideFireTileItem(iter_14_3.x, iter_14_3.y)
		end
	end

	local var_14_3 = arg_14_1.addSights

	if var_14_3 then
		for iter_14_4, iter_14_5 in ipairs(var_14_3) do
			arg_14_0:createSightTileItem(iter_14_5.x, iter_14_5.y)

			local var_14_4, var_14_5 = Va3ChessGameController.instance:searchInteractByPos(iter_14_5.x, iter_14_5.y)

			if var_14_4 == 1 then
				local var_14_6 = var_14_4 == 1 and var_14_5[1] or var_14_5

				if var_14_6 and not arg_14_0._avatarMap[var_14_6.id] then
					arg_14_0:createInteractObj(var_14_6)
				end
			elseif var_14_4 > 1 then
				for iter_14_6, iter_14_7 in pairs(var_14_5) do
					if not arg_14_0._avatarMap[iter_14_7.id] then
						arg_14_0:createInteractObj(iter_14_7)
					end
				end
			end
		end
	end
end

function var_0_0._onObjMove(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = Va3ChessMapUtils.calPosIndex(arg_15_2, arg_15_3)

	if not Activity122Model.instance:checkPosIndexInSight(var_15_0) then
		return
	end

	if arg_15_0._avatarMap[arg_15_1] then
		Va3ChessGameController.instance.interacts:get(arg_15_1):getHandler():setAlertActive(true)
		gohelper.setActive(arg_15_0._avatarMap[arg_15_1].sceneGo, true)

		return
	end

	local var_15_1 = Va3ChessGameController.instance.interacts:get(arg_15_1)

	arg_15_0:createInteractObj(var_15_1)
end

function var_0_0._onObjMoveEnd(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = Va3ChessMapUtils.calPosIndex(arg_16_2, arg_16_3)

	if not Activity122Model.instance:checkPosIndexInSight(var_16_0) then
		if not arg_16_0._avatarMap[arg_16_1] then
			return
		end

		gohelper.setActive(arg_16_0._avatarMap[arg_16_1].sceneGo, false)
		Va3ChessGameController.instance.interacts:get(arg_16_1):getHandler():setAlertActive(false)
	end
end

function var_0_0._onHpUpdate(arg_17_0)
	local var_17_0 = Va3ChessGameController.instance.interacts:getMainPlayer()

	if var_17_0 and var_17_0:getHandler() then
		var_17_0:getHandler():showHitAni()
	end
end

function var_0_0._onClickEffect1(arg_18_0)
	if not arg_18_0._sceneEffect1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.DrumHit)
	gohelper.setActive(arg_18_0._sceneEffect1, false)
	gohelper.setActive(arg_18_0._sceneEffect1, true)
end

function var_0_0._onClickEffect2(arg_19_0)
	if not arg_19_0._sceneEffect2 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.MonsterCroaking)
	gohelper.setActive(arg_19_0._sceneEffect2, false)
	gohelper.setActive(arg_19_0._sceneEffect2, true)
end

function var_0_0.createFireTileItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0
	local var_20_1 = Va3ChessMapUtils.calPosIndex(arg_20_1, arg_20_2)

	if arg_20_0._fireTileMap[var_20_1] then
		var_20_0 = arg_20_0._fireTileMap[var_20_1]
	end

	if not var_20_0 then
		var_20_0 = arg_20_0:getUserDataTb_()

		local var_20_2 = arg_20_0._loader:getAssetItem(Activity1_3ChessEnum.SceneResPath.FireTile)
		local var_20_3 = gohelper.clone(var_20_2:GetResource(), arg_20_0._sceneFire, "fireTile" .. arg_20_1 .. "_" .. arg_20_2)

		var_20_0.go = var_20_3
		var_20_0.sceneTf = var_20_3.transform
		arg_20_0._fireTileMap[var_20_1] = var_20_0

		Activity1_3ChessGameController.instance:dispatchEvent(Activity1_3ChessEvent.GameSceneFireCreated, var_20_1)
	end

	gohelper.setActive(var_20_0.go, true)
	arg_20_0:setTileBasePosition(var_20_0, arg_20_1, arg_20_2)

	return var_20_0
end

function var_0_0.hideFireTileItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = Va3ChessMapUtils.calPosIndex(arg_21_1, arg_21_2)

	if arg_21_0._fireTileMap[var_21_0] then
		gohelper.setActive(arg_21_0._fireTileMap[var_21_0].go, false)
	end
end

function var_0_0.removeFireTiles(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0._fireTileMap) do
		UnityEngine.GameObject.Destroy(iter_22_1.go)

		iter_22_1.sceneTf = nil
	end

	arg_22_0._fireTileMap = {}
end

function var_0_0.createSightTileItem(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0
	local var_23_1 = Va3ChessMapUtils.calPosIndex(arg_23_1, arg_23_2)

	if arg_23_0._sightTileMap[var_23_1] then
		var_23_0 = arg_23_0._sightTileMap[var_23_1]
	end

	if not var_23_0 then
		local var_23_2 = Va3ChessMapUtils.IsEdgeTile(arg_23_1, arg_23_2)

		var_23_0 = arg_23_0:getUserDataTb_()

		local var_23_3

		if var_23_2 then
			var_23_3 = arg_23_0._loader:getAssetItem(Activity1_3ChessEnum.SceneResPath.SightEdgeTile)
		else
			local var_23_4 = math.random(3)

			var_23_3 = arg_23_0._loader:getAssetItem(Activity1_3ChessEnum.SceneResPath["SightTile" .. var_23_4])
		end

		local var_23_5 = gohelper.clone(var_23_3:GetResource(), arg_23_0._sceneSight, "sightTile" .. arg_23_1 .. "_" .. arg_23_2)

		var_23_0.go = var_23_5
		var_23_0.sceneTf = var_23_5.transform
		arg_23_0._sightTileMap[var_23_1] = var_23_0
	end

	gohelper.setActive(var_23_0.go, true)
	arg_23_0:setTileBasePosition(var_23_0, arg_23_1, arg_23_2)

	return var_23_0
end

function var_0_0.hideSightTileItem(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = Va3ChessMapUtils.calPosIndex(arg_24_1, arg_24_2)

	if arg_24_0._sightTileMap[var_24_0] then
		gohelper.setActive(arg_24_0._sightTileMap[var_24_0].go, false)
	end
end

function var_0_0.removeSightTiles(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0._sightTileMap) do
		UnityEngine.GameObject.Destroy(iter_25_1.go)

		iter_25_1.sceneTf = nil
	end

	arg_25_0._sightTileMap = {}
end

function var_0_0._onResetGame(arg_26_0)
	arg_26_0:resetTiles()
	Va3ChessGameController.instance:setSelectObj(nil)
	Va3ChessGameController.instance:autoSelectPlayer()
end

function var_0_0._onReadGame(arg_27_0)
	arg_27_0:resetTiles()
	Va3ChessGameController.instance:setSelectObj(nil)
	Va3ChessGameController.instance:autoSelectPlayer()
end

function var_0_0._onEnterNextMap(arg_28_0)
	arg_28_0:resetTiles()
	Va3ChessGameController.instance:setSelectObj(nil)
	Va3ChessGameController.instance:autoSelectPlayer()
end

function var_0_0.handleResetByResult(arg_29_0)
	arg_29_0:removeFireTiles()
	arg_29_0:removeSightTiles()
	arg_29_0:resetTiles()
	var_0_0.super.handleResetByResult(arg_29_0)
end

function var_0_0.onDestroyView(arg_30_0)
	arg_30_0:removeFireTiles()
	arg_30_0:removeSightTiles()
	arg_30_0:removeEvents()
	var_0_0.super.onDestroyView(arg_30_0)
end

return var_0_0
