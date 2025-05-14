module("modules.logic.login.view.SimulateLoginView", package.seeall)

local var_0_0 = class("SimulateLoginView", BaseView)
local var_0_1 = UnityEngine.Input
local var_0_2 = UnityEngine.KeyCode
local var_0_3 = 10

local function var_0_4()
	local var_1_0 = ""

	math.randomseed(os.time())

	for iter_1_0 = 1, 6 do
		local var_1_1 = math.random(0, os.time()) % 62

		if var_1_1 < 10 then
			var_1_1 = tostring(var_1_1)
		elseif var_1_1 < 36 then
			var_1_1 = var_1_1 - 10 + 65
			var_1_1 = string.char(var_1_1)
		else
			var_1_1 = var_1_1 - 36 + 97
			var_1_1 = string.char(var_1_1)
		end

		var_1_0 = var_1_0 .. var_1_1
	end

	return var_1_0
end

function var_0_0._quickLogin(arg_2_0)
	local var_2_0 = arg_2_0._inputField:GetText()

	if string.nilorempty(var_2_0) then
		GameFacade.showToast(ToastEnum.SimulateLogin)

		return
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.SimulateAccount, var_2_0)
	arg_2_0:onClickModalMask()
	FrameTimerController.onDestroyViewMember(arg_2_0, "_loginFrameTimer")

	arg_2_0._loginFrameTimer = FrameTimerController.instance:register(arg_2_0._onClickLogin, arg_2_0, 3, 1)

	arg_2_0._loginFrameTimer:Start()
end

function var_0_0._onUpdate(arg_3_0)
	if var_0_1.GetKey(var_0_2.LeftControl) and var_0_1.GetKeyDown(var_0_2.Return) then
		arg_3_0:_setLoginAccountInput(var_0_4())
		arg_3_0:_quickLogin()

		return
	end

	if var_0_1.GetKeyDown(var_0_2.UpArrow) then
		arg_3_0:_selectBeforeAccount()
	elseif var_0_1.GetKeyDown(var_0_2.DownArrow) then
		arg_3_0:_selectNextAccount()
	elseif var_0_1.GetKeyDown(var_0_2.KeypadEnter) or var_0_1.GetKeyDown(var_0_2.Return) then
		arg_3_0:_quickLogin()
	end
end

function var_0_0._onClickLogin(arg_4_0)
	local var_4_0 = ViewMgr.instance:getContainer(ViewName.LoginView)

	for iter_4_0, iter_4_1 in ipairs(var_4_0._views) do
		if iter_4_1.__cname == "LoginView" then
			iter_4_1:_onClickLogin()

			break
		end
	end
end

local var_0_5 = "SimulateLoginView_HistoryAccount"

function var_0_0._saveHistoryAccount(arg_5_0)
	local var_5_0 = arg_5_0:_getHistoryAccountList()
	local var_5_1 = arg_5_0._inputField:GetText()
	local var_5_2 = false
	local var_5_3 = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if iter_5_0 > var_0_3 then
			break
		end

		if iter_5_1.account == var_5_1 then
			table.insert(var_5_3, iter_5_1.account .. "#" .. tostring(os.time()))

			var_5_2 = true
		else
			table.insert(var_5_3, iter_5_1.account .. "#" .. tostring(iter_5_1.ts))
		end
	end

	if not var_5_2 then
		if #var_5_3 >= var_0_3 then
			table.remove(var_5_3)
		end

		table.insert(var_5_3, 1, var_5_1 .. "#" .. tostring(os.time()))
	end

	local var_5_4 = table.concat(var_5_3, "|")

	PlayerPrefsHelper.setString(var_0_5, var_5_4)
end

