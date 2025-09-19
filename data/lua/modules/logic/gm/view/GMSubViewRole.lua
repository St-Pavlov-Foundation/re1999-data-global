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
	arg_2_0:addButton("L4", "诺谛卡技能替换红点存储重置", arg_2_0._resetNuodiKaReplaceSkill, arg_2_0)

	arg_2_0._voiceId = arg_2_0:addInputText("L5", "", "主界面角色语音", nil, nil, {
		w = 500
	})

	arg_2_0:addButton("L5", "播放语音", arg_2_0._onClickPlayVoice, arg_2_0)
	arg_2_0:addTitleSplitLine("快速养成")
	arg_2_0:addButton("L6", "全角色获得", arg_2_0.onClickGetAllHero, arg_2_0)
	arg_2_0:addButton("L6", "全角色一键拉满（等级,共鸣，塑造）", arg_2_0.onClickUpgradeAllToMax, arg_2_0)
	arg_2_0:addButton("L7", "全角色升至最高等级", arg_2_0.onClickUpgradeMaxLevel, arg_2_0)
	arg_2_0:addButton("L7", "全角色升至最高共鸣", arg_2_0.onClickUpgradeMaxTalent, arg_2_0)
	arg_2_0:addButton("L7", "全角色升至最高塑造", arg_2_0.onClickUpgradeMaxExLevel, arg_2_0)
	arg_2_0:addButton("L8", "全满级心相获得（满等级，满增幅等级）", arg_2_0.onClickGetAllEquip, arg_2_0)
end

function var_0_0.onClickGetAllEquip(arg_3_0)
	GMRpc.instance:sendGMRequest("add equip 0#60#5")
end

function var_0_0.onClickUpgradeEquipAllToMax(arg_4_0)
	arg_4_0.upgradeEquipAllToMaxFlow = FlowSequence.New()

	arg_4_0.upgradeEquipAllToMaxFlow:addWork(GmUpgradeEquipAllToMax.New())
	arg_4_0.upgradeEquipAllToMaxFlow:start()
end

function var_0_0.onClickGetAllHero(arg_5_0)
	GMRpc.instance:sendGMRequest("add hero all 1")
end

function var_0_0.onClickUpgradeMaxLevel(arg_6_0)
	arg_6_0.upgradeMaxLevelFlow = FlowSequence.New()

	arg_6_0.upgradeMaxLevelFlow:addWork(GmUpgradeAllHeroToMaxLevel.New())
	arg_6_0.upgradeMaxLevelFlow:start()
end

function var_0_0.onClickUpgradeMaxTalent(arg_7_0)
	arg_7_0.upgradeMaxTalentFlow = FlowSequence.New()

	arg_7_0.upgradeMaxTalentFlow:addWork(GmUpgradeAllHeroToMaxTalent.New())
	arg_7_0.upgradeMaxTalentFlow:start()
end

function var_0_0.onClickUpgradeMaxExLevel(arg_8_0)
	arg_8_0.upgradeMaxExLevelFlow = FlowSequence.New()

	arg_8_0.upgradeMaxExLevelFlow:addWork(GmUpgradeAllHeroToMaxExLevel.New())
	arg_8_0.upgradeMaxExLevelFlow:start()
end

function var_0_0.onClickUpgradeAllToMax(arg_9_0)
	arg_9_0.upgradeAllToMaxFlow = FlowSequence.New()

	arg_9_0.upgradeAllToMaxFlow:addWork(GmUpgradeAllHeroAllToMax.New())
	arg_9_0.upgradeAllToMaxFlow:start()
end

function var_0_0._onClickPlayVoice(arg_10_0)
	arg_10_0:closeThis()

	local var_10_0 = tonumber(arg_10_0._voiceId:GetText())

	CharacterController.instance:dispatchEvent(CharacterEvent.MainHeroGmPlayVoice, var_10_0)
end

