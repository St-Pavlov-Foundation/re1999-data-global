module("modules.logic.versionactivity2_7.act191.view.Act191SwitchView", package.seeall)

local var_0_0 = class("Act191SwitchView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtStage = gohelper.findChildText(arg_1_0.viewGO, "bg/stage/#txt_Stage")
	arg_1_0._goItem = gohelper.findChild(arg_1_0.viewGO, "bg/#go_Item")
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "#txt_Tips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._onEscBtnClick(arg_4_0)
	return
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.actId = Activity191Model.instance:getCurActId()
	arg_5_0.nodeItemList = {}

	NavigateMgr.instance:addEscape(arg_5_0.viewName, arg_5_0._onEscBtnClick, arg_5_0)
end

function var_0_0.onOpen(arg_6_0)
	gohelper.setActive(arg_6_0._txtTips, false)

	arg_6_0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	arg_6_0.nodeInfoList = arg_6_0.gameInfo:getStageNodeInfoList()
	arg_6_0.gameInfo.nodeChange = false

	local var_6_0 = lua_activity191_stage.configDict[arg_6_0.actId][arg_6_0.gameInfo.curStage]
	local var_6_1 = lua_activity191_node.configDict[tonumber(var_6_0.rule)]

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.nodeInfoList) do
		local var_6_2 = arg_6_0.nodeItemList[iter_6_0] or arg_6_0:creatNodeItem(iter_6_0)
		local var_6_3 = var_6_1[iter_6_0]
		local var_6_4

		if var_6_3.random == 1 then
			var_6_4 = Activity191Helper.getNodeIcon(iter_6_1.nodeType)
		elseif #iter_6_1.selectNodeStr == 0 then
			var_6_4 = Activity191Helper.getNodeIcon(iter_6_1.nodeType)
		else
			local var_6_5 = Act191NodeDetailMO.New()

			var_6_5:init(iter_6_1.selectNodeStr[1])

			var_6_4 = Activity191Helper.getNodeIcon(var_6_5.type)
		end

		if var_6_4 then
			UISpriteSetMgr.instance:setAct174Sprite(var_6_2.imageNode, var_6_4)
			UISpriteSetMgr.instance:setAct174Sprite(var_6_2.imageNodeS, var_6_4 .. "_light")
		end

		if iter_6_1.nodeId == arg_6_0.gameInfo.curNode then
			arg_6_0._txtStage.text = string.format("<#FAB459>%s</color>-%d", var_6_0.name, iter_6_0)
			arg_6_0._txtTips.text = var_6_3.desc

			gohelper.setActive(var_6_2.goSelect, true)
			TaskDispatcher.runDelay(arg_6_0.delayAudio, arg_6_0, 1)
			var_6_2.animSwitch:Play("switch_open")
			gohelper.setActive(arg_6_0._txtTips, true)
		elseif iter_6_1.nodeId == arg_6_0.gameInfo.curNode - 1 then
			gohelper.setActive(var_6_2.goSelect, true)
			AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_pmgressbar_01)
			var_6_2.animSwitch:Play("switch_close")
		else
			gohelper.setActive(var_6_2.goSelect, false)
		end
	end

	gohelper.setActive(arg_6_0._goItem, false)
	TaskDispatcher.runDelay(arg_6_0.closeThis, arg_6_0, 2.3)
end

function var_0_0.onDestroyView(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.closeThis, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.delayAudio, arg_7_0)
end

function var_0_0.creatNodeItem(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getUserDataTb_()
	local var_8_1 = gohelper.cloneInPlace(arg_8_0._goItem)

	var_8_0.imageNode = gohelper.findChildImage(var_8_1, "image_Node")
	var_8_0.goSelect = gohelper.findChildImage(var_8_1, "go_Select")
	var_8_0.animSwitch = var_8_0.goSelect:GetComponent(gohelper.Type_Animator)
	var_8_0.imageNodeS = gohelper.findChildImage(var_8_1, "go_Select/image_NodeS")
	arg_8_0.nodeItemList[arg_8_1] = var_8_0

	return var_8_0
end

function var_0_0.delayAudio(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_pmgressbar_02)
end

return var_0_0
