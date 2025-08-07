module("modules.logic.sp01.assassin2.outside.view.AssassinHeroView", package.seeall)

local var_0_0 = class("AssassinHeroView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gopick = gohelper.findChild(arg_1_0.viewGO, "root/#go_pick")
	arg_1_0._txtpicktitle = gohelper.findChildText(arg_1_0.viewGO, "root/#go_pick/txt_pick")
	arg_1_0._goheroContent = gohelper.findChild(arg_1_0.viewGO, "root/left/#scroll_hero/Viewport/Content")
	arg_1_0._goheroItem = gohelper.findChild(arg_1_0.viewGO, "root/left/#scroll_hero/Viewport/Content/#go_heroItem")
	arg_1_0._txtnamecn = gohelper.findChildText(arg_1_0.viewGO, "root/heroInfo/#txt_namecn")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "root/heroInfo/#txt_namecn/#txt_nameen")
	arg_1_0._imagecareericon = gohelper.findChildImage(arg_1_0.viewGO, "root/heroInfo/#image_careericon")
	arg_1_0._simagehero = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/heroInfo/Mask/#simage_hero")
	arg_1_0._goequipcontainer = gohelper.findChild(arg_1_0.viewGO, "root/heroInfo/#go_equipcontainer")
	arg_1_0._simageequipicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/heroInfo/#go_equipcontainer/#simage_equipicon")
	arg_1_0._txtequiplv = gohelper.findChildText(arg_1_0.viewGO, "root/heroInfo/#go_equipcontainer/#txt_lv")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/right/#go_assassinCareer/#go_assassinEquip/#simage_icon")
	arg_1_0._goswitch = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_assassinCareer/#go_assassinEquip/#switch_equip")
	arg_1_0._txtEquipName = gohelper.findChildText(arg_1_0.viewGO, "root/right/#go_assassinCareer/#go_assassinEquip/#txt_name")
	arg_1_0._txtcareer = gohelper.findChildText(arg_1_0.viewGO, "root/right/#go_assassinCareer/#go_assassinEquip/career/#txt_career")
	arg_1_0._goattrLayout = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_assassinCareer/#go_assassinEquip/#go_attrLayout")
	arg_1_0._goattrItem = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_assassinCareer/#go_assassinEquip/#go_attrLayout/#go_attrItem")
	arg_1_0._gochange = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_assassinCareer/#go_assassinEquip/#go_change")
	arg_1_0._btnchange = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "root/right/#go_assassinCareer/#go_assassinEquip/#go_change/#btn_change", AudioEnum2_9.StealthGame.play_ui_cikeshang_skillopen)
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "root/right/#go_assassinCareer/#go_assassinSkill/ScrollView/Viewport/#txt_desc")
	arg_1_0._goitemLayout = gohelper.findChild(arg_1_0.viewGO, "root/right/Layout/#go_itemLayout")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "root/right/Layout/#go_itemLayout/#go_item")
	arg_1_0._goenterGame = gohelper.findChild(arg_1_0.viewGO, "root/right/Layout/#go_enterGame")
	arg_1_0._goAble = gohelper.findChild(arg_1_0.viewGO, "root/right/Layout/#go_enterGame/#go_Able")
	arg_1_0._btnenter1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/Layout/#go_enterGame/#go_Able/#btn_enter", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._txtenter1 = gohelper.findChildText(arg_1_0.viewGO, "root/right/Layout/#go_enterGame/#go_Able/#btn_enter/txt_Enter")
	arg_1_0._txtpick1 = gohelper.findChildText(arg_1_0.viewGO, "root/right/Layout/#go_enterGame/#go_Able/#txt_pick")
	arg_1_0._goDisAble = gohelper.findChild(arg_1_0.viewGO, "root/right/Layout/#go_enterGame/#go_DisAble")
	arg_1_0._btnenter2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/Layout/#go_enterGame/#go_DisAble/#btn_enter", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._txtenter2 = gohelper.findChildText(arg_1_0.viewGO, "root/right/Layout/#go_enterGame/#go_DisAble/#btn_enter/txt_Enter")
	arg_1_0._txtpick2 = gohelper.findChildText(arg_1_0.viewGO, "root/right/Layout/#go_enterGame/#go_DisAble/#txt_pick")
	arg_1_0._btnInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/heroInfo/#btn_Info", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnInfo:AddClickListener(arg_2_0._btnInfoOnClick, arg_2_0)
	arg_2_0._btnchange:AddClickListener(arg_2_0._btnchangeOnClick, arg_2_0)
	arg_2_0._btnenter1:AddClickListener(arg_2_0._btnenterOnClick, arg_2_0)
	arg_2_0._btnenter2:AddClickListener(arg_2_0._btnenterOnClick, arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._btnequipOnClick, arg_2_0)
	arg_2_0._animEventWrap:AddEventListener("changeHero", arg_2_0._onChangeHero, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.OnChangeAssassinHeroCareer, arg_2_0._onChangeAssassinHeroCareer, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.OnChangeEquippedItem, arg_2_0._onChangeEquippedItem, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.OnUnlockQuestContent, arg_2_0._onUnlockQuestContent, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnStartDungeonExtraParams, arg_2_0.onEnterFightSetParams, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_2_0.onOpenViewFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnInfo:RemoveClickListener()
	arg_3_0._btnchange:RemoveClickListener()
	arg_3_0._btnenter1:RemoveClickListener()
	arg_3_0._btnenter2:RemoveClickListener()
	arg_3_0._btnequip:RemoveClickListener()
	arg_3_0._animEventWrap:RemoveAllEventListener()

	if arg_3_0._heroItemList then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0._heroItemList) do
			iter_3_1.btnClick:RemoveClickListener()
		end
	end

	if arg_3_0._itemGridList then
		for iter_3_2, iter_3_3 in ipairs(arg_3_0._itemGridList) do
			iter_3_3.btnClick:RemoveClickListener()
		end
	end

	arg_3_0:removeEventCb(AssassinController.instance, AssassinEvent.OnChangeAssassinHeroCareer, arg_3_0._onChangeAssassinHeroCareer, arg_3_0)
	arg_3_0:removeEventCb(AssassinController.instance, AssassinEvent.OnChangeEquippedItem, arg_3_0._onChangeEquippedItem, arg_3_0)
	arg_3_0:removeEventCb(AssassinController.instance, AssassinEvent.OnUnlockQuestContent, arg_3_0._onUnlockQuestContent, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnStartDungeonExtraParams, arg_3_0.onEnterFightSetParams, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_3_0.onOpenViewFinish, arg_3_0)
