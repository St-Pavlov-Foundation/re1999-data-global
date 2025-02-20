module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaOperView", package.seeall)

slot0 = class("TianShiNaNaOperView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnBack = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_back")
	slot0._gofull = gohelper.findChild(slot0.viewGO, "#go_full")
	slot0._clickFull = gohelper.findChildClick(slot0.viewGO, "#go_full")
	slot0._btnEndRotate = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_endrotate")
end

function slot0.addEvents(slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.ResetScene, slot0.onSceneReset, slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.LoadLevelFinish, slot0.onLevelLoadFinish, slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.OnFlowEnd, slot0.onFlowEnd, slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.RoundFail, slot0.onRoundFail, slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.StatuChange, slot0._onStatuChange, slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.RoundUpdate, slot0._onRoundChange, slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.GuideClickNode, slot0._onGuideClickNode, slot0)
	slot0._btnBack:AddClickListener(slot0._onBackClick, slot0)
	slot0._clickFull:AddClickListener(slot0._onClickFull, slot0)
	slot0._btnEndRotate:AddClickListener(slot0._onEndRotate, slot0)
	CommonDragHelper.instance:registerDragObj(slot0._gofull, nil, slot0._onDrag, slot0._onEndDrag, slot0._checkLockDrag, slot0, nil, true)
end

function slot0.removeEvents(slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.ResetScene, slot0.onSceneReset, slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.LoadLevelFinish, slot0.onLevelLoadFinish, slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.OnFlowEnd, slot0.onFlowEnd, slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.RoundFail, slot0.onRoundFail, slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.StatuChange, slot0._onStatuChange, slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.RoundUpdate, slot0._onRoundChange, slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.GuideClickNode, slot0._onGuideClickNode, slot0)
	slot0._btnBack:RemoveClickListener()
	slot0._clickFull:RemoveClickListener()
	slot0._btnEndRotate:RemoveClickListener()
	CommonDragHelper.instance:unregisterDragObj(slot0._gofull)
end

function slot0.onLevelLoadFinish(slot0, slot1)
	TianShiNaNaModel.instance.sceneLevelLoadFinish = true
	slot0._cubeContainer = gohelper.create3d(slot1.transform.parent.gameObject, "CubeContainer")
	slot0._placeContainer = gohelper.create3d(slot1.transform.parent.gameObject, "PlaceContainer")
	slot0._effectContainer = gohelper.create3d(slot1.transform.parent.gameObject, "EffectContainer")

	TianShiNaNaEffectPool.instance:setRoot(slot0._effectContainer)

	slot2 = slot0._cubeContainer.transform

	transformhelper.setLocalPos(slot2, 0, 1.113595, -4.8425)
	transformhelper.setLocalRotation(slot2, 152.637, 52.768, 31.166)
	transformhelper.setLocalScale(slot2, 1.5, -1.5, -1.5)

	if TianShiNaNaModel.instance.waitStartFlow then
		TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.DoStep)
		TianShiNaNaController.instance:checkBeginFlow()
	else
		slot0:beginSelectDir()
	end

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.EnterMapAndInitDone, tostring(TianShiNaNaModel.instance.episodeCo.id))
end

function slot0.onSceneReset(slot0)
	if TianShiNaNaModel.instance.waitStartFlow then
		slot0:clearCubes()
		TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.DoStep)
		TianShiNaNaController.instance:checkBeginFlow()

		return
	end

	if #TianShiNaNaModel.instance.curOperList == 0 then
		slot0:beginSelectDir()
	else
		slot0:clearCubes()

		slot0.cube = slot0:_placeCubes(slot1[1], TianShiNaNaModel.instance:getNextCubeType())
		slot6 = slot0.cube

		slot0:setCurOperCube(slot1[1], slot6)

		for slot6 = 2, #slot1 do
			slot7 = slot1[slot6]

			slot0.cube:doRotate(slot7)
			slot0:markOpers(slot7)

			if slot6 == 4 and slot2 == 5 and not slot0._finishIndex[7 - slot0.cube:getOperDownIndex(slot1[5])] then
				table.remove(slot1)

				break
			end

			if slot6 == 5 and slot2 == 6 then
				table.remove(slot1)

				break
			end
		end
	end
end

