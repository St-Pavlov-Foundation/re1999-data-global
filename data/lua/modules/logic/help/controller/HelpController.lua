module("modules.logic.help.controller.HelpController", package.seeall)

local var_0_0 = class("HelpController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.canShowFirstHelp(arg_4_0, arg_4_1)
	if ViewMgr.instance._openViewNameSet[ViewName.SkinOffsetAdjustView] then
		return
	end

	if GuideModel.instance:isDoingClickGuide() then
		return
	end

	if not GuideController.instance:isForbidGuides() then
		if GuideModel.instance:getDoingGuideId() then
			return
		end

		if arg_4_1 == HelpEnum.HelpId.Dungeon and DungeonModel.instance:hasPassLevel(10115) then
			return
		end
	end

	if HelpModel.instance:isShowedHelp(arg_4_1) then
		return
	end

	if not arg_4_0:checkGuideStepLock(arg_4_1) then
		return
	end

	return true
end

function var_0_0.tryShowFirstHelp(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0:canShowFirstHelp(arg_5_1) then
		return
	end

	arg_5_0:showHelp(arg_5_1, true)
end

function var_0_0.showHelp(arg_6_0, arg_6_1, arg_6_2)
	ViewMgr.instance:openView(ViewName.HelpView, {
		id = arg_6_1,
		auto = arg_6_2
	})
end

function var_0_0.checkGuideStepLock(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return false
	end

	local var_7_0 = HelpConfig.instance:getHelpCO(arg_7_1)

	if not var_7_0 then
		logError("please check help config, not found help Config!, help id is " .. arg_7_1)
	end

	local var_7_1 = string.splitToNumber(var_7_0.page, "#")
	local var_7_2 = false

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_3 = HelpConfig.instance:getHelpPageCo(iter_7_1)

		if arg_7_0:canShowPage(var_7_3) then
			var_7_2 = true

			break
		end
	end

	return var_7_2
end

function var_0_0.canShowPage(arg_8_0, arg_8_1)
	return arg_8_1.unlockGuideId == 0 or GuideModel.instance:isGuideFinish(arg_8_1.unlockGuideId)
end

function var_0_0.canShowVideo(arg_9_0, arg_9_1)
	return arg_9_1.unlockGuideId == 0 or GuideModel.instance:isGuideFinish(arg_9_1.unlockGuideId)
end

function var_0_0.openStoreTipView(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {
		desc = arg_10_1,
		title = arg_10_2
	}

	ViewMgr.instance:openView(ViewName.StoreTipView, var_10_0)
end

function var_0_0.openBpRuleTipsView(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = {
		title = arg_11_1,
		titleEn = arg_11_2,
		ruleDesc = arg_11_3
	}

	ViewMgr.instance:openView(ViewName.BpRuleTipsView, var_11_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
