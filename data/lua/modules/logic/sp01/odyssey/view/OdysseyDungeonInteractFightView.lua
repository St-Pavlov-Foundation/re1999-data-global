module("modules.logic.sp01.odyssey.view.OdysseyDungeonInteractFightView", package.seeall)

local var_0_0 = class("OdysseyDungeonInteractFightView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofightPanel = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel")
	arg_1_0._imagelevelIcon = gohelper.findChildImage(arg_1_0.viewGO, "#go_fightPanel/panel/common/level/#image_levelIcon")
	arg_1_0._txtenemyLevel = gohelper.findChildText(arg_1_0.viewGO, "#go_fightPanel/panel/common/level/#image_levelIcon/#txt_enemyLevel")
	arg_1_0._btnenemyLevel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_fightPanel/panel/common/level/#image_levelIcon/#btn_enemyLevel")
	arg_1_0._txtfightName = gohelper.findChildText(arg_1_0.viewGO, "#go_fightPanel/panel/common/level/#txt_fightName")
	arg_1_0._btnenemyInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_fightPanel/panel/common/level/#txt_fightName/#btn_enemyInfo")
	arg_1_0._golevelTip = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/common/level/#go_levelTip")
	arg_1_0._btnlevelCloseTip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_fightPanel/panel/#btn_levelCloseTip")
	arg_1_0._txtlevelTip = gohelper.findChildText(arg_1_0.viewGO, "#go_fightPanel/panel/common/level/#go_levelTip/bg/#txt_levelTip")
	arg_1_0._imagetagLarge = gohelper.findChildImage(arg_1_0.viewGO, "#go_fightPanel/panel/common/enemyTag/#image_tagLarge")
	arg_1_0._goenemyTagItem = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/common/enemyTag/#go_enemyTagItem")
	arg_1_0._txtrecommend = gohelper.findChildText(arg_1_0.viewGO, "#go_fightPanel/panel/common/recommendLevel/#txt_recommend")
	arg_1_0._txtfightDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_fightPanel/panel/common/scroll_fightDesc/Viewport/Content/#txt_fightDesc")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/common/#go_reward")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/common/#go_reward/scroll_reward/Viewport/#go_rewardContent")
	arg_1_0._gorewardItem = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/common/#go_reward/scroll_reward/Viewport/#go_rewardContent/#go_rewardItem")
	arg_1_0._btnfight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_fightPanel/panel/common/#btn_fight")
	arg_1_0._txtfight = gohelper.findChildText(arg_1_0.viewGO, "#go_fightPanel/panel/common/#btn_fight/#txt_fight")
	arg_1_0._goequipReward = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_equipReward")
	arg_1_0._goequipSuit = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_equipSuit")
	arg_1_0._txtequipSuit = gohelper.findChildText(arg_1_0.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_equipSuit/#txt_equipSuit")
	arg_1_0._imageequipSuit = gohelper.findChildImage(arg_1_0.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_equipSuit/#image_icon")
	arg_1_0._btnchangeSuit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_equipSuit/#btn_changeSuit")
	arg_1_0._goequipContent = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_equipReward/reward/scroll_equip/Viewport/#go_equipContent")
	arg_1_0._goequipItem = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_equipReward/reward/scroll_equip/Viewport/#go_equipContent/#go_equipItem")
	arg_1_0._gosuitSelectTip = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_suitSelectTip")
	arg_1_0._btnsuitCloseTip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_suitSelectTip/#btn_suitCloseTip")
	arg_1_0._gosuitSelectContent = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_suitSelectTip/#go_suitSelectContent")
	arg_1_0._gosuitSelectItem = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_suitSelectTip/#go_suitSelectContent/#go_suitSelectItem")
	arg_1_0._gosuitInfoTip = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_suitInfoTip")
	arg_1_0._imagesuitIcon = gohelper.findChildImage(arg_1_0.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_suitInfoTip/suit/suitName/#image_icon")
	arg_1_0._txtsuitName = gohelper.findChildText(arg_1_0.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_suitInfoTip/suit/suitName/#txt_suitName")
	arg_1_0._gosuitInfoContent = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_suitInfoTip/suit/#go_suitInfoContent")
	arg_1_0._gosuitInfoItem = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_suitInfoTip/suit/#go_suitInfoContent/#go_suitInfoItem")
	arg_1_0._goconquerReward = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_conquerReward")
	arg_1_0._goconquerHasget = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_conquerReward/conquerReward/icon/#go_conquerHasget")
	arg_1_0._imageconquerBar = gohelper.findChildImage(arg_1_0.viewGO, "#go_fightPanel/panel/#go_conquerReward/conquerReward/conquerBar/#image_conquerBar")
	arg_1_0._txtconquerTimes = gohelper.findChildText(arg_1_0.viewGO, "#go_fightPanel/panel/#go_conquerReward/conquerReward/#txt_conquerTimes")
	arg_1_0._txtconquerTotalTimes = gohelper.findChildText(arg_1_0.viewGO, "#go_fightPanel/panel/#go_conquerReward/conquerReward/#txt_conquerTimes/#txt_conquerTotalTimes")
	arg_1_0._btnconquer = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_fightPanel/panel/#go_conquerReward/conquerReward/#btn_conquer")
	arg_1_0._goconquerTip = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_conquerReward/#go_conquerTip")
	arg_1_0._btnconquerCloseTip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_fightPanel/panel/#go_conquerReward/#go_conquerTip/#btn_conquerCloseTip")
	arg_1_0._scrollconquer = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_fightPanel/panel/#go_conquerReward/#go_conquerTip/#scroll_conquer")
	arg_1_0._goconquerContent = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_conquerReward/#go_conquerTip/#scroll_conquer/Viewport/#go_conquerContent")
	arg_1_0._goconquerRewardItem = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_conquerReward/#go_conquerTip/#scroll_conquer/Viewport/#go_conquerContent/#go_conquerRewardItem")
	arg_1_0._gomyth = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_myth")
	arg_1_0._gorecord = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_myth/content/#go_record")
	arg_1_0._imagerecord = gohelper.findChildImage(arg_1_0.viewGO, "#go_fightPanel/panel/#go_myth/content/#go_record/#image_record")
	arg_1_0._goEmptyRecord = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_myth/content/#go_record/#go_emptyRecord")
	arg_1_0._txtrecord = gohelper.findChildText(arg_1_0.viewGO, "#go_fightPanel/panel/#go_myth/content/#go_record/#txt_record")
	arg_1_0._btnrecord = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_fightPanel/panel/#go_myth/content/#go_record/#btn_record")
	arg_1_0._goaddition = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_myth/content/#go_addition")
	arg_1_0._goadditionContent = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_myth/content/#go_addition/#go_additionContent")
	arg_1_0._goadditionItem = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_myth/content/#go_addition/#go_additionContent/#go_additionItem")
	arg_1_0._btnaddition = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_fightPanel/panel/#go_myth/content/#go_addition/#btn_addition")
	arg_1_0._gorecordRewardTip = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_myth/#go_recordRewardTip")
	arg_1_0._btnrecordCloseTip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_fightPanel/panel/#go_myth/#go_recordRewardTip/#btn_recordCloseTip")
	arg_1_0._gorecordContent = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_myth/#go_recordRewardTip/#go_recordContent")
	arg_1_0._gorecordItem = gohelper.findChild(arg_1_0.viewGO, "#go_fightPanel/panel/#go_myth/#go_recordRewardTip/#go_recordContent/#go_recordItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlevelCloseTip:AddClickListener(arg_2_0._btnLevelCloseTipOnClick, arg_2_0)
	arg_2_0._btnsuitCloseTip:AddClickListener(arg_2_0._btnSuitCloseTipOnClick, arg_2_0)
	arg_2_0._btnconquerCloseTip:AddClickListener(arg_2_0._btnConquerCloseTipOnClick, arg_2_0)
	arg_2_0._btnrecordCloseTip:AddClickListener(arg_2_0._btnRecordCloseTipOnClick, arg_2_0)
	arg_2_0._btnenemyLevel:AddClickListener(arg_2_0._btnenemyLevelOnClick, arg_2_0)
	arg_2_0._btnenemyInfo:AddClickListener(arg_2_0._btnenemyInfoOnClick, arg_2_0)
	arg_2_0._btnfight:AddClickListener(arg_2_0._btnfightOnClick, arg_2_0)
	arg_2_0._btnchangeSuit:AddClickListener(arg_2_0._btnchangeSuitOnClick, arg_2_0)
	arg_2_0._btnconquer:AddClickListener(arg_2_0._btnconquerOnClick, arg_2_0)
	arg_2_0._btnrecord:AddClickListener(arg_2_0._btnrecordOnClick, arg_2_0)
	arg_2_0._btnaddition:AddClickListener(arg_2_0._btnadditionOnClick, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.RefreshMercenarySuit, arg_2_0.refreshMercenaryUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlevelCloseTip:RemoveClickListener()
	arg_3_0._btnsuitCloseTip:RemoveClickListener()
	arg_3_0._btnconquerCloseTip:RemoveClickListener()
	arg_3_0._btnrecordCloseTip:RemoveClickListener()
	arg_3_0._btnenemyLevel:RemoveClickListener()
	arg_3_0._btnenemyInfo:RemoveClickListener()
	arg_3_0._btnfight:RemoveClickListener()
	arg_3_0._btnchangeSuit:RemoveClickListener()
	arg_3_0._btnconquer:RemoveClickListener()
	arg_3_0._btnrecord:RemoveClickListener()
	arg_3_0._btnaddition:RemoveClickListener()
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.RefreshMercenarySuit, arg_3_0.refreshMercenaryUI, arg_3_0)
end

var_0_0.normalDescHeight = 271
var_0_0.smallDescHeight = 162

function var_0_0._btnenemyLevelOnClick(arg_4_0)
	arg_4_0:showLevelSuppressTip(true)
end

function var_0_0._btnLevelCloseTipOnClick(arg_5_0)
	arg_5_0:showLevelSuppressTip(false)
end

function var_0_0._btnchangeSuitOnClick(arg_6_0)
	gohelper.setActive(arg_6_0._gosuitSelectTip, true)
end

function var_0_0._btnSuitCloseTipOnClick(arg_7_0)
	gohelper.setActive(arg_7_0._gosuitInfoTip, false)
	gohelper.setActive(arg_7_0._gosuitSelectTip, false)
end

function var_0_0._btnconquerOnClick(arg_8_0)
	gohelper.setActive(arg_8_0._goconquerTip, true)
end

function var_0_0._btnConquerCloseTipOnClick(arg_9_0)
	gohelper.setActive(arg_9_0._goconquerTip, false)
end

function var_0_0._btnrecordOnClick(arg_10_0)
	gohelper.setActive(arg_10_0._gorecordRewardTip, true)
end

function var_0_0._btnRecordCloseTipOnClick(arg_11_0)
	gohelper.setActive(arg_11_0._gorecordRewardTip, false)
end

function var_0_0._btnadditionOnClick(arg_12_0)
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = arg_12_0.ruleList,
		offSet = {
			-200,
			-176
		}
	})
end

function var_0_0._btnenemyInfoOnClick(arg_13_0)
	local var_13_0 = DungeonConfig.instance:getEpisodeCO(arg_13_0.fightElementConfig.episodeId)

	EnemyInfoController.instance:openEnemyInfoViewByBattleId(var_13_0.battleId)
end

function var_0_0._btnfightOnClick(arg_14_0)
	if arg_14_0.fightEpisodeCo.beforeStory > 0 then
		if arg_14_0.fightEpisodeCo.afterStory > 0 then
			if not StoryModel.instance:isStoryFinished(arg_14_0.fightEpisodeCo.afterStory) then
				arg_14_0:playStoryAndEnterFight(arg_14_0.fightEpisodeCo.beforeStory)

				return
			end
		elseif not OdysseyDungeonModel.instance:isElementFinish(arg_14_0.elementConfig.id) then
			arg_14_0:playStoryAndEnterFight(arg_14_0.fightEpisodeCo.beforeStory)

			return
		end
	end

	arg_14_0:enterFight()
end

function var_0_0._editableInitView(arg_15_0)
	arg_15_0.rewardItemTab = arg_15_0:getUserDataTb_()
	arg_15_0.rewardOuteritemTab = arg_15_0:getUserDataTb_()
	arg_15_0.multiRewardItemTab = arg_15_0:getUserDataTb_()
	arg_15_0.suitSelectItemTab = arg_15_0:getUserDataTb_()
	arg_15_0.fightUIHandleFunc = {
		[OdysseyEnum.FightType.Normal] = var_0_0.refreshNormalUI,
		[OdysseyEnum.FightType.Elite] = var_0_0.refreshNormalUI,
		[OdysseyEnum.FightType.Mercenary] = var_0_0.refreshMercenaryUI,
		[OdysseyEnum.FightType.Religion] = var_0_0.refreshNormalUI,
		[OdysseyEnum.FightType.Conquer] = var_0_0.refreshConquerUI,
		[OdysseyEnum.FightType.Myth] = var_0_0.refreshMythUI
	}
	arg_15_0._txtEnemyTag = gohelper.findChildText(arg_15_0._goenemyTagItem, "txt_tag")
	arg_15_0._imageEnemyTag = gohelper.findChildImage(arg_15_0._goenemyTagItem, "image_tag")
	arg_15_0._gofightDesc = gohelper.findChild(arg_15_0.viewGO, "#go_fightPanel/panel/common/scroll_fightDesc")
	arg_15_0._goConquerBar = gohelper.findChild(arg_15_0.viewGO, "#go_fightPanel/panel/#go_conquerReward/conquerReward/conquerBar")
	arg_15_0._goequipSuitEffect = gohelper.findChild(arg_15_0.viewGO, "#go_fightPanel/panel/#go_equipReward/#go_equipSuit/vx_eff")
	arg_15_0._conquerBarWith = recthelper.getWidth(arg_15_0._goConquerBar.transform)

	gohelper.setActive(arg_15_0._btnlevelCloseTip, false)
	gohelper.setActive(arg_15_0._goequipSuitEffect, false)
	gohelper.setActive(arg_15_0._gosuitInfoTip, false)
	gohelper.setActive(arg_15_0._gosuitSelectTip, false)
end

function var_0_0.onUpdateParam(arg_16_0)
	return
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0.elementConfig = arg_17_0.viewParam.config
	arg_17_0.elementType = arg_17_0.elementConfig.type
	arg_17_0.fightElementConfig = OdysseyConfig.instance:getElementFightConfig(arg_17_0.elementConfig.id)
	arg_17_0.elementMO = OdysseyDungeonModel.instance:getElementMo(arg_17_0.elementConfig.id)
end

function var_0_0.refreshFightPanel(arg_18_0)
	arg_18_0:showLevelSuppressTip(false, true)
	arg_18_0:refreshCommonUI()
	arg_18_0:hideAllSpUI()

	local var_18_0 = arg_18_0.fightUIHandleFunc[arg_18_0.fightElementConfig.type]

	if var_18_0 then
		var_18_0(arg_18_0)
	end
end

function var_0_0.refreshCommonUI(arg_19_0)
	local var_19_0 = OdysseyModel.instance:getHeroCurLevelAndExp()

	arg_19_0.fightEpisodeCo = DungeonConfig.instance:getEpisodeCO(arg_19_0.fightElementConfig.episodeId)

	local var_19_1 = arg_19_0.fightElementConfig.enemyLevel

	arg_19_0._txtenemyLevel.text = var_19_0 < var_19_1 and string.format("<#E76969>%s</color>", var_19_1) or var_19_1
	arg_19_0._txtfightName.text = arg_19_0.fightElementConfig.title
	arg_19_0._txtfightDesc.text = arg_19_0.fightElementConfig.desc

	local var_19_2 = FightHelper.getBattleRecommendLevel(arg_19_0.fightEpisodeCo.battleId)

	arg_19_0._txtrecommend.text = var_19_2 >= 0 and HeroConfig.instance:getLevelDisplayVariant(var_19_2) or ""
	arg_19_0._txtfight.text = luaLang("toughbattle_mainview_txt_start")

	local var_19_3 = arg_19_0.fightElementConfig.type == OdysseyEnum.FightType.Mercenary and tonumber(arg_19_0.fightElementConfig.param) or 0
	local var_19_4 = OdysseyEnum.FightElementTagLang[arg_19_0.fightElementConfig.type][var_19_3]

	arg_19_0._txtEnemyTag.text = luaLang(var_19_4)

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_19_0._imageEnemyTag, string.format("%s_0", OdysseyEnum.FightElementTagIcon[arg_19_0.fightElementConfig.type]), true)
	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_19_0._imagetagLarge, string.format("%s_2", OdysseyEnum.FightElementTagIcon[arg_19_0.fightElementConfig.type]))
	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_19_0._imagelevelIcon, OdysseyEnum.FightElementEnemyIcon[arg_19_0.fightElementConfig.type])
