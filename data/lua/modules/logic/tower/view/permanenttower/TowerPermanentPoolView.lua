module("modules.logic.tower.view.permanenttower.TowerPermanentPoolView", package.seeall)

slot0 = class("TowerPermanentPoolView", BaseView)

function slot0.onInitView(slot0)
	slot0._goPoolContent = gohelper.findChild(slot0.viewGO, "Left/#go_altitudePool")
	slot0._goaltitudeItem = gohelper.findChild(slot0.viewGO, "Left/#go_altitudePool/#go_altitudeItem")
	slot0._goeliteItem = gohelper.findChild(slot0.viewGO, "episode/#go_eliteEpisode/#go_eliteItem")
	slot0._goEliteEpisodeContent = gohelper.findChild(slot0.viewGO, "episode/#go_eliteEpisode/#go_eliteEpisodeContent")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0.altitudeItemPoolTab = slot0:getUserDataTb_()
	slot0.altitudeItemPoolList = slot0:getUserDataTb_()

	gohelper.setActive(slot0._goPoolContent, false)
	gohelper.setActive(slot0._goeliteItem, false)
	recthelper.setAnchorX(slot0._goPoolContent.transform, -10000)

	slot0.eliteEpisodeItemPoolTab = slot0:getUserDataTb_()
	slot0.eliteEpisodeItemPoolList = slot0:getUserDataTb_()

	gohelper.setActive(slot0._goEliteEpisodeContent, false)
end

function slot0.createOrGetAltitudeItem(slot0, slot1, slot2, slot3)
	if not slot0.altitudeItemPoolTab[slot1.index] then
		slot4 = {
			go = gohelper.clone(slot0._goaltitudeItem, slot0._goPoolContent, "altitude" .. slot1.index)
		}
		slot4.itemCanvasGroup = gohelper.findChild(slot4.go, "item"):GetComponent(gohelper.Type_CanvasGroup)
		slot4.goNormal = gohelper.findChild(slot4.go, "item/go_normal")
		slot4.goNormalSelect = gohelper.findChild(slot4.go, "item/go_normal/go_select")
		slot4.goNormalUnFinish = gohelper.findChild(slot4.go, "item/go_normal/go_unfinish")
		slot4.goNormalFinish = gohelper.findChild(slot4.go, "item/go_normal/go_finish")
		slot4.animNormalFinish = slot4.goNormalFinish:GetComponent(gohelper.Type_Animator)
		slot4.goNormalLock = gohelper.findChild(slot4.go, "item/go_normal/go_lock")
		slot4.goElite = gohelper.findChild(slot4.go, "item/go_elite")
		slot4.goEliteSelect = gohelper.findChild(slot4.go, "item/go_elite/go_select")
		slot4.goEliteUnFinish = gohelper.findChild(slot4.go, "item/go_elite/go_unfinish")
		slot4.goEliteFinish = gohelper.findChild(slot4.go, "item/go_elite/go_finish")
		slot4.animEliteFinish = slot4.goEliteFinish:GetComponent(gohelper.Type_Animator)
		slot4.goEliteLock = gohelper.findChild(slot4.go, "item/go_elite/go_lock")
		slot4.goArrow = gohelper.findChild(slot4.go, "go_arrow/arrow")
		slot4.goReward = gohelper.findChild(slot4.go, "go_arrow/Reward/image_RewardBG")
		slot4.simageReward = gohelper.findChildSingleImage(slot4.go, "go_arrow/Reward/image_RewardBG/simage_reward")
		slot4.txtNum = gohelper.findChildText(slot4.go, "item/txt_num")
		slot4.btnClick = gohelper.findChildButtonWithAudio(slot4.go, "btn_click")
		slot0.altitudeItemPoolTab[slot1.index] = slot4

		table.insert(slot0.altitudeItemPoolList, slot4)
	end

	slot4.btnClick:AddClickListener(slot2, slot3, slot1)

	return slot4
end

function slot0.recycleAltitudeItem(slot0, slot1)
	for slot5 = #slot1 + 1, #slot0.altitudeItemPoolList do
		if slot0.altitudeItemPoolList[slot5] then
			gohelper.setActive(slot0.altitudeItemPoolList[slot5].go, false)
			slot0.altitudeItemPoolList[slot5].go.transform:SetParent(slot0._goPoolContent.transform, false)
			recthelper.setAnchor(slot0.altitudeItemPoolList[slot5].go.transform, 0, 0)
		end
	end
end

function slot0.getaltitudeItemPoolList(slot0)
	return slot0.altitudeItemPoolList, slot0.altitudeItemPoolTab
end

function slot0.createOrGetEliteEpisodeItem(slot0, slot1, slot2, slot3)
	if not slot0.eliteEpisodeItemPoolTab[slot1] then
		slot4 = {
			go = gohelper.clone(slot0._goeliteItem, slot0._goEliteEpisodeContent, "eliteItem" .. slot1)
		}
		slot4.imageIcon = gohelper.findChildImage(slot4.go, "image_icon")
		slot4.goSelect = gohelper.findChild(slot4.go, "go_select")
		slot4.imageSelectIcon = gohelper.findChildImage(slot4.go, "go_select/image_selectIcon")
		slot4.imageSelectFinishIcon = gohelper.findChildImage(slot4.go, "go_select/image_selectFinishIcon")
		slot4.goFinish = gohelper.findChild(slot4.go, "go_finish")
		slot4.goFinishEffect = gohelper.findChild(slot4.go, "go_finishEffect")
		slot4.imageFinishIcon = gohelper.findChildImage(slot4.go, "go_finish/image_finishIcon")
		slot4.txtName = gohelper.findChildText(slot4.go, "txt_name")
		slot4.btnClick = gohelper.findChildButtonWithAudio(slot4.go, "btn_click")
		slot4.isSelect = false
		slot4.episodeIndex = slot1
		slot0.eliteEpisodeItemPoolTab[slot1] = slot4

		table.insert(slot0.eliteEpisodeItemPoolList, slot4)
	end

	slot4.btnClick:AddClickListener(slot2, slot3, slot1)

	return slot4
end

function slot0.recycleEliteEpisodeItem(slot0, slot1)
	for slot5 = #slot1 + 1, #slot0.eliteEpisodeItemPoolList do
		if slot0.eliteEpisodeItemPoolList[slot5] then
			gohelper.setActive(slot0.eliteEpisodeItemPoolList[slot5].go, false)
			slot0.eliteEpisodeItemPoolList[slot5].go.transform:SetParent(slot0._goEliteEpisodeContent.transform, false)
			recthelper.setAnchor(slot0.eliteEpisodeItemPoolList[slot5].go.transform, 0, 0)
		end
	end
end

function slot0.getEliteEpisodeItemPoolList(slot0)
	return slot0.eliteEpisodeItemPoolList, slot0.eliteEpisodeItemPoolTab
end

function slot0.onClose(slot0)
	for slot4, slot5 in pairs(slot0.altitudeItemPoolTab) do
		slot5.btnClick:RemoveClickListener()
		slot5.simageReward:UnLoadImage()
	end

	for slot4, slot5 in pairs(slot0.eliteEpisodeItemPoolList) do
		slot5.btnClick:RemoveClickListener()
	end
end

return slot0
