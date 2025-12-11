module("modules.logic.survival.view.shelter.SummaryAct.SurvivalSummaryActView", package.seeall)

local var_0_0 = class("SurvivalSummaryActView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._goplayerbubble = gohelper.findChild(arg_1_0.viewGO, "Bubble/#go_player_Bubble")
	arg_1_0._txtBubble = gohelper.findChildText(arg_1_0.viewGO, "Bubble/#go_player_Bubble/root/#txt_Bubble")
	arg_1_0.SurvivalSummaryNpcHUD = gohelper.findChild(arg_1_0.viewGO, "Bubble/npc/#go_SurvivalSummaryNpcHUD")

	gohelper.setActive(arg_1_0.SurvivalSummaryNpcHUD, false)

	arg_1_0.reputationList = gohelper.findChild(arg_1_0.viewGO, "reputationList")
	arg_1_0.reputationItem = gohelper.findChild(arg_1_0.reputationList, "Viewport/Content/reputationItem")

	gohelper.setActive(arg_1_0.reputationItem, false)
	arg_1_0:createReputationListComp()
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_4_0)
	if not arg_4_0.isClickClose and (not arg_4_0.popupFlow or arg_4_0.popupFlow:isFlowDone()) then
		if arg_4_0.survivalSummaryActNpcWork then
			arg_4_0.survivalSummaryActNpcWork:playCloseAnim()
		end

		TaskDispatcher.runDelay(arg_4_0.closeThis, arg_4_0, 0.2)

		arg_4_0.isClickClose = true

		return
	end
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0.isClickClose = nil
	arg_5_0.npcDataList = SurvivalMapHelper.instance:getScene().actProgress.npcDataList

	local var_5_0 = ""

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.npcDataList) do
		var_5_0 = string.format("%s,%s", var_5_0, iter_5_1.config.name)
	end

	local var_5_1 = {}

	for iter_5_2, iter_5_3 in ipairs(arg_5_0.npcDataList) do
		table.insert(var_5_1, iter_5_3.config.name)
	end

	local var_5_2 = table.concat(var_5_1, luaLang("sep_overseas"))

	arg_5_0._txtBubble.text = GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalSummaryActView_1"), {
		#arg_5_0.npcDataList,
		var_5_2
	})
	arg_5_0.popupFlow = SurvivalDecreeVoteFlowSequence.New()

	arg_5_0.popupFlow:registerDoneListener(arg_5_0.onDone, arg_5_0)
	arg_5_0:buildPlayerWork()
	arg_5_0:buildNpcWork()
	arg_5_0:buildDelay(2)
	arg_5_0.popupFlow:start()
	arg_5_0:refreshReputationListComp()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideSurvivalSummaryActStart)
end

function var_0_0.onClose(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.closeThis, arg_6_0)
end

function var_0_0.onDestroyView(arg_7_0)
	if arg_7_0.popupFlow then
		arg_7_0.popupFlow:destroy()

		arg_7_0.popupFlow = nil
	end

	SurvivalController.instance:exitMap()
end

function var_0_0.buildPlayerWork(arg_8_0)
	local var_8_0 = {
		goBubble = arg_8_0._goplayerbubble
	}

	arg_8_0.popupFlow:addWork(SurvivalSummaryActBuildPlayerWork.New(var_8_0))
end

function var_0_0.buildNpcWork(arg_9_0)
	local var_9_0 = {
		SurvivalSummaryNpcHUD = arg_9_0.SurvivalSummaryNpcHUD
	}

	arg_9_0.survivalSummaryActNpcWork = SurvivalSummaryActNpcWork.New(var_9_0)

	arg_9_0.popupFlow:addWork(arg_9_0.survivalSummaryActNpcWork)
end

function var_0_0.buildDelay(arg_10_0, arg_10_1)
	local var_10_0 = {
		time = arg_10_1
	}

	arg_10_0.popupFlow:addWork(SurvivalDecreeVoteShowWork.New(var_10_0))
end

function var_0_0.onDone(arg_11_0)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideSurvivalSummaryActAnimFinish)
end

function var_0_0.createReputationListComp(arg_12_0)
	local var_12_0 = SurvivalSimpleListParam.New()

	var_12_0.cellClass = SurvivalSummaryActReputationItem
	var_12_0.lineCount = 1
	var_12_0.cellWidth = 452
	var_12_0.cellHeight = 138
	var_12_0.cellSpaceH = 0
	var_12_0.cellSpaceV = 0

	local var_12_1 = arg_12_0.reputationItem

	arg_12_0.listComp = SurvivalHelper.instance:createLuaSimpleListComp(arg_12_0.reputationList.gameObject, var_12_0, var_12_1, arg_12_0.viewContainer)
end

function var_0_0.refreshReputationListComp(arg_13_0)
	local var_13_0 = SurvivalMapHelper.instance:getScene().actProgress.buildReputationInfos

	arg_13_0.listComp:setList(var_13_0)
end

return var_0_0
