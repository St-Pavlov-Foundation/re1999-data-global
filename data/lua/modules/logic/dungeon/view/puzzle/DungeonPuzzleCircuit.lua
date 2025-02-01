module("modules.logic.dungeon.view.puzzle.DungeonPuzzleCircuit", package.seeall)

slot0 = class("DungeonPuzzleCircuit", BaseView)

function slot0.onInitView(slot0)
	slot0._gocube = gohelper.findChild(slot0.viewGO, "#go_basepoint/#go_cube")
	slot0._gobasepoint = gohelper.findChild(slot0.viewGO, "#go_basepoint")
	slot0._goclick = gohelper.findChild(slot0.viewGO, "#go_click")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reset")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._click:AddClickListener(slot0._onClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0:addEventCb(DungeonPuzzleCircuitController.instance, DungeonPuzzleEvent.CircuitClick, slot0._onGuideClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._click:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0:removeEventCb(DungeonPuzzleCircuitController.instance, DungeonPuzzleEvent.CircuitClick, slot0._onGuideClick, slot0)
end

function slot0._btnresetOnClick(slot0)
	if slot0._rule:isWin() then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.DungeonPuzzleResetGame, MsgBoxEnum.BoxType.Yes_No, function ()
		uv0:_resetGame()
	end)
end

function slot0._resetGame(slot0)
	for slot4 = 1, slot0._gameHeight do
		for slot8 = 1, slot0._gameWidth do
			if DungeonPuzzleCircuitModel.instance:getData(slot4, slot8) then
				slot9.value = slot9.rawValue

				slot0:_syncRotation(slot4, slot8, slot9)
			end
		end
	end

	slot0._rule:refreshAllConnection()
	slot0:_refreshAllConnectionStatus()
end

function slot0._editableInitView(slot0)
	slot0:initConst()

	slot0._touch = TouchEventMgrHepler.getTouchEventMgr(slot0._gobasepoint)

	slot0._touch:SetOnlyTouch(true)
	slot0._touch:SetIgnoreUI(true)
	slot0._touch:SetOnClickCb(slot0._onClickContainer, slot0)

	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._goclick)
	slot0._rule = DungeonPuzzleCircuitRule.New()
	slot0._animator = gohelper.findChild(slot0.viewGO, "biaopan"):GetComponent(typeof(UnityEngine.Animator))
	slot0._capacitanceEffectList = {}
end

function slot0.initConst(slot0)
	slot0._itemSizeX = 109
	slot0._itemSizeY = 109
	slot0._gameWidth, slot0._gameHeight = DungeonPuzzleCircuitModel.instance:getGameSize()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._gridObjs = {}

	for slot4 = 1, slot0._gameHeight do
		for slot8 = 1, slot0._gameWidth do
			slot0._gridObjs[slot4] = slot0._gridObjs[slot4] or {}

			slot0:addNewItem(slot4, slot8)
		end
	end

	slot0._rule:refreshAllConnection()
	slot0:_refreshAllConnectionStatus()
end

function slot0.addNewItem(slot0, slot1, slot2)
	slot0:initItem(slot1, slot2)
end

function slot0._newPipeItem(slot0, slot1, slot2)
	if slot0._gridObjs[slot1][slot2] then
		return
	end

	slot3 = gohelper.cloneInPlace(slot0._gocube, slot1 .. "_" .. slot2)

	gohelper.setActive(slot3, true)

	slot4 = slot3.transform
	slot5, slot6 = DungeonPuzzleCircuitModel.instance:getRelativePosition(slot1, slot2, slot0._itemSizeX, slot0._itemSizeY)

	recthelper.setAnchor(slot4, slot5, slot6)

	slot7 = slot0:getUserDataTb_()
	slot7.go = slot3
	slot7.image = gohelper.findChildImage(slot3, "icon")
	slot7.imageTf = slot7.image.transform
	slot7.tf = slot4
	slot7.capacitanceEffect = gohelper.findChild(slot3, "#vx_dianzu")
	slot7.errorEffect = gohelper.findChild(slot3, "error")
	slot0._gridObjs[slot1][slot2] = slot7
end

function slot0.initItem(slot0, slot1, slot2)
	if not DungeonPuzzleCircuitModel.instance:getData(slot1, slot2) then
		return
	end

	slot0:_newPipeItem(slot1, slot2)

	slot4 = slot0._gridObjs[slot1][slot2]

	if slot3.type == 0 then
		gohelper.setActive(slot4.go, false)

		return
	end

	gohelper.setActive(slot4.go, true)
	UISpriteSetMgr.instance:setPuzzleSprite(slot4.image, DungeonPuzzleCircuitEnum.res[slot3.type][1], true)
	slot0:_syncRotation(slot1, slot2, slot3)
end

function slot0._getItem(slot0, slot1)
	return slot0._gridObjs[slot1.x][slot1.y]
end

function slot0._syncRotation(slot0, slot1, slot2, slot3)
	if not DungeonPuzzleCircuitEnum.rotate[slot3.type] then
		slot3.value = 0

		transformhelper.setLocalRotation(slot0._gridObjs[slot1][slot2].tf, 0, 0, 0)

		return
	end

	if not slot5[slot3.value] then
		for slot10, slot11 in pairs(slot5) do
			slot3.value = slot10

			break
		end
	end

	transformhelper.setLocalRotation(slot4.tf, 0, 0, slot5[slot3.value][1])
end

function slot0._onClick(slot0)
	slot0._isClick = true
end