end

function var_0_0.showLevelSuppressTip(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = OdysseyModel.instance:getHeroCurLevelAndExp()
	local var_20_1 = arg_20_0.fightElementConfig.enemyLevel
	local var_20_2 = OdysseyEnum.LocalSaveKey.FightLevelSuppress
	local var_20_3 = GameUtil.playerPrefsGetNumberByUserId(var_20_2, 0)
	local var_20_4 = var_20_0 - var_20_1
	local var_20_5 = OdysseyConfig.instance:getLevelSuppressConfig(var_20_4)

	arg_20_0._txtlevelTip.text = var_20_5.tips

	gohelper.setActive(arg_20_0._golevelTip, arg_20_1)
	gohelper.setActive(arg_20_0._btnlevelCloseTip, arg_20_1)

	if var_20_3 == 0 and var_20_0 < var_20_1 and arg_20_2 then
		GameUtil.playerPrefsSetNumberByUserId(var_20_2, 1)
		gohelper.setActive(arg_20_0._golevelTip, true)
	end
end

function var_0_0.hideAllSpUI(arg_21_0)
	gohelper.setActive(arg_21_0._goequipReward, false)
	gohelper.setActive(arg_21_0._goconquerReward, false)
	gohelper.setActive(arg_21_0._gomyth, false)
	gohelper.setActive(arg_21_0._goreward, false)
end

function var_0_0.refreshNormalUI(arg_22_0)
	gohelper.setActive(arg_22_0._goreward, true)
	gohelper.setActive(arg_22_0._gorewardItem, false)

	local var_22_0 = arg_22_0.fightElementConfig.episodeId
	local var_22_1 = DungeonConfig.instance:getEpisodeCO(var_22_0)
	local var_22_2 = lua_bonus.configDict[var_22_1.firstBonus]

	if var_22_1.firstBonus > 0 and var_22_2 then
		local var_22_3 = GameUtil.splitString2(var_22_2.fixBonus)

		for iter_22_0, iter_22_1 in ipairs(var_22_3) do
			local var_22_4 = arg_22_0.rewardOuteritemTab[iter_22_0]

			if not var_22_4 then
				var_22_4 = {
					go = gohelper.clone(arg_22_0._gorewardItem, arg_22_0._gorewardContent, "rewardOuterItem_" .. iter_22_0)
				}
				var_22_4.itemGO = arg_22_0.viewContainer:getResInst(arg_22_0.viewContainer:getSetting().otherRes[1], var_22_4.go)
				var_22_4.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(var_22_4.itemGO, OdysseyItemIcon)
				arg_22_0.rewardOuteritemTab[iter_22_0] = var_22_4
			end

			local var_22_5 = {
				type = tonumber(iter_22_1[1]),
				id = tonumber(iter_22_1[2])
			}

			var_22_4.itemIcon:initRewardItemInfo(OdysseyEnum.RewardItemType.OuterItem, var_22_5, tonumber(iter_22_1[3]))
			gohelper.setActive(var_22_4.go, true)
		end

		for iter_22_2 = #var_22_3 + 1, #arg_22_0.rewardOuteritemTab do
			local var_22_6 = arg_22_0.rewardOuteritemTab[iter_22_2]

			if var_22_6 then
				gohelper.setActive(var_22_6.go, false)
			end
		end
	end

	local var_22_7 = GameUtil.splitString2(arg_22_0.fightElementConfig.reward)

	for iter_22_3, iter_22_4 in ipairs(var_22_7) do
		local var_22_8 = arg_22_0.rewardItemTab[iter_22_3]

		if not var_22_8 then
			var_22_8 = {
				go = gohelper.clone(arg_22_0._gorewardItem, arg_22_0._gorewardContent, "rewardItem_" .. iter_22_3)
			}
			var_22_8.itemGO = arg_22_0.viewContainer:getResInst(arg_22_0.viewContainer:getSetting().otherRes[1], var_22_8.go)
			var_22_8.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(var_22_8.itemGO, OdysseyItemIcon)
			arg_22_0.rewardItemTab[iter_22_3] = var_22_8
		end

		var_22_8.itemIcon:initRewardItemInfo(iter_22_4[1], tonumber(iter_22_4[2]), tonumber(iter_22_4[3]))
		gohelper.setActive(var_22_8.go, true)
	end

	for iter_22_5 = #var_22_7 + 1, #arg_22_0.rewardItemTab do
		local var_22_9 = arg_22_0.rewardItemTab[iter_22_5]

		if var_22_9 then
			gohelper.setActive(var_22_9.go, false)
		end
	end
end

function var_0_0.refreshMercenaryUI(arg_23_0)
	gohelper.setActive(arg_23_0._goequipReward, true)

	arg_23_0.mercenaryType = tonumber(arg_23_0.fightElementConfig.param)

	local var_23_0 = OdysseyEnum.MercenaryTypeToSuit[arg_23_0.mercenaryType]
	local var_23_1 = OdysseyConfig.instance:getConstConfig(var_23_0)
	local var_23_2 = not string.nilorempty(var_23_1.value)

	gohelper.setActive(arg_23_0._goequipSuit, var_23_2)

	if var_23_2 then
		local var_23_3 = string.splitToNumber(var_23_1.value, "#")

		arg_23_0.curSuitId = OdysseyModel.instance:getMercenaryTypeSuit(arg_23_0.mercenaryType)

		local var_23_4 = OdysseyConfig.instance:getEquipSuitConfig(arg_23_0.curSuitId)

		arg_23_0._txtequipSuit.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_get_rateup"), var_23_4.name)

		UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_23_0._imageequipSuit, var_23_4.icon)
		arg_23_0:refreshSuitSelectTip(var_23_3)
		arg_23_0:playSuitSelectEffect()
	end

	arg_23_0:createAndRefreshMercenaryReward()
