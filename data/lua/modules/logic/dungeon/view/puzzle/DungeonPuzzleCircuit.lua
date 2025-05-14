module("modules.logic.dungeon.view.puzzle.DungeonPuzzleCircuit", package.seeall)

local var_0_0 = class("DungeonPuzzleCircuit", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocube = gohelper.findChild(arg_1_0.viewGO, "#go_basepoint/#go_cube")
	arg_1_0._gobasepoint = gohelper.findChild(arg_1_0.viewGO, "#go_basepoint")
	arg_1_0._goclick = gohelper.findChild(arg_1_0.viewGO, "#go_click")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0:addEventCb(DungeonPuzzleCircuitController.instance, DungeonPuzzleEvent.CircuitClick, arg_2_0._onGuideClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._click:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0:removeEventCb(DungeonPuzzleCircuitController.instance, DungeonPuzzleEvent.CircuitClick, arg_3_0._onGuideClick, arg_3_0)
end

function var_0_0._btnresetOnClick(arg_4_0)
	if arg_4_0._rule:isWin() then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.DungeonPuzzleResetGame, MsgBoxEnum.BoxType.Yes_No, function()
		arg_4_0:_resetGame()
	end)
end

function var_0_0._resetGame(arg_6_0)
	for iter_6_0 = 1, arg_6_0._gameHeight do
		for iter_6_1 = 1, arg_6_0._gameWidth do
			local var_6_0 = DungeonPuzzleCircuitModel.instance:getData(iter_6_0, iter_6_1)

			if var_6_0 then
				var_6_0.value = var_6_0.rawValue

				arg_6_0:_syncRotation(iter_6_0, iter_6_1, var_6_0)
			end
		end
	end

	arg_6_0._rule:refreshAllConnection()
	arg_6_0:_refreshAllConnectionStatus()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0:initConst()

	arg_7_0._touch = TouchEventMgrHepler.getTouchEventMgr(arg_7_0._gobasepoint)

	arg_7_0._touch:SetOnlyTouch(true)
	arg_7_0._touch:SetIgnoreUI(true)
	arg_7_0._touch:SetOnClickCb(arg_7_0._onClickContainer, arg_7_0)

	arg_7_0._click = SLFramework.UGUI.UIClickListener.Get(arg_7_0._goclick)
	arg_7_0._rule = DungeonPuzzleCircuitRule.New()
	arg_7_0._animator = gohelper.findChild(arg_7_0.viewGO, "biaopan"):GetComponent(typeof(UnityEngine.Animator))
	arg_7_0._capacitanceEffectList = {}
end

function var_0_0.initConst(arg_8_0)
	arg_8_0._itemSizeX = 109
	arg_8_0._itemSizeY = 109
	arg_8_0._gameWidth, arg_8_0._gameHeight = DungeonPuzzleCircuitModel.instance:getGameSize()
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._gridObjs = {}

	for iter_10_0 = 1, arg_10_0._gameHeight do
		for iter_10_1 = 1, arg_10_0._gameWidth do
			arg_10_0._gridObjs[iter_10_0] = arg_10_0._gridObjs[iter_10_0] or {}

			arg_10_0:addNewItem(iter_10_0, iter_10_1)
		end
	end

	arg_10_0._rule:refreshAllConnection()
	arg_10_0:_refreshAllConnectionStatus()
end

function var_0_0.addNewItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:initItem(arg_11_1, arg_11_2)
end

function var_0_0._newPipeItem(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0._gridObjs[arg_12_1][arg_12_2] then
		return
	end

	local var_12_0 = gohelper.cloneInPlace(arg_12_0._gocube, arg_12_1 .. "_" .. arg_12_2)

	gohelper.setActive(var_12_0, true)

	local var_12_1 = var_12_0.transform
	local var_12_2, var_12_3 = DungeonPuzzleCircuitModel.instance:getRelativePosition(arg_12_1, arg_12_2, arg_12_0._itemSizeX, arg_12_0._itemSizeY)

	recthelper.setAnchor(var_12_1, var_12_2, var_12_3)

	local var_12_4 = arg_12_0:getUserDataTb_()

	var_12_4.go = var_12_0
	var_12_4.image = gohelper.findChildImage(var_12_0, "icon")
	var_12_4.imageTf = var_12_4.image.transform
	var_12_4.tf = var_12_1
	var_12_4.capacitanceEffect = gohelper.findChild(var_12_0, "#vx_dianzu")
	var_12_4.errorEffect = gohelper.findChild(var_12_0, "error")
	arg_12_0._gridObjs[arg_12_1][arg_12_2] = var_12_4
end

function var_0_0.initItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = DungeonPuzzleCircuitModel.instance:getData(arg_13_1, arg_13_2)

	if not var_13_0 then
		return
	end

	arg_13_0:_newPipeItem(arg_13_1, arg_13_2)

	local var_13_1 = arg_13_0._gridObjs[arg_13_1][arg_13_2]

	if var_13_0.type == 0 then
		gohelper.setActive(var_13_1.go, false)

		return
	end

	gohelper.setActive(var_13_1.go, true)

	local var_13_2 = DungeonPuzzleCircuitEnum.res[var_13_0.type][1]

	UISpriteSetMgr.instance:setPuzzleSprite(var_13_1.image, var_13_2, true)
	arg_13_0:_syncRotation(arg_13_1, arg_13_2, var_13_0)
end

function var_0_0._getItem(arg_14_0, arg_14_1)
	return arg_14_0._gridObjs[arg_14_1.x][arg_14_1.y]
end

function var_0_0._syncRotation(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_0._gridObjs[arg_15_1][arg_15_2]
	local var_15_1 = DungeonPuzzleCircuitEnum.rotate[arg_15_3.type]

	if not var_15_1 then
		arg_15_3.value = 0

		transformhelper.setLocalRotation(var_15_0.tf, 0, 0, 0)

		return
	end

	if not var_15_1[arg_15_3.value] then
		for iter_15_0, iter_15_1 in pairs(var_15_1) do
			arg_15_3.value = iter_15_0

			break
		end
	end

	local var_15_2 = var_15_1[arg_15_3.value][1]

	transformhelper.setLocalRotation(var_15_0.tf, 0, 0, var_15_2)
end

function var_0_0._onClick(arg_16_0)
	arg_16_0._isClick = true
end

function var_0_0._onClickContainer(arg_17_0, arg_17_1)
	if not arg_17_0._isClick then
		return
	end

	arg_17_0._isClick = false

	if arg_17_0._rule:isWin() then
		return
	end

	local var_17_0 = recthelper.screenPosToAnchorPos(arg_17_1, arg_17_0._gobasepoint.transform)
	local var_17_1, var_17_2 = DungeonPuzzleCircuitModel.instance:getIndexByTouchPos(var_17_0.x, var_17_0.y, arg_17_0._itemSizeX, arg_17_0._itemSizeY)

	if var_17_1 ~= -1 then
		arg_17_0:_onClickGridItem(var_17_1, var_17_2)
	end
end

function var_0_0._onGuideClick(arg_18_0, arg_18_1)
	local var_18_0 = string.splitToNumber(arg_18_1, "_")

	arg_18_0:_onClickGridItem(var_18_0[1], var_18_0[2])
end

function var_0_0._onClickGridItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = DungeonPuzzleCircuitModel.instance:getData(arg_19_1, arg_19_2)

	if not var_19_0 then
		return
	end

	arg_19_0._clickItemMo = var_19_0

	AudioMgr.instance:trigger(AudioEnum.PuzzleCircuit.play_ui_circuit_click)
	arg_19_0._rule:changeDirection(arg_19_1, arg_19_2, true)
	arg_19_0._rule:refreshAllConnection()
	arg_19_0:_syncRotation(arg_19_1, arg_19_2, var_19_0)
	arg_19_0:_checkAudio()
	arg_19_0:_refreshAllConnectionStatus()

	if arg_19_0._rule:isWin() then
		AudioMgr.instance:trigger(AudioEnum.PuzzleCircuit.play_ui_powersupply_connection)
		GameFacade.showToast(ToastEnum.DungeonPuzzle2)

		local var_19_1 = DungeonPuzzleCircuitModel.instance:getElementCo()

		DungeonRpc.instance:sendPuzzleFinishRequest(var_19_1.id)
		arg_19_0._animator:Play(UIAnimationName.Open)
	end
end

function var_0_0._refreshAllConnectionStatus(arg_20_0)
	arg_20_0:_refreshItemsStatus(arg_20_0._rule:getOldCircuitList(), DungeonPuzzleCircuitEnum.status.normal)
	arg_20_0:_refreshItemsStatus(arg_20_0._rule:getOldCapacitanceList(), DungeonPuzzleCircuitEnum.status.normal)
	arg_20_0:_refreshItemsStatus(arg_20_0._rule:getOldWrongList(), DungeonPuzzleCircuitEnum.status.normal)
	arg_20_0:_refreshItemsStatus(arg_20_0._rule:getCircuitList(), DungeonPuzzleCircuitEnum.status.correct)
	arg_20_0:_refreshItemsStatus(arg_20_0._rule:getCapacitanceList(), DungeonPuzzleCircuitEnum.status.correct)
	arg_20_0:_refreshItemsStatus(arg_20_0._rule:getWrongList(), DungeonPuzzleCircuitEnum.status.error)

	for iter_20_0, iter_20_1 in pairs(arg_20_0._capacitanceEffectList) do
		gohelper.setActive(iter_20_1.capacitanceEffect, false)
		rawset(arg_20_0._capacitanceEffectList, iter_20_0, nil)
	end
end

function var_0_0._checkAudio(arg_21_0)
	if tabletool.len(arg_21_0._rule:getCapacitanceList()) > tabletool.len(arg_21_0._rule:getOldCapacitanceList()) then
		AudioMgr.instance:trigger(AudioEnum.PuzzleCircuit.play_ui_capacitors_connection)
		arg_21_0._animator:Play("onece", 0, 0)
	end

	if tabletool.len(arg_21_0._rule:getWrongList()) > tabletool.len(arg_21_0._rule:getOldWrongList()) then
		AudioMgr.instance:trigger(AudioEnum.PuzzleCircuit.play_ui_circuit_shortcircuit)

		arg_21_0._clickItemMo = nil
	end
end

function var_0_0._refreshItemsStatus(arg_22_0, arg_22_1, arg_22_2)
	if not arg_22_1 then
		return
	end

	for iter_22_0, iter_22_1 in pairs(arg_22_1) do
		local var_22_0 = arg_22_0:_getItem(iter_22_1)
		local var_22_1 = DungeonPuzzleCircuitEnum.res[iter_22_1.type][arg_22_2]

		if var_22_1 then
			UISpriteSetMgr.instance:setPuzzleSprite(var_22_0.image, var_22_1, true)
		end

		if arg_22_2 == DungeonPuzzleCircuitEnum.status.normal then
			if iter_22_1.type == DungeonPuzzleCircuitEnum.type.capacitance then
				arg_22_0._capacitanceEffectList[iter_22_1] = var_22_0
			end

			gohelper.setActive(var_22_0.errorEffect, false)
		elseif iter_22_1.type == DungeonPuzzleCircuitEnum.type.capacitance and arg_22_2 == DungeonPuzzleCircuitEnum.status.correct then
			gohelper.setActive(var_22_0.capacitanceEffect, true)

			arg_22_0._capacitanceEffectList[iter_22_1] = nil
		elseif arg_22_2 == DungeonPuzzleCircuitEnum.status.error and iter_22_1.type >= DungeonPuzzleCircuitEnum.type.straight and iter_22_1.type <= DungeonPuzzleCircuitEnum.type.t_shape then
			gohelper.setActive(var_22_0.errorEffect, true)

			local var_22_2, var_22_3, var_22_4 = transformhelper.getLocalRotation(var_22_0.tf)

			transformhelper.setLocalRotation(var_22_0.errorEffect.transform, 0, 0, -var_22_4)

			if arg_22_0._clickItemMo == iter_22_1 then
				AudioMgr.instance:trigger(AudioEnum.PuzzleCircuit.play_ui_circuit_shortcircuit)
			end
		end
	end
end

function var_0_0._doEdit(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = DungeonPuzzleCircuitModel.instance:getEditIndex()

	if not var_23_0 or var_23_0 <= 0 then
		return false
	end

	local var_23_1 = DungeonPuzzleCircuitModel.instance:getData(arg_23_1, arg_23_2)

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftAlt) then
		if not var_23_1 then
			return true
		end

		var_23_1.type = 0

		arg_23_0:initItem(arg_23_1, arg_23_2)

		return true
	end

	if not UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) then
		return false
	end

	var_23_1 = var_23_1 or DungeonPuzzleCircuitModel.instance:_getMo(arg_23_1, arg_23_2)

	if var_23_0 >= DungeonPuzzleCircuitEnum.type.power1 and var_23_0 <= DungeonPuzzleCircuitEnum.type.t_shape then
		var_23_1.type = var_23_0

		arg_23_0:initItem(arg_23_1, arg_23_2)
	end

	return true
end

function var_0_0.onClose(arg_24_0)
	if arg_24_0._touch then
		TouchEventMgrHepler.remove(arg_24_0._touch)

		arg_24_0._touch = nil
	end
end

function var_0_0.onDestroyView(arg_25_0)
	return
end

return var_0_0
