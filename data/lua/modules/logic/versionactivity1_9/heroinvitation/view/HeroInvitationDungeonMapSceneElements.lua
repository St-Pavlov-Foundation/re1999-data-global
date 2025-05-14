module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationDungeonMapSceneElements", package.seeall)

local var_0_0 = class("HeroInvitationDungeonMapSceneElements", DungeonMapSceneElements)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0.goItem = gohelper.findChild(arg_1_0.viewGO, "#go_arrow/#go_item")
	arg_1_0.allFinish = HeroInvitationModel.instance:isAllFinish()
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0:addEventCb(HeroInvitationController.instance, HeroInvitationEvent.StateChange, arg_2_0.updateState, arg_2_0)
	arg_2_0:addEventCb(HeroInvitationController.instance, HeroInvitationEvent.UpdateInfo, arg_2_0.updateHeroInvitation, arg_2_0)
end

function var_0_0.updateState(arg_3_0)
	if arg_3_0._mapCfg then
		arg_3_0:_showElements(arg_3_0._mapCfg.id)
	end
end

function var_0_0.updateHeroInvitation(arg_4_0)
	if HeroInvitationModel.instance:isAllFinish() == arg_4_0.allFinish then
		return
	end

	if arg_4_0._mapCfg then
		arg_4_0:_showElements(arg_4_0._mapCfg.id)
	end
end

function var_0_0._addElement(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.id
	local var_5_1 = arg_5_0._elementList[var_5_0]
	local var_5_2 = false

	if not var_5_1 then
		local var_5_3 = UnityEngine.GameObject.New(tostring(var_5_0))

		gohelper.addChild(arg_5_0._elementRoot, var_5_3)

		var_5_1 = MonoHelper.addLuaComOnceToGo(var_5_3, HeroInvitationDungeonMapElement, {
			arg_5_1,
			arg_5_0._mapScene,
			arg_5_0
		})
		arg_5_0._elementList[var_5_0] = var_5_1
		var_5_2 = true
	end

	if var_5_1:showArrow() then
		arg_5_0:createArrowItem(var_5_0)
		arg_5_0:_updateArrow(var_5_1)
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnElementAdd, var_5_0)

	if arg_5_0._inRemoveElementId == var_5_0 then
		var_5_1:setWenHaoGoVisible(true)
		arg_5_0:_removeElement(var_5_0)
	else
		local var_5_4 = DungeonMapModel.instance:elementIsFinished(var_5_0)

		var_5_1:setWenHaoGoVisible(arg_5_0.allFinish or not var_5_4)

		if not var_5_2 and arg_5_0.allFinish then
			var_5_1:setWenHaoAnim(DungeonMapElement.InAnimName)
		end
	end
end

function var_0_0._getElements(arg_6_0, arg_6_1)
	local var_6_0 = DungeonConfig.instance:getMapElements(arg_6_1)

	arg_6_0.allFinish = HeroInvitationModel.instance:isAllFinish()

	local var_6_1 = {}

	if var_6_0 then
		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			local var_6_2 = HeroInvitationModel.instance:getInvitationStateByElementId(iter_6_1.id)

			if var_6_2 ~= HeroInvitationEnum.InvitationState.TimeLocked and var_6_2 ~= HeroInvitationEnum.InvitationState.ElementLocked and (arg_6_0.allFinish or DungeonMapModel.instance:getElementById(iter_6_1.id) or DungeonMapModel.instance:elementIsFinished(iter_6_1.id)) then
				table.insert(var_6_1, iter_6_1)
			end
		end
	end

	return var_6_1
end

function var_0_0._removeElement(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._elementList[arg_7_1]

	if not var_7_0 then
		arg_7_0._inRemoveElementId = arg_7_1

		return
	end

	DungeonMapModel.instance.directFocusElement = true

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnFocusElement, arg_7_1)

	DungeonMapModel.instance.directFocusElement = false
	arg_7_0._inRemoveElementId = nil
	arg_7_0._inRemoveElement = true

	if var_7_0 then
		var_7_0:setFinishAndDotDestroy()
	end

	local var_7_1 = arg_7_0._arrowList[arg_7_1]

	if var_7_1 then
		arg_7_0:destoryArrowItem(var_7_1)

		arg_7_0._arrowList[arg_7_1] = nil
	end