end

function var_0_0.createAndRefreshMercenaryReward(arg_24_0)
	gohelper.setActive(arg_24_0._goequipItem, false)

	local var_24_0 = {}
	local var_24_1 = GameUtil.splitString2(arg_24_0.fightElementConfig.reward)
	local var_24_2 = arg_24_0.fightElementConfig.randomDrop
	local var_24_3 = OdysseyConfig.instance:getEquipDropConfig(var_24_2)
	local var_24_4 = GameUtil.splitString2(var_24_3.dropRare, true)

	for iter_24_0, iter_24_1 in ipairs(var_24_1) do
		local var_24_5 = {}

		var_24_5.isEquipSuit = false
		var_24_5.data = iter_24_1

		table.insert(var_24_0, var_24_5)
	end

	table.sort(var_24_4, function(arg_25_0, arg_25_1)
		return tonumber(arg_25_0[1]) > tonumber(arg_25_1[1])
	end)

	for iter_24_2, iter_24_3 in ipairs(var_24_4) do
		local var_24_6 = {}

		var_24_6.isEquipSuit = true
		var_24_6.data = iter_24_3

		table.insert(var_24_0, var_24_6)
	end

	for iter_24_4, iter_24_5 in ipairs(var_24_0) do
		local var_24_7 = arg_24_0.rewardItemTab[iter_24_4]

		if not var_24_7 then
			var_24_7 = {
				go = gohelper.clone(arg_24_0._goequipItem, arg_24_0._goequipContent, "rewardItem_" .. iter_24_4)
			}
			var_24_7.itemGO = arg_24_0.viewContainer:getResInst(arg_24_0.viewContainer:getSetting().otherRes[1], var_24_7.go)
			var_24_7.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(var_24_7.itemGO, OdysseyItemIcon)
			arg_24_0.rewardItemTab[iter_24_4] = var_24_7
		end

		if iter_24_5.isEquipSuit then
			var_24_7.itemIcon:showUnknowSuitIcon(iter_24_5.data[1])
		else
			var_24_7.itemIcon:initRewardItemInfo(iter_24_5.data[1], tonumber(iter_24_5.data[2]), tonumber(iter_24_5.data[3]))
		end

		gohelper.setActive(var_24_7.go, true)
	end

	for iter_24_6 = #var_24_0 + 1, #arg_24_0.rewardItemTab do
		local var_24_8 = arg_24_0.rewardItemTab[iter_24_6]

		if var_24_8 then
			gohelper.setActive(var_24_8.go, false)
		end
	end
