module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotProgressItem", package.seeall)

slot0 = class("V1a6_CachotProgressItem", MixScrollCell)

function slot0.init(slot0, slot1)
	slot0._gounlock = gohelper.findChild(slot1, "#go_unlock")
	slot0._golock = gohelper.findChild(slot1, "#go_lock")
	slot0._txtscore = gohelper.findChildText(slot1, "#go_unlock/scorebg/#txt_score")
	slot0._gorewarditem = gohelper.findChild(slot1, "#go_unlock/#go_item/#go_rewarditem")
	slot0._imagepoint = gohelper.findChildImage(slot1, "#go_unlock/#image_point")
	slot0._txtlocktip = gohelper.findChildText(slot1, "#go_lock/#txt_locktip")
	slot0._txtindex = gohelper.findChildText(slot1, "#go_unlock/#txt_index")
	slot0._gospecial = gohelper.findChild(slot1, "#go_unlock/#go_special")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onDestroy(slot0)
	slot0:releaseRewardIconTab()
	TaskDispatcher.cancelTask(slot0.refreshUnLockNextStageTimeUI, slot0)
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3)
	slot0._mo = slot1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._golock, slot0._mo.isLocked)
	gohelper.setActive(slot0._gounlock, not slot0._mo.isLocked)
	TaskDispatcher.cancelTask(slot0.refreshUnLockNextStageTimeUI, slot0)

	if slot0._mo.isLocked then
		slot0:onItemLocked()

		return
	end

	if V1a6_CachotScoreConfig.instance:getStagePartConfig(slot0._mo.id) then
		slot2 = V1a6_CachotProgressListModel.instance:getRewardState(slot0._mo.id)

		slot0:refreshNormalUI(slot1)
		slot0:refreshStateUI(slot1, slot2)
		slot0:refreshRewardItems(slot1.reward, slot2)
	end
end

function slot0.refreshNormalUI(slot0, slot1)
	gohelper.setActive(slot0._gospecial, slot1 and slot1.special == 1)
end

function slot0.onItemLocked(slot0)
	TaskDispatcher.cancelTask(slot0.refreshUnLockNextStageTimeUI, slot0)
	TaskDispatcher.runRepeat(slot0.refreshUnLockNextStageTimeUI, slot0, TimeUtil.OneMinuteSecond)
	slot0:refreshUnLockNextStageTimeUI()
end

function slot0.refreshUnLockNextStageTimeUI(slot0)
	if V1a6_CachotProgressListModel.instance:getUnLockNextStageRemainTime() and slot1 > 0 then
		slot2, slot3 = TimeUtil.secondsToDDHHMMSS(slot1)

		if slot2 > 0 then
			slot0._txtlocktip.text = formatLuaLang("v1a6_cachotprogressview_unlocktips_days", slot2)
		else
			slot0._txtlocktip.text = formatLuaLang("v1a6_cachotprogressview_unlocktips_hours", slot3)
		end
	else
		TaskDispatcher.cancelTask(slot0.refreshUnLockNextStageTimeUI, slot0)
	end
end

slot1 = "#DB7D29"
slot2 = "#FFFFFF"
slot3 = 0.3
slot4 = 0.3
slot5 = "#DB7D29"
slot6 = "#8E8E8E"

function slot0.refreshStateUI(slot0, slot1, slot2)
	slot3 = "v1a6_cachot_icon_pointdark"
	slot4 = uv0
	slot5 = uv1
	slot6 = uv2

	if slot2 == V1a6_CachotEnum.MilestonesState.UnFinish then
		slot3 = slot1 and slot1.special == 1 and "v1a6_cachot_icon_pointdark2" or "v1a6_cachot_icon_pointdark"
	else
		slot3 = slot7 and "v1a6_cachot_icon_pointlight2" or "v1a6_cachot_icon_pointlight"
		slot4 = uv3
		slot5 = uv4
		slot6 = uv5
	end

	UISpriteSetMgr.instance:setV1a6CachotSprite(slot0._imagepoint, slot3)

	slot0._txtscore.text = string.format("<%s>%s</color>", slot6, slot1.score)
	slot0._txtindex.text = slot0._index

	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtindex, slot4)
	ZProj.UGUIHelper.SetColorAlpha(slot0._txtindex, slot5)
end

slot7 = 0.5
slot8 = 1
slot9 = 0.5
slot10 = 1
slot11 = 0.5
slot12 = 1

function slot0.refreshRewardItems(slot0, slot1, slot2)
	slot3 = {}

	function slot4(slot0)
		slot1 = slot0.simageicon.gameObject:GetComponent(typeof(UnityEngine.UI.Image))

		slot1:SetNativeSize()
		ZProj.UGUIHelper.SetColorAlpha(slot1, uv0 == V1a6_CachotEnum.MilestonesState.HasReceived and uv1 or uv2)
	end

	if slot1 then
		for slot9 = 1, #string.split(slot1, "|") do
			slot11 = slot0:getOrCreateRewardItem(slot9)

			slot0:refreshSingleRewardItem(slot11, string.splitToNumber(slot5[slot9], "#"), slot2, slot4)

			slot3[slot11] = true
		end
	end

	slot0:recycleUnUseRewardItem(slot3)