function var_0_0._onMainThumbnailToggleChanged(arg_11_0)
	local var_11_0 = arg_11_0._loginOpenMainThumbnail.isOn and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewOpenMainThumbnail, var_11_0)
	GameFacade.showToast(2674, var_11_0 == 1 and "设置登录打开缩略页开启" or "设置登录打开缩略页关闭")
end

function var_0_0._onStopShowAllSkins(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._checkSkinAndVoice, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._checkWeekWalk_2Skin, arg_12_0)
end

function var_0_0._onClickShowWeekWalk_2AllSkins(arg_13_0)
	local var_13_0 = tonumber(arg_13_0._inpDuration:GetText()) or 1.5

	print(string.format("====开始播放,间隔为：%ss====", var_13_0))
	gohelper.setActive(arg_13_0._subViewGo, false)

	arg_13_0._index = 1
	arg_13_0._skinList = {}

	if not arg_13_0:_initInputSkins() then
		for iter_13_0, iter_13_1 in ipairs(lua_skin.configList) do
			if HeroConfig.instance:getHeroCO(iter_13_1.characterId) then
				table.insert(arg_13_0._skinList, iter_13_1)
			end
		end
	end

	arg_13_0._skinNum = #arg_13_0._skinList

	TaskDispatcher.cancelTask(arg_13_0._checkWeekWalk_2Skin, arg_13_0)
	TaskDispatcher.runRepeat(arg_13_0._checkWeekWalk_2Skin, arg_13_0, var_13_0)
end

function var_0_0._checkWeekWalk_2Skin(arg_14_0)
	if arg_14_0._index > arg_14_0._skinNum then
		print("====结束播放====")
		gohelper.setActive(arg_14_0._subViewGo, true)
		TaskDispatcher.cancelTask(arg_14_0._checkWeekWalk_2Skin, arg_14_0)

		return
	end

	local var_14_0 = arg_14_0._skinList[arg_14_0._index]

	print(string.format("==========================================auto showSkin %s skinId:%s progress:%s/%s", var_14_0.name, var_14_0.id, arg_14_0._index, arg_14_0._skinNum))

	arg_14_0._index = arg_14_0._index + 1

	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnShowSkin, var_14_0.id, true)
end

function var_0_0._onClickShowAllSkins(arg_15_0)
	local var_15_0 = tonumber(arg_15_0._inpDuration:GetText()) or 1.5

	print(string.format("====开始播放,间隔为：%ss====", var_15_0))
	gohelper.setActive(arg_15_0._subViewGo, false)

	arg_15_0._index = 1
	arg_15_0._skinList = {}

	if not arg_15_0:_initInputSkins() then
		for iter_15_0, iter_15_1 in ipairs(lua_skin.configList) do
			if HeroConfig.instance:getHeroCO(iter_15_1.characterId) then
				table.insert(arg_15_0._skinList, iter_15_1)
			end
		end
	end

	arg_15_0._skinNum = #arg_15_0._skinList

	TaskDispatcher.cancelTask(arg_15_0._checkSkinAndVoice, arg_15_0)
	TaskDispatcher.runRepeat(arg_15_0._checkSkinAndVoice, arg_15_0, var_15_0)
	arg_15_0:_showSkin()
end

function var_0_0._initInputSkins(arg_16_0)
	local var_16_0 = arg_16_0._inpSkins:GetText()

	if string.nilorempty(var_16_0) then
		return
	end

	local var_16_1 = string.splitToNumber(var_16_0, "#")

	if #var_16_1 == 1 then
		local var_16_2 = var_16_1[1]

		for iter_16_0, iter_16_1 in ipairs(lua_skin.configList) do
			if HeroConfig.instance:getHeroCO(iter_16_1.characterId) then
				table.insert(arg_16_0._skinList, iter_16_1)

				if iter_16_1.id == var_16_2 then
					arg_16_0._index = #arg_16_0._skinList
				end
			end
		end

		return true
	end

	for iter_16_2, iter_16_3 in ipairs(var_16_1) do
		local var_16_3 = lua_skin.configDict[iter_16_3]

		table.insert(arg_16_0._skinList, var_16_3)
	end

	return true
end

