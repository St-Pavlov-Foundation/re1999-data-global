module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameStateView", package.seeall)

local var_0_0 = class("AiZiLaGameStateView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnfullClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_fullClose")
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_PanelBG")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "#txt_Title")
	arg_1_0._gostateItem = gohelper.findChild(arg_1_0.viewGO, "#go_stateItem")
	arg_1_0._goState = gohelper.findChild(arg_1_0.viewGO, "#go_stateItem/#go_State")
	arg_1_0._goeffdown = gohelper.findChild(arg_1_0.viewGO, "#go_stateItem/#go_State/#go_effdown")
	arg_1_0._goeffup = gohelper.findChild(arg_1_0.viewGO, "#go_stateItem/#go_State/#go_effup")
	arg_1_0._txteffDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_stateItem/#go_State/#txt_effDesc")
	arg_1_0._scrollequip = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_equip")
	arg_1_0._goEquip = gohelper.findChild(arg_1_0.viewGO, "#scroll_equip/Viewport/Content/#go_Equip")
	arg_1_0._goequipState = gohelper.findChild(arg_1_0.viewGO, "#scroll_equip/Viewport/Content/#go_equipState")
	arg_1_0._goEffect = gohelper.findChild(arg_1_0.viewGO, "#scroll_equip/Viewport/Content/#go_Effect")
	arg_1_0._gogameState = gohelper.findChild(arg_1_0.viewGO, "#scroll_equip/Viewport/Content/#go_gameState")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnfullClose:AddClickListener(arg_2_0._btnfullCloseOnClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnfullClose:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._btnfullCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnCloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	transformhelper.setLocalPos(arg_6_0._gostateItem.transform, 0, 0, 0)
	gohelper.setActive(arg_6_0._gostateItem, false)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	if arg_8_0.viewContainer then
		NavigateMgr.instance:addEscape(arg_8_0.viewContainer.viewName, arg_8_0.closeThis, arg_8_0)
	end

	arg_8_0:addEventCb(AiZiLaController.instance, AiZiLaEvent.ExitGame, arg_8_0.closeThis, arg_8_0)
	arg_8_0:refreshUI()
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

function var_0_0.refreshUI(arg_11_0)
	local var_11_0 = arg_11_0:_getEquipStateDataList()
	local var_11_1 = arg_11_0:_getGameStateDataList()

	gohelper.setActive(arg_11_0._goEquip, var_11_0 and #var_11_0 > 0)
	gohelper.setActive(arg_11_0._goEffect, var_11_1 and #var_11_1 > 0)
	gohelper.CreateObjList(arg_11_0, arg_11_0._onEquipStateItem, var_11_0, arg_11_0._goequipState, arg_11_0._gostateItem, AiZiLaGameStateItem)
	gohelper.CreateObjList(arg_11_0, arg_11_0._onGameStateItem, var_11_1, arg_11_0._gogameState, arg_11_0._gostateItem, AiZiLaGameStateItem)
end

function var_0_0._getEquipStateDataList(arg_12_0)
	local var_12_0 = {}

	tabletool.addValues(var_12_0, AiZiLaModel.instance:getEquipMOList())

	return var_12_0
end

function var_0_0._getGameStateDataList(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = AiZiLaGameModel.instance:getBuffIdList() or {}
	local var_13_2 = AiZiLaGameModel.instance:getActivityID()
	local var_13_3 = AiZiLaConfig.instance

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		local var_13_4 = var_13_3:getBuffCo(var_13_2, iter_13_1)

		if var_13_4 then
			table.insert(var_13_0, var_13_4)
		else
			logError(string.format("[export_状态] buff配置找不到。 activityId:%s buffId:%s", var_13_2, iter_13_1))
		end
	end

	return var_13_0
end

function var_0_0._onEquipStateItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_2:getConfig()

	if var_14_0 then
		local var_14_1 = {
			var_14_0.name,
			var_14_0.effectDesc
		}
		local var_14_2 = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a5_aizila_role_state_effect_desc"), var_14_1)

		arg_14_1:setStateStr(var_14_2)
	end

	arg_14_1:setShowUp(true)
end

function var_0_0._onGameStateItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_2

	if var_15_0 then
		arg_15_1:setStateStr(var_15_0.effectDesc)
		arg_15_1:setShowUp(var_15_0.reduction ~= 1)
	end
end

return var_0_0
