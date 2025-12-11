module("modules.logic.story.view.StoryHeroView", package.seeall)

local var_0_0 = class("StoryHeroView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorolebg = gohelper.findChild(arg_1_0.viewGO, "#go_rolebg")
	arg_1_0._goroles = gohelper.findChild(arg_1_0.viewGO, "#go_roles")

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

function var_0_0._addEvent(arg_4_0)
	arg_4_0:addEventCb(StoryController.instance, StoryEvent.RefreshHero, arg_4_0._onUpdateHero, arg_4_0)
	arg_4_0:addEventCb(StoryController.instance, StoryEvent.RefreshView, arg_4_0._refreshView, arg_4_0)
	arg_4_0:addEventCb(StoryController.instance, StoryEvent.AllStepFinished, arg_4_0._storyFinished, arg_4_0)
	arg_4_0:addEventCb(StoryController.instance, StoryEvent.Finish, arg_4_0._clearItems, arg_4_0)
end

function var_0_0._removeEvent(arg_5_0)
	arg_5_0:removeEventCb(StoryController.instance, StoryEvent.RefreshHero, arg_5_0._onUpdateHero, arg_5_0)
	arg_5_0:removeEventCb(StoryController.instance, StoryEvent.RefreshView, arg_5_0._refreshView, arg_5_0)
	arg_5_0:removeEventCb(StoryController.instance, StoryEvent.AllStepFinished, arg_5_0._storyFinished, arg_5_0)
	arg_5_0:removeEventCb(StoryController.instance, StoryEvent.Finish, arg_5_0._clearItems, arg_5_0)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._blitEff = arg_6_0._gorolebg:GetComponent(typeof(UrpCustom.UIBlitEffect))
	arg_6_0._heros = {}

	arg_6_0:_loadRes()
end

local var_0_1 = "spine/spine_ui_default.mat"
local var_0_2 = "spine/spine_ui_dark.mat"

function var_0_0._loadRes(arg_7_0)
	arg_7_0._matLoader = MultiAbLoader.New()

	arg_7_0._matLoader:addPath(var_0_1)
	arg_7_0._matLoader:addPath(var_0_2)
	arg_7_0._matLoader:startLoad(arg_7_0._onResLoaded, arg_7_0)
end

function var_0_0._onResLoaded(arg_8_0)
	local var_8_0 = arg_8_0._matLoader:getAssetItem(var_0_1)

	if var_8_0 then
		arg_8_0._normalMat = var_8_0:GetResource(var_0_1)
	else
		logError("Resource is not found at path : " .. var_0_1)
	end

	local var_8_1 = arg_8_0._matLoader:getAssetItem(var_0_2)

	if var_8_1 then
		arg_8_0._darkMat = var_8_1:GetResource(var_0_2)
	else
		logError("Resource is not found at path : " .. var_0_2)
	end

	arg_8_0:_resetHeroMat()
end

function var_0_0._resetHeroMat(arg_9_0)
	if not arg_9_0._heroCo then
		return
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_0._heroCo) do
		local var_9_0 = arg_9_0:_isHeroDark(iter_9_0) and arg_9_0._darkMat or arg_9_0._normalMat

		if arg_9_0._heros[iter_9_1.heroIndex] then
			local var_9_1 = StoryModel.instance:hasBottomEffect()

			arg_9_0._heros[iter_9_1.heroIndex]:setHeroMat(var_9_0, var_9_1)
		end
	end
end

function var_0_0._isHeroDark(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._stepCo.conversation.showList) do
		if iter_10_1 == arg_10_1 - 1 then
			return false
		end
	end

	return true
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:_addEvent()
end

function var_0_0.onClose(arg_13_0)
	arg_13_0:_removeEvent()
end

function var_0_0._onUpdateHero(arg_14_0, arg_14_1)
	if #arg_14_1.branches > 0 then
		StoryController.instance:openStoryBranchView(arg_14_1.branches)
	end

	if arg_14_1.stepType ~= StoryEnum.StepType.Normal then
		for iter_14_0, iter_14_1 in pairs(arg_14_0._heros) do
			iter_14_1:stopVoice()
		end

		return
	end

	arg_14_0._stepCo = StoryStepModel.instance:getStepListById(arg_14_1.stepId)

	if arg_14_0._stepCo.bg.transType ~= StoryEnum.BgTransType.DarkFade and arg_14_0._stepCo.bg.transType ~= StoryEnum.BgTransType.WhiteFade then
		arg_14_0:_updateHeroList(arg_14_0._stepCo.heroList)
	end
end

function var_0_0._refreshView(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._playShowHero, arg_15_0)
	arg_15_0:_updateHeroList(arg_15_0._stepCo.heroList)
end

function var_0_0._storyFinished(arg_16_0)
	if not StoryController.instance._hideStartAndEndDark then
		return
	end

	arg_16_0:_updateHeroList({})
end

