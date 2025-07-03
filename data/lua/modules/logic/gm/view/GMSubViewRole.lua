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

	arg_2_0._loginOpenMainThumbnail = arg_2_0:addToggle("L0", "登录打开缩略页")
	arg_2_0._loginOpenMainThumbnail.isOn = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewOpenMainThumbnail, 0) == 1

	arg_2_0._loginOpenMainThumbnail:AddOnValueChanged(arg_2_0._onMainThumbnailToggleChanged, arg_2_0)

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

function var_0_0._onMainThumbnailToggleChanged(arg_3_0)
	local var_3_0 = arg_3_0._loginOpenMainThumbnail.isOn and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewOpenMainThumbnail, var_3_0)
	GameFacade.showToast(2674, var_3_0 == 1 and "设置登录打开缩略页开启" or "设置登录打开缩略页关闭")
end

function var_0_0._onStopShowAllSkins(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._checkSkinAndVoice, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._checkWeekWalk_2Skin, arg_4_0)
end

function var_0_0._onClickShowWeekWalk_2AllSkins(arg_5_0)
	local var_5_0 = tonumber(arg_5_0._inpDuration:GetText()) or 1.5

	print(string.format("====开始播放,间隔为：%ss====", var_5_0))
	gohelper.setActive(arg_5_0._subViewGo, false)

	arg_5_0._index = 1
	arg_5_0._skinList = {}

	if not arg_5_0:_initInputSkins() then
		for iter_5_0, iter_5_1 in ipairs(lua_skin.configList) do
			if HeroConfig.instance:getHeroCO(iter_5_1.characterId) then
				table.insert(arg_5_0._skinList, iter_5_1)
			end
		end
	end

	arg_5_0._skinNum = #arg_5_0._skinList

	TaskDispatcher.cancelTask(arg_5_0._checkWeekWalk_2Skin, arg_5_0)
	TaskDispatcher.runRepeat(arg_5_0._checkWeekWalk_2Skin, arg_5_0, var_5_0)
end

function var_0_0._checkWeekWalk_2Skin(arg_6_0)
	if arg_6_0._index > arg_6_0._skinNum then
		print("====结束播放====")
		gohelper.setActive(arg_6_0._subViewGo, true)
		TaskDispatcher.cancelTask(arg_6_0._checkWeekWalk_2Skin, arg_6_0)

		return
	end

	local var_6_0 = arg_6_0._skinList[arg_6_0._index]

	print(string.format("==========================================auto showSkin %s skinId:%s progress:%s/%s", var_6_0.name, var_6_0.id, arg_6_0._index, arg_6_0._skinNum))

	arg_6_0._index = arg_6_0._index + 1

	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnShowSkin, var_6_0.id, true)
end

function var_0_0._onClickShowAllSkins(arg_7_0)
	local var_7_0 = tonumber(arg_7_0._inpDuration:GetText()) or 1.5

	print(string.format("====开始播放,间隔为：%ss====", var_7_0))
	gohelper.setActive(arg_7_0._subViewGo, false)

	arg_7_0._index = 1
	arg_7_0._skinList = {}

	if not arg_7_0:_initInputSkins() then
		for iter_7_0, iter_7_1 in ipairs(lua_skin.configList) do
			if HeroConfig.instance:getHeroCO(iter_7_1.characterId) then
				table.insert(arg_7_0._skinList, iter_7_1)
			end
		end
	end

	arg_7_0._skinNum = #arg_7_0._skinList

	TaskDispatcher.cancelTask(arg_7_0._checkSkinAndVoice, arg_7_0)
	TaskDispatcher.runRepeat(arg_7_0._checkSkinAndVoice, arg_7_0, var_7_0)
	arg_7_0:_showSkin()
end

function var_0_0._initInputSkins(arg_8_0)
	local var_8_0 = arg_8_0._inpSkins:GetText()

	if string.nilorempty(var_8_0) then
		return
	end

	local var_8_1 = string.splitToNumber(var_8_0, "#")

	if #var_8_1 == 1 then
		local var_8_2 = var_8_1[1]

		for iter_8_0, iter_8_1 in ipairs(lua_skin.configList) do
			if HeroConfig.instance:getHeroCO(iter_8_1.characterId) then
				table.insert(arg_8_0._skinList, iter_8_1)

				if iter_8_1.id == var_8_2 then
					arg_8_0._index = #arg_8_0._skinList
				end
			end
		end

		return true
	end

	for iter_8_2, iter_8_3 in ipairs(var_8_1) do
		local var_8_3 = lua_skin.configDict[iter_8_3]

		table.insert(arg_8_0._skinList, var_8_3)
	end

	return true
end

function var_0_0._showSkin(arg_9_0)
	local var_9_0 = arg_9_0._skinList[arg_9_0._index]

	print(string.format("==========================================auto showSkin %s skinId:%s progress:%s/%s", var_9_0.name, var_9_0.id, arg_9_0._index, arg_9_0._skinNum))

	arg_9_0._index = arg_9_0._index + 1

	MainController.instance:dispatchEvent(MainEvent.ChangeMainHeroSkin, var_9_0, true)

	arg_9_0._skinCo = var_9_0

	if arg_9_0._playVoiceToggle.isOn then
		arg_9_0._voiceList = arg_9_0:_getCharacterVoicesCO(var_9_0.characterId, var_9_0.id)
		arg_9_0._voiceLen = arg_9_0._voiceList and #arg_9_0._voiceList or 0
	end
end

function var_0_0._checkSkinAndVoice(arg_10_0)
	if arg_10_0:_checkPlayVoice() then
		return
	end

	arg_10_0:_checkShowSkin()
end

function var_0_0._checkShowSkin(arg_11_0)
	if arg_11_0._index > arg_11_0._skinNum then
		print("====结束播放====")
		gohelper.setActive(arg_11_0._subViewGo, true)
		TaskDispatcher.cancelTask(arg_11_0._checkSkinAndVoice, arg_11_0)

		return
	end

	arg_11_0:_showSkin()
end

function var_0_0._checkPlayVoice(arg_12_0)
	if not arg_12_0._voiceList or #arg_12_0._voiceList == 0 then
		return
	end

	local var_12_0 = table.remove(arg_12_0._voiceList, 1)

	print(string.format("======auto playVoice skinId:%s audio:%s name:%s progress:%s/%s", arg_12_0._skinCo.id, var_12_0.audio, var_12_0.name, arg_12_0._voiceLen - #arg_12_0._voiceList, arg_12_0._voiceLen))
	ViewMgr.instance:getContainer(ViewName.MainView):getMainHeroView():onlyPlayVoice(var_12_0)

	return true
end

function var_0_0._getCharacterVoicesCO(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = {}
	local var_13_1 = lua_character_voice.configDict[arg_13_1]

	if var_13_1 then
		for iter_13_0, iter_13_1 in pairs(var_13_1) do
			if CharacterDataConfig.instance:_checkSkin(iter_13_1, arg_13_2) then
				table.insert(var_13_0, iter_13_1)
			end
		end
	end

	return var_13_0
end

function var_0_0.onDestroyView(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._checkSkinAndVoice, arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._checkWeekWalk_2Skin, arg_14_0)
end

return var_0_0
