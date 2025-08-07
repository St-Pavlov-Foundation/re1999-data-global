module("modules.logic.sp01.odyssey.view.OdysseyDungeonSceneElements", package.seeall)

local var_0_0 = class("OdysseyDungeonSceneElements", BaseView)
local var_0_1 = 0.5
local var_0_2 = 0.5

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._screenClick = SLFramework.UGUI.UIClickListener.Get(arg_1_0._gofullscreen)
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "root/#go_arrow")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	if GamepadController.instance:isOpen() then
		arg_2_0:addEventCb(GamepadController.instance, GamepadEvent.KeyDown, arg_2_0.onGamepadKeyDown, arg_2_0)
	end

	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnInitElements, arg_2_0.initElements, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnUpdateElementArrow, arg_2_0.updateAllArrowPos, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnElementFinish, arg_2_0.elementFinished, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnDisposeOldMap, arg_2_0.onDisposeOldMap, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.CreateNewElement, arg_2_0.showNewElements, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.PlayElementAnim, arg_2_0.playElementAnim, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0, LuaEventSystem.Low)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(GamepadController.instance, GamepadEvent.KeyDown, arg_3_0.onGamepadKeyDown, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnInitElements, arg_3_0.initElements, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnUpdateElementArrow, arg_3_0.updateAllArrowPos, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnElementFinish, arg_3_0.elementFinished, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnDisposeOldMap, arg_3_0.onDisposeOldMap, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.CreateNewElement, arg_3_0.showNewElements, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.PlayElementAnim, arg_3_0.playElementAnim, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0._screenClick:RemoveClickUpListener()
end

function var_0_0.onElementClickDown(arg_4_0, arg_4_1)
	arg_4_0.curClickElement = arg_4_1
end

function var_0_0.onScreenClickUp(arg_5_0, arg_5_1)
	local var_5_0 = OdysseyDungeonModel.instance:getDraggingMapState()

	if not arg_5_0.curClickElement or var_5_0 then
		return
	end

	local var_5_1 = arg_5_0.curClickElement

	if OdysseyDungeonModel.instance:isElementFinish(var_5_1.config.id) or gohelper.isNil(var_5_1.go) then
		return
	end

	TaskDispatcher.cancelTask(arg_5_0.realClickElement, arg_5_0)

	if arg_5_1 then
		TaskDispatcher.runDelay(arg_5_0.realClickElement, arg_5_0, 0.3)
	else
		arg_5_0:realClickElement()
	end
end

function var_0_0.realClickElement(arg_6_0)
	local var_6_0 = arg_6_0.curClickElement

	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnClickElement, var_6_0)

	arg_6_0.curClickElement = nil

	if not arg_6_0.curHeroPosElementCo or arg_6_0.curHeroPosElementCo.id ~= var_6_0.config.id then
		arg_6_0:setHeroItemPos(var_6_0.config)
		arg_6_0:playShowOrHideHeroAnim(true, var_6_0.config.id)
		OdysseyRpc.instance:sendOdysseyMapSetCurrElementRequest(var_6_0.config.id)
	end

	OdysseyDungeonController.instance:openDungeonInteractView(var_6_0)
end

function var_0_0.onGamepadKeyDown(arg_7_0, arg_7_1)
	if arg_7_1 ~= GamepadEnum.KeyCode.A then
		return
	end

	local var_7_0 = GamepadController.instance:getScreenPos()
	local var_7_1 = CameraMgr.instance:getMainCamera():ScreenPointToRay(var_7_0)
	local var_7_2 = UnityEngine.Physics2D.RaycastAll(var_7_1.origin, var_7_1.direction)
	local var_7_3 = var_7_2.Length - 1

	for iter_7_0 = 0, var_7_3 do
		local var_7_4 = var_7_2[iter_7_0]
		local var_7_5 = MonoHelper.getLuaComFromGo(var_7_4.transform.parent.gameObject, OdysseyDungeonElement)

		if var_7_5 then
			var_7_5:onClickDown()
		end
	end
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.elementCompMap = arg_8_0:getUserDataTb_()
	arg_8_0.elementRootMap = arg_8_0:getUserDataTb_()
	arg_8_0.elementArrowMap = arg_8_0:getUserDataTb_()
	arg_8_0.curHeroPosElementCo = nil
	arg_8_0.mainCamera = CameraMgr.instance:getMainCamera()