end

function var_0_0.onRemoveElementFinish(arg_8_0)
	arg_8_0._inRemoveElement = false

	if arg_8_0._mapCfg then
		arg_8_0:_showElements(arg_8_0._mapCfg.id)
	end
end

function var_0_0._showElements(arg_9_0, arg_9_1)
	if arg_9_0._inRemoveElement then
		return
	end

	if gohelper.isNil(arg_9_0._sceneGo) or arg_9_0._lockShowElementAnim then
		return
	end

	if arg_9_0._inRemoveElementId then
		local var_9_0 = arg_9_0:_getElements(arg_9_1)
		local var_9_1 = {}
		local var_9_2 = {}

		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			if iter_9_1.id <= arg_9_0._inRemoveElementId then
				if iter_9_1.showCamera == 1 and not arg_9_0._skipShowElementAnim and arg_9_0._forceShowElementAnim then
					table.insert(var_9_1, iter_9_1.id)
				else
					table.insert(var_9_2, iter_9_1)
				end
			end
		end

		arg_9_0:_showElementAnim(var_9_1, var_9_2)
	else
		local var_9_3 = arg_9_0:_getElements(arg_9_1)
		local var_9_4 = DungeonMapModel.instance:getNewElements()
		local var_9_5 = {}
		local var_9_6 = {}

		for iter_9_2, iter_9_3 in ipairs(var_9_3) do
			if iter_9_3.showCamera == 1 and not arg_9_0._skipShowElementAnim and (var_9_4 and tabletool.indexOf(var_9_4, iter_9_3.id) or arg_9_0._forceShowElementAnim) then
				table.insert(var_9_5, iter_9_3.id)
			else
				table.insert(var_9_6, iter_9_3)
			end
		end

		arg_9_0:_showElementAnim(var_9_5, var_9_6)
		DungeonMapModel.instance:clearNewElements()
	end
end

function var_0_0.clickElement(arg_10_0, arg_10_1)
	if arg_10_0:_isShowElementAnim() then
		return
	end

	local var_10_0 = arg_10_0._elementList[tonumber(arg_10_1)]

	if not var_10_0 then
		return
	end

	local var_10_1 = var_10_0._config

	arg_10_0:_focusElementById(var_10_1.id)

	local var_10_2 = HeroInvitationConfig.instance:getInvitationConfigByElementId(var_10_1.id)

	if DungeonMapModel.instance:elementIsFinished(var_10_1.id) then
		local var_10_3 = var_10_2.restoryId
		local var_10_4 = {}

		var_10_4.blur = true
		var_10_4.hideStartAndEndDark = true

		StoryController.instance:playStory(var_10_3, var_10_4)
	else
		local var_10_5 = var_10_2.storyId
		local var_10_6 = {}

		var_10_6.blur = true
		var_10_6.hideStartAndEndDark = true

		StoryController.instance:playStory(var_10_5, var_10_6, function()
			DungeonRpc.instance:sendMapElementRequest(var_10_1.id)
		end)
	end
end

function var_0_0.hideMapHeroIcon(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._arrowList) do
		arg_12_0:destoryArrowItem(iter_12_1)
	end

	arg_12_0._arrowList = arg_12_0:getUserDataTb_()
end

