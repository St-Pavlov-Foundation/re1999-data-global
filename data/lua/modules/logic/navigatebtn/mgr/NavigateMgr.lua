module("modules.logic.navigatebtn.mgr.NavigateMgr", package.seeall)

local var_0_0 = class("NavigateMgr")
local var_0_1 = {
	[ViewName.ToastView] = true,
	[ViewName.StorySceneView] = true,
	[ViewName.FightDiceView] = true,
	[ViewName.BpVideoView] = true,
	[ViewName.PlayerChangeBgListView] = true,
	[ViewName.GMErrorView] = true,
	[ViewName.RougeMapTipView] = true,
	[ViewName.SurvivalToastView] = true
}
local var_0_2 = {
	[ViewName.RougeMapTipView] = true,
	[ViewName.GMToolView2] = true
}

function var_0_0.init(arg_1_0)
	arg_1_0._eventSystemGO = gohelper.find("EventSystem")

	if arg_1_0._eventSystemGO then
		arg_1_0._eventSystem = arg_1_0._eventSystemGO:GetComponent(typeof(UnityEngine.EventSystems.EventSystem))
	end

	arg_1_0:setNavigationEnabled(false)

	arg_1_0._escapeParamDict = {}
	arg_1_0._escapeParamDictForNavigate = {}
	arg_1_0._spaceParamDict = {}

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_1_0._onCloseView, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_1_0._onOpenView, arg_1_0)
	TaskDispatcher.runRepeat(arg_1_0._onFrame, arg_1_0, 0.001)
end

function var_0_0.onEscapeBtnClick(arg_2_0)
	arg_2_0:_onEscapeBtnClick()
end

function var_0_0._onFrame(arg_3_0)
	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.Escape) then
		arg_3_0:_onEscapeBtnClick()
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.Space) then
		arg_3_0:_onSpaceBtnClick()
	end
end

function var_0_0._onOpenView(arg_4_0, arg_4_1)
	arg_4_0:_modifyScroll(arg_4_1)
end

function var_0_0._onCloseView(arg_5_0, arg_5_1)
	arg_5_0:removeEscape(arg_5_1)
	arg_5_0:removeEscape(arg_5_1, true)
	arg_5_0:removeSpace(arg_5_1)
end

