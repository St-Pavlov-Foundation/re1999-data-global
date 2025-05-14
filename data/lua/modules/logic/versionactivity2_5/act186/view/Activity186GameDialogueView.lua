module("modules.logic.versionactivity2_5.act186.view.Activity186GameDialogueView", package.seeall)

local var_0_0 = class("Activity186GameDialogueView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goRight = gohelper.findChild(arg_1_0.viewGO, "root/right")
	arg_1_0.rightAnim = arg_1_0.goRight:GetComponent(gohelper.Type_Animator)
	arg_1_0.txtDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/right/desc")
	arg_1_0.txtContent = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/#goRole/bottom/#txt_Dialouge")
	arg_1_0.options = {}
	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/#btn_close")
	arg_1_0.goOptions = gohelper.findChild(arg_1_0.viewGO, "root/right/options")
	arg_1_0.goRewards = gohelper.findChild(arg_1_0.viewGO, "root/right/rewards")
	arg_1_0.goReward1 = gohelper.findChild(arg_1_0.viewGO, "root/right/rewards/reward1")
	arg_1_0.txtRewardNum1 = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/right/rewards/reward1/#txt_num")
	arg_1_0.goReward2 = gohelper.findChild(arg_1_0.viewGO, "root/right/rewards/reward2")
	arg_1_0.simageReward2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/right/rewards/reward2/icon")
	arg_1_0.txtRewardNum2 = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/right/rewards/reward2/#txt_num")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClose, arg_2_0.onClickBtnClose, arg_2_0)
	arg_2_0:addEventCb(Activity186Controller.instance, Activity186Event.FinishGame, arg_2_0.onFinishGame, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickBtnClose(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.onClickOption(arg_6_0, arg_6_1)
	if arg_6_0.gameStatus ~= Activity186Enum.GameStatus.Playing then
		return
	end

	if arg_6_0._selectIndex ~= arg_6_1 then
		arg_6_0._selectIndex = arg_6_1

		arg_6_0:updateSelect()
	end

	if not arg_6_0.questionConfig then
		return
	end

	local var_6_0 = arg_6_0.questionConfig["rewardId" .. arg_6_1]

	if var_6_0 == 0 then
		return
	end

	arg_6_0.txtDesc.text = arg_6_0.questionConfig["feedback" .. arg_6_1]
	arg_6_0.txtContent.text = arg_6_0.questionConfig.hanzhangline4

	arg_6_0:showResult(var_6_0)
	Activity186Rpc.instance:sendFinishAct186ATypeGameRequest(arg_6_0.actId, arg_6_0.gameId, var_6_0)
end

function var_0_0.onFinishGame(arg_7_0)
	arg_7_0:checkGameNotOnline()
end

function var_0_0.checkGameNotOnline(arg_8_0)
	local var_8_0 = Activity186Model.instance:getById(arg_8_0.actId)

	if not var_8_0 then
		return
	end

	if not var_8_0:getGameInfo(arg_8_0.gameId) then
		return
	end

	if not var_8_0:isGameOnline(arg_8_0.gameId) then
		arg_8_0:closeThis()
	end
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:refreshParam()
	arg_9_0:refreshView()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:refreshParam()
	arg_10_0:refreshView()
end

function var_0_0.refreshParam(arg_11_0)
	arg_11_0.actId = arg_11_0.viewParam.activityId
	arg_11_0.gameId = arg_11_0.viewParam.gameId
	arg_11_0.gameStatus = arg_11_0.viewParam.gameStatus
end

function var_0_0.refreshView(arg_12_0)
	if arg_12_0.gameStatus == Activity186Enum.GameStatus.Playing then
		arg_12_0:_showDeadline()
		arg_12_0.rightAnim:Play("open")

		local var_12_0 = Activity186Model.instance:getById(arg_12_0.actId):getQuestionConfig(arg_12_0.gameId)

		arg_12_0.questionConfig = var_12_0
		arg_12_0.txtDesc.text = var_12_0.question

		AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_mln_unlock)
		arg_12_0:updateOptions(var_12_0)
	end
end

function var_0_0.updateOptions(arg_13_0, arg_13_1)
	for iter_13_0 = 1, 3 do
		arg_13_0:updateOption(iter_13_0, arg_13_1)
	end

	arg_13_0:updateSelect()
end

function var_0_0.updateSelect(arg_14_0)
	for iter_14_0 = 1, 3 do
		local var_14_0 = arg_14_0:getOrCreateOption(iter_14_0)

		gohelper.setActive(var_14_0.goNormal, arg_14_0._selectIndex ~= iter_14_0)
		gohelper.setActive(var_14_0.goSelect, arg_14_0._selectIndex == iter_14_0)
	end
end

function var_0_0.updateOption(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:getOrCreateOption(arg_15_1)
	local var_15_1 = arg_15_2["answer" .. arg_15_1]

	if string.nilorempty(var_15_1) then
		gohelper.setActive(var_15_0.go, false)

		return
	end

	gohelper.setActive(var_15_0.go, true)

	var_15_0.txtNormal.text = var_15_1
	var_15_0.txtSelect.text = var_15_1
end

function var_0_0.getOrCreateOption(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.options[arg_16_1]

	if not var_16_0 then
		var_16_0 = arg_16_0:getUserDataTb_()
		var_16_0.go = gohelper.findChild(arg_16_0.viewGO, "root/right/options/item" .. arg_16_1)
		var_16_0.goNormal = gohelper.findChild(var_16_0.go, "normal")
		var_16_0.goSelect = gohelper.findChild(var_16_0.go, "select")
		var_16_0.txtNormal = gohelper.findChildTextMesh(var_16_0.goNormal, "#txt_dec")
		var_16_0.txtSelect = gohelper.findChildTextMesh(var_16_0.goSelect, "#txt_dec")
		var_16_0.btn = gohelper.findButtonWithAudio(var_16_0.go)

		var_16_0.btn:AddClickListener(arg_16_0.onClickOption, arg_16_0, arg_16_1)

		arg_16_0.options[arg_16_1] = var_16_0
	end

	return var_16_0
end

function var_0_0.showResult(arg_17_0, arg_17_1)
	arg_17_0.gameStatus = Activity186Enum.GameStatus.Result

	arg_17_0.rightAnim:Play("finish")

	local var_17_0 = Activity186Config.instance:getGameRewardConfig(1, arg_17_1)

	arg_17_0:refreshReward(var_17_0.bonus)
end

function var_0_0.refreshReward(arg_18_0, arg_18_1)
	local var_18_0 = GameUtil.splitString2(arg_18_1, true)
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		if iter_18_1[1] ~= 26 then
			table.insert(var_18_1, iter_18_1)
		end
	end

	local var_18_2 = var_18_1[1]
	local var_18_3 = var_18_1[2]

	if var_18_2 then
		arg_18_0.txtRewardNum1.text = string.format("×%s", var_18_2[3])

		gohelper.setActive(arg_18_0.goReward1, true)
	else
		gohelper.setActive(arg_18_0.goReward1, false)
	end

	if var_18_3 then
		gohelper.setActive(arg_18_0.goReward2, true)

		local var_18_4, var_18_5 = ItemModel.instance:getItemConfigAndIcon(var_18_3[1], var_18_3[2], true)

		arg_18_0.simageReward2:LoadImage(var_18_5)

		arg_18_0.txtRewardNum2.text = string.format("×%s", var_18_3[3])
	else
		gohelper.setActive(arg_18_0.goReward2, false)
	end
end

function var_0_0._showDeadline(arg_19_0)
	arg_19_0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(arg_19_0._onRefreshDeadline, arg_19_0)
	TaskDispatcher.runRepeat(arg_19_0._onRefreshDeadline, arg_19_0, 1)
end

function var_0_0._onRefreshDeadline(arg_20_0)
	arg_20_0:checkGameNotOnline()
end

function var_0_0.onClose(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._onRefreshDeadline, arg_21_0)
end

function var_0_0.onDestroyView(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._onRefreshDeadline, arg_22_0)

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.options) do
		iter_22_1.btn:RemoveClickListener()
	end
end

return var_0_0
