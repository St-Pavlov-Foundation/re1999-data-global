module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaOperView", package.seeall)

local var_0_0 = class("TianShiNaNaOperView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnBack = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_back")
	arg_1_0._gofull = gohelper.findChild(arg_1_0.viewGO, "#go_full")
	arg_1_0._clickFull = gohelper.findChildClick(arg_1_0.viewGO, "#go_full")
	arg_1_0._btnEndRotate = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_endrotate")
end

function var_0_0.addEvents(arg_2_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.ResetScene, arg_2_0.onSceneReset, arg_2_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.LoadLevelFinish, arg_2_0.onLevelLoadFinish, arg_2_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.OnFlowEnd, arg_2_0.onFlowEnd, arg_2_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.RoundFail, arg_2_0.onRoundFail, arg_2_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.StatuChange, arg_2_0._onStatuChange, arg_2_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.RoundUpdate, arg_2_0._onRoundChange, arg_2_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.GuideClickNode, arg_2_0._onGuideClickNode, arg_2_0)
	arg_2_0._btnBack:AddClickListener(arg_2_0._onBackClick, arg_2_0)
	arg_2_0._clickFull:AddClickListener(arg_2_0._onClickFull, arg_2_0)
	arg_2_0._btnEndRotate:AddClickListener(arg_2_0._onEndRotate, arg_2_0)
	CommonDragHelper.instance:registerDragObj(arg_2_0._gofull, nil, arg_2_0._onDrag, arg_2_0._onEndDrag, arg_2_0._checkLockDrag, arg_2_0, nil, true)
end

function var_0_0.removeEvents(arg_3_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.ResetScene, arg_3_0.onSceneReset, arg_3_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.LoadLevelFinish, arg_3_0.onLevelLoadFinish, arg_3_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.OnFlowEnd, arg_3_0.onFlowEnd, arg_3_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.RoundFail, arg_3_0.onRoundFail, arg_3_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.StatuChange, arg_3_0._onStatuChange, arg_3_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.RoundUpdate, arg_3_0._onRoundChange, arg_3_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.GuideClickNode, arg_3_0._onGuideClickNode, arg_3_0)
	arg_3_0._btnBack:RemoveClickListener()
	arg_3_0._clickFull:RemoveClickListener()
	arg_3_0._btnEndRotate:RemoveClickListener()
	CommonDragHelper.instance:unregisterDragObj(arg_3_0._gofull)
end

function var_0_0.onLevelLoadFinish(arg_4_0, arg_4_1)
	TianShiNaNaModel.instance.sceneLevelLoadFinish = true
	arg_4_0._cubeContainer = gohelper.create3d(arg_4_1.transform.parent.gameObject, "CubeContainer")
	arg_4_0._placeContainer = gohelper.create3d(arg_4_1.transform.parent.gameObject, "PlaceContainer")
	arg_4_0._effectContainer = gohelper.create3d(arg_4_1.transform.parent.gameObject, "EffectContainer")

	TianShiNaNaEffectPool.instance:setRoot(arg_4_0._effectContainer)

	local var_4_0 = arg_4_0._cubeContainer.transform

	transformhelper.setLocalPos(var_4_0, 0, 1.113595, -4.8425)
	transformhelper.setLocalRotation(var_4_0, 152.637, 52.768, 31.166)
	transformhelper.setLocalScale(var_4_0, 1.5, -1.5, -1.5)

	if TianShiNaNaModel.instance.waitStartFlow then
		TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.DoStep)
		TianShiNaNaController.instance:checkBeginFlow()
	else
		arg_4_0:beginSelectDir()
	end

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.EnterMapAndInitDone, tostring(TianShiNaNaModel.instance.episodeCo.id))
end