end

function var_0_0.initElements(arg_9_0, arg_9_1)
	arg_9_0._screenClick:AddClickUpListener(arg_9_0.onScreenClickUp, arg_9_0)

	arg_9_0.curMapId = OdysseyDungeonModel.instance:getCurMapId()
	arg_9_0.elementsRootGO = arg_9_1

	local var_9_0 = gohelper.findChild(arg_9_0.elementsRootGO, "root")

	arg_9_0.rootScale = transformhelper.getLocalScale(var_9_0.transform)
	arg_9_0.heroItem = gohelper.findChild(arg_9_0.elementsRootGO, "root/hero/#go_heroItem")
	arg_9_0.animHeroItem = arg_9_0.heroItem:GetComponent(typeof(UnityEngine.Animator))

	for iter_9_0, iter_9_1 in pairs(OdysseyEnum.ElementTypeRoot) do
		if not arg_9_0.elementRootMap[iter_9_0] then
			local var_9_1 = gohelper.findChild(arg_9_0.elementsRootGO, "root/" .. iter_9_1)

			arg_9_0.elementRootMap[iter_9_0] = var_9_1
		end
	end

	arg_9_0:removeAllElement()
	TaskDispatcher.cancelTask(arg_9_0.addElements, arg_9_0)

	local var_9_2 = OdysseyDungeonModel.instance:getLastElementFightParam()
	local var_9_3 = OdysseyDungeonModel.instance:getCurFightEpisodeId()

	if var_9_2 and var_9_2.lastElementId > 0 and var_9_3 ~= var_9_2.lastEpisodeId then
		local var_9_4 = OdysseyConfig.instance:getElementConfig(var_9_2.lastElementId)
		local var_9_5 = OdysseyDungeonModel.instance:getNewElementList()

		if var_9_4 and var_9_4.isPermanent ~= 1 and #var_9_5 > 0 then
			TaskDispatcher.runDelay(arg_9_0.addElements, arg_9_0, 1.5)
		else
			arg_9_0:addElements()
		end
	else
		arg_9_0:addElements()
	end

	arg_9_0:cleanLastFightElementAndJumpNext()

	local var_9_6 = OdysseyDungeonModel.instance:getCurInElementId()

	if var_9_6 > 0 then
		local var_9_7 = OdysseyConfig.instance:getElementConfig(var_9_6)

		gohelper.setActive(arg_9_0.heroItem, var_9_7 and var_9_7.mapId == arg_9_0.curMapId)

		if var_9_7.mapId == arg_9_0.curMapId then
			arg_9_0:setHeroItemPos(var_9_7)
			arg_9_0:playShowOrHideHeroAnim(true)
		end
	else
		gohelper.setActive(arg_9_0.heroItem, true)

		local var_9_8 = OdysseyConfig.instance:getDungeonMapConfig(arg_9_0.curMapId)
		local var_9_9 = string.splitToNumber(var_9_8.initPos, "#")
		local var_9_10 = -(var_9_9[1] / arg_9_0.rootScale) or 0
		local var_9_11 = -(var_9_9[2] / arg_9_0.rootScale) or 0

		transformhelper.setLocalPos(arg_9_0.heroItem.transform, var_9_10, var_9_11, 0)
	end
end

function var_0_0.addElements(arg_10_0)
	local var_10_0 = OdysseyDungeonModel.instance:getCurAllElementCoList(arg_10_0.curMapId)

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		arg_10_0:addOrUpdateElement(iter_10_1)
		arg_10_0:addOrUpdateArrowItem(iter_10_1)
	end
