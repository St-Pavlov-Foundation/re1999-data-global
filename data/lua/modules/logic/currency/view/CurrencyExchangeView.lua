module("modules.logic.currency.view.CurrencyExchangeView", package.seeall)

local var_0_0 = class("CurrencyExchangeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagehuawen1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "tipbg/#simage_huawen1")
	arg_1_0._simagehuawen2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "tipbg/#simage_huawen2")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc")
	arg_1_0._btnyes = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_yes")
	arg_1_0._btnno = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_no")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_righttop")
	arg_1_0._toggleoption = gohelper.findChildToggle(arg_1_0.viewGO, "#toggle_option")
	arg_1_0._txtoption = gohelper.findChildText(arg_1_0.viewGO, "#toggle_option/#txt_option")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnyes:AddClickListener(arg_2_0._btnyesOnClick, arg_2_0)
	arg_2_0._btnno:AddClickListener(arg_2_0._btnnoOnClick, arg_2_0)
	arg_2_0._toggleoption:AddOnValueChanged(arg_2_0._toggleOptionOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnyes:RemoveClickListener()
	arg_3_0._btnno:RemoveClickListener()
	arg_3_0._toggleoption:RemoveOnValueChanged()
end

local var_0_1 = MsgBoxEnum.CloseType
local var_0_2 = MsgBoxEnum.BoxType

function var_0_0._btnyesOnClick(arg_4_0)
	arg_4_0:_closeInvokeCallback(var_0_1.Yes)
end

function var_0_0._btnnoOnClick(arg_5_0)
	arg_5_0:_closeInvokeCallback(var_0_1.No)
end

function var_0_0._closeInvokeCallback(arg_6_0, arg_6_1)
	local var_6_0 = false

	if arg_6_1 == var_0_1.Yes then
		if arg_6_0._toggleoption.isOn then
			arg_6_0:saveOptionData()
		end

		var_6_0 = CurrencyController.instance:checkCurrencyExchange(arg_6_0.viewParam)
	elseif arg_6_0.viewParam.noCallback then
		arg_6_0.viewParam.noCallback(arg_6_0.viewParam.noCallbackObj)
	end

	if not var_6_0 then
		arg_6_0:closeThis()
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._simagehuawen1:LoadImage(ResUrl.getMessageIcon("huawen1_002"))
	arg_7_0._simagehuawen2:LoadImage(ResUrl.getMessageIcon("huawen2_003"))

	arg_7_0._goNo = arg_7_0._btnno.gameObject
	arg_7_0._goYes = arg_7_0._btnyes.gameObject

	gohelper.addUIClickAudio(arg_7_0._btnyes.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
	gohelper.addUIClickAudio(arg_7_0._btnno.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:onOpen()
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._simagehuawen1:UnLoadImage()
	arg_9_0._simagehuawen2:UnLoadImage()
end

function var_0_0.onOpen(arg_10_0)
	if not string.nilorempty(arg_10_0.viewParam.msg) and arg_10_0.viewParam.extra and #arg_10_0.viewParam.extra > 0 then
		local var_10_0 = arg_10_0.viewParam.msg
		local var_10_1 = GameUtil.getSubPlaceholderLuaLang(var_10_0, arg_10_0.viewParam.extra)

		arg_10_0._txtdesc.text = var_10_1
	else
		arg_10_0._txtdesc.text = arg_10_0.viewParam.msg or ""
	end

	if arg_10_0.viewParam.openCallback then
		arg_10_0.viewParam.openCallback(arg_10_0)
	end

	gohelper.setActive(arg_10_0._goNo, true)
	recthelper.setAnchorX(arg_10_0._goYes.transform, 248)
	recthelper.setAnchorX(arg_10_0._goNo.transform, -248)
	NavigateMgr.instance:addEscape(ViewName.CurrencyExchangeView, arg_10_0._onEscapeBtnClick, arg_10_0)

	arg_10_0._toggleoption.isOn = false

	gohelper.setActive(arg_10_0._toggleoption.gameObject, false)

	if arg_10_0.viewParam.isShowDailySure and arg_10_0.viewParam.isExchangeStep then
		arg_10_0:refreshOptionUI()
	end
end

function var_0_0._onEscapeBtnClick(arg_11_0)
	if arg_11_0._goNo.gameObject.activeInHierarchy then
		arg_11_0:_closeInvokeCallback(var_0_1.No)
	end
end

function var_0_0.refreshOptionUI(arg_12_0)
	gohelper.setActive(arg_12_0._toggleoption.gameObject, true)

	arg_12_0.optionType = MsgBoxEnum.optionType.Daily
	arg_12_0._txtoption.text = luaLang("messageoptionbox_daily")
end

function var_0_0.saveOptionData(arg_13_0)
	if not arg_13_0.viewParam.isShowDailySure or not arg_13_0.viewParam.isExchangeStep then
		return
	end

	if arg_13_0.optionType == nil or arg_13_0.optionType <= 0 or not arg_13_0._toggleoption.isOn then
		return
	end

	local var_13_0 = CurrencyController.instance:getOptionLocalKey(arg_13_0.viewParam.srcType)

	if arg_13_0.optionType == MsgBoxEnum.optionType.Daily then
		TimeUtil.setDayFirstLoginRed(var_13_0)
	end
end

function var_0_0._toggleOptionOnClick(arg_14_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	arg_14_0:saveOptionData()
end

function var_0_0.onClose(arg_15_0)
	return
end

return var_0_0
