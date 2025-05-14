module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapHeroIconView", package.seeall)

local var_0_0 = class("VersionActivity1_5DungeonMapHeroIconView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomapdirection = gohelper.findChild(arg_1_0.viewGO, "#go_mapdirection")
	arg_1_0._goherorightitem = gohelper.findChild(arg_1_0.viewGO, "#go_mapdirection/#go_rightitem")
	arg_1_0._goheroleftitem = gohelper.findChild(arg_1_0.viewGO, "#go_mapdirection/#go_leftitem")
	arg_1_0._goherotopitem = gohelper.findChild(arg_1_0.viewGO, "#go_mapdirection/#go_topitem")
	arg_1_0._goherobottomitem = gohelper.findChild(arg_1_0.viewGO, "#go_mapdirection/#go_bottomitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.heroItemDict = {}
	arg_4_0.dirToFocusElementDict = {
		[VersionActivity1_5DungeonEnum.MapDir.Right] = {},
		[VersionActivity1_5DungeonEnum.MapDir.Left] = {},
		[VersionActivity1_5DungeonEnum.MapDir.Top] = {},
		[VersionActivity1_5DungeonEnum.MapDir.Bottom] = {}
	}
	arg_4_0.focusElementDataPool = {}

	arg_4_0:createHeroItem(arg_4_0._goherorightitem, VersionActivity1_5DungeonEnum.MapDir.Right)
	arg_4_0:createHeroItem(arg_4_0._goheroleftitem, VersionActivity1_5DungeonEnum.MapDir.Left)
	arg_4_0:createHeroItem(arg_4_0._goherotopitem, VersionActivity1_5DungeonEnum.MapDir.Top)
	arg_4_0:createHeroItem(arg_4_0._goherobottomitem, VersionActivity1_5DungeonEnum.MapDir.Bottom)

	arg_4_0.taskMoList = {}

	for iter_4_0, iter_4_1 in ipairs(VersionActivity1_5RevivalTaskModel.instance:getTaskMoList() or {}) do
		if not iter_4_1:isExploreTask() then
			table.insert(arg_4_0.taskMoList, iter_4_1)
		end
	end

	arg_4_0.mapSceneElementsView = arg_4_0.viewContainer.mapSceneElements
	arg_4_0.mainCamera = CameraMgr.instance:getMainCamera()
	arg_4_0._tempVector = Vector3()
	arg_4_0.loadedElements = false
	arg_4_0.canShowHeroIcon = true

	arg_4_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnHideInteractUI, arg_4_0.onHideInteractUI, arg_4_0)
	arg_4_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnClickElement, arg_4_0.onClickElement, arg_4_0)
	arg_4_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnMapPosChanged, arg_4_0.onMapPosChanged, arg_4_0)
	arg_4_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnRemoveElement, arg_4_0.onRemoveElement, arg_4_0)
	arg_4_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnInitElements, arg_4_0.onInitElements, arg_4_0, LuaEventSystem.Low)
	arg_4_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, arg_4_0.onDisposeOldMap, arg_4_0)
	arg_4_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, arg_4_0.onDisposeScene, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_4_0.onOpenView, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_4_0.onCloseView, arg_4_0)
end

function var_0_0.onClickElement(arg_5_0)
	arg_5_0:hideMapDir()
end

function var_0_0.onHideInteractUI(arg_6_0)
	arg_6_0:showMapDir()
end

