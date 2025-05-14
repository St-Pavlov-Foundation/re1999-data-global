module("modules.logic.room.view.RoomViewContainer", package.seeall)

local var_0_0 = class("RoomViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "navigatebuttonscontainer"))
	table.insert(var_1_0, RoomView.New())
	table.insert(var_1_0, RoomViewTouch.New())
	table.insert(var_1_0, RoomViewBlur.New())
	table.insert(var_1_0, RoomViewCameraState.New())

	if RoomController.instance:isEditMode() then
		table.insert(var_1_0, TabViewGroup.New(2, "blockop_tab"))
	end

	table.insert(var_1_0, TabViewGroup.New(3, "go_normalroot/go_confirm"))

	if RoomController.instance:isObMode() then
		table.insert(var_1_0, RoomViewNavigateBubble.New())
		table.insert(var_1_0, RoomViewSceneTask.New())
		table.insert(var_1_0, RoomViewTopRight.New("go_normalroot/go_topright", arg_1_0._viewSetting.otherRes[3], {
			{
				type = 2,
				id = 5,
				onlyShowEvent = true,
				classDefine = RoomViewTopRightMaterialItem,
				listeningItems = {
					{
						id = 5,
						type = 2
					},
					{
						id = 3,
						type = 2
					}
				}
			},
			{
				type = 2,
				id = 3,
				onlyShowEvent = true,
				classDefine = RoomViewTopRightMaterialItem,
				listeningItems = {
					{
						id = 5,
						type = 2
					},
					{
						id = 3,
						type = 2
					}
				}
			},
			{
				classDefine = RoomViewTopRightMaterialItem,
				type = MaterialEnum.MaterialType.Currency,
				id = CurrencyEnum.CurrencyType.RoomTrade,
				listeningItems = {
					{
						type = MaterialEnum.MaterialType.Currency,
						id = CurrencyEnum.CurrencyType.RoomTrade
					}
				}
			},
			{
				classDefine = RoomViewTopRightCharacterItem
			},
			{
				classDefine = RoomViewTopRightBuildItem
			}
		}))
	elseif RoomController.instance:isEditMode() then
		table.insert(var_1_0, RoomViewSceneTask.New())
		table.insert(var_1_0, RoomViewTopRight.New("go_normalroot/go_topright", arg_1_0._viewSetting.otherRes[3], {
			{
				classDefine = RoomViewTopRightMaterialItem,
				type = MaterialEnum.MaterialType.Currency,
				id = CurrencyEnum.CurrencyType.RoomTrade,
				listeningItems = {
					{
						type = MaterialEnum.MaterialType.Currency,
						id = CurrencyEnum.CurrencyType.RoomTrade
					}
				}
			},
			{
				classDefine = RoomViewTopRightBuildItem
			},
			{
				bgType = 2,
				classDefine = RoomViewTopRightBlockItem
			}
		}))
	elseif RoomController.instance:isVisitMode() then
		table.insert(var_1_0, TabViewGroup.New(4, "go_normalroot/go_confirm"))
		table.insert(var_1_0, RoomViewTopRight.New("go_normalroot/go_topright", arg_1_0._viewSetting.otherRes[3], {
			{
				ismap = true,
				bgType = 2,
				classDefine = RoomViewTopRightLayoutShareItem
			},
			{
				classDefine = RoomViewTopRightBuildItem
			},
			{
				bgType = 2,
				classDefine = RoomViewTopRightBlockItem
			}
		}))
	end

	table.insert(var_1_0, RoomViewUI.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		if RoomController.instance:isObMode() then
			arg_2_0._navigateButtonsView = NavigateButtonsView.New({
				true,
				false,
				true
			}, HelpEnum.HelpId.RoomOb)
		elseif RoomController.instance:isEditMode() then
			arg_2_0._navigateButtonsView = NavigateButtonsView.New({
				true,
				false,
				false
			})
		elseif RoomController.instance:isVisitMode() then
			arg_2_0._navigateButtonsView = NavigateButtonsView.New({
				true,
				true,
				true
			}, HelpEnum.HelpId.RoomOb)
		else
			arg_2_0._navigateButtonsView = NavigateButtonsView.New({
				true,
				false,
				false
			})
		end

		arg_2_0._navigateButtonsView:setOverrideClose(arg_2_0._overrideCloseFunc, arg_2_0)

		return {
			arg_2_0._navigateButtonsView
		}
	elseif arg_2_1 == 2 then
		local var_2_0 = arg_2_0:buildRoomWaterReformScrollViews()
		local var_2_1 = MultiView.New({
			RoomWaterReformView.New(),
			var_2_0
		})

		return {
			RoomBackBlockView.New(),
			var_2_1
		}
	elseif arg_2_1 == 3 then
		return {
			RoomViewConfirm.New()
		}
	elseif arg_2_1 == 4 then
		return {
			RoomLayoutVisitPlan.New()
		}
	end
end

function var_0_0.buildRoomWaterReformScrollViews(arg_3_0)
	local var_3_0 = ListScrollParam.New()

	var_3_0.scrollGOPath = "#go_bottom/#go_blockContent/scroll_block"
	var_3_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_3_0.prefabUrl = "#go_bottom/#go_blockContent/#go_item"
	var_3_0.cellClass = RoomWaterReformItem
	var_3_0.scrollDir = ScrollEnum.ScrollDirH
	var_3_0.lineCount = 1
	var_3_0.cellWidth = 170
	var_3_0.cellHeight = 231
	var_3_0.cellSpaceH = 0.5
	var_3_0.cellSpaceV = 0
	var_3_0.startSpace = 5

	return (LuaListScrollView.New(RoomWaterReformListModel.instance, var_3_0))
end

function var_0_0.onContainerOpenFinish(arg_4_0)
	arg_4_0._navigateButtonsView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_CloseHouse)
	arg_4_0._navigateButtonsView:resetHomeBtnAudioId(AudioEnum.UI.Play_UI_CloseHouse)

	if RoomController.instance:isEditMode() then
		local var_4_0

		if ManufactureModel.instance:getIsJump2ManufactureBuildingList() then
			var_4_0 = RoomBuildingEnum.BuildingListViewResTabType.Produce
		end

		local var_4_1 = RoomTransportPathModel.instance:getisJumpTransportSite()

		RoomTransportPathModel.instance:setIsJumpTransportSite()
		ManufactureModel.instance:setIsJump2ManufactureBuildingList()
		ViewMgr.instance:openView(ViewName.RoomInventorySelectView, {
			defaultBuildingResType = var_4_0,
			isJumpTransportSite = var_4_1
		})
	end

	if RoomController.instance:isObMode() or RoomController.instance:isVisitMode() then
		arg_4_0._navigateButtonsView:setHelpId(HelpEnum.HelpId.RoomOb)
	end

	if RoomController.instance:isEditMode() then
		arg_4_0._navigateButtonsView:setHelpId(HelpEnum.HelpId.RoomManufacture)
	end
end

function var_0_0._overrideCloseFunc(arg_5_0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)

		return
	end

	local var_5_0 = GameSceneMgr.instance:getCurScene()

	if var_5_0.camera:isTweening() then
		return
	end

	if RoomCharacterController.instance:isCharacterListShow() then
		RoomCharacterController.instance:setCharacterListShow(false)

		return
	end

	if arg_5_0:shouldShowUI() then
		return
	end

	if var_5_0.camera:getCameraState() ~= RoomEnum.CameraState.Overlook then
		var_5_0.camera:switchCameraState(RoomEnum.CameraState.Overlook, {})

		return
	end

	RoomController.instance:exitRoom()
end

function var_0_0._overrideHelpFunc(arg_6_0)
	ViewMgr.instance:openView(ViewName.HelpPageTabView)
end

function var_0_0._onEscape(arg_7_0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)
	else
		if arg_7_0:shouldShowUI() then
			return
		end

		if RoomBuildingController.instance:isBuildingListShow() then
			RoomBuildingController.instance:setBuildingListShow(false)
		elseif RoomDebugController.instance:isDebugPlaceListShow() then
			RoomDebugController.instance:setDebugPlaceListShow(false)
		elseif RoomDebugController.instance:isDebugPackageListShow() then
			RoomDebugController.instance:setDebugPackageListShow(false)
		elseif RoomDebugController.instance:isDebugBuildingListShow() then
			RoomDebugController.instance:setDebugBuildingListShow(false)
		elseif RoomCharacterController.instance:isCharacterListShow() then
			RoomCharacterController.instance:setCharacterListShow(false)
		end
	end
end

function var_0_0.shouldShowUI(arg_8_0)
	if RoomMapController.instance:isUIHide() then
		RoomMapController.instance:setUIHide(false)

		return true
	end

	return false
end

function var_0_0.setNavigateButtonShow(arg_9_0, arg_9_1)
	if arg_9_1 then
		NavigateMgr.instance:removeEscape(ViewName.RoomView)

		if RoomController.instance:isObMode() then
			arg_9_0._navigateButtonsView:setParam({
				true,
				true,
				true
			}, HelpEnum.HelpId.RoomOb)
		elseif RoomController.instance:isEditMode() then
			arg_9_0._navigateButtonsView:setParam({
				true,
				true,
				true
			}, HelpEnum.HelpId.RoomManufacture)
		elseif RoomController.instance:isVisitMode() then
			arg_9_0._navigateButtonsView:setParam({
				true,
				true,
				true
			}, HelpEnum.HelpId.RoomOb)
		else
			arg_9_0._navigateButtonsView:setParam({
				true,
				false,
				false
			})
		end
	else
		NavigateMgr.instance:addEscape(ViewName.RoomView, arg_9_0._onEscape, arg_9_0)
		arg_9_0._navigateButtonsView:setParam({
			false,
			false,
			false
		})
	end
end

function var_0_0.selectBlockOpTab(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return
	end

	arg_10_0:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_10_1)
end

return var_0_0