end

function var_0_0.addOrUpdateElement(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.elementCompMap[arg_11_1.id]

	if not var_11_0 then
		local var_11_1 = arg_11_0.viewContainer:getSetting().otherRes[1]
		local var_11_2 = arg_11_0.viewContainer:getResInst(var_11_1, arg_11_0.elementRootMap[arg_11_1.type], tostring(arg_11_1.id))

		var_11_0 = MonoHelper.addLuaComOnceToGo(var_11_2, OdysseyDungeonElement, {
			arg_11_1,
			arg_11_0
		})

		var_11_0:playShowOrHideAnim(true)
	else
		local var_11_3 = arg_11_0.elementRootMap[arg_11_1.type]

		gohelper.addChild(var_11_3, var_11_0.go)
		var_11_0:updateInfo()
	end

	arg_11_0.elementCompMap[arg_11_1.id] = var_11_0
end

function var_0_0.addOrUpdateArrowItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.elementCompMap[arg_12_1.id]

	if var_12_0 and var_12_0:needShowArrow() then
		local var_12_1 = arg_12_0.elementArrowMap[arg_12_1.id]

		if not var_12_1 then
			var_12_1 = arg_12_0:getUserDataTb_()

			local var_12_2 = arg_12_0.viewContainer:getSetting().otherRes[2]

			var_12_1.go = arg_12_0:getResInst(var_12_2, arg_12_0._goarrow, tostring(arg_12_1.id) .. "arrowItem")
			var_12_1.rotateGO = gohelper.findChild(var_12_1.go, "icon/arrow")
			var_12_1.arrowClick = gohelper.findChildButtonWithAudio(var_12_1.go, "click")

			var_12_1.arrowClick:AddClickListener(arg_12_0.arrowItemClick, arg_12_0, arg_12_1.id)

			local var_12_3, var_12_4, var_12_5 = transformhelper.getLocalRotation(var_12_1.rotateGO.transform)

			var_12_1.initRotation = {
				var_12_3,
				var_12_4,
				var_12_5
			}
			var_12_1.elementItemIcon = gohelper.findChild(var_12_1.go, "icon/elementItemIcon")
			var_12_1.optionItem = gohelper.findChild(var_12_1.elementItemIcon, "optionItem")
			var_12_1.optionItemIcon = gohelper.findChildImage(var_12_1.elementItemIcon, "optionItem/#image_optionIcon")
			var_12_1.dialogItem = gohelper.findChild(var_12_1.elementItemIcon, "dialogItem")
			var_12_1.dialogItemIcon = gohelper.findChildSingleImage(var_12_1.elementItemIcon, "dialogItem/#image_dialogHero")
			var_12_1.fightItem = gohelper.findChild(var_12_1.elementItemIcon, "fightItem")
			var_12_1.fightItemIcon = gohelper.findChildImage(var_12_1.elementItemIcon, "fightItem/#image_fightIcon")
			arg_12_0.elementArrowMap[arg_12_1.id] = var_12_1
		end

		arg_12_0:updateArrowPos(arg_12_1.id)
		arg_12_0:updateArrowElementIcon(var_12_1, arg_12_1)
	end
end

function var_0_0.updateArrowElementIcon(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_2.type

	for iter_13_0, iter_13_1 in pairs(OdysseyEnum.ElementTypeRoot) do
		gohelper.setActive(arg_13_1[iter_13_1 .. "Item"], var_13_0 == iter_13_0)
	end

	if var_13_0 == OdysseyEnum.ElementType.Option then
		UISpriteSetMgr.instance:setSp01OdysseyDungeonElementSprite(arg_13_1.optionItemIcon, arg_13_2.icon)
	elseif var_13_0 == OdysseyEnum.ElementType.Dialog then
		arg_13_1.dialogItemIcon:LoadImage(ResUrl.getRoomHeadIcon(arg_13_2.icon))
	elseif var_13_0 == OdysseyEnum.ElementType.Fight then
		UISpriteSetMgr.instance:setSp01OdysseyDungeonElementSprite(arg_13_1.fightItemIcon, arg_13_2.icon)
	end
end

function var_0_0.updateAllArrowPos(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.elementCompMap) do
		arg_14_0:updateArrowPos(iter_14_0)
	end
end

function var_0_0.updateArrowPos(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.elementArrowMap[arg_15_1]
	local var_15_1 = arg_15_0.elementCompMap[arg_15_1]

	if not var_15_0 or not var_15_1 then
		return
	end

	local var_15_2 = var_15_1.trans
	local var_15_3 = arg_15_0.mainCamera:WorldToViewportPoint(var_15_2.position)
	local var_15_4 = var_15_3.x >= 0 and var_15_3.x <= 1 and var_15_3.y >= 0 and var_15_3.y <= 1 and var_15_3.z > 0

	gohelper.setActive(var_15_0.go, not var_15_4)

	if var_15_4 then
		return
	end

	local var_15_5 = Mathf.Clamp(var_15_3.x, 0.0416, 0.958)
	local var_15_6 = Mathf.Clamp(var_15_3.y, 0.074, 0.926)
	local var_15_7 = recthelper.getWidth(arg_15_0._goarrow.transform)
	local var_15_8 = recthelper.getHeight(arg_15_0._goarrow.transform)

	recthelper.setAnchor(var_15_0.go.transform, var_15_7 * (var_15_5 - 0.5), var_15_8 * (var_15_6 - 0.5))

	if var_15_3.x >= 0 and var_15_3.x <= 1 then
		if var_15_3.y < 0 then
			transformhelper.setLocalRotation(var_15_0.rotateGO.transform, var_15_0.initRotation[1], var_15_0.initRotation[2], var_15_0.initRotation[3] + 180)

			return
		elseif var_15_3.y > 1 then
			transformhelper.setLocalRotation(var_15_0.rotateGO.transform, var_15_0.initRotation[1], var_15_0.initRotation[2], var_15_0.initRotation[3])

			return
		end
	end

	if var_15_3.y >= 0 and var_15_3.y <= 1 then
		if var_15_3.x < 0 then
			transformhelper.setLocalRotation(var_15_0.rotateGO.transform, var_15_0.initRotation[1], var_15_0.initRotation[2], var_15_0.initRotation[3] + 90)

			return
		elseif var_15_3.x > 1 then
			transformhelper.setLocalRotation(var_15_0.rotateGO.transform, var_15_0.initRotation[1], var_15_0.initRotation[2], var_15_0.initRotation[3] - 90)

			return
		end
	end

	local var_15_9 = Mathf.Atan2(var_15_3.y, var_15_3.x) * Mathf.Rad2Deg - 90

	transformhelper.setLocalRotation(var_15_0.rotateGO.transform, var_15_0.initRotation[1], var_15_0.initRotation[2], var_15_0.initRotation[3] + var_15_9)
end

function var_0_0.getElemenetComp(arg_16_0, arg_16_1)
	return arg_16_0.elementCompMap[arg_16_1]
end

function var_0_0.arrowItemClick(arg_17_0, arg_17_1)
	arg_17_0.curClickElement = nil

	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnFocusElement, arg_17_1)
end

function var_0_0.setHeroItemPos(arg_18_0, arg_18_1)
	if arg_18_0.heroItem then
		gohelper.setActive(arg_18_0.heroItem, true)

		local var_18_0 = string.splitToNumber(arg_18_1.pos, "#")
		local var_18_1 = string.splitToNumber(arg_18_1.heroPos, "#")
		local var_18_2 = {
			var_18_0[1] + var_18_1[1],
			var_18_0[2] + var_18_1[2],
			var_18_0[3]
		}

		transformhelper.setLocalPos(arg_18_0.heroItem.transform, var_18_2[1], var_18_2[2], var_18_2[3])

		arg_18_0.curHeroPosElementCo = arg_18_1
	end
end

function var_0_0.playShowOrHideHeroAnim(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = OdysseyDungeonModel.instance:getCurInElementId()

	if arg_19_1 and arg_19_2 == var_19_0 then
		arg_19_0.animHeroItem:Play("idle", 0, 0)
		arg_19_0.animHeroItem:Update(0)

		return
	end

	arg_19_0.animHeroItem:Play(arg_19_1 and "open" or "close", 0, 0)

	if arg_19_1 then
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_disp)
	end
end

function var_0_0.elementFinished(arg_20_0, arg_20_1)
	if OdysseyDungeonModel.instance:isElementFinish(arg_20_1) then
		if not OdysseyDungeonController.instance:checkNeedPopupRewardView() then
			arg_20_0:playHeroItemFadeAnim(arg_20_1)
		end

		arg_20_0:playElementFinishAnim(arg_20_1)
		arg_20_0:showNewElements()
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.RefreshDungeonView)
	end
end

function var_0_0.showNewElements(arg_21_0, arg_21_1)
	arg_21_0.notAutoOpenElement = arg_21_1

	local var_21_0 = OdysseyDungeonModel.instance:getNewElementList()

	if not var_21_0 or #var_21_0 == 0 then
		TaskDispatcher.cancelTask(arg_21_0.removeUnExitElement, arg_21_0)
		TaskDispatcher.runDelay(arg_21_0.removeUnExitElement, arg_21_0, var_0_1)

		return
	end

	local var_21_1 = {}

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if iter_21_1.mapId == arg_21_0.curMapId then
			table.insert(var_21_1, iter_21_1)
		end
	end

	arg_21_0:showNewElementsAnim(var_21_1)

	if OdysseyDungeonModel.instance:checkHasFightTypeElement(OdysseyEnum.FightType.Myth) then
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.MythUnlockGuide)
	end

	OdysseyDungeonModel.instance:cleanNewElements()
