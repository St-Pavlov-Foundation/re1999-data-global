module("modules.logic.necrologiststory.game.v3a1.V3A1_RoleStoryGameBaseItem", package.seeall)

local var_0_0 = class("V3A1_RoleStoryGameBaseItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.transform = arg_1_1.transform

	recthelper.setAnchor(arg_1_0.transform, 0, 0)

	arg_1_0.goCanClick = gohelper.findChild(arg_1_0.go, "#clickable")
	arg_1_0.goTime = gohelper.findChild(arg_1_0.go, "time")
	arg_1_0.txtTime = gohelper.findChildTextMesh(arg_1_0.go, "time/#txt_time")
	arg_1_0.imgBuild = gohelper.findChildImage(arg_1_0.go, "#image_build")
	arg_1_0.goNormalName = gohelper.findChild(arg_1_0.go, "name/normal")
	arg_1_0.goBigBaseName = gohelper.findChild(arg_1_0.go, "name/bigBase")
	arg_1_0.storyItemList = {}
	arg_1_0.goProgress = gohelper.findChild(arg_1_0.go, "progress")
	arg_1_0.storyItemGO = gohelper.findChild(arg_1_0.go, "progress/item")

	gohelper.setActive(arg_1_0.storyItemGO, false)

	arg_1_0.btn = gohelper.findChildButtonWithAudio(arg_1_0.go, "click")
	arg_1_0.goCurrent = gohelper.findChild(arg_1_0.go, "#go_current")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btn, arg_2_0.onClickBtn, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btn)
end

function var_0_0.onClickBtn(arg_4_0)
	if not arg_4_0.baseConfig then
		return
	end

	if arg_4_0.gameBaseMO:getGameState() ~= NecrologistStoryEnum.GameState.Normal then
		return
	end

	local var_4_0 = arg_4_0.gameBaseMO:getCurBaseId()

	if var_4_0 == arg_4_0.baseConfig.id then
		local var_4_1, var_4_2 = arg_4_0:checkCanReadStory()

		if var_4_1 then
			NecrologistStoryController.instance:openStoryView(var_4_2, arg_4_0.gameBaseMO.id)
		elseif arg_4_0.baseConfig.type == NecrologistStoryEnum.BaseType.InteractiveBase then
			ViewMgr.instance:openView(ViewName.V3A1_RoleStoryTicketView, {
				roleStoryId = arg_4_0.gameBaseMO.id
			})
		else
			arg_4_0.gameBaseMO:tryFinishBase(arg_4_0.baseConfig.id)
		end

		return
	end

	if arg_4_0.gameBaseMO:isInEndBase() or not arg_4_0.gameBaseMO:isBaseFinish(var_4_0) then
		return
	end

	local var_4_3, var_4_4 = NecrologistStoryV3A1Config.instance:hasBaseConnection(var_4_0, arg_4_0.baseConfig.id)

	if var_4_3 then
		arg_4_0.gameBaseMO:addTime(var_4_4)
		arg_4_0.gameBaseMO:setCurBaseId(arg_4_0.baseConfig.id)
	end
end

