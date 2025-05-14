module("modules.logic.jump.controller.JumpController", package.seeall)

local var_0_0 = class("JumpController", BaseController)

function var_0_0.onInit(arg_1_0)
	JumpControllerCanJumpFunc.activateCanJumpFuncController()
	JumpControllerHandleFunc.activateHandleFuncController()

	arg_1_0.isInitLogicDefine = false
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.clear(arg_3_0)
	arg_3_0.waitOpenViewNames = nil
	arg_3_0.remainViewNames = nil
	arg_3_0.closeViewNames = nil
	arg_3_0._callback = nil
	arg_3_0._callbackObj = nil
	arg_3_0.jumpStage = JumpEnum.JumpStage.None
end

function var_0_0.addConstEvents(arg_4_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_4_0._onOpenView, arg_4_0)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, arg_4_0._onOpenView, arg_4_0)
end

function var_0_0.reInit(arg_5_0)
	arg_5_0:clear()
end

function var_0_0.initLogicDefine(arg_6_0)
	if arg_6_0.isInitLogicDefine then
		return
	end

	arg_6_0:initJumpViewBelongScene()

	arg_6_0.isInitLogicDefine = true
end

function var_0_0.initJumpViewBelongScene(arg_7_0)
	arg_7_0.jumpViewBelongScene = {
		[JumpEnum.JumpView.StoreView] = {
			SceneType.Main,
			SceneType.Room
		},
		[JumpEnum.JumpView.RoomProductLineView] = {
			SceneType.Main,
			SceneType.Room
		},
		[JumpEnum.JumpView.DungeonViewWithChapter] = SceneType.Main,
		[JumpEnum.JumpView.DungeonViewWithEpisode] = SceneType.Main,
		[JumpEnum.JumpView.DungeonViewWithType] = SceneType.Main,
		[JumpEnum.JumpView.CharacterBackpackViewWithCharacter] = SceneType.Main,
		[JumpEnum.JumpView.CharacterBackpackViewWithEquip] = SceneType.Main,
		[JumpEnum.JumpView.HeroGroupView] = SceneType.Main,
		[JumpEnum.JumpView.BackpackView] = SceneType.Main,
		[JumpEnum.JumpView.PlayerClothView] = SceneType.Main,
		[JumpEnum.JumpView.MainView] = SceneType.Main,
		[JumpEnum.JumpView.TaskView] = SceneType.Main,
		[JumpEnum.JumpView.TeachNoteView] = SceneType.Main,
		[JumpEnum.JumpView.HandbookView] = SceneType.Main,
		[JumpEnum.JumpView.SocialView] = SceneType.Main,
		[JumpEnum.JumpView.NoticeView] = SceneType.Main,
		[JumpEnum.JumpView.SignInView] = SceneType.Main,
		[JumpEnum.JumpView.SignInViewWithBirthDay] = SceneType.Main,
		[JumpEnum.JumpView.SeasonMainView] = SceneType.Main,
		[JumpEnum.JumpView.EquipView] = SceneType.Main,
		[JumpEnum.JumpView.BpView] = SceneType.Main,
		[JumpEnum.JumpView.Show] = SceneType.Main,
		[JumpEnum.JumpView.ActivityView] = SceneType.Main,
		[JumpEnum.JumpView.LeiMiTeBeiDungeonView] = SceneType.Main,
		[JumpEnum.JumpView.SummonView] = SceneType.Main,
		[JumpEnum.JumpView.V1a5Dungeon] = SceneType.Main,
		[JumpEnum.JumpView.RoomView] = SceneType.Room,
		[JumpEnum.JumpView.PushBox] = SceneType.PushBox
	}
end

function var_0_0._onOpenView(arg_8_0, arg_8_1)
	if arg_8_0.jumpStage ~= JumpEnum.JumpStage.Jumping then
		return
	end

	if not arg_8_0.canDispatchCallback then
		return
	end

	if arg_8_0.waitOpenViewNames and tabletool.indexOf(arg_8_0.waitOpenViewNames, arg_8_1) then
		tabletool.removeValue(arg_8_0.waitOpenViewNames, arg_8_1)
	end

	arg_8_0:dispatchCallback()
end

function var_0_0.checkJumpDone(arg_9_0)
	return not arg_9_0.waitOpenViewNames or not next(arg_9_0.waitOpenViewNames)