end

function var_0_0.showNewElementsAnim(arg_22_0, arg_22_1)
	if #arg_22_1 == 0 then
		return
	end

	local var_22_0 = {}

	arg_22_0.animElementList = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		if iter_22_1.needFollow == OdysseyEnum.DungeonElementNeedFollow then
			table.insert(arg_22_0.animElementList, iter_22_1)
			arg_22_0:addOrUpdateArrowItem(iter_22_1)
		else
			table.insert(var_22_0, iter_22_1)
			arg_22_0:addOrUpdateElement(iter_22_1)
			AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_icons)
		end
	end

	TaskDispatcher.cancelTask(arg_22_0.removeUnExitElement, arg_22_0)
	TaskDispatcher.runDelay(arg_22_0.removeUnExitElement, arg_22_0, var_0_1)

	if #arg_22_0.animElementList == 0 then
		return
	end

	table.sort(arg_22_0.animElementList, var_0_0.sortElementList)

	arg_22_0.showSequence = FlowSequence.New()

	arg_22_0.showSequence:addWork(TimerWork.New(var_0_1))

	for iter_22_2, iter_22_3 in ipairs(arg_22_0.animElementList) do
		arg_22_0.showSequence:addWork(FunctionWork.New(var_0_0.addNewElement, {
			arg_22_0,
			iter_22_3
		}))
		arg_22_0.showSequence:addWork(TimerWork.New(var_0_1))
	end

	arg_22_0.nextElementId = arg_22_0.animElementList[1].id

	arg_22_0.showSequence:addWork(OdysseyCheckCloseRewardWork.New(arg_22_0.nextElementId, true))
	arg_22_0.showSequence:registerDoneListener(arg_22_0.stopShowElementsSequence, arg_22_0)
	arg_22_0.showSequence:start()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(OdysseyEnum.BlockKey.FocusNewElement)
