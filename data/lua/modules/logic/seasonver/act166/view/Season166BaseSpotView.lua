module("modules.logic.seasonver.act166.view.Season166BaseSpotView", package.seeall)

slot0 = class("Season166BaseSpotView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._goscoreInfo = gohelper.findChild(slot0.viewGO, "left/#go_scoreInfo")
	slot0._txtscore = gohelper.findChildText(slot0.viewGO, "left/#go_scoreInfo/#txt_score")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "right/episodeInfo/#txt_title")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/episodeInfo/#btn_detail")
	slot0._txtenemyinfo = gohelper.findChildText(slot0.viewGO, "right/episodeInfo/enemyInfo/enemyinfo/#txt_enemyinfo")
	slot0._txtepisodeInfo = gohelper.findChildText(slot0.viewGO, "right/episodeInfo/#txt_episodeInfo")
	slot0._gorewardContent = gohelper.findChild(slot0.viewGO, "right/reward/#go_rewardContent")
	slot0._gorewardItem = gohelper.findChild(slot0.viewGO, "right/reward/#go_rewardContent/#go_rewardItem")
	slot0._btnfight = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_fight")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
	slot0._btnfight:AddClickListener(slot0._btnfightOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndetail:RemoveClickListener()
	slot0._btnfight:RemoveClickListener()
end

function slot0._btndetailOnClick(slot0)
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(slot0.battleId)
end

function slot0._btnfightOnClick(slot0)
	Season166BaseSpotController.instance:enterBaseSpotFightScene({
		actId = slot0.actId,
		baseId = slot0.baseId
	})
end

function slot0._editableInitView(slot0)
	slot0.starTab = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		slot5 = {
			go = gohelper.findChild(slot0.viewGO, "left/#go_scoreInfo/stars/go_star" .. slot4)
		}
		slot5.imageStar = gohelper.findChildImage(slot5.go, "#go_Star" .. slot4)

		table.insert(slot0.starTab, slot5)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.config = slot0.viewParam.config
	slot0.baseId = slot0.viewParam.baseId
	slot0.episodeConfig = DungeonConfig.instance:getEpisodeCO(slot0.config.episodeId)
	slot0.battleId = slot0.episodeConfig.battleId

	if Season166Model.instance:getActInfo(slot0.actId).baseSpotInfoMap[slot0.baseId] and not slot2.isEnter then
		Activity166Rpc.instance:sendAct166EnterBaseRequest(slot0.actId, slot0.baseId)
	end

	slot3 = Season166Config.instance:getSeasonScoreCos(slot0.actId)
	slot0.finalLevelScore = slot3[#slot3].needScore

	Season166Controller.instance:dispatchEvent(Season166Event.OpenBaseSpotView, {
		isEnter = true,
		baseSpotId = slot0.baseId
	})
	Season166BaseSpotModel.instance:initBaseSpotData(slot0.actId, slot0.baseId)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshReward()
	slot0:refreshInfo()
	slot0:refreshScoreInfo()
end

function slot0.refreshReward(slot0)
	gohelper.CreateObjList(slot0, slot0.rewardItemShow, Season166Config.instance:getSeasonBaseLevelCos(slot0.actId, slot0.baseId), slot0._gorewardContent, slot0._gorewardItem)
end

function slot0.rewardItemShow(slot0, slot1, slot2, slot3)
	slot8 = Season166Config.instance:getSeasonScoreCo(slot0.actId, slot2.level).star
	gohelper.findChildText(slot1, "star/txt_starCount").text = slot8
	slot9 = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot1, "go_itempos"))
	slot10 = string.splitToNumber(slot2.firstBonus, "#")

	slot9:setMOValue(slot10[1], slot10[2], slot10[3])
	slot9:setHideLvAndBreakFlag(true)
	slot9:hideEquipLvAndBreak(true)
	slot9:setCountFontSize(51)
	gohelper.setActive(gohelper.findChild(slot1, "go_get"), slot8 <= Season166BaseSpotModel.instance:getStarCount(slot0.actId, slot0.baseId))
end

function slot0.refreshInfo(slot0)
	slot0._txttitle.text = GameUtil.setFirstStrSize(slot0.config.name, 102)
	slot0._txtepisodeInfo.text = slot0.config.desc
	slot0._txtenemyinfo.text = HeroConfig.instance:getLevelDisplayVariant(slot0.config.level)
end

function slot0.refreshScoreInfo(slot0)
	slot0._txtscore.text = Season166BaseSpotModel.instance:getBaseSpotMaxScore(slot0.actId, slot0.baseId)

	for slot7, slot8 in ipairs(slot0.starTab) do
		gohelper.setActive(slot8.go, slot7 <= #Season166Config.instance:getSeasonBaseLevelCos(slot0.actId, slot0.baseId))
		gohelper.setActive(slot8.imageStar.gameObject, slot7 <= Season166BaseSpotModel.instance:getStarCount(slot0.actId, slot0.baseId))
		UISpriteSetMgr.instance:setSeason166Sprite(slot8.imageStar, slot0.finalLevelScore <= slot1 and "season166_result_inclinedbulb3" or "season166_result_inclinedbulb2")
	end
end

function slot0.onClose(slot0)
	Season166Controller.instance:dispatchEvent(Season166Event.CloseBaseSpotView, {
		isEnter = false,
		baseSpotId = slot0.baseId
	})
end

function slot0.onDestroyView(slot0)
end

return slot0
