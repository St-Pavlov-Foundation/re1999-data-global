module("modules.logic.versionactivity2_3.act174.view.Act174SettlementView", package.seeall)

slot0 = class("Act174SettlementView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtWinCnt = gohelper.findChildText(slot0.viewGO, "Right/fight/#txt_WinCnt")
	slot0._txtLoseCnt = gohelper.findChildText(slot0.viewGO, "Right/fight/#txt_LoseCnt")
	slot0._gobadgeItem = gohelper.findChild(slot0.viewGO, "Right/badge/layout/#go_badgeItem")
	slot0._txtScore = gohelper.findChildText(slot0.viewGO, "Right/score/#txt_Score")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.animEvent = slot0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)

	slot0.animEvent:AddEventListener("PlayBadgeAnim", slot0.playBadgeAnim, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.actInfo = Activity174Model.instance:getActInfo()
	slot0.gameInfo = slot0.actInfo:getGameInfo()
	slot0.gameEndInfo = slot0.actInfo:getGameEndInfo()

	slot0:refreshLeft()
	slot0:refreshRight()
	AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shenghuo_dqq_fight_end)
end

function slot0.onClose(slot0)
	if slot0.gameEndInfo and slot0.gameEndInfo.gainScore ~= 0 then
		slot1 = MaterialDataMO.New()

		slot1:initValue(2, 2302, slot0.gameEndInfo.gainScore)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, {
			slot1
		})
	end

	slot0.actInfo:clearEndInfo()
end

function slot0.onDestroyView(slot0)
	slot0.animEvent:RemoveEventListener("PlayBadgeAnim")
end

function slot0.refreshLeft(slot0)
	slot2 = gohelper.findChild(slot0.viewGO, "Left/Group/playergroup")

	if slot0.actInfo:getGameInfo():getTeamMoList() then
		for slot6, slot7 in ipairs(slot1) do
			slot13 = "act174_ready_num_0" .. slot7.index

			UISpriteSetMgr.instance:setAct174Sprite(gohelper.findChildImage(gohelper.cloneInPlace(slot2), "numbg/image_Num"), slot13)

			for slot13 = 1, 4 do
				slot16 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity174Enum.PrefabPath.BattleHero, slot8), Act174BattleHeroItem)

				slot16:setIndex(slot13)
				slot16:setData(Activity174Helper.MatchKeyInArray(slot7.battleHeroInfo, slot13, "index"), slot7.index, false)
			end
		end
	end

	gohelper.setActive(slot2, false)
end

function slot0.refreshRight(slot0)
	slot0._txtLoseCnt.text = slot0.gameEndInfo.winNum
	slot0._txtWinCnt.text = slot0.gameEndInfo.loseNum

	slot0:initBadge()

	slot0._txtScore.text = slot0.gameEndInfo.gainScore
end

function slot0.initBadge(slot0)
	slot0.badgeItemList = {}

	for slot6, slot7 in ipairs(slot0.actInfo:getBadgeMoList()) do
		slot9 = gohelper.cloneInPlace(slot0._gobadgeItem)
		slot0:getUserDataTb_().Icon = gohelper.findChildSingleImage(slot9, "root/image_icon")
		slot11 = gohelper.findChildText(slot9, "root/txt_score")
		gohelper.findChildText(slot9, "root/txt_num").text = slot7.count

		if slot0.actInfo:getBadgeScoreChangeDic()[slot7.id] and slot12 ~= 0 then
			slot11.text = "+" .. slot12
		end

		gohelper.setActive(slot11, slot12 ~= 0)
		slot8.Icon:LoadImage(ResUrl.getAct174BadgeIcon(slot7.config.icon, slot7:getState()))

		slot8.anim = slot9:GetComponent(gohelper.Type_Animator)
		slot8.id = slot7.id
		slot0.badgeItemList[#slot0.badgeItemList] = slot8
	end

	gohelper.setActive(slot0._gobadgeItem, false)
end

function slot0.playBadgeAnim(slot0)
	for slot5, slot6 in ipairs(slot0.badgeItemList) do
		if slot0.actInfo:getBadgeScoreChangeDic()[slot6.id] and slot7 ~= 0 then
			slot6.anim:Play("refresh")
		end
	end
end

return slot0
