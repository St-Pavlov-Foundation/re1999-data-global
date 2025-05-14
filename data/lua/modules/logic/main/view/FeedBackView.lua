module("modules.logic.main.view.FeedBackView", package.seeall)

local var_0_0 = class("FeedBackView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._browserGo = gohelper.findChild(arg_1_0.viewGO, "browser")
	arg_1_0._rootGo = gohelper.findChild(arg_1_0.viewGO, "root")
	arg_1_0._gosuretip = gohelper.findChild(arg_1_0.viewGO, "root/bottom/#go_suretip")
	arg_1_0._txtsuretip = gohelper.findChildText(arg_1_0.viewGO, "root/bottom/#go_suretip")
	arg_1_0._btnsure = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/bottom/#btn_sure")
	arg_1_0._inputfeedback = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "root/message/#input_feedback")
	arg_1_0._inputtitle = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "root/#input_title")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsure:AddClickListener(arg_2_0._btnsureOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._inputfeedback:AddOnValueChanged(arg_2_0._onContentValueChanged, arg_2_0)
	arg_2_0._inputtitle:AddOnValueChanged(arg_2_0._onTitleValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsure:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._inputfeedback:RemoveOnValueChanged()
	arg_3_0._inputtitle:RemoveOnValueChanged()
end

var_0_0.commitInterval = 30
var_0_0.maxTitleLength = 20
var_0_0.maxContentLength = 300
var_0_0.nilTitleToastId = 124
var_0_0.nilContentToastId = 125
var_0_0.maxTitleToastId = 126
var_0_0.maxContentToastId = 127

function var_0_0._btnsureOnClick(arg_4_0)
	local var_4_0 = arg_4_0._inputtitle:GetText()
	local var_4_1 = arg_4_0._inputfeedback:GetText()

	if string.nilorempty(var_4_0) and string.nilorempty(var_4_1) then
		return
	end

	if string.nilorempty(var_4_0) then
		GameFacade.showToast(var_0_0.nilTitleToastId)

		return
	end

	if string.nilorempty(var_4_1) then
		GameFacade.showToast(var_0_0.nilContentToastId)

		return
	end

	TaskDispatcher.cancelTask(arg_4_0.hideSureTip, arg_4_0)

	local var_4_2 = PlayerModel.instance:getPreFeedBackTime()

	if var_4_2 == -1 or Time.time - var_4_2 > var_0_0.commitInterval then
		arg_4_0:sendRequest(var_4_0, var_4_1)
		PlayerModel.instance:setPreFeedBackTime()
	else
		arg_4_0._txtsuretip.text = luaLang("frequently_commit")

		gohelper.setActive(arg_4_0._gosuretip, true)
		TaskDispatcher.runDelay(arg_4_0.hideSureTip, arg_4_0, 3)
	end
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.sendRequest(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = GameUrlConfig.getCurConfig().feedBack
	local var_6_1 = {}

	table.insert(var_6_1, string.format("userId=%s", PlayerModel.instance:getMyUserId()))
	table.insert(var_6_1, string.format("title=%s", arg_6_1))
	table.insert(var_6_1, string.format("content=%s", arg_6_2))

	local var_6_2 = var_6_0 .. "?" .. table.concat(var_6_1, "&")

	logWarn(var_6_2)
	SLFramework.SLWebRequest.Instance:Get(var_6_2, arg_6_0.receiveResponse, arg_6_0)
end

function var_0_0.receiveResponse(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2 == "fail" then
		arg_7_0._txtsuretip.text = luaLang("frequently_commit")
	else
		arg_7_0._txtsuretip.text = luaLang("thanks_feedback")

		arg_7_0._inputfeedback:SetText("")
		arg_7_0._inputtitle:SetText("")
	end

	gohelper.setActive(arg_7_0._gosuretip, true)
	TaskDispatcher.runDelay(arg_7_0.hideSureTip, arg_7_0, 3)
end

function var_0_0._onContentValueChanged(arg_8_0)
	local var_8_0 = arg_8_0._inputfeedback:GetText()

	if string.utf8len(var_8_0) > var_0_0.maxContentLength then
		local var_8_1 = GameUtil.utf8sub(var_8_0, 1, var_0_0.maxContentLength)

		arg_8_0._inputfeedback:SetText(var_8_1)
		GameFacade.showToast(var_0_0.maxContentToastId, var_0_0.maxContentLength)
	end
end

function var_0_0._onTitleValueChanged(arg_9_0)
	local var_9_0 = arg_9_0._inputtitle:GetText()

	if string.utf8len(var_9_0) > var_0_0.maxTitleLength then
		local var_9_1 = GameUtil.utf8sub(var_9_0, 1, var_0_0.maxTitleLength)

		arg_9_0._inputtitle:SetText(var_9_1)
		GameFacade.showToast(var_0_0.maxTitleToastId, var_0_0.maxTitleLength)
	end
end

function var_0_0.hideSureTip(arg_10_0)
	gohelper.setActive(arg_10_0._gosuretip, false)
end

function var_0_0._editableInitView(arg_11_0)
	gohelper.addUIClickAudio(arg_11_0._btnclose.gameObject, AudioEnum.UI.play_ui_feedback_close)
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	if GameChannelConfig.isSlsdk() then
		arg_13_0:hideSureTip()
		gohelper.setActive(arg_13_0._browserGo, false)
		gohelper.setActive(arg_13_0._rootGo, true)
	else
		gohelper.setActive(arg_13_0._browserGo, true)
		gohelper.setActive(arg_13_0._rootGo, false)
	end

	NavigateMgr.instance:addEscape(ViewName.FeedBackView, arg_13_0._btncloseOnClick, arg_13_0)
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
