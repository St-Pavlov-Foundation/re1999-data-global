module("modules.logic.seasonver.act123.view2_1.Season123_2_1RecordWindowItem", package.seeall)

slot0 = class("Season123_2_1RecordWindowItem", LuaCompBase)
slot1 = 6

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._gobestrecord = gohelper.findChild(slot0.go, "#go_bestrecord")
	slot0._gonormalrecord = gohelper.findChild(slot0.go, "#go_normalrecord")
	slot0._txtTotalEn = gohelper.findChildText(slot0.go, "#go_normalrecord/en1")
	slot0._goBestBg = gohelper.findChild(slot0.go, "#go_normalrecord/totaltime/#img_bestBg")
	slot0._goBestCircle = gohelper.findChild(slot0.go, "#go_normalrecord/totaltime/#go_bestcircle")
	slot0._txtBlueTxtTime = gohelper.findChildText(slot0.go, "#go_normalrecord/totaltime/#go_bestcircle/#txt_timeblue")
	slot0._txttime = gohelper.findChildText(slot0.go, "#go_normalrecord/totaltime/#txt_time")
	slot0._btndetails = gohelper.findChildButtonWithAudio(slot0.go, "#go_normalrecord/#btn_details")
	slot0._transHeroList = gohelper.findChild(slot0.go, "#go_normalrecord/#scroll_herolist").transform
	slot0._originalHeroListY = recthelper.getAnchorY(slot0._transHeroList)
	slot0._goContent = gohelper.findChild(slot0.go, "#go_normalrecord/#scroll_herolist/Viewport/Content")
	slot0._goheroitem = gohelper.findChild(slot0.go, "#go_normalrecord/#scroll_herolist/Viewport/Content/#go_heroitem")
	slot0._itemAni = slot0.go:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.addEventListeners(slot0)
	slot0._btndetails:AddClickListener(slot0._btndetailsOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btndetails:RemoveClickListener()
end

function slot0._btndetailsOnClick(slot0)
	if not slot0.mo or not slot0.mo.attackStatistics then
		return
	end

	FightStatModel.instance:setAtkStatInfo(slot0.mo.attackStatistics)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function slot0.onLoad(slot0, slot1, slot2)
	gohelper.setActive(slot0.go, false)

	slot0._isPlayOpen = slot2

	TaskDispatcher.runDelay(slot0._delayActive, slot0, slot1)
end

function slot0._delayActive(slot0)
	gohelper.setActive(slot0.go, true)
	slot0:playAnimation(slot0._isPlayOpen and UIAnimationName.Open or UIAnimationName.Idle)

	slot0._isPlayOpen = false
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.mo = slot1

	if not slot0.mo or slot0.mo.isEmpty then
		gohelper.setActive(slot0._gobestrecord, false)
		gohelper.setActive(slot0._gonormalrecord, false)

		return
	end

	gohelper.setActive(slot0._gonormalrecord, true)

	slot2 = slot0.mo.round or 0
	slot3 = slot0.mo.isBest
	slot0._txttime.text = slot2
	slot0._txtBlueTxtTime.text = slot2

	gohelper.setActive(slot0._gobestrecord, slot3)
	gohelper.setActive(slot0._goBestBg, slot3)
	gohelper.setActive(slot0._goBestCircle, slot3)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtTotalEn, slot3 and "#7D4A29" or "#393939")
	recthelper.setAnchorY(slot0._transHeroList, slot3 and slot0._originalHeroListY or slot0._originalHeroListY + uv0)
	gohelper.CreateObjList(slot0, slot0._onHeroItemLoad, slot0.mo.heroList or {}, slot0._goContent, slot0._goheroitem)
end

function slot0.playAnimation(slot0, slot1)
	if not slot0._itemAni then
		return
	end

	slot0._itemAni:Play(slot1 or UIAnimationName.Idle)
end

function slot0._onHeroItemLoad(slot0, slot1, slot2, slot3)
	if gohelper.isNil(slot1) then
		return
	end

	slot4 = gohelper.findChild(slot1, "empty")
	slot5 = gohelper.findChild(slot1, "assist")
	slot6 = gohelper.findChild(slot1, "hero")
	slot7, slot8 = nil

	if slot2.heroId and slot9 ~= 0 then
		slot7 = HeroConfig.instance:getHeroCO(slot9)
	end

	if not gohelper.isNil(slot6) then
		slot8 = IconMgr.instance:getCommonHeroIconNew(slot6)
	end

	if slot7 and slot8 then
		slot10 = slot2.level or 1
		slot14 = HeroMo.New()

		slot14:initFromConfig(slot7)

		slot15, slot14.rank = HeroConfig.instance:getShowLevel(slot10)
		slot14.level = slot10
		slot14.skin = slot2.skinId or slot7.skinId

		slot8:onUpdateMO(slot14)
		slot8:isShowRare(false)
		slot8:isShowEmptyWhenNoneHero(false)
		slot8:setIsBalance(slot2.isBalance)
		gohelper.setActive(slot6, true)
		gohelper.setActive(slot5, slot2.isAssist)
		gohelper.setActive(slot4, false)
	else
		gohelper.setActive(slot6, false)
		gohelper.setActive(slot5, false)
		gohelper.setActive(slot4, true)
	end
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._delayActive, slot0)

	slot0._isPlayOpen = false
end

return slot0
