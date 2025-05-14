module("modules.logic.versionactivity1_5.act142.view.game.Activity142ResultView", package.seeall)

local var_0_0 = class("Activity142ResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtclassnum = gohelper.findChildText(arg_1_0.viewGO, "txtFbName/#txt_classnum")
	arg_1_0._txtclassname = gohelper.findChildText(arg_1_0.viewGO, "txtFbName/#txt_classname")
	arg_1_0._goMainTargetItem = gohelper.findChild(arg_1_0.viewGO, "targets/#go_targetitem0")
	arg_1_0._gotargetitem = gohelper.findChild(arg_1_0.viewGO, "targets/#go_targetitem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:_btnquitgameOnClick()
end

function var_0_0._onEscape(arg_5_0)
	arg_5_0:_btnquitgameOnClick()
end

function var_0_0._btnquitgameOnClick(arg_6_0)
	Va3ChessController.instance:reGetActInfo(arg_6_0._gameResultQuit, arg_6_0)
end

function var_0_0._gameResultQuit(arg_7_0)
	arg_7_0:closeThis()
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameResultQuit)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._targetItemList = {}

	gohelper.setActive(arg_8_0._gotargetitem, false)
	gohelper.setActive(arg_8_0._goMainTargetItem, false)
	NavigateMgr.instance:addEscape(arg_8_0.viewName, arg_8_0._onEscape, arg_8_0)
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	local var_10_0 = Va3ChessModel.instance:getActId()
	local var_10_1 = Va3ChessModel.instance:getEpisodeId()

	if var_10_0 ~= nil and var_10_1 ~= nil then
		arg_10_0._episodeCfg = Va3ChessConfig.instance:getEpisodeCo(var_10_0, var_10_1)
	end

	arg_10_0:refreshUI()
end

function var_0_0.refreshUI(arg_11_0)
	if not arg_11_0._episodeCfg then
		return
	end

	arg_11_0._txtclassname.text = arg_11_0._episodeCfg.name
	arg_11_0._txtclassnum.text = arg_11_0._episodeCfg.orderId

	arg_11_0:refreshTaskConditions()
end

function var_0_0.refreshTaskConditions(arg_12_0)
	if not arg_12_0._episodeCfg then
		return
	end

	local var_12_0 = arg_12_0._episodeCfg.mainConfition
	local var_12_1 = #string.split(var_12_0, "|")
	local var_12_2 = arg_12_0:getOrCreateTaskItem(var_12_1, true)

	arg_12_0:refreshTaskItem(var_12_2, var_12_0, arg_12_0._episodeCfg.mainConditionStr, true)

	if not string.nilorempty(arg_12_0._episodeCfg.extStarCondition) then
		local var_12_3 = arg_12_0:getOrCreateTaskItem(var_12_1 + 1)

		arg_12_0:refreshTaskItem(var_12_3, arg_12_0._episodeCfg.extStarCondition, arg_12_0._episodeCfg.conditionStr, true)
	end
end

function var_0_0.getOrCreateTaskItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0._targetItemList[arg_13_1]

	if not var_13_0 then
		var_13_0 = arg_13_0:getUserDataTb_()
		var_13_0.go = gohelper.cloneInPlace(arg_13_2 and arg_13_0._goMainTargetItem or arg_13_0._gotargetitem, "taskitem_" .. tostring(arg_13_1))
		var_13_0.txtTaskDesc = gohelper.findChildText(var_13_0.go, "txt_taskdesc")
		var_13_0.goFinish = gohelper.findChild(var_13_0.go, "result/go_finish")
		var_13_0.goUnFinish = gohelper.findChild(var_13_0.go, "result/go_unfinish")
		var_13_0.goResult = gohelper.findChild(var_13_0.go, "result")
		arg_13_0._targetItemList[arg_13_1] = var_13_0
	end

	return var_13_0
end

function var_0_0.refreshTaskItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	gohelper.setActive(arg_14_1.go, true)

	arg_14_1.txtTaskDesc.text = arg_14_3

	local var_14_0 = arg_14_4 and not string.nilorempty(arg_14_2)

	gohelper.setActive(arg_14_1.goResult, var_14_0)

	if var_14_0 then
		local var_14_1 = Va3ChessModel.instance:getActId()
		local var_14_2 = Activity142Helper.checkConditionIsFinish(arg_14_2, var_14_1)

		gohelper.setActive(arg_14_1.goFinish, var_14_2)
		gohelper.setActive(arg_14_1.goUnFinish, not var_14_2)
	end
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	NavigateMgr.instance:removeEscape(arg_16_0.viewName, arg_16_0._onEscape, arg_16_0)
end

return var_0_0
