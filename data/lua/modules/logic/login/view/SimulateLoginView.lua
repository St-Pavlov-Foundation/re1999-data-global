module("modules.logic.login.view.SimulateLoginView", package.seeall)

slot0 = class("SimulateLoginView", BaseView)
slot1 = UnityEngine.Input
slot2 = UnityEngine.KeyCode
slot3 = 10

function slot4()
	math.randomseed(os.time())

	for slot4 = 1, 6 do
		slot0 = "" .. ((math.random(0, os.time()) % 62 >= 10 or tostring(slot5)) and (slot5 >= 36 or string.char(slot5 - 10 + 65)) and string.char(slot5 - 36 + 97))
	end

	return slot0
end

function slot0._quickLogin(slot0)
	if string.nilorempty(slot0._inputField:GetText()) then
		GameFacade.showToast(ToastEnum.SimulateLogin)

		return
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.SimulateAccount, slot1)
	slot0:onClickModalMask()
	FrameTimerController.onDestroyViewMember(slot0, "_loginFrameTimer")

	slot0._loginFrameTimer = FrameTimerController.instance:register(slot0._onClickLogin, slot0, 3, 1)

	slot0._loginFrameTimer:Start()
end

function slot0._onUpdate(slot0)
	if uv0.GetKey(uv1.LeftControl) and uv0.GetKeyDown(uv1.Return) then
		slot0:_setLoginAccountInput(uv2())
		slot0:_quickLogin()

		return
	end

	if uv0.GetKeyDown(uv1.UpArrow) then
		slot0:_selectBeforeAccount()
	elseif uv0.GetKeyDown(uv1.DownArrow) then
		slot0:_selectNextAccount()
	elseif uv0.GetKeyDown(uv1.KeypadEnter) or uv0.GetKeyDown(uv1.Return) then
		slot0:_quickLogin()
	end
end

function slot0._onClickLogin(slot0)
	for slot5, slot6 in ipairs(ViewMgr.instance:getContainer(ViewName.LoginView)._views) do
		if slot6.__cname == "LoginView" then
			slot6:_onClickLogin()

			break
		end
	end
end

slot5 = "SimulateLoginView_HistoryAccount"

function slot0._saveHistoryAccount(slot0)
	slot2 = slot0._inputField:GetText()
	slot3 = false
	slot4 = {}

	for slot8, slot9 in ipairs(slot0:_getHistoryAccountList()) do
		if uv0 < slot8 then
			break
		end

		if slot9.account == slot2 then
			table.insert(slot4, slot9.account .. "#" .. tostring(os.time()))

			slot3 = true
		else
			table.insert(slot4, slot9.account .. "#" .. tostring(slot9.ts))
		end
	end

	if not slot3 then
		if uv0 <= #slot4 then
			table.remove(slot4)
		end

		table.insert(slot4, 1, slot2 .. "#" .. tostring(os.time()))
	end

	PlayerPrefsHelper.setString(uv1, table.concat(slot4, "|"))
end

function slot0._getHistoryAccountPlayerPrefs(slot0)
	slot1 = {
		{
			account = slot0._lastAccount,
			ts = os.time()
		}
	}

	if string.nilorempty(PlayerPrefsHelper.getString(uv0, "")) then
		if not string.nilorempty(slot0._lastAccount) then
			-- Nothing
		end
	else
		for slot7, slot8 in ipairs(GameUtil.splitString2(slot2)) do
			table.insert(slot1, {
				account = slot8[1],
				ts = tonumber(slot8[2])
			})
		end
	end

	table.sort(slot1, function (slot0, slot1)
		return slot1.ts < slot0.ts
	end)

	for slot7 = uv1 + 1, #slot1 do
		table.remove(slot1)
	end

	return slot1
end

function slot0._getHistoryAccountList(slot0)
	if not slot0._historyAccountStrList then
		slot0._historyAccountStrList = slot0:_getHistoryAccountPlayerPrefs()
	end

	return slot0._historyAccountStrList
end

function slot0._initHistoryAccountData(slot0)
	slot0._lastAccount = PlayerPrefsHelper.getString(PlayerPrefsKey.SimulateAccount, "")
	slot0._curAccountIndex = 0
	slot0.__firstInited = true
end

function slot0._initHistoryAccount(slot0)
	if slot0.__isHistoryAccountInited then
		return
	end

	slot0.__isHistoryAccountInited = true

	slot0:_initHistoryAccountData()
	slot0:_initHistoryAccountView()
end

function slot0._initHistoryAccountView(slot0)
	slot1 = slot0._inputField.gameObject
	slot2 = gohelper.create2d(slot0.viewGO, "===History Account===")
	slot3 = gohelper.create2d(slot2)
	slot4 = slot3.transform
	slot5 = gohelper.clone(gohelper.findChild(slot1, "Text"), slot3)
	slot6 = slot5.transform
	slot8 = gohelper.findChildText(slot5, "")

	recthelper.setWidth(slot4, 500)
	UIDockingHelper.setDock(UIDockingHelper.Dock.MR_R, slot4, slot1.transform)

	slot8.richText = true
	slot6.anchorMin = Vector2.New(0, 0)
	slot6.anchorMax = Vector2.New(1, 1)
	slot6.pivot = Vector2.New(0.5, 0.5)

	recthelper.setAnchor(slot6, 0, 0)

	slot6.sizeDelta = Vector2.New(0, 0)

	ZProj.UGUIHelper.SetColorAlpha(gohelper.onceAddComponent(slot3, gohelper.Type_Image), 0.5)

	slot0._historyAccountGo = slot2
	slot0._historyAccountText = slot8
	slot0._historyAccountImgTrans = slot4

	slot0:_refreshHistoryAccountView()