end

function var_0_0.playSuitSelectEffect(arg_26_0)
	if arg_26_0.curSuitId and arg_26_0.lastSuitId and arg_26_0.curSuitId ~= arg_26_0.lastSuitId then
		gohelper.setActive(arg_26_0._goequipSuitEffect, false)
		gohelper.setActive(arg_26_0._goequipSuitEffect, true)
	end

	arg_26_0.lastSuitId = arg_26_0.curSuitId
end

function var_0_0.refreshSuitSelectTip(arg_27_0, arg_27_1)
	arg_27_0.isSuitLongPress = false

	gohelper.CreateObjList(arg_27_0, arg_27_0.onSuitSelectTipShow, arg_27_1, arg_27_0._gosuitSelectContent, arg_27_0._gosuitSelectItem)
end

function var_0_0.onSuitSelectTipShow(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = arg_28_0.suitSelectItemTab[arg_28_3]

	if not var_28_0 then
		var_28_0 = {
			go = arg_28_1
		}
		var_28_0.imageSuitIcon = gohelper.findChildImage(var_28_0.go, "image_suitIcon")
		var_28_0.txtSuitName = gohelper.findChildText(var_28_0.go, "txt_suitName")
		var_28_0.btnSuitSelect = gohelper.findChildButtonWithAudio(var_28_0.go, "btn_select")
		var_28_0.btnSuitClickLongPrees = SLFramework.UGUI.UILongPressListener.Get(var_28_0.btnSuitSelect.gameObject)

		var_28_0.btnSuitClickLongPrees:SetLongPressTime({
			0.5,
			99999
		})

		var_28_0.goSelect = gohelper.findChild(var_28_0.go, "btn_select/go_select")
		arg_28_0.suitSelectItemTab[arg_28_3] = var_28_0
	end

	var_28_0.suitConfig = OdysseyConfig.instance:getEquipSuitConfig(arg_28_2)
	var_28_0.txtSuitName.text = var_28_0.suitConfig.name

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(var_28_0.imageSuitIcon, var_28_0.suitConfig.icon)
	var_28_0.btnSuitSelect:AddClickListener(arg_28_0._onSuitSelectClick, arg_28_0, var_28_0)
	var_28_0.btnSuitClickLongPrees:AddLongPressListener(arg_28_0._onSuitEffectInfoClick, arg_28_0, var_28_0)
	gohelper.setActive(var_28_0.goSelect, arg_28_2 == arg_28_0.curSuitId)
end

function var_0_0._onSuitEffectInfoClick(arg_29_0, arg_29_1)
	gohelper.setActive(arg_29_0._gosuitInfoTip, true)

	arg_29_0._txtsuitName.text = arg_29_1.suitConfig.name

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_29_0._imagesuitIcon, arg_29_1.suitConfig.icon)

	arg_29_0.suitEffectList = OdysseyConfig.instance:getEquipSuitAllEffect(arg_29_1.suitConfig.id)

	gohelper.CreateObjList(arg_29_0, arg_29_0.onSuitEffectInfoTipShow, arg_29_0.suitEffectList, arg_29_0._gosuitInfoContent, arg_29_0._gosuitInfoItem)

	arg_29_0.isSuitLongPress = true
