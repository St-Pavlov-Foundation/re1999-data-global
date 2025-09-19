module("modules.logic.weekwalk.view.WeekWalkReviveView", package.seeall)

local var_0_0 = class("WeekWalkReviveView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._txtruledesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_ruledesc")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottomLeft/#btn_detail")
	arg_1_0._btnok = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_ok")
	arg_1_0._gocardlist = gohelper.findChild(arg_1_0.viewGO, "#go_cardlist")
	arg_1_0._gotemplate = gohelper.findChild(arg_1_0.viewGO, "#go_cardlist/#go_template")
	arg_1_0._gorecommendAttr = gohelper.findChild(arg_1_0.viewGO, "#go_recommendAttr")
	arg_1_0._goattritem = gohelper.findChild(arg_1_0.viewGO, "#go_recommendAttr/attrlist/#go_attritem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
	arg_2_0._btnok:AddClickListener(arg_2_0._btnokOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndetail:RemoveClickListener()
	arg_3_0._btnok:RemoveClickListener()
end

function var_0_0._btndetailOnClick(arg_4_0)
	EnemyInfoController.instance:openWeekWalkEnemyInfoView(arg_4_0._mapInfo.id)
end

function var_0_0._btnokOnClick(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0._heroItemList) do
		if iter_5_1._isSelected then
			table.insert(var_5_0, iter_5_1._mo.heroId)
		end
	end

	if #var_5_0 <= 0 then
		return
	end

	WeekwalkRpc.instance:sendSelectNotCdHeroRequest(var_5_0)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnSelectNotCdHeroReply, arg_6_0.closeThis, arg_6_0)
	arg_6_0._simagebg:LoadImage(ResUrl.getWeekWalkBg("full/bg_beijigntu.png"))
	gohelper.addUIClickAudio(arg_6_0._btnok.gameObject, AudioEnum.WeekWalk.play_artificial_ui_commonchoose)
	gohelper.addUIClickAudio(arg_6_0._btndetail.gameObject, AudioEnum.UI.play_ui_action_explore)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0._recommendCareer(arg_8_0)
	local var_8_0 = arg_8_0._mapInfo:getNoStarBattleInfo()

	if not var_8_0 then
		gohelper.setActive(arg_8_0._gorecommendAttr, false)

		return
	end

	local var_8_1 = var_8_0.battleId
	local var_8_2 = lua_battle.configDict[var_8_1]
	local var_8_3 = string.splitToNumber(var_8_2.monsterGroupIds, "#")
	local var_8_4, var_8_5 = FightHelper.getAttributeCounter(var_8_3)
	local var_8_6 = #var_8_4

	gohelper.setActive(arg_8_0._gorecommendAttr, var_8_6 > 0)

	if var_8_6 > 0 then
		for iter_8_0, iter_8_1 in ipairs(var_8_4) do
			local var_8_7 = "career_" .. iter_8_1
			local var_8_8 = gohelper.cloneInPlace(arg_8_0._goattritem)

			gohelper.setActive(var_8_8, true)

			local var_8_9 = gohelper.findChildImage(var_8_8, "icon")

			UISpriteSetMgr.instance:setHeroGroupSprite(var_8_9, var_8_7)
		end
	end
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._mapInfo = WeekWalkModel.instance:getCurMapInfo()
	arg_9_0._mapConfig = WeekWalkModel.instance:getCurMapConfig()
	arg_9_0._heroItemList = {}
	arg_9_0._txtruledesc.text = formatLuaLang("weekwalkreviveview_ruledesc", arg_9_0._mapConfig.notCdHeroCount)

	arg_9_0:_showHeroList()
	arg_9_0:_updateBtn()
	arg_9_0:_recommendCareer()

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		arg_9_0:_playBgm(AudioEnum.WeekWalk.play_artificial_layer_type_1)
	end
end

function var_0_0._playBgm(arg_10_0, arg_10_1)
	arg_10_0._bgmId = arg_10_1

	AudioMgr.instance:trigger(arg_10_0._bgmId)
end

function var_0_0._stopBgm(arg_11_0)
	if arg_11_0._bgmId then
		AudioMgr.instance:trigger(AudioEnum.WeekWalk.stop_sleepwalkingaudio)

		arg_11_0._bgmId = nil
	end
end

function var_0_0._showHeroList(arg_12_0)
	local var_12_0 = arg_12_0._mapInfo:getHeroInfoList()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		arg_12_0:_addHeroItem(iter_12_1)
	end
end

function var_0_0._addHeroItem(arg_13_0, arg_13_1)
	local var_13_0 = gohelper.cloneInPlace(arg_13_0._gotemplate)

	gohelper.setActive(var_13_0, true)

	local var_13_1 = gohelper.findChild(var_13_0, "go_retain")

	gohelper.setActive(var_13_1, false)

	local var_13_2 = gohelper.findChild(var_13_0, "hero")
	local var_13_3 = IconMgr.instance:getCommonHeroItem(var_13_2)
	local var_13_4 = arg_13_1.heroId
	local var_13_5 = HeroModel.instance:getByHeroId(var_13_4)

	var_13_3:setStyle_CharacterBackpack()
	var_13_3:onUpdateMO(var_13_5)
	var_13_3:addClickListener(arg_13_0._heroItemClick, arg_13_0)
	var_13_3:setDamage(true)
	var_13_3:setNewShow(false)
	var_13_3:setEffectVisible(false)
	var_13_3:setInjuryTxtVisible(false)

	local var_13_6 = arg_13_0:getUserDataTb_()

	var_13_6._mo = var_13_5
	var_13_6._isSelected = false
	var_13_6._heroItem = var_13_3
	var_13_6._retainGo = var_13_1
	arg_13_0._heroItemList[var_13_5] = var_13_6
end

function var_0_0._heroItemClick(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._heroItemList[arg_14_1]

	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_fight_choosecard)

	if not var_14_0._isSelected and arg_14_0._canRevive then
		GameFacade.showToast(ToastEnum.WeekWalkRevive)

		return
	end

	var_14_0._isSelected = not var_14_0._isSelected

	arg_14_0:_updateBtn()
end

function var_0_0._updateBtn(arg_15_0)
	local var_15_0 = 0
	local var_15_1 = 0

	for iter_15_0, iter_15_1 in pairs(arg_15_0._heroItemList) do
		var_15_1 = var_15_1 + 1

		if iter_15_1._isSelected then
			var_15_0 = var_15_0 + 1
		end
	end

	arg_15_0._canRevive = var_15_0 >= math.min(var_15_1, arg_15_0._mapConfig.notCdHeroCount)
	arg_15_0._btnok.button.interactable = arg_15_0._canRevive

	for iter_15_2, iter_15_3 in pairs(arg_15_0._heroItemList) do
		iter_15_3._heroItem:setSelect(false)

		if iter_15_3._isSelected then
			gohelper.setActive(iter_15_3._retainGo, true)
			iter_15_3._heroItem:setDamage(false)
			iter_15_3._heroItem:setInjuryTxtVisible(false)
			iter_15_3._heroItem:setSelect(true)
		else
			gohelper.setActive(iter_15_3._retainGo, false)
			iter_15_3._heroItem:setDamage(true)
			iter_15_3._heroItem:setInjuryTxtVisible(false)
		end
	end
end

function var_0_0.onClose(arg_16_0)
	arg_16_0:_stopBgm()
end

function var_0_0.onDestroyView(arg_17_0)
	arg_17_0._simagebg:UnLoadImage()
end

return var_0_0