end

function slot0.getOrCreateRewardItem(slot0, slot1)
	slot0._rewardItemTab = slot0._rewardItemTab or {}

	if not slot0._rewardItemTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._gorewarditem, "reward_" .. slot1)
		slot2.imagebg = gohelper.findChildImage(slot2.go, "bg")
		slot2.simageicon = gohelper.findChildSingleImage(slot2.go, "simage_reward")
		slot2.goheadframe = gohelper.findChild(slot2.go, "go_headframe")
		slot2.frameCanvasGroup = gohelper.onceAddComponent(slot2.goheadframe, typeof(UnityEngine.CanvasGroup))
		slot2.gocanget = gohelper.findChild(slot2.go, "go_canget")
		slot2.gohasget = gohelper.findChild(slot2.go, "go_hasget")
		slot2.txtrewardcount = gohelper.findChildText(slot2.go, "txt_rewardcount")
		slot2.btnclick = gohelper.findChildButtonWithAudio(slot2.go, "btn_click")
		slot0._rewardItemTab[slot1] = slot2
	end

	return slot2
end

function slot0.refreshSingleRewardItem(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot2 and slot2[1]
	slot7 = slot2 and slot2[3]
	slot8, slot9 = ItemModel.instance:getItemConfigAndIcon(slot5, slot2 and slot2[2])

	UISpriteSetMgr.instance:setV1a6CachotSprite(slot1.imagebg, "v1a6_cachot_img_quality_" .. slot8.rare)
	ZProj.UGUIHelper.SetColorAlpha(slot1.imagebg, slot3 == V1a6_CachotEnum.MilestonesState.HasReceived and uv0 or uv1)
	gohelper.setActive(slot1.goheadframe, false)
	gohelper.setActive(slot1.txtrewardcount, true)

	if slot5 == MaterialEnum.MaterialType.Equip then
		slot1.simageicon:LoadImage(ResUrl.getHeroDefaultEquipIcon(slot8.icon), slot4, slot1)
	elseif slot8.subType == ItemEnum.SubType.Portrait then
		slot10 = slot3 == V1a6_CachotEnum.MilestonesState.HasReceived and uv2 or uv3

		if not slot0._liveHeadIcon then
			slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot1.simageicon)
		end

		slot0._liveHeadIcon:setLiveHead(tonumber(slot8.icon), true, nil, function (slot0, slot1)
			slot1:setAlpha(uv0)
		end, slot0)
		gohelper.setActive(slot1.goheadframe, true)
		gohelper.setActive(slot1.txtrewardcount, false)

		slot1.frameCanvasGroup.alpha = slot10
	else
		slot1.simageicon:LoadImage(slot9, slot4, slot1)
	end

	slot1.txtrewardcount.text = formatLuaLang("cachotprogressview_rewardcount", slot7)

	gohelper.setActive(slot1.gohasget, slot3 == V1a6_CachotEnum.MilestonesState.HasReceived)
	gohelper.setActive(slot1.gocanget, slot3 == V1a6_CachotEnum.MilestonesState.CanReceive)
	gohelper.setActive(slot1.go, true)
	slot1.btnclick:RemoveClickListener()
	slot1.btnclick:AddClickListener(slot0.onClickRewardItem, slot0, slot2)
end

function slot0.onClickRewardItem(slot0, slot1)
	if V1a6_CachotProgressListModel.instance:getRewardState(slot0._mo.id) == V1a6_CachotEnum.MilestonesState.CanReceive then
		RogueRpc.instance:sendGetRogueScoreRewardRequest(V1a6_CachotEnum.ActivityId, V1a6_CachotProgressListModel.instance:getCanReceivePartIdList())
	elseif slot1 then
		MaterialTipController.instance:showMaterialInfo(slot1[1], slot1[2])
	end
end

function slot0.recycleUnUseRewardItem(slot0, slot1)
	if slot1 and slot0._rewardItemTab then
		for slot5, slot6 in pairs(slot0._rewardItemTab) do
			if not slot1[slot6] then
				gohelper.setActive(slot6.go, false)
			end
		end
	end
end

function slot0.releaseRewardIconTab(slot0)
	if slot0._rewardItemTab then
		for slot4, slot5 in pairs(slot0._rewardItemTab) do
			if slot5.btnclick then
				slot5.btnclick:RemoveClickListener()
			end

			if slot5.simageicon then
				slot5.simageicon:UnLoadImage()
			end
		end
	end
end

return slot0
