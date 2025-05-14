module("modules.logic.seasonver.act166.view.Season166BaseSpotView", package.seeall)

local var_0_0 = class("Season166BaseSpotView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._goscoreInfo = gohelper.findChild(arg_1_0.viewGO, "left/#go_scoreInfo")
	arg_1_0._txtscore = gohelper.findChildText(arg_1_0.viewGO, "left/#go_scoreInfo/#txt_score")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "right/episodeInfo/#txt_title")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/episodeInfo/#btn_detail")
	arg_1_0._txtenemyinfo = gohelper.findChildText(arg_1_0.viewGO, "right/episodeInfo/enemyInfo/enemyinfo/#txt_enemyinfo")
	arg_1_0._txtepisodeInfo = gohelper.findChildText(arg_1_0.viewGO, "right/episodeInfo/#txt_episodeInfo")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "right/reward/#go_rewardContent")
	arg_1_0._gorewardItem = gohelper.findChild(arg_1_0.viewGO, "right/reward/#go_rewardContent/#go_rewardItem")
	arg_1_0._btnfight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_fight")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
	arg_2_0._btnfight:AddClickListener(arg_2_0._btnfightOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndetail:RemoveClickListener()
	arg_3_0._btnfight:RemoveClickListener()
end

function var_0_0._btndetailOnClick(arg_4_0)
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(arg_4_0.battleId)
end

function var_0_0._btnfightOnClick(arg_5_0)
	local var_5_0 = {
		actId = arg_5_0.actId,
		baseId = arg_5_0.baseId
	}

	Season166BaseSpotController.instance:enterBaseSpotFightScene(var_5_0)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.starTab = arg_6_0:getUserDataTb_()

	for iter_6_0 = 1, 3 do
		local var_6_0 = {
			go = gohelper.findChild(arg_6_0.viewGO, "left/#go_scoreInfo/stars/go_star" .. iter_6_0)
		}

		var_6_0.imageStar = gohelper.findChildImage(var_6_0.go, "#go_Star" .. iter_6_0)

		table.insert(arg_6_0.starTab, var_6_0)
	end
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.actId = arg_8_0.viewParam.actId
	arg_8_0.config = arg_8_0.viewParam.config
	arg_8_0.baseId = arg_8_0.viewParam.baseId
	arg_8_0.episodeConfig = DungeonConfig.instance:getEpisodeCO(arg_8_0.config.episodeId)
	arg_8_0.battleId = arg_8_0.episodeConfig.battleId

	local var_8_0 = Season166Model.instance:getActInfo(arg_8_0.actId).baseSpotInfoMap[arg_8_0.baseId]

	if var_8_0 and not var_8_0.isEnter then
		Activity166Rpc.instance:sendAct166EnterBaseRequest(arg_8_0.actId, arg_8_0.baseId)
	end

	local var_8_1 = Season166Config.instance:getSeasonScoreCos(arg_8_0.actId)

	arg_8_0.finalLevelScore = var_8_1[#var_8_1].needScore

	Season166Controller.instance:dispatchEvent(Season166Event.OpenBaseSpotView, {
		isEnter = true,
		baseSpotId = arg_8_0.baseId
	})
	Season166BaseSpotModel.instance:initBaseSpotData(arg_8_0.actId, arg_8_0.baseId)
	arg_8_0:refreshUI()
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0:refreshReward()
	arg_9_0:refreshInfo()
	arg_9_0:refreshScoreInfo()
end

function var_0_0.refreshReward(arg_10_0)
	local var_10_0 = Season166Config.instance:getSeasonBaseLevelCos(arg_10_0.actId, arg_10_0.baseId)

	gohelper.CreateObjList(arg_10_0, arg_10_0.rewardItemShow, var_10_0, arg_10_0._gorewardContent, arg_10_0._gorewardItem)
end

function var_0_0.rewardItemShow(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = gohelper.findChildText(arg_11_1, "star/txt_starCount")
	local var_11_1 = gohelper.findChild(arg_11_1, "go_itempos")
	local var_11_2 = gohelper.findChild(arg_11_1, "go_get")
	local var_11_3 = Season166Config.instance:getSeasonScoreCo(arg_11_0.actId, arg_11_2.level).star

	var_11_0.text = var_11_3

	local var_11_4 = IconMgr.instance:getCommonPropItemIcon(var_11_1)
	local var_11_5 = string.splitToNumber(arg_11_2.firstBonus, "#")

	var_11_4:setMOValue(var_11_5[1], var_11_5[2], var_11_5[3])
	var_11_4:setHideLvAndBreakFlag(true)
	var_11_4:hideEquipLvAndBreak(true)
	var_11_4:setCountFontSize(51)

	local var_11_6 = Season166BaseSpotModel.instance:getStarCount(arg_11_0.actId, arg_11_0.baseId)

	gohelper.setActive(var_11_2, var_11_3 <= var_11_6)
end

function var_0_0.refreshInfo(arg_12_0)
	arg_12_0._txttitle.text = GameUtil.setFirstStrSize(arg_12_0.config.name, 102)
	arg_12_0._txtepisodeInfo.text = arg_12_0.config.desc

	local var_12_0 = arg_12_0.config.level

	arg_12_0._txtenemyinfo.text = HeroConfig.instance:getLevelDisplayVariant(var_12_0)
end

function var_0_0.refreshScoreInfo(arg_13_0)
	local var_13_0 = Season166BaseSpotModel.instance:getBaseSpotMaxScore(arg_13_0.actId, arg_13_0.baseId)

	arg_13_0._txtscore.text = var_13_0

	local var_13_1 = Season166BaseSpotModel.instance:getStarCount(arg_13_0.actId, arg_13_0.baseId)
	local var_13_2 = Season166Config.instance:getSeasonBaseLevelCos(arg_13_0.actId, arg_13_0.baseId)

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.starTab) do
		gohelper.setActive(iter_13_1.go, iter_13_0 <= #var_13_2)
		gohelper.setActive(iter_13_1.imageStar.gameObject, iter_13_0 <= var_13_1)

		local var_13_3 = var_13_0 >= arg_13_0.finalLevelScore and "season166_result_inclinedbulb3" or "season166_result_inclinedbulb2"

		UISpriteSetMgr.instance:setSeason166Sprite(iter_13_1.imageStar, var_13_3)
	end
end

function var_0_0.onClose(arg_14_0)
	Season166Controller.instance:dispatchEvent(Season166Event.CloseBaseSpotView, {
		isEnter = false,
		baseSpotId = arg_14_0.baseId
	})
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
