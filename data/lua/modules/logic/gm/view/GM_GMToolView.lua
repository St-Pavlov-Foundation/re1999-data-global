module("modules.logic.gm.view.GM_GMToolView", package.seeall)

local var_0_0 = class("GM_GMToolView", BaseView)

function var_0_0.register()
	var_0_0.GMToolView_register(GMToolView)
end

local function var_0_1()
	if not MainController.instance then
		return
	end

	local var_2_0 = MainController.instance._popupFlow

	if not var_2_0 then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	local var_2_1 = var_2_0:getWorkList()
	local var_2_2 = MainThumbnailWork
	local var_2_3 = false

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		if iter_2_1.class == var_2_2 then
			var_2_3 = true

			break
		end
	end

	if not var_2_3 then
		return
	end

	PatFaceController.instance:_destroyPopupFlow()
	MainController.instance:_destroyPopupFlow()
	ViewMgr.instance:closeAllViews({
		ViewName.MainView,
		ViewName.GMToolView,
		ViewName.GMToolView2
	})
	MainController.instance:_onPopupFlowDone(true)
end

function var_0_0.GMToolView_register(arg_3_0)
	GMMinusModel.instance:saveOriginalFunc(arg_3_0, "onInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_3_0, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_3_0, "onOpen")
	GMMinusModel.instance:saveOriginalFunc(arg_3_0, "_sendGM")

	function arg_3_0.onInitView(arg_4_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_4_0, "onInitView", ...)

		if not SettingsModel.instance:isOverseas() then
			return
		end

		local var_4_0 = gohelper.findChild(arg_4_0.viewGO, "viewport/content")
		local var_4_1 = gohelper.findChild(var_4_0, "item25")
		local var_4_2 = gohelper.findChild(var_4_0, "item40")
		local var_4_3 = gohelper.cloneInPlace(var_4_1, "[GM_GMToolView]dropLangChangeGo")

		arg_4_0._dropLangChange = gohelper.findChildDropdown(var_4_3, "Dropdown")
		gohelper.findChildText(var_4_3, "text").text = luaLang("language")

		gohelper.setSiblingAfter(var_4_3, var_4_2)

		local var_4_4 = gohelper.create2d(var_4_0, "[GM_GMToolView]empty")

		gohelper.setSiblingAfter(var_4_4, var_4_3)
	end

	function arg_3_0.removeEvents(arg_5_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_5_0, "removeEvents", ...)

		if not SettingsModel.instance:isOverseas() then
			return
		end

		arg_5_0._dropLangChange:RemoveOnValueChanged()
	end

	function arg_3_0.onOpen(arg_6_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_6_0, "onOpen", ...)

		if not SettingsModel.instance:isOverseas() then
			return
		end

		arg_6_0:_initLangChange()
		arg_6_0._dropLangChange:AddOnValueChanged(arg_6_0._onLangChange, arg_6_0)
	end

	function arg_3_0._sendGM(arg_7_0, arg_7_1)
		GameFacade.showToast(ToastEnum.IconId, arg_7_1)
		GMCommandHistoryModel.instance:addCommandHistory(arg_7_1)

		if arg_7_1:find("bossrush") then
			BossRushController_Test.instance:_test(arg_7_1)

			return
		end

		if string.find(arg_7_1, "#") == 1 then
			local var_7_0 = string.split(arg_7_1, " ")

			arg_7_0:_clientGM(var_7_0)

			return
		end

		if GMToolCommands.sendGM(arg_7_1) then
			return
		end

		GMRpc.instance:sendGMRequest(arg_7_1)
		arg_7_0:_onServerGM(arg_7_1)
	end

	function arg_3_0._initLangChange(arg_8_0)
		if not SettingsModel.instance:isOverseas() then
			return
		end

		local var_8_0 = GameConfig:GetSupportedLangs()
		local var_8_1 = var_8_0.Length

		arg_8_0.supportLangs = {}

		for iter_8_0 = 0, var_8_1 - 1 do
			table.insert(arg_8_0.supportLangs, LangSettings.shortcutTab[var_8_0[iter_8_0]])
		end

		arg_8_0._dropLangChange:ClearOptions()
		arg_8_0._dropLangChange:AddOptions(arg_8_0.supportLangs)

		local var_8_2 = LangSettings.instance:getCurLangShortcut()

		for iter_8_1 = 1, #arg_8_0.supportLangs do
			if arg_8_0.supportLangs[iter_8_1] == var_8_2 then
				arg_8_0._dropLangChange:SetValue(iter_8_1 - 1)

				break
			end
		end
	end

	function arg_3_0._onLangChange(arg_9_0, arg_9_1)
		if not SettingsModel.instance:isOverseas() then
			return
		end

		local var_9_0 = arg_9_0.supportLangs[arg_9_1 + 1]

		LangSettings.instance:SetCurLangType(var_9_0)

		local var_9_1 = GameLanguageMgr.instance:getStoryIndexByShortCut(var_9_0)

		GameLanguageMgr.instance:setLanguageTypeByStoryIndex(var_9_1)
		PlayerPrefsHelper.setNumber("StoryTxtLanType", var_9_1 - 1)
		SettingsController.instance:changeLangTxt()
	end

	if SettingsModel.instance:isOverseas() then
		var_0_1()
	end
end

return var_0_0
