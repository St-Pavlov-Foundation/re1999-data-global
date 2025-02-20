module("modules.logic.dungeon.view.rolestory.RoleStoryRewardItem", package.seeall)

slot0 = class("RoleStoryRewardItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._rectTransform = slot0.viewGO.transform
	slot0._gospecial = gohelper.findChild(slot0.viewGO, "#go_special")
	slot0.txtScore = gohelper.findChildTextMesh(slot0.viewGO, "scorebg/#txt_score")
	slot0.normalbg = gohelper.findChild(slot0.viewGO, "scorebg/normalbg")
	slot0.txtIndex = gohelper.findChildTextMesh(slot0.viewGO, "#txt_index")
	slot0._imagepoint = gohelper.findChildImage(slot0.viewGO, "#image_point")
	slot0._goRewardParent = gohelper.findChild(slot0.viewGO, "#go_item")
	slot0._rectRewardParent = slot0._goRewardParent.transform
	slot0._goRewardTemplate = gohelper.findChild(slot0.viewGO, "#go_item/#go_rewarditem")

	gohelper.setActive(slot0._goRewardTemplate, false)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.refresh(slot0, slot1)
	if slot1 then
		slot0:onUpdateMO(slot1)
		gohelper.setActive(slot0.viewGO, true)
	else
		slot0.data = nil

		gohelper.setActive(slot0.viewGO, false)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.data = slot1

	slot0:refreshReward(slot1)
	slot0:refreshChapter(slot1)
end

function slot0.refreshReward(slot0, slot1)
	slot3 = GameUtil.splitString2(slot1.config.bonus, true) or {}

	if not slot0._rewardItems then
		slot0._rewardItems = {}
	end

	slot7 = #slot0._rewardItems

	for slot7 = 1, math.max(slot7, #slot3) do
		slot8 = slot3[slot7]

		if not slot0._rewardItems[slot7] then
			slot0._rewardItems[slot7] = slot0:createRewardItem(slot7)
		end

		slot0:refreshRewardItem(slot9, slot8)
	end
end

function slot0.createRewardItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot3 = gohelper.clone(slot0._goRewardTemplate, slot0._goRewardParent, "reward_" .. tostring(slot1))
	slot2.go = slot3
	slot2.imagebg = gohelper.findChildImage(slot3, "bg")
	slot2.simagereward = gohelper.findChildSingleImage(slot3, "simage_reward")
	slot2.imagereward = gohelper.findChildImage(slot3, "simage_reward")
	slot2.txtrewardcount = gohelper.findChildText(slot3, "txt_rewardcount")
	slot2.goalreadygot = gohelper.findChild(slot3, "go_hasget")
	slot2.gocanget = gohelper.findChild(slot3, "go_canget")
	slot2.btn = gohelper.findChildButtonWithAudio(slot3, "btn_click")

	slot2.btn:AddClickListener(slot0.onClickItem, slot0, slot2)

	slot2.rewardAnim = slot2.go:GetComponent(typeof(UnityEngine.Animator))

	function slot2.onLoadImageCallback(slot0)
		slot0.imagereward:SetNativeSize()
	end

	return slot2
end

slot1 = Color.New(1, 1, 1, 1)

function slot0.refreshRewardItem(slot0, slot1, slot2)
	slot1.data = slot2

	if not slot2 then
		gohelper.setActive(slot1.go, false)

		return
	end

	gohelper.setActive(slot1.go, true)

	slot3 = slot0.data.config
	slot4 = RoleStoryModel.instance:getRewardState(slot3.storyId, slot3.id, slot3.score)
	slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(slot2[1], slot2[2])

	if slot5 then
		UISpriteSetMgr.instance:setUiFBSprite(slot1.imagebg, "bg_pinjidi_" .. slot5.rare)
	end

	if slot2[1] == MaterialEnum.MaterialType.Equip then
		slot6 = ResUrl.getHeroDefaultEquipIcon(slot5.icon)
	end

	if slot6 then
		slot1.simagereward:LoadImage(slot6, slot1.onLoadImageCallback, slot1)
	end

	slot1.txtrewardcount.text = string.format("<size=25>x</size>%s", tostring(slot2[3]))

	gohelper.setActive(slot1.goalreadygot, slot4 == 2)
	gohelper.setActive(slot1.gocanget, slot4 == 1)

	if slot4 == 2 then
		slot1.rewardAnim.enabled = true

		slot1.rewardAnim:Play("dungeoncumulativerewardsitem_receiveenter")
	elseif slot4 == 1 then
		slot1.rewardAnim.enabled = true

		slot1.rewardAnim:Play("dungeoncumulativerewardsitem_received")
	else
		slot1.rewardAnim.enabled = false
		slot1.imagereward.color = uv0
		slot1.imagebg.color = uv0
	end
end

function slot0.onClickItem(slot0, slot1)
	if not slot0.data then
		return
	end

	slot2 = slot0.data.config

	if RoleStoryModel.instance:getRewardState(slot2.storyId, slot2.id, slot2.score) == 1 then
		slot4 = {}

		if RoleStoryConfig.instance:getRewardList(slot2.storyId) then
			for slot9, slot10 in ipairs(slot5) do
				if RoleStoryModel.instance:getRewardState(slot10.storyId, slot10.id, slot10.score) == 1 then
					table.insert(slot4, slot10.id)
				end
			end
		end

		if #slot4 > 0 then
			HeroStoryRpc.instance:sendGetScoreBonusRequest(slot4)
		end
	elseif slot1.data then
		MaterialTipController.instance:showMaterialInfo(slot1.data[1], slot1.data[2])
	end
end

slot2 = "#DB7D29"
slot3 = "#FFFFFF"
slot4 = 0.86
slot5 = 0.86
slot6 = "#DB7D29"
slot7 = "#8E8E8E"

function slot0.refreshChapter(slot0, slot1)
	slot2 = slot0.data.config
	slot5 = "v1a6_cachot_icon_pointdark"
	slot6 = uv0
	slot7 = uv1
	slot8 = uv2

	if RoleStoryModel.instance:getRewardState(slot2.storyId, slot2.id, slot2.score) == 0 then
		slot5 = slot2.keyReward == 1 and "v1a6_cachot_icon_pointdark2" or "v1a6_cachot_icon_pointdark"
	else
		slot5 = slot4 and "v1a6_cachot_icon_pointlight2" or "v1a6_cachot_icon_pointlight"
		slot6 = uv3
		slot7 = uv4
		slot8 = uv5
	end

	UISpriteSetMgr.instance:setV1a6CachotSprite(slot0._imagepoint, slot5)

	slot0.txtScore.text = string.format("<color=%s>%s</color>", slot8, slot2.score)
	slot0.txtIndex.text = string.format("<color=%s>%02d</color>", slot8, slot0.data.index)

	ZProj.UGUIHelper.SetColorAlpha(slot0.txtIndex, slot7)
	gohelper.setActive(slot0._gospecial, slot4 and not slot0.data.isTarget)
	gohelper.setActive(slot0.normalbg, slot4 and slot0.data.isTarget)
end

function slot0._editableInitView(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._rewardItems then
		for slot4, slot5 in pairs(slot0._rewardItems) do
			slot5.btn:RemoveClickListener()
			slot5.simagereward:UnLoadImage()
		end

		slot0._rewardItems = nil
	end
end

return slot0