function var_0_0.onSceneReset(arg_5_0)
	if TianShiNaNaModel.instance.waitStartFlow then
		arg_5_0:clearCubes()
		TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.DoStep)
		TianShiNaNaController.instance:checkBeginFlow()

		return
	end

	local var_5_0 = TianShiNaNaModel.instance.curOperList

	if #var_5_0 == 0 then
		arg_5_0:beginSelectDir()
	else
		arg_5_0:clearCubes()

		arg_5_0.cube = arg_5_0:_placeCubes(var_5_0[1], TianShiNaNaModel.instance:getNextCubeType())

		arg_5_0:setCurOperCube(var_5_0[1], arg_5_0.cube)

		local var_5_1 = #var_5_0

		for iter_5_0 = 2, var_5_1 do
			local var_5_2 = var_5_0[iter_5_0]

			arg_5_0.cube:doRotate(var_5_2)
			arg_5_0:markOpers(var_5_2)

			if iter_5_0 == 4 and var_5_1 == 5 then
				local var_5_3 = arg_5_0.cube:getOperDownIndex(var_5_0[5])

				if not arg_5_0._finishIndex[7 - var_5_3] then
					table.remove(var_5_0)

					break
				end
			end

			if iter_5_0 == 5 and var_5_1 == 6 then
				table.remove(var_5_0)

				break
			end
		end
	end
end

function var_0_0._onStatuChange(arg_6_0, arg_6_1, arg_6_2)
	gohelper.setActive(arg_6_0._btnEndRotate, arg_6_2 == TianShiNaNaEnum.CurState.Rotate)

	if arg_6_1 == TianShiNaNaEnum.CurState.SelectDir and arg_6_2 == TianShiNaNaEnum.CurState.DoStep then
		arg_6_0:clearCubes()
	end
end

function var_0_0._onRoundChange(arg_7_0)
	if TianShiNaNaModel.instance:isWaitClick() then
		arg_7_0:clearCubes(true)
		gohelper.setActive(arg_7_0._btnEndRotate, true)
	end
end

function var_0_0._onBackClick(arg_8_0)
	if TianShiNaNaHelper.isBanOper() then
		return
	end

	local var_8_0 = TianShiNaNaModel.instance:getState()

	if var_8_0 == TianShiNaNaEnum.CurState.SelectDir or TianShiNaNaModel.instance:isWaitClick() then
		Activity167Rpc.instance:sendAct167RollbackRequest(VersionActivity2_2Enum.ActivityId.TianShiNaNa, TianShiNaNaModel.instance.episodeCo.id)
	elseif var_8_0 == TianShiNaNaEnum.CurState.Rotate then
		if arg_8_0:_checkLockDrag() then
			return
		end

		local var_8_1 = TianShiNaNaModel.instance.curOperList

		if #var_8_1 <= 1 then
			arg_8_0:beginSelectDir()
		else
			local var_8_2 = table.remove(var_8_1)

			arg_8_0:rollbackOper(var_8_2)
		end
	end
end

function var_0_0.rollbackOper(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.cube:getCurDownIndex()

	arg_9_0.cube:revertPlane(var_9_0)
	arg_9_0.cube:doRotate(-arg_9_1)

	arg_9_0._isErrorOper = true
	arg_9_0._dragValue = 1
	arg_9_0._nowOper = arg_9_1
	arg_9_0._finishIndex[var_9_0] = nil

	arg_9_0:_doOperTween()
end

function var_0_0.beginSelectDir(arg_10_0)
	arg_10_0:clearCubes()
	TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.SelectDir)

	local var_10_0 = TianShiNaNaModel.instance:getHeroMo()
	local var_10_1 = TianShiNaNaModel.instance:getNextCubeType()

	if not var_10_1 then
		logError("没有方块了？？？")

		return
	end

	arg_10_0._nowCubeType = var_10_1

	local var_10_2 = TianShiNaNaHelper.getCanOperDirs(var_10_0, var_10_1)

	if not next(var_10_2) then
		TianShiNaNaModel.instance.curOperList = {}
		arg_10_0._finishIndex = {}

		TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.Rotate)
	else
		arg_10_0._placeEntity = TianShiNaNaPlaceEntity.Create(var_10_0.x, var_10_0.y, var_10_2, var_10_1, arg_10_0._placeContainer)
	end
end

