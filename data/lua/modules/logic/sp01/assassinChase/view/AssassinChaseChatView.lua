module("modules.logic.sp01.assassinChase.view.AssassinChaseChatView", package.seeall)

local var_0_0 = class("AssassinChaseChatView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Click")
	arg_1_0._gohead = gohelper.findChild(arg_1_0.viewGO, "#go_head")
	arg_1_0._goheadgrey = gohelper.findChild(arg_1_0.viewGO, "#go_head/#go_headgrey")
	arg_1_0._simagehead = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_head/#simage_head")
	arg_1_0._goname = gohelper.findChild(arg_1_0.viewGO, "#go_name")
	arg_1_0._txtnamecn1 = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_name/namelayout/#txt_namecn1")
	arg_1_0._gocontents = gohelper.findChild(arg_1_0.viewGO, "#go_contents")
	arg_1_0._txtcontentcn = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_contents/txt_contentcn")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClick:AddClickListener(arg_2_0._btnClickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClick:RemoveClickListener()
end

function var_0_0._btnClickOnClick(arg_4_0)
	arg_4_0:_checkNextStep()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam

	arg_7_0._dialogIndex = 1
	arg_7_0._configIndex = 1
	arg_7_0._actId = var_7_0.actId

	local var_7_1 = AssassinChaseConfig.instance:getDialogueConfigList(var_7_0.actId)

	if var_7_1 == nil then
		logError("奥德赛下半角色活动 对话表为空 actId:" .. tostring(var_7_0.actId))
		arg_7_0:closeThis()

		return
	end

	arg_7_0._configList = var_7_1
	arg_7_0._configCount = #var_7_1

	arg_7_0:refreshUI()
end

function var_0_0._checkNextStep(arg_8_0)
	if arg_8_0._configIndex >= arg_8_0._configCount then
		arg_8_0:closeThis()

		return
	end

	arg_8_0._configIndex = arg_8_0._configIndex + 1

	arg_8_0:refreshUI()
end

function var_0_0.refreshUI(arg_9_0)
	local var_9_0 = arg_9_0._dialogIndex
	local var_9_1 = arg_9_0._configIndex
	local var_9_2 = arg_9_0._configList[var_9_1]

	arg_9_0._simagehead:LoadImage(ResUrl.getHeadIconSmall(var_9_2.roleIcon))

	arg_9_0._txtnamecn1.text = var_9_2.roleName
	arg_9_0._txtcontentcn.text = var_9_2.dialog
end

function var_0_0.onClose(arg_10_0)
	AssassinChaseController.instance:dispatchEvent(AssassinChaseEvent.OnDialogueEnd)
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagehead:UnLoadImage()
end

return var_0_0
