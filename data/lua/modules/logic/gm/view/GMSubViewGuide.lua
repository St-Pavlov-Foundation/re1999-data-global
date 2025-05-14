module("modules.logic.gm.view.GMSubViewGuide", package.seeall)

local var_0_0 = class("GMSubViewGuide", GMSubViewBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.tabName = "指引"
end

function var_0_0.initViewContent(arg_2_0)
	if arg_2_0._inited then
		return
	end

	GMSubViewBase.initViewContent(arg_2_0)
	arg_2_0:addTitleSplitLine("指引调试")
	arg_2_0:addLabel("L1", "指引：")

	arg_2_0._inpGuide = arg_2_0:addInputText("L1", "", "[guide[#step]]")

	arg_2_0:addButton("L1", "开始", arg_2_0._onClickGuideStart, arg_2_0)
	arg_2_0:addButton("L1", "完成", arg_2_0._onClickGuideFinish, arg_2_0)
	arg_2_0:addButton("L1", "重置", arg_2_0._onClickGuideReset, arg_2_0)
	arg_2_0:addButton("L2", "指引状态", arg_2_0._onClickGuideStatus, arg_2_0)
	arg_2_0:addButton("L2", "指引屏蔽", arg_2_0._onClickGuideForbid, arg_2_0)
	arg_2_0:addButton("L2", "引导图预览", arg_2_0._onClickHelpViewBrowse, arg_2_0)
	arg_2_0:addButton("L2", "清空战斗指引记录", arg_2_0._clearFightGuide, arg_2_0)
	arg_2_0:addTitleSplitLine("指引编辑")
	arg_2_0:addButton("L3", "打开指引编辑器", arg_2_0._onClickGuideEditor, arg_2_0)
	arg_2_0:addWikiButton("L3", "http://doc.sl.com/pages/viewpage.action?pageId=31851464")
	arg_2_0._inpGuide:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewGuide, ""))
end

function var_0_0._clearFightGuide(arg_3_0)
	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.FightTechnique, "")
	ToastController.instance:showToastWithString("清空成功，重启生效")
end

function var_0_0._onClickGuideStatus(arg_4_0)
	arg_4_0:closeThis()
	ViewMgr.instance:openView(ViewName.GMGuideStatusView)
end

function var_0_0._onClickGuideForbid(arg_5_0)
	local var_5_0 = GuideController.instance:isForbidGuides()

	GuideController.instance:forbidGuides(not var_5_0)
end

function var_0_0._onClickGuideStart(arg_6_0)
	arg_6_0:closeThis()

	local var_6_0 = arg_6_0._inpGuide:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewGuide, var_6_0)

	local var_6_1 = string.splitToNumber(var_6_0, "#")
	local var_6_2 = tonumber(var_6_1[1])
	local var_6_3 = tonumber(var_6_1[2]) or 0

	print(string.format("input guideId:%s,guideStep:%s", var_6_2, var_6_3))

	local var_6_4 = GuideModel.instance:getById(var_6_2)

	GuideModel.instance:gmStartGuide(var_6_2, var_6_3)

	if var_6_4 then
		GuideStepController.instance:clearFlow(var_6_2)

		var_6_4.isJumpPass = false

		GMRpc.instance:sendGMRequest("delete guide " .. var_6_2)

		;({}).guideInfos = {
			{
				guideId = var_6_2,
				stepId = var_6_3
			}
		}

		GuideRpc.instance:sendFinishGuideRequest(var_6_2, var_6_3)
		logNormal(string.format("<color=#FFA500>set guideId:%s,guideStep:%s</color>", var_6_2, var_6_3))
	elseif var_6_2 then
		GuideController.instance:startGudie(var_6_2)
		logNormal("<color=#FFA500>start guide " .. var_6_2 .. "</color>")
	end
end

function var_0_0._onClickGuideFinish(arg_7_0)
	local var_7_0 = arg_7_0._inpGuide:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewGuide, var_7_0)

	if not string.nilorempty(var_7_0) then
		local var_7_1 = tonumber(var_7_0)

		if var_7_1 then
			local var_7_2 = GuideModel.instance:getById(var_7_1)

			arg_7_0:closeThis()
			logNormal("GM one key finish guide " .. var_7_1)

			local var_7_3 = GuideConfig.instance:getStepList(var_7_1)

			for iter_7_0 = #var_7_3, 1, -1 do
				local var_7_4 = var_7_3[iter_7_0]

				if var_7_4.keyStep == 1 then
					GuideRpc.instance:sendFinishGuideRequest(var_7_1, var_7_4.stepId)

					break
				end
			end
		else
			local var_7_5 = string.split(var_7_0, "#")

			logNormal("GM one key finish guide " .. var_7_0)
			GuideRpc.instance:sendFinishGuideRequest(tonumber(var_7_5[1]), tonumber(var_7_5[2]))
		end
	else
		logNormal("GM one key finish guides")
		GuideStepController.instance:clearStep()
		GuideController.instance:oneKeyFinishGuides()
	end
end

function var_0_0._onClickGuideReset(arg_8_0)
	local var_8_0 = arg_8_0._inpGuide:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewGuide, var_8_0)

	local var_8_1 = string.splitToNumber(var_8_0, "#")
	local var_8_2 = tonumber(var_8_1[1])
	local var_8_3 = GuideConfig.instance:getGuideCO(var_8_2)

	if var_8_3 then
		print(string.format("reset guideId:%s", var_8_2))
		GuideStepController.instance:clearFlow(var_8_2)
		GMRpc.instance:sendGMRequest("delete guide " .. var_8_2)

		local var_8_4 = string.split(var_8_3.trigger, "#")
		local var_8_5 = var_8_4[1]

		arg_8_0:_resetEpisode(var_8_4[1], var_8_4[2])

		local var_8_6 = GameUtil.splitString2(var_8_3.invalid, false, "|", "#")

		if not var_8_6 then
			return
		end

		for iter_8_0, iter_8_1 in ipairs(var_8_6) do
			-- block empty
		end
	end
end

function var_0_0._resetEpisode(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == "EpisodeFinish" or arg_9_1 == "EnterEpisode" then
		arg_9_0:_doResetEpisode(tonumber(arg_9_2))

		return
	end

	local var_9_0 = lua_open.configDict[tonumber(arg_9_2)]

	if var_9_0 then
		arg_9_0:_doResetEpisode(var_9_0.episodeId)
	end
end

function var_0_0._doResetEpisode(arg_10_0, arg_10_1)
	local var_10_0 = lua_episode.configDict[arg_10_1]

	if not var_10_0 then
		return
	end

	GMRpc.instance:sendGMRequest(string.format("set dungeon %s 0", arg_10_1))

	if var_10_0.beforeStory > 0 then
		print(arg_10_1 .. " delete beforeStory")
		GMRpc.instance:sendGMRequest(string.format("delete story %s", var_10_0.beforeStory))
	end

	if var_10_0.afterStory > 0 then
		print(arg_10_1 .. " delete afterStory")
		GMRpc.instance:sendGMRequest(string.format("delete story %s", var_10_0.afterStory))
	end
end

function var_0_0._onClickGuideEditor(arg_11_0)
	arg_11_0:closeThis()
	ViewMgr.instance:openView(ViewName.GuideStepEditor)
end

function var_0_0._onClickHelpViewBrowse(arg_12_0)
	arg_12_0:closeThis()
	ViewMgr.instance:openView(ViewName.GMHelpViewBrowseView)
end

return var_0_0
