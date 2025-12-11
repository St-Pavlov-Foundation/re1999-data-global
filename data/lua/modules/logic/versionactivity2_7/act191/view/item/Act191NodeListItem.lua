module("modules.logic.versionactivity2_7.act191.view.item.Act191NodeListItem", package.seeall)

local var_0_0 = class("Act191NodeListItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.handleView = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.txtStage = gohelper.findChildText(arg_2_1, "bg/stage/#txt_Stage")
	arg_2_0.goNodeItem = gohelper.findChild(arg_2_1, "bg/#go_NodeItem")
	arg_2_0.goSalary = gohelper.findChild(arg_2_1, "#go_Salary")
	arg_2_0.txtCoin1 = gohelper.findChildText(arg_2_1, "#go_Salary/Coin1/#txt_Coin1")
	arg_2_0.txtCoin2 = gohelper.findChildText(arg_2_1, "#go_Salary/Coin2/#txt_Coin2")
	arg_2_0.btnClick = gohelper.findChildButtonWithAudio(arg_2_1, "#btn_Click")
	arg_2_0.nodeItemList = {}
	arg_2_0.goFly1 = gohelper.findChild(arg_2_1, "#go_Salary/Coin1/#fly")
	arg_2_0.goFly2 = gohelper.findChild(arg_2_1, "#go_Salary/Coin2/#fly")
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addClickCb(arg_3_0.btnClick, arg_3_0.onClick, arg_3_0)
	arg_3_0:addEventCb(Activity191Controller.instance, Activity191Event.UpdateGameInfo, arg_3_0.refreshUI, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0.onClick(arg_5_0)
	local var_5_0 = arg_5_0.goSalary.activeInHierarchy and "false" or "true"

	Act191StatController.instance:statButtonClick(arg_5_0.handleView.viewName, string.format("showSalary_%s", var_5_0))
	arg_5_0:showSalary()
end

function var_0_0.onStart(arg_6_0)
	arg_6_0.actId = Activity191Model.instance:getCurActId()

	arg_6_0:refreshUI()
end

function var_0_0.onDestroy(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.playSalaryAnim, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.hideSalary, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.hideFly, arg_7_0)
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	arg_8_0.nodeInfoList = arg_8_0.gameInfo:getStageNodeInfoList()

	local var_8_0 = lua_activity191_stage.configDict[arg_8_0.actId][arg_8_0.gameInfo.curStage]

	arg_8_0.txtCoin1.text = var_8_0.coin
	arg_8_0.txtCoin2.text = var_8_0.score

	local var_8_1 = lua_activity191_node.configDict[tonumber(var_8_0.rule)]

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.nodeInfoList) do
		local var_8_2 = arg_8_0.nodeItemList[iter_8_0] or arg_8_0:creatNodeItem(iter_8_0)
		local var_8_3 = var_8_1[iter_8_0]
		local var_8_4

		if var_8_3.random == 1 then
			var_8_4 = Activity191Helper.getNodeIcon(iter_8_1.nodeType)
		elseif #iter_8_1.selectNodeStr == 0 then
			var_8_4 = Activity191Helper.getNodeIcon(iter_8_1.nodeType)
		else
			local var_8_5 = Act191NodeDetailMO.New()

			var_8_5:init(iter_8_1.selectNodeStr[1])

			var_8_4 = Activity191Helper.getNodeIcon(var_8_5.type)
		end

		if var_8_4 then
			UISpriteSetMgr.instance:setAct174Sprite(var_8_2.imageNode, var_8_4)
			UISpriteSetMgr.instance:setAct174Sprite(var_8_2.imageNodeS, var_8_4 .. "_light")
		end

		if iter_8_1.nodeId == arg_8_0.gameInfo.curNode then
			if iter_8_0 == 1 and arg_8_0.gameInfo.curNode ~= 1 then
				arg_8_0.firstNode = true
			end

			arg_8_0.txtStage.text = string.format("<#FAB459>%s</color>-%d", var_8_0.name, iter_8_0)

			gohelper.setActive(var_8_2.goSelect, true)
		else
			gohelper.setActive(var_8_2.goSelect, false)
		end
	end

	gohelper.setActive(arg_8_0.goNodeItem, false)
end

function var_0_0.creatNodeItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getUserDataTb_()
	local var_9_1 = gohelper.cloneInPlace(arg_9_0.goNodeItem)

	var_9_0.imageNode = gohelper.findChildImage(var_9_1, "image_Node")
	var_9_0.goSelect = gohelper.findChildImage(var_9_1, "go_Select")
	var_9_0.imageNodeS = gohelper.findChildImage(var_9_1, "go_Select/image_NodeS")
	arg_9_0.nodeItemList[arg_9_1] = var_9_0

	return var_9_0
end

function var_0_0.showSalary(arg_10_0)
	if arg_10_0.goSalary.activeInHierarchy then
		TaskDispatcher.cancelTask(arg_10_0.hideSalary, arg_10_0)
		arg_10_0:hideSalary()

		return
	end

	gohelper.setActive(arg_10_0.goSalary, true)
	TaskDispatcher.runDelay(arg_10_0.hideSalary, arg_10_0, 2)
end

function var_0_0.hideSalary(arg_11_0)
	gohelper.setActive(arg_11_0.goSalary, false)
end

function var_0_0.setClickEnable(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0.btnClick, arg_12_1)
end

function var_0_0.playSalaryAnim(arg_13_0, arg_13_1, arg_13_2)
	gohelper.setActive(arg_13_0.goFly1, true)
	gohelper.setActive(arg_13_0.goFly2, true)

	local var_13_0 = recthelper.rectToRelativeAnchorPos(arg_13_1.transform.position, arg_13_0.goFly1.transform.parent)

	ZProj.TweenHelper.DOAnchorPos(arg_13_0.goFly1.transform, var_13_0.x, var_13_0.y, 1)

	local var_13_1 = recthelper.rectToRelativeAnchorPos(arg_13_2.transform.position, arg_13_0.goFly2.transform.parent)

	ZProj.TweenHelper.DOAnchorPos(arg_13_0.goFly2.transform, var_13_1.x, var_13_1.y, 1)
	TaskDispatcher.runDelay(arg_13_0.hideFly, arg_13_0, 1)
end

function var_0_0.hideFly(arg_14_0)
	AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_earn_gold)
	gohelper.setActive(arg_14_0.goFly1, false)
	gohelper.setActive(arg_14_0.goFly2, false)
end

return var_0_0
