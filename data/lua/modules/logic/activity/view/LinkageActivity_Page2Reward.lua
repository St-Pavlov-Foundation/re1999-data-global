module("modules.logic.activity.view.LinkageActivity_Page2Reward", package.seeall)

slot0 = class("LinkageActivity_Page2Reward", LinkageActivity_Page2RewardBase)

function slot0.onInitView(slot0)
	slot0._txtNum = gohelper.findChildText(slot0.viewGO, "image_NumBG/#txt_Num")
	slot0._goCanGet = gohelper.findChild(slot0.viewGO, "#go_CanGet")
	slot0._goGet = gohelper.findChild(slot0.viewGO, "#go_Get")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = string.split

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	GameUtil.onDestroyViewMember(slot0, "_itemIcon")
	FrameTimerController.onDestroyViewMember(slot0, "_frameTimer")
	uv0.super.onDestroyView(slot0)
end

function slot0._editableAddEvents(slot0)
	uv0.super._editableInitView(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._OnOpenView, slot0)
end

function slot0._editableRemoveEvents(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0._OnOpenView, slot0)
end

function slot0._editableInitView(slot0)
	slot0._txtNum.text = ""

	slot0:setActive_goGet(false)
	slot0:setActive_goCanGet(false)

	slot0._imageRewardGo = gohelper.findChild(slot0.viewGO, "image_Reward")
	slot0._itemIcon = IconMgr.instance:getCommonPropItemIcon(slot0._imageRewardGo)
	slot0._imageRewardBG = gohelper.findChildImage(slot0.viewGO, "image_RewardBG")
	slot0._imageTipsBGGo = gohelper.findChild(slot0.viewGO, "image_TipsBG")
end

function slot0.onUpdateMO(slot0, slot1)
	uv0.super.onUpdateMO(slot0, slot1)

	slot3 = slot0:isType101RewardGet() and "#808080" or "#ffffff"
	slot5 = slot0._index

	assert(#uv1(slot0:getNorSignActivityCo().bonus, "|") == 1, string.format("[LinkageActivity_Page2Reward] rewardCount=%s", tostring(slot7)))

	slot8 = string.splitToNumber(slot6[1], "#")
	slot1._itemCo = slot8

	slot0._itemIcon:setMOValue(slot8[1], slot8[2], slot8[3])
	slot0._itemIcon:isShowQuality(false)
	slot0._itemIcon:isShowEquipAndItemCount(false)
	slot0._itemIcon:customOnClickCallback(slot0._onClick, slot0)

	if slot0._itemIcon:isEquipIcon() then
		slot0._itemIcon:setScale(0.7)
	else
		slot0._itemIcon:setScale(0.8)
	end

	slot0._itemIcon:setItemColor(slot3)
	UIColorHelper.set(slot0._imageRewardBG, slot3)

	slot0._txtNum.text = luaLang("multiple") .. slot11

	slot0:setActive_goGet(slot2)
	slot0:setActive_goCanGet(slot0:isType101RewardCouldGet())
	slot0:setActive_goTmr(slot0:getType101LoginCount() + 1 == slot5)
end

function slot0.setActive_goCanGet(slot0, slot1)
	gohelper.setActive(slot0._goCanGet, slot1)
end

function slot0.setActive_goGet(slot0, slot1)
	gohelper.setActive(slot0._goGet, slot1)
end

function slot0.setActive_goTmr(slot0, slot1)
	gohelper.setActive(slot0._imageTipsBGGo, slot1)
end

function slot0._onClaimAllCb(slot0)
	if not slot0:isType101RewardCouldGetAnyOne() then
		FrameTimerController.onDestroyViewMember(slot0, "_frameTimer")

		slot0._frameTimer = FrameTimerController.instance:register(function ()
			if ViewMgr.instance:isOpen(ViewName.CommonPropView) or ViewMgr.instance:isOpen(ViewName.RoomBlockPackageGetView) then
				FrameTimerController.onDestroyViewMember(uv0, "_frameTimer")
				uv0:_assetGetViewContainer():switchPage(1)
			end
		end, nil, 6, 6)

		slot0._frameTimer:Start()
	end
end

function slot0._onClick(slot0)
	if not slot0:isActOnLine() then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	if slot0:isType101RewardCouldGet() then
		slot0:sendGet101BonusRequest(slot0._onClaimAllCb, slot0)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_tags_2000013)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_25050217)

	slot3 = slot0._mo._itemCo

	MaterialTipController.instance:showMaterialInfo(slot3[1], slot3[2])
end

function slot0._OnOpenView(slot0, slot1)
	if slot1 == ViewName.RoomBlockPackageGetView then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shenghuo_building_collect_20234002)
	end
end

return slot0
