module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErDispatchItem", package.seeall)

local var_0_0 = class("MoLiDeErDispatchItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._goItemList = gohelper.findChild(arg_1_0.viewGO, "#go_ItemList")
	arg_1_0._goItem = gohelper.findChild(arg_1_0.viewGO, "#go_ItemList/#go_Item")
	arg_1_0._simageProp = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ItemList/#go_Item/#simage_Prop")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "#go_ItemList/#go_Item/#txt_Num")
	arg_1_0._goAction = gohelper.findChild(arg_1_0.viewGO, "#go_Action")
	arg_1_0._goLightBG = gohelper.findChild(arg_1_0.viewGO, "#go_Action/#go_LightBG")
	arg_1_0._goLightBgFx = gohelper.findChild(arg_1_0.viewGO, "#go_Action/#go_LightBG/#go_LightBgFx")
	arg_1_0._txtActionNum = gohelper.findChildText(arg_1_0.viewGO, "#go_Action/#txt_ActionNum")
	arg_1_0._txtActionNumChange = gohelper.findChildText(arg_1_0.viewGO, "#go_Action/#txt_ActionNum/#txt_ActionNumChange")
	arg_1_0._goDispatch = gohelper.findChild(arg_1_0.viewGO, "#go_Dispatch")
	arg_1_0._goExpand = gohelper.findChild(arg_1_0.viewGO, "#go_Dispatch/#go_Expand")
	arg_1_0._goSelectRole = gohelper.findChild(arg_1_0.viewGO, "#go_Dispatch/#go_Expand/#go_SelectRole")
	arg_1_0._goSelected = gohelper.findChild(arg_1_0.viewGO, "#go_Dispatch/#go_Expand/#go_SelectRole/image_HeadBG/#go_Selected")
	arg_1_0._simageHead = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Dispatch/#go_Expand/#go_SelectRole/image_HeadBG/image/#simage_Head")
	arg_1_0._goCD = gohelper.findChild(arg_1_0.viewGO, "#go_Dispatch/#go_Expand/#go_SelectRole/image_HeadBG/#go_CD")
	arg_1_0._txtTeamDescr = gohelper.findChildText(arg_1_0.viewGO, "#go_Dispatch/#go_Expand/#txt_TeamDescr")
	arg_1_0._txtTeamName = gohelper.findChildText(arg_1_0.viewGO, "#go_Dispatch/#go_Expand/#txt_TeamDescr/#txt_TeamName")
	arg_1_0._goRole = gohelper.findChild(arg_1_0.viewGO, "#go_Dispatch/#go_Role")
	arg_1_0._btnDispatch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Dispatch/#btn_Dispatch")
	arg_1_0._btnWithdraw = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Dispatch/#btn_Withdraw")
	arg_1_0._goBG1 = gohelper.findChild(arg_1_0.viewGO, "#go_Dispatch/#btn_Dispatch/#go_BG1")
	arg_1_0._goBG2 = gohelper.findChild(arg_1_0.viewGO, "#go_Dispatch/#btn_Dispatch/#go_BG2")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "#go_Tips")
	arg_1_0._btnUseItem = gohelper.findChildButton(arg_1_0.viewGO, "#go_Tips/#btn_Use")
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "#go_Tips/#txt_Tips")
	arg_1_0._goDispatchTitle = gohelper.findChild(arg_1_0.viewGO, "#go_Dispatch/#go_DispatchTitle")
	arg_1_0._goWithdrawTitle = gohelper.findChild(arg_1_0.viewGO, "#go_Dispatch/#go_Expand/#go_WithdrawTitle")
	arg_1_0._btnResetSelect = gohelper.findChildButton(arg_1_0.viewGO, "#btn_ResetSelect")
	arg_1_0._imageBg = gohelper.findChildImage(arg_1_0.viewGO, "#go_Dispatch")
	arg_1_0._imageBgFrame = gohelper.findChildImage(arg_1_0.viewGO, "#go_Dispatch/image_Frame")
	arg_1_0._goActionChangeItem = gohelper.findChildText(arg_1_0.viewGO, "#go_Action/#go_Num/#txt_Num")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnDispatch:AddClickListener(arg_2_0._btnDispatchOnClick, arg_2_0)
	arg_2_0._btnWithdraw:AddClickListener(arg_2_0._btnWithdrawOnClick, arg_2_0)
	arg_2_0._btnResetSelect:AddClickListener(arg_2_0._btnResetSelectOnClick, arg_2_0)
	arg_2_0._btnUseItem:AddClickListener(arg_2_0._btnUseItemOnClick, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameItemSelect, arg_2_0.onItemSelect, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameTeamSelect, arg_2_0.onTeamSelect, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameOptionSelect, arg_2_0.onOptionSelect, arg_2_0)
	arg_2_0:addEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameUseItem, arg_2_0.onUseItem, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnDispatch:RemoveClickListener()
	arg_3_0._btnWithdraw:RemoveClickListener()
	arg_3_0._btnResetSelect:RemoveClickListener()
	arg_3_0._btnUseItem:RemoveClickListener()
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameItemSelect, arg_3_0.onItemSelect, arg_3_0)
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameTeamSelect, arg_3_0.onTeamSelect, arg_3_0)
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameOptionSelect, arg_3_0.onOptionSelect, arg_3_0)
	arg_3_0:removeEventCb(MoLiDeErGameController.instance, MoLiDeErEvent.GameUseItem, arg_3_0.onUseItem, arg_3_0)
