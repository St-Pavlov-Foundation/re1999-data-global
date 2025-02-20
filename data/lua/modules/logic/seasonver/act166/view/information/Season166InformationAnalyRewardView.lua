module("modules.logic.seasonver.act166.view.information.Season166InformationAnalyRewardView", package.seeall)

slot0 = class("Season166InformationAnalyRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0.rewardItems = {}
	slot0.goReward = gohelper.findChild(slot0.viewGO, "Bottom/SliderPoint/#go_rewards")

	gohelper.setActive(slot0.goReward, false)

	slot0.slider = gohelper.findChildSlider(slot0.viewGO, "Bottom/Slider")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.OnAnalyInfoSuccess, slot0.onAnalyInfoSuccess, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.OnInformationUpdate, slot0.onInformationUpdate, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.OnGetInfoBonus, slot0.onGetInfoBonus, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.ChangeAnalyInfo, slot0.onChangeAnalyInfo, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onAnalyInfoSuccess(slot0)
	slot0:refreshUI()
end

function slot0.onChangeAnalyInfo(slot0, slot1)
	slot0.infoId = slot1

	for slot5, slot6 in ipairs(slot0.rewardItems) do
		slot6.activieStatus = nil
		slot6.hasGet = nil
	end

	slot0:refreshUI()
end

function slot0.onInformationUpdate(slot0)
	slot0:refreshUI()
end

function slot0.onGetInfoBonus(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.infoId = slot0.viewParam.infoId

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	if not slot0.actId then
		return
	end

	slot0:refreshReward()
end

function slot0.refreshReward(slot0)
	if ViewMgr.instance:isOpen(ViewName.CommonPropView) then
		return
	end

	slot2 = Season166Model.instance:getActInfo(slot0.actId):getInformationMO(slot0.infoId)
	slot7 = #(Season166Config.instance:getSeasonInfoAnalys(slot0.actId, slot0.infoId) or {})

	for slot7 = 1, math.max(slot7, #slot0.rewardItems) do
		slot0:refreshRewardItem(slot0.rewardItems[slot7] or slot0:createRewardItem(slot7), slot3[slot7])
	end

	slot0.slider:SetValue(Mathf.Clamp01((slot2.stage - 1) / (#slot3 - 1)))
end

function slot0.onGetReward(slot0, slot1)
	if not slot1.config then
		return
	end

	slot2 = slot1.config

	if slot2.stage <= Season166Model.instance:getActInfo(slot2.activityId):getInformationMO(slot2.infoId).bonusStage then
		slot0:showInfo(slot2)

		return
	end

	if slot2.stage <= slot4.stage then
		Activity166Rpc.instance:sendAct166ReceiveInfoBonusRequest(slot0.actId, slot0.infoId)
	else
		slot0:showInfo(slot2)
	end
end

function slot0.showInfo(slot0, slot1)
	slot3 = GameUtil.splitString2(slot1.bonus, true)[1]

	MaterialTipController.instance:showMaterialInfo(slot3[1], slot3[2], nil, , true)
end

function slot0.createRewardItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.cloneInPlace(slot0.goReward, string.format("reward%s", slot1))
	slot2.goStatus0 = gohelper.findChild(slot2.go, "image_status0")
	slot2.goStatus = gohelper.findChild(slot2.go, "#image_status")
	slot2.goReward = gohelper.findChild(slot2.go, "#go_reward_template")
	slot2.imgBg = gohelper.findChildImage(slot2.goReward, "image_bg")
	slot2.imgCircle = gohelper.findChildImage(slot2.goReward, "image_circle")
	slot2.goHasGet = gohelper.findChild(slot2.goReward, "go_hasget")
	slot2.goIcon = gohelper.findChild(slot2.goReward, "go_icon")
	slot2.txtCount = gohelper.findChildTextMesh(slot2.goReward, "txt_rewardcount")
	slot2.goCanget = gohelper.findChild(slot2.goReward, "go_canget")
	slot2.btn = gohelper.findButtonWithAudio(slot2.go)

	slot2.btn:AddClickListener(slot0.onGetReward, slot0, slot2)

	slot2.animStatus = slot2.goStatus:GetComponent(typeof(UnityEngine.Animator))
	slot2.animHasGet = slot2.goHasGet:GetComponent(typeof(UnityEngine.Animator))
	slot0.rewardItems[slot1] = slot2

	return slot2
end

function slot0.refreshRewardItem(slot0, slot1, slot2)
	slot1.config = slot2

	if not slot2 then
		gohelper.setActive(slot1.go, false)

		return
	end

	slot5 = slot2.stage <= Season166Model.instance:getActInfo(slot2.activityId):getInformationMO(slot2.infoId).bonusStage
	slot6 = slot2.stage <= slot4.stage

	gohelper.setActive(slot1.go, true)
	gohelper.setActive(slot1.goHasGet, slot5)
	gohelper.setActive(slot1.goStatus, slot6)
	gohelper.setActive(slot1.goCanget, not slot5 and slot6)

	slot8 = GameUtil.splitString2(slot2.bonus, true)[1]
	slot9 = ItemModel.instance:getItemConfig(slot8[1], slot8[2])

	UISpriteSetMgr.instance:setUiFBSprite(slot1.imgBg, "bg_pinjidi_" .. slot9.rare)
	UISpriteSetMgr.instance:setUiFBSprite(slot1.imgCircle, "bg_pinjidi_lanse_" .. slot9.rare)

	slot1.txtCount.text = string.format("x%s", slot8[3])

	if slot8 then
		if not slot1.itemIcon then
			slot1.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot1.goIcon)
		end

		slot1.itemIcon:setMOValue(slot8[1], slot8[2], slot8[3], nil, true)
		slot1.itemIcon:isShowQuality(false)
		slot1.itemIcon:isShowCount(false)
	end

	if slot5 and slot1.hasGet == false then
		slot1.animHasGet:Play("open")
	end

	if slot6 and slot1.activieStatus == false then
		slot1.animStatus:Play("open")
	end

	slot1.activieStatus = slot6
	slot1.hasGet = slot5
end

function slot0.onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.CommonPropView then
		slot0:refreshReward()
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.rewardItems) do
		slot5.btn:RemoveClickListener()
	end
end

return slot0