function var_0_0.createArrowItem(arg_13_0, arg_13_1)
	if arg_13_0._arrowList[arg_13_1] then
		return arg_13_0._arrowList[arg_13_1]
	end

	local var_13_0 = arg_13_0:getUserDataTb_()

	var_13_0.elementId = arg_13_1
	var_13_0.go = gohelper.cloneInPlace(arg_13_0.goItem, tostring(arg_13_1))

	gohelper.setActive(var_13_0.go, false)

	var_13_0.arrowGO = gohelper.findChild(var_13_0.go, "arrow")
	var_13_0.rotationTrans = var_13_0.arrowGO.transform
	var_13_0.goHeroIcon = gohelper.findChild(var_13_0.go, "heroicon")
	var_13_0.heroHeadImage = gohelper.findChildSingleImage(var_13_0.go, "heroicon/#simage_herohead")
	var_13_0.click = gohelper.getClickWithDefaultAudio(var_13_0.heroHeadImage.gameObject)

	var_13_0.click:AddClickListener(arg_13_0.onClickHeroHeadIcon, arg_13_0, var_13_0)

	local var_13_1, var_13_2, var_13_3 = transformhelper.getLocalRotation(var_13_0.rotationTrans)

	var_13_0.initRotation = {
		var_13_1,
		var_13_2,
		var_13_3
	}
	arg_13_0._arrowList[arg_13_1] = var_13_0

	local var_13_4 = HeroInvitationConfig.instance:getInvitationConfigByElementId(arg_13_1)

	var_13_0.heroHeadImage:LoadImage(ResUrl.getHeadIconSmall(var_13_4.head))

	return var_13_0
end

function var_0_0.destoryArrowItem(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	arg_14_1.click:RemoveClickListener()
	arg_14_1.heroHeadImage:UnLoadImage()
	gohelper.destroy(arg_14_1.go)
end

function var_0_0.onClickHeroHeadIcon(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.elementId

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnFocusElement, var_15_0)
end

function var_0_0._updateArrow(arg_16_0, arg_16_1)
	if not arg_16_1:showArrow() then
		return
	end

	local var_16_0 = arg_16_1._transform
	local var_16_1 = CameraMgr.instance:getMainCamera():WorldToViewportPoint(var_16_0.position)
	local var_16_2 = var_16_1.x
	local var_16_3 = var_16_1.y
	local var_16_4 = DungeonMapModel.instance:elementIsFinished(arg_16_1:getElementId())
	local var_16_5 = var_16_2 >= 0 and var_16_2 <= 1 and var_16_3 >= 0 and var_16_3 <= 1
	local var_16_6 = arg_16_0._arrowList[arg_16_1:getElementId()]

	if not var_16_6 then
		return
	end

	gohelper.setActive(var_16_6.go, not var_16_4 and not var_16_5)

	if var_16_5 or var_16_4 then
		return
	end

	local var_16_7 = math.max(0.05, math.min(var_16_2, 0.95))
	local var_16_8 = math.max(0.1, math.min(var_16_3, 0.9))

	if var_16_8 > 0.85 and var_16_7 < 0.15 then
		var_16_8 = 0.85
	end

	local var_16_9 = recthelper.getWidth(arg_16_0._goarrow.transform)
	local var_16_10 = recthelper.getHeight(arg_16_0._goarrow.transform)

	recthelper.setAnchor(var_16_6.go.transform, var_16_9 * (var_16_7 - 0.5), var_16_10 * (var_16_8 - 0.5))

	local var_16_11 = var_16_6.initRotation

	if var_16_2 >= 0 and var_16_2 <= 1 then
		if var_16_3 < 0 then
			transformhelper.setLocalRotation(var_16_6.rotationTrans, var_16_11[1], var_16_11[2], 180)

			return
		elseif var_16_3 > 1 then
			transformhelper.setLocalRotation(var_16_6.rotationTrans, var_16_11[1], var_16_11[2], 0)

			return
		end
	end

	if var_16_3 >= 0 and var_16_3 <= 1 then
		if var_16_2 < 0 then
			transformhelper.setLocalRotation(var_16_6.rotationTrans, var_16_11[1], var_16_11[2], 90)

			return
		elseif var_16_2 > 1 then
			transformhelper.setLocalRotation(var_16_6.rotationTrans, var_16_11[1], var_16_11[2], 270)

			return
		end
	end

	local var_16_12 = Mathf.Deg(Mathf.Atan2(var_16_3, var_16_2)) - 90

	transformhelper.setLocalRotation(var_16_6.rotationTrans, var_16_11[1], var_16_11[2], var_16_12)
end

function var_0_0._disposeOldMap(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0._elementList) do
		iter_17_1:onDestroy()
	end

	arg_17_0._elementList = arg_17_0:getUserDataTb_()

	arg_17_0:hideMapHeroIcon()
	arg_17_0:_stopShowSequence()
end

return var_0_0
