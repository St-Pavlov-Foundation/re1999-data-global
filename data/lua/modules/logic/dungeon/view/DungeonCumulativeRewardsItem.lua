module("modules.logic.dungeon.view.DungeonCumulativeRewardsItem", package.seeall)

slot0 = class("DungeonCumulativeRewardsItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "#go_rewards")
	slot0._goimportant = gohelper.findChild(slot0.viewGO, "#go_rewards/#go_important")
	slot0._simageimportantbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_rewards/#go_important/#simage_importantbg")
	slot0._txtpointname = gohelper.findChildText(slot0.viewGO, "#go_rewards/#go_important/#txt_pointname")
	slot0._gofinishline = gohelper.findChild(slot0.viewGO, "#go_rewards/#go_important/#txt_pointname/#go_finishline")
	slot0._gounfinishline = gohelper.findChild(slot0.viewGO, "#go_rewards/#go_important/#txt_pointname/#go_unfinishline")
	slot0._gorewardtemplate = gohelper.findChild(slot0.viewGO, "#go_rewards/#go_reward_template")
	slot0._imagestatus = gohelper.findChildImage(slot0.viewGO, "#go_rewards/#image_status")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.ctor(slot0, slot1)
	slot0._chapterId = slot1[1]
	slot0._pointRewardCfg = slot1[2]
	slot0._isRightDisplay = slot1[3]
	slot0.rewardId = slot0._pointRewardCfg.id
	slot0.curPointValue = slot0._pointRewardCfg.rewardPointNum
	slot0.prevPosX = slot1[4]
	slot0.curPosX = slot1[5]
	slot0.prevPointValue = slot1[6]
end

function slot0.createRewardUIs(slot0)
	slot0._rewarditems = {}

	for slot6 = 1, #string.split(slot0._pointRewardCfg.reward, "|") do
		slot7 = string.splitToNumber(slot2[slot6], "#")
		slot8 = slot0:getUserDataTb_()
		slot9 = gohelper.clone(slot0._gorewardtemplate, slot0._gorewards, "reward_" .. tostring(slot6))
		slot8.imagebg = gohelper.findChildImage(slot9, "image_bg")
		slot8.imagecircle = gohelper.findChildImage(slot9, "image_circle")
		slot8.simagereward = gohelper.findChildSingleImage(slot9, "simage_reward")
		slot8.txtrewardcount = gohelper.findChildText(slot9, "txt_rewardcount")
		slot8.txtpointvalue = gohelper.findChildText(slot9, "txt_pointvalue")
		slot8.imagereward = slot8.simagereward:GetComponent(gohelper.Type_Image)
		slot8.btn = gohelper.findChildClick(slot9, "simage_reward")
		slot8.goalreadygot = gohelper.findChild(slot9, "go_hasget")

		slot8.btn:AddClickListener(slot0.onClickItem, slot0, slot8)

		slot8.go = slot9
		slot8.rewardCfg = slot7
		slot8.itemCfg, slot8.iconPath = ItemModel.instance:getItemConfigAndIcon(slot7[1], slot7[2])

		gohelper.setActive(slot8.go, true)
		UISpriteSetMgr.instance:setUiFBSprite(slot8.imagebg, "bg_pinjidi_" .. slot8.itemCfg.rare)
		UISpriteSetMgr.instance:setUiFBSprite(slot8.imagecircle, "bg_pinjidi_lanse_" .. slot8.itemCfg.rare)
		table.insert(slot0._rewarditems, slot8)
	end
end

function slot0.refreshRewardItems(slot0, slot1)
	slot0._pointRewardInfo = DungeonMapModel.instance:getRewardPointInfo(slot0._chapterId)

	for slot5, slot6 in ipairs(slot0._rewarditems) do
		slot0:refreshRewardUIItem(slot6, slot0._pointRewardCfg, slot1)
	end
end

slot1 = Color.New(0.5, 0.5, 0.5, 1)
slot2 = Color.New(1, 1, 1, 1)
slot3 = Color.New(0.5, 0.5, 0.5, 1)
slot4 = Color.New(1, 1, 1, 1)
slot5 = Color.New(0.4, 0.3882353, 0.3843137, 1)
slot6 = Color.New(0.6745098, 0.3254902, 0.1254902, 1)

function slot0.refreshRewardUIItem(slot0, slot1, slot2, slot3)
	slot1.simagereward:LoadImage(slot1.iconPath)

	slot1.txtrewardcount.text = string.format("<size=25>%s</size>%s", luaLang("multiple"), tostring(slot1.rewardCfg[3]))
	slot1.txtpointvalue.text = slot2.rewardPointNum
	slot1.txtpointvalue.color = tabletool.indexOf(slot0._pointRewardInfo.hasGetPointRewardIds, slot2.id) and uv0 or uv1

	gohelper.setActive(slot1.goalreadygot, slot4)

	if slot3 then
		slot1.goalreadygot:GetComponent(typeof(UnityEngine.Animator)):Play("go_hasget_in")
	end

	if slot4 then
		if not slot3 then
			slot1.go:GetComponent(typeof(UnityEngine.Animator)):Play("dungeoncumulativerewardsitem_receiveenter")
		else
			slot5:Play("dungeoncumulativerewardsitem_received")
		end
	end
end

function slot0.onClickItem(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	MaterialTipController.instance:showMaterialInfo(slot1.rewardCfg[1], slot1.rewardCfg[2])
end

function slot0._editableInitView(slot0)
	slot0:createRewardUIs()
	slot0:refreshRewardItems()
	slot0:_refreshStatus()
	slot0._simageimportantbg:LoadImage(ResUrl.getDungeonIcon("bg_tishidiban"))
end

function slot0._refreshStatus(slot0)
	if slot0._pointRewardCfg.display > 0 then
		UISpriteSetMgr.instance:setUiFBSprite(slot0._imagestatus, "bg_xingjidian_1" .. (slot0.curPointValue <= slot0._pointRewardInfo.rewardPoint and "" or "_dis"), true)
	else
		UISpriteSetMgr.instance:setUiFBSprite(slot0._imagestatus, "bg_xingjidian" .. (slot1 and "" or "_dis"), true)
	end

	gohelper.setActive(slot0._goimportant, slot0._pointRewardCfg.display > 0)

	if slot0._pointRewardCfg.unlockChapter > 0 then
		slot0._txtpointname.text = string.format(luaLang("dungeonmapview_unlocktitle"), lua_chapter.configDict[slot0._pointRewardCfg.unlockChapter].name)

		gohelper.setActive(slot0._gofinishline, slot1)
		gohelper.setActive(slot0._gounfinishline, not slot1)
	else
		gohelper.setActive(slot0._txtpointname.gameObject, false)
	end

	gohelper.setActive(slot0._simageimportantbg.gameObject, not slot0._isRightDisplay)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._rewarditems) do
		slot5.btn:RemoveClickListener()
		slot5.simagereward:UnLoadImage()
	end

	slot0._simageimportantbg:UnLoadImage()
end

return slot0