end

function var_0_0._btnDispatchOnClick(arg_4_0)
	local var_4_0 = MoLiDeErModel.instance:getCurActId()
	local var_4_1 = MoLiDeErModel.instance:getCurEpisodeId()
	local var_4_2 = MoLiDeErGameModel.instance:getSelectTeamId()
	local var_4_3 = MoLiDeErGameModel.instance:getSelectOptionId()
	local var_4_4 = MoLiDeErGameModel.instance:getSelectEventId()

	MoLiDeErGameController.instance:dispatchTeam(var_4_0, var_4_1, var_4_4, var_4_2, var_4_3, var_4_4)
end

function var_0_0._btnWithdrawOnClick(arg_5_0)
	local var_5_0 = MoLiDeErGameModel.instance:getSelectEventId()
	local var_5_1 = MoLiDeErGameModel.instance:getCurGameInfo():getEventInfo(var_5_0)

	if not var_5_1 or var_5_1.teamId == nil or var_5_1.teamId == 0 then
		logError("莫莉德尔 角色活动 撤回小队id为空")

		return
	end

	local var_5_2 = var_5_1.teamId

	MoLiDeErGameController.instance:withDrawTeam(var_5_2)
end

function var_0_0._btnResetSelectOnClick(arg_6_0)
	MoLiDeErGameModel.instance:setSelectItemId(nil)

	if arg_6_0._state == MoLiDeErEnum.DispatchState.Main or arg_6_0._state == MoLiDeErEnum.DispatchState.Dispatch and arg_6_0._optionId == nil then
		MoLiDeErGameModel.instance:setSelectTeamId(nil)
	end
end

function var_0_0._btnUseItemOnClick(arg_7_0)
	local var_7_0 = MoLiDeErGameModel.instance:getSelectItemId()

	if var_7_0 == nil then
		return
	end

	if MoLiDeErGameModel.instance:getCurGameInfo():canEquipUse(var_7_0) == false then
		GameFacade.showToast(ToastEnum.Act194EquipCountNotEnough)

		return
	end

	local var_7_1 = MoLiDeErModel.instance:getCurActId()
	local var_7_2 = MoLiDeErModel.instance:getCurEpisodeId()

	MoLiDeErGameController.instance:useItem(var_7_1, var_7_2, var_7_0)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._equipItemList = {}
	arg_8_0._teamItemList = {}
	arg_8_0._useActionChangeItemList = {}
	arg_8_0._unUseActionChangeItemList = {}
	arg_8_0._expandTeamItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_8_0._goSelectRole, MoLiDeErTeamItem)
	arg_8_0._showItemList = {}

	arg_8_0:_initState()
end

function var_0_0._initState(arg_9_0)
	gohelper.setActive(arg_9_0._goItem, false)
	gohelper.setActive(arg_9_0._goRole, false)
	gohelper.setActive(arg_9_0._goExpand, false)
	gohelper.setActive(arg_9_0._goTips, false)
	gohelper.setActive(arg_9_0._goBG2.gameObject, false)
	gohelper.setActive(arg_9_0._btnResetSelect.gameObject, false)
	gohelper.setActive(arg_9_0._imageBgFrame.gameObject, true)
	gohelper.setActive(arg_9_0._goActionChangeItem.transform.parent.gameObject, false)

	arg_9_0._imageBg.enabled = false
end