function slot0._onClickContainer(slot0, slot1)
	if not slot0._isClick then
		return
	end

	slot0._isClick = false

	if slot0._rule:isWin() then
		return
	end

	slot2 = recthelper.screenPosToAnchorPos(slot1, slot0._gobasepoint.transform)
	slot3, slot4 = DungeonPuzzleCircuitModel.instance:getIndexByTouchPos(slot2.x, slot2.y, slot0._itemSizeX, slot0._itemSizeY)

	if slot3 ~= -1 then
		slot0:_onClickGridItem(slot3, slot4)
	end
end

function slot0._onGuideClick(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "_")

	slot0:_onClickGridItem(slot2[1], slot2[2])
end

function slot0._onClickGridItem(slot0, slot1, slot2)
	if not DungeonPuzzleCircuitModel.instance:getData(slot1, slot2) then
		return
	end

	slot0._clickItemMo = slot3

	AudioMgr.instance:trigger(AudioEnum.PuzzleCircuit.play_ui_circuit_click)
	slot0._rule:changeDirection(slot1, slot2, true)
	slot0._rule:refreshAllConnection()
	slot0:_syncRotation(slot1, slot2, slot3)
	slot0:_checkAudio()
	slot0:_refreshAllConnectionStatus()

	if slot0._rule:isWin() then
		AudioMgr.instance:trigger(AudioEnum.PuzzleCircuit.play_ui_powersupply_connection)
		GameFacade.showToast(ToastEnum.DungeonPuzzle2)
		DungeonRpc.instance:sendPuzzleFinishRequest(DungeonPuzzleCircuitModel.instance:getElementCo().id)
		slot0._animator:Play(UIAnimationName.Open)
	end
end

function slot0._refreshAllConnectionStatus(slot0)
	slot0:_refreshItemsStatus(slot0._rule:getOldCircuitList(), DungeonPuzzleCircuitEnum.status.normal)
	slot0:_refreshItemsStatus(slot0._rule:getOldCapacitanceList(), DungeonPuzzleCircuitEnum.status.normal)
	slot0:_refreshItemsStatus(slot0._rule:getOldWrongList(), DungeonPuzzleCircuitEnum.status.normal)
	slot0:_refreshItemsStatus(slot0._rule:getCircuitList(), DungeonPuzzleCircuitEnum.status.correct)
	slot0:_refreshItemsStatus(slot0._rule:getCapacitanceList(), DungeonPuzzleCircuitEnum.status.correct)

	slot4 = DungeonPuzzleCircuitEnum.status.error

	slot0:_refreshItemsStatus(slot0._rule:getWrongList(), slot4)

	for slot4, slot5 in pairs(slot0._capacitanceEffectList) do
		gohelper.setActive(slot5.capacitanceEffect, false)
		rawset(slot0._capacitanceEffectList, slot4, nil)
	end
end

function slot0._checkAudio(slot0)
	if tabletool.len(slot0._rule:getOldCapacitanceList()) < tabletool.len(slot0._rule:getCapacitanceList()) then
		AudioMgr.instance:trigger(AudioEnum.PuzzleCircuit.play_ui_capacitors_connection)
		slot0._animator:Play("onece", 0, 0)
	end

	if tabletool.len(slot0._rule:getOldWrongList()) < tabletool.len(slot0._rule:getWrongList()) then
		AudioMgr.instance:trigger(AudioEnum.PuzzleCircuit.play_ui_circuit_shortcircuit)

		slot0._clickItemMo = nil
	end
end

function slot0._refreshItemsStatus(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	for slot6, slot7 in pairs(slot1) do
		if DungeonPuzzleCircuitEnum.res[slot7.type][slot2] then
			UISpriteSetMgr.instance:setPuzzleSprite(slot0:_getItem(slot7).image, slot10, true)
		end

		if slot2 == DungeonPuzzleCircuitEnum.status.normal then
			if slot7.type == DungeonPuzzleCircuitEnum.type.capacitance then
				slot0._capacitanceEffectList[slot7] = slot8
			end

			gohelper.setActive(slot8.errorEffect, false)
		elseif slot7.type == DungeonPuzzleCircuitEnum.type.capacitance and slot2 == DungeonPuzzleCircuitEnum.status.correct then
			gohelper.setActive(slot8.capacitanceEffect, true)

			slot0._capacitanceEffectList[slot7] = nil
		elseif slot2 == DungeonPuzzleCircuitEnum.status.error and DungeonPuzzleCircuitEnum.type.straight <= slot7.type and slot7.type <= DungeonPuzzleCircuitEnum.type.t_shape then
			gohelper.setActive(slot8.errorEffect, true)

			slot11, slot12, slot13 = transformhelper.getLocalRotation(slot8.tf)

			transformhelper.setLocalRotation(slot8.errorEffect.transform, 0, 0, -slot13)

			if slot0._clickItemMo == slot7 then
				AudioMgr.instance:trigger(AudioEnum.PuzzleCircuit.play_ui_circuit_shortcircuit)
			end
		end
	end
end

function slot0._doEdit(slot0, slot1, slot2)
	if not DungeonPuzzleCircuitModel.instance:getEditIndex() or slot3 <= 0 then
		return false
	end

	slot4 = DungeonPuzzleCircuitModel.instance:getData(slot1, slot2)

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftAlt) then
		if not slot4 then
			return true
		end

		slot4.type = 0

		slot0:initItem(slot1, slot2)

		return true
	end

	if not UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) then
		return false
	end

	if DungeonPuzzleCircuitEnum.type.power1 <= slot3 and slot3 <= DungeonPuzzleCircuitEnum.type.t_shape then
		(slot4 or DungeonPuzzleCircuitModel.instance:_getMo(slot1, slot2)).type = slot3

		slot0:initItem(slot1, slot2)
	end

	return true
end

function slot0.onClose(slot0)
	if slot0._touch then
		TouchEventMgrHepler.remove(slot0._touch)

		slot0._touch = nil
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