function var_0_0.onOpenView(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.VersionActivity1_5DungeonMapLevelView then
		arg_7_0:hideMapDir()
	end
end

function var_0_0.onCloseView(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.VersionActivity1_5DungeonMapLevelView then
		arg_8_0:showMapDir()
	end
end

function var_0_0.onDisposeOldMap(arg_9_0)
	arg_9_0.loadedElements = false

	arg_9_0:hideMapHeroIcon()
end

function var_0_0.onDisposeScene(arg_10_0)
	arg_10_0.loadedElements = false

	arg_10_0:hideMapHeroIcon()
end

function var_0_0.hideMapDir(arg_11_0)
	arg_11_0.canShowHeroIcon = false

	gohelper.setActive(arg_11_0._gomapdirection, arg_11_0.canShowHeroIcon)
end

function var_0_0.showMapDir(arg_12_0)
	arg_12_0.canShowHeroIcon = true

	gohelper.setActive(arg_12_0._gomapdirection, arg_12_0.canShowHeroIcon)
	arg_12_0:refreshHeroIcon()
end

function var_0_0.hideMapHeroIcon(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.heroItemDict) do
		gohelper.setActive(iter_13_1.go, false)
	end
end

function var_0_0.onInitElements(arg_14_0)
	if arg_14_0.activityDungeonMo:isHardMode() then
		arg_14_0:hideMapHeroIcon()

		return
	end

	arg_14_0.loadedElements = true

	arg_14_0:refreshHeroIcon()
end

function var_0_0.createHeroItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:getUserDataTb_()

	var_15_0.go = arg_15_1

	gohelper.setActive(var_15_0.go, false)

	var_15_0.goHeroIcon1 = gohelper.findChild(var_15_0.go, "heroicon_container/heroicon1")
	var_15_0.goHeroIcon2 = gohelper.findChild(var_15_0.go, "heroicon_container/heroicon2")
	var_15_0.heroHeadImage1 = gohelper.findChildSingleImage(var_15_0.go, "heroicon_container/heroicon1/#simage_herohead")
	var_15_0.heroHeadImage2 = gohelper.findChildSingleImage(var_15_0.go, "heroicon_container/heroicon2/#simage_herohead")
	var_15_0.click1 = gohelper.getClickWithDefaultAudio(var_15_0.heroHeadImage1.gameObject)
	var_15_0.click2 = gohelper.getClickWithDefaultAudio(var_15_0.heroHeadImage2.gameObject)

	var_15_0.click1:AddClickListener(arg_15_0.onClickHeroHeadIcon, arg_15_0, {
		index = 1,
		dir = arg_15_2
	})
	var_15_0.click2:AddClickListener(arg_15_0.onClickHeroHeadIcon, arg_15_0, {
		index = 2,
		dir = arg_15_2
	})

	arg_15_0.heroItemDict[arg_15_2] = var_15_0

	return var_15_0
end

function var_0_0.onClickHeroHeadIcon(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.dirToFocusElementDict[arg_16_1.dir][arg_16_1.index].focusElementId

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.FocusElement, var_16_0)
end

function var_0_0.getElementData(arg_17_0)
	if #arg_17_0.focusElementDataPool > 0 then
		return table.remove(arg_17_0.focusElementDataPool)
	end

	return {}
end

function var_0_0.onMapPosChanged(arg_18_0)
	arg_18_0:refreshHeroIcon()
end

function var_0_0.onRemoveElement(arg_19_0)
	arg_19_0:refreshHeroIcon()
end

function var_0_0.refreshHeroIcon(arg_20_0)
	if not arg_20_0.loadedElements then
		return
	end

	if not arg_20_0.canShowHeroIcon then
		return
	end

	if arg_20_0.activityDungeonMo:isHardMode() then
		return
	end

	for iter_20_0, iter_20_1 in pairs(arg_20_0.dirToFocusElementDict) do
		for iter_20_2 = 1, #iter_20_1 do
			table.insert(arg_20_0.focusElementDataPool, table.remove(iter_20_1))
		end
	end

	for iter_20_3, iter_20_4 in ipairs(arg_20_0.taskMoList) do
		local var_20_0, var_20_1 = arg_20_0:getTaskMoFirstNotFinishElement(iter_20_4)

		if var_20_0 then
			local var_20_2 = arg_20_0:getElementData()

			var_20_2.focusElementId = var_20_0
			var_20_2.heroId = iter_20_4.config.heroId

			table.insert(arg_20_0.dirToFocusElementDict[arg_20_0:getDir(var_20_1.x, var_20_1.y)], var_20_2)
		end
	end

	for iter_20_5, iter_20_6 in pairs(arg_20_0.dirToFocusElementDict) do
		local var_20_3 = #iter_20_6 > 0

		gohelper.setActive(arg_20_0.heroItemDict[iter_20_5].go, var_20_3)

		if var_20_3 then
			gohelper.setActive(arg_20_0.heroItemDict[iter_20_5].goHeroIcon1, false)
			gohelper.setActive(arg_20_0.heroItemDict[iter_20_5].goHeroIcon2, false)

			for iter_20_7, iter_20_8 in ipairs(iter_20_6) do
				arg_20_0:refreshHeroItemPos(iter_20_5, iter_20_7, iter_20_8)
			end
		end
	end
end

function var_0_0.getTaskMoFirstNotFinishElement(arg_21_0, arg_21_1)
	if not arg_21_1:isUnlock() then
		return
	end

	if arg_21_1.gainedReward then
		return
	end

	local var_21_0 = arg_21_1:getSubTaskCoList()

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if VersionActivity1_5RevivalTaskModel.instance:getSubHeroTaskStatus(iter_21_1) == VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Normal then
			for iter_21_2, iter_21_3 in ipairs(iter_21_1.elementList) do
				if not DungeonMapModel.instance:elementIsFinished(iter_21_3) then
					local var_21_1 = arg_21_0.mapSceneElementsView:getElementComp(iter_21_3)

					if var_21_1 then
						local var_21_2, var_21_3, var_21_4 = transformhelper.getPos(var_21_1:getTransform())

						arg_21_0._tempVector:Set(var_21_2, var_21_3, var_21_4)

						local var_21_5 = arg_21_0.mainCamera:WorldToViewportPoint(arg_21_0._tempVector)
						local var_21_6, var_21_7 = var_21_5.x, var_21_5.y

						if var_21_6 < 0 or var_21_6 > 1 or var_21_7 < 0 or var_21_7 > 1 then
							return iter_21_3, var_21_5
						end
					end
				end
			end
		end
	end
end

function var_0_0.refreshHeroItemPos(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_2 > 2 then
		return
	end

	local var_22_0 = arg_22_0.heroItemDict[arg_22_1]

	gohelper.setActive(var_22_0.go, true)

	local var_22_1 = arg_22_2 == 1 and var_22_0.heroHeadImage1 or var_22_0.heroHeadImage2
	local var_22_2 = arg_22_2 == 1 and var_22_0.goHeroIcon1 or var_22_0.goHeroIcon2

	gohelper.setActive(var_22_2, true)
	var_22_1:LoadImage(ResUrl.getHeadIconSmall(arg_22_3.heroId .. "01"))
end

function var_0_0.getDir(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 < 0 then
		return VersionActivity1_5DungeonEnum.MapDir.Left
	elseif arg_23_1 >= 0 and arg_23_1 <= 1 then
		if arg_23_2 < 0 then
			return VersionActivity1_5DungeonEnum.MapDir.Bottom
		else
			return VersionActivity1_5DungeonEnum.MapDir.Top
		end
	else
		return VersionActivity1_5DungeonEnum.MapDir.Right
	end
end

function var_0_0.onDestroyView(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.heroItemDict) do
		iter_24_1.click1:RemoveClickListener()
		iter_24_1.click2:RemoveClickListener()
		iter_24_1.heroHeadImage1:UnLoadImage()
		iter_24_1.heroHeadImage2:UnLoadImage()
	end
end

return var_0_0