end

function var_0_0._btnInfoOnClick(arg_4_0)
	local var_4_0 = arg_4_0:getCurShowAssassinHeroId()

	AssassinController.instance:openHeroStatsView({
		assassinHeroId = var_4_0
	})
end

function var_0_0._btnchangeOnClick(arg_5_0)
	local var_5_0 = arg_5_0:getCurShowAssassinHeroId()

	if not AssassinConfig.instance:isAssassinHeroHasSecondCareer(var_5_0) then
		return
	end

	AssassinController.instance:openAssassinEquipView({
		assassinHeroId = var_5_0
	})
end

function var_0_0._btnenterOnClick(arg_6_0)
	if not arg_6_0._questId then
		return
	end

	if arg_6_0._isFightQuest then
		AssassinController.instance:enterQuestFight(arg_6_0._questId)
		arg_6_0:saveHeroCache()
	else
		if AssassinStealthGameModel.instance:getPickHeroCount() < arg_6_0.needHeroCount then
			return
		end

		AssassinHelper.lockScreen(AssassinEnum.BlockKey.EnterStealthGameEff, true)
		arg_6_0._animatorPlayer:Play("to_game", arg_6_0._enterAssassinStealthGame, arg_6_0)
		AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_movestart)
		arg_6_0:saveHeroCache()
	end
end

function var_0_0._enterAssassinStealthGame(arg_7_0)
	AssassinStealthGameController.instance:startStealthGame(arg_7_0._questId)
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.EnterStealthGameEff, false)
end

function var_0_0._btnHeroItemOnClick(arg_8_0, arg_8_1)
	arg_8_0:_selectHero(arg_8_1, true)
end