end

function var_0_0.dispatchCallback(arg_10_0)
	if not arg_10_0:checkJumpDone() then
		return
	end

	if arg_10_0._callback then
		arg_10_0._callback(arg_10_0._callbackObj)
	end

	arg_10_0:reInit()
end

function var_0_0.jump(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if not LoginController.instance:isEnteredGame() then
		return false
	end

	arg_11_1 = tonumber(arg_11_1)

	local var_11_0 = JumpConfig.instance:getJumpConfig(arg_11_1)

	if var_11_0 then
		if not arg_11_0:isJumpOpen(arg_11_1) then
			local var_11_1, var_11_2 = OpenHelper.getToastIdAndParam(var_11_0.openId)

			if var_11_1 then
				GameFacade.showToastWithTableParam(var_11_1, var_11_2)
			end

			return false
		else
			local var_11_3, var_11_4, var_11_5 = arg_11_0:canJumpNew(var_11_0.param)

			if not var_11_3 then
				GameFacade.showToastWithTableParam(var_11_4, var_11_5)

				return false
			end
		end

		local var_11_6 = var_11_0.param

		return arg_11_0:jumpTo(var_11_6, arg_11_2, arg_11_3, arg_11_4) == JumpEnum.JumpResult.Success
	end

	return false
end

function var_0_0.jumpByAdditionParam(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = string.split(arg_12_1, "#")
	local var_12_1 = tonumber(var_12_0[1])
	local var_12_2 = ""

	for iter_12_0 = 2, #var_12_0 do
		var_12_2 = string.format("%s#%s", var_12_2, var_12_0[iter_12_0])
	end

	local var_12_3 = JumpConfig.instance:getJumpConfig(var_12_1)

	if var_12_3 then
		if not arg_12_0:isJumpOpen(var_12_1) then
			local var_12_4, var_12_5 = OpenHelper.getToastIdAndParam(var_12_3.openId)

			if var_12_4 then
				GameFacade.showToastWithTableParam(var_12_4, var_12_5)
			end

			return false
		else
			local var_12_6, var_12_7, var_12_8 = arg_12_0:canJumpNew(var_12_3.param)

			if not var_12_6 then
				GameFacade.showToastWithTableParam(var_12_7, var_12_8)

				return false
			end
		end

		local var_12_9 = var_12_3.param
		local var_12_10 = string.format("%s%s", var_12_9, var_12_2)

		return arg_12_0:jumpTo(var_12_10, arg_12_2, arg_12_3, arg_12_4) == JumpEnum.JumpResult.Success
	end

	return false
end

function var_0_0.jumpByParamWithCondition(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0, var_13_1, var_13_2 = arg_13_0:canJumpNew(arg_13_1)

	if not var_13_0 then
		GameFacade.showToastWithTableParam(var_13_1, var_13_2)

		return false
	end

	return arg_13_0:jumpTo(arg_13_1, arg_13_2, arg_13_3, arg_13_4) == JumpEnum.JumpResult.Success
end

function var_0_0.jumpByParam(arg_14_0, arg_14_1)
	arg_14_0:jumpTo(arg_14_1)
end

local var_0_1 = {
	"V1a5_HarvestSeason_PanelSignView",
	"V2a0_SummerSign_PanelView",
	"V2a1_MoonFestival_PanelView",
	"V2a2_SpringFestival_PanelView",
	"ActivityDoubleFestivalSignPaiLianView_1_3",
	"ActivityStarLightSignPart1PaiLianView_1_3",
	"ActivityStarLightSignPart2PaiLianView_1_3",
	"V1a4_Role_PanelSignView_Part1",
	"V1a4_Role_PanelSignView_Part2",
	"V1a5_Role_PanelSignView_Part1",
	"V1a5_Role_PanelSignView_Part2",
	"V1a6_Role_PanelSignView_Part1",
	"V1a6_Role_PanelSignView_Part2",
	"V1a5_DoubleFestival_PanelSignView",
	"V1a6_Spring_PanelSignView",
	"V1a7_Role_PanelSignView_Part1",
	"V1a7_Role_PanelSignView_Part2",
	"LanternFestivalView",
	"V1a8_Role_PanelSignView_Part1",
	"V1a8_Role_PanelSignView_Part2",
	"V1a8_Work_PanelSignView",
	"V1a9_Role_PanelSignView_Part1",
	"V1a9_Role_PanelSignView_Part2",
	"DragonBoatFestivalView",
	"V1a9_AnniversarySign_PanelSignView",
	"V2a0_SummerSign_PanelView",
	"V2a0_Role_PanelSignView_Part1",
	"V2a0_Role_PanelSignView_Part2",
	"V2a1_Role_PanelSignView_Part1",
	"V2a1_Role_PanelSignView_Part2",
	"V2a1_MoonFestival_PanelView",
	"V2a2_Role_PanelSignView_Part1",
	"V2a2_Role_PanelSignView_Part2",
	"V2a2_RedLeafFestival_PanelView",
	"V2a3_Role_PanelSignView_Part1",
	"V2a3_Role_PanelSignView_Part2",
	"V2a3_Special_PanelsView",
	"V2a4_Role_PanelSignView_Part1",
	"V2a4_Role_PanelSignView_Part2",
	"V2a5_Role_PanelSignView_Part1",
	"V2a5_Role_PanelSignView_Part2",
	"V2a7_Labor_PanelSignView"
}

function var_0_0.jumpTo(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	arg_15_0:dispatchEvent(JumpEvent.BeforeJump, arg_15_1)
	arg_15_0:initLogicDefine()

	if string.nilorempty(arg_15_1) then
		logError("跳转参数为空")

		return JumpEnum.JumpResult.Fail
	end

	arg_15_0.jumpStage = JumpEnum.JumpStage.Jumping

	local var_15_0 = string.splitToNumber(arg_15_1, "#")[1]

	if ViewMgr.instance:isOpen(ViewName.CommonPropView) or ViewMgr.instance:isOpen(ViewName.BpPropView) or ViewMgr.instance:isOpen(ViewName.BpPropView2) or ViewMgr.instance:isOpen(ViewName.FightSuccView) then
		GameFacade.showToast(ToastEnum.MaterialTipJump)

		return false
	end

	if VirtualSummonScene.instance:isOpen() and var_15_0 ~= JumpEnum.JumpView.StoreView then
		GameFacade.showToast(ToastEnum.MaterialTipJump)

		return false
	end

	for iter_15_0, iter_15_1 in ipairs(var_0_1) do
		local var_15_1 = ViewName[iter_15_1]

		if ViewMgr.instance:isOpen(var_15_1) then
			GameFacade.showToast(ToastEnum.MaterialTipJump)

			return false
		end
	end

	if arg_15_0:_checkNeedSwitchScene(var_15_0) then
		DungeonModel.instance.curSendEpisodeId = nil

		ViewMgr.instance:closeAllPopupViews()

		local var_15_2 = arg_15_0:_getJumpViewDefaultScene(var_15_0)

		if var_15_2 == SceneType.Main then
			MainController.instance:enterMainScene(true)
		elseif var_15_2 == SceneType.Room then
			RoomController.instance:enterRoom(RoomEnum.GameMode.Ob, nil, nil, nil, nil, true)
		elseif var_15_2 == SceneType.PushBox then
			PushBoxController.instance:enterPushBoxGame()
		else
			var_15_2 = SceneType.Main

			MainController.instance:enterMainScene()
		end

		ViewMgr.instance:closeAllPopupViews()
		SceneHelper.instance:waitSceneDone(var_15_2, function()
			arg_15_0:jumpTo(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
		end)

		return JumpEnum.JumpResult.Success
	end

	JumpModel.instance:setRecordFarmItem(arg_15_4)

	arg_15_0._callback = arg_15_2
	arg_15_0._callbackObj = arg_15_3
	arg_15_0.waitOpenViewNames = {}
	arg_15_0.remainViewNames = {}
	arg_15_0.closeViewNames = {}

	local var_15_3 = var_0_0.JumpViewToHandleFunc[var_15_0]

	if not var_15_3 then
		logError("跳转参数错误: " .. arg_15_1)
		arg_15_0:reInit()

		return JumpEnum.JumpResult.Fail
	end

	arg_15_0.canDispatchCallback = false

	local var_15_4 = var_15_3(arg_15_0, arg_15_1)

	arg_15_0.canDispatchCallback = true

	if var_15_4 ~= JumpEnum.JumpResult.Success then
		arg_15_0:reInit()

		return var_15_4
	end

	table.insert(arg_15_0.closeViewNames, ViewName.NormalStoreGoodsView)
	table.insert(arg_15_0.closeViewNames, ViewName.ChargeStoreGoodsView)
	table.insert(arg_15_0.closeViewNames, ViewName.HeroGroupEditView)
	table.insert(arg_15_0.closeViewNames, ViewName.VersionActivity_1_2_HeroGroupEditView)
	table.insert(arg_15_0.closeViewNames, ViewName.PlayerClothView)
	table.insert(arg_15_0.closeViewNames, ViewName.DungeonMapLevelView)
	table.insert(arg_15_0.closeViewNames, ViewName.VersionActivityDungeonMapLevelView)
	table.insert(arg_15_0.closeViewNames, ViewName.GiftMultipleChoiceView)
	table.insert(arg_15_0.closeViewNames, ViewName.DungeonCumulativeRewardsView)
	table.insert(arg_15_0.closeViewNames, ViewName.DungeonCumulativeRewardPackView)
	table.insert(arg_15_0.closeViewNames, ViewName.WeekWalkLayerRewardView)
	table.insert(arg_15_0.closeViewNames, ViewName.WeekWalkRewardView)
	table.insert(arg_15_0.closeViewNames, ViewName.MaterialTipView)
	table.insert(arg_15_0.closeViewNames, ViewName.VersionActivity1_5RevivalTaskView)
	arg_15_0:_closeModelViews(arg_15_0.remainViewNames)
	arg_15_0:_closeViews(arg_15_0.closeViewNames, arg_15_0.remainViewNames)
	arg_15_0:removeOpenedView()
	arg_15_0:dispatchCallback()

	return var_15_4
end

function var_0_0._checkNeedSwitchScene(arg_17_0, arg_17_1)
	local var_17_0 = GameSceneMgr.instance:getCurSceneType()
	local var_17_1 = arg_17_0.jumpViewBelongScene[arg_17_1] or SceneType.Main

	if type(var_17_1) == "table" then
		return not tabletool.indexOf(var_17_1, var_17_0)
	end

	return var_17_0 ~= var_17_1
end

function var_0_0._getJumpViewDefaultScene(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.jumpViewBelongScene[arg_18_1] or SceneType.Main

	if type(var_18_0) == "table" then
		return var_18_0 and var_18_0[1] or SceneType.Main
	end

	return var_18_0
end

function var_0_0.removeOpenedView(arg_19_0)
	for iter_19_0 = #arg_19_0.waitOpenViewNames, 1, -1 do
		if ViewMgr.instance:isOpen(arg_19_0.waitOpenViewNames[iter_19_0]) then
			table.remove(arg_19_0.waitOpenViewNames, iter_19_0)
		end
	end
end

function var_0_0.cantJump(arg_20_0, arg_20_1)
	local var_20_0 = string.split(arg_20_1, "#")
	local var_20_1 = tonumber(var_20_0[1])
	local var_20_2, var_20_3, var_20_4 = (var_0_0.JumpViewToCanJumpFunc[var_20_1] or var_0_0.defaultCanJump)(arg_20_0, arg_20_1)

	if var_20_2 then
		return nil
	else
		return var_20_3, var_20_4
	end
end

function var_0_0.canJumpNew(arg_21_0, arg_21_1)
	local var_21_0 = string.split(arg_21_1, "#")
	local var_21_1 = tonumber(var_21_0[1])
	local var_21_2, var_21_3, var_21_4 = (var_0_0.JumpViewToCanJumpFunc[var_21_1] or var_0_0.defaultCanJump)(arg_21_0, arg_21_1)

	return var_21_2, var_21_3, var_21_4
end

function var_0_0._closeModelViews(arg_22_0, arg_22_1)
	local var_22_0 = {}

	arg_22_1 = arg_22_1 or {}

	table.insert(arg_22_1, ViewName.ActivityNormalView)
	table.insert(arg_22_1, ViewName.SignInView)
	table.insert(arg_22_1, ViewName.MaterialTipView)
	table.insert(arg_22_1, ViewName.ActivityBeginnerView)

	local var_22_1 = ViewMgr.instance:getOpenViewNameList()

	for iter_22_0, iter_22_1 in ipairs(var_22_1) do
		local var_22_2 = ViewMgr.instance:getSetting(iter_22_1)

		if (not arg_22_1 or not tabletool.indexOf(arg_22_1, iter_22_1)) and var_22_2.layer == UILayerName.PopUpTop and var_22_2.viewType == ViewType.Modal then
			local var_22_3 = gohelper.findChild(ViewMgr.instance:getTopUIRoot(), "POPUP_TOP")
			local var_22_4 = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUPBlur")
			local var_22_5 = ViewMgr.instance:getContainer(iter_22_1).viewGO

			if var_22_5 and (var_22_5.transform.parent == var_22_3.transform or var_22_5.transform.parent == var_22_4.transform) then
				table.insert(var_22_0, iter_22_1)
			end
		end
	end

	for iter_22_2 = 1, #var_22_0 do
		ViewMgr.instance:closeView(var_22_0[iter_22_2], true)
	end
end

function var_0_0._closeViews(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		if not tabletool.indexOf(arg_23_2, iter_23_1) then
			table.insert(var_23_0, iter_23_1)
		end
	end

	for iter_23_2, iter_23_3 in ipairs(var_23_0) do
		ViewMgr.instance:closeView(iter_23_3, true)
	end
end

function var_0_0.isJumpOpen(arg_24_0, arg_24_1)
	local var_24_0 = JumpConfig.instance:getJumpConfig(arg_24_1)

	if var_24_0 then
		local var_24_1 = var_24_0.openId

		if var_24_1 and var_24_1 ~= 0 then
			return OpenModel.instance:isFunctionUnlock(var_24_1)
		end

		return true
	end

	return false
end

function var_0_0.isOnlyShowJump(arg_25_0, arg_25_1)
	local var_25_0 = JumpConfig.instance:getJumpConfig(arg_25_1)

	if var_25_0 then
		local var_25_1 = var_25_0.param

		if string.nilorempty(var_25_1) then
			return true
		end

		local var_25_2 = string.split(var_25_1, "#")

		if tonumber(var_25_2[1]) == JumpEnum.JumpView.Show then
			return true
		end
	end

	return false
end

function var_0_0.getCurrentOpenedView(arg_26_0, arg_26_1)
	if not arg_26_0.ignoreViewName then
		arg_26_0.ignoreViewName = {
			[ViewName.RoomView] = true,
			[ViewName.ToastView] = true,
			[ViewName.MainView] = true,
			[ViewName.GMToolView] = true,
			[ViewName.DungeonView] = true,
			[ViewName.DungeonMapView] = true,
			[ViewName.DungeonMapLevelView] = true,
			[ViewName.DungeonMapLevelView] = true,
			[ViewName.HeroGroupFightView] = true,
			[ViewName.HeroGroupEditView] = true,
			[ViewName.VersionActivity_1_2_HeroGroupEditView] = true,
			[ViewName.MaterialTipView] = true,
			[SeasonViewHelper.getViewName(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.HeroGroupFightView)] = true,
			[Season123Controller.instance:getHeroGroupFightViewName()] = true,
			[Season123Controller.instance:getHeroGroupEditViewName()] = true,
			[ViewName.TowerHeroGroupFightView] = true
		}
	end

	local var_26_0 = {}
	local var_26_1
	local var_26_2

	for iter_26_0, iter_26_1 in ipairs(ViewMgr.instance:getOpenViewNameList()) do
		if iter_26_1 ~= arg_26_1 and not arg_26_0.ignoreViewName[iter_26_1] then
			local var_26_3 = {
				viewName = iter_26_1
			}
			local var_26_4 = ViewMgr.instance:getContainer(iter_26_1)

			var_26_3.viewParam = var_26_4.getCurrentViewParam and var_26_4:getCurrentViewParam() or var_26_4.viewParam

			table.insert(var_26_0, var_26_3)
		end
	end

	return var_26_0
end

function var_0_0.commonIconBeforeClickSetRecordItem(arg_27_0, arg_27_1, arg_27_2)
	arg_27_2:setRecordFarmItem({
		type = arg_27_2._itemType,
		id = arg_27_2._itemId,
		quantity = arg_27_2._itemQuantity,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = var_0_0.instance:getCurrentOpenedView()
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
