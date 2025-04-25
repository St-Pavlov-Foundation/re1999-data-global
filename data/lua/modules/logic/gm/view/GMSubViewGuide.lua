module("modules.logic.gm.view.GMSubViewGuide", package.seeall)

slot0 = class("GMSubViewGuide", GMSubViewBase)

function slot0.ctor(slot0)
	slot0.tabName = "指引"
end

function slot0.initViewContent(slot0)
	if slot0._inited then
		return
	end

	GMSubViewBase.initViewContent(slot0)
	slot0:addTitleSplitLine("指引调试")
	slot0:addLabel("L1", "指引：")

	slot0._inpGuide = slot0:addInputText("L1", "", "[guide[#step]]")

	slot0:addButton("L1", "开始", slot0._onClickGuideStart, slot0)
	slot0:addButton("L1", "完成", slot0._onClickGuideFinish, slot0)
	slot0:addButton("L1", "重置", slot0._onClickGuideReset, slot0)
	slot0:addButton("L2", "指引状态", slot0._onClickGuideStatus, slot0)
	slot0:addButton("L2", "指引屏蔽", slot0._onClickGuideForbid, slot0)
	slot0:addButton("L2", "引导图预览", slot0._onClickHelpViewBrowse, slot0)
	slot0:addButton("L2", "清空战斗指引记录", slot0._clearFightGuide, slot0)
	slot0:addTitleSplitLine("指引编辑")
	slot0:addButton("L3", "打开指引编辑器", slot0._onClickGuideEditor, slot0)
	slot0:addWikiButton("L3", "http://doc.sl.com/pages/viewpage.action?pageId=31851464")
	slot0._inpGuide:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewGuide, ""))
end

function slot0._clearFightGuide(slot0)
	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.FightTechnique, "")
	ToastController.instance:showToastWithString("清空成功，重启生效")
end

function slot0._onClickGuideStatus(slot0)
	slot0:closeThis()
	ViewMgr.instance:openView(ViewName.GMGuideStatusView)
end

function slot0._onClickGuideForbid(slot0)
	GuideController.instance:forbidGuides(not GuideController.instance:isForbidGuides())
end

function slot0._onClickGuideStart(slot0)
	slot0:closeThis()

	slot1 = slot0._inpGuide:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewGuide, slot1)

	slot2 = string.splitToNumber(slot1, "#")
	slot3 = tonumber(slot2[1])
	slot4 = tonumber(slot2[2]) or 0

	print(string.format("input guideId:%s,guideStep:%s", slot3, slot4))
	GuideModel.instance:gmStartGuide(slot3, slot4)

	if GuideModel.instance:getById(slot3) then
		GuideStepController.instance:clearFlow(slot3)

		slot5.isJumpPass = false

		GMRpc.instance:sendGMRequest("delete guide " .. slot3)

		slot6 = {
			guideInfos = {
				{
					guideId = slot3,
					stepId = slot4
				}
			}
		}

		GuideRpc.instance:sendFinishGuideRequest(slot3, slot4)
		logNormal(string.format("<color=#FFA500>set guideId:%s,guideStep:%s</color>", slot3, slot4))
	elseif slot3 then
		GuideController.instance:startGudie(slot3)
		logNormal("<color=#FFA500>start guide " .. slot3 .. "</color>")
	end
end

function slot0._onClickGuideFinish(slot0)
	slot1 = slot0._inpGuide:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewGuide, slot1)

	if not string.nilorempty(slot1) then
		if tonumber(slot1) then
			slot3 = GuideModel.instance:getById(slot2)

			slot0:closeThis()
			logNormal("GM one key finish guide " .. slot2)

			for slot8 = #GuideConfig.instance:getStepList(slot2), 1, -1 do
				if slot4[slot8].keyStep == 1 then
					GuideRpc.instance:sendFinishGuideRequest(slot2, slot9.stepId)

					break
				end
			end
		else
			slot3 = string.split(slot1, "#")

			logNormal("GM one key finish guide " .. slot1)
			GuideRpc.instance:sendFinishGuideRequest(tonumber(slot3[1]), tonumber(slot3[2]))
		end
	else
		logNormal("GM one key finish guides")
		GuideStepController.instance:clearStep()
		GuideController.instance:oneKeyFinishGuides()
	end
end

function slot0._onClickGuideReset(slot0)
	slot1 = slot0._inpGuide:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewGuide, slot1)

	if GuideConfig.instance:getGuideCO(tonumber(string.splitToNumber(slot1, "#")[1])) then
		print(string.format("reset guideId:%s", slot3))
		GuideStepController.instance:clearFlow(slot3)
		GMRpc.instance:sendGMRequest("delete guide " .. slot3)

		slot5 = string.split(slot4.trigger, "#")
		slot6 = slot5[1]

		slot0:_resetEpisode(slot5[1], slot5[2])

		if not GameUtil.splitString2(slot4.invalid, false, "|", "#") then
			return
		end

		for slot11, slot12 in ipairs(slot7) do
			-- Nothing
		end
	end
end

function slot0._resetEpisode(slot0, slot1, slot2)
	if slot1 == "EpisodeFinish" or slot1 == "EnterEpisode" then
		slot0:_doResetEpisode(tonumber(slot2))

		return
	end

	if lua_open.configDict[tonumber(slot2)] then
		slot0:_doResetEpisode(slot3.episodeId)
	end
end

function slot0._doResetEpisode(slot0, slot1)
	if not lua_episode.configDict[slot1] then
		return
	end

	GMRpc.instance:sendGMRequest(string.format("set dungeon %s 0", slot1))

	if slot2.beforeStory > 0 then
		print(slot1 .. " delete beforeStory")
		GMRpc.instance:sendGMRequest(string.format("delete story %s", slot2.beforeStory))
	end

	if slot2.afterStory > 0 then
		print(slot1 .. " delete afterStory")
		GMRpc.instance:sendGMRequest(string.format("delete story %s", slot2.afterStory))
	end
end

function slot0._onClickGuideEditor(slot0)
	slot0:closeThis()
	ViewMgr.instance:openView(ViewName.GuideStepEditor)
end

function slot0._onClickHelpViewBrowse(slot0)
	slot0:closeThis()
	ViewMgr.instance:openView(ViewName.GMHelpViewBrowseView)
end

return slot0
