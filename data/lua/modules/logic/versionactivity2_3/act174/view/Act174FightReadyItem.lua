module("modules.logic.versionactivity2_3.act174.view.Act174FightReadyItem", package.seeall)

slot0 = class("Act174FightReadyItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._readyView = slot1
end

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0.transform = slot1.transform
	slot0._imageNum = gohelper.findChildImage(slot1, "numbg/image_Num")

	CommonDragHelper.instance:registerDragObj(slot1, slot0.beginDrag, slot0.onDrag, slot0.endDrag, slot0.checkDrag, slot0, nil, true)
	slot0:initBattleHero()
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onDestroy(slot0)
	CommonDragHelper.instance:unregisterDragObj(slot0._go)
end

function slot0.initBattleHero(slot0)
	slot0.heroItemList = {}

	for slot4 = 1, 4 do
		slot0.heroItemList[slot4] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._readyView:getResInst(Activity174Enum.PrefabPath.BattleHero, slot0._go), Act174BattleHeroItem, slot0)
	end
end

function slot0.setData(slot0, slot1, slot2)
	slot0.teamInfo = slot1
	slot0.reverse = slot2

	if slot1 then
		slot0.index = slot1.index

		UISpriteSetMgr.instance:setAct174Sprite(slot0._imageNum, "act174_ready_num_0" .. slot0.index)
		slot0:refreshTeam()
	end
end

function slot0.refreshTeam(slot0)
	if slot0.reverse then
		for slot4 = 4, 1, -1 do
			slot5 = math.abs(slot4 - 5)

			slot0.heroItemList[slot5]:setIndex(slot4)
			slot0.heroItemList[slot5]:setData(Activity174Helper.MatchKeyInArray(slot0.teamInfo.battleHeroInfo, slot4, "index"), slot0.teamInfo.index, true)
		end
	else
		for slot4 = 1, 4 do
			slot0.heroItemList[slot4]:setIndex(slot4)
			slot0.heroItemList[slot4]:setData(Activity174Helper.MatchKeyInArray(slot0.teamInfo.battleHeroInfo, slot4, "index"), slot0.teamInfo.index, false)
		end
	end
end

function slot0.beginDrag(slot0)
	slot0.isDraging = true
end

function slot0.onDrag(slot0, slot1, slot2)
	slot0:_tweenToPos(slot0._go.transform, slot2.position)
	gohelper.setAsLastSibling(slot0._go)
end

function slot0.endDrag(slot0, slot1, slot2)
	slot0.isDraging = false

	if not slot0:findTarget(slot2.position) then
		slot0:setToPos(slot0._go.transform, recthelper.rectToRelativeAnchorPos(slot0._readyView.frameTrList[slot0.index].position, slot0.transform.parent), true, slot0.tweenCallback, slot0)
	else
		slot0:setToPos(slot0.transform, recthelper.rectToRelativeAnchorPos(slot0._readyView.frameTrList[slot4.index].position, slot0.transform.parent), true, slot0.tweenCallback, slot0)

		if slot4 ~= slot0 then
			slot8 = slot4.index

			slot0:setToPos(slot4.transform, recthelper.rectToRelativeAnchorPos(slot0._readyView.frameTrList[slot0.index].position, slot4.transform.parent), true, function ()
				uv0._readyView:exchangeItem(uv0.index, uv1)
			end, slot0)
		end
	end

	AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shenghuo_dqq_move)
end

function slot0.checkDrag(slot0)
	if slot0._readyView.unLockTeamCnt == 1 or slot0.reverse or slot0.isDraging or slot0.tweenId then
		return true
	end
end

function slot0.findTarget(slot0, slot1)
	for slot5 = 1, slot0._readyView.unLockTeamCnt do
		slot6 = slot0._readyView.frameTrList[slot5]
		slot7, slot8 = recthelper.getAnchor(slot6)

		if math.abs((recthelper.screenPosToAnchorPos(slot1, slot6.parent).x - (slot7 - 416)) * 2) < recthelper.getWidth(slot6) and math.abs((slot10.y - (slot8 + 276)) * 2) < recthelper.getHeight(slot6) then
			return slot0._readyView.readyItemList[slot5] or nil
		end
	end

	return nil
end

function slot0.setToPos(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot3 then
		CommonDragHelper.instance:setGlobalEnabled(false)

		slot0.tweenId = ZProj.TweenHelper.DOAnchorPos(slot1, slot2.x, slot2.y, 0.2, slot4, slot5)
	else
		recthelper.setAnchor(slot1, slot2.x, slot2.y)

		if slot4 then
			slot4(slot5)
		end
	end
end

function slot0.tweenCallback(slot0)
	slot0.tweenId = nil

	CommonDragHelper.instance:setGlobalEnabled(true)
end

function slot0._tweenToPos(slot0, slot1, slot2)
	slot4, slot5 = recthelper.getAnchor(slot1)

	if math.abs(slot4 - recthelper.screenPosToAnchorPos(slot2, slot1.parent).x) > 10 or math.abs(slot5 - slot3.y) > 10 then
		ZProj.TweenHelper.DOAnchorPos(slot1, slot3.x, slot3.y, 0.2)
	else
		recthelper.setAnchor(slot1, slot3.x, slot3.y)
	end
end

return slot0