function var_0_0._selectHero(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getAssassinHeroId(arg_9_1)

	if not AssassinHeroModel.instance:isUnlockAssassinHero(var_9_0) then
		return
	end

	if AssassinStealthGameController.instance:pickAssassinHeroItemInHeroView(arg_9_0._questId, var_9_0, arg_9_0._isFightQuest) then
		local var_9_1 = arg_9_2 and arg_9_0._curShowIndex ~= arg_9_1

		arg_9_0._curShowIndex = arg_9_1

		if var_9_1 then
			arg_9_0._animatorPlayer:Play("switch")
		else
			arg_9_0:refresh()
		end
	end
end

function var_0_0._btnItemOnClick(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getCurShowAssassinHeroId()
	local var_10_1 = AssassinHeroModel.instance:getAssassinCareerId(var_10_0)

	if arg_10_1 > AssassinConfig.instance:getAssassinCareerCapacity(var_10_1) then
		return
	end

	AssassinController.instance:openAssassinBackpackView({
		assassinHeroId = var_10_0,
		carryIndex = arg_10_1
	})
end

function var_0_0._btnequipOnClick(arg_11_0)
	local var_11_0 = arg_11_0:getCurShowAssassinHeroId()
	local var_11_1 = AssassinHeroModel.instance:getHeroMo(var_11_0)
	local var_11_2 = AssassinHeroModel.instance:getAssassinHeroEquipMo(var_11_0)
	local var_11_3 = {
		heroMo = var_11_1,
		equipMo = var_11_2,
		fromView = EquipEnum.FromViewEnum.FromAssassinHeroView
	}

	EquipController.instance:openEquipInfoTeamView(var_11_3)
end

function var_0_0._onChangeHero(arg_12_0)
	arg_12_0:refresh()
end

function var_0_0._onChangeAssassinHeroCareer(arg_13_0)
	arg_13_0:refreshCareerEquipInfo(true)
	arg_13_0:refreshItemGridList()
end

function var_0_0._onChangeEquippedItem(arg_14_0)
	arg_14_0:refreshItemGridList()
end

function var_0_0._onUnlockQuestContent(arg_15_0)
	arg_15_0:refreshHeroItemIsUnlocked()
	arg_15_0:refreshHeroItemSelected()
end

function var_0_0.onEnterFightSetParams(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0._isFightQuest then
		return
	end

	if arg_16_2 and arg_16_2.type == DungeonEnum.EpisodeType.Assassin2Outside then
		local var_16_0 = AssassinOutsideModel.instance:getEnterFightQuest()

		arg_16_1.params = tostring(var_16_0)
	end
end

function var_0_0.onOpenViewFinish(arg_17_0, arg_17_1)
	if arg_17_1 == ViewName.AssassinStealthGameView then
		arg_17_0:closeThis()
	end
end

local var_0_1 = 1

function var_0_0._editableInitView(arg_18_0)
	arg_18_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_18_0.viewGO)
	arg_18_0._animEventWrap = arg_18_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	arg_18_0._btnequip = gohelper.getClick(arg_18_0._goequipcontainer)
	arg_18_0._goranks = arg_18_0:getUserDataTb_()

	for iter_18_0 = 1, 3 do
		arg_18_0._goranks[iter_18_0] = gohelper.findChild(arg_18_0.viewGO, "root/heroInfo/level/rankobj/rank" .. iter_18_0)
	end

	arg_18_0._txtherolv = gohelper.findChildText(arg_18_0.viewGO, "root/heroInfo/level/lv/lvltxt")
	arg_18_0._goexskill = gohelper.findChild(arg_18_0.viewGO, "root/heroInfo/#go_exskill")
	arg_18_0._imageexskill = gohelper.findChildImage(arg_18_0.viewGO, "root/heroInfo/#go_exskill/#image_exskill")

	AssassinStealthGameModel.instance:clearPickHeroData()
	gohelper.setActive(arg_18_0._goswitch, false)
end

function var_0_0.onUpdateParam(arg_19_0)
	arg_19_0._questId = arg_19_0.viewParam and arg_19_0.viewParam.questId

	if arg_19_0._questId then
		arg_19_0._isFightQuest = AssassinConfig.instance:getQuestType(arg_19_0._questId) == AssassinEnum.QuestType.Fight
		arg_19_0._recommendHeroList = AssassinConfig.instance:getQuestRecommendHeroList(arg_19_0._questId)

		if arg_19_0._isFightQuest then
			local var_19_0 = AssassinConfig.instance:getQuestParam(arg_19_0._questId)
			local var_19_1 = tonumber(var_19_0)
			local var_19_2 = var_19_1 and lua_episode.configDict[var_19_1]
			local var_19_3 = var_19_2 and lua_battle.configDict[var_19_2.battleId]

			arg_19_0.needHeroCount = var_19_3 and var_19_3.playerMax or ModuleEnum.HeroCountInGroup
		else
			local var_19_4 = AssassinConfig.instance:getQuestParam(arg_19_0._questId)

			arg_19_0.needHeroCount = AssassinConfig.instance:getStealthMapNeedHeroCount(tonumber(var_19_4))
		end
	end
end

function var_0_0.onOpen(arg_20_0)
	arg_20_0:onUpdateParam()
	arg_20_0:initBagItemGrid()
	arg_20_0:initAssassinHeroList()
	arg_20_0:checkIsPickMode()
	arg_20_0:_selectHero(var_0_1)
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_training)
end

function var_0_0.initBagItemGrid(arg_21_0)
	arg_21_0._itemGridList = {}

	local var_21_0 = {}
	local var_21_1 = AssassinConfig.instance:getAssassinConst(AssassinEnum.ConstId.MaxBagCapacity, true)

	for iter_21_0 = 1, var_21_1 do
		var_21_0[iter_21_0] = {
			index = iter_21_0
		}
	end

	gohelper.CreateObjList(arg_21_0, arg_21_0._onCreateItemGrid, var_21_0, arg_21_0._goitemLayout, arg_21_0._goitem)
end

function var_0_0._onCreateItemGrid(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = arg_22_0:getUserDataTb_()

	var_22_0.go = arg_22_1
	var_22_0.index = arg_22_2
	var_22_0.golocked = gohelper.findChild(var_22_0.go, "#go_locked")
	var_22_0.gounlocked = gohelper.findChild(var_22_0.go, "#go_unlocked")
	var_22_0.goaddIcon = gohelper.findChild(var_22_0.go, "#go_unlocked/#go_addIcon")
	var_22_0.imageitem = gohelper.findChildImage(var_22_0.go, "#go_unlocked/#simage_item")
	var_22_0.goitemicon = var_22_0.imageitem.gameObject
	var_22_0.txtnum = gohelper.findChildText(var_22_0.go, "#go_unlocked/#simage_item/#txt_num")
	var_22_0.goswitch = gohelper.findChild(var_22_0.go, "#go_unlocked/#switch_item")
	var_22_0.btnClick = gohelper.findChildClickWithAudio(var_22_0.go, "#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	var_22_0.btnClick:AddClickListener(arg_22_0._btnItemOnClick, arg_22_0, arg_22_3)
	gohelper.setActive(var_22_0.golocked, true)
	gohelper.setActive(var_22_0.gounlocked, false)
	gohelper.setActive(var_22_0.goswitch, false)

	arg_22_0._itemGridList[arg_22_3] = var_22_0
end

function var_0_0.initAssassinHeroList(arg_23_0)
	arg_23_0._heroItemList = {}

	local var_23_0 = AssassinHeroModel.instance:getAssassinHeroIdList()

	gohelper.CreateObjList(arg_23_0, arg_23_0._onCreateAssassinHeroItem, var_23_0, arg_23_0._goheroContent, arg_23_0._goheroItem)
end

function var_0_0._onCreateAssassinHeroItem(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_0:getUserDataTb_()

	var_24_0.go = arg_24_1
	var_24_0.id = arg_24_2
	var_24_0.gounselected = gohelper.findChild(var_24_0.go, "#go_unselected")
	var_24_0.goframe1 = gohelper.findChild(var_24_0.go, "#go_unselected/#go_frame")
	var_24_0.gonormalFrame1 = gohelper.findChild(var_24_0.go, "#go_unselected/#go_frame/#go_normalFrame")
	var_24_0.gorequiredFrame1 = gohelper.findChild(var_24_0.go, "#go_unselected/#go_frame/#go_requiredFrame")
	var_24_0.simageheroIcon1 = gohelper.findChildSingleImage(var_24_0.go, "#go_unselected/#simage_heroIcon")
	var_24_0.txtindex1 = gohelper.findChildText(var_24_0.go, "#go_unselected/#txt_index")
	var_24_0.goRecommand1 = gohelper.findChild(var_24_0.go, "#go_unselected/#go_Recommand")
	var_24_0.goselected = gohelper.findChild(var_24_0.go, "#go_selected")
	var_24_0.goframe2 = gohelper.findChild(var_24_0.go, "#go_selected/#go_frame")
	var_24_0.gonormalFrame2 = gohelper.findChild(var_24_0.go, "#go_selected/#go_frame/#go_normalFrame")
	var_24_0.gorequiredFrame2 = gohelper.findChild(var_24_0.go, "#go_selected/#go_frame/#go_requiredFrame")
	var_24_0.simageheroIcon2 = gohelper.findChildSingleImage(var_24_0.go, "#go_selected/#simage_heroIcon")
	var_24_0.txtindex2 = gohelper.findChildText(var_24_0.go, "#go_selected/#txt_index")
	var_24_0.goRecommand2 = gohelper.findChild(var_24_0.go, "#go_selected/#go_Recommand")
	var_24_0.golocked = gohelper.findChild(var_24_0.go, "#go_locked")
	var_24_0.simageheroIcon3 = gohelper.findChildSingleImage(var_24_0.go, "#go_locked/#simage_heroIcon")
	var_24_0.btnClick = gohelper.findChildClickWithAudio(var_24_0.go, "#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_herochoose)

	var_24_0.btnClick:AddClickListener(arg_24_0._btnHeroItemOnClick, arg_24_0, arg_24_3)

	local var_24_1 = AssassinConfig.instance:getAssassinHeroIcon(var_24_0.id)

	if not string.nilorempty(var_24_1) then
		local var_24_2 = ResUrl.getSp01AssassinSingleBg("hero/headicon/" .. var_24_1)

		var_24_0.simageheroIcon1:LoadImage(var_24_2)
		var_24_0.simageheroIcon2:LoadImage(var_24_2)
		var_24_0.simageheroIcon3:LoadImage(var_24_2)
	end

	if AssassinHeroModel.instance:isRequiredAssassin(var_24_0.id) then
		AssassinStealthGameController.instance:pickAssassinHeroItemInHeroView(arg_24_0._questId, var_24_0.id, arg_24_0._isFightQuest)
	end

	gohelper.setActive(var_24_0.gorequiredFrame1, false)
	gohelper.setActive(var_24_0.gorequiredFrame2, false)
	gohelper.setActive(var_24_0.gonormalFrame1, false)
	gohelper.setActive(var_24_0.gonormalFrame2, false)
	gohelper.setActive(var_24_0.gounselected, false)
	gohelper.setActive(var_24_0.goselected, false)
	gohelper.setActive(var_24_0.golocked, true)

	local var_24_3 = arg_24_0._recommendHeroList and tabletool.indexOf(arg_24_0._recommendHeroList, arg_24_2)

	gohelper.setActive(var_24_0.goRecommand1, var_24_3)
	gohelper.setActive(var_24_0.goRecommand2, var_24_3)

	arg_24_0._heroItemList[arg_24_3] = var_24_0
end

function var_0_0.checkIsPickMode(arg_25_0)
	if arg_25_0._questId then
		local var_25_0 = ""
		local var_25_1 = ""

		if arg_25_0._isFightQuest then
			var_25_0 = luaLang("assassin_quest_fight_pick_hero")
			var_25_1 = luaLang("assassin_quest_fight_begin")
		else
			local var_25_2 = AssassinConfig.instance:getQuestParam(arg_25_0._questId)
			local var_25_3 = AssassinConfig.instance:getStealthMapNeedHeroCount(tonumber(var_25_2))

			var_25_0 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("assassin_stealth_game_pick_hero"), var_25_3)
			var_25_1 = luaLang("assassin_stealth_game_begin")
		end

		arg_25_0._txtpicktitle.text = var_25_0
		arg_25_0._txtenter1.text = var_25_1
		arg_25_0._txtenter2.text = var_25_1

		arg_25_0:fillHeroCache()
	end

	gohelper.setActive(arg_25_0._gopick, arg_25_0._questId)
	gohelper.setActive(arg_25_0._goenterGame, arg_25_0._questId)
end

function var_0_0.getAssassinHeroId(arg_26_0, arg_26_1)
	local var_26_0

	if arg_26_0._heroItemList then
		local var_26_1 = arg_26_0._heroItemList[arg_26_1]

		if var_26_1 then
			var_26_0 = var_26_1.id
		else
			logError(string.format("AssassinHeroView:getAssassinHeroId error, no heroItem, index:%s", arg_26_1))
		end
	end

	return var_26_0
end

function var_0_0.getCurShowAssassinHeroId(arg_27_0)
	return (arg_27_0:getAssassinHeroId(arg_27_0._curShowIndex))
end

function var_0_0.refresh(arg_28_0)
	arg_28_0:refreshHeroItemIsUnlocked()
	arg_28_0:refreshHeroItemSelected()
	arg_28_0:refreshHeroInfo()
	arg_28_0:refreshCareerEquipInfo()
	arg_28_0:refreshItemGridList()
end

function var_0_0.refreshHeroItemSelected(arg_29_0)
	if not arg_29_0._heroItemList then
		return
	end

	for iter_29_0, iter_29_1 in ipairs(arg_29_0._heroItemList) do
		local var_29_0 = iter_29_1.id

		if AssassinHeroModel.instance:isUnlockAssassinHero(var_29_0) then
			local var_29_1 = iter_29_0 == arg_29_0._curShowIndex

			if arg_29_0._questId then
				local var_29_2 = AssassinStealthGameModel.instance:getHeroPickIndex(var_29_0)

				if var_29_2 then
					local var_29_3 = AssassinHeroModel.instance:isRequiredAssassin(var_29_0)

					gohelper.setActive(iter_29_1.gorequiredFrame1, var_29_3)
					gohelper.setActive(iter_29_1.gorequiredFrame2, var_29_3)
					gohelper.setActive(iter_29_1.gonormalFrame1, not var_29_3)
					gohelper.setActive(iter_29_1.gonormalFrame2, not var_29_3)
				end

				iter_29_1.txtindex1.text = var_29_2 or ""
				iter_29_1.txtindex2.text = var_29_2 or ""

				gohelper.setActive(iter_29_1.goframe1, var_29_2)
				gohelper.setActive(iter_29_1.goframe2, var_29_2)
			else
				iter_29_1.txtindex1.text = ""
				iter_29_1.txtindex2.text = ""

				gohelper.setActive(iter_29_1.gonormalFrame1, var_29_1)
				gohelper.setActive(iter_29_1.gonormalFrame2, var_29_1)
			end

			gohelper.setActive(iter_29_1.goselected, var_29_1)
			gohelper.setActive(iter_29_1.gounselected, not var_29_1)
		else
			gohelper.setActive(iter_29_1.goselected, false)
			gohelper.setActive(iter_29_1.gounselected, false)
		end
	end

	if arg_29_0._questId then
		local var_29_4 = ""
		local var_29_5 = AssassinStealthGameModel.instance:getPickHeroCount()
		local var_29_6 = false

		if arg_29_0._isFightQuest then
			var_29_4 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("assassin_stealth_game_fight_has_pick_hero"), var_29_5, arg_29_0.needHeroCount)
			var_29_6 = var_29_5 > 0
		else
			var_29_4 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("assassin_stealth_game_has_pick_hero"), var_29_5, arg_29_0.needHeroCount)
			var_29_6 = var_29_5 >= arg_29_0.needHeroCount
		end

		arg_29_0._txtpick1.text = var_29_4
		arg_29_0._txtpick2.text = var_29_4

		gohelper.setActive(arg_29_0._goAble, var_29_6)
		gohelper.setActive(arg_29_0._goDisAble, not var_29_6)
	end
end

function var_0_0.refreshHeroItemIsUnlocked(arg_30_0)
	if not arg_30_0._heroItemList then
		return
	end

	for iter_30_0, iter_30_1 in ipairs(arg_30_0._heroItemList) do
		local var_30_0 = iter_30_1.id

		if AssassinHeroModel.instance:isUnlockAssassinHero(var_30_0) then
			gohelper.setActive(iter_30_1.golocked, false)
			gohelper.setActive(iter_30_1.goselected, false)
			gohelper.setActive(iter_30_1.gounselected, false)
		else
			gohelper.setActive(iter_30_1.golocked, true)
			gohelper.setActive(iter_30_1.goselected, false)
			gohelper.setActive(iter_30_1.gounselected, false)
		end
	end
end

local var_0_2 = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function var_0_0.refreshHeroInfo(arg_31_0)
	local var_31_0 = arg_31_0:getCurShowAssassinHeroId()
	local var_31_1, var_31_2 = AssassinHeroModel.instance:getAssassinHeroName(var_31_0)

	arg_31_0._txtnamecn.text = var_31_1
	arg_31_0._txtnameen.text = var_31_2

	local var_31_3 = AssassinConfig.instance:getAssassinHeroImg(var_31_0)

	if not string.nilorempty(var_31_3) then
		local var_31_4 = ResUrl.getSp01AssassinSingleBg("hero/headicon/" .. var_31_3)

		arg_31_0._simagehero:LoadImage(var_31_4)
	end

	local var_31_5 = AssassinHeroModel.instance:getAssassinHeroCommonCareer(var_31_0)

	UISpriteSetMgr.instance:setCommonSprite(arg_31_0._imagecareericon, "lssx_" .. tostring(var_31_5))

	local var_31_6 = AssassinHeroModel.instance:getAssassinHeroEquipMo(var_31_0)

	if var_31_6 then
		arg_31_0._simageequipicon:LoadImage(ResUrl.getHeroDefaultEquipIcon(var_31_6.config.icon))

		arg_31_0._txtequiplv.text = var_31_6.level
	end

	gohelper.setActive(arg_31_0._goequipcontainer, var_31_6)

	local var_31_7, var_31_8 = AssassinHeroModel.instance:getAssassinHeroShowLevel(var_31_0)

	arg_31_0._txtherolv.text = var_31_7

	for iter_31_0 = 1, 3 do
		gohelper.setActive(arg_31_0._goranks[iter_31_0], var_31_8 and iter_31_0 == var_31_8 - 1)
	end

	local var_31_9 = AssassinHeroModel.instance:getAssassinHeroSkillLevel(var_31_0)

	if var_31_9 > 0 then
		arg_31_0._imageexskill.fillAmount = var_0_2[var_31_9] or 1

		gohelper.setActive(arg_31_0._goexskill, true)
	else
		gohelper.setActive(arg_31_0._goexskill, false)
	end
end

function var_0_0.refreshCareerEquipInfo(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0:getCurShowAssassinHeroId()
	local var_32_1 = AssassinHeroModel.instance:getAssassinCareerId(var_32_0)
	local var_32_2 = AssassinConfig.instance:getAssassinCareerEquipPic(var_32_1)
	local var_32_3 = ResUrl.getSp01AssassinSingleBg("weapon/" .. var_32_2)

	arg_32_0._simageicon:LoadImage(var_32_3)

	arg_32_0._txtEquipName.text = AssassinConfig.instance:getAssassinCareerEquipName(var_32_1)
	arg_32_0._txtcareer.text = AssassinConfig.instance:getAssassinCareerTitle(var_32_1)

	local var_32_4 = AssassinConfig.instance:isAssassinHeroHasSecondCareer(var_32_0)

	gohelper.setActive(arg_32_0._gochange, var_32_4)

	local var_32_5 = AssassinConfig.instance:getAssassinSkillIdByHeroCareer(var_32_0, var_32_1)

	arg_32_0._txtdesc.text = AssassinConfig.instance:getAssassinCareerSkillDesc(var_32_5)

	local var_32_6 = AssassinConfig.instance:getAssassinCareerAttrList(var_32_1)

	gohelper.CreateObjList(arg_32_0, arg_32_0._onCreateCareerEquipAttrItem, var_32_6, arg_32_0._goattrLayout, arg_32_0._goattrItem)

	if arg_32_1 then
		gohelper.setActive(arg_32_0._goswitch, false)
		gohelper.setActive(arg_32_0._goswitch, true)
	end
end

function var_0_0._onCreateCareerEquipAttrItem(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = gohelper.findChildImage(arg_33_1, "icon")
	local var_33_1 = gohelper.findChildText(arg_33_1, "#txt_attrName")
	local var_33_2 = gohelper.findChildText(arg_33_1, "#txt_attrValue")
	local var_33_3 = arg_33_2[1]
	local var_33_4 = HeroConfig.instance:getHeroAttributeCO(var_33_3)

	CharacterController.instance:SetAttriIcon(var_33_0, var_33_3, GameUtil.parseColor("#675C58"))

	var_33_1.text = var_33_4.name
	var_33_2.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("add_percent_value"), (arg_33_2[2] or 0) / 10)
end

function var_0_0.refreshItemGridList(arg_34_0)
	local var_34_0 = arg_34_0:getCurShowAssassinHeroId()
	local var_34_1 = AssassinHeroModel.instance:getAssassinCareerId(var_34_0)
	local var_34_2 = AssassinConfig.instance:getAssassinCareerCapacity(var_34_1)

	for iter_34_0, iter_34_1 in ipairs(arg_34_0._itemGridList) do
		local var_34_3 = iter_34_0 <= var_34_2

		if var_34_3 then
			local var_34_4 = AssassinHeroModel.instance:getCarryItemId(var_34_0, iter_34_0)

			if var_34_4 then
				AssassinHelper.setAssassinItemIcon(var_34_4, iter_34_1.imageitem)

				iter_34_1.txtnum.text = AssassinItemModel.instance:getAssassinItemCount(var_34_4)
			end

			gohelper.setActive(iter_34_1.goaddIcon, not var_34_4)
			gohelper.setActive(iter_34_1.goitemicon, var_34_4)
		end

		gohelper.setActive(iter_34_1.golocked, not var_34_3)
		gohelper.setActive(iter_34_1.gounlocked, var_34_3)
	end
end

function var_0_0.onClose(arg_35_0)
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.EnterStealthGameEff, false)
end

function var_0_0.onDestroyView(arg_36_0)
	if arg_36_0._heroItemList then
		for iter_36_0, iter_36_1 in ipairs(arg_36_0._heroItemList) do
			if iter_36_1.simageheroIcon1 then
				iter_36_1.simageheroIcon1:UnLoadImage()
			end

			if iter_36_1.simageheroIcon2 then
				iter_36_1.simageheroIcon2:UnLoadImage()
			end

			if iter_36_1.simageheroIcon3 then
				iter_36_1.simageheroIcon3:UnLoadImage()
			end
		end
	end

	arg_36_0._simagehero:UnLoadImage()
	arg_36_0._simageicon:UnLoadImage()
	arg_36_0._simageequipicon:UnLoadImage()
end

function var_0_0.saveHeroCache(arg_37_0)
	local var_37_0 = {}
	local var_37_1 = AssassinStealthGameModel.instance:getPickHeroList()

	for iter_37_0 = 2, #var_37_1 do
		var_37_0[tostring(iter_37_0 - 1)] = var_37_1[iter_37_0]
	end

	GameUtil.playerPrefsSetStringByUserId(AssassinEnum.PlayerCacheDataKey.AssassinHeroGroupCache, cjson.encode(var_37_0))
end

function var_0_0.fillHeroCache(arg_38_0)
	if arg_38_0.needHeroCount <= 1 then
		return
	end

	local var_38_0 = GameUtil.playerPrefsGetStringByUserId(AssassinEnum.PlayerCacheDataKey.AssassinHeroGroupCache, "")

	if not string.nilorempty(var_38_0) then
		local var_38_1 = cjson.decode(var_38_0)

		for iter_38_0 = 1, arg_38_0.needHeroCount - 1 do
			local var_38_2 = var_38_1[tostring(iter_38_0)]

			if var_38_2 then
				AssassinStealthGameController.instance:pickAssassinHeroItemInHeroView(arg_38_0._questId, var_38_2, arg_38_0._isFightQuest)
			end
		end
	end
end

return var_0_0