end

function var_0_0.sortElementList(arg_23_0, arg_23_1)
	return arg_23_0.id < arg_23_1.id
end

function var_0_0.addNewElement(arg_24_0)
	local var_24_0 = arg_24_0[1]
	local var_24_1 = arg_24_0[2]

	var_24_0:addOrUpdateElement(var_24_1)
	var_24_0:addOrUpdateArrowItem(var_24_1)
end

function var_0_0.doFocusElement(arg_25_0)
	local var_25_0 = arg_25_0[1]
	local var_25_1 = arg_25_0[2]
	local var_25_2 = arg_25_0[3]

	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnFocusElement, var_25_1, var_25_2)
end

function var_0_0.stopShowElementsSequence(arg_26_0)
	if arg_26_0.showSequence then
		arg_26_0.showSequence:unregisterDoneListener(arg_26_0.stopShowElementsSequence, arg_26_0)
		arg_26_0.showSequence:destroy()

		arg_26_0.showSequence = nil
	end

	UIBlockMgr.instance:endBlock(OdysseyEnum.BlockKey.FocusNewElement)

	if arg_26_0.nextElementId then
		local var_26_0 = arg_26_0.elementCompMap[arg_26_0.nextElementId]

		if var_26_0 and not arg_26_0.notAutoOpenElement then
			arg_26_0.curClickElement = var_26_0

			if not GuideModel.instance:isGuideRunning(OdysseyEnum.NotOpenInteractWithGuideId) then
				arg_26_0:onScreenClickUp(true)
			end
		end

		arg_26_0.nextElementId = nil
	end