function var_0_0._placeCubes(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = TianShiNaNaModel.instance:getHeroMo()
	local var_11_1 = var_11_0.x
	local var_11_2 = var_11_0.y

	if arg_11_2 == TianShiNaNaEnum.CubeType.Type1 then
		local var_11_3 = TianShiNaNaHelper.getOperOffset(arg_11_1)

		var_11_1 = var_11_1 + var_11_3.x
		var_11_2 = var_11_2 + var_11_3.y
	end

	local var_11_4 = TianShiNaNaCubeEntity.Create(var_11_1, var_11_2, arg_11_0._cubeContainer)

	if arg_11_2 == TianShiNaNaEnum.CubeType.Type2 then
		var_11_4:doRotate(arg_11_1)
	end

	return var_11_4
end

function var_0_0._onClickFull(arg_12_0, arg_12_1)
	local var_12_0 = TianShiNaNaModel.instance:getState()

	if var_12_0 == TianShiNaNaEnum.CurState.SelectDir then
		local var_12_1 = arg_12_1 or TianShiNaNaHelper.getClickNodePos()
		local var_12_2 = arg_12_0._placeEntity:getClickDir(var_12_1)

		if var_12_2 then
			local var_12_3 = TianShiNaNaModel.instance:getNextCubeType()
			local var_12_4 = arg_12_0:_placeCubes(var_12_2, var_12_3)

			var_12_4:playOpenAnim(var_12_3)
			arg_12_0:setCurOperCube(var_12_2, var_12_4)
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.play_ui_youyu_deploy)
		end
	elseif var_12_0 == TianShiNaNaEnum.CurState.Rotate and not arg_12_0._nowOper and not arg_12_0:_checkLockDrag() then
		local var_12_5 = arg_12_1 or TianShiNaNaHelper.getClickNodePos()

		for iter_12_0, iter_12_1 in pairs(TianShiNaNaEnum.OperDir) do
			local var_12_6 = arg_12_0.cube:getOperGrids(iter_12_1)
			local var_12_7 = arg_12_0.cube:getOperDownIndex(iter_12_1)

			if not arg_12_0._finishIndex[var_12_7] and TianShiNaNaHelper.havePos(var_12_6, var_12_5) and arg_12_0:checkCanOper(iter_12_1, var_12_6) then
				arg_12_0._dragValue = 0
				arg_12_0._nowOper = iter_12_1

				if tabletool.len(arg_12_0._finishIndex) == 4 and not arg_12_0._finishIndex[7 - var_12_7] then
					arg_12_0._hidePlanIndex = 7 - var_12_7

					local var_12_8 = arg_12_0.cube:getPlaneByIndex(arg_12_0._hidePlanIndex)

					gohelper.setActive(var_12_8, false)
				end

				arg_12_0:_doOperTween(true)

				return
			elseif arg_12_0._finishIndex[var_12_7] and TianShiNaNaHelper.havePos(var_12_6, var_12_5) then
				local var_12_9 = TianShiNaNaModel.instance.curOperList

				if (#var_12_9 > 1 and var_12_9[#var_12_9]) == -iter_12_1 then
					arg_12_0._dragValue = 0
					arg_12_0._nowOper = iter_12_1

					local var_12_10 = arg_12_0.cube:getCurDownIndex()

					arg_12_0.cube:revertPlane(var_12_10)
					arg_12_0:_doOperTween(true)

					return
				end
			end
		end
	end
end

function var_0_0._onGuideClickNode(arg_13_0, arg_13_1)
	local var_13_0 = string.splitToNumber(arg_13_1, ",")
	local var_13_1 = {
		x = var_13_0[1],
		y = var_13_0[2]
	}

	arg_13_0:_onClickFull(var_13_1)
end

function var_0_0.setCurOperCube(arg_14_0, arg_14_1, arg_14_2)
	TianShiNaNaModel.instance.curOperList = {}
	arg_14_0._finishIndex = {}
	arg_14_0.cube = arg_14_2

	if arg_14_0._placeEntity then
		arg_14_0._placeEntity:dispose()

		arg_14_0._placeEntity = nil
	end

	TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.Rotate)
	arg_14_0:markOpers(arg_14_1)
end

function var_0_0._onEndRotate(arg_15_0)
	if TianShiNaNaHelper.isBanOper() then
		return
	end

	if TianShiNaNaModel.instance:isWaitClick() then
		gohelper.setActive(arg_15_0._btnEndRotate, false)

		TianShiNaNaModel.instance.waitClickJump = false

		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.WaitClickJumpRound)

		return
	end

	if TianShiNaNaModel.instance:getState() ~= TianShiNaNaEnum.CurState.Rotate then
		return
	end

	if arg_15_0._tweenId then
		return
	end

	if arg_15_0.cube then
		local var_15_0 = arg_15_0.cube:getCurGrids()
		local var_15_1 = 0

		if tabletool.len(arg_15_0._finishIndex) == 6 then
			var_15_1 = 0.2
		end

		for iter_15_0, iter_15_1 in pairs(var_15_0) do
			TianShiNaNaEffectPool.instance:getFromPool(iter_15_1.x, iter_15_1.y, 1, var_15_1, 0.2)
		end

		arg_15_0.cube:hideOtherPlane()
	end

	TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.DoStep)
	Activity167Rpc.instance:sendAct167BeginRoundRequest(VersionActivity2_2Enum.ActivityId.TianShiNaNa, TianShiNaNaModel.instance.episodeCo.id, TianShiNaNaModel.instance.curOperList)

	TianShiNaNaModel.instance.curOperList = {}