function slot0._onStatuChange(slot0, slot1, slot2)
	gohelper.setActive(slot0._btnEndRotate, slot2 == TianShiNaNaEnum.CurState.Rotate)

	if slot1 == TianShiNaNaEnum.CurState.SelectDir and slot2 == TianShiNaNaEnum.CurState.DoStep then
		slot0:clearCubes()
	end
end

function slot0._onRoundChange(slot0)
	if TianShiNaNaModel.instance:isWaitClick() then
		slot0:clearCubes(true)
		gohelper.setActive(slot0._btnEndRotate, true)
	end
end

function slot0._onBackClick(slot0)
	if TianShiNaNaHelper.isBanOper() then
		return
	end

	if TianShiNaNaModel.instance:getState() == TianShiNaNaEnum.CurState.SelectDir or TianShiNaNaModel.instance:isWaitClick() then
		Activity167Rpc.instance:sendAct167RollbackRequest(VersionActivity2_2Enum.ActivityId.TianShiNaNa, TianShiNaNaModel.instance.episodeCo.id)
	elseif slot1 == TianShiNaNaEnum.CurState.Rotate then
		if slot0:_checkLockDrag() then
			return
		end

		if #TianShiNaNaModel.instance.curOperList <= 1 then
			slot0:beginSelectDir()
		else
			slot0:rollbackOper(table.remove(slot2))
		end
	end
end

function slot0.rollbackOper(slot0, slot1)
	slot2 = slot0.cube:getCurDownIndex()

	slot0.cube:revertPlane(slot2)
	slot0.cube:doRotate(-slot1)

	slot0._isErrorOper = true
	slot0._dragValue = 1
	slot0._nowOper = slot1
	slot0._finishIndex[slot2] = nil

	slot0:_doOperTween()
end

function slot0.beginSelectDir(slot0)
	slot0:clearCubes()
	TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.SelectDir)

	slot1 = TianShiNaNaModel.instance:getHeroMo()

	if not TianShiNaNaModel.instance:getNextCubeType() then
		logError("没有方块了？？？")

		return
	end

	slot0._nowCubeType = slot2

	if not next(TianShiNaNaHelper.getCanOperDirs(slot1, slot2)) then
		TianShiNaNaModel.instance.curOperList = {}
		slot0._finishIndex = {}

		TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.Rotate)
	else
		slot0._placeEntity = TianShiNaNaPlaceEntity.Create(slot1.x, slot1.y, slot3, slot2, slot0._placeContainer)
	end
end

function slot0._placeCubes(slot0, slot1, slot2)
	slot3 = TianShiNaNaModel.instance:getHeroMo()

	if slot2 == TianShiNaNaEnum.CubeType.Type1 then
		slot6 = TianShiNaNaHelper.getOperOffset(slot1)
		slot4 = slot3.x + slot6.x
		slot5 = slot3.y + slot6.y
	end

	slot6 = TianShiNaNaCubeEntity.Create(slot4, slot5, slot0._cubeContainer)

	if slot2 == TianShiNaNaEnum.CubeType.Type2 then
		slot6:doRotate(slot1)
	end

	return slot6
end

