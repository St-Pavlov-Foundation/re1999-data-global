module("modules.logic.room.view.RoomViewContainer", package.seeall)

slot0 = class("RoomViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "navigatebuttonscontainer"))
	table.insert(slot1, RoomView.New())
	table.insert(slot1, RoomViewTouch.New())
	table.insert(slot1, RoomViewBlur.New())
	table.insert(slot1, RoomViewCameraState.New())

	if RoomController.instance:isEditMode() then
		table.insert(slot1, TabViewGroup.New(2, "blockop_tab"))
	end

	table.insert(slot1, TabViewGroup.New(3, "go_normalroot/go_confirm"))

	if RoomController.instance:isObMode() then
		table.insert(slot1, RoomViewNavigateBubble.New())
		table.insert(slot1, RoomViewSceneTask.New())
		table.insert(slot1, RoomViewTopRight.New("go_normalroot/go_topright", slot0._viewSetting.otherRes[3], {
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
		table.insert(slot1, RoomViewSceneTask.New())
		table.insert(slot1, RoomViewTopRight.New("go_normalroot/go_topright", slot0._viewSetting.otherRes[3], {
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
		table.insert(slot1, TabViewGroup.New(4, "go_normalroot/go_confirm"))
		table.insert(slot1, RoomViewTopRight.New("go_normalroot/go_topright", slot0._viewSetting.otherRes[3], {
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

	table.insert(slot1, RoomViewUI.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		if RoomController.instance:isObMode() then
			slot0._navigateButtonsView = NavigateButtonsView.New({
				true,
				false,
				true
			}, HelpEnum.HelpId.RoomOb)
		elseif RoomController.instance:isEditMode() then
			slot0._navigateButtonsView = NavigateButtonsView.New({
				true,
				false,
				false
			})
		elseif RoomController.instance:isVisitMode() then
			slot0._navigateButtonsView = NavigateButtonsView.New({
				true,
				true,
				true
			}, HelpEnum.HelpId.RoomOb)
		else
			slot0._navigateButtonsView = NavigateButtonsView.New({
				true,
				false,
				false
			})
		end

		slot0._navigateButtonsView:setOverrideClose(slot0._overrideCloseFunc, slot0)

		return {
			slot0._navigateButtonsView
		}
	elseif slot1 == 2 then
		return {
			RoomBackBlockView.New(),
			MultiView.New({
				RoomWaterReformView.New(),
				slot0:buildRoomWaterReformScrollViews()
			})
		}
	elseif slot1 == 3 then
		return {
			RoomViewConfirm.New()
		}
	elseif slot1 == 4 then
		return {
			RoomLayoutVisitPlan.New()
		}
	end
end

function slot0.buildRoomWaterReformScrollViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_bottom/#go_blockContent/scroll_block"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "#go_bottom/#go_blockContent/#go_item"
	slot1.cellClass = RoomWaterReformItem
	slot1.scrollDir = ScrollEnum.ScrollDirH
	slot1.lineCount = 1
	slot1.cellWidth = 170
	slot1.cellHeight = 231
	slot1.cellSpaceH = 0.5
	slot1.cellSpaceV = 0
	slot1.startSpace = 5

	return LuaListScrollView.New(RoomWaterReformListModel.instance, slot1)
end

function slot0.onContainerOpenFinish(slot0)
	slot0._navigateButtonsView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_CloseHouse)
	slot0._navigateButtonsView:resetHomeBtnAudioId(AudioEnum.UI.Play_UI_CloseHouse)

	if RoomController.instance:isEditMode() then
		slot1 = nil

		if ManufactureModel.instance:getIsJump2ManufactureBuildingList() then
			slot1 = RoomBuildingEnum.BuildingListViewResTabType.Produce
		end

		RoomTransportPathModel.instance:setIsJumpTransportSite()
		ManufactureModel.instance:setIsJump2ManufactureBuildingList()
		ViewMgr.instance:openView(ViewName.RoomInventorySelectView, {
			defaultBuildingResType = slot1,
			isJumpTransportSite = RoomTransportPathModel.instance:getisJumpTransportSite()
		})
	end

	if RoomController.instance:isObMode() or RoomController.instance:isVisitMode() then
		slot0._navigateButtonsView:setHelpId(HelpEnum.HelpId.RoomOb)
	end

	if RoomController.instance:isEditMode() then
		slot0._navigateButtonsView:setHelpId(HelpEnum.HelpId.RoomManufacture)
	end
end

function slot0._overrideCloseFunc(slot0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)

		return
	end

	if GameSceneMgr.instance:getCurScene().camera:isTweening() then
		return
	end

	if RoomCharacterController.instance:isCharacterListShow() then
		RoomCharacterController.instance:setCharacterListShow(false)

		return
	end

	if slot0:shouldShowUI() then
		return
	end

	if slot1.camera:getCameraState() ~= RoomEnum.CameraState.Overlook then
		slot1.camera:switchCameraState(RoomEnum.CameraState.Overlook, {})

		return
	end

	RoomController.instance:exitRoom()
end

function slot0._overrideHelpFunc(slot0)
	ViewMgr.instance:openView(ViewName.HelpPageTabView)
end

function slot0._onEscape(slot0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)
	else
		if slot0:shouldShowUI() then
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

function slot0.shouldShowUI(slot0)
	if RoomMapController.instance:isUIHide() then
		RoomMapController.instance:setUIHide(false)

		return true
	end

	return false
end

function slot0.setNavigateButtonShow(slot0, slot1)
	if slot1 then
		NavigateMgr.instance:removeEscape(ViewName.RoomView)

		if RoomController.instance:isObMode() then
			slot0._navigateButtonsView:setParam({
				true,
				true,
				true
			}, HelpEnum.HelpId.RoomOb)
		elseif RoomController.instance:isEditMode() then
			slot0._navigateButtonsView:setParam({
				true,
				true,
				true
			}, HelpEnum.HelpId.RoomManufacture)
		elseif RoomController.instance:isVisitMode() then
			slot0._navigateButtonsView:setParam({
				true,
				true,
				true
			}, HelpEnum.HelpId.RoomOb)
		else
			slot0._navigateButtonsView:setParam({
				true,
				false,
				false
			})
		end
	else
		NavigateMgr.instance:addEscape(ViewName.RoomView, slot0._onEscape, slot0)
		slot0._navigateButtonsView:setParam({
			false,
			false,
			false
		})
	end
end

function slot0.selectBlockOpTab(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot1)
end

return slot0