function var_0_0.setData(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0._state = arg_10_1
	arg_10_0._eventId = arg_10_2
	arg_10_0._optionId = arg_10_3

	arg_10_0:refreshUI()
end

function var_0_0.onOptionSelect(arg_11_0, arg_11_1)
	arg_11_0._optionId = arg_11_1
end

function var_0_0.refreshUI(arg_12_0)
	arg_12_0:refreshItem()
	arg_12_0:refreshTeam()
	arg_12_0:refreshState()
end

function var_0_0.refreshState(arg_13_0)
	local var_13_0 = arg_13_0._optionId ~= nil and arg_13_0._optionId ~= 0

	gohelper.setActive(arg_13_0._goBG2, var_13_0 and arg_13_0._selectTeamId ~= nil)

	local var_13_1 = arg_13_0._state == MoLiDeErEnum.DispatchState.Dispatch and var_13_0

	gohelper.setActive(arg_13_0._btnDispatch, var_13_1)
	gohelper.setActive(arg_13_0._txtActionNumChange, var_13_1)
	gohelper.setActive(arg_13_0._goDispatchTitle, var_13_1)
	gohelper.setActive(arg_13_0._goAction, var_13_1 or arg_13_0._state == MoLiDeErEnum.DispatchState.Main)

	local var_13_2 = arg_13_0._state == MoLiDeErEnum.DispatchState.Dispatching and var_13_0

	gohelper.setActive(arg_13_0._btnWithdraw, var_13_2)
	gohelper.setActive(arg_13_0._goWithdrawTitle, var_13_2)

	arg_13_0._imageBg.enabled = arg_13_0._state == MoLiDeErEnum.DispatchState.Dispatch or arg_13_0._state == MoLiDeErEnum.DispatchState.Dispatching

	if var_13_1 then
		local var_13_3 = MoLiDeErGameModel.instance:getCurExecutionCost()

		arg_13_0._txtActionNumChange.text = MoLiDeErHelper.getExecutionCostStr(var_13_3)

		gohelper.setActive(arg_13_0._goLightBgFx, var_13_3 ~= 0)
	else
		gohelper.setActive(arg_13_0._goLightBgFx, false)
	end

	arg_13_0:refreshActionCount()
end

function var_0_0.refreshActionCount(arg_14_0)
	local var_14_0 = MoLiDeErGameModel.instance:getCurGameInfo()
	local var_14_1 = var_14_0.leftRoundEnergy
	local var_14_2 = var_14_0.previousRoundEnergy
	local var_14_3 = arg_14_0._goActionChangeItem

	if arg_14_0._state == MoLiDeErEnum.DispatchState.Main and var_14_2 and var_14_2 ~= var_14_1 then
		TaskDispatcher.cancelTask(arg_14_0.onActionNumChangeEnd, arg_14_0)

		var_14_3.text = MoLiDeErHelper.getExecutionCostStr(var_14_1 - var_14_2)

		gohelper.setActive(var_14_3.transform.parent.gameObject, true)
		TaskDispatcher.runDelay(arg_14_0.onActionNumChangeEnd, arg_14_0, 1)

		var_14_0.previousRoundEnergy = var_14_0.leftRoundEnergy

		AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_gudu_bubble_click)
	else
		gohelper.setActive(var_14_3.transform.parent.gameObject, false)
	end

	arg_14_0._txtActionNum.text = tostring(var_14_1)
end

function var_0_0.onActionNumChangeEnd(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0.onActionNumChangeEnd, arg_15_0)
	gohelper.setActive(arg_15_0._goActionChangeItem.transform.parent.gameObject, false)
end

function var_0_0.refreshItem(arg_16_0)
	if arg_16_0._showItemList and arg_16_0._showItemList[1] then
		arg_16_0:refreshItemCount()
		TaskDispatcher.cancelTask(arg_16_0.refreshItemWithHide, arg_16_0)

		if arg_16_0._state ~= MoLiDeErEnum.DispatchState.Main then
			local var_16_0 = MoLiDeErGameModel.instance:getCurGameInfo()

			if var_16_0 and var_16_0.newFinishEventList and var_16_0.newFinishEventList[1] then
				return
			end
		end

		TaskDispatcher.runDelay(arg_16_0.refreshItemWithHide, arg_16_0, MoLiDeErEnum.DelayTime.ItemHideOrAppear)
	else
		arg_16_0:refreshItemWithHide()
	end
end

