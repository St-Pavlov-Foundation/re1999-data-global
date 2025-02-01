module("modules.logic.gm.view.GM_GMToolView", package.seeall)

slot0 = class("GM_GMToolView", BaseView)

function slot0.register()
	uv0.GMToolView_register(GMToolView)
end

function slot1()
	if not MainController.instance then
		return
	end

	if not MainController.instance._popupFlow then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	slot4 = false

	for slot8, slot9 in ipairs(slot0:getWorkList()) do
		if slot9.class == MainThumbnailWork then
			slot4 = true

			break
		end
	end

	if not slot4 then
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

function slot0.GMToolView_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "onInitView")
	GMMinusModel.instance:saveOriginalFunc(slot0, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "onOpen")
	GMMinusModel.instance:saveOriginalFunc(slot0, "_sendGM")

	function slot0.onInitView(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "onInitView", ...)

		slot1 = gohelper.findChild(slot0.viewGO, "viewport/content")
		slot4 = gohelper.cloneInPlace(gohelper.findChild(slot1, "item25"), "[GM_GMToolView]dropLangChangeGo")
		slot0._dropLangChange = gohelper.findChildDropdown(slot4, "Dropdown")
		gohelper.findChildText(slot4, "text").text = luaLang("language")

		gohelper.setSiblingAfter(slot4, gohelper.findChild(slot1, "item40"))
		gohelper.setSiblingAfter(gohelper.create2d(slot1, "[GM_GMToolView]empty"), slot4)
	end

	function slot0.removeEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "removeEvents", ...)
		slot0._dropLangChange:RemoveOnValueChanged()
	end

	function slot0.onOpen(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "onOpen", ...)
		slot0:_initLangChange()
		slot0._dropLangChange:AddOnValueChanged(slot0._onLangChange, slot0)
	end

	function slot0._sendGM(slot0, slot1)
		GameFacade.showToast(ToastEnum.IconId, slot1)

		if slot1:find("bossrush") then
			BossRushController_Test.instance:_test(slot1)

			return
		end

		if string.find(slot1, "#") == 1 then
			slot0:_clientGM(string.split(slot1, " "))

			return
		end

		if GMToolCommands.sendGM(slot1) then
			return
		end

		GMRpc.instance:sendGMRequest(slot1)
		slot0:_onServerGM(slot1)
	end

	function slot0._initLangChange(slot0)
		slot0.supportLangs = {}

		for slot6 = 0, GameConfig:GetSupportedLangs().Length - 1 do
			table.insert(slot0.supportLangs, LangSettings.shortcutTab[slot1[slot6]])
		end

		slot0._dropLangChange:ClearOptions()
		slot0._dropLangChange:AddOptions(slot0.supportLangs)

		for slot7 = 1, #slot0.supportLangs do
			if slot0.supportLangs[slot7] == LangSettings.instance:getCurLangShortcut() then
				slot0._dropLangChange:SetValue(slot7 - 1)

				break
			end
		end
	end

	function slot0._onLangChange(slot0, slot1)
		slot2 = slot0.supportLangs[slot1 + 1]

		LangSettings.instance:SetCurLangType(slot2)

		slot3 = GameLanguageMgr.instance:getStoryIndexByShortCut(slot2)

		GameLanguageMgr.instance:setLanguageTypeByStoryIndex(slot3)
		PlayerPrefsHelper.setNumber("StoryTxtLanType", slot3 - 1)
		SettingsController.instance:changeLangTxt()
	end

	uv0()
end

return slot0