function var_0_0._showSkin(arg_17_0)
	local var_17_0 = arg_17_0._skinList[arg_17_0._index]

	print(string.format("==========================================auto showSkin %s skinId:%s progress:%s/%s", var_17_0.name, var_17_0.id, arg_17_0._index, arg_17_0._skinNum))

	arg_17_0._index = arg_17_0._index + 1

	MainController.instance:dispatchEvent(MainEvent.ChangeMainHeroSkin, var_17_0, true)

	arg_17_0._skinCo = var_17_0

	if arg_17_0._playVoiceToggle.isOn then
		arg_17_0._voiceList = arg_17_0:_getCharacterVoicesCO(var_17_0.characterId, var_17_0.id)
		arg_17_0._voiceLen = arg_17_0._voiceList and #arg_17_0._voiceList or 0
	end
end

function var_0_0._checkSkinAndVoice(arg_18_0)
	if arg_18_0:_checkPlayVoice() then
		return
	end

	arg_18_0:_checkShowSkin()
end

function var_0_0._checkShowSkin(arg_19_0)
	if arg_19_0._index > arg_19_0._skinNum then
		print("====结束播放====")
		gohelper.setActive(arg_19_0._subViewGo, true)
		TaskDispatcher.cancelTask(arg_19_0._checkSkinAndVoice, arg_19_0)

		return
	end

	arg_19_0:_showSkin()
end

function var_0_0._checkPlayVoice(arg_20_0)
	if not arg_20_0._voiceList or #arg_20_0._voiceList == 0 then
		return
	end

	local var_20_0 = table.remove(arg_20_0._voiceList, 1)

	print(string.format("======auto playVoice skinId:%s audio:%s name:%s progress:%s/%s", arg_20_0._skinCo.id, var_20_0.audio, var_20_0.name, arg_20_0._voiceLen - #arg_20_0._voiceList, arg_20_0._voiceLen))
	ViewMgr.instance:getContainer(ViewName.MainView):getMainHeroView():onlyPlayVoice(var_20_0)

	return true
end

function var_0_0._getCharacterVoicesCO(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = {}
	local var_21_1 = lua_character_voice.configDict[arg_21_1]

	if var_21_1 then
		for iter_21_0, iter_21_1 in pairs(var_21_1) do
			if CharacterDataConfig.instance:_checkSkin(iter_21_1, arg_21_2) then
				table.insert(var_21_0, iter_21_1)
			end
		end
	end

	return var_21_0
end

function var_0_0._resetNuodiKaReplaceSkill(arg_22_0)
	local var_22_0 = 3120

	PlayerModel.instance:setPropKeyValue(PlayerEnum.SimpleProperty.NuoDiKaNewSkill, var_22_0, 0)

	local var_22_1 = PlayerModel.instance:getPropKeyValueString(PlayerEnum.SimpleProperty.NuoDiKaNewSkill)

	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.NuoDiKaNewSkill, var_22_1)
	GameUtil.playerPrefsSetNumberByUserId(CharacterModel.AnimKey_ReplaceSkillPlay .. var_22_0, 0)
end

function var_0_0.onDestroyView(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._checkSkinAndVoice, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._checkWeekWalk_2Skin, arg_23_0)

	if arg_23_0.upgradeMaxLevelFlow then
		arg_23_0.upgradeMaxLevelFlow:destroy()

		arg_23_0.upgradeMaxLevelFlow = nil
	end

	if arg_23_0.upgradeMaxTalentFlow then
		arg_23_0.upgradeMaxTalentFlow:destroy()

		arg_23_0.upgradeMaxTalentFlow = nil
	end

	if arg_23_0.upgradeMaxExLevelFlow then
		arg_23_0.upgradeMaxExLevelFlow:destroy()

		arg_23_0.upgradeMaxExLevelFlow = nil
	end

	if arg_23_0.upgradeAllToMaxFlow then
		arg_23_0.upgradeAllToMaxFlow:destroy()

		arg_23_0.upgradeAllToMaxFlow = nil
	end
end

return var_0_0
