module("modules.logic.versionactivity1_5.peaceulu.view.PeaceUluProgressItem", package.seeall)

slot0 = class("PeaceUluProgressItem", MixScrollCell)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._txtnormal = gohelper.findChildText(slot0.viewGO, "normal/#txt_normal")
	slot0._txtfinished = gohelper.findChildText(slot0.viewGO, "finished/#txt_finished")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "#go_item")
	slot0._gorewardtemplate = gohelper.findChild(slot0._goitem, "#reward")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "normal")
	slot0._gofinished = gohelper.findChild(slot0.viewGO, "finished")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.onStart(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0._rewarditems) do
		slot5.simagereward:UnLoadImage()

		if slot5.btnclick then
			slot5.btnclick:RemoveClickListener()
		end
	end
end

function slot0.removeEventListeners(slot0)
end

function slot0.initMo(slot0, slot1, slot2)
	slot0.mo = slot2
	slot0.index = slot1
	slot0.targetNum = string.split(slot0.mo.needProgress, "#")[3]
	slot0._txtfinished.text = slot0.targetNum
	slot0._txtnormal.text = slot0.targetNum

	slot0:rewardItem()
end

function slot0.refreshProgress(slot0)
	slot1 = PeaceUluModel.instance:checkGetReward(slot0.mo.id)

	slot0:refreshRewardItems(slot1)
	gohelper.setActive(slot0._gonormal, not slot1)
	gohelper.setActive(slot0._gofinished, slot1)
end

function slot0.rewardItem(slot0)
	slot0._rewarditems = {}

	gohelper.setActive(slot0._gorewardtemplate, false)

	for slot6 = 1, #string.split(slot0.mo.bonus, "|") do
		slot7 = string.splitToNumber(slot2[slot6], "#")
		slot8 = slot0:getUserDataTb_()
		slot9 = gohelper.clone(slot0._gorewardtemplate, slot0._goitem, "reward_" .. tostring(slot6))
		slot8.imagebg = gohelper.findChildImage(slot9, "image_bg")
		slot8.imagecircle = gohelper.findChildImage(slot9, "image_circle")
		slot8.simagereward = gohelper.findChildSingleImage(slot9, "simage_reward")
		slot8.txtrewardcount = gohelper.findChildText(slot9, "txt_rewardcount")
		slot8.txtpointvalue = gohelper.findChildText(slot9, "txt_pointvalue")
		slot8.imagereward = slot8.simagereward:GetComponent(gohelper.Type_Image)
		slot8.goalreadygot = gohelper.findChild(slot9, "go_hasget")
		slot8.btnclick = gohelper.findChildButtonWithAudio(slot9, "btn_click")
		slot8.go = slot9
		slot8.rewardCfg = slot7
		slot8.itemCfg, slot8.iconPath = ItemModel.instance:getItemConfigAndIcon(slot7[1], slot7[2])

		gohelper.setActive(slot8.go, true)
		UISpriteSetMgr.instance:setUiFBSprite(slot8.imagebg, "bg_pinjidi_" .. slot8.itemCfg.rare)
		UISpriteSetMgr.instance:setUiFBSprite(slot8.imagecircle, "bg_pinjidi_lanse_" .. slot8.itemCfg.rare)
		table.insert(slot0._rewarditems, slot8)
	end
end

function slot0.onClickRewardItem(slot0, slot1)
	if slot1 then
		MaterialTipController.instance:showMaterialInfo(slot1[1], slot1[2])
	end
end

function slot0.refreshRewardItems(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._rewarditems) do
		slot0:refreshRewardUIItem(slot6, slot1)
	end
end

slot1 = Color.New(0.6941177, 0.6941177, 0.6941177, 1)
slot2 = Color.New(1, 1, 1, 1)
slot3 = Color.New(1, 1, 1, 0.5)
slot4 = Color.New(1, 1, 1, 1)
slot5 = Color.New(0.4235, 0.4235, 0.4235, 1)
slot6 = Color.New(0.9411, 0.9411, 0.9411, 1)

function slot0.refreshRewardUIItem(slot0, slot1, slot2)
	slot1.imagereward.color = slot2 and uv0 or uv1
	slot1.imagebg.color = slot2 and uv2 or uv3
	slot1.txtrewardcount.color = slot2 and uv4 or uv5

	slot1.simagereward:LoadImage(slot1.iconPath)

	slot1.txtrewardcount.text = "×" .. tostring(slot1.rewardCfg[3])

	slot1.btnclick:RemoveClickListener()
	slot1.btnclick:AddClickListener(slot0.onClickRewardItem, slot0, slot1.rewardCfg)
	gohelper.setActive(slot1.goalreadygot, slot2)

	if slot2 then
		slot1.go:GetComponent(typeof(UnityEngine.Animator)):Play("dungeoncumulativerewardsitem_received")
	end
end

return slot0