function var_0_0.refreshItemCount(arg_17_0, arg_17_1)
	local var_17_0 = MoLiDeErGameModel.instance:getCurGameInfo()

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._showItemList) do
		local var_17_1 = iter_17_1.itemId

		if var_17_0:getEquipInfo(var_17_1) == nil then
			iter_17_1:reset()

			return
		end

		iter_17_1:refreshUI()

		if arg_17_1 then
			iter_17_1:setUseFxState(false)
		end
	end
end

function var_0_0.refreshItemWithHide(arg_18_0)
	arg_18_0._showItemList = {}

	local var_18_0 = MoLiDeErGameModel.instance:getCurGameInfo().itemInfos

	if var_18_0 == nil then
		gohelper.setActive(arg_18_0._goItemList, false)

		return
	end

	local var_18_1 = #var_18_0

	if var_18_1 <= 0 then
		gohelper.setActive(arg_18_0._goItemList, false)

		return
	end

	local var_18_2 = {}
	local var_18_3 = 0

	for iter_18_0 = 1, var_18_1 do
		local var_18_4 = var_18_0[iter_18_0]

		if var_18_4.quantity > 0 then
			table.insert(var_18_2, var_18_4)

			var_18_3 = var_18_3 + 1
		end
	end

	if var_18_3 <= 0 then
		gohelper.setActive(arg_18_0._goItemList, false)
		gohelper.setActive(arg_18_0._goTips, false)

		return
	end

	gohelper.setActive(arg_18_0._goItemList, true)

	local var_18_5 = arg_18_0._equipItemList
	local var_18_6 = #var_18_5

	for iter_18_1 = 1, var_18_3 do
		local var_18_7

		if var_18_6 < iter_18_1 then
			local var_18_8 = gohelper.clone(arg_18_0._goItem, arg_18_0._goItemList)

			var_18_7 = MonoHelper.addNoUpdateLuaComOnceToGo(var_18_8, MoLiDeErEquipItem)

			table.insert(var_18_5, var_18_7)
		else
			var_18_7 = var_18_5[iter_18_1]
		end

		local var_18_9 = var_18_2[iter_18_1]

		var_18_7:setActive(true)
		var_18_7:setData(var_18_9.itemId)
		var_18_7:setUseFxState(false)
		table.insert(arg_18_0._showItemList, var_18_7)
	end

	if var_18_3 < var_18_6 then
		for iter_18_2 = var_18_3 + 1, var_18_6 do
			var_18_5[iter_18_2]:reset()
		end
	end
end

function var_0_0.onUseItem(arg_19_0, arg_19_1)
	if arg_19_0.viewGO.activeSelf == false then
		return
	end

	local var_19_0 = arg_19_0._equipItemList
	local var_19_1 = #var_19_0

	for iter_19_0 = 1, var_19_1 do
		local var_19_2 = var_19_0[iter_19_0]

		if var_19_2.viewGO.activeSelf and var_19_2.itemId == arg_19_1 then
			var_19_2:setUseFxState(true)
			AudioMgr.instance:trigger(AudioEnum2_8.MoLiDeEr.play_ui_molu_exit_appear)
		end
	end

	if MoLiDeErGameModel.instance:getCurGameInfo():getEquipInfo(arg_19_1).quantity <= 0 then
		gohelper.setActive(arg_19_0._goTips, false)
	end

	if arg_19_0._state == MoLiDeErEnum.DispatchState.Main then
		return
	end

	arg_19_0:refreshItem()
	arg_19_0:refreshState()
end

function var_0_0.refreshTeam(arg_20_0)
	if arg_20_0._state == MoLiDeErEnum.DispatchState.Dispatching then
		arg_20_0:refreshDispatchingTeam()
	else
		arg_20_0:refreshDispatchTeam()
	end
end

function var_0_0.refreshDispatchTeam(arg_21_0)
	local var_21_0 = MoLiDeErGameModel.instance:getCurGameInfo().teamInfos

	if var_21_0 == nil then
		gohelper.setActive(arg_21_0._goDispatch, false)

		return
	end

	local var_21_1 = #var_21_0

	if var_21_1 <= 0 then
		gohelper.setActive(arg_21_0._goDispatch, false)

		return
	end

	local var_21_2 = arg_21_0._teamItemList
	local var_21_3 = #var_21_2

	for iter_21_0 = 1, var_21_1 do
		local var_21_4

		if var_21_3 < iter_21_0 then
			local var_21_5 = gohelper.clone(arg_21_0._goRole, arg_21_0._goDispatch)

			gohelper.setSiblingBefore(var_21_5, arg_21_0._btnDispatch.gameObject)

			var_21_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_21_5, MoLiDeErTeamItem)

			table.insert(var_21_2, var_21_4)
		else
			var_21_4 = var_21_2[iter_21_0]
		end

		local var_21_6 = var_21_0[iter_21_0]

		var_21_4:setActive(true)
		var_21_4:setData(var_21_6, arg_21_0._state)
		var_21_4:setSelect(false)
	end

	if var_21_1 < var_21_3 then
		for iter_21_1 = var_21_1 + 1, var_21_3 do
			local var_21_7 = var_21_2[iter_21_1]

			var_21_7:setActive(false)
			var_21_7:clear()
		end
	end