end

function var_0_0._onCloseView(arg_27_0, arg_27_1)
	if arg_27_1 == ViewName.StoryView then
		local var_27_0 = OdysseyDungeonModel.instance:getStoryOptionParam()

		if var_27_0 and var_27_0.optionId > 0 then
			local var_27_1 = OdysseyConfig.instance:getOptionConfig(var_27_0.optionId)

			if var_27_1 and var_27_1.notFinish ~= OdysseyEnum.ElementOptionNotFinish then
				({}).optionId = var_27_0.optionId

				OdysseyRpc.instance:sendOdysseyMapInteractRequest(var_27_0.elementId, var_27_0)
				OdysseyDungeonModel.instance:setStoryOptionParam(nil)
			end
		end
	end
end

function var_0_0.playElementFinishAnim(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.elementCompMap[arg_28_1]

	if var_28_0 then
		var_28_0:playShowOrHideAnim(false)
		arg_28_0:removeArrow(arg_28_1)
	end
end

function var_0_0.playHeroItemFadeAnim(arg_29_0, arg_29_1)
	local var_29_0 = OdysseyDungeonModel.instance:getCurInElementId()

	if arg_29_0:checkHasNeedFollowNewElemenet() and arg_29_1 == var_29_0 then
		arg_29_0:playShowOrHideHeroAnim(false)
	end
end

function var_0_0.playElementAnim(arg_30_0, arg_30_1, arg_30_2)
	for iter_30_0, iter_30_1 in pairs(arg_30_0.elementCompMap) do
		iter_30_1:playAnim(OdysseyEnum.ElementAnimName.Idle)
	end

	local var_30_0 = arg_30_0.elementCompMap[arg_30_1]

	if var_30_0 then
		var_30_0:playAnim(arg_30_2)
	end
end

function var_0_0.checkHasNeedFollowNewElemenet(arg_31_0)
	local var_31_0 = OdysseyDungeonModel.instance:getNewElementList()

	for iter_31_0, iter_31_1 in ipairs(var_31_0) do
		if iter_31_1.mapId == arg_31_0.curMapId and iter_31_1.needFollow == OdysseyEnum.DungeonElementNeedFollow then
			return true
		end
	end

	return false
end

function var_0_0.cleanLastFightElementAndJumpNext(arg_32_0)
	arg_32_0.lastFightElementId = nil

	local var_32_0 = OdysseyDungeonModel.instance:getLastElementFightParam()

	if var_32_0 and var_32_0.lastElementId > 0 then
		local var_32_1 = OdysseyConfig.instance:getElementConfig(var_32_0.lastElementId)

		if not OdysseyDungeonModel.instance:isElementFinish(var_32_0.lastElementId) or var_32_1.isPermanent == 1 then
			local var_32_2 = arg_32_0.elementCompMap[var_32_0.lastElementId]

			if var_32_2 then
				arg_32_0.curClickElement = var_32_2

				arg_32_0:onScreenClickUp()
			end
		else
			arg_32_0.lastFightElementId = var_32_1.id

			arg_32_0:addOrUpdateElement(var_32_1)
			TaskDispatcher.runDelay(arg_32_0.setElementFinished, arg_32_0, 1)
		end
	end

	TaskDispatcher.runDelay(arg_32_0.playSubTaskFinishEffect, arg_32_0, 1)
	OdysseyDungeonModel.instance:cleanLastElementFightParam()
end

function var_0_0.playSubTaskFinishEffect(arg_33_0)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.PlaySubTaskFinishEffect)
end