end

function var_0_0.onSuitEffectInfoTipShow(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = arg_30_1
	local var_30_1 = gohelper.findChildText(var_30_0, "txt_suitInfo")
	local var_30_2 = gohelper.findChild(var_30_0, "go_line")
	local var_30_3 = HeroSkillModel.instance:skillDesToSpot(arg_30_2.effect, "#CC492F", "#485E92")

	var_30_1.text = SkillHelper.buildDesc(var_30_3)

	local var_30_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_30_1.gameObject, FixTmpBreakLine)

	SkillHelper.addHyperLinkClick(var_30_1, arg_30_0._onHyperLinkClick, arg_30_0)
	var_30_4:refreshTmpContent(var_30_1)
	gohelper.setActive(var_30_2, arg_30_3 ~= #arg_30_0.suitEffectList)
end

function var_0_0._onHyperLinkClick(arg_31_0, arg_31_1, arg_31_2)
	CommonBuffTipController.instance:openCommonTipView(tonumber(arg_31_1), arg_31_2)
end

function var_0_0._onSuitSelectClick(arg_32_0, arg_32_1)
	if arg_32_0.isSuitLongPress then
		arg_32_0.isSuitLongPress = false

		return
	end

	arg_32_0.curSuitId = arg_32_1.suitConfig.id

	OdysseyRpc.instance:sendOdysseyFightMercenarySetDropRequest(arg_32_0.mercenaryType, arg_32_0.curSuitId)

	for iter_32_0, iter_32_1 in ipairs(arg_32_0.suitSelectItemTab) do
		gohelper.setActive(iter_32_1.goSelect, iter_32_1.suitConfig.id == arg_32_0.curSuitId)
	end

	arg_32_0._txtequipSuit.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_get_rateup"), arg_32_1.suitConfig.name)

	gohelper.setActive(arg_32_0._gosuitInfoTip, false)
	gohelper.setActive(arg_32_0._gosuitSelectTip, false)
end

function var_0_0.refreshConquerUI(arg_33_0)
	gohelper.setActive(arg_33_0._goconquerTip, false)
	gohelper.setActive(arg_33_0._goconquerReward, true)

	local var_33_0 = string.split(arg_33_0.fightElementConfig.reward, "@")
	local var_33_1 = #var_33_0 and #var_33_0 > 0 and #var_33_0 or 1
	local var_33_2 = arg_33_0.elementMO:getConquestEleData()

	arg_33_0.curConquestHighWave = var_33_2 and var_33_2.highWave or 0

	local var_33_3 = arg_33_0.curConquestHighWave / var_33_1 * arg_33_0._conquerBarWith

	recthelper.setWidth(arg_33_0._imageconquerBar.gameObject.transform, var_33_3)

	arg_33_0._txtconquerTimes.text = arg_33_0.curConquestHighWave
	arg_33_0._txtconquerTotalTimes.text = "/" .. var_33_1

	gohelper.setActive(arg_33_0._goconquerHasget, arg_33_0.curConquestHighWave == var_33_1)
	arg_33_0:createRewardItem(var_33_0, arg_33_0._goconquerRewardItem, arg_33_0._goconquerContent)

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.multiRewardItemTab) do
		for iter_33_2, iter_33_3 in ipairs(iter_33_1.itemIconTab) do
			gohelper.setActive(iter_33_3.itemGet, iter_33_0 <= arg_33_0.curConquestHighWave)
		end

		iter_33_1.txt.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_conquest_wave"), GameUtil.getNum2Chinese(iter_33_0))
	end