end

function var_0_0.onFlowEnd(arg_16_0, arg_16_1)
	if not arg_16_1 then
		return
	end

	arg_16_0:beginSelectDir()
end

function var_0_0.onRoundFail(arg_17_0)
	arg_17_0:beginSelectDir()
end

function var_0_0.clearCubes(arg_18_0, arg_18_1)
	if not arg_18_1 then
		TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.None)
	end

	if arg_18_0.cube then
		gohelper.destroy(arg_18_0.cube.go)
	end

	if arg_18_0._placeEntity then
		arg_18_0._placeEntity:dispose()

		arg_18_0._placeEntity = nil
	end
end

function var_0_0.onClose(arg_19_0)
	TianShiNaNaModel.instance.sceneLevelLoadFinish = false

	arg_19_0:clearCubes()

	if arg_19_0._tweenId then
		ZProj.TweenHelper.KillById(arg_19_0._tweenId)

		arg_19_0._tweenId = nil
	end

	TianShiNaNaEffectPool.instance:clear()
end

function var_0_0._checkLockDrag(arg_20_0)
	return arg_20_0._tweenId or not arg_20_0.cube or TianShiNaNaModel.instance:getState() ~= TianShiNaNaEnum.CurState.Rotate
end

function var_0_0._onDrag(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_2.position
	local var_21_1 = arg_21_2.pressPosition
	local var_21_2 = var_21_0.x - var_21_1.x
	local var_21_3 = var_21_0.y - var_21_1.y
	local var_21_4 = math.abs(var_21_2)
	local var_21_5 = math.abs(var_21_3)
	local var_21_6 = 0

	if not arg_21_0._nowOper and (var_21_4 > TianShiNaNaEnum.OperDragBegin or var_21_5 > TianShiNaNaEnum.OperDragBegin) then
		arg_21_0._nowOper = TianShiNaNaHelper.getOperDir(var_21_2, var_21_3)

		local var_21_7 = arg_21_0.cube:getOperDownIndex(arg_21_0._nowOper)
		local var_21_8 = true

		arg_21_0._isErrorOper = false

		local var_21_9 = false

		if arg_21_0._finishIndex[var_21_7] then
			local var_21_10 = TianShiNaNaModel.instance.curOperList

			if (#var_21_10 > 1 and var_21_10[#var_21_10]) ~= -arg_21_0._nowOper then
				var_21_8 = false
			else
				local var_21_11 = arg_21_0.cube:getCurDownIndex()

				arg_21_0.cube:revertPlane(var_21_11)

				var_21_9 = true
			end
		elseif not arg_21_0:checkCanOper(arg_21_0._nowOper) then
			arg_21_0._isErrorOper = true
		end

		if not var_21_8 then
			arg_21_0._nowOper = nil
		else
			local var_21_12 = tabletool.len(arg_21_0._finishIndex)

			if not var_21_9 and var_21_12 == 4 and not arg_21_0._finishIndex[7 - var_21_7] then
				arg_21_0._hidePlanIndex = 7 - var_21_7

				local var_21_13 = arg_21_0.cube:getPlaneByIndex(arg_21_0._hidePlanIndex)

				gohelper.setActive(var_21_13, false)
			end
		end
	elseif arg_21_0._nowOper and TianShiNaNaHelper.isRevertDir(arg_21_0._nowOper, var_21_2, var_21_3) then
		var_21_4, var_21_5 = 0, 0
	end

	if arg_21_0._nowOper then
		if arg_21_0._nowOper == TianShiNaNaEnum.OperDir.Left or arg_21_0._nowOper == TianShiNaNaEnum.OperDir.Right then
			var_21_6 = var_21_4
		else
			var_21_6 = var_21_5
		end

		arg_21_0._dragValue = Mathf.Clamp((var_21_6 - TianShiNaNaEnum.OperDragBegin) / TianShiNaNaEnum.OperDragMax, 0, 1)

		arg_21_0.cube:doCubeTween(arg_21_0._nowOper, arg_21_0._dragValue)
	end
end

function var_0_0._onEndDrag(arg_22_0)
	arg_22_0:_doOperTween()
end

function var_0_0._doOperTween(arg_23_0, arg_23_1)
	if arg_23_0._nowOper and arg_23_0._dragValue then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.play_ui_youyu_unfold)

		if arg_23_0._dragValue > TianShiNaNaEnum.OperDragVaild and not arg_23_0._isErrorOper or arg_23_1 then
			arg_23_0._tweenId = ZProj.TweenHelper.DOTweenFloat(arg_23_0._dragValue, 1, (1 - arg_23_0._dragValue) * 0.3, arg_23_0.onFrameDragCube, arg_23_0.onFinishDragCube, arg_23_0)
		else
			arg_23_0._tweenId = ZProj.TweenHelper.DOTweenFloat(arg_23_0._dragValue, 0, arg_23_0._dragValue * 0.3, arg_23_0.onFrameDragCube, arg_23_0.onFinishDragCube2, arg_23_0)
		end

		arg_23_0._dragValue = nil
	end
end

function var_0_0.onFrameDragCube(arg_24_0, arg_24_1)
	arg_24_0.cube:doCubeTween(arg_24_0._nowOper, arg_24_1)
end

function var_0_0.onFinishDragCube(arg_25_0)
	local var_25_0 = TianShiNaNaModel.instance.curOperList
	local var_25_1 = #var_25_0 > 1 and var_25_0[#var_25_0]

	if var_25_1 == -arg_25_0._nowOper then
		table.remove(var_25_0)

		local var_25_2 = arg_25_0.cube:getCurDownIndex()

		arg_25_0.cube:doRotate(-var_25_1)

		arg_25_0._finishIndex[var_25_2] = nil
	else
		local var_25_3 = arg_25_0.cube:getCurGrids()

		for iter_25_0, iter_25_1 in pairs(var_25_3) do
			TianShiNaNaEffectPool.instance:getFromPool(iter_25_1.x, iter_25_1.y, 1, 0, 0.2)
		end

		arg_25_0.cube:doRotate(arg_25_0._nowOper)
		arg_25_0:markOpers(arg_25_0._nowOper)
	end

	arg_25_0._nowOper = nil
	arg_25_0._tweenId = nil

	if arg_25_0._hidePlanIndex then
		arg_25_0._finishIndex[arg_25_0._hidePlanIndex] = true
		arg_25_0._hidePlanIndex = nil
	end

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.OnWaitDragEnd)

	if tabletool.len(arg_25_0._finishIndex) == 6 then
		arg_25_0:_onEndRotate()

		return
	end