function var_0_0.addEscape(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	(arg_6_4 and arg_6_0._escapeParamDictForNavigate or arg_6_0._escapeParamDict)[arg_6_1] = {
		callback = arg_6_2,
		callbackObj = arg_6_3
	}
end

function var_0_0.removeEscape(arg_7_0, arg_7_1, arg_7_2)
	(arg_7_2 and arg_7_0._escapeParamDictForNavigate or arg_7_0._escapeParamDict)[arg_7_1] = nil
end

function var_0_0.addSpace(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0._spaceParamDict[arg_8_1] = {
		callback = arg_8_2,
		callbackObj = arg_8_3
	}
end

function var_0_0.removeSpace(arg_9_0, arg_9_1)
	arg_9_0._spaceParamDict[arg_9_1] = nil
end

var_0_0.EscapeToLoginGuideID = 108

function var_0_0._onEscapeBtnClick(arg_10_0)
	if BootNativeUtil.isAndroid() or SLFramework.FrameworkSettings.IsEditor then
		local var_10_0 = GuideModel.instance:getById(var_0_0.EscapeToLoginGuideID)

		if ViewMgr.instance:isOpen(ViewName.LoginView) then
			-- block empty
		elseif var_10_0 == nil or var_10_0.isFinish == false or GuideModel.instance:getDoingGuideId() == var_0_0.EscapeToLoginGuideID then
			if ViewMgr.instance:isOpen(ViewName.StoryLogView) then
				ViewMgr.instance:closeView(ViewName.StoryLogView)
			elseif ViewMgr.instance:isOpen(ViewName.NicknameConfirmView) then
				ViewMgr.instance:closeView(ViewName.NicknameConfirmView)
				PlayerController.instance:dispatchEvent(PlayerEvent.NickNameConfirmNo)
			elseif ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
				ViewMgr.instance:closeView(ViewName.MessageBoxView)
			else
				local var_10_1 = ViewMgr.instance:getOpenViewNameList()
				local var_10_2 = var_0_0.sortOpenViewNameList(var_10_1)
				local var_10_3 = var_10_2[#var_10_2]

				if var_10_3 == ViewName.MainView and GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
					SDKMgr.instance:exitSdk()
				elseif var_10_3 == ViewName.SDKExitGameTopView then
					ViewMgr.instance:closeView(ViewName.SDKExitGameTopView)
				elseif var_10_3 == ViewName.FightTechniqueTipsView then
					ViewMgr.instance:closeView(ViewName.FightTechniqueTipsView)
				elseif var_10_3 == ViewName.FightGuideView then
					ViewMgr.instance:closeView(ViewName.FightGuideView)
				else
					local var_10_4 = {}

					ViewMgr.instance:openView(ViewName.SDKExitGameTopView, var_10_4)
				end
			end

			return
		end
	end

	if not arg_10_0:isEventSystemActive() then
		return
	end

	if UIBlockMgr.instance:isBlock() then
		return
	end

	if GuideBlockMgr.instance:isBlock() then
		return
	end

	local var_10_5 = ViewMgr.instance:getUIRoot()
	local var_10_6 = ViewMgr.instance:getOpenViewNameList()
	local var_10_7 = var_0_0.sortOpenViewNameList(var_10_6)

	for iter_10_0, iter_10_1 in ipairs(var_10_7) do
		local var_10_8 = ViewMgr.instance:getSetting(iter_10_1)

		if var_10_8.layer == "TOP" and not var_0_2[iter_10_1] then
			return
		end

		if var_10_8.layer == "GUIDE" then
			return
		end
	end

	for iter_10_2 = #var_10_7, 1, -1 do
		local var_10_9 = var_10_7[iter_10_2]
		local var_10_10 = ViewMgr.instance:getSetting(var_10_9)
		local var_10_11 = ViewMgr.instance:getContainer(var_10_9)

		if var_10_9 == ViewName.MainView then
			if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
				if BootNativeUtil.isAndroid() then
					SDKMgr.instance:exitSdk()
				else
					SDKController.instance:openSDKExitView()
				end
			end

			return
		elseif not var_0_1[var_10_9] then
			local var_10_12 = var_10_11 and var_10_11.viewGO

			if (var_10_12 and var_10_12.transform.parent.parent) == var_10_5.transform then
				arg_10_0:_dispatchEscape(var_10_9)

				return
			end
		end
	end
end

function var_0_0.isMainViewInTop(arg_11_0)
	local var_11_0 = ViewMgr.instance:getUIRoot()
	local var_11_1 = ViewMgr.instance:getOpenViewNameList()
	local var_11_2 = var_0_0.sortOpenViewNameList(var_11_1)

	for iter_11_0, iter_11_1 in ipairs(var_11_2) do
		local var_11_3 = ViewMgr.instance:getSetting(iter_11_1)

		if var_11_3.layer == "TOP" and iter_11_1 ~= ViewName.GMToolView2 then
			return false
		end

		if var_11_3.layer == "GUIDE" then
			return false
		end
	end

	for iter_11_2 = #var_11_2, 1, -1 do
		local var_11_4 = var_11_2[iter_11_2]
		local var_11_5 = ViewMgr.instance:getSetting(var_11_4)
		local var_11_6 = ViewMgr.instance:getContainer(var_11_4)

		if var_11_4 == ViewName.MainView then
			if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
				return true
			end
		elseif not var_0_1[var_11_4] then
			local var_11_7 = var_11_6 and var_11_6.viewGO

			if (var_11_7 and var_11_7.transform.parent.parent) == var_11_0.transform then
				return false
			end
		end
	end

	return false
end

function var_0_0._dispatchEscape(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._escapeParamDict[arg_12_1]

	if var_12_0 and var_12_0.callback then
		var_12_0.callback(var_12_0.callbackObj)

		return
	end

	local var_12_1 = arg_12_0._escapeParamDictForNavigate[arg_12_1]

	if var_12_1 and var_12_1.callback then
		var_12_1.callback(var_12_1.callbackObj)

		return
	end

	local var_12_2 = ViewMgr.instance:getSetting(arg_12_1)
	local var_12_3 = ViewMgr.instance:getContainer(arg_12_1)

	if not var_12_3 then
		return
	end

	if not LoginModel.instance:isDoneLogin() then
		return
	end

	if var_12_2.viewType == ViewType.Modal then
		var_12_3:onClickModalMaskInternal()
	elseif var_12_2.layer == "POPUP_TOP" then
		if not arg_12_0._dontCloseViewNameDict then
			arg_12_0._dontCloseViewNameDict = {}
			arg_12_0._dontCloseViewNameDict[ViewName.FightLoadingView] = true
			arg_12_0._dontCloseViewNameDict[ViewName.WeekWalkSelectTarotView] = true
			arg_12_0._dontCloseViewNameDict[ViewName.FightFailTipsView] = true

			local var_12_4 = SeasonViewHelper.getViewName(nil, Activity104Enum.ViewName.EquipSelfChoiceView)

			arg_12_0._dontCloseViewNameDict[var_12_4] = true
			arg_12_0._dontCloseViewNameDict[ViewName.ExploreInteractView] = true
			arg_12_0._dontCloseViewNameDict[ViewName.ExploreGuideDialogueView] = true
			arg_12_0._dontCloseViewNameDict[ViewName.VersionActivity1_6EnterVideoView] = true
			arg_12_0._dontCloseViewNameDict[ViewName.FullScreenVideoView] = true
			arg_12_0._dontCloseViewNameDict[ViewName.ToughBattleLoadingView] = true
			arg_12_0._dontCloseViewNameDict[ViewName.RougeResultView] = true

			for iter_12_0, iter_12_1 in pairs(V1a6_CachotEventController.instance:getNoCloseViews()) do
				arg_12_0._dontCloseViewNameDict[iter_12_1] = true
			end

			Season123Controller.instance:addDontNavigateBtn(arg_12_0._dontCloseViewNameDict)
		end

		if not arg_12_0._dontCloseViewNameDict[arg_12_1] then
			ViewMgr.instance:closeView(arg_12_1, false, true)
		end
	end
end

function var_0_0._onSpaceBtnClick(arg_13_0)
	if not arg_13_0:isEventSystemActive() then
		return
	end

	if UIBlockMgr.instance:isBlock() then
		return
	end

	if GuideBlockMgr.instance:isBlock() then
		return
	end

	local var_13_0 = ViewMgr.instance:getUIRoot()
	local var_13_1 = ViewMgr.instance:getOpenViewNameList()
	local var_13_2 = var_0_0.sortOpenViewNameList(var_13_1)

	for iter_13_0, iter_13_1 in ipairs(var_13_2) do
		local var_13_3 = ViewMgr.instance:getSetting(iter_13_1)

		if var_13_3.layer == "TOP" and not var_0_2[iter_13_1] then
			return
		end

		if var_13_3.layer == "GUIDE" then
			arg_13_0:_dispatchSpace(iter_13_1)

			return
		end
	end

	for iter_13_2 = #var_13_2, 1, -1 do
		local var_13_4 = var_13_2[iter_13_2]
		local var_13_5 = ViewMgr.instance:getSetting(var_13_4)
		local var_13_6 = ViewMgr.instance:getContainer(var_13_4)

		if var_13_4 ~= ViewName.ToastView and var_13_4 ~= ViewName.StorySceneView and not var_0_2[var_13_4] then
			local var_13_7 = var_13_6 and var_13_6.viewGO

			if (var_13_7 and var_13_7.transform.parent.parent) == var_13_0.transform then
				arg_13_0:_dispatchSpace(var_13_4)

				return
			end
		end
	end
end

function var_0_0._dispatchSpace(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._spaceParamDict[arg_14_1]

	if var_14_0 and var_14_0.callback then
		var_14_0.callback(var_14_0.callbackObj)
	end

	if not LoginModel.instance:isDoneLogin() then
		return
	end
end

function var_0_0.setNavigationEnabled(arg_15_0, arg_15_1)
	if arg_15_0._eventSystem then
		arg_15_0._eventSystem.sendNavigationEvents = arg_15_1
	end
end

function var_0_0.isEventSystemActive(arg_16_0)
	return arg_16_0._eventSystemGO and arg_16_0._eventSystemGO.activeInHierarchy
end

function var_0_0._modifyScroll(arg_17_0, arg_17_1)
	local var_17_0 = ViewMgr.instance:getContainer(arg_17_1)
	local var_17_1 = var_17_0 and var_17_0.viewGO

	if not var_17_1 then
		return
	end

	local var_17_2 = var_17_1:GetComponentsInChildren(typeof(UnityEngine.UI.ScrollRect), true)

	if var_17_2 then
		local var_17_3 = var_17_2:GetEnumerator()

		while var_17_3:MoveNext() do
			var_17_3.Current.scrollSensitivity = 50
		end
	end
end

local var_0_3 = {
	GUIDE = 4,
	POPUP = 2,
	HUD = 1,
	TOP = 6,
	MESSAGE = 5,
	POPUP_TOP = 3
}

function var_0_0.sortOpenViewNameList(arg_18_0)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_0) do
		local var_18_1 = {
			openViewName = iter_18_1,
			originOrder = iter_18_0
		}
		local var_18_2 = ViewMgr.instance:getSetting(iter_18_1)

		var_18_1.layerOrder = var_0_3.POPUP_TOP

		if var_18_2 and var_0_3[var_18_2.layer] then
			var_18_1.layerOrder = var_0_3[var_18_2.layer]
		end

		table.insert(var_18_0, var_18_1)
	end

	table.sort(var_18_0, function(arg_19_0, arg_19_1)
		if arg_19_0.layerOrder ~= arg_19_1.layerOrder then
			return arg_19_0.layerOrder < arg_19_1.layerOrder
		end

		return arg_19_0.originOrder < arg_19_1.originOrder
	end)

	local var_18_3 = {}

	for iter_18_2, iter_18_3 in ipairs(var_18_0) do
		table.insert(var_18_3, iter_18_3.openViewName)
	end

	return var_18_3
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