end

function var_0_0.refreshDispatchingTeam(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0._teamItemList) do
		iter_22_1:setActive(false)
	end

	local var_22_0 = MoLiDeErGameModel.instance:getSelectEventId()
	local var_22_1 = MoLiDeErGameModel.instance:getCurGameInfo():getEventInfo(var_22_0)

	if var_22_1 then
		arg_22_0:showTeamTips(true, var_22_1.teamId)
	end
end

function var_0_0.onItemSelect(arg_23_0, arg_23_1)
	arg_23_0:showItemTips(arg_23_1 ~= nil, arg_23_1)

	arg_23_0._selectItemId = arg_23_1

	if arg_23_0.viewGO.activeSelf == false then
		return
	end

	arg_23_0:refreshState()
end

function var_0_0.onTeamSelect(arg_24_0, arg_24_1)
	if arg_24_0.viewGO.activeSelf == false then
		return
	end

	arg_24_0:showTeamTips(arg_24_1 ~= nil, arg_24_1)

	if arg_24_0._state == MoLiDeErEnum.DispatchState.Dispatch then
		for iter_24_0, iter_24_1 in ipairs(arg_24_0._teamItemList) do
			iter_24_1:refreshState()
		end
	end

	arg_24_0._selectTeamId = arg_24_1

	arg_24_0:refreshState()
end

function var_0_0.showItemTips(arg_25_0, arg_25_1, arg_25_2)
	gohelper.setActive(arg_25_0._goTips, arg_25_1)
	gohelper.setActive(arg_25_0._btnResetSelect, arg_25_1)

	if arg_25_1 == false then
		return
	end

	local var_25_0 = MoLiDeErConfig.instance:getItemConfig(arg_25_2)
	local var_25_1 = var_25_0.isUse == MoLiDeErEnum.ItemType.Initiative

	gohelper.setActive(arg_25_0._btnUseItem, var_25_1)

	local var_25_2 = MoLiDeErConfig.instance:getBuffConfig(tonumber(var_25_0.buffId))

	arg_25_0._txtTips.text = var_25_2.effectDesc
end

function var_0_0.setTeamSelect(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0._teamItemList) do
		local var_26_0 = iter_26_1.teamId == arg_26_1

		if var_26_0 then
			gohelper.setSiblingAfter(arg_26_0._goExpand, iter_26_1.viewGO)
		end

		iter_26_1:setSelect(var_26_0)
	end
end

function var_0_0.showTeamTips(arg_27_0, arg_27_1, arg_27_2)
	gohelper.setActive(arg_27_0._goExpand, arg_27_1)

	if arg_27_0._state == MoLiDeErEnum.DispatchState.Main or arg_27_0._state == MoLiDeErEnum.DispatchState.Dispatch and arg_27_0._optionId == nil and arg_27_0._optionId ~= 0 then
		gohelper.setActive(arg_27_0._btnResetSelect, arg_27_1)
	end

	arg_27_0:setTeamSelect(arg_27_2)

	if arg_27_1 == false then
		return
	end

	local var_27_0 = MoLiDeErConfig.instance:getTeamConfig(arg_27_2)

	arg_27_0._txtTeamName.text = var_27_0.name

	local var_27_1 = arg_27_0._expandTeamItem

	var_27_1:setActive(true)

	local var_27_2 = MoLiDeErGameModel.instance:getCurGameInfo():getTeamInfo(arg_27_2)

	var_27_1:setData(var_27_2, arg_27_0._state)

	if not not string.nilorempty(var_27_0.buffId) then
		arg_27_0._txtTeamDescr.text = ""

		return
	end

	local var_27_3 = MoLiDeErConfig.instance:getBuffConfig(tonumber(var_27_0.buffId))

	arg_27_0._txtTeamDescr.text = var_27_3.effectDesc
end

function var_0_0.onDestroy(arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0.onActionNumChangeEnd, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0.refreshItemWithHide, arg_28_0)
end

return var_0_0