end

function var_0_0.refreshMythUI(arg_34_0)
	gohelper.setActive(arg_34_0._gomyth, true)
	gohelper.setActive(arg_34_0._gorecordRewardTip, false)

	local var_34_0 = arg_34_0.elementMO:getMythicEleData()
	local var_34_1 = var_34_0 and var_34_0.evaluation or 0

	arg_34_0._txtrecord.text = var_34_1 > 0 and luaLang("odyssey_dungeon_mapselectinfo_mythRecord" .. var_34_1) or luaLang("odyssey_myth_record_empty")

	if var_34_1 > 0 then
		UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_34_0._imagerecord, "pingji_d_" .. var_34_1)
	end

	gohelper.setActive(arg_34_0._imagerecord.gameObject, var_34_1 > 0)
	gohelper.setActive(arg_34_0._goEmptyRecord, var_34_1 == 0)

	local var_34_2 = GameUtil.splitString2(arg_34_0.fightElementConfig.param, true)
	local var_34_3 = string.split(arg_34_0.fightElementConfig.reward, "@")

	arg_34_0:createRewardItem(var_34_3, arg_34_0._gorecordItem, arg_34_0._gorecordContent)

	for iter_34_0, iter_34_1 in ipairs(arg_34_0.multiRewardItemTab) do
		for iter_34_2, iter_34_3 in ipairs(iter_34_1.itemIconTab) do
			gohelper.setActive(iter_34_3.itemGet, iter_34_0 <= var_34_1)
		end

		iter_34_1.imageRecord = gohelper.findChildImage(iter_34_1.go, "image_record")

		UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(iter_34_1.imageRecord, "pingji_x_" .. iter_34_0)

		local var_34_4 = OdysseyConfig.instance:getFightTaskDescConfig(var_34_2[iter_34_0][2])

		iter_34_1.txt.text = var_34_4.desc
	end

	local var_34_5 = arg_34_0.fightElementConfig.episodeId
	local var_34_6 = DungeonConfig.instance:getEpisodeCO(var_34_5)
	local var_34_7 = lua_battle.configDict[var_34_6.battleId]
	local var_34_8 = not string.nilorempty(var_34_7.AdditionRule)

	gohelper.setActive(arg_34_0._goaddition, var_34_8)
	recthelper.setHeight(arg_34_0._gofightDesc.transform, var_34_8 and var_0_0.smallDescHeight or var_0_0.normalDescHeight)

	if var_34_8 then
		arg_34_0.ruleList = FightStrUtil.instance:getSplitString2Cache(var_34_7.AdditionRule, true, "|", "#")

		gohelper.CreateObjList(arg_34_0, arg_34_0.onAdditionalRuleShow, arg_34_0.ruleList, arg_34_0._goadditionContent, arg_34_0._goadditionItem)
	end
