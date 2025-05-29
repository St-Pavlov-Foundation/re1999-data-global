﻿module("modules.logic.gm.view.GMSubViewRole", package.seeall)

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
	arg_2_0:addButton("L3", "梦游结算界面测试皮肤", arg_2_0._onClickShowWeekWalk_2AllSkins, arg_2_0)
end

function var_0_0._onStopShowAllSkins(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._checkSkinAndVoice, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._checkWeekWalk_2Skin, arg_3_0)
end

function var_0_0._onClickShowWeekWalk_2AllSkins(arg_4_0)
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

	TaskDispatcher.cancelTask(arg_4_0._checkWeekWalk_2Skin, arg_4_0)
	TaskDispatcher.runRepeat(arg_4_0._checkWeekWalk_2Skin, arg_4_0, var_4_0)
end

function var_0_0._checkWeekWalk_2Skin(arg_5_0)
	if arg_5_0._index > arg_5_0._skinNum then
		print("====结束播放====")
		gohelper.setActive(arg_5_0._subViewGo, true)
		TaskDispatcher.cancelTask(arg_5_0._checkWeekWalk_2Skin, arg_5_0)

		return
	end

	local var_5_0 = arg_5_0._skinList[arg_5_0._index]

	print(string.format("==========================================auto showSkin %s skinId:%s progress:%s/%s", var_5_0.name, var_5_0.id, arg_5_0._index, arg_5_0._skinNum))

	arg_5_0._index = arg_5_0._index + 1

	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnShowSkin, var_5_0.id, true)
end

function var_0_0._onClickShowAllSkins(arg_6_0)
	local var_6_0 = tonumber(arg_6_0._inpDuration:GetText()) or 1.5

	print(string.format("====开始播放,间隔为：%ss====", var_6_0))
	gohelper.setActive(arg_6_0._subViewGo, false)

	arg_6_0._index = 1
	arg_6_0._skinList = {}

	if not arg_6_0:_initInputSkins() then
		for iter_6_0, iter_6_1 in ipairs(lua_skin.configList) do
			if HeroConfig.instance:getHeroCO(iter_6_1.characterId) then
				table.insert(arg_6_0._skinList, iter_6_1)
			end
		end
	end

	arg_6_0._skinNum = #arg_6_0._skinList

	TaskDispatcher.cancelTask(arg_6_0._checkSkinAndVoice, arg_6_0)
	TaskDispatcher.runRepeat(arg_6_0._checkSkinAndVoice, arg_6_0, var_6_0)
	arg_6_0:_showSkin()
end

function var_0_0._initInputSkins(arg_7_0)
	local var_7_0 = arg_7_0._inpSkins:GetText()

	if string.nilorempty(var_7_0) then
		return
	end

	local var_7_1 = string.splitToNumber(var_7_0, "#")

	if #var_7_1 == 1 then
		local var_7_2 = var_7_1[1]

		for iter_7_0, iter_7_1 in ipairs(lua_skin.configList) do
			if HeroConfig.instance:getHeroCO(iter_7_1.characterId) then
				table.insert(arg_7_0._skinList, iter_7_1)

				if iter_7_1.id == var_7_2 then
					arg_7_0._index = #arg_7_0._skinList
				end
			end
		end

		return true
	end

	for iter_7_2, iter_7_3 in ipairs(var_7_1) do
		local var_7_3 = lua_skin.configDict[iter_7_3]

		table.insert(arg_7_0._skinList, var_7_3)
	end

	return true
end

function var_0_0._showSkin(arg_8_0)
	local var_8_0 = arg_8_0._skinList[arg_8_0._index]

	print(string.format("==========================================auto showSkin %s skinId:%s progress:%s/%s", var_8_0.name, var_8_0.id, arg_8_0._index, arg_8_0._skinNum))

	arg_8_0._index = arg_8_0._index + 1

	MainController.instance:dispatchEvent(MainEvent.ChangeMainHeroSkin, var_8_0, true)

	arg_8_0._skinCo = var_8_0

	if arg_8_0._playVoiceToggle.isOn then
		arg_8_0._voiceList = arg_8_0:_getCharacterVoicesCO(var_8_0.characterId, var_8_0.id)
		arg_8_0._voiceLen = arg_8_0._voiceList and #arg_8_0._voiceList or 0
	end
end

function var_0_0._checkSkinAndVoice(arg_9_0)
	if arg_9_0:_checkPlayVoice() then
		return
	end

	arg_9_0:_checkShowSkin()
end

function var_0_0._checkShowSkin(arg_10_0)
	if arg_10_0._index > arg_10_0._skinNum then
		print("====结束播放====")
		gohelper.setActive(arg_10_0._subViewGo, true)
		TaskDispatcher.cancelTask(arg_10_0._checkSkinAndVoice, arg_10_0)

		return
	end

	arg_10_0:_showSkin()
end

function var_0_0._checkPlayVoice(arg_11_0)
	if not arg_11_0._voiceList or #arg_11_0._voiceList == 0 then
		return
	end

	local var_11_0 = table.remove(arg_11_0._voiceList, 1)

	print(string.format("======auto playVoice skinId:%s audio:%s name:%s progress:%s/%s", arg_11_0._skinCo.id, var_11_0.audio, var_11_0.name, arg_11_0._voiceLen - #arg_11_0._voiceList, arg_11_0._voiceLen))
	ViewMgr.instance:getContainer(ViewName.MainView):getMainHeroView():onlyPlayVoice(var_11_0)

	return true
end

function var_0_0._getCharacterVoicesCO(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {}
	local var_12_1 = lua_character_voice.configDict[arg_12_1]

	if var_12_1 then
		for iter_12_0, iter_12_1 in pairs(var_12_1) do
			if CharacterDataConfig.instance:_checkSkin(iter_12_1, arg_12_2) then
				table.insert(var_12_0, iter_12_1)
			end
		end
	end

	return var_12_0
end

function var_0_0.onDestroyView(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._checkSkinAndVoice, arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._checkWeekWalk_2Skin, arg_13_0)
end

return var_0_0