end

slot6 = "#00FF00"

function slot0._refreshHistoryAccountView(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0:_getHistoryAccountList()) do
		if slot6 - 1 == slot0._curAccountIndex then
			slot8 = gohelper.getRichColorText(tostring(slot7.account), uv0)
		end

		table.insert(slot2, slot8)
	end

	slot0._historyAccountText.text = table.concat(slot2, "\n")

	recthelper.setHeight(slot0._historyAccountImgTrans, slot0._historyAccountText.preferredHeight)
end

function slot0._selectBeforeAccount(slot0)
	slot0:_initHistoryAccount()

	slot1 = #slot0:_getHistoryAccountList()

	slot0:_onHistoryAccountDropDownChange((slot0._curAccountIndex + slot1 - 1) % slot1)
end

function slot0._selectNextAccount(slot0)
	slot0:_initHistoryAccount()
	slot0:_onHistoryAccountDropDownChange((slot0._curAccountIndex + 1) % #slot0:_getHistoryAccountList())
end

function slot0._setLoginAccountInput(slot0, slot1)
	slot0._inputField:SetText(slot1 or "")
end

function slot0._onHistoryAccountDropDownChange(slot0, slot1)
	if not slot0._historyAccountStrList then
		return
	end

	if slot0.__firstInited then
		slot1 = 0
		slot0.__firstInited = false
	end

	if slot0._curAccountIndex == GameUtil.clamp(slot1, 0, #slot0._historyAccountStrList - 1) then
		return
	end

	slot0._curAccountIndex = slot1

	slot0:_setLoginAccountInput(slot0._historyAccountStrList[slot1 + 1].account)
	slot0:_refreshHistoryAccountView()
end

function slot0.onClose_(slot0)
	UpdateBeat:Remove(slot0._onUpdate, slot0)

	if slot0._hestoryAccountDropDown then
		slot0._hestoryAccountDropDown:RemoveOnValueChanged()
	end

	slot0:_saveHistoryAccount()
end

function slot0.ctor(slot0)
	slot0._button = nil
	slot0._inputField = nil
end

function slot0.onInitView(slot0)
	slot0._button = gohelper.findChildButtonWithAudio(slot0.viewGO, "Button")
	slot0._inputField = gohelper.findChildTextMeshInputField(slot0.viewGO, "InputField")
	slot0._btnAgeFit = gohelper.findChildButtonWithAudio(slot0.viewGO, "leftbtn/#btn_agefit")
end

function slot0.addEvents(slot0)
	slot0._button:AddClickListener(slot0._onClickButton, slot0)
	slot0._btnAgeFit:AddClickListener(slot0._onClickAgeFit, slot0)
	slot0._inputField:AddOnEndEdit(slot0._onEndEdit, slot0)
end

function slot0.removeEvents(slot0)
	slot0._button:RemoveClickListener()
	slot0._btnAgeFit:RemoveClickListener()
	slot0._inputField:RemoveOnEndEdit()
end

function slot0.onOpen(slot0)
	UpdateBeat:Add(slot0._onUpdate, slot0)
	gohelper.addUIClickAudio(slot0._button.gameObject, AudioEnum.UI.UI_Common_Click)
	slot0._inputField:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.SimulateAccount))
	TaskDispatcher.runRepeat(slot0._onTick, slot0, 0.1)
	gohelper.setActive(slot0._btnAgeFit.gameObject, not (tostring(SDKMgr.instance:getChannelId()) == "102") and SettingsModel.instance:isZhRegion())
end

function slot0.onClose(slot0)
	slot0:onClose_()
	TaskDispatcher.cancelTask(slot0._onTick, slot0)
end

function slot0._onTick(slot0)
	if not ViewMgr.instance:isOpen(ViewName.LoginView) then
		logNormal("LoginView has close, close SimulateLoginView too")
		slot0:closeThis()
	end
end

function slot0._onClickButton(slot0, slot1)
	if string.nilorempty(slot0._inputField:GetText()) then
		GameFacade.showToast(ToastEnum.SimulateLogin)

		return
	end

	slot0:closeThis()
	LoginModel.instance:setChannelParam("", slot2, "", "", "")
	LoginController.instance:login({})
end

function slot0.onClickModalMask(slot0)
	slot0:_onClickButton()
end

function slot0._onClickAgeFit(slot0)
	ViewMgr.instance:openView(ViewName.SdkFitAgeTipView)
end

function slot0._onEndEdit(slot0, slot1)
	PlayerPrefsHelper.setString(PlayerPrefsKey.SimulateAccount, slot1)
end

return slot0