end

function var_0_0.onAdditionalRuleShow(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = arg_35_2[1]
	local var_35_1 = arg_35_2[2]
	local var_35_2 = lua_rule.configDict[var_35_1]
	local var_35_3 = arg_35_1

	if var_35_2 then
		gohelper.setActive(var_35_3, true)

		local var_35_4 = gohelper.findChildImage(var_35_3, "image_ruleicon")
		local var_35_5 = gohelper.findChildImage(var_35_3, "image_ruleicon/image_tagicon")

		UISpriteSetMgr.instance:setCommonSprite(var_35_5, "wz_" .. var_35_0)
		UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_35_4, var_35_2.icon)
	else
		gohelper.setActive(var_35_3, false)
	end
end

function var_0_0.createRewardItem(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	gohelper.setActive(arg_36_2, false)

	for iter_36_0, iter_36_1 in ipairs(arg_36_1) do
		local var_36_0 = arg_36_0.multiRewardItemTab[iter_36_0]

		if not var_36_0 then
			var_36_0 = {
				go = gohelper.clone(arg_36_2, arg_36_3, "rewardItem" .. iter_36_0)
			}
			var_36_0.txt = gohelper.findChildText(var_36_0.go, "txt_desc")
			var_36_0.itemContent = gohelper.findChild(var_36_0.go, "go_rewardContent")
			var_36_0.itemGO = gohelper.findChild(var_36_0.go, "go_rewardContent/go_rewardItem")
			var_36_0.itemIconTab = {}

			arg_36_0:createRewardItemIcon(iter_36_1, var_36_0.itemGO, var_36_0.itemContent, var_36_0.itemIconTab)

			arg_36_0.multiRewardItemTab[iter_36_0] = var_36_0
		end

		gohelper.setActive(var_36_0.go, true)
	end
end

function var_0_0.createRewardItemIcon(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	gohelper.setActive(arg_37_2, false)

	local var_37_0 = GameUtil.splitString2(arg_37_1)

	for iter_37_0, iter_37_1 in ipairs(var_37_0) do
		local var_37_1 = arg_37_4[iter_37_0]

		if not var_37_1 then
			var_37_1 = {
				go = gohelper.clone(arg_37_2, arg_37_3, "rewardItem_" .. iter_37_0)
			}
			var_37_1.itemPos = gohelper.findChild(var_37_1.go, "go_itemPos")
			var_37_1.itemGet = gohelper.findChild(var_37_1.go, "go_get")
			var_37_1.itemGO = arg_37_0.viewContainer:getResInst(arg_37_0.viewContainer:getSetting().otherRes[1], var_37_1.itemPos)
			var_37_1.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(var_37_1.itemGO, OdysseyItemIcon)
			arg_37_4[iter_37_0] = var_37_1
		end

		var_37_1.itemIcon:initRewardItemInfo(iter_37_1[1], tonumber(iter_37_1[2]), tonumber(iter_37_1[3]))
		gohelper.setActive(var_37_1.go, true)
	end

	for iter_37_2 = #var_37_0 + 1, #arg_37_4 do
		local var_37_2 = arg_37_4[iter_37_2]

		if var_37_2 then
			gohelper.setActive(var_37_2.go, false)
		end
	end
end

function var_0_0.enterFight(arg_38_0)
	local var_38_0 = {
		episodeId = arg_38_0.fightEpisodeCo.id,
		elementId = arg_38_0.elementConfig.id
	}

	OdysseyDungeonModel.instance:setLastElementFightParam(var_38_0)
	DungeonFightController.instance:enterFight(arg_38_0.fightEpisodeCo.chapterId, arg_38_0.fightEpisodeCo.id)
end

function var_0_0.playStoryAndEnterFight(arg_39_0, arg_39_1, arg_39_2)
	if not arg_39_2 and StoryModel.instance:isStoryFinished(arg_39_1) then
		arg_39_0:enterFight()

		return
	end

	local var_39_0 = {}

	var_39_0.mark = true
	var_39_0.episodeId = arg_39_0.fightEpisodeCo.id

	StoryController.instance:playStory(arg_39_1, var_39_0, arg_39_0.enterFight, arg_39_0)
end

function var_0_0.onClose(arg_40_0)
	if #arg_40_0.suitSelectItemTab > 0 then
		for iter_40_0, iter_40_1 in ipairs(arg_40_0.suitSelectItemTab) do
			iter_40_1.btnSuitSelect:RemoveClickListener()
			iter_40_1.btnSuitClickLongPrees:RemoveLongPressListener()
		end
	end
end

function var_0_0.onDestroyView(arg_41_0)
	return
end

return var_0_0