function slot0._onClickFull(slot0, slot1)
	if TianShiNaNaModel.instance:getState() == TianShiNaNaEnum.CurState.SelectDir then
		if slot0._placeEntity:getClickDir(slot1 or TianShiNaNaHelper.getClickNodePos()) then
			slot5 = TianShiNaNaModel.instance:getNextCubeType()
			slot6 = slot0:_placeCubes(slot4, slot5)

			slot6:playOpenAnim(slot5)
			slot0:setCurOperCube(slot4, slot6)
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.play_ui_youyu_deploy)
		end
	elseif slot2 == TianShiNaNaEnum.CurState.Rotate and not slot0._nowOper and not slot0:_checkLockDrag() then
		for slot7, slot8 in pairs(TianShiNaNaEnum.OperDir) do
			slot9 = slot0.cube:getOperGrids(slot8)

			if not slot0._finishIndex[slot0.cube:getOperDownIndex(slot8)] and TianShiNaNaHelper.havePos(slot9, slot1 or TianShiNaNaHelper.getClickNodePos()) and slot0:checkCanOper(slot8, slot9) then
				slot0._dragValue = 0
				slot0._nowOper = slot8

				if tabletool.len(slot0._finishIndex) == 4 and not slot0._finishIndex[7 - slot10] then
					slot0._hidePlanIndex = 7 - slot10

					gohelper.setActive(slot0.cube:getPlaneByIndex(slot0._hidePlanIndex), false)
				end

				slot0:_doOperTween(true)

				return
			elseif slot0._finishIndex[slot10] and TianShiNaNaHelper.havePos(slot9, slot3) and (#TianShiNaNaModel.instance.curOperList > 1 and slot11[#slot11]) == -slot8 then
				slot0._dragValue = 0
				slot0._nowOper = slot8

				slot0.cube:revertPlane(slot0.cube:getCurDownIndex())
				slot0:_doOperTween(true)

				return
			end
		end
	end
end

function slot0._onGuideClickNode(slot0, slot1)
	slot2 = string.splitToNumber(slot1, ",")

	slot0:_onClickFull({
		x = slot2[1],
		y = slot2[2]
	})
end

function slot0.setCurOperCube(slot0, slot1, slot2)
	TianShiNaNaModel.instance.curOperList = {}
	slot0._finishIndex = {}
	slot0.cube = slot2

	if slot0._placeEntity then
		slot0._placeEntity:dispose()

		slot0._placeEntity = nil
	end

	TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.Rotate)
	slot0:markOpers(slot1)
end

function slot0._onEndRotate(slot0)
	if TianShiNaNaHelper.isBanOper() then
		return
	end

	if TianShiNaNaModel.instance:isWaitClick() then
		gohelper.setActive(slot0._btnEndRotate, false)

		TianShiNaNaModel.instance.waitClickJump = false

		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.WaitClickJumpRound)

		return
	end

	if TianShiNaNaModel.instance:getState() ~= TianShiNaNaEnum.CurState.Rotate then
		return
	end

	if slot0._tweenId then
		return
	end

	if slot0.cube then
		slot1 = slot0.cube:getCurGrids()
		slot2 = 0

		if tabletool.len(slot0._finishIndex) == 6 then
			slot2 = 0.2
		end

		for slot6, slot7 in pairs(slot1) do
			TianShiNaNaEffectPool.instance:getFromPool(slot7.x, slot7.y, 1, slot2, 0.2)
		end

		slot0.cube:hideOtherPlane()
	end

	TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.DoStep)
	Activity167Rpc.instance:sendAct167BeginRoundRequest(VersionActivity2_2Enum.ActivityId.TianShiNaNa, TianShiNaNaModel.instance.episodeCo.id, TianShiNaNaModel.instance.curOperList)

	TianShiNaNaModel.instance.curOperList = {}
end

function slot0.onFlowEnd(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:beginSelectDir()
end

function slot0.onRoundFail(slot0)
	slot0:beginSelectDir()
end

function slot0.clearCubes(slot0, slot1)
	if not slot1 then
		TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.None)
	end

	if slot0.cube then
		gohelper.destroy(slot0.cube.go)
	end

	if slot0._placeEntity then
		slot0._placeEntity:dispose()

		slot0._placeEntity = nil
	end
end

function slot0.onClose(slot0)
	TianShiNaNaModel.instance.sceneLevelLoadFinish = false

	slot0:clearCubes()

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	TianShiNaNaEffectPool.instance:clear()
end

function slot0._checkLockDrag(slot0)
	return slot0._tweenId or not slot0.cube or TianShiNaNaModel.instance:getState() ~= TianShiNaNaEnum.CurState.Rotate
end

