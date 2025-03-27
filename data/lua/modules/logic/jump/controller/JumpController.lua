module("modules.logic.jump.controller.JumpController", package.seeall)

slot0 = class("JumpController", BaseController)

function slot0.onInit(slot0)
	JumpControllerCanJumpFunc.activateCanJumpFuncController()
	JumpControllerHandleFunc.activateHandleFuncController()

	slot0.isInitLogicDefine = false
end

function slot0.onInitFinish(slot0)
end

function slot0.clear(slot0)
	slot0.waitOpenViewNames = nil
	slot0.remainViewNames = nil
	slot0.closeViewNames = nil
	slot0._callback = nil
	slot0._callbackObj = nil
	slot0.jumpStage = JumpEnum.JumpStage.None
end

function slot0.addConstEvents(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, slot0._onOpenView, slot0)
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.initLogicDefine(slot0)
	if slot0.isInitLogicDefine then
		return
	end

	slot0:initJumpViewBelongScene()

	slot0.isInitLogicDefine = true
end

function slot0.initJumpViewBelongScene(slot0)
	slot0.jumpViewBelongScene = {
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

function slot0._onOpenView(slot0, slot1)
	if slot0.jumpStage ~= JumpEnum.JumpStage.Jumping then
		return
	end

	if not slot0.canDispatchCallback then
		return
	end

	if slot0.waitOpenViewNames and tabletool.indexOf(slot0.waitOpenViewNames, slot1) then
		tabletool.removeValue(slot0.waitOpenViewNames, slot1)
	end

	slot0:dispatchCallback()
end

function slot0.checkJumpDone(slot0)
	return not slot0.waitOpenViewNames or not next(slot0.waitOpenViewNames)
end

function slot0.dispatchCallback(slot0)
	if not slot0:checkJumpDone() then
		return
	end

	if slot0._callback then
		slot0._callback(slot0._callbackObj)
	end

	slot0:reInit()
end

function slot0.jump(slot0, slot1, slot2, slot3, slot4)
	if not LoginController.instance:isEnteredGame() then
		return false
	end

	if JumpConfig.instance:getJumpConfig(tonumber(slot1)) then
		if not slot0:isJumpOpen(slot1) then
			slot6, slot7 = OpenHelper.getToastIdAndParam(slot5.openId)

			if slot6 then
				GameFacade.showToastWithTableParam(slot6, slot7)
			end

			return false
		else
			slot6, slot7, slot8 = slot0:canJumpNew(slot5.param)

			if not slot6 then
				GameFacade.showToastWithTableParam(slot7, slot8)

				return false
			end
		end

		return slot0:jumpTo(slot5.param, slot2, slot3, slot4) == JumpEnum.JumpResult.Success
	end

	return false
end

function slot0.jumpByAdditionParam(slot0, slot1, slot2, slot3, slot4)
	slot5 = string.split(slot1, "#")
	slot6 = tonumber(slot5[1])

	for slot11 = 2, #slot5 do
		slot7 = string.format("%s#%s", "", slot5[slot11])
	end

	if JumpConfig.instance:getJumpConfig(slot6) then
		if not slot0:isJumpOpen(slot6) then
			slot9, slot10 = OpenHelper.getToastIdAndParam(slot8.openId)

			if slot9 then
				GameFacade.showToastWithTableParam(slot9, slot10)
			end

			return false
		else
			slot9, slot10, slot11 = slot0:canJumpNew(slot8.param)

			if not slot9 then
				GameFacade.showToastWithTableParam(slot10, slot11)

				return false
			end
		end

		return slot0:jumpTo(string.format("%s%s", slot8.param, slot7), slot2, slot3, slot4) == JumpEnum.JumpResult.Success
	end

	return false
end

function slot0.jumpByParamWithCondition(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6, slot7 = slot0:canJumpNew(slot1)

	if not slot5 then
		GameFacade.showToastWithTableParam(slot6, slot7)

		return false
	end

	return slot0:jumpTo(slot1, slot2, slot3, slot4) == JumpEnum.JumpResult.Success
end

function slot0.jumpByParam(slot0, slot1)
	slot0:jumpTo(slot1)
end

slot1 = {
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
	"V2a4_Role_PanelSignView_Part2"
}

function slot0.jumpTo(slot0, slot1, slot2, slot3, slot4)
	slot0:dispatchEvent(JumpEvent.BeforeJump, slot1)
	slot0:initLogicDefine()

	if string.nilorempty(slot1) then
		logError("跳转参数为空")

		return JumpEnum.JumpResult.Fail
	end

	slot0.jumpStage = JumpEnum.JumpStage.Jumping
	slot6 = string.splitToNumber(slot1, "#")[1]

	if ViewMgr.instance:isOpen(ViewName.CommonPropView) or ViewMgr.instance:isOpen(ViewName.BpPropView) or ViewMgr.instance:isOpen(ViewName.BpPropView2) or ViewMgr.instance:isOpen(ViewName.FightSuccView) then
		GameFacade.showToast(ToastEnum.MaterialTipJump)

		return false
	end

	if VirtualSummonScene.instance:isOpen() and slot6 ~= JumpEnum.JumpView.StoreView then
		GameFacade.showToast(ToastEnum.MaterialTipJump)

		return false
	end

	for slot10, slot11 in ipairs(uv0) do
		if ViewMgr.instance:isOpen(ViewName[slot11]) then
			GameFacade.showToast(ToastEnum.MaterialTipJump)

			return false
		end
	end

	if slot0:_checkNeedSwitchScene(slot6) then
		DungeonModel.instance.curSendEpisodeId = nil

		ViewMgr.instance:closeAllPopupViews()

		if slot0:_getJumpViewDefaultScene(slot6) == SceneType.Main then
			MainController.instance:enterMainScene(true)
		elseif slot7 == SceneType.Room then
			RoomController.instance:enterRoom(RoomEnum.GameMode.Ob, nil, , , , true)
		elseif slot7 == SceneType.PushBox then
			PushBoxController.instance:enterPushBoxGame()
		else
			slot7 = SceneType.Main

			MainController.instance:enterMainScene()
		end

		ViewMgr.instance:closeAllPopupViews()
		SceneHelper.instance:waitSceneDone(slot7, function ()
			uv0:jumpTo(uv1, uv2, uv3, uv4)
		end)

		return JumpEnum.JumpResult.Success
	end

	JumpModel.instance:setRecordFarmItem(slot4)

	slot0._callback = slot2
	slot0._callbackObj = slot3
	slot0.waitOpenViewNames = {}
	slot0.remainViewNames = {}
	slot0.closeViewNames = {}

	if not uv1.JumpViewToHandleFunc[slot6] then
		logError("跳转参数错误: " .. slot1)
		slot0:reInit()

		return JumpEnum.JumpResult.Fail
	end

	slot0.canDispatchCallback = false
	slot0.canDispatchCallback = true

	if slot7(slot0, slot1) ~= JumpEnum.JumpResult.Success then
		slot0:reInit()

		return slot8
	end

	table.insert(slot0.closeViewNames, ViewName.NormalStoreGoodsView)
	table.insert(slot0.closeViewNames, ViewName.ChargeStoreGoodsView)
	table.insert(slot0.closeViewNames, ViewName.HeroGroupEditView)
	table.insert(slot0.closeViewNames, ViewName.VersionActivity_1_2_HeroGroupEditView)
	table.insert(slot0.closeViewNames, ViewName.PlayerClothView)
	table.insert(slot0.closeViewNames, ViewName.DungeonMapLevelView)
	table.insert(slot0.closeViewNames, ViewName.VersionActivityDungeonMapLevelView)
	table.insert(slot0.closeViewNames, ViewName.GiftMultipleChoiceView)
	table.insert(slot0.closeViewNames, ViewName.DungeonCumulativeRewardsView)
	table.insert(slot0.closeViewNames, ViewName.DungeonCumulativeRewardPackView)
	table.insert(slot0.closeViewNames, ViewName.WeekWalkLayerRewardView)
	table.insert(slot0.closeViewNames, ViewName.WeekWalkRewardView)
	table.insert(slot0.closeViewNames, ViewName.MaterialTipView)
	table.insert(slot0.closeViewNames, ViewName.VersionActivity1_5RevivalTaskView)
	slot0:_closeModelViews(slot0.remainViewNames)
	slot0:_closeViews(slot0.closeViewNames, slot0.remainViewNames)
	slot0:removeOpenedView()
	slot0:dispatchCallback()

	return slot8
end

function slot0._checkNeedSwitchScene(slot0, slot1)
	slot2 = GameSceneMgr.instance:getCurSceneType()

	if type(slot0.jumpViewBelongScene[slot1] or SceneType.Main) == "table" then
		return not tabletool.indexOf(slot3, slot2)
	end

	return slot2 ~= slot3
end

function slot0._getJumpViewDefaultScene(slot0, slot1)
	if type(slot0.jumpViewBelongScene[slot1] or SceneType.Main) == "table" then
		return slot2 and slot2[1] or SceneType.Main
	end

	return slot2
end

function slot0.removeOpenedView(slot0)
	for slot4 = #slot0.waitOpenViewNames, 1, -1 do
		if ViewMgr.instance:isOpen(slot0.waitOpenViewNames[slot4]) then
			table.remove(slot0.waitOpenViewNames, slot4)
		end
	end
end

function slot0.cantJump(slot0, slot1)
	slot5, slot6, slot7 = uv0.JumpViewToCanJumpFunc[tonumber(string.split(slot1, "#")[1])] or uv0.defaultCanJump(slot0, slot1)

	if slot5 then
		return nil
	else
		return slot6, slot7
	end
end

function slot0.canJumpNew(slot0, slot1)
	slot5, slot6, slot7 = uv0.JumpViewToCanJumpFunc[tonumber(string.split(slot1, "#")[1])] or uv0.defaultCanJump(slot0, slot1)

	return slot5, slot6, slot7
end

function slot0._closeModelViews(slot0, slot1)
	slot2 = {}
	slot1 = slot1 or {}

	table.insert(slot1, ViewName.ActivityNormalView)
	table.insert(slot1, ViewName.SignInView)
	table.insert(slot1, ViewName.MaterialTipView)
	table.insert(slot1, ViewName.ActivityBeginnerView)

	for slot7, slot8 in ipairs(ViewMgr.instance:getOpenViewNameList()) do
		slot9 = ViewMgr.instance:getSetting(slot8)

		if (not slot1 or not tabletool.indexOf(slot1, slot8)) and slot9.layer == UILayerName.PopUpTop and slot9.viewType == ViewType.Modal then
			if ViewMgr.instance:getContainer(slot8).viewGO and (slot12.transform.parent == gohelper.findChild(ViewMgr.instance:getTopUIRoot(), "POPUP_TOP").transform or slot12.transform.parent == gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUPBlur").transform) then
				table.insert(slot2, slot8)
			end
		end
	end

	for slot7 = 1, #slot2 do
		ViewMgr.instance:closeView(slot2[slot7], true)
	end
end

function slot0._closeViews(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		if not tabletool.indexOf(slot2, slot8) then
			table.insert(slot3, slot8)
		end
	end

	for slot7, slot8 in ipairs(slot3) do
		ViewMgr.instance:closeView(slot8, true)
	end
end

function slot0.isJumpOpen(slot0, slot1)
	if JumpConfig.instance:getJumpConfig(slot1) then
		if slot2.openId and slot3 ~= 0 then
			return OpenModel.instance:isFunctionUnlock(slot3)
		end

		return true
	end

	return false
end

function slot0.isOnlyShowJump(slot0, slot1)
	if JumpConfig.instance:getJumpConfig(slot1) then
		if string.nilorempty(slot2.param) then
			return true
		end

		if tonumber(string.split(slot3, "#")[1]) == JumpEnum.JumpView.Show then
			return true
		end
	end

	return false
end

function slot0.getCurrentOpenedView(slot0, slot1)
	if not slot0.ignoreViewName then
		slot0.ignoreViewName = {
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

	slot2 = {}
	slot3, slot4 = nil

	for slot8, slot9 in ipairs(ViewMgr.instance:getOpenViewNameList()) do
		if slot9 ~= slot1 and not slot0.ignoreViewName[slot9] then
			table.insert(slot2, {
				viewName = slot9,
				viewParam = ViewMgr.instance:getContainer(slot9).getCurrentViewParam and slot4:getCurrentViewParam() or slot4.viewParam
			})
		end
	end

	return slot2
end

function slot0.commonIconBeforeClickSetRecordItem(slot0, slot1, slot2)
	slot2:setRecordFarmItem({
		type = slot2._itemType,
		id = slot2._itemId,
		quantity = slot2._itemQuantity,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = uv0.instance:getCurrentOpenedView()
	})
end

slot0.instance = slot0.New()

return slot0
