module("modules.logic.versionactivity1_2.jiexika.view.Activity114TravelItem", package.seeall)

slot0 = class("Activity114TravelItem", LuaCompBase)

function slot0.ctor(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.go = slot1
	slot0.index = slot2
	slot0._golock = gohelper.findChild(slot0.go, "go_lock")
	slot0._gonormal = gohelper.findChild(slot0.go, "normal")
	slot0._name = gohelper.findChildTextMesh(slot0._gonormal, "name")
	slot0._nameEn = gohelper.findChildTextMesh(slot0._gonormal, "name/nameEn")
	slot0._gopoint = gohelper.findChild(slot0._gonormal, "point/go_point")
	slot0._goselect = gohelper.findChild(slot0.go, "go_select")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.go, "btn_click")
	slot0._selectAnim = SLFramework.AnimatorPlayer.Get(slot0._goselect)

	slot0:addEventListeners()
	slot0:onInitView()
end

function slot0.addEventListeners(slot0)
	slot0:addClickCb(slot0._btnclick, slot0._btnclickOnClick, slot0)
end

function slot0._btnclickOnClick(slot0)
	if slot0._eventStatu ~= Activity114Enum.TravelStatus.Normal then
		if slot0._eventStatu == Activity114Enum.TravelStatus.EventBlock or slot0._eventStatu == Activity114Enum.TravelStatus.EventEnd then
			GameFacade.showToast(ToastEnum.Act114TravelEnd)
		end

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_travel_circle)
	gohelper.setActive(slot0._goselect, true)
	slot0._selectAnim:Stop()
	slot0._selectAnim:Play(UIAnimationName.Open, slot0.showMsgBox, slot0)
	UIBlockMgr.instance:startBlock("Activity114TravelItem")
end

function slot0.showMsgBox(slot0)
	UIBlockMgr.instance:endBlock("Activity114TravelItem")
	slot0:onTravel()
end

function slot0.onTravel(slot0)
	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	Activity114Rpc.instance:travelRequest(Activity114Model.instance.id, slot0.index)
end

function slot0.cancelTravel(slot0)
	gohelper.setActive(slot0._goselect, false)
end

function slot0.onInitView(slot0)
	slot1 = Activity114Config.instance:getTravelCoList(Activity114Model.instance.id)[slot0.index]
	slot0.co = slot1
	slot0._name.text = slot1.place
	slot0._nameEn.text = slot1.placeEn
	slot3 = not Activity114Model.instance.unLockTravelDict[slot0.index]

	gohelper.setActive(slot0._golock, slot3)
	gohelper.setActive(slot0._gonormal, not slot3)
	gohelper.setActive(slot0._goselect, false)
	gohelper.setActive(slot0._gopoint, false)
	gohelper.setActive(slot0._btnclick.gameObject, not slot3)

	slot0._eventStatu = Activity114Enum.TravelStatus.Normal

	if slot3 then
		slot0._eventStatu = Activity114Enum.TravelStatus.TravelLock

		return
	end

	slot0.points = {}

	for slot9 = 1, #string.splitToNumber(slot1.events, "#") do
		slot10 = 1

		if slot2.times < slot9 and slot2.isBlock ~= 1 then
			slot10 = 1

			if Activity114Config.instance:getEventCoById(Activity114Model.instance.id, slot4[slot9]).config.isCheckEvent == 1 then
				if slot11.config.disposable == 1 then
					slot10 = 6
				else
					slot10 = 7
				end
			end
		elseif slot9 < slot5 or slot9 == slot5 and slot2.isBlock ~= 1 then
			slot10 = 2
		elseif slot9 == slot5 and slot2.isBlock == 1 then
			slot10 = 3
		elseif slot5 < slot9 and slot2.isBlock == 1 then
			slot10 = 4
		end

		slot0:_createPoint(slot9, slot10)
	end

	if slot2.isBlock == 1 then
		slot0._eventStatu = Activity114Enum.TravelStatus.EventBlock
	elseif not slot4[slot2.times + 1] then
		slot0._eventStatu = Activity114Enum.TravelStatus.EventEnd
	elseif not Activity114Model.instance.unLockEventDict[slot6] then
		slot0._eventStatu = Activity114Enum.TravelStatus.EventLock
	end

	if slot1.residentEvent > 0 then
		if slot0._eventStatu ~= Activity114Enum.TravelStatus.Normal then
			slot0._eventStatu = Activity114Enum.TravelStatus.Normal

			slot0:_createPoint(#slot0.points + 1, 5)
		end
	elseif slot2.hasSpecialEvent and slot1.specialEvents > 0 then
		slot0._eventStatu = Activity114Enum.TravelStatus.Normal
	end

	if not Activity114Model.instance:getIsPlayUnLock(Activity114Enum.EventType.Travel, slot2.travelId) then
		gohelper.setActive(slot0._golock, true)
		slot0:playUnlockEffect()
	end
end

function slot0._createPoint(slot0, slot1, slot2)
	slot0.points[slot1] = slot0:getUserDataTb_()
	slot0.points[slot1].go = gohelper.cloneInPlace(slot0._gopoint, "Point")
	slot6 = typeof
	slot0.points[slot1].anim = slot0.points[slot1].go:GetComponent(slot6(UnityEngine.Animator))

	gohelper.setActive(slot0.points[slot1].go, true)

	for slot6 = 1, 7 do
		gohelper.setActive(gohelper.findChild(slot0.points[slot1].go, "type" .. slot6), slot2 == slot6)
	end
end

function slot0.playUnlockEffect(slot0)
	for slot4 = 1, #slot0.points do
		slot0.points[slot4].anim:Play(UIAnimationName.Unlock, 0, 0)
	end

	slot1 = SLFramework.AnimatorPlayer.Get(slot0.go)

	slot1:Stop()
	slot1:Play(UIAnimationName.Unlock, slot0.playUnlockEffectFinish, slot0)
	Activity114Model.instance:setIsPlayUnLock(Activity114Enum.EventType.Travel, slot0.index)
end

function slot0.playUnlockEffectFinish(slot0)
	gohelper.setActive(slot0._golock, false)
end

function slot0.onDestroy(slot0)
	UIBlockMgr.instance:endBlock("Activity114TravelItem")

	if slot0.points then
		for slot4 = 1, #slot0.points do
			gohelper.destroy(slot0.points[slot4].go)
		end
	end

	slot0:__onDispose()
end

return slot0
