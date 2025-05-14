module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryMapNodeItem", package.seeall)

local var_0_0 = class("VersionActivity1_8FactoryMapNodeItem", UserDataDispose)
local var_0_1 = 0.8
local var_0_2 = 0.5

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0:__onInit()

	arg_1_0.actId = Activity157Model.instance:getActId()
	arg_1_0.go = arg_1_1
	arg_1_0.getLineTemplateFunc = arg_1_2
	arg_1_0.lineParentGo = arg_1_3
	arg_1_0.trans = arg_1_0.go.transform
	arg_1_0._animator = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goLineParentInNode = gohelper.findChild(arg_1_0.go, "line")
	arg_1_0._gonum = gohelper.findChild(arg_1_0.go, "num")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.go, "num/#txt_num")
	arg_1_0._gotimetips = gohelper.findChild(arg_1_0.go, "timetips")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.go, "timetips/#txt_time")
	arg_1_0._imagestatus = gohelper.findChildImage(arg_1_0.go, "#image_status")
	arg_1_0._godispatchrewardeff = gohelper.findChild(arg_1_0.go, "#image_status/#vx_reward")
	arg_1_0._gounlockeff = gohelper.findChild(arg_1_0.go, "#image_status/#vx_unlock")
	arg_1_0._goReddot = gohelper.findChild(arg_1_0.go, "#go_reddot")
	arg_1_0._btnnode = gohelper.findChildClickWithDefaultAudio(arg_1_0.go, "#btn_node")
	arg_1_0.parentView = arg_1_4

	arg_1_0:addEventListeners()
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0.statusClickHandler = {
		[Activity157Enum.MissionStatus.Normal] = arg_2_0._clickNormal,
		[Activity157Enum.MissionStatus.Locked] = arg_2_0._clickLocked,
		[Activity157Enum.MissionStatus.Dispatching] = arg_2_0._clickDispatch,
		[Activity157Enum.MissionStatus.DispatchFinish] = arg_2_0._clickDispatch,
		[Activity157Enum.MissionStatus.Finish] = arg_2_0._clickFinish
	}

	arg_2_0._btnnode:AddClickListener(arg_2_0._btnnodeOnClick, arg_2_0)
	arg_2_0:addEventCb(DispatchController.instance, DispatchEvent.OnDispatchFinish, arg_2_0.onDispatchFinish, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnnode:RemoveClickListener()
	arg_3_0:removeEventCb(DispatchController.instance, DispatchEvent.OnDispatchFinish, arg_3_0.onDispatchFinish, arg_3_0)
end

function var_0_0._btnnodeOnClick(arg_4_0)
	local var_4_0 = Activity157Config.instance:getMissionElementId(arg_4_0.actId, arg_4_0.missionId)

	if not var_4_0 then
		return
	end

	local var_4_1 = Activity157Model.instance:getMissionStatus(arg_4_0.missionGroupId, arg_4_0.missionId)
	local var_4_2 = arg_4_0.statusClickHandler[var_4_1]

	if var_4_2 then
		var_4_2(arg_4_0, var_4_0)
	else
		logError(string.format("VersionActivity1_8FactoryMapNodeItem:_btnnodeOnClick, no status handler, status:%s", var_4_1))
	end
end

function var_0_0._clickNormal(arg_5_0, arg_5_1)
	if Activity157Model.instance:isInProgressOtherMissionGroup(arg_5_0.missionGroupId) then
		GameFacade.showToast(ToastEnum.V1a8Activity157HasDoingOtherMissionGroup)

		return
	end

	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.FocusElement, arg_5_1)
	AudioMgr.instance:trigger(AudioEnum.main_ui.play_ui_task_page)
end

function var_0_0._clickLocked(arg_6_0, arg_6_1)
	local var_6_0 = Activity157Model.instance:getMissionUnlockToastId(arg_6_0.missionId, arg_6_1)

	if var_6_0 then
		GameFacade.showToast(var_6_0)
	end
end

function var_0_0._clickDispatch(arg_7_0, arg_7_1)
	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.ManualClickElement, arg_7_1)
end

