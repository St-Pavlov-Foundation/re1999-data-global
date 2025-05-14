module("modules.logic.gm.view.GMSubViewRole", package.seeall)

local var_0_0 = class("GMSubViewRole", GMSubViewBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.tabName = "角色"
end

function var_0_0.initViewContent(arg_2_0)
	if arg_2_0._inited then
		return
	end

	GMSubViewBase.initViewContent(arg_2_0)

	arg_2_0._inpDuration = arg_2_0:addInputText("L1", "", "刷新间隔", nil, nil, {
		w = 200
	})
	arg_2_0._inpSkins = arg_2_0:addInputText("L1", "", "皮肤id#皮肤id", nil, nil, {
		w = 600
	})

	arg_2_0:addButton("L1", "主界面测试皮肤", arg_2_0._onClickShowAllSkins, arg_2_0)

	arg_2_0._playVoiceToggle = arg_2_0:addToggle("L1", "播放语音")

	arg_2_0:addButton("L2", "停止测试皮肤", arg_2_0._onStopShowAllSkins, arg_2_0)
end

function var_0_0._onStopShowAllSkins(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._checkSkinAndVoice, arg_3_0)
end

function var_0_0._onClickShowAllSkins(arg_4_0)
	local var_4_0 = tonumber(arg_4_0._inpDuration:GetText()) or 1.5

	print(string.format("====开始播放,间隔为：%ss====", var_4_0))
	gohelper.setActive(arg_4_0._subViewGo, false)

	arg_4_0._index = 1
	arg_4_0._skinList = {}

	if not arg_4_0:_initInputSkins() then
		for iter_4_0, iter_4_1 in ipairs(lua_skin.configList) do
			if HeroConfig.instance:getHeroCO(iter_4_1.characterId) then
				table.insert(arg_4_0._skinList, iter_4_1)
			end
		end
	end

	arg_4_0._skinNum = #arg_4_0._skinList

	TaskDispatcher.cancelTask(arg_4_0._checkSkinAndVoice, arg_4_0)
	TaskDispatcher.runRepeat(arg_4_0._checkSkinAndVoice, arg_4_0, var_4_0)
	arg_4_0:_showSkin()
end

function var_0_0._initInputSkins(arg_5_0)
	local var_5_0 = arg_5_0._inpSkins:GetText()

	if string.nilorempty(var_5_0) then
		return
	end

	local var_5_1 = string.splitToNumber(var_5_0, "#")

	if #var_5_1 == 1 then
		local var_5_2 = var_5_1[1]

		for iter_5_0, iter_5_1 in ipairs(lua_skin.configList) do
			if HeroConfig.instance:getHeroCO(iter_5_1.characterId) then
				table.insert(arg_5_0._skinList, iter_5_1)

				if iter_5_1.id == var_5_2 then
					arg_5_0._index = #arg_5_0._skinList
				end
			end
		end

		return true
	end

	for iter_5_2, iter_5_3 in ipairs(var_5_1) do
		local var_5_3 = lua_skin.configDict[iter_5_3]

		table.insert(arg_5_0._skinList, var_5_3)
	end

	return true
end

function var_0_0._showSkin(arg_6_0)
	local var_6_0 = arg_6_0._skinList[arg_6_0._index]

	print(string.format("==========================================auto showSkin %s skinId:%s progress:%s/%s", var_6_0.name, var_6_0.id, arg_6_0._index, arg_6_0._skinNum))

	arg_6_0._index = arg_6_0._index + 1

	MainController.instance:dispatchEvent(MainEvent.ChangeMainHeroSkin, var_6_0, true)

	arg_6_0._skinCo = var_6_0

	if arg_6_0._playVoiceToggle.isOn then
		arg_6_0._voiceList = arg_6_0:_getCharacterVoicesCO(var_6_0.characterId, var_6_0.id)
		arg_6_0._voiceLen = arg_6_0._voiceList and #arg_6_0._voiceList or 0
	end
end

function var_0_0._checkSkinAndVoice(arg_7_0)
	if arg_7_0:_checkPlayVoice() then
		return
	end

	arg_7_0:_checkShowSkin()
end

function var_0_0._checkShowSkin(arg_8_0)
	if arg_8_0._index > arg_8_0._skinNum then
		print("====结束播放====")
		gohelper.setActive(arg_8_0._subViewGo, true)
		TaskDispatcher.cancelTask(arg_8_0._checkSkinAndVoice, arg_8_0)

		return
	end

	arg_8_0:_showSkin()
end

function var_0_0._checkPlayVoice(arg_9_0)
	if not arg_9_0._voiceList or #arg_9_0._voiceList == 0 then
		return
	end

	local var_9_0 = table.remove(arg_9_0._voiceList, 1)

	print(string.format("======auto playVoice skinId:%s audio:%s name:%s progress:%s/%s", arg_9_0._skinCo.id, var_9_0.audio, var_9_0.name, arg_9_0._voiceLen - #arg_9_0._voiceList, arg_9_0._voiceLen))
	ViewMgr.instance:getContainer(ViewName.MainView):getMainHeroView():onlyPlayVoice(var_9_0)

	return true
end

function var_0_0._getCharacterVoicesCO(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}
	local var_10_1 = lua_character_voice.configDict[arg_10_1]

	if var_10_1 then
		for iter_10_0, iter_10_1 in pairs(var_10_1) do
			if CharacterDataConfig.instance:_checkSkin(iter_10_1, arg_10_2) then
				table.insert(var_10_0, iter_10_1)
			end
		end
	end

	return var_10_0
end

function var_0_0.onDestroyView(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._checkSkinAndVoice, arg_11_0)
end

return var_0_0