function var_0_0.refreshView(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.baseConfig = arg_5_1
	arg_5_0.gameBaseMO = arg_5_2

	if not arg_5_1 then
		arg_5_0:setVisible(false)

		return
	end

	if not arg_5_0.gameBaseMO:isAreaUnlock(arg_5_0.baseConfig.areaId) then
		arg_5_0:setVisible(false)

		return
	end

	if not arg_5_0.gameBaseMO:isBaseAllStoryFinish(arg_5_0.baseConfig.preId, true) then
		arg_5_0:setVisible(false)

		return
	end

	arg_5_0:setVisible(true)
	arg_5_0:refreshName()
	arg_5_0:refreshTime()
	arg_5_0:refreshBuild()
	arg_5_0:refreshProgress()
	arg_5_0:refreshClickEnabel()
	arg_5_0:refreshCurrent()
end

function var_0_0.refreshCurrent(arg_6_0)
	local var_6_0 = false
	local var_6_1 = arg_6_0.gameBaseMO:getCurBaseId()

	if var_6_1 ~= arg_6_0.baseConfig.id and arg_6_0.baseConfig.unlockAreaId > 0 and not arg_6_0.gameBaseMO:isAreaUnlock(arg_6_0.baseConfig.unlockAreaId) then
		var_6_0 = true
	end

	if not var_6_0 then
		local var_6_2 = NecrologistStoryV3A1Config.instance:getDefaultBaseId()

		if var_6_1 == 401 and arg_6_0.baseConfig.id == var_6_2 then
			var_6_0 = true
		end
	end

	gohelper.setActive(arg_6_0.goCurrent, var_6_0)

	if var_6_0 then
		local var_6_3 = arg_6_0.isTimeShow and 118 or 72

		recthelper.setAnchorY(arg_6_0.goCurrent.transform, var_6_3)
	end
end

function var_0_0.setVisible(arg_7_0, arg_7_1)
	if arg_7_0.isVisible == arg_7_1 then
		return
	end

	arg_7_0.isVisible = arg_7_1

	gohelper.setActive(arg_7_0.go, arg_7_1)
end

function var_0_0.getIsVisible(arg_8_0)
	return arg_8_0.isVisible
end

function var_0_0.refreshClickEnabel(arg_9_0)
	local var_9_0 = arg_9_0:isCanClick()

	gohelper.setActive(arg_9_0.goCanClick, var_9_0)
end

function var_0_0.isCanClick(arg_10_0)
	if not arg_10_0.baseConfig then
		return false
	end

	if arg_10_0.gameBaseMO:getGameState() ~= NecrologistStoryEnum.GameState.Normal then
		return false
	end

	local var_10_0 = arg_10_0.gameBaseMO:getCurBaseId()

	if var_10_0 == arg_10_0.baseConfig.id then
		local var_10_1, var_10_2 = arg_10_0:checkCanReadStory()

		if var_10_1 then
			return true
		end

		if arg_10_0.baseConfig.type == NecrologistStoryEnum.BaseType.InteractiveBase then
			return true
		end

		if arg_10_0.gameBaseMO:isBaseCanFinish(var_10_0) then
			return true
		end
	end

	if arg_10_0.gameBaseMO:isInEndBase() or not arg_10_0.gameBaseMO:isBaseFinish(var_10_0) then
		return false
	end

	if NecrologistStoryV3A1Config.instance:hasBaseConnection(var_10_0, arg_10_0.baseConfig.id) then
		return true
	end
end

function var_0_0.refreshTime(arg_11_0)
	arg_11_0.isTimeShow = false

	local var_11_0 = arg_11_0.gameBaseMO:getCurBaseId()

	if var_11_0 == arg_11_0.baseConfig.id or arg_11_0.gameBaseMO:isInEndBase() or not arg_11_0.gameBaseMO:isBaseFinish(var_11_0) then
		gohelper.setActive(arg_11_0.goTime, false)

		return
	end

	local var_11_1, var_11_2 = NecrologistStoryV3A1Config.instance:hasBaseConnection(var_11_0, arg_11_0.baseConfig.id)

	if not var_11_1 or var_11_2 == 0 then
		gohelper.setActive(arg_11_0.goTime, false)

		return
	end

	arg_11_0.isTimeShow = true

	gohelper.setActive(arg_11_0.goTime, true)

	local var_11_3 = math.floor(var_11_2)
	local var_11_4 = math.floor((var_11_2 - var_11_3) * 60)

	if var_11_3 > 0 then
		if var_11_4 > 0 then
			if LangSettings.instance:isEn() then
				arg_11_0.txtTime.text = string.format("+%sh %sm", var_11_3, var_11_4)
			else
				arg_11_0.txtTime.text = string.format("+%sh%sm", var_11_3, var_11_4)
			end
		else
			arg_11_0.txtTime.text = string.format("+%sh", var_11_3)
		end
	else
		arg_11_0.txtTime.text = string.format("+%sm", var_11_4)
	end
end

function var_0_0.refreshName(arg_12_0)
	gohelper.setActive(arg_12_0.goNormalName, false)
	gohelper.setActive(arg_12_0.goBigBaseName, false)

	local var_12_0 = arg_12_0.baseConfig.type == NecrologistStoryEnum.BaseType.BigBase and arg_12_0.goBigBaseName or arg_12_0.goNormalName

	gohelper.setActive(var_12_0, true)

	gohelper.findChildTextMesh(var_12_0, "#txt_name").text = arg_12_0.baseConfig.name
end

function var_0_0.refreshBuild(arg_13_0)
	UISpriteSetMgr.instance:setRoleStorySprite(arg_13_0.imgBuild, arg_13_0.baseConfig.resource, true)
end

function var_0_0.refreshProgress(arg_14_0)
	if not arg_14_0.baseConfig then
		return
	end

	gohelper.setActive(arg_14_0.goProgress, true)

	local var_14_0 = NecrologistStoryV3A1Config.instance:getBaseStoryList(arg_14_0.baseConfig.id) or {}

	for iter_14_0 = 1, math.max(#var_14_0, #arg_14_0.storyItemList) do
		local var_14_1 = arg_14_0:getProgressItem(iter_14_0)

		arg_14_0:refreshProgressItem(var_14_1, var_14_0[iter_14_0])
	end
end

function var_0_0.getProgressItem(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.storyItemList[arg_15_1]

	if not var_15_0 then
		var_15_0 = arg_15_0:getUserDataTb_()
		var_15_0.index = arg_15_1
		var_15_0.go = gohelper.cloneInPlace(arg_15_0.storyItemGO, tostring(arg_15_1))
		var_15_0.goCurrent = gohelper.findChild(var_15_0.go, "current")
		var_15_0.goNormal = gohelper.findChild(var_15_0.go, "normal")
		var_15_0.goFinished = gohelper.findChild(var_15_0.go, "finished")
		var_15_0.anim = var_15_0.go:GetComponent(typeof(UnityEngine.Animator))
		arg_15_0.storyItemList[arg_15_1] = var_15_0
	end

	return var_15_0
end

function var_0_0.refreshProgressItem(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_2 then
		gohelper.setActive(arg_16_1.go, false)

		return
	end

	local var_16_0 = arg_16_0.gameBaseMO:getStoryState(arg_16_2)
	local var_16_1 = arg_16_1.lastState == NecrologistStoryEnum.StoryState.Lock and var_16_0 == NecrologistStoryEnum.StoryState.Normal

	arg_16_1.lastState = var_16_0

	if var_16_0 == NecrologistStoryEnum.StoryState.Lock then
		gohelper.setActive(arg_16_1.go, false)

		return
	end

	gohelper.setActive(arg_16_1.go, true)

	if var_16_1 then
		arg_16_1.anim:Play("open", 0, 0)
		arg_16_0:playProgressOpenAuido()
	else
		arg_16_1.anim:Play("idle", 0, 0)
	end

	local var_16_2 = var_16_0 == NecrologistStoryEnum.StoryState.Finish

	gohelper.setActive(arg_16_1.goFinished, var_16_2)
	gohelper.setActive(arg_16_1.goCurrent, false)
	gohelper.setActive(arg_16_1.goNormal, false)

	if not var_16_2 then
		if var_16_0 == NecrologistStoryEnum.StoryState.Reading then
			gohelper.setActive(arg_16_1.goCurrent, true)
		else
			gohelper.setActive(arg_16_1.goNormal, true)
		end
	end
end

function var_0_0.playProgressOpenAuido(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._playProgressOpenAudio, arg_17_0)
	TaskDispatcher.runDelay(arg_17_0._playProgressOpenAudio, arg_17_0, 0.7)
end

function var_0_0._playProgressOpenAudio(arg_18_0)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_gudu_bubble_click)
end

function var_0_0.checkCanReadStory(arg_19_0)
	local var_19_0 = NecrologistStoryV3A1Config.instance:getBaseStoryList(arg_19_0.baseConfig.id) or {}

	for iter_19_0 = 1, #var_19_0 do
		local var_19_1 = var_19_0[iter_19_0]
		local var_19_2 = arg_19_0.gameBaseMO:getStoryState(var_19_1)

		if var_19_2 == NecrologistStoryEnum.StoryState.Reading or var_19_2 == NecrologistStoryEnum.StoryState.Normal then
			return true, var_19_1
		end
	end

	return false
end

function var_0_0.onDestroy(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._playProgressOpenAudio, arg_20_0)
end

return var_0_0
