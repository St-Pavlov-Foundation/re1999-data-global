module("modules.spine.SpineVoiceText", package.seeall)

local var_0_0 = class("SpineVoiceText")

function var_0_0.onDestroy(arg_1_0)
	arg_1_0:removeTaskActions()

	arg_1_0._spineVoice = nil
	arg_1_0._voiceConfig = nil
	arg_1_0._txtContent = nil
	arg_1_0._txtEnContent = nil
	arg_1_0._showBg = nil
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	arg_2_0._spineVoice = arg_2_1
	arg_2_0._voiceConfig = arg_2_2
	arg_2_0._txtContent = arg_2_3
	arg_2_0._txtmarktop = IconMgr.instance:getCommonTextMarkTop(arg_2_0._txtContent.gameObject):GetComponent(gohelper.Type_TextMesh)
	arg_2_0._conMark = gohelper.onceAddComponent(arg_2_0._txtContent.gameObject, typeof(ZProj.TMPMark))

	arg_2_0._conMark:SetMarkTopGo(arg_2_0._txtmarktop.gameObject)
	arg_2_0._conMark:SetTopOffset(0, -2)

	arg_2_0._txtEnContent = arg_2_4
	arg_2_0._showBg = arg_2_5
	arg_2_0._hasAudio = AudioConfig.instance:getAudioCOById(arg_2_2.audio)

	local var_2_0 = GameLanguageMgr.instance:getLanguageTypeStoryIndex()

	arg_2_0._showEnContent = var_2_0 == LanguageEnum.LanguageStoryType.CN or var_2_0 == LanguageEnum.LanguageStoryType.TW

	if arg_2_0._txtContent then
		arg_2_0._contentStart = Time.time
		arg_2_0._contentList = {}

		arg_2_0:_initContent(arg_2_0._contentList, arg_2_0:getContent(arg_2_2))
	end

	if arg_2_0._txtEnContent then
		arg_2_0._enContentStart = Time.time
		arg_2_0._enContentList = {}

		arg_2_0:_initContent(arg_2_0._enContentList, arg_2_0:getContent(arg_2_2, LanguageEnum.LanguageStoryType.EN))
		gohelper.setActive(arg_2_0._txtEnContent.gameObject, arg_2_0._showEnContent)
	end

	if arg_2_0:_contentListEmpty() then
		arg_2_0._spineVoice:setBgVisible(false)
	end

	if not arg_2_0._voiceConfig.displayTime then
		return
	end

	TaskDispatcher.runRepeat(arg_2_0._showContent, arg_2_0, 0.1)
end

function var_0_0.getContent(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_2 or GameLanguageMgr.instance:getLanguageTypeStoryIndex()
	local var_3_1 = arg_3_0._spineVoice:getVoiceLang()
	local var_3_2 = GameLanguageMgr.instance:getStoryIndexByShortCut(var_3_1)

	return (SpineVoiceTextHelper.getSeparateContent(arg_3_1, var_3_0, var_3_2))
end

function var_0_0._showContent(arg_4_0)
	arg_4_0:_showOneLang(arg_4_0._contentList, arg_4_0._contentStart, arg_4_0._txtContent)
	arg_4_0:_showOneLang(arg_4_0._enContentList, arg_4_0._enContentStart, arg_4_0._txtEnContent)
	arg_4_0:_checkEnd()
end

function var_0_0._checkEnd(arg_5_0)
	if arg_5_0._hasAudio then
		return
	end

	if arg_5_0:_contentListEmpty() and arg_5_0._voiceConfig.displayTime > 0 then
		TaskDispatcher.cancelTask(arg_5_0._showContent, arg_5_0)
		TaskDispatcher.runDelay(arg_5_0._onEnd, arg_5_0, arg_5_0._voiceConfig.displayTime)
	end
end

function var_0_0._contentListEmpty(arg_6_0)
	return (not arg_6_0._contentList or #arg_6_0._contentList == 0) and (not arg_6_0._enContentList or #arg_6_0._enContentList == 0)
end

function var_0_0._onEnd(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._onEnd, arg_7_0)
	arg_7_0:onVoiceStop()
end

function var_0_0._showOneLang(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_1 then
		local var_8_0 = arg_8_1[1]

		if not var_8_0 then
			return
		end

		local var_8_1 = var_8_0[2] or 0

		if var_8_0 and not var_8_0[2] then
			logError("没有配置时间 audio:" .. arg_8_0._voiceConfig.audio)
		end

		if var_8_1 <= Time.time - arg_8_2 then
			local var_8_2 = var_8_0[1]

			arg_8_3.text = StoryTool.filterMarkTop(var_8_2)

			TaskDispatcher.runDelay(function()
				if not gohelper.isNil(arg_8_0._txtContent) and arg_8_0._txtContent.text ~= "" and arg_8_0._txtContent.name == arg_8_3.name then
					local var_9_0 = StoryTool.getMarkTopTextList(var_8_2)

					arg_8_0._conMark:SetMarksTop(var_9_0)
				end
			end, nil, 0.01)
			table.remove(arg_8_1, 1)
		end
	end
end

function var_0_0._initContent(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = string.split(arg_10_2, "|")

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if iter_10_1 ~= "" then
			local var_10_1 = string.split(iter_10_1, "#")

			var_10_1[2] = tonumber(var_10_1[2])

			table.insert(arg_10_1, var_10_1)
		end
	end
end

function var_0_0.removeTaskActions(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._showContent, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._onEnd, arg_11_0)
end

function var_0_0.onVoiceStop(arg_12_0)
	arg_12_0:removeTaskActions()

	if arg_12_0._showBg then
		return
	end

	if not gohelper.isNil(arg_12_0._txtContent) then
		arg_12_0._txtContent.text = ""

		arg_12_0._conMark:Destroy()
	end

	if not gohelper.isNil(arg_12_0._txtEnContent) then
		arg_12_0._txtEnContent.text = ""
	end

	if arg_12_0._spineVoice then
		arg_12_0._spineVoice:setBgVisible(false)
	end
end

return var_0_0
