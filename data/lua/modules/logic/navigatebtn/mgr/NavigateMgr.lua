module("modules.logic.navigatebtn.mgr.NavigateMgr", package.seeall)

slot0 = class("NavigateMgr")
slot1 = {
	[ViewName.ToastView] = true,
	[ViewName.StorySceneView] = true,
	[ViewName.FightDiceView] = true,
	[ViewName.BpVideoView] = true,
	[ViewName.PlayerChangeBgListView] = true,
	[ViewName.GMErrorView] = true,
	[ViewName.RougeMapTipView] = true
}
slot2 = {
	[ViewName.RougeMapTipView] = true,
	[ViewName.GMToolView2] = true
}

function slot0.init(slot0)
	slot0._eventSystemGO = gohelper.find("EventSystem")

	if slot0._eventSystemGO then
		slot0._eventSystem = slot0._eventSystemGO:GetComponent(typeof(UnityEngine.EventSystems.EventSystem))
	end

	slot0:setNavigationEnabled(false)

	slot0._escapeParamDict = {}
	slot0._escapeParamDictForNavigate = {}
	slot0._spaceParamDict = {}

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	TaskDispatcher.runRepeat(slot0._onFrame, slot0, 0.001)
end

function slot0.onEscapeBtnClick(slot0)
	slot0:_onEscapeBtnClick()
end

function slot0._onFrame(slot0)
	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.Escape) then
		slot0:_onEscapeBtnClick()
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.Space) then
		slot0:_onSpaceBtnClick()
	end
end

function slot0._onOpenView(slot0, slot1)
	slot0:_modifyScroll(slot1)
end

function slot0._onCloseView(slot0, slot1)
	slot0:removeEscape(slot1)
	slot0:removeEscape(slot1, true)
	slot0:removeSpace(slot1)
end

function slot0.addEscape(slot0, slot1, slot2, slot3, slot4)
	(slot4 and slot0._escapeParamDictForNavigate or slot0._escapeParamDict)[slot1] = {
		callback = slot2,
		callbackObj = slot3
	}
end

function slot0.removeEscape(slot0, slot1, slot2)
	(slot2 and slot0._escapeParamDictForNavigate or slot0._escapeParamDict)[slot1] = nil
end

function slot0.addSpace(slot0, slot1, slot2, slot3)
	slot0._spaceParamDict[slot1] = {
		callback = slot2,
		callbackObj = slot3
	}
end

function slot0.removeSpace(slot0, slot1)
	slot0._spaceParamDict[slot1] = nil
end

slot0.EscapeToLoginGuideID = 108