function slot0._onDrag(slot0, slot1, slot2)
	slot3 = slot2.position
	slot4 = slot2.pressPosition
	slot9 = 0

	if not slot0._nowOper and (TianShiNaNaEnum.OperDragBegin < math.abs(slot3.x - slot4.x) or TianShiNaNaEnum.OperDragBegin < math.abs(slot3.y - slot4.y)) then
		slot0._nowOper = TianShiNaNaHelper.getOperDir(slot5, slot6)
		slot11 = true
		slot0._isErrorOper = false
		slot12 = false

		if slot0._finishIndex[slot0.cube:getOperDownIndex(slot0._nowOper)] then
			if (#TianShiNaNaModel.instance.curOperList > 1 and slot13[#slot13]) ~= -slot0._nowOper then
				slot11 = false
			else
				slot0.cube:revertPlane(slot0.cube:getCurDownIndex())

				slot12 = true
			end
		elseif not slot0:checkCanOper(slot0._nowOper) then
			slot0._isErrorOper = true
		end

		if not slot11 then
			slot0._nowOper = nil
		elseif not slot12 and tabletool.len(slot0._finishIndex) == 4 and not slot0._finishIndex[7 - slot10] then
			slot0._hidePlanIndex = 7 - slot10

			gohelper.setActive(slot0.cube:getPlaneByIndex(slot0._hidePlanIndex), false)
		end
	elseif slot0._nowOper and TianShiNaNaHelper.isRevertDir(slot0._nowOper, slot5, slot6) then
		slot8 = 0
		slot7 = 0
	end

	if slot0._nowOper then
		slot0._dragValue = Mathf.Clamp((((slot0._nowOper == TianShiNaNaEnum.OperDir.Left or slot0._nowOper == TianShiNaNaEnum.OperDir.Right) and slot7 or slot8) - TianShiNaNaEnum.OperDragBegin) / TianShiNaNaEnum.OperDragMax, 0, 1)

		slot0.cube:doCubeTween(slot0._nowOper, slot0._dragValue)
	end
end

function slot0._onEndDrag(slot0)
	slot0:_doOperTween()
end

function slot0._doOperTween(slot0, slot1)
	if slot0._nowOper and slot0._dragValue then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.play_ui_youyu_unfold)

		if TianShiNaNaEnum.OperDragVaild < slot0._dragValue and not slot0._isErrorOper or slot1 then
			slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot0._dragValue, 1, (1 - slot0._dragValue) * 0.3, slot0.onFrameDragCube, slot0.onFinishDragCube, slot0)
		else
			slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot0._dragValue, 0, slot0._dragValue * 0.3, slot0.onFrameDragCube, slot0.onFinishDragCube2, slot0)
		end

		slot0._dragValue = nil
	end
end

function slot0.onFrameDragCube(slot0, slot1)
	slot0.cube:doCubeTween(slot0._nowOper, slot1)
end

function slot0.onFinishDragCube(slot0)
	if (#TianShiNaNaModel.instance.curOperList > 1 and slot1[#slot1]) == -slot0._nowOper then
		table.remove(slot1)
		slot0.cube:doRotate(-slot2)

		slot0._finishIndex[slot0.cube:getCurDownIndex()] = nil
	else
		for slot7, slot8 in pairs(slot0.cube:getCurGrids()) do
			TianShiNaNaEffectPool.instance:getFromPool(slot8.x, slot8.y, 1, 0, 0.2)
		end

		slot0.cube:doRotate(slot0._nowOper)
		slot0:markOpers(slot0._nowOper)
	end

	slot0._nowOper = nil
	slot0._tweenId = nil

	if slot0._hidePlanIndex then
		slot0._finishIndex[slot0._hidePlanIndex] = true
		slot0._hidePlanIndex = nil
	end

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.OnWaitDragEnd)

	if tabletool.len(slot0._finishIndex) == 6 then
		slot0:_onEndRotate()

		return
	end
end

function slot0.checkCanOper(slot0, slot1, slot2)
	for slot8, slot9 in pairs(slot3) do
		if not TianShiNaNaModel.instance:isNodeCanPlace(slot9.x, slot9.y, #(slot2 or slot0.cube:getOperGrids(slot1)) == 1) then
			return false
		end
	end

	return true
end

function slot0.markOpers(slot0, slot1)
	table.insert(TianShiNaNaModel.instance.curOperList, slot1)

	slot2 = slot0.cube:getCurDownIndex()
	slot0._finishIndex[slot2] = true

	slot0.cube:setPlaneParent(slot2, slot0._cubeContainer.transform)
end

function slot0.onFinishDragCube2(slot0)
	if (#TianShiNaNaModel.instance.curOperList > 1 and slot1[#slot1]) == -slot0._nowOper then
		slot0.cube:setPlaneParent(slot0.cube:getCurDownIndex(), slot0._cubeContainer.transform)
	end

	slot0._nowOper = nil
	slot0._tweenId = nil

	if slot0._hidePlanIndex then
		gohelper.setActive(slot0.cube:getPlaneByIndex(slot0._hidePlanIndex), true)

		slot0._hidePlanIndex = nil
	end
end

return slot0
