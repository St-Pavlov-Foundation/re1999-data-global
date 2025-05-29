module("modules.logic.room.view.layout.RoomLayoutInputBaseView", package.seeall)

local var_0_0 = class("RoomLayoutInputBaseView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/#simage_rightbg")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/#simage_leftbg")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_close")
	arg_1_0._btnsure = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_sure")
	arg_1_0._txtdes = gohelper.findChildText(arg_1_0.viewGO, "message/#txt_des")
	arg_1_0._inputsignature = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "message/#input_signature")
	arg_1_0._txttext = gohelper.findChildText(arg_1_0.viewGO, "message/#input_signature/textarea/#txt_text")
	arg_1_0._btncleanname = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "message/#input_signature/#btn_cleanname")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnsure:AddClickListener(arg_2_0._btnsureOnClick, arg_2_0)
	arg_2_0._btncleanname:AddClickListener(arg_2_0._btncleannameOnClick, arg_2_0)
	arg_2_0._inputsignature:AddOnEndEdit(arg_2_0._onInputNameEndEdit, arg_2_0)
	arg_2_0._inputsignature:AddOnValueChanged(arg_2_0._onInputNameValueChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnsure:RemoveClickListener()
	arg_3_0._btncleanname:RemoveClickListener()
	arg_3_0._inputsignature:RemoveOnEndEdit()
	arg_3_0._inputsignature:RemoveOnValueChanged()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
	arg_4_0:_closeInvokeCallback(false)
end

function var_0_0._btnsureOnClick(arg_5_0)
	local var_5_0 = arg_5_0._inputsignature:GetText()

	if string.nilorempty(var_5_0) then
		-- block empty
	else
		arg_5_0:closeThis()
		arg_5_0:_closeInvokeCallback(true, var_5_0)
	end
end

function var_0_0._btncleannameOnClick(arg_6_0)
	arg_6_0._inputsignature:SetText("")
end

function var_0_0._onInputNameEndEdit(arg_7_0)
	arg_7_0:_checkLimit()
end

function var_0_0._onInputNameValueChange(arg_8_0)
	if not BootNativeUtil.isIOS() then
		arg_8_0:_checkLimit()
	end
end

function var_0_0._checkLimit(arg_9_0)
	local var_9_0 = arg_9_0._inputsignature:GetText()
	local var_9_1 = arg_9_0:_getInputLimit()
	local var_9_2 = GameUtil.utf8sub(var_9_0, 1, math.min(GameUtil.utf8len(var_9_0), var_9_1))

	if var_9_2 ~= var_9_0 then
		arg_9_0._inputsignature:SetText(var_9_2)
	end
end

function var_0_0._getInputLimit(arg_10_0)
	return CommonConfig.instance:getConstNum(ConstEnum.RoomLayoutNameLimit)
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0._txttitlecn = gohelper.findChildText(arg_11_0.viewGO, "titlecn")
	arg_11_0._txttitleen = gohelper.findChildText(arg_11_0.viewGO, "titlecn/titleen")
	arg_11_0._txtbtnsurecn = gohelper.findChildText(arg_11_0.viewGO, "bottom/#btn_sure/text")
	arg_11_0._txtbtnsureed = gohelper.findChildText(arg_11_0.viewGO, "bottom/#btn_sure/texten")
	arg_11_0._txtinputlang = gohelper.findChildText(arg_11_0.viewGO, "message/#input_signature/textarea/lang_txt")

	arg_11_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	arg_11_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
end

function var_0_0.onUpdateParam(arg_12_0)
	arg_12_0:_refreshInitUI()
end

function var_0_0.onOpen(arg_13_0)
	if arg_13_0.viewContainer then
		NavigateMgr.instance:addEscape(arg_13_0.viewContainer.viewName, arg_13_0._onEscape, arg_13_0)
	end

	arg_13_0:_refreshInitUI()
end

function var_0_0._onEscape(arg_14_0)
	arg_14_0:_btncloseOnClick()
end

function var_0_0._refreshInitUI(arg_15_0)
	if arg_15_0.viewParam then
		local var_15_0 = arg_15_0.viewParam.defaultName

		if string.nilorempty(var_15_0) then
			arg_15_0._inputsignature:SetText("")
		else
			arg_15_0._inputsignature:SetText(var_15_0)
		end
	end
end

function var_0_0._closeInvokeCallback(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0.viewParam then
		return
	end

	if arg_16_1 then
		if arg_16_0.viewParam.yesCallback then
			if arg_16_0.viewParam.callbockObj then
				arg_16_0.viewParam.yesCallback(arg_16_0.viewParam.callbockObj, arg_16_2)
			else
				arg_16_0.viewParam.yesCallback(arg_16_2)
			end
		end
	elseif arg_16_0.viewParam.noCallback then
		arg_16_0.viewParam.noCallback(arg_16_0.viewParam.noCallbackObj)
	end
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0._simagerightbg:UnLoadImage()
	arg_18_0._simageleftbg:UnLoadImage()
end

return var_0_0