function slot0._onEscapeBtnClick(slot0)
	if BootNativeUtil.isAndroid() or SLFramework.FrameworkSettings.IsEditor then
		slot1 = GuideModel.instance:getById(uv0.EscapeToLoginGuideID)

		if ViewMgr.instance:isOpen(ViewName.LoginView) then
			-- Nothing
		elseif slot1 == nil or slot1.isFinish == false or GuideModel.instance:getDoingGuideId() == uv0.EscapeToLoginGuideID then
			if ViewMgr.instance:isOpen(ViewName.StoryLogView) then
				ViewMgr.instance:closeView(ViewName.StoryLogView)
			elseif ViewMgr.instance:isOpen(ViewName.NicknameConfirmView) then
				ViewMgr.instance:closeView(ViewName.NicknameConfirmView)
				PlayerController.instance:dispatchEvent(PlayerEvent.NickNameConfirmNo)
			elseif ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
				ViewMgr.instance:closeView(ViewName.MessageBoxView)
			else
				slot2 = uv0.sortOpenViewNameList(ViewMgr.instance:getOpenViewNameList())

				if slot2[#slot2] == ViewName.MainView and GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
					SDKMgr.instance:exitSdk()
				elseif slot3 == ViewName.SDKExitGameTopView then
					ViewMgr.instance:closeView(ViewName.SDKExitGameTopView)
				elseif slot3 == ViewName.FightTechniqueTipsView then
					ViewMgr.instance:closeView(ViewName.FightTechniqueTipsView)
				elseif slot3 == ViewName.FightGuideView then
					ViewMgr.instance:closeView(ViewName.FightGuideView)
				else
					ViewMgr.instance:openView(ViewName.SDKExitGameTopView, {})
				end
			end

			return
		end
	end

	if not slot0:isEventSystemActive() then
		return
	end

	if UIBlockMgr.instance:isBlock() then
		return
	end

	if GuideBlockMgr.instance:isBlock() then
		return
	end

	slot1 = ViewMgr.instance:getUIRoot()

	for slot6, slot7 in ipairs(uv0.sortOpenViewNameList(ViewMgr.instance:getOpenViewNameList())) do
		if ViewMgr.instance:getSetting(slot7).layer == "TOP" and not uv1[slot7] then
			return
		end

		if slot8.layer == "GUIDE" then
			return
		end
	end

	for slot6 = #slot2, 1, -1 do
		slot7 = slot2[slot6]
		slot8 = ViewMgr.instance:getSetting(slot7)
		slot9 = ViewMgr.instance:getContainer(slot7)

		if slot7 == ViewName.MainView then
			if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
				if BootNativeUtil.isAndroid() then
					SDKMgr.instance:exitSdk()
				else
					SDKController.instance:openSDKExitView()
				end
			end

			return
		elseif not uv2[slot7] then
			slot10 = slot9 and slot9.viewGO

			if (slot10 and slot10.transform.parent.parent) == slot1.transform then
				slot0:_dispatchEscape(slot7)

				return
			end
		end
	end
end

function slot0.isMainViewInTop(slot0)
	slot1 = ViewMgr.instance:getUIRoot()

	for slot6, slot7 in ipairs(uv0.sortOpenViewNameList(ViewMgr.instance:getOpenViewNameList())) do
		if ViewMgr.instance:getSetting(slot7).layer == "TOP" and slot7 ~= ViewName.GMToolView2 then
			return false
		end

		if slot8.layer == "GUIDE" then
			return false
		end
	end

	for slot6 = #slot2, 1, -1 do
		slot7 = slot2[slot6]
		slot8 = ViewMgr.instance:getSetting(slot7)
		slot9 = ViewMgr.instance:getContainer(slot7)

		if slot7 == ViewName.MainView then
			if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
				return true
			end
		elseif not uv1[slot7] then
			slot10 = slot9 and slot9.viewGO

			if (slot10 and slot10.transform.parent.parent) == slot1.transform then
				return false
			end
		end
	end

	return false
end

function slot0._dispatchEscape(slot0, slot1)
	if slot0._escapeParamDict[slot1] and slot2.callback then
		slot2.callback(slot2.callbackObj)

		return
	end

	if slot0._escapeParamDictForNavigate[slot1] and slot3.callback then
		slot3.callback(slot3.callbackObj)

		return
	end

	slot4 = ViewMgr.instance:getSetting(slot1)

	if not ViewMgr.instance:getContainer(slot1) then
		return
	end

	if not LoginModel.instance:isDoneLogin() then
		return
	end

	if slot4.viewType == ViewType.Modal then
		slot5:onClickModalMaskInternal()
	elseif slot4.layer == "POPUP_TOP" then
		if not slot0._dontCloseViewNameDict then
			slot0._dontCloseViewNameDict = {
				[ViewName.FightLoadingView] = true,
				[ViewName.WeekWalkSelectTarotView] = true,
				[ViewName.FightFailTipsView] = true,
				[SeasonViewHelper.getViewName(nil, Activity104Enum.ViewName.EquipSelfChoiceView)] = true,
				[ViewName.ExploreInteractView] = true,
				[ViewName.ExploreGuideDialogueView] = true,
				[ViewName.VersionActivity1_6EnterVideoView] = true,
				[ViewName.FullScreenVideoView] = true,
				[ViewName.ToughBattleLoadingView] = true,
				[ViewName.RougeResultView] = true
			}

			for slot10, slot11 in pairs(V1a6_CachotEventController.instance:getNoCloseViews()) do
				slot0._dontCloseViewNameDict[slot11] = true
			end

			Season123Controller.instance:addDontNavigateBtn(slot0._dontCloseViewNameDict)
		end

		if not slot0._dontCloseViewNameDict[slot1] then
			ViewMgr.instance:closeView(slot1, false, true)
		end
	end
end

function slot0._onSpaceBtnClick(slot0)
	if not slot0:isEventSystemActive() then
		return
	end

	if UIBlockMgr.instance:isBlock() then
		return
	end

	if GuideBlockMgr.instance:isBlock() then
		return
	end

	slot1 = ViewMgr.instance:getUIRoot()

	for slot6, slot7 in ipairs(uv0.sortOpenViewNameList(ViewMgr.instance:getOpenViewNameList())) do
		if ViewMgr.instance:getSetting(slot7).layer == "TOP" and not uv1[slot7] then
			return
		end

		if slot8.layer == "GUIDE" then
			slot0:_dispatchSpace(slot7)

			return
		end
	end

	for slot6 = #slot2, 1, -1 do
		slot7 = slot2[slot6]
		slot8 = ViewMgr.instance:getSetting(slot7)
		slot9 = ViewMgr.instance:getContainer(slot7)

		if slot7 ~= ViewName.ToastView and slot7 ~= ViewName.StorySceneView and not uv1[slot7] then
			slot10 = slot9 and slot9.viewGO

			if (slot10 and slot10.transform.parent.parent) == slot1.transform then
				slot0:_dispatchSpace(slot7)

				return
			end
		end
	end
end

function slot0._dispatchSpace(slot0, slot1)
	if slot0._spaceParamDict[slot1] and slot2.callback then
		slot2.callback(slot2.callbackObj)
	end

	if not LoginModel.instance:isDoneLogin() then
		return
	end
end

function slot0.setNavigationEnabled(slot0, slot1)
	if slot0._eventSystem then
		slot0._eventSystem.sendNavigationEvents = slot1
	end
end

function slot0.isEventSystemActive(slot0)
	return slot0._eventSystemGO and slot0._eventSystemGO.activeInHierarchy
end

function slot0._modifyScroll(slot0, slot1)
	if not (ViewMgr.instance:getContainer(slot1) and slot2.viewGO) then
		return
	end

	if slot3:GetComponentsInChildren(typeof(UnityEngine.UI.ScrollRect), true) then
		slot5 = slot4:GetEnumerator()

		while slot5:MoveNext() do
			slot5.Current.scrollSensitivity = 50
		end
	end
end

slot3 = {
	GUIDE = 4,
	POPUP = 2,
	HUD = 1,
	TOP = 6,
	MESSAGE = 5,
	POPUP_TOP = 3
}

function slot0.sortOpenViewNameList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0) do
		slot7 = {
			openViewName = slot6,
			originOrder = slot5,
			layerOrder = uv0.POPUP_TOP,
			layerOrder = uv0[slot8.layer]
		}

		if ViewMgr.instance:getSetting(slot6) and uv0[slot8.layer] then
			-- Nothing
		end

		table.insert(slot1, slot7)
	end

	table.sort(slot1, function (slot0, slot1)
		if slot0.layerOrder ~= slot1.layerOrder then
			return slot0.layerOrder < slot1.layerOrder
		end

		return slot0.originOrder < slot1.originOrder
	end)

	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2, slot7.openViewName)
	end

	return slot2
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