function var_0_0._updateHeroList(arg_17_0, arg_17_1)
	local var_17_0 = false
	local var_17_1 = false
	local var_17_2 = false

	arg_17_0._blitEff:SetKeepCapture(true)

	if arg_17_0._heroCo then
		if #arg_17_0._heroCo == 0 and #arg_17_1 == 0 then
			var_17_1 = false
			var_17_0 = false
		else
			local var_17_3 = false

			for iter_17_0, iter_17_1 in pairs(arg_17_1) do
				for iter_17_2, iter_17_3 in pairs(arg_17_0._heroCo) do
					if iter_17_3.heroIndex == iter_17_1.heroIndex then
						var_17_3 = true

						break
					end
				end
			end

			if var_17_3 then
				var_17_1 = false
				var_17_0 = false
			else
				var_17_1 = true
				var_17_0 = true
			end
		end
	else
		var_17_0 = false
		var_17_1 = true
		arg_17_0._heroCo = {}
	end

	if arg_17_0._preStepTransBg then
		arg_17_0._preStepTransBg = false
		var_17_0 = true
		var_17_1 = true
	else
		local var_17_4 = StoryModel.instance:getPreSteps(arg_17_0._stepCo.id)

		if var_17_4 and #var_17_4 > 0 then
			local var_17_5 = StoryStepModel.instance:getStepListById(var_17_4[1])
			local var_17_6 = var_17_5 and var_17_5.bg
			local var_17_7 = arg_17_0._stepCo.bg

			if var_17_6 and var_17_7 and (var_17_7.offset[1] ~= var_17_6.offset[1] or var_17_7.offset[2] ~= var_17_6.offset[2]) then
				arg_17_0._preStepTransBg = true
			end
		end
	end

	for iter_17_4, iter_17_5 in pairs(arg_17_0._heroCo) do
		local var_17_8 = true

		for iter_17_6, iter_17_7 in pairs(arg_17_1) do
			if iter_17_7.heroIndex == iter_17_5.heroIndex then
				var_17_8 = false

				break
			end
		end

		if var_17_8 then
			var_17_2 = true
		end
	end

	arg_17_0._heroCo = arg_17_1

	local var_17_9 = {}

	for iter_17_8, iter_17_9 in pairs(arg_17_0._heros) do
		local var_17_10 = false

		for iter_17_10, iter_17_11 in pairs(arg_17_0._heroCo) do
			if iter_17_11.heroIndex == iter_17_8 then
				var_17_10 = true
			end
		end

		if not var_17_10 then
			iter_17_9:hideHero()
			table.insert(var_17_9, iter_17_8)
		end
	end

	for iter_17_12, iter_17_13 in pairs(var_17_9) do
		arg_17_0._heros[iter_17_13] = nil
	end

	if var_17_0 then
		StoryModel.instance:enableClick(false)

		if var_17_2 then
			TaskDispatcher.runDelay(arg_17_0._playShowHero, arg_17_0, 1)
		else
			TaskDispatcher.runDelay(arg_17_0._playShowHero, arg_17_0, 0.5)
		end
	elseif var_17_2 then
		StoryModel.instance:enableClick(false)
		TaskDispatcher.runDelay(arg_17_0._playShowHero, arg_17_0, 0.5)
	else
		arg_17_0:_playShowHero()
	end

	StoryModel.instance:setNeedFadeIn(var_17_1)
	StoryModel.instance:setNeedFadeOut(var_17_0)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshConversation)
end

function var_0_0._playShowHero(arg_18_0)
	local var_18_0 = false
	local var_18_1 = arg_18_0._stepCo.conversation.audios[1] or 0

	for iter_18_0, iter_18_1 in pairs(arg_18_0._heroCo) do
		local var_18_2 = arg_18_0:_isHeroDark(iter_18_0) and arg_18_0._darkMat or arg_18_0._normalMat
		local var_18_3 = StoryModel.instance:hasBottomEffect()

		if not arg_18_0._heros[iter_18_1.heroIndex] then
			var_18_0 = true

			local var_18_4 = StoryHeroItem.New()

			arg_18_0._heros[iter_18_1.heroIndex] = var_18_4

			var_18_4:init(arg_18_0._goroles, iter_18_1)
			var_18_4:buildHero(iter_18_1, var_18_2, var_18_3, arg_18_0._onEnableClick, arg_18_0, var_18_1)
		else
			arg_18_0._heros[iter_18_1.heroIndex]:resetHero(iter_18_1, var_18_2, var_18_3, var_18_1)
		end
	end

	if not var_18_0 then
		local var_18_5 = StoryModel.instance:getCurStepId()

		if StoryStepModel.instance:getStepListById(var_18_5).conversation.type ~= StoryEnum.ConversationType.IrregularShake then
			StoryModel.instance:enableClick(true)
		end
	end
end

function var_0_0._onEnableClick(arg_19_0)
	if StoryModel.instance:isTextShowing() then
		return
	end

	StoryModel.instance:enableClick(true)
end

function var_0_0._clearItems(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0._heros) do
		iter_20_1:onDestroy()
	end

	arg_20_0._heros = {}
end

function var_0_0.onDestroyView(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._playShowHero, arg_21_0)
	ViewMgr.instance:closeView(ViewName.StoryView, true)
	ViewMgr.instance:closeView(ViewName.StoryLeadRoleSpineView, true)
	arg_21_0:_clearItems()
	arg_21_0._blitEff:SetKeepCapture(false)

	if arg_21_0._matLoader then
		arg_21_0._matLoader:dispose()

		arg_21_0._matLoader = nil
	end
end

return var_0_0