function var_0_0._getHistoryAccountPlayerPrefs(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = PlayerPrefsHelper.getString(var_0_5, "")

	if string.nilorempty(var_6_1) then
		if not string.nilorempty(arg_6_0._lastAccount) then
			var_6_0[1] = {
				account = arg_6_0._lastAccount,
				ts = os.time()
			}
		end
	else
		local var_6_2 = GameUtil.splitString2(var_6_1)

		for iter_6_0, iter_6_1 in ipairs(var_6_2) do
			table.insert(var_6_0, {
				account = iter_6_1[1],
				ts = tonumber(iter_6_1[2])
			})
		end
	end

	table.sort(var_6_0, function(arg_7_0, arg_7_1)
		return arg_7_0.ts > arg_7_1.ts
	end)

	local var_6_3 = #var_6_0

	for iter_6_2 = var_0_3 + 1, var_6_3 do
		table.remove(var_6_0)
	end

	return var_6_0
end

function var_0_0._getHistoryAccountList(arg_8_0)
	if not arg_8_0._historyAccountStrList then
		arg_8_0._historyAccountStrList = arg_8_0:_getHistoryAccountPlayerPrefs()
	end

	return arg_8_0._historyAccountStrList
end

function var_0_0._initHistoryAccountData(arg_9_0)
	arg_9_0._lastAccount = PlayerPrefsHelper.getString(PlayerPrefsKey.SimulateAccount, "")
	arg_9_0._curAccountIndex = 0
	arg_9_0.__firstInited = true
end

function var_0_0._initHistoryAccount(arg_10_0)
	if arg_10_0.__isHistoryAccountInited then
		return
	end

	arg_10_0.__isHistoryAccountInited = true

	arg_10_0:_initHistoryAccountData()
	arg_10_0:_initHistoryAccountView()
end

function var_0_0._initHistoryAccountView(arg_11_0)
	local var_11_0 = arg_11_0._inputField.gameObject
	local var_11_1 = gohelper.create2d(arg_11_0.viewGO, "===History Account===")
	local var_11_2 = gohelper.create2d(var_11_1)
	local var_11_3 = var_11_2.transform
	local var_11_4 = gohelper.clone(gohelper.findChild(var_11_0, "Text"), var_11_2)
	local var_11_5 = var_11_4.transform
	local var_11_6 = gohelper.onceAddComponent(var_11_2, gohelper.Type_Image)
	local var_11_7 = gohelper.findChildText(var_11_4, "")

	recthelper.setWidth(var_11_3, 500)
	UIDockingHelper.setDock(UIDockingHelper.Dock.MR_R, var_11_3, var_11_0.transform)

	var_11_7.richText = true
	var_11_5.anchorMin = Vector2.New(0, 0)
	var_11_5.anchorMax = Vector2.New(1, 1)
	var_11_5.pivot = Vector2.New(0.5, 0.5)

	recthelper.setAnchor(var_11_5, 0, 0)

	var_11_5.sizeDelta = Vector2.New(0, 0)

	ZProj.UGUIHelper.SetColorAlpha(var_11_6, 0.5)

	arg_11_0._historyAccountGo = var_11_1
	arg_11_0._historyAccountText = var_11_7
	arg_11_0._historyAccountImgTrans = var_11_3

	arg_11_0:_refreshHistoryAccountView()
end

local var_0_6 = "#00FF00"

function var_0_0._refreshHistoryAccountView(arg_12_0)
	local var_12_0 = arg_12_0:_getHistoryAccountList()
	local var_12_1 = {}

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_2 = tostring(iter_12_1.account)

		if iter_12_0 - 1 == arg_12_0._curAccountIndex then
			var_12_2 = gohelper.getRichColorText(var_12_2, var_0_6)
		end

		table.insert(var_12_1, var_12_2)
	end

	arg_12_0._historyAccountText.text = table.concat(var_12_1, "\n")

	recthelper.setHeight(arg_12_0._historyAccountImgTrans, arg_12_0._historyAccountText.preferredHeight)
end

function var_0_0._selectBeforeAccount(arg_13_0)
	arg_13_0:_initHistoryAccount()

	local var_13_0 = #arg_13_0:_getHistoryAccountList()
	local var_13_1 = (arg_13_0._curAccountIndex + var_13_0 - 1) % var_13_0

	arg_13_0:_onHistoryAccountDropDownChange(var_13_1)
end

function var_0_0._selectNextAccount(arg_14_0)
	arg_14_0:_initHistoryAccount()

	local var_14_0 = #arg_14_0:_getHistoryAccountList()
	local var_14_1 = (arg_14_0._curAccountIndex + 1) % var_14_0

	arg_14_0:_onHistoryAccountDropDownChange(var_14_1)
end

function var_0_0._setLoginAccountInput(arg_15_0, arg_15_1)
	arg_15_0._inputField:SetText(arg_15_1 or "")
end

function var_0_0._onHistoryAccountDropDownChange(arg_16_0, arg_16_1)
	if not arg_16_0._historyAccountStrList then
		return
	end

	if arg_16_0.__firstInited then
		arg_16_1 = 0
		arg_16_0.__firstInited = false
	end

	arg_16_1 = GameUtil.clamp(arg_16_1, 0, #arg_16_0._historyAccountStrList - 1)

	if arg_16_0._curAccountIndex == arg_16_1 then
		return
	end

	arg_16_0._curAccountIndex = arg_16_1

	local var_16_0 = arg_16_0._historyAccountStrList[arg_16_1 + 1]

	arg_16_0:_setLoginAccountInput(var_16_0.account)
	arg_16_0:_refreshHistoryAccountView()
end

function var_0_0.onClose_(arg_17_0)
	UpdateBeat:Remove(arg_17_0._onUpdate, arg_17_0)

	if arg_17_0._hestoryAccountDropDown then
		arg_17_0._hestoryAccountDropDown:RemoveOnValueChanged()
	end

	arg_17_0:_saveHistoryAccount()
end

function var_0_0.ctor(arg_18_0)
	arg_18_0._button = nil
	arg_18_0._inputField = nil
end

function var_0_0.onInitView(arg_19_0)
	arg_19_0._button = gohelper.findChildButtonWithAudio(arg_19_0.viewGO, "Button")
	arg_19_0._inputField = gohelper.findChildTextMeshInputField(arg_19_0.viewGO, "InputField")
	arg_19_0._btnAgeFit = gohelper.findChildButtonWithAudio(arg_19_0.viewGO, "leftbtn/#btn_agefit")
end

function var_0_0.addEvents(arg_20_0)
	arg_20_0._button:AddClickListener(arg_20_0._onClickButton, arg_20_0)
	arg_20_0._btnAgeFit:AddClickListener(arg_20_0._onClickAgeFit, arg_20_0)
	arg_20_0._inputField:AddOnEndEdit(arg_20_0._onEndEdit, arg_20_0)
end

function var_0_0.removeEvents(arg_21_0)
	arg_21_0._button:RemoveClickListener()
	arg_21_0._btnAgeFit:RemoveClickListener()
	arg_21_0._inputField:RemoveOnEndEdit()
end

function var_0_0.onOpen(arg_22_0)
	UpdateBeat:Add(arg_22_0._onUpdate, arg_22_0)
	gohelper.addUIClickAudio(arg_22_0._button.gameObject, AudioEnum.UI.UI_Common_Click)

	local var_22_0 = PlayerPrefsHelper.getString(PlayerPrefsKey.SimulateAccount)

	arg_22_0._inputField:SetText(var_22_0)
	TaskDispatcher.runRepeat(arg_22_0._onTick, arg_22_0, 0.1)

	local var_22_1 = tostring(SDKMgr.instance:getChannelId()) == "102"

	gohelper.setActive(arg_22_0._btnAgeFit.gameObject, not var_22_1 and SettingsModel.instance:isZhRegion())
end

function var_0_0.onClose(arg_23_0)
	arg_23_0:onClose_()
	TaskDispatcher.cancelTask(arg_23_0._onTick, arg_23_0)
end

function var_0_0._onTick(arg_24_0)
	if not ViewMgr.instance:isOpen(ViewName.LoginView) then
		logNormal("LoginView has close, close SimulateLoginView too")
		arg_24_0:closeThis()
	end
end

function var_0_0._onClickButton(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0._inputField:GetText()

	if string.nilorempty(var_25_0) then
		GameFacade.showToast(ToastEnum.SimulateLogin)

		return
	end

	arg_25_0:closeThis()
	LoginModel.instance:setChannelParam("", var_25_0, "", "", "")
	LoginController.instance:login({})
end

function var_0_0.onClickModalMask(arg_26_0)
	arg_26_0:_onClickButton()
end

function var_0_0._onClickAgeFit(arg_27_0)
	ViewMgr.instance:openView(ViewName.SdkFitAgeTipView)
end

function var_0_0._onEndEdit(arg_28_0, arg_28_1)
	PlayerPrefsHelper.setString(PlayerPrefsKey.SimulateAccount, arg_28_1)
end

return var_0_0