function var_0_0._clickFinish(arg_8_0)
	local var_8_0 = Activity157Config.instance:getMissionElementId(arg_8_0.actId, arg_8_0.missionId)
	local var_8_1 = var_8_0 and DungeonConfig.instance:getChapterMapElement(var_8_0)
	local var_8_2 = var_8_1 and var_8_1.type

	if var_8_2 == DungeonEnum.ElementType.None or var_8_2 == DungeonEnum.ElementType.Story then
		local var_8_3 = Activity157Config.instance:getAct157MissionStoryId(arg_8_0.actId, arg_8_0.missionId)

		if var_8_3 and var_8_3 ~= 0 then
			StoryController.instance:playStory(var_8_3, nil, function()
				arg_8_0:openFragmentInfoView(var_8_1)
			end)
		else
			arg_8_0:openFragmentInfoView(var_8_1)
		end
	else
		GameFacade.showToast(ToastEnum.V1a8Activity157MissionHasFinished)
	end
end

function var_0_0.openFragmentInfoView(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.fragment
	local var_10_1 = HandbookModel.instance:getFragmentDialogIdList(var_10_0)

	ViewMgr.instance:openView(ViewName.DungeonFragmentInfoView, {
		isFromHandbook = true,
		fragmentId = var_10_0,
		dialogIdList = var_10_1
	})
end

function var_0_0.onDispatchFinish(arg_11_0)
	local var_11_0 = Activity157Config.instance:getMissionElementId(arg_11_0.actId, arg_11_0.missionId)

	if not DungeonConfig.instance:isDispatchElement(var_11_0) then
		return
	end

	arg_11_0:refreshStatus()
end

function var_0_0.setMissionData(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if not arg_12_1 or not arg_12_2 then
		return
	end

	arg_12_0.missionId = arg_12_2
	arg_12_0.missionGroupId = arg_12_1

	local var_12_0 = Activity157Config.instance:getAct157MissionPos(arg_12_0.actId, arg_12_0.missionId)

	recthelper.setAnchor(arg_12_0.trans, var_12_0[1], var_12_0[2])

	arg_12_0.go.name = string.format("%s-%s", arg_12_0.missionGroupId, arg_12_0.missionId)

	local var_12_1 = Activity157Config.instance:getAct157MissionOrder(arg_12_0.actId, arg_12_0.missionId)

	if var_12_1 then
		arg_12_0._txtnum.text = var_12_1

		gohelper.setActive(arg_12_0._gonum, true)
	else
		gohelper.setActive(arg_12_0._gonum, false)
	end

	arg_12_0:createLine()
	arg_12_0:refresh()

	local var_12_2
	local var_12_3 = Activity157Config.instance:getMissionElementId(arg_12_0.actId, arg_12_0.missionId)
	local var_12_4 = var_12_3 and DungeonConfig.instance:getChapterMapElement(var_12_3)

	if (var_12_4 and var_12_4.type) == DungeonEnum.ElementType.Dispatch then
		var_12_2 = tonumber(var_12_4.param)
	end

	RedDotController.instance:addRedDot(arg_12_0._goReddot, RedDotEnum.DotNode.V1a8FactoryMapDispatchFinish, var_12_2, arg_12_0.checkDispatchReddot, arg_12_0)
	gohelper.setActive(arg_12_0.go, true)

	if Activity157Model.instance:getIsNeedPlayMissionUnlockAnim(arg_12_0.missionId) then
		arg_12_0:playNodeAnimation("open", "go")

		if arg_12_0._lineAnimator then
			arg_12_0._lineAnimator.speed = 0
		end

		arg_12_0._animator.speed = 0

		local var_12_5 = 0

		if arg_12_3 then
			var_12_5 = var_0_1
		elseif not Activity157Config.instance:isRootMission(arg_12_0.actId, arg_12_2) then
			var_12_5 = var_0_2
		end

		TaskDispatcher.cancelTask(arg_12_0.playNodeUnlockAnimation, arg_12_0)
		TaskDispatcher.runDelay(arg_12_0.playNodeUnlockAnimation, arg_12_0, var_12_5)
	else
		arg_12_0:playNodeAnimation("open", "open", "unlock")
	end
end

function var_0_0.refreshUnlockAnim(arg_13_0)
	arg_13_0:refresh()

	if not Activity157Model.instance:getIsNeedPlayMissionUnlockAnim(arg_13_0.missionId) then
		return
	end

	arg_13_0:playNodeUnlockAnimation()
end

function var_0_0.checkDispatchReddot(arg_14_0, arg_14_1)
	arg_14_1:defaultRefreshDot()
	gohelper.setActive(arg_14_0._godispatchrewardeff, arg_14_1.show)
end

function var_0_0.createLine(arg_15_0)
	arg_15_0:destroyLine()

	local var_15_0

	if arg_15_0.getLineTemplateFunc then
		local var_15_1 = Activity157Config.instance:getLineResPath(arg_15_0.actId, arg_15_0.missionId)

		var_15_0 = arg_15_0.getLineTemplateFunc(arg_15_0.parentView, var_15_1)
	end

	if not var_15_0 then
		return
	end

	arg_15_0.lineGo = gohelper.clone(var_15_0, arg_15_0.lineParentGo or arg_15_0._goLineParentInNode)

	if gohelper.isNil(arg_15_0.lineGo) then
		return
	end

	arg_15_0._lineAnimator = gohelper.findChildComponent(arg_15_0.lineGo, "ani", typeof(UnityEngine.Animator))
	arg_15_0._goLineFinish = gohelper.findChild(arg_15_0.lineGo, "ani/line_finish")
	arg_15_0._goLineUnlock = gohelper.findChild(arg_15_0.lineGo, "ani/line_unlock")
	arg_15_0._goLineLock = gohelper.findChild(arg_15_0.lineGo, "ani/line_lock")
	arg_15_0._lineImagePoint1 = gohelper.findChildImage(arg_15_0.lineGo, "ani/point1")
	arg_15_0._lineImagePoint2 = gohelper.findChildImage(arg_15_0.lineGo, "ani/point2")

	local var_15_2, var_15_3 = recthelper.getAnchor(arg_15_0._lineImagePoint2.transform, 0, 0)
	local var_15_4 = Activity157Config.instance:getAct157Const(arg_15_0.actId, Activity157Enum.ConstId.FactoryMapNodeLineOffsetY)
	local var_15_5 = tonumber(var_15_4) or 0

	if arg_15_0.lineParentGo then
		local var_15_6 = Activity157Config.instance:getAct157MissionPos(arg_15_0.actId, arg_15_0.missionId)

		recthelper.setAnchor(arg_15_0.lineGo.transform, var_15_6[1] - var_15_2, var_15_6[2] - var_15_3 + var_15_5)
	else
		recthelper.setAnchor(arg_15_0.lineGo.transform, -var_15_2, -var_15_3 + var_15_5)
	end

	gohelper.setActive(arg_15_0.lineGo, true)
end

function var_0_0.playNodeAnimation(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if not string.nilorempty(arg_16_1) and arg_16_0._animator then
		arg_16_0._animator:Play(arg_16_1, 0, 0)
	end

	if not string.nilorempty(arg_16_2) and arg_16_0._lineAnimator then
		arg_16_0._lineAnimator:Play(arg_16_2, 0, 0)
	end

	local var_16_0 = Activity157Config.instance:getMissionArea(arg_16_0.actId, arg_16_0.missionId)

	arg_16_0.parentView:playAreaAnim(var_16_0, arg_16_3)
end

function var_0_0.playNodeUnlockAnimation(arg_17_0)
	arg_17_0:playNodeAnimation("open", "go", "unlock")

	if arg_17_0._lineAnimator then
		arg_17_0._lineAnimator.speed = 1

		AudioMgr.instance:trigger(AudioEnum.UI.Act157FactoryNodeLineShow)
	end

	arg_17_0._animator.speed = 1

	gohelper.setActive(arg_17_0._gounlockeff, false)
	gohelper.setActive(arg_17_0._gounlockeff, true)

	if arg_17_0.missionId then
		local var_17_0 = VersionActivity1_8DungeonEnum.PlayerPrefsKey.IsPlayedMissionNodeUnlocked .. arg_17_0.missionId

		Activity157Model.instance:setHasPlayedAnim(var_17_0)
		Activity157Controller.instance:dispatchEvent(Activity157Event.Act157PlayMissionUnlockAnim)
	end
end

function var_0_0.everySecondCall(arg_18_0)
	arg_18_0:refreshTime()
end

function var_0_0.refresh(arg_19_0)
	arg_19_0:refreshStatus()
	arg_19_0:refreshTime()
	arg_19_0:refreshLine()
end

function var_0_0.refreshStatus(arg_20_0)
	local var_20_0
	local var_20_1 = Activity157Model.instance:getMissionStatus(arg_20_0.missionGroupId, arg_20_0.missionId)
	local var_20_2 = Activity157Enum.MissionStatusShowSetting[var_20_1]

	if type(var_20_2) == "table" then
		local var_20_3 = Activity157Config.instance:getMissionElementId(arg_20_0.actId, arg_20_0.missionId)
		local var_20_4 = var_20_3 and DungeonConfig.instance:getChapterMapElement(var_20_3)
		local var_20_5 = var_20_4 and var_20_4.type

		if var_20_1 == Activity157Enum.MissionStatus.Finish then
			var_20_0 = var_20_2.normal

			if var_20_5 == DungeonEnum.ElementType.None or var_20_5 == DungeonEnum.ElementType.Story then
				var_20_0 = var_20_2.story
			end
		elseif var_20_1 == Activity157Enum.MissionStatus.Normal then
			var_20_0 = var_20_2.normal

			if var_20_5 == DungeonEnum.ElementType.Fight then
				var_20_0 = var_20_2.fight
			end
		else
			logError("VersionActivity1_8FactoryMapNodeItem:refreshStatus error, no status icon, status:%s", var_20_1)
		end
	else
		var_20_0 = var_20_2
	end

	if var_20_0 then
		UISpriteSetMgr.instance:setV1a8FactorySprite(arg_20_0._imagestatus, var_20_0)
	end

	local var_20_6 = var_20_1 == Activity157Enum.MissionStatus.Dispatching

	gohelper.setActive(arg_20_0._gotimetips, var_20_6)
end

function var_0_0.refreshTime(arg_21_0)
	if not (Activity157Model.instance:getMissionStatus(arg_21_0.missionGroupId, arg_21_0.missionId) == Activity157Enum.MissionStatus.Dispatching) then
		return
	end

	local var_21_0 = Activity157Config.instance:getMissionElementId(arg_21_0.actId, arg_21_0.missionId)

	arg_21_0._txttime.text = DispatchModel.instance:getDispatchTime(var_21_0)
end

function var_0_0.refreshLine(arg_22_0)
	if not arg_22_0.missionGroupId or not arg_22_0.missionId then
		return
	end

	local var_22_0 = Activity157Model.instance:getMissionStatus(arg_22_0.missionGroupId, arg_22_0.missionId)

	gohelper.setActive(arg_22_0._goLineLock, var_22_0 == Activity157Enum.MissionStatus.Locked)

	if var_22_0 == Activity157Enum.MissionStatus.Normal or var_22_0 == Activity157Enum.MissionStatus.Dispatching or var_22_0 == Activity157Enum.MissionStatus.DispatchFinish then
		gohelper.setActive(arg_22_0._goLineUnlock, true)
	else
		gohelper.setActive(arg_22_0._goLineUnlock, false)
	end

	gohelper.setActive(arg_22_0._goLineFinish, var_22_0 == Activity157Enum.MissionStatus.Finish)

	local var_22_1 = Activity157Enum.MissionLineStatusIcon[var_22_0]

	if not var_22_1 then
		return
	end

	if arg_22_0._lineImagePoint1 then
		UISpriteSetMgr.instance:setV1a8FactorySprite(arg_22_0._lineImagePoint1, var_22_1.point, true)
	end

	if arg_22_0._lineImagePoint2 then
		UISpriteSetMgr.instance:setV1a8FactorySprite(arg_22_0._lineImagePoint2, var_22_1.point, true)
	end
end

function var_0_0.reset(arg_23_0, arg_23_1)
	TaskDispatcher.cancelTask(arg_23_0.playNodeUnlockAnimation, arg_23_0)

	if arg_23_1 then
		arg_23_0:playNodeAnimation("close", "close", "lock")
	end

	arg_23_0.missionId = nil
	arg_23_0.missionGroupId = nil
	arg_23_0.go.name = "nodeitem"
	arg_23_0._animator.speed = 1

	gohelper.setActive(arg_23_0.go, false)
	arg_23_0:destroyLine()
end

function var_0_0.destroyLine(arg_24_0)
	arg_24_0._lineAnimator = nil
	arg_24_0._lineImagePoint1 = nil
	arg_24_0._lineImagePoint2 = nil

	if not gohelper.isNil(arg_24_0.lineGo) then
		gohelper.destroy(arg_24_0.lineGo)
	end

	arg_24_0.lineGo = nil

	gohelper.setActive(arg_24_0._gounlockeff, false)
end

function var_0_0.destroy(arg_25_0)
	arg_25_0:removeEventListeners()
	arg_25_0:reset()
	gohelper.destroy(arg_25_0.go)
	arg_25_0:__onDispose()
end

return var_0_0