function var_0_0.setElementFinished(arg_34_0)
	if not arg_34_0.lastFightElementId and arg_34_0.elementCompMap[arg_34_0.lastFightElementId] then
		return
	end

	arg_34_0:elementFinished(arg_34_0.lastFightElementId)
end

function var_0_0.removeAllElement(arg_35_0)
	for iter_35_0, iter_35_1 in pairs(arg_35_0.elementCompMap) do
		arg_35_0:removeElement(iter_35_0)
		arg_35_0:removeArrow(iter_35_0)
	end
end

function var_0_0.removeUnExitElement(arg_36_0)
	local var_36_0 = OdysseyDungeonModel.instance:getCurAllElementCoList(arg_36_0.curMapId)

	for iter_36_0, iter_36_1 in pairs(arg_36_0.elementCompMap) do
		local var_36_1 = true

		for iter_36_2, iter_36_3 in ipairs(var_36_0) do
			if iter_36_3.id == iter_36_0 then
				var_36_1 = false

				break
			end
		end

		if var_36_1 then
			arg_36_0:removeElement(iter_36_0)
			arg_36_0:removeArrow(iter_36_0)
		end
	end
end

function var_0_0.removeElement(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0.elementCompMap[arg_37_1]

	if var_37_0 and var_37_0.go then
		gohelper.destroy(var_37_0.go)
	end

	arg_37_0.elementCompMap[arg_37_1] = nil
end

function var_0_0.removeArrow(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0.elementArrowMap[arg_38_1]

	if var_38_0 and var_38_0.go then
		var_38_0.arrowClick:RemoveClickListener()
		var_38_0.dialogItemIcon:UnLoadImage()
		gohelper.destroy(var_38_0.go)

		arg_38_0.elementArrowMap[arg_38_1] = nil
	end
end

function var_0_0.onDisposeOldMap(arg_39_0)
	arg_39_0.nextElementId = nil

	arg_39_0:removeAllElement()
	arg_39_0:stopShowElementsSequence()

	arg_39_0.elementRootMap = arg_39_0:getUserDataTb_()
end

function var_0_0.onClose(arg_40_0)
	arg_40_0:onDisposeOldMap()
	TaskDispatcher.cancelTask(arg_40_0.showNewElements, arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.setElementFinished, arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.realClickElement, arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.playSubTaskFinishEffect, arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.removeUnExitElement, arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.addElements, arg_40_0)
end

function var_0_0.onDestroyView(arg_41_0)
	arg_41_0:removeAllElement()
end

return var_0_0