end

function var_0_0.checkCanOper(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_2 or arg_26_0.cube:getOperGrids(arg_26_1)
	local var_26_1 = #var_26_0

	for iter_26_0, iter_26_1 in pairs(var_26_0) do
		if not TianShiNaNaModel.instance:isNodeCanPlace(iter_26_1.x, iter_26_1.y, var_26_1 == 1) then
			return false
		end
	end

	return true
end

function var_0_0.markOpers(arg_27_0, arg_27_1)
	table.insert(TianShiNaNaModel.instance.curOperList, arg_27_1)

	local var_27_0 = arg_27_0.cube:getCurDownIndex()

	arg_27_0._finishIndex[var_27_0] = true

	arg_27_0.cube:setPlaneParent(var_27_0, arg_27_0._cubeContainer.transform)
end

function var_0_0.onFinishDragCube2(arg_28_0)
	local var_28_0 = TianShiNaNaModel.instance.curOperList

	if (#var_28_0 > 1 and var_28_0[#var_28_0]) == -arg_28_0._nowOper then
		local var_28_1 = arg_28_0.cube:getCurDownIndex()

		arg_28_0.cube:setPlaneParent(var_28_1, arg_28_0._cubeContainer.transform)
	end

	arg_28_0._nowOper = nil
	arg_28_0._tweenId = nil

	if arg_28_0._hidePlanIndex then
		local var_28_2 = arg_28_0.cube:getPlaneByIndex(arg_28_0._hidePlanIndex)

		gohelper.setActive(var_28_2, true)

		arg_28_0._hidePlanIndex = nil
	end
end

return var_0_0
