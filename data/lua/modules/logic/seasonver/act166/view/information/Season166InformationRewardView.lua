module("modules.logic.seasonver.act166.view.information.Season166InformationRewardView", package.seeall)

slot0 = class("Season166InformationRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0.txtTitle = gohelper.findChildTextMesh(slot0.viewGO, "Left/SmallTitle/txt_SmallTitle")
	slot0.rewardItems = {}
	slot0.goReward = gohelper.findChild(slot0.viewGO, "Bottom/SliderPoint/#go_rewards")

	gohelper.setActive(slot0.goReward, false)

	slot0.slider = gohelper.findChildSlider(slot0.viewGO, "Bottom/Slider")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.OnInformationUpdate, slot0.onInformationUpdate, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.OnGetInformationBonus, slot0.onGetInformationBonus, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onInformationUpdate(slot0)
	slot0:refreshUI()
end

function slot0.onGetInformationBonus(slot0)
end

function slot0.onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.CommonPropView or slot1 == ViewName.CharacterSkinGainView then
		slot0:refreshReward()
	end
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	if not slot0.actId then
		return
	end

	slot1 = Season166Model.instance:getActInfo(slot0.actId)
	slot2, slot3 = slot1:getBonusNum()
	slot0.txtTitle.text = GameUtil.getSubPlaceholderLuaLang(luaLang("season166_infoanalyze_rewardview_txt"), {
		slot2,
		slot3
	})
	slot0.infoAnalyCount = slot1:getInfoAnalyCount()

	slot0:refreshReward()
end

function slot0.refreshReward(slot0)
	if ViewMgr.instance:isOpen(ViewName.CommonPropView) or ViewMgr.instance:isOpen(ViewName.CharacterSkinGainView) then
		return
	end

	slot1 = Season166Config.instance:getSeasonInfoBonuss(slot0.actId) or {}
	slot5 = #slot0.rewardItems

	for slot5 = 1, math.max(#slot1, slot5) do
		slot0:refreshRewardItem(slot0.rewardItems[slot5] or slot0:createRewardItem(slot5), slot1[slot5])
	end

	slot0.slider:SetValue(Mathf.Clamp01((slot0.infoAnalyCount - 1) / (#slot1 - 1)))
end

function slot0.onGetReward(slot0, slot1)
	if not slot1.config then
		return
	end

	slot2 = slot1.config

	if Season166Model.instance:getActInfo(slot2.activityId):isBonusGet(slot2.analyCount) then
		slot0:showInfo(slot2)

		return
	end

	if slot2.analyCount <= slot0.infoAnalyCount then
		Activity166Rpc.instance:sendAct166ReceiveInformationBonusRequest(slot0.actId)
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

	gohelper.setActive(slot1.go, true)
	gohelper.setActive(slot1.goHasGet, Season166Model.instance:getActInfo(slot2.activityId):isBonusGet(slot2.analyCount))
	gohelper.setActive(slot1.goStatus, slot2.analyCount <= slot0.infoAnalyCount)
	gohelper.setActive(slot1.goCanget, not slot4 and slot2.analyCount <= slot0.infoAnalyCount)

	slot6 = GameUtil.splitString2(slot2.bonus, true)[1]
	slot7 = ItemModel.instance:getItemConfig(slot6[1], slot6[2])

	UISpriteSetMgr.instance:setUiFBSprite(slot1.imgBg, "bg_pinjidi_" .. slot7.rare)
	UISpriteSetMgr.instance:setUiFBSprite(slot1.imgCircle, "bg_pinjidi_lanse_" .. slot7.rare)

	slot1.txtCount.text = string.format("x%s", slot6[3])

	if slot6 then
		if not slot1.itemIcon then
			slot1.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot1.goIcon)
		end

		slot1.itemIcon:setMOValue(slot6[1], slot6[2], slot6[3], nil, true)
		slot1.itemIcon:isShowQuality(false)
		slot1.itemIcon:isShowCount(false)
	end

	if slot4 and slot1.hasGet == false then
		slot1.animStatus:Play("open")
	end

	slot1.hasGet = slot4
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.rewardItems) do
		slot5.btn:RemoveClickListener()
	end
end

return slot0
